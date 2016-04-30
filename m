From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v15 3/7] t0040-parse-options: improve test coverage
Date: Sun,  1 May 2016 01:33:32 +0530
Message-ID: <1462046616-2582-3-git-send-email-pranit.bauva@gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
Cc: sunshine@sunshineco.com, gitster@pobox.com,
	Pranit Bauva <pranit.bauva@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 22:04:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awb7m-00010z-5L
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 22:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbcD3UER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Apr 2016 16:04:17 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33061 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbcD3UEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2016 16:04:16 -0400
Received: by mail-pf0-f193.google.com with SMTP id e190so17855989pfe.0
        for <git@vger.kernel.org>; Sat, 30 Apr 2016 13:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cVAx2lrYoc6vFhYgb56n++A0f8fEvOE2A2wEjWypeLc=;
        b=BQFJ1t7PCUOPx1Rae6qv6QIir1tyOL3SzxUOZOZJK98nsOBgnS1Jp7Z8rUKwXmtrWA
         NaZgF2kpZgsFBINDbX8a9CDr0JuZX6hkVt7A8ZSQ+YR/CpTCqaxZ9+Wypn7mRiih2GYo
         A8p0NmQv7aLsy+7DpU3HkYZjQoas/OSjh9szLsY2/ChoG/hSX7JK5ap9E1LQ/C4A5GHK
         FseAK8N14MFy2fM4cTXaAShHA0rfc+KECclmPuo7RzFX7V6NJQcUCO1TYyurVJ3flyu3
         th3SOt3pDHETErySg2u8T27VKUjcDujnKQP6SwAh8i6NTE57ZZZH61QQNb8NI94JHk22
         UuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cVAx2lrYoc6vFhYgb56n++A0f8fEvOE2A2wEjWypeLc=;
        b=ICIQZ0vsYIKcKQ250oMMqxj1hyD8ap49AdbTYsH6DQqZwf/HOK4aZl67EqRH1c9S2x
         ch8vEruGqg3DgubOokl7+6+j0h6c51ALjK+DoYRftT6JZeaVuDtShL1ap4DGi8rgEgHy
         FvQ4vVI9DrLfTnF87JJYk75GHKtVqz4Z3JcQ5aStMW4W/OfFHEcEq5aQZR1yprCL5Z1d
         udk6H6ad3kpyaVbKsrmcCy6su/zLV62vFimAypOU/hW5cx3/fmJE+GbVTavSvKt2d0QN
         T1a8WlQuS2SaG6GJ2CxqcYkuo1tQNpnuS5AiV4DkjXlT6zqeWy6iWz5NUAAOg4cKs0XK
         akcA==
X-Gm-Message-State: AOPr4FUChoglciSNbHfHR6F056wT/R6jRIAgMeFiJIIslcZV5Io9aazcWt3xLp3vTf1LLA==
X-Received: by 10.98.0.202 with SMTP id 193mr38605595pfa.120.1462046655906;
        Sat, 30 Apr 2016 13:04:15 -0700 (PDT)
Received: from localhost.localdomain ([27.106.101.191])
        by smtp.gmail.com with ESMTPSA id h85sm33329025pfj.52.2016.04.30.13.04.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Apr 2016 13:04:15 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293129>

Include tests to check for multiple levels of quiet and to check if the
'--no-quiet' option sets it to 0.

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
Link to v14:
 - $gmane/288880

Changes wrt v14:
 - Change the test to use '-q -q -q --no-quiet' instead of just '--no-quiet'
 - Move the test for '--no-verbose' from OPT_COUNTUP patch to this one.

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 t/t0040-parse-options.sh | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 450da45..57fc2a1 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -476,4 +476,61 @@ test_expect_success '--no-list resets list' '
 	test_cmp expect output
 '
 
+cat >expect <<\EOF
+boolean: 0
+integer: 0
+magnitude: 0
+timestamp: 0
+string: (not set)
+abbrev: 7
+verbose: 0
+quiet: 3
+dry run: no
+file: (not set)
+EOF
+
+test_expect_success 'multiple quiet levels' '
+	test-parse-options -q -q -q >output 2>output.err &&
+	test_must_be_empty output.err &&
+	test_cmp expect output
+'
+
+cat >expect <<\EOF
+boolean: 0
+integer: 0
+magnitude: 0
+timestamp: 0
+string: (not set)
+abbrev: 7
+verbose: 0
+quiet: 0
+dry run: no
+file: (not set)
+EOF
+
+test_expect_success '--no-quiet sets quiet to 0' '
+	test-parse-options -q -q -q --no-quiet >output 2>output.err &&
+	test_must_be_empty output.err &&
+	test_cmp expect output
+'
+
+cat >expect <<\EOF
+boolean: 0
+integer: 0
+magnitude: 0
+timestamp: 0
+string: (not set)
+abbrev: 7
+verbose: 0
+quiet: 0
+dry run: no
+file: (not set)
+EOF
+
+test_expect_success '--no-verbose sets verbose to 0' '
+	test-parse-options --no-verbose >output 2> output.err &&
+	test_must_be_empty output.err &&
+	test_cmp expect output
+'
+
 test_done
-- 
2.8.1
