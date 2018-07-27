Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 005211F597
	for <e@80x24.org>; Fri, 27 Jul 2018 19:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389210AbeG0VEc (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 17:04:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56148 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389064AbeG0VEc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 17:04:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so6367520wmc.5
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 12:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=IWvknlVW5eexCORpZNEU5mAOkxnSJUqehkwyjBSoshM=;
        b=GGYAI9TRm48q+UFV32f3UljmtN4LT7MOBlGdgMajLP/Xi33nWBZrZHenG/qhGTfm7x
         uEkEDZggpfgDwmJvddlRVVq63wErHVUQ7COZZS9u5YYzRWzZAoW31LUAy4GlbDqrnUuS
         ++HNLrWn6WZ7pfb1aZBPccfAHhQdzwtZLSjnBbDcnt8YrHh8HwLsi9N58sNOWkNDAT9v
         +CGbHmhYUxQ37dnt77c0O/tiUtVbYQMnaMjNzNrR2d0n4fuVsxF4TVKQSF7f3AsZycqX
         9PJLld3HLIMZuFVYAzcLqk2wi9+EyHNg1ma18J6F7w8TsrtnIUo7IyVBuGbpDWK4IJrx
         IxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=IWvknlVW5eexCORpZNEU5mAOkxnSJUqehkwyjBSoshM=;
        b=ehSoDs9sTJEKD8dhrL1AuUF2vsMa+8UgmTsLRAAgKsTMJmAOcdXfsu4prWHAY35Otl
         nEXc8IlfgAhVvfwvRcywJSI0ZfnKv6pe6QOJmfdBNcz44na3KL/OjQxXp+ozzf3kc0BL
         MNrKJ4Sb99tPm1FjzCeLE2SEcP5JVVq46zT4n34ixREwB3UYjfvGKx8UvIzMbecfGgKn
         qetaCiVwEVFzKh+ccC/zriJQ4qmsQUV8FgjqywEUBtdQ8X2j14lqKkCa01mcAb+wti95
         62FnWykEz1w+3nVdA45pucyp1tnsf+G98AGkhnytvFq715onxrlbonxIYc0tQgaDHFsR
         rNbg==
X-Gm-Message-State: AOUpUlFKPcrQCc0mPao/7gnXlRF3N2RfLukTF8ncFChKLCIoPN69dI/U
        iCgw2FrS1VCFl0NZVlgrpXY=
X-Google-Smtp-Source: AAOMgpeU1VR9HUoFJk5mFCXQGUm5LdDiOzKn5dpuVLGho8Z5RoX6HOURIyKGpf/QGWu2zAlBiSSx9Q==
X-Received: by 2002:a1c:9a15:: with SMTP id c21-v6mr5773269wme.112.1532720469637;
        Fri, 27 Jul 2018 12:41:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q188-v6sm8296272wmd.36.2018.07.27.12.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 12:41:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 04/10] config doc: elaborate on what transfer.fsckObjects does
References: <20180525192811.25680-1-avarab@gmail.com>
        <20180727143720.14948-5-avarab@gmail.com>
Date:   Fri, 27 Jul 2018 12:41:08 -0700
In-Reply-To: <20180727143720.14948-5-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 27 Jul 2018 14:37:14 +0000")
Message-ID: <xmqqin50mppn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> The existing documentation led the user to believe that all we were
> doing were basic reachability sanity checks, but that hasn't been true
> for a very long time. Update the description to match reality, and
> note the caveat that there's a quarantine for accepting pushes, but
> not for fetching.
>
> Also mention that the fsck checks for security issues, which was my
> initial motivation for writing this fetch.fsck.* series.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Documentation/config.txt | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 8d08250a5b..291b4f3c57 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -3397,8 +3397,17 @@ transfer.fsckObjects::
>  	Defaults to false.
>  +
>  When set, the fetch or receive will abort in the case of a malformed
> ...
> +On the receiving side, failing fsckObjects will make those objects
> +unreachable, see "QUARANTINE ENVIRONMENT" in
> +linkgit:git-receive-pack[1]. On the fetch side, malformed objects will
> +instead be left unreferenced in the repository.

"On the receiving side" would contrast better if the counterpart
were "On the fetching side", no?  

It may be clear to everybody who updates this document and reviews
such updates that "receive" is what happens on the other side when
you "push", but I think it is helpful to new readers if there were a
hint that indicates the linkage nearby (if merely as a reminder).

	When set, the fetch or receive (i.e. the other side that
	accepts your "push") will abort in the case of ...

