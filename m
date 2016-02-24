From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH v3 3/3] t3034: test deprecated interface
Date: Tue, 23 Feb 2016 22:41:31 -0300
Message-ID: <1456278091-6564-4-git-send-email-felipegassis@gmail.com>
References: <1456278091-6564-1-git-send-email-felipegassis@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Feb 24 02:44:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYOUi-0004iR-9M
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 02:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754484AbcBXBn4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 20:43:56 -0500
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33401 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738AbcBXBnz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 20:43:55 -0500
Received: by mail-qg0-f52.google.com with SMTP id b35so3515289qge.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 17:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0tRAoTDMlbyYnR/2NvoP/2BjFho5FG/y/h8PotXPZHo=;
        b=XeeI7o5sCSm+FwqaFhfBfF0SUywA4dgzYBpPpfO8h3KOddADaNA7frI0Cf+MkHs3QX
         8oEaurGyiMvykWM4XUXiCLqNE6zIswcF6eh52YU5U/j5z/cLLDWB4fySS5wUBEdmD6t2
         CBopuQ813pePfmTnAraGEaxAAW8JaX0/TJm0jzSo48jx3br5RRX2z0f5fE0Z/bIK8vo8
         WyvxT30UpPcqPlQAebazfcH2umA9aps1rWUn8QeAiBBGuKb0uj4Fq5wc/unG69BdvE9w
         /MDT14FBqVDWtCJ4KZ3b0FqYB981TwPPKoUR+22TYMtkmDOKcs/1xxP3Cb8GqYggE4ci
         41Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=0tRAoTDMlbyYnR/2NvoP/2BjFho5FG/y/h8PotXPZHo=;
        b=TAcWoc9Y2PRs5fEG3VMGOjThH2s5CLJzC+AizLyf2Gno6W7ZFF+FxdrBo+Ib2KGOSF
         0kjKSn4DFvMG2rlxYn3uEl/ihVtduBxfhte98gVJIsyIqCDHDBETbQipcabOD9Kx5DvN
         +QlP0NAOH49772WhUHZV2A5iz5qTkGpgnqxQlsz7XLIpHF3GthRSp2zGknPEYnp7g3Xi
         O7Y7KPltlXi7S6lZrzKvPEBkBgdNOKKsp/NttzDNPVeFgIRU1znj95xDwxJ8U04jNCYO
         MEsSHsitzb5btauOBDL5dTp+Yq0MXoAKvHQgyaLHxIFLs3s1FMrCeXZcCgLuy2wpF1Iw
         O2kg==
X-Gm-Message-State: AG10YOR5DShDT3fTYK6aHO6bweq5ZA3sMzqJoEcM4W/gJzr/aFxo7aIdGbtQYpbHsmmHZw==
X-Received: by 10.140.96.45 with SMTP id j42mr36781035qge.63.1456278234398;
        Tue, 23 Feb 2016 17:43:54 -0800 (PST)
Received: from traveller.moon (189-19-119-165.dsl.telesp.net.br. [189.19.119.165])
        by smtp.gmail.com with ESMTPSA id e127sm271155qkb.34.2016.02.23.17.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 17:43:53 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.492.gd821b20
In-Reply-To: <1456278091-6564-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287159>

=46rom: Felipe Gon=C3=A7alves Assis <felipeg.assis@gmail.com>

--find-renames=3D and --rename-threshold=3D should be aliases.

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---
 t/t3034-merge-recursive-rename-options.sh | 46 +++++++++++++++++++++++=
++++++++
 1 file changed, 46 insertions(+)

diff --git a/t/t3034-merge-recursive-rename-options.sh b/t/t3034-merge-=
recursive-rename-options.sh
index 2479910..b9c4028 100755
--- a/t/t3034-merge-recursive-rename-options.sh
+++ b/t/t3034-merge-recursive-rename-options.sh
@@ -263,4 +263,50 @@ test_expect_success '--find-renames rejects non-nu=
mbers' '
 	git diff --quiet --cached
 '
=20
+test_expect_success 'rename-threshold=3D<n> is a synonym for find-rena=
mes=3D<n>' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --rename-threshold=3D$th0 $tail &&
+	check_threshold_0
+'
+
+test_expect_success 'last wins in --no-renames --rename-threshold=3D<n=
>' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --no-renames --rename-threshold=3D=
$th0 $tail &&
+	check_threshold_0
+'
+
+test_expect_success 'last wins in --rename-threshold=3D<n> --no-rename=
s' '
+	git read-tree --reset -u HEAD &&
+	git merge-recursive --rename-threshold=3D$th0 --no-renames $tail &&
+	check_no_renames
+'
+
+test_expect_success '--rename-threshold=3D<n> rejects negative argumen=
t' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --rename-threshold=3D-25 \
+		HEAD -- HEAD HEAD &&
+	git diff --quiet --cached
+'
+
+test_expect_success '--rename-threshold=3D<n> rejects non-numbers' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --rename-threshold=3D0xf \
+		HEAD -- HEAD HEAD &&
+	git diff --quiet --cached
+'
+
+test_expect_success 'last wins in --rename-threshold=3D<m> --find-rena=
mes=3D<n>' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive \
+		--rename-threshold=3D$th0 --find-renames=3D$th2 $tail &&
+	check_threshold_2
+'
+
+test_expect_success 'last wins in --find-renames=3D<m> --rename-thresh=
old=3D<n>' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive \
+		--find-renames=3D$th2 --rename-threshold=3D$th0 $tail &&
+	check_threshold_0
+'
+
 test_done
--=20
2.7.1.492.gd821b20
