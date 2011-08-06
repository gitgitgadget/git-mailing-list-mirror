From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 03/40] whitespace: remediate t1006-cat-file.sh
Date: Sat,  6 Aug 2011 18:44:17 +1000
Message-ID: <1312620294-18616-3-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:45:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcVk-0004uu-84
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382Ab1HFIpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:45:22 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39722 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab1HFIpL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:11 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182410iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=rF61NzLS+8RDA5tZgd0It4tjuPddWu5Wj2x7cKEQFao=;
        b=SjaMDqgnQNyEE7rtaIAheKF4nWwAv8mUmPXRoVrlEb8onr9PRHB3nh4yWe43yrSUrh
         IGYq9BpEnz56hdUwiNVqUIU5/ZI+JpDpBP/o2P8FjzLDCfn//f21RAlh4BhBn1NFMsFF
         w/cUNMWUJ9ZyET5AdBd1QmYV3veYPRBDDweQc=
Received: by 10.231.207.19 with SMTP id fw19mr935328ibb.27.1312620310901;
        Sat, 06 Aug 2011 01:45:10 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178834>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t1006-cat-file.sh |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index d8b7f2f..c78bf87 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -14,7 +14,7 @@ strlen () {
 
 maybe_remove_timestamp () {
     if test -z "$2"; then
-        echo_without_newline "$1"
+	echo_without_newline "$1"
     else
 	echo_without_newline "$(printf '%s\n' "$1" | sed -e 's/ [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$//')"
     fi
@@ -36,11 +36,11 @@ $content"
     '
 
     test_expect_success "Type of $type is correct" '
-        test $type = "$(git cat-file -t $sha1)"
+	test $type = "$(git cat-file -t $sha1)"
     '
 
     test_expect_success "Size of $type is correct" '
-        test $size = "$(git cat-file -s $sha1)"
+	test $size = "$(git cat-file -s $sha1)"
     '
 
     test -z "$content" ||
@@ -48,54 +48,54 @@ $content"
 	expect="$(maybe_remove_timestamp "$content" $no_ts)"
 	actual="$(maybe_remove_timestamp "$(git cat-file $type $sha1)" $no_ts)"
 
-        if test "z$expect" = "z$actual"
+	if test "z$expect" = "z$actual"
 	then
 		: happy
 	else
 		echo "Oops: expected $expect"
 		echo "but got $actual"
 		false
-        fi
+	fi
     '
 
     test_expect_success "Pretty content of $type is correct" '
 	expect="$(maybe_remove_timestamp "$pretty_content" $no_ts)"
 	actual="$(maybe_remove_timestamp "$(git cat-file -p $sha1)" $no_ts)"
-        if test "z$expect" = "z$actual"
+	if test "z$expect" = "z$actual"
 	then
 		: happy
 	else
 		echo "Oops: expected $expect"
 		echo "but got $actual"
 		false
-        fi
+	fi
     '
 
     test -z "$content" ||
     test_expect_success "--batch output of $type is correct" '
 	expect="$(maybe_remove_timestamp "$batch_output" $no_ts)"
 	actual="$(maybe_remove_timestamp "$(echo $sha1 | git cat-file --batch)" $no_ts)"
-        if test "z$expect" = "z$actual"
+	if test "z$expect" = "z$actual"
 	then
 		: happy
 	else
 		echo "Oops: expected $expect"
 		echo "but got $actual"
 		false
-        fi
+	fi
     '
 
     test_expect_success "--batch-check output of $type is correct" '
 	expect="$sha1 $type $size"
 	actual="$(echo_without_newline $sha1 | git cat-file --batch-check)"
-        if test "z$expect" = "z$actual"
+	if test "z$expect" = "z$actual"
 	then
 		: happy
 	else
 		echo "Oops: expected $expect"
 		echo "but got $actual"
 		false
-        fi
+	fi
     '
 }
 
@@ -184,7 +184,7 @@ test_expect_success "--batch-check for a non-existent hash" '
     test "0000000000000000000000000000000000000042 missing
 0000000000000000000000000000000000000084 missing" = \
     "$( ( echo 0000000000000000000000000000000000000042;
-         echo_without_newline 0000000000000000000000000000000000000084; ) \
+	 echo_without_newline 0000000000000000000000000000000000000084; ) \
        | git cat-file --batch-check)"
 '
 
@@ -193,7 +193,7 @@ test_expect_success "--batch for an existent and a non-existent hash" '
 $tag_content
 0000000000000000000000000000000000000000 missing" = \
     "$( ( echo $tag_sha1;
-         echo_without_newline 0000000000000000000000000000000000000000; ) \
+	 echo_without_newline 0000000000000000000000000000000000000000; ) \
        | git cat-file --batch)"
 '
 
-- 
1.7.6.362.gf0e6
