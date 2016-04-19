From: santiago@nyu.edu
Subject: [PATCH v7 2/6] t7030: test verifying multiple tags
Date: Tue, 19 Apr 2016 13:47:17 -0400
Message-ID: <1461088041-19264-3-git-send-email-santiago@nyu.edu>
References: <1461088041-19264-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 19:47:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asZkW-0002Ju-Rn
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 19:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933392AbcDSRrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 13:47:40 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:32859 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581AbcDSRr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 13:47:29 -0400
Received: by mail-qk0-f173.google.com with SMTP id n63so6857016qkf.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 10:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F8OBHOiYUCnGlta2b6AkPULnYS1UWvUxOS+qw7qkXdw=;
        b=qTWw5TK0CVJEDkkSLw/wPaGQ2ecNGacCMSDog0SYnSeI/cvx1m78kyfVlYrmA1qFwT
         zWJfgdjn40eY0k1BXx2Jfg8FzueL9y0A24qVxMW/WMRH5rGdRxpjgUW3P5ASYZmeoVLP
         fi70ll5HfQ3LRz7qty14ydUYxML8tlI/4MknPsOZKlojf9igDHWlc2ZR5jYrvnOP7Uq4
         XkfJaEbZnhXFL3jgiKFzV/ZDL9lUP3LG0wlwBaz2s/AmHyEDcTf6zu7e04uC7S/CLrKO
         7yYVGSI5w8kYRSCj1m8JgRkqnQqP6LP7LpFKFb/CcFksd4R4uYQ7IwB70Z5akRoDy2hC
         xFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F8OBHOiYUCnGlta2b6AkPULnYS1UWvUxOS+qw7qkXdw=;
        b=O+gH7V1wadcccrIHF7FxI+Dc+7WApRBkhEUzZtkuAJffVOAR58GEJ/HFn0WfBLimgV
         2guVMrO8yz+FpA0oW4IAuUttDtHVb8EYicOsZayY94dx7AQtfoVtP+aYbds6y+b/6K3j
         3ald6/ySqdHfu422LLJbNkWoK2g1Aa6eHqVnHA6lQBsLOUUJfLJ2CW30tLRDefe4YImf
         KA4u4fK6PejsXL2xCEl0xZy9BNdOJ3G5n7qhK0n5ricJWJf82C6XcO3QZqM8NoZTfebk
         qGD1AfqHiVhlvDVPtVIZ/BuIMtyGpzKOPJ3/XTVxlpQy6jLtg0k68oqPMNJqfbpu4l89
         Bfig==
X-Gm-Message-State: AOPr4FX5RQNmFaaqnzQgS+HorydqGPLIsGxel2dzLglm3clvEwUywfvOunsAGp6eS1u0nPIs
X-Received: by 10.55.18.217 with SMTP id 86mr5332820qks.99.1461088048259;
        Tue, 19 Apr 2016 10:47:28 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id w184sm11073374qkw.4.2016.04.19.10.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 10:47:27 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461088041-19264-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291888>

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
