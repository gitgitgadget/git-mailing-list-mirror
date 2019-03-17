Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C652D20248
	for <e@80x24.org>; Sun, 17 Mar 2019 10:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfCQKQA (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 06:16:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37278 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfCQKQA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 06:16:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id q206so9382898pgq.4
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 03:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hQP3QMkX4oKr9kqTVesaIk2t8FOx174qRwSWSmPWHs0=;
        b=lBXaINhlVws5ychy2JhI3tJDDshbjrp1A4a3CamDVqKBpIqDsj8/2iGOuVOru2DD0r
         9MmhsfESstYm7sPh/pJfuNLMEsVBm6NR8pq6YS+gMPmrjkl4Y0KEhUGD79wU5CYrtmH3
         SYH1QlkiacL9YT/Z3wca7JF+j7oS55GTZESaVCqqPEH/s1yaXFKlrpZSC9CXkcmq43m9
         bZY3UEGxOQPzhHojy2mt2Aj2IFRFYtQF/1t2VIY5+hSHft+NkbOWdFyNvZ122d2yP1Bb
         SDrniH+FlA8VMIzYWTIoFDmspwDs14jS+U2sO7WbcApPXGDjRAig4NWRkH9TZUzTr2Zl
         nOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hQP3QMkX4oKr9kqTVesaIk2t8FOx174qRwSWSmPWHs0=;
        b=RE9cHw3DQGt72hr8nbARBYhbKwh267JVnTmW1A0vBC3mMAYW3aOSTpkQKgc4Emhe9Z
         182DUbTXs6PlCKMQb4g/NTdQRV4NrCXRXHeBTbNlJFwjpzFrLUFWP5GCx3SjGLvb6QXV
         cP2I0bvgYB9IDKL+BbFWZjUUEBisf0r2ZjS9+mwyOG5VCwm6dsB+8Y56fJMGaqDCRODM
         4JEE0Ws2JUfvter5NUw8Z/ADPGrbgEoXUOWBOvezrFBrLrPV48TaLI1JWHuq/j3gpD/G
         wqMHKNX6eGlKgsgS0oP3dciYliRAYXo1Vs3dgPdUUY7cFzujfkyTRQzf6hVJZWTcDur5
         OIWw==
X-Gm-Message-State: APjAAAUtOGCfuoIIG3mmgN9Kl/R/fHV+hXPQ1Pgl4c2MeRqIOAooiSP6
        bB9f2u/9ZYzLjSSPFwQ3hORN+r86
X-Google-Smtp-Source: APXvYqxmrsy0xA2QrZp+wFP8gFskwlPscqw/Dc4EeX2+AacCrpQqVEJPRXtXGuEpzXeOlw3Bxnm2Jw==
X-Received: by 2002:a17:902:bb0c:: with SMTP id l12mr14060149pls.108.1552817758964;
        Sun, 17 Mar 2019 03:15:58 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id k12sm9376619pfk.109.2019.03.17.03.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 03:15:58 -0700 (PDT)
Date:   Sun, 17 Mar 2019 03:15:56 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v8 02/11] t3507: cleanup space after redirection operators
Message-ID: <8bd03165e4703d6a791a617838a82fd0cb4f7e02.1552817044.git.liu.denton@gmail.com>
References: <cover.1552275703.git.liu.denton@gmail.com>
 <cover.1552817044.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1552817044.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3507-cherry-pick-conflict.sh | 34 ++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 0db166152a..74ff925526 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -88,7 +88,7 @@ test_expect_success 'cherry-pick --no-commit does not set CHERRY_PICK_HEAD' '
 
 test_expect_success 'cherry-pick w/dirty tree does not set CHERRY_PICK_HEAD' '
 	pristine_detach initial &&
-	echo foo > foo &&
+	echo foo >foo &&
 	test_must_fail git cherry-pick base &&
 	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
 '
@@ -96,7 +96,7 @@ test_expect_success 'cherry-pick w/dirty tree does not set CHERRY_PICK_HEAD' '
 test_expect_success \
 	'cherry-pick --strategy=resolve w/dirty tree does not set CHERRY_PICK_HEAD' '
 	pristine_detach initial &&
-	echo foo > foo &&
+	echo foo >foo &&
 	test_must_fail git cherry-pick --strategy=resolve base &&
 	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
 '
@@ -175,23 +175,23 @@ test_expect_success 'failed cherry-pick registers participants in index' '
 		git ls-files --stage foo &&
 		git checkout picked -- foo &&
 		git ls-files --stage foo
-	} > stages &&
+	} >stages &&
 	sed "
 		1 s/ 0	/ 1	/
 		2 s/ 0	/ 2	/
 		3 s/ 0	/ 3	/
-	" < stages > expected &&
+	" <stages >expected &&
 	git read-tree -u --reset HEAD &&
 
 	test_must_fail git cherry-pick picked &&
-	git ls-files --stage --unmerged > actual &&
+	git ls-files --stage --unmerged >actual &&
 
 	test_cmp expected actual
 '
 
 test_expect_success 'failed cherry-pick describes conflict in work tree' '
 	pristine_detach initial &&
-	cat <<-EOF > expected &&
+	cat <<-EOF >expected &&
 	<<<<<<< HEAD
 	a
 	=======
@@ -201,14 +201,14 @@ test_expect_success 'failed cherry-pick describes conflict in work tree' '
 
 	test_must_fail git cherry-pick picked &&
 
-	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
+	sed "s/[a-f0-9]*\.\.\./objid/" foo >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'diff3 -m style' '
 	pristine_detach initial &&
 	git config merge.conflictstyle diff3 &&
-	cat <<-EOF > expected &&
+	cat <<-EOF >expected &&
 	<<<<<<< HEAD
 	a
 	||||||| parent of objid picked
@@ -220,14 +220,14 @@ test_expect_success 'diff3 -m style' '
 
 	test_must_fail git cherry-pick picked &&
 
-	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
+	sed "s/[a-f0-9]*\.\.\./objid/" foo >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'revert also handles conflicts sanely' '
 	git config --unset merge.conflictstyle &&
 	pristine_detach initial &&
-	cat <<-EOF > expected &&
+	cat <<-EOF >expected &&
 	<<<<<<< HEAD
 	a
 	=======
@@ -241,24 +241,24 @@ test_expect_success 'revert also handles conflicts sanely' '
 		git ls-files --stage foo &&
 		git checkout base -- foo &&
 		git ls-files --stage foo
-	} > stages &&
+	} >stages &&
 	sed "
 		1 s/ 0	/ 1	/
 		2 s/ 0	/ 2	/
 		3 s/ 0	/ 3	/
-	" < stages > expected-stages &&
+	" <stages >expected-stages &&
 	git read-tree -u --reset HEAD &&
 
 	head=$(git rev-parse HEAD) &&
 	test_must_fail git revert picked &&
 	newhead=$(git rev-parse HEAD) &&
-	git ls-files --stage --unmerged > actual-stages &&
+	git ls-files --stage --unmerged >actual-stages &&
 
 	test "$head" = "$newhead" &&
 	test_must_fail git update-index --refresh -q &&
 	test_must_fail git diff-index --exit-code HEAD &&
 	test_cmp expected-stages actual-stages &&
-	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
+	sed "s/[a-f0-9]*\.\.\./objid/" foo >actual &&
 	test_cmp expected actual
 '
 
@@ -284,7 +284,7 @@ test_expect_success 'revert --no-commit sets REVERT_HEAD' '
 
 test_expect_success 'revert w/dirty tree does not set REVERT_HEAD' '
 	pristine_detach base &&
-	echo foo > foo &&
+	echo foo >foo &&
 	test_must_fail git revert base &&
 	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD &&
 	test_must_fail git rev-parse --verify REVERT_HEAD
@@ -319,7 +319,7 @@ test_expect_success 'failed commit does not clear REVERT_HEAD' '
 test_expect_success 'revert conflict, diff3 -m style' '
 	pristine_detach initial &&
 	git config merge.conflictstyle diff3 &&
-	cat <<-EOF > expected &&
+	cat <<-EOF >expected &&
 	<<<<<<< HEAD
 	a
 	||||||| objid picked
@@ -331,7 +331,7 @@ test_expect_success 'revert conflict, diff3 -m style' '
 
 	test_must_fail git revert picked &&
 
-	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
+	sed "s/[a-f0-9]*\.\.\./objid/" foo >actual &&
 	test_cmp expected actual
 '
 
-- 
2.21.0.512.g57bf1b23e1

