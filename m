Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 888CA20248
	for <e@80x24.org>; Tue, 19 Mar 2019 23:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfCSXSf (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 19:18:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39188 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfCSXSb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 19:18:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id t124so18150320wma.4
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 16:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jL+aE75tbgp2mS0xNX0zhH5pwCJ+hbPMQpFb0tXuDa4=;
        b=J2Zamhb471XGI/GWjkI12zjS3oQ9t6Ou/SEXhYd3p18tvndfwpRq2dARDFcyKNfOvV
         Ub2P7b3JqLM+eY271/QdTPJnzzIFWhoC4sg17ZrURNIodQJ62S1Wrm9uLgLrdG3Hm6/X
         a6+ph/HbEMU6IN5Gziag4QFdcvf3Lq5Xq/hE3hryV0cS/GK18m6PCVtGRfqNRJ53VVZz
         X1/OGK0lkcsq5JUtmKnITLST5WHFlaopD+9IjmTtdT08p46oHwF340H+x6iwfJoDB05T
         ZhV1mjtCMqYvtlTPQE/aIGm/gWr9edqykLVHppYVgKhLtUSW+f9zPPUOEJt9iRdPTp+a
         T/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jL+aE75tbgp2mS0xNX0zhH5pwCJ+hbPMQpFb0tXuDa4=;
        b=TZkgaus8o9QdbXgKAxksQRLYwPWWjyyLx5mnMID25XeB5Fl/LOpCR9DevRsUtEvG8I
         O5K2MzKBTnbql96bWSZd1vd72yEwbiGdgPeohpIbMLxEEK58ix0fZw88GeiSrpd7p5Hi
         ypPGhws4roxtiLOu66GvB7iSxUobwNU3HDqmtxn2WoHLwbj/iI96nIbg5Nawdu74Z2cz
         0ywagAEbJX5Mt2ilqqPfLPjb6YgcI6NiGcut5KRmuHopxaupuwsSXunA4CsbzEOxHwW7
         CW4EcFu+Q/JJqzdF0is/t49aPwoc9HF96rj1MMcqchlhopp3nyUrO+Svx+09TF2j/ORI
         K9+Q==
X-Gm-Message-State: APjAAAVoNtHiEDtndEyoIIk0TEwQHYMDrVzB5FEU0vVEJLJMvsUHCkaH
        wjPe42BwXkLmdOkP0ismXFw=
X-Google-Smtp-Source: APXvYqxkDzRX8npWUlj08e9nevbNAnZq6aZsopgalywQmqT2T5QIKXjqSTYFo8GQSDTC9GNzpI/D0g==
X-Received: by 2002:a7b:c111:: with SMTP id w17mr5833089wmi.6.1553037509475;
        Tue, 19 Mar 2019 16:18:29 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id r4sm167153wrw.79.2019.03.19.16.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 16:18:27 -0700 (PDT)
Date:   Tue, 19 Mar 2019 23:18:26 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [REGRESSION ps/stash-in-c] git stash show -v
Message-ID: <20190319231826.GB32487@hank.intra.tgummerer.com>
References: <20190319190503.GA10066@dev-l>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319190503.GA10066@dev-l>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/19, Denton Liu wrote:
> Hi all,
> 
> I've been using jch's branch and I discovered a regression in
> ps/stash-in-c.
> 
> Here's a test-case on git.git:
> 
> 	echo '/**/' >>abspath.c
> 	git stash
> 	git stash show -v
> 	# I am expecting the diff to show up here
> 
> I am expecting the diff to show up but in reality, I get no output.
> However, if I compile the latest master, the diff does show up.
> 
> Note that I can get the patch to show up using "git stash show -p" so
> it's not really a showstopper. However, my understanding is that this
> was supposed to be a one-to-one (bug included!) port.

Yes, I think this is indeed a regression, even if it worked more or
less accidentally.  '-v' would just be passed through to 'git diff'
which wouldn't do anything with it.  It would show the patch because
that's the default behaviour of 'git diff'.

From a quick search I couldn't find where 'git diff' actually parses
the '-v' argument, but I wonder if we should actually disallow it, in
case we want to use it for something else in the future?  It's not
documented anywhere in the docs either.

Anyway a patch to fix this is below, as we should have some
deprecation plan if we wanted to get rid of the '-v', and not just
silently change the behaviour.

--- >8 ---
Subject: [PATCH] stash: setup default diff output format if necessary

In the scripted 'git stash show' when no arguments are passed, we just
pass '--stat' to 'git diff'.  When any argument is passed to 'stash
show', we no longer pass '--stat' to 'git diff', and pass whatever
flags are passed directly through to 'git diff'.

By default 'git diff' shows the patch output.  So when we a user uses
'git stash show -v', they would be shown the diff, because that's the
default behaviour of 'git diff', but not actually directly triggered
by passing the '-v'.

In the C version of 'git stash show', we try to emulate that
behaviour using the internal diff API.  However we forgot to set up
the default output format, in case it wasn't set by any of the flags
that were passed through.  So 'git stash show -v' in the builtin
version of stash would be completely silent, while it would show the
diff before.

Fix this by setting up the default output format for 'git diff'.

Reported-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/stash.c  |  4 ++++
 t/t3903-stash.sh | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/builtin/stash.c b/builtin/stash.c
index 51df092633..012662ce68 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -761,6 +761,10 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 		free_stash_info(&info);
 		usage_with_options(git_stash_show_usage, options);
 	}
+	if (!rev.diffopt.output_format) {
+		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
+		diff_setup_done(&rev.diffopt);
+	}
 
 	rev.diffopt.flags.recursive = 1;
 	setup_diff_pager(&rev.diffopt);
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 97cc71fbaf..e0a50ab267 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -612,6 +612,24 @@ test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
 	test_cmp expected actual
 '
 
+test_expect_success 'stash show -v shows diff' '
+	git reset --hard &&
+	echo foo >>file &&
+	STASH_ID=$(git stash create) &&
+	git reset --hard &&
+	cat >expected <<-EOF &&
+	diff --git a/file b/file
+	index 7601807..71b52c4 100644
+	--- a/file
+	+++ b/file
+	@@ -1 +1,2 @@
+	 baz
+	+foo
+	EOF
+	git stash show -v ${STASH_ID} >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'drop: fail early if specified stash is not a stash ref' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD && git stash clear" &&
-- 
2.21.0.157.g0e94f7aa73.dirty

