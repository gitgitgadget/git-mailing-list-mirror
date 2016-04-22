From: santiago@nyu.edu
Subject: [PATCH v8 2/6] t7030: test verifying multiple tags
Date: Fri, 22 Apr 2016 10:52:01 -0400
Message-ID: <1461336725-29915-3-git-send-email-santiago@nyu.edu>
References: <1461336725-29915-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 16:52:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atcRV-0005C3-EL
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 16:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754387AbcDVOwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 10:52:15 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35631 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878AbcDVOwN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 10:52:13 -0400
Received: by mail-qg0-f46.google.com with SMTP id f74so54495222qge.2
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 07:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F8OBHOiYUCnGlta2b6AkPULnYS1UWvUxOS+qw7qkXdw=;
        b=bRP4Smdyu3or/BB3MoHqMjUAKS2xaTrOdTaEIq7RsnSfNo3GhC53/HahEKF8Asv8ca
         C+mqhDyFwi+gqwXt7YXcE+LjUtmLq854Jgk8wLeXx8s3Y+a6TY/KqpTTQ78BS+Lt+zSk
         XsUhNOb9uZEscsL7dwzBvucRYyVxFRRV2uMn4ueO+wwlA4MeeQwlYl3FKjQaJl3c/4+L
         czdd87ZXthf5GNjya+gS6/sGMIrqPG1FMHmCYsW31/TAKHmR6vSYRvWDrGftOVSsi3yD
         U9Xfwfc2qEEfVX3nJfibxJC+GUCYtphdaIauAjRZWEM0rxJGnANKHCvZxCUL1PeYJwq5
         3ATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F8OBHOiYUCnGlta2b6AkPULnYS1UWvUxOS+qw7qkXdw=;
        b=ZDQrbx3FFurQBa7uQtLe6SBwrzTAxqk9dXVMyLVQpwlwRgPEbo44c5buuHRs/o0uo0
         urMYOLutgsJ05aO3RlmWWvB96+Ktc6pq4jg7GhPnSNGjaTmVRFXnVD6s7F6lrquDscDh
         LBcpJJQLIXbijNyeCq+A/I17vKTUOgLvM1fDR+1wbApUB/GYm/+f9nIK1/R3df3vfTCq
         848CiPb6EzpPVNj78D3x2e2aS6v6AXQ0eE5jaK93TFx1uAyd15v22lWnIrxh7rX0xUbE
         cftO7HrXcoE8/d+cDgkBezoqAbXVVQktPeFzW78cMLCPxG+ND8/oYQ5yhCSMVivLPoaf
         RpXw==
X-Gm-Message-State: AOPr4FXtsV1EMwVzwe9o+Yi7N7M3KmSxyKGxRUp1hxKR9WwCz57frxMcmH2qceqFHuI9nAhh
X-Received: by 10.140.249.87 with SMTP id u84mr23150176qhc.80.1461336732575;
        Fri, 22 Apr 2016 07:52:12 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-18.NATPOOL.NYU.EDU. [216.165.95.7])
        by smtp.gmail.com with ESMTPSA id s67sm2583005qgs.48.2016.04.22.07.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 07:52:12 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461336725-29915-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292223>

From: Santiago Torres <santiago@nyu.edu>

The verify-tag command supports multiple tag names to verify, but
existing tests only test for invocation with a single tag.

Add a test invoking it with multiple tags.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Santiago Torres <santiago@nyu.edu>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7030-verify-tag.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 4608e71..07079a4 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -112,4 +112,17 @@ test_expect_success GPG 'verify signatures with --raw' '
 	)
 '
 
+test_expect_success GPG 'verify multiple tags' '
+	tags="fourth-signed sixth-signed seventh-signed" &&
+	for i in $tags
+	do
+		git verify-tag -v --raw $i || return 1
+	done >expect.stdout 2>expect.stderr.1 &&
+	grep "^.GNUPG:." <expect.stderr.1 >expect.stderr &&
+	git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
+	grep "^.GNUPG:." <actual.stderr.1 >actual.stderr &&
+	test_cmp expect.stdout actual.stdout &&
+	test_cmp expect.stderr actual.stderr
+'
+
 test_done
-- 
2.8.0
