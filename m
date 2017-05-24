Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 253C620281
	for <e@80x24.org>; Wed, 24 May 2017 04:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965953AbdEXEpl (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 00:45:41 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35743 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762012AbdEXEpe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 00:45:34 -0400
Received: by mail-pf0-f194.google.com with SMTP id u26so31552755pfd.2
        for <git@vger.kernel.org>; Tue, 23 May 2017 21:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bdt3QkEA4OanJkCWI40yNnz6yF4OBaZC8YjSUUOi9qM=;
        b=UYqA2yZPyDnwn1Y5pJcp1giUUf/ICFD+AgBw/4kWNXZJNPxTA4yqfZB/HF7Nkdwxdl
         IqpYerwrM/Zb8RJbIomrpJd0fO0KMWzyaRJRd1FYSlzVfp9mjNLS9jtPZxlXbmKLFzuJ
         WkHFRfQ2ZELaeZMFDVZlkQ4jHU2aRZ/lxFwnvGQcCSCTdGidSBJpJIa0wjRXNA3xbPKY
         hKE4zaL/1n6KiUWR7GlO/vONsqPHsZs0XC7jjhBl07mf/WzBDpz3fCIAJEo/NY8qggEP
         cxOVTp2hhCDp15uJ+elMkNBTyu430N0G/JaaBp4PThhJp5xBCq/AnaU05IZRa3xMyBmc
         ep8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bdt3QkEA4OanJkCWI40yNnz6yF4OBaZC8YjSUUOi9qM=;
        b=aBf1PXYbYBqmA4TEM0bf2JGoFXvgKMHj64ILyJB6l40dZGoeYI+10IH8BGS50zggBT
         gknZUgzEB0dqpylf28gx41+p6mbYNWj3miRe59eyeSZhh95AzFiV9zL7jg3RiMlmd/oI
         dD53B6mUvZMJ5u62/q5MtoXjpujQbnWHgJfvH9gzpxlx5P6c3Xra+WyyXdoXq2DEBkux
         4AMBD8ldM8gdlLo4zp0UNxjlUCV/utNVCJMaw2w54gBHkR2w+DRfOWSDvj14nXPLWR70
         H85nhF55wBvWdKmxyfKdNgdnlOzHkzJJKhoYt9qjckx7DjCJvLvYOqZb9O8fx6UhOcdy
         TD7A==
X-Gm-Message-State: AODbwcDO59xaT/mSUfO5yxYWnFNh6s2PIo1aDc2U3G+fMWt+6Dk8hvn9
        OY03iRQxvMRqcQ==
X-Received: by 10.98.155.154 with SMTP id e26mr36480460pfk.24.1495601134278;
        Tue, 23 May 2017 21:45:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:167:7063:293b:a24d])
        by smtp.gmail.com with ESMTPSA id b65sm4572528pfl.48.2017.05.23.21.45.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 21:45:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH v2 2/7] grep: skip pthreads overhead when using one thread
References: <20170523192453.14172-1-avarab@gmail.com>
        <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
        <20170523192453.14172-3-avarab@gmail.com>
Date:   Wed, 24 May 2017 13:45:32 +0900
In-Reply-To: <20170523192453.14172-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 23 May 2017 19:24:48 +0000")
Message-ID: <xmqqr2zehngz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Skip the administrative overhead of using pthreads when only using one
> thread. Instead take the non-threaded path which would be taken under
> NO_PTHREADS.
>
> The threading support was initially added in commit
> 5b594f457a ("Threaded grep", 2010-01-25) with a hardcoded compile-time
> number of 8 threads. Later the number of threads was made configurable
> in commit 89f09dd34e ("grep: add --threads=<num> option and
> grep.threads configuration", 2015-12-15).
>
> That change did not add any special handling for --threads=1. Now we
> take a slightly faster path by skipping thread handling entirely when
> 1 thread is requested.

OK, this is what Peff and you were discussing in the earlier round,
having the controller do the work himself, instead of sitting and
waiting for a sole worker to finish the work.  Looks good.

Thanks.

>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/grep.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 12e62fcbf3..bd008cb100 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1238,6 +1238,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  		num_threads = GREP_NUM_THREADS_DEFAULT;
>  	else if (num_threads < 0)
>  		die(_("invalid number of threads specified (%d)"), num_threads);
> +	if (num_threads == 1)
> +		num_threads = 0;
>  #else
>  	if (num_threads)
>  		warning(_("no threads support, ignoring --threads"));
