Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FE901F731
	for <e@80x24.org>; Fri,  2 Aug 2019 02:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbfHBC1O (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 22:27:14 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:32908 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730457AbfHBC1N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 22:27:13 -0400
Received: by mail-pf1-f178.google.com with SMTP id g2so35167520pfq.0
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 19:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dZ4dh33vo7LmAVTud2Yr6Q7M8FP3a3wyCk3rNHHimYw=;
        b=X1cZpd4qfQ2sVI7ZHTokUt+BN8YpAkp/92oJk1oKmN2qWmqDns6aixkKH/rfs42fWM
         yYzFHcKyICfkeiqZyinnfHjT/gpr5HER7ZmgpFyd+nXyShPHw6VZ2a1IT8EKzldzcfDY
         C1QXV9BBNMxZpR50Sk8n031Ifejl4CV9HD8cu+Cd9vsb51BaEpky3DgWAc2Di0yiHs+L
         MSgSR45HFPj3ClC3Rpjb07xmkMLj21RQAf6gohX3jJPJtnTjVC3VjRPGCSKF7uoqdPKg
         SgErAfAiw0mCK6T1WZMYCMilgIpuHSpAzdJ3c9QWqcYAiYIk3dphs6ML//4ejObJHGmJ
         1bMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dZ4dh33vo7LmAVTud2Yr6Q7M8FP3a3wyCk3rNHHimYw=;
        b=gZ2+I9AnjNfB8mivqNeQhFEHaQJytyqE64nZYOW17m7miKycTarW0bWHGGbEFXpHAu
         xthRgTmHTaY3sCymNln9Hi5OtlUC5pEwwtvtpkkrmvXNE2pgbvkbq2jdKNczBfzR5YZp
         31/e4CxvvnAbN5f2KRbW0TI6LFiD5bJyU2K8ti2Y7NLI6T2AmKEm+s1fEoGdv/kkfHT7
         6imk1qIT2o1WYyKZ9Bfm2Gn8hB84UgeVlpt8G/nv6Zz9iR0akpzFOS84blsNnN0Rgf5p
         I2QJj9aHeQwg4t5JSnZikUv0zs6KeI4R1e/WyOwgckn+d/D/IfoQbAeTBa9nIYtXvyx4
         D1mg==
X-Gm-Message-State: APjAAAU8cWEc9FLj+kEm862+9d2GBOD9ZT6bSq4BRCUkntAZbjmkfFH9
        YJw4nWV9FObjQE4AYzSF2oU=
X-Google-Smtp-Source: APXvYqwU3g0Jm0WjQE8Gc82e6taScE3rtJG3xDhmv166EjzgAFGk/erOdHObI2t/J0ZvYiUxD9ai0g==
X-Received: by 2002:a17:90a:e38f:: with SMTP id b15mr1933928pjz.85.1564712831633;
        Thu, 01 Aug 2019 19:27:11 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id v13sm85190205pfe.105.2019.08.01.19.27.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 19:27:11 -0700 (PDT)
Date:   Thu, 1 Aug 2019 19:27:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com,
        Ariadne Conill <ariadne@dereferenced.org>
Subject: Re: Git for Windows v2.23.0-rc0, was Re: [ANNOUNCE] Git v2.23.0-rc0
Message-ID: <20190802022709.GB54514@google.com>
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet>
 <20190731231848.GC1933@sigill.intra.peff.net>
 <20190801002125.GA176307@google.com>
 <xmqqlfwcopn1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlfwcopn1.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> I suspect that you may have misread the "is interactive" bit in the
> original; that was used only to decide if we are going to warn.

Ah.  That was indeed confusing.  Anyway, it's nice to see the complexity
go away.

[...]
> +++ b/builtin/log.c
[...]
> @@ -214,12 +204,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>  	memset(&w, 0, sizeof(w));
>  	userformat_find_requirements(NULL, &w);
>  
> -	if (mailmap < 0) {
> -		if (session_is_interactive() && !rev->pretty_given)
> -			warning("%s\n", _(warn_unspecified_mailmap_msg));
> -
> +	if (mailmap < 0)
>  		mailmap = 0;

As Peff noticed, this should say "mailmap = 1" (which I see you've done
in "pu").  We can simplify further by removing the "-1" case --- we do
not need to distinguish between "on" and "unspecified" any more.

We'll also want to update the docs.  And as Todd suggests, we should
cover how to disable mailmap in tests.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---

diff --git i/Documentation/config/log.txt w/Documentation/config/log.txt
index 7798e10cb0..e9e1e397f3 100644
--- i/Documentation/config/log.txt
+++ w/Documentation/config/log.txt
@@ -41,4 +41,4 @@ log.showSignature::
 log.mailmap::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--use-mailmap`, otherwise
-	assume `--no-use-mailmap`. False by default.
+	assume `--no-use-mailmap`. True by default.
diff --git i/builtin/log.c w/builtin/log.c
index 02fa179077..44b10b3415 100644
--- i/builtin/log.c
+++ w/builtin/log.c
@@ -47,7 +47,7 @@ static int default_follow;
 static int default_show_signature;
 static int decoration_style;
 static int decoration_given;
-static int use_mailmap_config = -1;
+static int use_mailmap_config = 1;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
@@ -160,7 +160,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
 	struct userformat_want w;
-	int quiet = 0, source = 0, mailmap = 0;
+	int quiet = 0, source = 0, mailmap;
 	static struct line_opt_callback_data line_cb = {NULL, NULL, STRING_LIST_INIT_DUP};
 	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
 	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
@@ -204,9 +204,6 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	memset(&w, 0, sizeof(w));
 	userformat_find_requirements(NULL, &w);
 
-	if (mailmap < 0)
-		mailmap = 1;
-
 	if (!rev->show_notes_given && (!rev->pretty_given || w.notes))
 		rev->show_notes = 1;
 	if (rev->show_notes)
diff --git i/t/t4203-mailmap.sh w/t/t4203-mailmap.sh
index ede0c292af..918ada69eb 100755
--- i/t/t4203-mailmap.sh
+++ w/t/t4203-mailmap.sh
@@ -442,6 +442,34 @@ test_expect_success 'Log output with log.mailmap' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log.mailmap=false disables mailmap' '
+	cat >expect <<-\EOF &&
+	Author: CTO <cto@coompany.xx>
+	Author: claus <me@company.xx>
+	Author: santa <me@company.xx>
+	Author: nick2 <nick2@company.xx>
+	Author: nick2 <bugs@company.xx>
+	Author: nick1 <bugs@company.xx>
+	Author: A U Thor <author@example.com>
+	EOF
+	git -c log.mailmap=False log | grep Author > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--no-use-mailmap disables mailmap' '
+	cat >expect <<-\EOF &&
+	Author: CTO <cto@coompany.xx>
+	Author: claus <me@company.xx>
+	Author: santa <me@company.xx>
+	Author: nick2 <nick2@company.xx>
+	Author: nick2 <bugs@company.xx>
+	Author: nick1 <bugs@company.xx>
+	Author: A U Thor <author@example.com>
+	EOF
+	git log --no-use-mailmap | grep Author > actual &&
+	test_cmp expect actual
+'
+
 cat >expect <<\EOF
 Author: Santa Claus <santa.claus@northpole.xx>
 Author: Santa Claus <santa.claus@northpole.xx>
