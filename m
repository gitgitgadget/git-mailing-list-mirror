From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH 2/3] t3034: test option to disable renames
Date: Tue, 23 Feb 2016 20:48:11 -0300
Message-ID: <1456271292-4652-3-git-send-email-felipegassis@gmail.com>
References: <1456271292-4652-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipeg.assis@gmail.com>,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 00:50:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYMie-0001kA-AY
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 00:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbcBWXuF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 18:50:05 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:35347 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbcBWXuA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 18:50:00 -0500
Received: by mail-qg0-f51.google.com with SMTP id y89so1685537qge.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 15:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Wtfj0gXLx3uL8YO06AjQ+70eKLnHHD1oFp7E/QkaorE=;
        b=QgVw3aakVeNWgBA9r97sg3tB/lwec+Ldt4rWjQpfkO5+wQfNWXX/BFnGmr1tyUdTJz
         y5zv/oIvEVFfZQsfAD2rr3PUM19KgQjc0g1qYTEA44cQ5jm+fGdkq3K8hMydcdzN8/0z
         8jhiC8WlpChGQKEerjX5U5pqf9qnah8BySLUp0j+G7I4/6dm5NfKz7+0kv+1EkRF5f2M
         c6GdnNJr593y6UKKYsU7CEcKdSkrAYTRaPKJzPbmIFfCTBRB9xl/9qQoyHmqV9QCrydK
         DnnVOX2yA5MuLQHR/ba7vORWpGcu7ORijmUhazBhAsBoTiXnG611GRQfWvCBVKms+v/8
         5daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Wtfj0gXLx3uL8YO06AjQ+70eKLnHHD1oFp7E/QkaorE=;
        b=CqfP7Uzq29Jxst/zryNfKQd2TU3p+XcibD8ucadsLCL7M7C8XWiN9vbEAem1Qu2dIj
         GPlXG3g5C/ezeB094BA8IO6v7w71ikNbQ4xNX/UvYkE/flq3SRqBzbaa+OY67VjwbNUc
         Yb0JMNRY9ztLn8LkYr1U6EcRPGjgIZb25D9k8eML1UeDbw2Wd/nQXdy4nFq1azwB3euh
         WNPN+Bh7O9GlK4bnDYx4Isaq8Ez0PDEci7A7sRhcmUvesCWrccmCkKezFU4OSVVCyEfv
         3+BdAsphpuD559V8GbyUglDvEC4iHf7qxxrIuc5sPHnR1yLP6pYPHpHVoQ/t1jkFdxtn
         vV0Q==
X-Gm-Message-State: AG10YOR/Paz984JWaG4qRgmWIEdwELWBHOdt5BANh3jNSA4rCoTElGmaN7T//XrsdhZ4pQ==
X-Received: by 10.140.242.16 with SMTP id n16mr48460837qhc.2.1456271400017;
        Tue, 23 Feb 2016 15:50:00 -0800 (PST)
Received: from traveller.moon (189-19-119-165.dsl.telesp.net.br. [189.19.119.165])
        by smtp.gmail.com with ESMTPSA id w1sm126080qha.3.2016.02.23.15.49.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 15:49:59 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.492.gd821b20
In-Reply-To: <1456271292-4652-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287148>

=46rom: Felipe Gon=C3=A7alves Assis <felipeg.assis@gmail.com>

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---
 t/t3034-merge-recursive-rename-options.sh | 28 +++++++++++++++++++++++=
+++++
 1 file changed, 28 insertions(+)

diff --git a/t/t3034-merge-recursive-rename-options.sh b/t/t3034-merge-=
recursive-rename-options.sh
index fbec68c..c07a4cb 100755
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
 	git merge-recursive --find-renames=3D$th2 HEAD -- HEAD HEAD &&
 	git diff --quiet --cached &&
 	git merge-recursive --find-renames=3D100% HEAD -- HEAD HEAD &&
+	git diff --quiet --cached &&
+	git merge-recursive --no-renames HEAD -- HEAD HEAD &&
 	git diff --quiet --cached
 '
=20
--=20
2.7.1.492.gd821b20
