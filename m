From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 5/6] t6300: add test for "raw" date format
Date: Tue,  1 Sep 2015 22:55:43 +0100
Message-ID: <2d0ac9bc81db744897f32de6ef1ebec69fdaae9f.1441144343.git.john@keeping.me.uk>
References: <20150901083731.GE30659@serenity.lan>
 <cover.1441144343.git.john@keeping.me.uk>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 23:57:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWtYE-0006S2-Dg
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 23:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493AbbIAV5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 17:57:06 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:45036 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbbIAV5E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 17:57:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 0E46CCDA5CD;
	Tue,  1 Sep 2015 22:57:04 +0100 (BST)
X-Quarantine-ID: <dK-lz+-3Od2k>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dK-lz+-3Od2k; Tue,  1 Sep 2015 22:57:03 +0100 (BST)
Received: from river.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 97D66CDA594;
	Tue,  1 Sep 2015 22:56:51 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
In-Reply-To: <cover.1441144343.git.john@keeping.me.uk>
In-Reply-To: <cover.1441144343.git.john@keeping.me.uk>
References: <cover.1441144343.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277048>

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/t6300-for-each-ref.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 9e0096f..2e76ca9 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -196,6 +196,10 @@ test_expect_success 'Check format "rfc2822" date fields output' '
 	test_date rfc2822 "Tue, 4 Jul 2006 01:18:43 +0200" "Tue, 4 Jul 2006 01:18:44 +0200" "Tue, 4 Jul 2006 01:18:45 +0200"
 '
 
+test_expect_success 'Check format "raw" date fields output' '
+	test_date raw "1151968723 +0200" "1151968724 +0200" "1151968725 +0200"
+'
+
 test_expect_success 'Check format of strftime date fields' '
 	echo "my date is 2006-07-04" >expected &&
 	git for-each-ref \
-- 
2.5.0.466.g9af26fa
