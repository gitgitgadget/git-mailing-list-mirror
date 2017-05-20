Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CD1A201A7
	for <e@80x24.org>; Sat, 20 May 2017 23:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755306AbdETXuf (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 19:50:35 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35109 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753121AbdETXue (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 19:50:34 -0400
Received: by mail-pf0-f193.google.com with SMTP id u26so13340991pfd.2
        for <git@vger.kernel.org>; Sat, 20 May 2017 16:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=z+fnDl8xiV2iI/LMLY2jpCzLJvMj/5VXDnEliSz8oQs=;
        b=qz5+yXC85jE8hVOZAbLcnmRkvBCUnROiRYPLiWzDcCoR6GCK2OvmPA5idQTEtKtrcs
         hInGpRfyiiTMKzbmhxqlSiBkeoquECcuBi17wbvm4ChSF2nm93CD26AljC4OIGfmqn27
         /8ViAvF1M8HjupPRUEP71mFEpoYRkeTk5i6BAKNK310gvxdtH67it8gxa4gtxBBOWnlC
         QvKQbXJKl8Y+JT3ubaWmpR4Ls4R1aiVz3Sz73hbw8kPqKseQiBTY7aPxhNqxbLCtSkxh
         V7mcoAYp7931aa099IPHOtA8zHE+ZJ73PZ9Ck/Udhl9Or0RJy+JaGsfMZKsjLcFvoY+P
         NDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=z+fnDl8xiV2iI/LMLY2jpCzLJvMj/5VXDnEliSz8oQs=;
        b=Xw+ASoOUmasabmwDZGn+THh9CIRuZuI+atbGXsHKVPfPLXy4VHLvPshOy65Vr3JjwH
         P3lrCGTKexR1EuoYfHqCWhafSiusXAWp7U31ElniGqOIBlFVfWZIH08Vd197lE6mt8IA
         OnctGJ269m3QklA3bG85ckhbr4327AJP0uMOYeDBhUBBO5xAcA5/4GdzjZpoL80Q/MEU
         WfYucZ8U28gz/xEI+5nymPIpPARXG2f4wKz/ly/UWc18AKc+8ASJEzcRVvY3LbF+JSwf
         PHz621GfZqZpedaU3UJFlDSCfzJBQ0gPZYUyH+7BT8xzFb8ZcaaPiO5Kz74g8B5Y5gEi
         xjlw==
X-Gm-Message-State: AODbwcBNL7doJs9cpz8tXxZXgm1C5YGFN+cemLhJKiNmAUh/yTmvWzyZ
        Md6Fq5XcG05wqL6C7ug=
X-Received: by 10.84.215.197 with SMTP id g5mr19815711plj.131.1495324233769;
        Sat, 20 May 2017 16:50:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a59e:fcd8:9df2:4b0f])
        by smtp.gmail.com with ESMTPSA id g23sm19331445pfb.54.2017.05.20.16.50.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 20 May 2017 16:50:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v3 05/30] log: make --regexp-ignore-case work with --perl-regexp
References: <20170520214233.7183-1-avarab@gmail.com>
        <20170520214233.7183-6-avarab@gmail.com>
Date:   Sun, 21 May 2017 08:50:32 +0900
Message-ID: <xmqqlgprqe9j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Make the --regexp-ignore-case option work with --perl-regexp. This
> never worked, and there was no test for this. Fix the bug and add a
> test.
>
> When PCRE support was added in commit 63e7e9d8b6 ("git-grep: Learn
> PCRE", 2011-05-09) compile_pcre_regexp() would only check
> opt->ignore_case, but when the --perl-regexp option was added in
> commit 727b6fc3ed ("log --grep: accept --basic-regexp and
> --perl-regexp", 2012-10-03) the code didn't set the opt->ignore_case.
>
> Change the test suite to test for -i and --invert-regexp with
> basic/extended/perl patterns in addition to fixed, which was the only
> patternType that was tested for before in combination with those
> options.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  revision.c     |  1 +
>  t/t4202-log.sh | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 56 insertions(+), 5 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 8a8c1789c7..4883cdd2d0 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1991,6 +1991,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  	} else if (!strcmp(arg, "--extended-regexp") || !strcmp(arg, "-E")) {
>  		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_ERE;
>  	} else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-i")) {
> +		revs->grep_filter.ignore_case = 1;
>  		revs->grep_filter.regflags |= REG_ICASE;
>  		DIFF_OPT_SET(&revs->diffopt, PICKAXE_IGNORE_CASE);
>  	} else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {

Looks good.

I however wonder if it is a better approach in the longer term to
treat the .ignore_case field just like .extended_regexp_option
field, i.e. not committing immediately to .regflags but commit it
after config and command line parsing is done, just like we make the
"BRE? ERE?" decision in grep_commit_pattern_type().

Thanks.
