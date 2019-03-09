Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4420320248
	for <e@80x24.org>; Sat,  9 Mar 2019 15:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfCIPqV (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 10:46:21 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40580 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCIPqU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 10:46:20 -0500
Received: by mail-pg1-f193.google.com with SMTP id u9so543866pgo.7
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 07:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ue7XFhr4NKB+1WlIqs4G7eE5lYzhE3gp+PZYvMtbock=;
        b=olYGrrSLbvtmh/Ra3WB2IQyBkrtcKJb+jAtijp+E5JBYDoVbIamUpZTp7J+NhVXxrF
         A3JTsuShPTPoVzrmFTNCPub2F+uUnZT8UaWEqSMyRAIU1k+JOLD/nFHZnRnnQFHqu017
         EmRDeNUzw4LF3pk5ymLARH3jp/7w2HZfvWnB0xf85gXkbHF9xDtFFCE2Hf9ECiQ5vTvL
         P8JoFw93hHRUGhLvaS0v8qTprtFYhXdVCl+RDfEvlsTtckM3pH8eVBMa9oamSnaYcNiy
         OssSW52zG+lsLCvUDgK5mf1Th0CpLT3CpFqMkVZ0rY14Kn8qErzgPgeK0Ywy2fJMtux7
         im+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ue7XFhr4NKB+1WlIqs4G7eE5lYzhE3gp+PZYvMtbock=;
        b=CatdOwNOio1o1EyW64DpQ+36YtnzGd+pUXnmjojZk2uRDK+73BUYv6frvDdr8dAZqm
         VTz4zhiA19Uz2fLjs4CKsl2PZN8lJ0yLN66wrsnv/6Wl78BmadLIApkeWTF6iJ7cYwt5
         5TMhfbzcg2XGK5VbER/d1jxquYEXs3eRtlIm7bbdTowUgbKB9dthamwRm27A9K66I6O7
         5LF/wgIfeyfkTd93Pg2oa+6hOzQF3mH5TFHS/XprO+AxCPqXAdAEsTCDxbyMgfegprlA
         ijFXVmvZ0Hp9XIMg8zZdGOAjpKo7kXiJU0DulZjt7IKMjJ+J78ZBTzAlG6dL4PRfmZhz
         mLXQ==
X-Gm-Message-State: APjAAAUBVxV+ehiK9pYaery1suDzV1XvjhK/etWQ2bPpOMDXnvgte/LJ
        O55SP+IWz7Uw1q7ntqnaz2UIFi6F
X-Google-Smtp-Source: APXvYqzw0exzeI88t4JXsos2JxGqVMdt0gS5lmo0EvzIegplvLdswI6jkG5xRsDnM+ZP6dRQQdaoVg==
X-Received: by 2002:a62:564d:: with SMTP id k74mr24079661pfb.19.1552146379406;
        Sat, 09 Mar 2019 07:46:19 -0800 (PST)
Received: from localhost.localdomain (cloudream.m3.ntu.edu.tw. [140.112.244.5])
        by smtp.gmail.com with ESMTPSA id k22sm1504703pfi.90.2019.03.09.07.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Mar 2019 07:46:18 -0800 (PST)
From:   Jonathan Chang <ttjtftx@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Chang <ttjtftx@gmail.com>
Subject: [GSoC][PATCH] tests: avoid using pipes
Date:   Sat,  9 Mar 2019 23:45:55 +0800
Message-Id: <20190309154555.33407-1-ttjtftx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is my attempt for this year's GSoC microproject.

I copied the commit message of the commit[1] mentioned in the microproject
page[2]. Is this OK?

Here is a summary of what I did:
	- simple substitution as in c6f44e1da5[1]. 
	- besides simple substitution, I moved some git command out of command 
		substitution to improve readability, which was not possible with pipes, 
		while in these cases keeping them inside won't discard git's exit code.
	- use actual1 and actual2 in cases where actual is already in use.
	- use `sort -o actual actual` to avoid using actual1 and actual2.

[1] c6f44e1da5 ("t9813: avoid using pipes", 2017-01-04)
[2] https://git.github.io/SoC-2019-Microprojects/

---------------------->8-------------------
The exit code of the upstream in a pipe is ignored thus we should avoid
using it. By writing out the output of the git command to a file, we can
test the exit codes of both the commands.

Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
---
 t/t0000-basic.sh       | 28 ++++++++++++++--------------
 t/t0003-attributes.sh  | 13 ++++++++-----
 t/t0022-crlf-rename.sh |  6 +++---
 3 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index b6566003dd..adc9545973 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1118,27 +1118,25 @@ P=$(test_oid root)
 
 test_expect_success 'git commit-tree records the correct tree in a commit' '
 	commit0=$(echo NO | git commit-tree $P) &&
-	tree=$(git show --pretty=raw $commit0 |
-		 sed -n -e "s/^tree //p" -e "/^author /q") &&
+	git show --pretty=raw $commit0 >actual &&
+	tree=$(sed -n -e "s/^tree //p" -e "/^author /q" actual) &&
 	test "z$tree" = "z$P"
 '
 
 test_expect_success 'git commit-tree records the correct parent in a commit' '
 	commit1=$(echo NO | git commit-tree $P -p $commit0) &&
-	parent=$(git show --pretty=raw $commit1 |
-		sed -n -e "s/^parent //p" -e "/^author /q") &&
+	git show --pretty=raw $commit1 >actual &&
+	parent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual) &&
 	test "z$commit0" = "z$parent"
 '
 
 test_expect_success 'git commit-tree omits duplicated parent in a commit' '
 	commit2=$(echo NO | git commit-tree $P -p $commit0 -p $commit0) &&
-	     parent=$(git show --pretty=raw $commit2 |
-		sed -n -e "s/^parent //p" -e "/^author /q" |
-		sort -u) &&
+	git show --pretty=raw $commit2 >actual &&
+	parent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual | sort -u) &&
 	test "z$commit0" = "z$parent" &&
-	numparent=$(git show --pretty=raw $commit2 |
-		sed -n -e "s/^parent //p" -e "/^author /q" |
-		wc -l) &&
+	git show --pretty=raw $commit2 >actual &&
+	numparent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual | wc -l) &&
 	test $numparent = 1
 '
 
@@ -1147,7 +1145,8 @@ test_expect_success 'update-index D/F conflict' '
 	mv path2 path0 &&
 	mv tmp path2 &&
 	git update-index --add --replace path2 path0/file2 &&
-	numpath0=$(git ls-files path0 | wc -l) &&
+	git ls-files path0 >actual &&
+	numpath0=$(wc -l actual) &&
 	test $numpath0 = 1
 '
 
@@ -1162,12 +1161,13 @@ test_expect_success 'very long name in the index handled sanely' '
 	>path4 &&
 	git update-index --add path4 &&
 	(
-		git ls-files -s path4 |
-		sed -e "s/	.*/	/" |
+		git ls-files -s path4 >actual &&
+		sed -e "s/	.*/	/" actual |
 		tr -d "\012" &&
 		echo "$a"
 	) | git update-index --index-info &&
-	len=$(git ls-files "a*" | wc -c) &&
+	git ls-files "a*" >actual &&
+	len=$(wc -c actual) &&
 	test $len = 4098
 '
 
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 71e63d8b50..14274f1ced 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -203,15 +203,18 @@ test_expect_success 'attribute test: read paths from stdin' '
 test_expect_success 'attribute test: --all option' '
 	grep -v unspecified <expect-all | sort >specified-all &&
 	sed -e "s/:.*//" <expect-all | uniq >stdin-all &&
-	git check-attr --stdin --all <stdin-all | sort >actual &&
+	git check-attr --stdin --all <stdin-all >actual &&
+	sort -o actual actual &&
 	test_cmp specified-all actual
 '
 
 test_expect_success 'attribute test: --cached option' '
-	git check-attr --cached --stdin --all <stdin-all | sort >actual &&
+	git check-attr --cached --stdin --all <stdin-all >actual &&
+	sort -o actual actual &&
 	test_must_be_empty actual &&
 	git add .gitattributes a/.gitattributes a/b/.gitattributes &&
-	git check-attr --cached --stdin --all <stdin-all | sort >actual &&
+	git check-attr --cached --stdin --all <stdin-all >actual &&
+	sort -o actual actual &&
 	test_cmp specified-all actual
 '
 
@@ -301,8 +304,8 @@ test_expect_success 'bare repository: check that --cached honors index' '
 	(
 		cd bare.git &&
 		GIT_INDEX_FILE=../.git/index \
-		git check-attr --cached --stdin --all <../stdin-all |
-		sort >actual &&
+		git check-attr --cached --stdin --all <../stdin-all >actual &&
+		sort -o actual actual &&
 		test_cmp ../specified-all actual
 	)
 '
diff --git a/t/t0022-crlf-rename.sh b/t/t0022-crlf-rename.sh
index 7af3fbcc7b..b4772b72f7 100755
--- a/t/t0022-crlf-rename.sh
+++ b/t/t0022-crlf-rename.sh
@@ -23,10 +23,10 @@ test_expect_success setup '
 
 test_expect_success 'diff -M' '
 
-	git diff-tree -M -r --name-status HEAD^ HEAD |
-	sed -e "s/R[0-9]*/RNUM/" >actual &&
+	git diff-tree -M -r --name-status HEAD^ HEAD >actual1 &&
+	sed -e "s/R[0-9]*/RNUM/" actual1 >actual2 &&
 	echo "RNUM	sample	elpmas" >expect &&
-	test_cmp expect actual
+	test_cmp expect actual2
 
 '
 
-- 
2.21.0

