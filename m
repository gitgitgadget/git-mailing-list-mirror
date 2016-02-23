From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH 2/3] t3034: test option to disable renames
Date: Tue, 23 Feb 2016 01:38:44 -0300
Message-ID: <1456202325-6037-3-git-send-email-felipegassis@gmail.com>
References: <1456202325-6037-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 05:41:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY4ml-0007XC-DW
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 05:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757285AbcBWElJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2016 23:41:09 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33192 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757271AbcBWElF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 23:41:05 -0500
Received: by mail-vk0-f51.google.com with SMTP id k196so152000679vka.0
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 20:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VEtB6ObOCsPlpGgpdAledyTNiztRpltG3qdl6vUDg78=;
        b=MZKKAa1CkrjJXZw8Y67Ak+JGVwvsYkdYvB4STeELCkEsqPBYXefug3QmgB/OtZtrEn
         nbbiiPczCxLZHjY8X6ULhqj3G5cTPJ5SEacHgBtzZxiZO2wNShYZ5HWRbjG369hH1ueP
         BhaLnyqGcKK8NgihZo8kjrilQwilvQsQ96XJqD9rPg0pLVz4nwmVrtvdHLvYmcUl2CHJ
         mJxz5W5t9gP41/nLCaeTgSxWoj3uUD7lFfJ5P+HaZQUBhQcQLJXg4QWA+GplZhvjXViY
         b1havTtQRl2fgzA6ujvoC88xOu3/s5Kbqn7aQm2m2csUtt3HH9NBQw2/D5VI+bLbli5k
         Mylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=VEtB6ObOCsPlpGgpdAledyTNiztRpltG3qdl6vUDg78=;
        b=R8a3MWOToBVAEPn23ubuC0rjIcmc6RsbZFUQKnCSeOeq3Bhot2vvscnXIxnJU0DZUC
         QkRlnOcSinOZ4P4X8hDfZrx4vR5ljdpdNCetZ1UYnvLPElxuAEupI2zPR3cKEHB1dYhI
         tEDdmVcO/rzS7qRs4twy9HQJuWwFd+Mj+VOTjs48gGL2O8k/KmPhJzNNg2m4FlExL10d
         cOPJMTGLwyCGv4YZR+rQYYcrD3J7NsSPOVwAcsgMFPQwvXdfvEw8mImk8QqGIXlx/R0o
         5nbwv3TvVZBEuFHB10dFA/W6UBylVyZ8dXbz479MyF8sw6GnWm82RQnXonc458SygQgf
         bCSg==
X-Gm-Message-State: AG10YOSrSUgexKukYRXh192E/4ks2lCOo2z4W5GkKmBhxDIv3/p8/SgzP/+MlQnqO9XisA==
X-Received: by 10.31.146.2 with SMTP id u2mr22931082vkd.19.1456202464369;
        Mon, 22 Feb 2016 20:41:04 -0800 (PST)
Received: from traveller.moon (201-43-158-89.dsl.telesp.net.br. [201.43.158.89])
        by smtp.gmail.com with ESMTPSA id o141sm3772201vkd.19.2016.02.22.20.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2016 20:41:03 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.492.gd821b20
In-Reply-To: <1456202325-6037-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287012>

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---
 t/t3034-merge-recursive-rename-options.sh | 28 +++++++++++++++++++++++=
+++++
 1 file changed, 28 insertions(+)

diff --git a/t/t3034-merge-recursive-rename-options.sh b/t/t3034-merge-=
recursive-rename-options.sh
index 66fee8a..03ce77c 100755
--- a/t/t3034-merge-recursive-rename-options.sh
+++ b/t/t3034-merge-recursive-rename-options.sh
@@ -83,6 +83,14 @@ check_exact_renames () {
 	rename_detected 3
 }
=20
+check_no_renames () {
+	check_common &&
+	rename_undetected 0 &&
+	rename_undetected 1 &&
+	rename_undetected 2 &&
+	rename_undetected 3
+}
+
 test_expect_success 'setup 1/2: basic setup' '
 	cat <<-\EOF >3-old &&
 	33a
@@ -192,6 +200,12 @@ test_expect_success 'rename threshold is truncated=
' '
 	check_exact_renames
 '
=20
+test_expect_success 'disabled rename detection' '
+	git read-tree --reset -u HEAD &&
+	git merge-recursive --no-renames $tail &&
+	check_no_renames
+'
+
 test_expect_success 'last wins in --find-renames=3D<m> --find-renames=3D=
<n>' '
 	git read-tree --reset -u HEAD &&
 	test_must_fail git merge-recursive \
@@ -206,6 +220,18 @@ test_expect_success '--find-renames resets thresho=
ld' '
 	$check_50
 '
=20
+test_expect_success 'last wins in --no-renames --find-renames' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --no-renames --find-renames $tail =
&&
+	$check_50
+'
+
+test_expect_success 'last wins in --find-renames --no-renames' '
+	git read-tree --reset -u HEAD &&
+	git merge-recursive --find-renames --no-renames $tail &&
+	check_no_renames
+'
+
 test_expect_success 'assumption for further tests: trivial merge succe=
eds' '
 	git read-tree --reset -u HEAD &&
 	git merge-recursive HEAD -- HEAD HEAD &&
@@ -215,6 +241,8 @@ test_expect_success 'assumption for further tests: =
trivial merge succeeds' '
 	git merge-recursive --find-renames=3D${th[2]} HEAD -- HEAD HEAD &&
 	git diff --quiet --cached &&
 	git merge-recursive --find-renames=3D100% HEAD -- HEAD HEAD &&
+	git diff --quiet --cached &&
+	git merge-recursive --no-renames HEAD -- HEAD HEAD &&
 	git diff --quiet --cached
 '
=20
--=20
2.7.1.492.gd821b20
