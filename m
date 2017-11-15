Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9BEE202AF
	for <e@80x24.org>; Wed, 15 Nov 2017 00:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756350AbdKOAbE (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 19:31:04 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:56744 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755169AbdKOAau (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 19:30:50 -0500
Received: by mail-it0-f65.google.com with SMTP id r127so15778042itb.5
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 16:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=i6vf2mzObD+njLKaqwn59P7WyOLc5QizwDU2uYBmUo0=;
        b=qiBd9vHC20PThF3GgIpk3IND2MYJfVetu44JUn2rYVJWsHyFTz3GmLX6XzU6rTrhBW
         1zvnJDoHSLfrjVG8bFInY2+xhRKCGMt0ItO47Xq4/uIexUqsdZxciBARboSUoN+CsbiE
         leHfBKAWGOZAlL1NYozbts2HaEB48acR7pGOhO5oo7F/wDSOFyndcYsnsdXT8UewwTgz
         9Vld+lBEuCuA1n4xF9zrPx0cA5b6X8k1wbB5QQHlXbMLIJy3WkcCJkqL3oTVbELPHLJD
         Ea7fG5sQI3SYyNCJRKZHQ1qItrqYM5b5Ha5URpKx23QjNntPn9tFJK+FJ6cMaQld2MMk
         2jFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i6vf2mzObD+njLKaqwn59P7WyOLc5QizwDU2uYBmUo0=;
        b=EchlO9140IDUiqNpXHEWtxu2cLTAYCARUEdaup9YExR/lRGd+Wmo+OAY/4/zEe37jm
         TbWnq1b5VFH8dU6sxxWwRyrn7h8mONRDT1ZDAWVvOSTurnZCnFKEHjO4KbPbWZel2M2S
         nvzmA29UAk0gsxirmBJBzI0+tS/GqyfbGwDuqGbLZTKORmfx1srBZp0VcMl+xdxj1zW4
         wvNTcJ5mQSg5qtZ+ts8SZ+Fv9TAI8pnMzYdphLWV9u0SAK9n/1WrKtH3eVbWWOYOX2Wa
         WyOkPyhfoq14bq2sOCNdPdtYZIkK7E+0jzwRRJ8SW0T0oK6b2df+IZQHACuMTdSIxZZe
         c80g==
X-Gm-Message-State: AJaThX4jv4mPnY4lptFmDi0B+XMnQDHYDysg2rXtpjw7cE4n7jBvJBGR
        AQARXlPDqTAQidk4R70XteytzcqknsY=
X-Google-Smtp-Source: AGs4zMb3ApmNcvfQGG69WmCtaqvTCL41U1NCoafjSUnAF55omWHd6LfaLfolfG3+s04+/maMYb15+Q==
X-Received: by 10.36.74.135 with SMTP id k129mr17788186itb.147.1510705849389;
        Tue, 14 Nov 2017 16:30:49 -0800 (PST)
Received: from localhost ([2620:0:100e:422:c9fb:9110:c737:8943])
        by smtp.gmail.com with ESMTPSA id p203sm4819646itg.14.2017.11.14.16.30.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Nov 2017 16:30:48 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 0/7] describe a blob
Date:   Tue, 14 Nov 2017 16:30:36 -0800
Message-Id: <20171115003043.24080-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* omitted the check for options, none of them made sense.
* use of --reverse
* an additional test asked for by Jonathan

previous discussion
https://public-inbox.org/git/20171102194148.2124-1-sbeller@google.com/
interdiff to current queued patches below.

Thanks,
Stefan

Stefan Beller (7):
  t6120: fix typo in test name
  list-objects.c: factor out traverse_trees_and_blobs
  revision.h: introduce blob/tree walking in order of the commits
  builtin/describe.c: rename `oid` to avoid variable shadowing
  builtin/describe.c: print debug statements earlier
  builtin/describe.c: factor out describe_commit
  builtin/describe.c: describe a blob

 Documentation/git-describe.txt     |  13 +++-
 Documentation/rev-list-options.txt |   5 ++
 builtin/describe.c                 | 126 ++++++++++++++++++++++++++++---------
 list-objects.c                     |  52 +++++++++------
 revision.c                         |   2 +
 revision.h                         |   3 +-
 t/t6100-rev-list-in-order.sh       |  77 +++++++++++++++++++++++
 t/t6120-describe.sh                |  21 ++++++-
 8 files changed, 249 insertions(+), 50 deletions(-)
 create mode 100755 t/t6100-rev-list-in-order.sh

-- 
2.15.0.128.gcadd42da22

diff --git c/builtin/describe.c w/builtin/describe.c
index acfd853a30..a2a5fdc48d 100644
--- c/builtin/describe.c
+++ w/builtin/describe.c
@@ -473,6 +473,7 @@ static void describe_blob(struct object_id oid, struct strbuf *dst)
 		"--single-worktree",
 		"--objects",
 		"--in-commit-order",
+		"--reverse",
 		NULL);
 
 	init_revisions(&revs, NULL);
@@ -501,13 +502,9 @@ static void describe(const char *arg, int last_one)
 
 	if (cmit)
 		describe_commit(&oid, &sb);
-	else if (lookup_blob(&oid)) {
-		if (all || tags || longformat || first_parent ||
-		    patterns.nr || exclude_patterns.nr ||
-		    always || dirty || broken)
-			die(_("options not available for describing blobs"));
+	else if (lookup_blob(&oid))
 		describe_blob(oid, &sb);
-	} else
+	else
 		die(_("%s is neither a commit nor blob"), arg);
 
 	puts(sb.buf);
diff --git c/t/t6100-rev-list-in-order.sh w/t/t6100-rev-list-in-order.sh
index d4d539b0da..b2bb0a7f61 100755
--- c/t/t6100-rev-list-in-order.sh
+++ w/t/t6100-rev-list-in-order.sh
@@ -4,7 +4,7 @@ test_description='rev-list testing in-commit-order'
 
 . ./test-lib.sh
 
-test_expect_success 'rev-list --in-commit-order' '
+test_expect_success 'setup a commit history with trees, blobs' '
 	for x in one two three four
 	do
 		echo $x >$x &&
@@ -17,7 +17,10 @@ test_expect_success 'rev-list --in-commit-order' '
 		git rm $x &&
 		git commit -m "remove $x" ||
 		return 1
-	done &&
+	done
+'
+
+test_expect_success 'rev-list --in-commit-order' '
 	git rev-list --in-commit-order --objects HEAD >actual.raw &&
 	cut -c 1-40 >actual <actual.raw &&
 
@@ -44,4 +47,31 @@ test_expect_success 'rev-list --in-commit-order' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rev-list lists blobs and trees after commits' '
+	git rev-list --objects HEAD >actual.raw &&
+	cut -c 1-40 >actual <actual.raw &&
+
+	git cat-file --batch-check="%(objectname)" >expect.raw <<-\EOF &&
+		HEAD^{commit}
+		HEAD~1^{commit}
+		HEAD~2^{commit}
+		HEAD~3^{commit}
+		HEAD~4^{commit}
+		HEAD~5^{commit}
+		HEAD^{tree}
+		HEAD^{tree}:one
+		HEAD^{tree}:two
+		HEAD~1^{tree}
+		HEAD~1^{tree}:three
+		HEAD~2^{tree}
+		HEAD~2^{tree}:four
+		# HEAD~3^{tree} skipped, same as HEAD~1^{tree}
+		# HEAD~4^{tree} skipped, same as HEAD^{tree}
+		HEAD~5^{tree}
+	EOF
+	grep -v "#" >expect <expect.raw &&
+
+	test_cmp expect actual
+'
+
 test_done
diff --git c/t/t6120-describe.sh w/t/t6120-describe.sh
index aec6ed192d..ec4f25d009 100755
--- c/t/t6120-describe.sh
+++ w/t/t6120-describe.sh
@@ -319,10 +319,14 @@ test_expect_success 'describe a blob at a tag' '
 	test_cmp expect actual
 '
 
-test_expect_success 'describe a blob with commit-ish' '
+test_expect_success 'describe a blob with its last introduction' '
+	git commit --allow-empty -m "empty commit" &&
+	git rm file &&
+	git commit -m "delete blob" &&
+	git revert HEAD &&
 	git commit --allow-empty -m "empty commit" &&
 	git describe HEAD:file >actual &&
-	grep unique-file-1-g actual
+	grep unique-file-3-g actual
 '
 
 test_expect_failure ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
