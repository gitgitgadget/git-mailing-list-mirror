Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8014620248
	for <e@80x24.org>; Thu, 21 Mar 2019 06:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfCUGxp (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 02:53:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46753 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUGxo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 02:53:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id 9so3439326pfj.13
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 23:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zONT9wgeUtMRr2psstEvePElRUfzKGh9VjRi7CUmC5c=;
        b=r9FNyMlp1EaqOGF+SLgcL442+qQVzv86lui4hv4nQaRc1GXuDe4fbH/aAuCsK8eIqf
         zBTpxOlmGKHetz60dKKKSRJ034zP4QHcrG8hDYCYruygoAwvboDYWNSjdmyMs/uNU5Kt
         JplfXjqmIhHn8ToZClnIt77ikBuQNpp+VPW1ZQZUJpepkxPYnjFXl868k+iwocf6aVsn
         iH0yYsvXlK3wxHxk7ugOcHwcMOqCaHAZXyDDkxjkoks5quzut7zuSDn2Q+KZSKyPkd2/
         pOJi673VML+YEnZGBF+3QiBs5n0Z9iIvFgx+dg+HtAH3puq7JkUaClHGXTP8uABXAtvs
         rqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zONT9wgeUtMRr2psstEvePElRUfzKGh9VjRi7CUmC5c=;
        b=nkjeQR/BVwfkXMnNUHXv5jGb++MlF1fwgvlUMsfc3/wIoPdAjrGUv4t7XpHlPXaBbU
         8s0eXYYiotSPqq2wD56007e+Mt5pIjqu8Agbee0he9EcMcOH3YsSpRGt1tYzXqF2/7vZ
         jK6cPvpF90YI7HLuHY37h56T72QRFMHQTZSvTI/7fPQHhEoBHJkYpwAUTnGxZYcgaEhl
         dxLoQ7x3/phybNJH05WpLtYka8BBw1NVVh7iehrKgU9aPk6VTb811rG4HsvGScE+ts3A
         YU+npZtfceiFROTsz7sYwxbmoBeRmHq+nD+SgNULkY1Np7ROtMGvn/jvKHZsu9lRcwyD
         BFUQ==
X-Gm-Message-State: APjAAAW1amYsKZ8BNyjK4WfAGrsHjPRnOb7VXhoO9Rqi+MYVLSv49mRQ
        T0h9BKZ5j8kC72xnMPuXOp2CmJ8OXns=
X-Google-Smtp-Source: APXvYqwDrv2cMhIaZ8ZRNwYrr+sGLTZMJBdIiUCkuJi4mbeI/vEmVg9ADmrtmsJcDe4HrUFXUGlKEA==
X-Received: by 2002:a62:be08:: with SMTP id l8mr1850354pff.162.1553151223134;
        Wed, 20 Mar 2019 23:53:43 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id a13sm4277847pgw.91.2019.03.20.23.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 23:53:42 -0700 (PDT)
Date:   Wed, 20 Mar 2019 23:53:40 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v9 02/11] t3507: clean up style
Message-ID: <7d8d39b93002d1416eaf730f3e8262360c925c42.1553150827.git.liu.denton@gmail.com>
References: <cover.1552817044.git.liu.denton@gmail.com>
 <cover.1553150827.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1553150827.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove space after redirection operators for style. Also, remove a git
command which was upstream of a pipe. Finally, let grep and sed open
their own input instead of letting the shell redirect the input.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3507-cherry-pick-conflict.sh | 42 ++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 0db166152a..777fb23d18 100755
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
+	" stages >expected &&
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
+	" stages >expected-stages &&
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
 
@@ -345,7 +345,7 @@ test_expect_success 'commit after failed cherry-pick does not add duplicated -s'
 	pristine_detach initial &&
 	test_must_fail git cherry-pick -s picked-signed &&
 	git commit -a -s &&
-	test $(git show -s |grep -c "Signed-off-by") = 1
+	test $(git show -s >tmp && grep -c "Signed-off-by" tmp && rm tmp) = 1
 '
 
 test_expect_success 'commit after failed cherry-pick adds -s at the right place' '
@@ -359,7 +359,7 @@ test_expect_success 'commit after failed cherry-pick adds -s at the right place'
 	Signed-off-by: C O Mitter <committer@example.com>
 	# Conflicts:
 	EOF
-	grep -e "^# Conflicts:" -e '^Signed-off-by' <.git/COMMIT_EDITMSG >actual &&
+	grep -e "^# Conflicts:" -e '^Signed-off-by' .git/COMMIT_EDITMSG >actual &&
 	test_cmp expect actual &&
 
 	cat <<-\EOF >expected &&
@@ -378,7 +378,7 @@ test_expect_success 'commit --amend -s places the sign-off at the right place' '
 
 	# emulate old-style conflicts block
 	mv .git/MERGE_MSG .git/MERGE_MSG+ &&
-	sed -e "/^# Conflicts:/,\$s/^# *//" <.git/MERGE_MSG+ >.git/MERGE_MSG &&
+	sed -e "/^# Conflicts:/,\$s/^# *//" .git/MERGE_MSG+ >.git/MERGE_MSG &&
 
 	git commit -a &&
 	git commit --amend -s &&
@@ -388,7 +388,7 @@ test_expect_success 'commit --amend -s places the sign-off at the right place' '
 	Signed-off-by: C O Mitter <committer@example.com>
 	Conflicts:
 	EOF
-	grep -e "^Conflicts:" -e '^Signed-off-by' <.git/COMMIT_EDITMSG >actual &&
+	grep -e "^Conflicts:" -e '^Signed-off-by' .git/COMMIT_EDITMSG >actual &&
 	test_cmp expect actual
 '
 
-- 
2.21.0.512.g57bf1b23e1

