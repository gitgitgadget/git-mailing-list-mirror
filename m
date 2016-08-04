Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D725A20193
	for <e@80x24.org>; Thu,  4 Aug 2016 19:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbcHDTwL (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 15:52:11 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35811 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758986AbcHDTwI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 15:52:08 -0400
Received: by mail-pf0-f181.google.com with SMTP id x72so89553092pfd.2
        for <git@vger.kernel.org>; Thu, 04 Aug 2016 12:52:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BD3SexaLlIoqB63aYRk8npb6bYH9/UrtQcVF7JLFd5k=;
        b=IBI3ICDXAUCehLuO4oC/1LLi0L5WlABJNB/cb2d3r+KrwV6R3R8dUL0ZQquVq78mjT
         pHorBcLT5NS6IibDm/kMdeFDOMnL3pzqJSmuNnzrGr48XB0uQ+A8HAvWjZ76toSSn9Pi
         m0ztW0Ee3U2cPBvv4+RT3pVt7csnzQ9+VIZAQ99ohYrzhFa448yljLRDZKaQTvKIqEGc
         EEAoRiF4tU8fNEMHB3TG7ctxkf6cN534lYjXQIPxgzQgk9R7aMZxoOsZYAaiSq2eLTth
         v+CyHFUXAhQTSt5QOqYIgq4+S/EtzJ8jbgv112NDt0r6CwBivBU00/7KTHWrgXusnOKG
         Wc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BD3SexaLlIoqB63aYRk8npb6bYH9/UrtQcVF7JLFd5k=;
        b=WtmbD5HsIgzCMnjvFRMpJ5rVNeCu+Tj663bf8ZstoSrzLVQOyZD8ruChoBpgbfEdRo
         wZbKWRE8mJtaEGaLbPkF0uzJTYJybvGfuYT8eodDpCX9JdJboYLr2Kgdm/8mPHFSa8Wv
         8FN5JPgOPhiRJc/qKav7Dfjb28PcHiopb/ohoPemzS4pEgoSKjW2S+1UcgW10lpR3WM8
         /lKC6iCiTJym/0QjLuuukeKtzlyP//eHEmxQIF2E793A9e7U/OcEHOayBG0zRFZ3RREU
         Ogw7X89plYMXJPGXMXDlJl/KNTQXa2cGB2E/5XUhCY4plVDqqmW9qKlSD/Uybox+gl+R
         x1Wg==
X-Gm-Message-State: AEkoouuA7E7mMQDMT9nDA9TrZdEe9CQWn0uAvyjzoV1XxIP9QlWvgk/lODz2YwYKZsQ+L/Sx
X-Received: by 10.98.133.10 with SMTP id u10mr110941942pfd.134.1470340327362;
        Thu, 04 Aug 2016 12:52:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b86b:a022:8342:c00c])
        by smtp.gmail.com with ESMTPSA id p67sm22302377pfg.22.2016.08.04.12.52.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 04 Aug 2016 12:52:06 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, mst@redhat.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/6] t7408: modernize style
Date:	Thu,  4 Aug 2016 12:51:54 -0700
Message-Id: <20160804195159.7788-2-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.572.g9d9644e.dirty
In-Reply-To: <20160804195159.7788-1-sbeller@google.com>
References: <20160804195159.7788-1-sbeller@google.com>
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
 t/t7408-submodule-reference.sh | 138 +++++++++++++++++++++--------------------
 1 file changed, 71 insertions(+), 67 deletions(-)

diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index eaea19b..afcc629 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -10,72 +10,76 @@ base_dir=$(pwd)
 
 U=$base_dir/UPLOAD_LOG
 
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
+		echo "0 objects, 0 kilobytes" > expected &&
+		git count-objects > current &&
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
+	echo "0 objects, 0 kilobytes" > expected &&
+	git count-objects > current &&
+	diff expected current
+'
 
 test_done
-- 
2.9.2.572.g9d9644e.dirty

