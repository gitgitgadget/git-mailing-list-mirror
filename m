Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCC281F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 21:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbcHOVxm (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 17:53:42 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36770 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006AbcHOVxl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 17:53:41 -0400
Received: by mail-pf0-f179.google.com with SMTP id h186so20343355pfg.3
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 14:53:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qk5+sxBjC2Gm2tq5ovp8vy85/fIdsfhn0SHVRSSfm7I=;
        b=o9bLI6/rTyI/4VoCnScOdoRp6jKH4O6xNgXDX8WQXY9WP04zhHibWUwxkJoFYZTD5O
         tCnGhEBoyKhEy0h0aiZdPGY3hgf42urepoYRL6xrrEuHxhvOqAF3BR8/iEC7fTToQjiF
         FL9UG5GyhWfi0f1cLR6aBsxP0GDp+EX9YGGnwP5NTrhhYby98lypOMSC/Jcdey/pxLE7
         sn1dCFP7PM+L2aj4WYO3b3b6jGfQBXeVGGalHNKWaxEiH9OfTNG2586fBMwAFoBBpfp5
         NId3dgzqpGn/kKvQYNvOXoxvJisjNU97ln/Re8yXgp3ttZTmnf6IJVXLdxSqgNE+AsoY
         S+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qk5+sxBjC2Gm2tq5ovp8vy85/fIdsfhn0SHVRSSfm7I=;
        b=Kn9r0DEmk7drhSaSHq5ervpZzSWsHYwlSCjvclavZl1ZNuFiT8+fq85A4OZqmRHF58
         oIGu7W1uXc2uzV4fuuwQOw+RJTQlJKPxtEtRzRM2ji64d9i+0oUBoFxYwYEEXjiTq0kL
         N+58n4gnoPqfvcLE5X2tPQWq0M5+WaSJ/7Qbu7CZPrv58DVSa2sUa4XJv28Qmg4NihYZ
         sWKDPZXyQ/G3wWMVkMUJpmVN8qrSZMC7LNzSkm36ne8eVIMYX4yV45RtaqIVyk69o9hl
         inviIJho/4iXfMVH9/m1TRzSVO6wEMZU3l5fJqcaGF6zQsW4/j1sff5rBP+hk2GSu573
         Psog==
X-Gm-Message-State: AEkooutRdYPe+1i57kDi4nsyfr4t7+w8b3rqT7M3CVsypo1c2tPgWcfACbxpdBvGBNX5S73o
X-Received: by 10.98.155.17 with SMTP id r17mr57787095pfd.24.1471298020511;
        Mon, 15 Aug 2016 14:53:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fd0c:5bce:d30d:9f4d])
        by smtp.gmail.com with ESMTPSA id p64sm33717751pfd.11.2016.08.15.14.53.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 Aug 2016 14:53:39 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 1/8] t7408: modernize style
Date:	Mon, 15 Aug 2016 14:53:20 -0700
Message-Id: <20160815215327.15682-2-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.730.g525ad04.dirty
In-Reply-To: <20160815215327.15682-1-sbeller@google.com>
References: <20160815215327.15682-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

No functional change intended. This commit only changes formatting
to the style we recently use, e.g. starting the body of a test with a
single quote on the same line as the header, and then having the test
indented in the following lines.

Whenever we change directories, we do that in subshells.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7408-submodule-reference.sh | 140 +++++++++++++++++++++--------------------
 1 file changed, 71 insertions(+), 69 deletions(-)

diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index eaea19b..b84c6748 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -8,74 +8,76 @@ test_description='test clone --reference'
 
 base_dir=$(pwd)
 
-U=$base_dir/UPLOAD_LOG
-
-test_expect_success 'preparing first repository' \
-'test_create_repo A && cd A &&
-echo first > file1 &&
-git add file1 &&
-git commit -m A-initial'
-
-cd "$base_dir"
-
-test_expect_success 'preparing second repository' \
-'git clone A B && cd B &&
-echo second > file2 &&
-git add file2 &&
-git commit -m B-addition &&
-git repack -a -d &&
-git prune'
-
-cd "$base_dir"
-
-test_expect_success 'preparing superproject' \
-'test_create_repo super && cd super &&
-echo file > file &&
-git add file &&
-git commit -m B-super-initial'
-
-cd "$base_dir"
-
-test_expect_success 'submodule add --reference' \
-'cd super && git submodule add --reference ../B "file://$base_dir/A" sub &&
-git commit -m B-super-added'
-
-cd "$base_dir"
-
-test_expect_success 'after add: existence of info/alternates' \
-'test_line_count = 1 super/.git/modules/sub/objects/info/alternates'
-
-cd "$base_dir"
-
-test_expect_success 'that reference gets used with add' \
-'cd super/sub &&
-echo "0 objects, 0 kilobytes" > expected &&
-git count-objects > current &&
-diff expected current'
-
-cd "$base_dir"
-
-test_expect_success 'cloning superproject' \
-'git clone super super-clone'
-
-cd "$base_dir"
-
-test_expect_success 'update with reference' \
-'cd super-clone && git submodule update --init --reference ../B'
-
-cd "$base_dir"
-
-test_expect_success 'after update: existence of info/alternates' \
-'test_line_count = 1 super-clone/.git/modules/sub/objects/info/alternates'
-
-cd "$base_dir"
-
-test_expect_success 'that reference gets used with update' \
-'cd super-clone/sub &&
-echo "0 objects, 0 kilobytes" > expected &&
-git count-objects > current &&
-diff expected current'
-
-cd "$base_dir"
+test_expect_success 'preparing first repository' '
+	test_create_repo A &&
+	(
+		cd A &&
+		echo first >file1 &&
+		git add file1 &&
+		git commit -m A-initial
+	)
+'
+
+test_expect_success 'preparing second repository' '
+	git clone A B &&
+	(
+		cd B &&
+		echo second >file2 &&
+		git add file2 &&
+		git commit -m B-addition &&
+		git repack -a -d &&
+		git prune
+	)
+'
+
+test_expect_success 'preparing superproject' '
+	test_create_repo super &&
+	(
+		cd super &&
+		echo file >file &&
+		git add file &&
+		git commit -m B-super-initial
+	)
+'
+
+test_expect_success 'submodule add --reference' '
+	(
+		cd super &&
+		git submodule add --reference ../B "file://$base_dir/A" sub &&
+		git commit -m B-super-added
+	)
+'
+
+test_expect_success 'after add: existence of info/alternates' '
+	test_line_count = 1 super/.git/modules/sub/objects/info/alternates
+'
+
+test_expect_success 'that reference gets used with add' '
+	(
+		cd super/sub &&
+		echo "0 objects, 0 kilobytes" >expected &&
+		git count-objects >current &&
+		diff expected current
+	)
+'
+
+test_expect_success 'cloning superproject' '
+	git clone super super-clone
+'
+
+test_expect_success 'update with reference' '
+	cd super-clone && git submodule update --init --reference ../B
+'
+
+test_expect_success 'after update: existence of info/alternates' '
+	test_line_count = 1 super-clone/.git/modules/sub/objects/info/alternates
+'
+
+test_expect_success 'that reference gets used with update' '
+	cd super-clone/sub &&
+	echo "0 objects, 0 kilobytes" >expected &&
+	git count-objects >current &&
+	diff expected current
+'
 
 test_done
-- 
2.9.2.730.g525ad04.dirty

