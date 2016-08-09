Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A07E2018E
	for <e@80x24.org>; Tue,  9 Aug 2016 04:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbcHIEIV (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 00:08:21 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33753 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbcHIEIU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 00:08:20 -0400
Received: by mail-pa0-f48.google.com with SMTP id ti13so1223799pac.0
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 21:08:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VD9mmgrhID+FjC4dXoPqH+6wFGL9TVayyH6fQ/3jzTs=;
        b=TxA251HI4/Mm2+G4di9vAVS5+X3aSlj7ogMh4X2DQ8NJOtYBYS4CxT+qR1saEIDGBS
         0BomJL1ObX9t5o0pHZAEx/ylNedw/UYuK7wvfgB6v5G1DSgXcvoEnjFw7yeA1j4f0jTs
         I01VEup5a+tRtM6vv7gXoPy5ZLS5VASrsbvfpgrnOfrHSNfrHaRhNlMHRjjxz8nIqNg4
         ArLpjRtagLDEnJU2tPDVTGsKwIW2BLRdGlBX7oGnhuyM+220zo0msBW4kn8kv2DNoiX8
         bG2lUxr+1Hjod+FrwAV9KF1Z1dZBz8UyWCro2TTWam9jlOiz9ijaiNa2Mq7PuMh3cIhe
         aHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VD9mmgrhID+FjC4dXoPqH+6wFGL9TVayyH6fQ/3jzTs=;
        b=HG+6vOyPUOndRMkUZ4O4t9YGld1f9YcL18dyZLlPvRiDhWoVSmpqrVgsbl8svXQrE6
         MeNM5zK1X1tJj1V2v2QQy4kCyf+RZA0GGY7G/tvWhQzvnZAY3bRnyEQ4+eeSIgLFDXLs
         1GCoHY8xc8YM5GuQuF47NeFB0ZFEvQwmToJgtVzXc3qaISdTbC/99rEUuMiYWPuyrQuw
         52WgWiGZP1lZcft1EIQtG8qdeB6hR67xkAnatcHph7OE3a4mSki7JmP4K0i3BRkiKaQm
         EiGpnd3sHuNhdECgZCr9WB791Erg3Jx37NNNy8tMKQqBQgkXHVN2cYfLoGGgwM6kO72W
         8P6A==
X-Gm-Message-State: AEkoouuilEb6IT7fZ3LqEUYhrcL8JU3rHJnvaMURtesvO5ZfKIfLRbi305o1wc9oL2uZ/FTe
X-Received: by 10.66.244.199 with SMTP id xi7mr167007043pac.127.1470715697129;
        Mon, 08 Aug 2016 21:08:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ad25:78d3:1e25:67ef])
        by smtp.gmail.com with ESMTPSA id a5sm51470312pfc.89.2016.08.08.21.08.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 21:08:16 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, mst@redhat.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 1/9] t7408: modernize style
Date:	Mon,  8 Aug 2016 21:08:01 -0700
Message-Id: <20160809040811.21408-2-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.583.gd6329be.dirty
In-Reply-To: <20160809040811.21408-1-sbeller@google.com>
References: <20160809040811.21408-1-sbeller@google.com>
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
index eaea19b..beee0bb 100755
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
2.9.2.583.gd6329be.dirty

