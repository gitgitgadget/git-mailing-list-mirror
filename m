From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v16 3/7] t0040-parse-options: improve test coverage
Date: Thu,  5 May 2016 15:19:58 +0530
Message-ID: <1462441802-4768-4-git-send-email-pranit.bauva@gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
 <1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
Cc: sunshine@sunshineco.com, szeder@ira.uka.de, git@vger.kernel.org,
	Pranit Bauva <pranit.bauva@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 05 11:51:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayFwH-0007if-H2
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 11:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757053AbcEEJvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 05:51:19 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36011 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756669AbcEEJvS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 05:51:18 -0400
Received: by mail-pf0-f181.google.com with SMTP id c189so37265049pfb.3
        for <git@vger.kernel.org>; Thu, 05 May 2016 02:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E+Er7JDueaSc7UVeUjyI2qfOXoV8YCzgq5CHeHOo1Oo=;
        b=l42GiOHdAxhE0QSbgAWrd62FPnvKmzad/osfHyaw+GmjD/1mZM4Fto29me/CKrFvQq
         ntlKVfS/Ds/jNM85zRrdsyvlDLA3DaBOLvSSP/F6PWViZudqe0QqGULymwUMf4Gg50Um
         rhgPrHLtOUlV+Pyd6AT0lcBklLWDbP/v7HMpRecW132NNDG4KHfGPmcEKZXJdsguNlh8
         EaRtQFroeuiv41zduZ/wOl+OlOSRVIKt5VI8SDa+WvMVsrycYxBPrC/1MjlwhSqAvpqz
         mU3c+MX3JwVCDiCcjWCUHI9/lET0XDSHEnj03uNnYJu6qKi8csz3ji+xTimfN51wE/+I
         L0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E+Er7JDueaSc7UVeUjyI2qfOXoV8YCzgq5CHeHOo1Oo=;
        b=P/T6B+VPsVk4pLWOxNGHS6egq/zs/fQcKeBAXfpeywWqtCkbg5OeMcimv79tDVVrQw
         ohPBeEw4W1dhCX86GJmCh5cMSEBh2HGWC5/7O7cvt2HAOVCw2yno2QCYQkoYfQErNxTK
         +y6ackZaRAu473vYmDGmvjE84iYY1U7Q6aK3Hgu++yABQGkAyWH9Y33dqRYhkN4hAvI2
         GXUS3qkkViuoWJaxvh5fmN3l0gBn15MrkCA/LY+EfOx+YRVm8yRVizGNA9NlM5sLXNzN
         dZz8R2vpr6SFZLwg3RlJaFvdGXmuswmDHyLL0WPX3+DGi8t4jC50qNQSqVFCzCP55V4h
         DP4g==
X-Gm-Message-State: AOPr4FXZ6pbR2I4yRN9LqclYVedLW4h9EIZq9AgIvinRCqAGGuibbPn2WVdTapRp+ARdvA==
X-Received: by 10.98.72.16 with SMTP id v16mr19337640pfa.12.1462441877193;
        Thu, 05 May 2016 02:51:17 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id zn12sm12255111pab.14.2016.05.05.02.51.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 May 2016 02:51:16 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293638>

Include tests to check for multiple levels of quiet and to check the
behavior of '--no-quiet'.

Include tests to check for multiple levels of verbose and to check the
behavior of '--no-verbose'.

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
 t/t0040-parse-options.sh | 114 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 450da45..717a514 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -476,4 +476,118 @@ test_expect_success '--no-list resets list' '
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
+verbose: 3
+quiet: 0
+dry run: no
+file: (not set)
+EOF
+
+test_expect_success 'multiple verbose levels' '
+	test-parse-options -v -v -v >output 2>output.err &&
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
+test_expect_success '--no-quiet sets --quiet to 0' '
+	test-parse-options --no-quiet >output 2>output.err &&
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
+test_expect_success '--no-quiet resets multiple -q to 0' '
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
+	test-parse-options --no-verbose >output 2>output.err &&
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
+test_expect_success '--no-verbose resets multiple verbose to 0' '
+	test-parse-options -v -v -v --no-verbose >output 2>output.err &&
+	test_must_be_empty output.err &&
+	test_cmp expect output
+'
+
 test_done
-- 
2.8.1
