Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5B2320193
	for <e@80x24.org>; Thu, 11 Aug 2016 23:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbcHKXON (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 19:14:13 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33436 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbcHKXOM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 19:14:12 -0400
Received: by mail-pf0-f170.google.com with SMTP id y134so2921314pfg.0
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 16:14:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AErn9Pp3mFAWo9qXA9ViR2xEquxa6XXvxEnur9HrGyA=;
        b=XNPhFl7KOoz3fVow7o+XcJoyN1DjZYSB0SJP2x0L0l2CRD4myy90d/NqPxtHQaz80f
         udPo5R0WAoPpR++6uwkWsH9BuBq/j+RStbBShc7M0Da91C+Ql2s1teAp16IgV5ZhdTU+
         /oZMK9yXlqHlxcthWWG2JDXR+inwsXgxl5Eu5qg46/Nc9sR80paqfEEz+Xvv87bdFVVn
         fsoxXK4VCAv7kAV46nPDSqZbpBKrTKz6mGdgGcl5DZ5F7zhvML2JUf5XhctGfEzgK+C5
         4eesh1rm+lZbFpBTfERf426FBxmEnLfw2D7tgWmTIyyuK/hha76b9y7LtSDBeWsDndew
         7D7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AErn9Pp3mFAWo9qXA9ViR2xEquxa6XXvxEnur9HrGyA=;
        b=BSqGWtMBCEuOVyW5BNBq9w6be/S4FCx/0cG7dMjT4Vm1ObOeRQtESIJF29iY8k2AqA
         gvTgkmHOFy+9w0gK+Bt9+iofPAQnNgHVV+8ZzXx5q1HtfcjCmeBTy8tag2Se7xqO1vPH
         hK7WAS6MAyXUyD9jK/XABDxRLTQyC5r80cACnTZvWwuphLo2yVJ0mhpqtrd/Wlep9QhM
         Izw8zpZiClTqXkj5Ni3h/dVWSXpgcfItdOAbntsvFf/fTZLtmg+iB4tigSfdHimiU54n
         d7b/vq/A2fgHollyKY911OoTjIBW0NgynUnJQcGYHettD2Z/l1KaZvMj73GAfQxo97mp
         OEhg==
X-Gm-Message-State: AEkoout673xRREb3CTHwRJZgdMtPOOf9wS0Vmivm+0CCFd7Vr0fjreVJTuKMuDetC74VapPj
X-Received: by 10.98.51.131 with SMTP id z125mr21719431pfz.109.1470957251937;
        Thu, 11 Aug 2016 16:14:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:2879:1504:a6e4:e441])
        by smtp.gmail.com with ESMTPSA id g10sm7705591pfc.57.2016.08.11.16.14.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 16:14:11 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 1/8] t7408: modernize style
Date:	Thu, 11 Aug 2016 16:13:58 -0700
Message-Id: <20160811231405.17318-2-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.737.g4a14654
In-Reply-To: <20160811231405.17318-1-sbeller@google.com>
References: <20160811231405.17318-1-sbeller@google.com>
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
2.9.2.737.g4a14654

