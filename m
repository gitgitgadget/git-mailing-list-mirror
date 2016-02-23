From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH 3/3] t3034: test deprecated interface
Date: Tue, 23 Feb 2016 20:48:12 -0300
Message-ID: <1456271292-4652-4-git-send-email-felipegassis@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Feb 24 00:50:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYMiZ-0001iQ-Sb
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 00:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbcBWXuG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 18:50:06 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35127 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbcBWXuD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 18:50:03 -0500
Received: by mail-qk0-f174.google.com with SMTP id o6so822204qkc.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 15:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zu0NHD9KRZlnZrGSjtjuyaEtcaYCO4tyrefld0s43nc=;
        b=0HscP674P8oi1Ue6cB8+Q2pDyWhvEc7yuDBy7VGoWp2y55q+MqF9TL0IlVjXr5SR7J
         NZtG16KCDhID5wdQW2BGItaspU7ztr6I6JpSSuBX+03OGrRBNCGMkbcHSQYrCPhntNDb
         V0XhwWsUa366L9gmFKassvh+2QIUnSJ7HCHUNHzPeR6b8YHCmxo+q39+Z5Cl4yCcJX/P
         b13695t+cr8vTgGveqIkG29eueC0boAhhGMSt5/KLLejkTEKoZbpDa7sYwEzyxcAbCQr
         EbLCGAQ36FibW5mUQbmWvAFn7eJskwzYfKzsKljyZBlUvZBrk6kflH2ljWIRQzA7uMfF
         FdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=zu0NHD9KRZlnZrGSjtjuyaEtcaYCO4tyrefld0s43nc=;
        b=gSC7k4+WOovqxQUGvqYbhU7zTx9GiY+ZsDQetFPIq4M94x07qrEGfZD7vs9uSZW3Cf
         rl/F7MbfAEYcvjVemP+R6Wgif9KyGwdBBhnIL5wibavajNqvb6Npe8nSLMr0BDcSADa+
         AEYTASz3fryARkvCsSG2fZEHUnSqqvtKLe7lthL7oZQWpzAhpaNR+5nnw8yxQ/WX1re9
         aSXRLXahgkmo0oDCw4kKF7AFh0K19fAs5nOOuP9WdLcNc04xOoIgJBYqXyXNXNMq7jzR
         OvvxoukquQse6ISTQvXGIwblWLqrFplJxaaImnDwOECIAL98ZEe9lT7ZL3x3l5YYcwl0
         cw2g==
X-Gm-Message-State: AG10YOSKoAiqu+n2s0YVnfHUZkLbIsCYzaBtQ7hvRntY4BWmLAtmBiG8i9JMUrlPJSrjqg==
X-Received: by 10.55.74.86 with SMTP id x83mr44756759qka.89.1456271402451;
        Tue, 23 Feb 2016 15:50:02 -0800 (PST)
Received: from traveller.moon (189-19-119-165.dsl.telesp.net.br. [189.19.119.165])
        by smtp.gmail.com with ESMTPSA id w1sm126080qha.3.2016.02.23.15.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 15:50:01 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.492.gd821b20
In-Reply-To: <1456271292-4652-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287149>

=46rom: Felipe Gon=C3=A7alves Assis <felipeg.assis@gmail.com>

--find-renames=3D and --rename-threshold=3D should be aliases.

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---
 t/t3034-merge-recursive-rename-options.sh | 46 +++++++++++++++++++++++=
++++++++
 1 file changed, 46 insertions(+)

diff --git a/t/t3034-merge-recursive-rename-options.sh b/t/t3034-merge-=
recursive-rename-options.sh
index c07a4cb..96d8767 100755
--- a/t/t3034-merge-recursive-rename-options.sh
+++ b/t/t3034-merge-recursive-rename-options.sh
@@ -260,4 +260,50 @@ test_expect_success '--find-renames rejects non-nu=
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
