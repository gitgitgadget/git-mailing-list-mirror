From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 07/11] t6300: add test for "raw" date format
Date: Thu,  3 Sep 2015 22:48:57 +0100
Message-ID: <c0c0a1c5eaa36388bba38b604e2fbcae30677b86.1441316394.git.john@keeping.me.uk>
References: <cover.1441144343.git.john@keeping.me.uk>
 <cover.1441316394.git.john@keeping.me.uk>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 23:50:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXcPC-0001DP-Is
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 23:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757578AbbICVur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 17:50:47 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:52192 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757532AbbICVur (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 17:50:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 67114CDA590;
	Thu,  3 Sep 2015 22:50:46 +0100 (BST)
X-Quarantine-ID: <bS+u5qqTYc15>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bS+u5qqTYc15; Thu,  3 Sep 2015 22:50:45 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 79D6C86600B;
	Thu,  3 Sep 2015 22:50:31 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
In-Reply-To: <cover.1441316394.git.john@keeping.me.uk>
In-Reply-To: <cover.1441316394.git.john@keeping.me.uk>
References: <cover.1441316394.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277268>

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/t6300-for-each-ref.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 0bf709b..6afcff6 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -215,6 +215,10 @@ test_expect_success 'Check format "rfc2822" date fields output' '
 		"Mon, 3 Jul 2006 17:18:45 +0200"
 '
 
+test_expect_success 'Check format "raw" date fields output' '
+	test_date raw "1151939923 +0200" "1151939924 +0200" "1151939925 +0200"
+'
+
 test_expect_success 'Check format of strftime date fields' '
 	echo "my date is 2006-07-03" >expected &&
 	git for-each-ref \
-- 
2.5.0.466.g9af26fa
