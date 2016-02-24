From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH v3 2/3] t3034: test option to disable renames
Date: Tue, 23 Feb 2016 22:41:30 -0300
Message-ID: <1456278091-6564-3-git-send-email-felipegassis@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Feb 24 02:43:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYOUf-0004dG-Op
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 02:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388AbcBXBnx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 20:43:53 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33195 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738AbcBXBnw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 20:43:52 -0500
Received: by mail-qk0-f175.google.com with SMTP id s5so1700000qkd.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 17:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wIYNGm8o4ipIvR/CqXRBi4ZR4MzIdahFPRGsj5GayTs=;
        b=bekSJHo2f6fSP5rL7RAkMtua/U/iFPwEgV+s7kRN9eiflLLLbAcFZKfO6Qy+GgPruF
         Woj6G8MPi8wpdtJQk/tZj1jSEum1zUp7xSLA4nlIIUX4KkMaQYEsggc0L8dvGzk3bltJ
         mePDk4j97xrbgmLjpWTdQMMesDwwuraQD2jXLbdYlzrJVJ4GIc1KUkbbhXsHnm/nQAbc
         rwkxB41auVgoVcOJfkoLDyTPBsGO1QSzkrYi0qyDTRXhfe/Z3Tp+DVsc95L7b/QHZ577
         UPB4jx/YY8JHf4HESeDwIq2ABmYq5veJMfF797TDD1BcPDCi65uvPzBhmaBkQcF+DK8D
         x+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=wIYNGm8o4ipIvR/CqXRBi4ZR4MzIdahFPRGsj5GayTs=;
        b=EE+KlolUc4aGrMs8nTswnBBQqplV9bKM3yFulQaqYuxovrtxa2thb6lt742cukEKR4
         hg/jDrk7iL1UfYlNCYseOiaembZzJ7fqJyNLvolx3GRs7abklvRg0B6xQj0AsTmB717x
         BdRF2gLqIcowuDpaDqQL6YCaHjGf9liAPJF6NJDcR0fIXHiSrOTioB3H+65YW1MpX5un
         CWwZYlpSNLPVuOJACsy2HGh4EvCRCxGV1hw3cYwsTPWJc5VSk53wmDTXph41YM2VRwzB
         pAHbNoCoXCONzJuWDfmUyxEu5PIobyYJEsVL00ZFPlkh/GhJzYEcy8k9eV5o2pGfmMOE
         /CXA==
X-Gm-Message-State: AG10YOSgiLFT9MjjQY8fXsdRJco5yf8oVMKq6z+vgX4er76Arj0K2b5UYIK+NxCmHCSmbg==
X-Received: by 10.55.75.212 with SMTP id y203mr46713939qka.3.1456278231909;
        Tue, 23 Feb 2016 17:43:51 -0800 (PST)
Received: from traveller.moon (189-19-119-165.dsl.telesp.net.br. [189.19.119.165])
        by smtp.gmail.com with ESMTPSA id e127sm271155qkb.34.2016.02.23.17.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 17:43:51 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.492.gd821b20
In-Reply-To: <1456278091-6564-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287158>

=46rom: Felipe Gon=C3=A7alves Assis <felipeg.assis@gmail.com>

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---
 t/t3034-merge-recursive-rename-options.sh | 28 +++++++++++++++++++++++=
+++++
 1 file changed, 28 insertions(+)

diff --git a/t/t3034-merge-recursive-rename-options.sh b/t/t3034-merge-=
recursive-rename-options.sh
index 51c2f87..2479910 100755
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
 test_expect_success 'setup repo' '
 	cat <<-\EOF >3-old &&
 	33a
@@ -195,6 +203,12 @@ test_expect_success 'rename threshold is truncated=
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
@@ -209,6 +223,18 @@ test_expect_success '--find-renames resets thresho=
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
@@ -218,6 +244,8 @@ test_expect_success 'assumption for further tests: =
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
