Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE2EC1FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 17:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763586AbdJQRj7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 13:39:59 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:54359 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763584AbdJQRj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 13:39:56 -0400
Received: by mail-io0-f196.google.com with SMTP id e89so3133461ioi.11
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 10:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UV1vFeOhHWYO3zMBoX1fw83Pe2nawel0gD548JjsUFE=;
        b=AypG7Xq/jzG9g7kWV+9v7FEF1QsNbmzSorW5Jz5F3RIlfDuhOEyfEFnRFVn5KWiSA0
         2J6bvHDJdaRcDn5kAqeJ0pMawvxxsqwT6AzPFchwfBllL3dw5FOYU+rV3XtoQvZ2x1gS
         HCFNDS3Su77mxSTuNzgw3WoQ/kc07K7/1cxnYWzG5oaOFysk51JFcHZSVFkp46g/Ani9
         GUa+lN6KviqiZm0P9qpUU9kVGigi0fPR+TusxGkpB1ACYeI2UoklIoF7qaSb+XHkRCQt
         CagrSH9KTselM6WhfRn3akNYIT3VJCpiW+8+paNEDioX8g6ia1gtWWOjTD5qgbhnq6dU
         75vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UV1vFeOhHWYO3zMBoX1fw83Pe2nawel0gD548JjsUFE=;
        b=uEE1+6xS83HcDg0AiuL8IAtZTMsnzKhwo7Uw1EXZS/0JF7E5bdEAWNLdkZ9rUOT3tr
         XMk7U8zjvC4Ns7mRy8I/j4N2gEe09SaolvxT/CTXbAFjfupHR31JAoONE8hxjCZGFiQg
         b3WoDf1hoEmz1FIu4SpmFyRzmsPIPahBAsEIvWH1K4imn65n/TgBQLox98uQPUBt+/in
         Rlsq8nG/nWAaN6QRNe/XrJE71n8TDXE00Wt24knb7ugiR5VrMHyGrFPoOWwyY1z2e0Nq
         kkqltxSwmkmPxjMASQvYgL12Jk2x0sl3GedpwiNpRqz0Yofqt/K7wkIJlFgAtYgCQV1i
         vzsg==
X-Gm-Message-State: AMCzsaWWnV0YWb2caftsuLy1LlvK/CipvKVSbzZUeDkrrpQiSMWJDpLr
        IgP8zmXIWyiz9frsFXV4I9o=
X-Google-Smtp-Source: ABhQp+SRymG4+a65ytBOVQ5hyZYgjK8NVroCVQQhu6jV6CWGjRkFLCQZ8isi5+6rZY47Xr761KU4bQ==
X-Received: by 10.107.201.204 with SMTP id z195mr16870809iof.16.1508261995845;
        Tue, 17 Oct 2017 10:39:55 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a31sm5448098itj.7.2017.10.17.10.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Oct 2017 10:39:54 -0700 (PDT)
Date:   Tue, 17 Oct 2017 10:39:20 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Thomas Rikl <trikl@online.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] git: add NO_INTERNAL_HELP flag for builtins
Message-ID: <20171017173920.hzsvftikaoi4y6zt@aiede.mtv.corp.google.com>
References: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
 <CAN0heSpPWWdWY4d1wCdRH8TjcmD3kAiSffL0-_9kJWkm5P2EkA@mail.gmail.com>
 <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de>
 <76c3e710-0655-7788-f6f4-af1e59d65edd@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76c3e710-0655-7788-f6f4-af1e59d65edd@web.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

René Scharfe wrote:

> Builtin commands have skipped repo setup when called with just a single
> option -h and thus shown their short help text even outside of
> repositories since 99caeed05d3 (Let 'git <command> -h' show usage
> without a git dir).
>
> Add the flag NO_INTERNAL_HELP for builtins to opt out of this special
> treatment and provide a list of commands that are exempt from the
> corresponding test in t0012.  That allows builtins to handle -h
> themselves.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  git.c           | 6 +++++-
>  t/t0012-help.sh | 9 ++++++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)

Makes sense.

[...]
> +++ b/git.c
[...]
> @@ -312,7 +313,10 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>  	const char *prefix;
>  
>  	prefix = NULL;
> -	help = argc == 2 && !strcmp(argv[1], "-h");
> +	if (p->option & NO_INTERNAL_HELP)
> +		help = 0;
> +	else
> +		help = argc == 2 && !strcmp(argv[1], "-h");

optional: this could be part of the same expression:

	help = !(p->option & NO_INTERNAL_HELP) && argc == 2 && ...;

[...]
> --- a/t/t0012-help.sh
> +++ b/t/t0012-help.sh
> @@ -53,12 +53,19 @@ test_expect_success 'generate builtin list' '
>  	git --list-builtins >builtins
>  '
>  
> +cat >no_internal_help <<EOF
> +EOF
> +
> +test_expect_success 'generate list of builtins with internal help' '
> +	grep -w -v -f no_internal_help <builtins >builtins_internal_help
> +'

Hm, I don't see any instances of "grep -f" in the testsuite.  Are
there portability pitfalls in it I don't know about?  It's in POSIX,
so it looks pretty safe.

I would have been tempted to use comm, which is already used in
t6500-gc.sh:

	comm -1 -3 no_internal_help builtins >builtins_internal_help

Other nits:

- preparatory 'cat' commands like the above tend to go inside
  test_expect_success these days

- test that set up for later tests get marked as 'setup' or 'set up'

With whatever subset of the changes below looks good squashed in,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

diff --git i/git.c w/git.c
index 9d1b8c4716..e4b340df7d 100644
--- i/git.c
+++ w/git.c
@@ -313,10 +313,8 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	const char *prefix;
 
 	prefix = NULL;
-	if (p->option & NO_INTERNAL_HELP)
-		help = 0;
-	else
-		help = argc == 2 && !strcmp(argv[1], "-h");
+	help = !(p->option & NO_INTERNAL_HELP) &&
+			argc == 2 && !strcmp(argv[1], "-h");
 	if (!help) {
 		if (p->option & RUN_SETUP)
 			prefix = setup_git_directory();
diff --git i/t/t0012-help.sh w/t/t0012-help.sh
index c5a748837c..73fdfd99ab 100755
--- i/t/t0012-help.sh
+++ w/t/t0012-help.sh
@@ -49,15 +49,11 @@ test_expect_success "--help does not work for guides" "
 	test_i18ncmp expect actual
 "
 
-test_expect_success 'generate builtin list' '
-	git --list-builtins >builtins
-'
-
-cat >no_internal_help <<EOF
-EOF
-
-test_expect_success 'generate list of builtins with internal help' '
-	grep -w -v -f no_internal_help <builtins >builtins_internal_help
+test_expect_success 'set up list of builtins with internal help' '
+	cat >no_internal_help <<-\EOF &&
+	EOF
+	git --list-builtins >builtins &&
+	comm -1 -3 no_internal_help builtins >builtins_internal_help
 '
 
 while read builtin
