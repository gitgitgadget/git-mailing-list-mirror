From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 3/5] utf8: use correct type for values in interval table
Date: Sun, 16 Feb 2014 16:06:04 +0000
Message-ID: <2af4618fe70a02ec92c625eb7f53485ba37827f3.1392565571.git.john@keeping.me.uk>
References: <cover.1392565571.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 16 17:07:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WF4FC-00088c-0p
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 17:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbaBPQGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 11:06:49 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:35807 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbaBPQGd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 11:06:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id CA688CDA590;
	Sun, 16 Feb 2014 16:06:32 +0000 (GMT)
X-Quarantine-ID: <8ap9O5TEQ25z>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ap9O5TEQ25z; Sun, 16 Feb 2014 16:06:32 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 8D385CDA596;
	Sun, 16 Feb 2014 16:06:32 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 8454F161E4CB;
	Sun, 16 Feb 2014 16:06:32 +0000 (GMT)
X-Quarantine-ID: <fhgRv7ztVT5s>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fhgRv7ztVT5s; Sun, 16 Feb 2014 16:06:32 +0000 (GMT)
Received: from river.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 4DAD9161E262;
	Sun, 16 Feb 2014 16:06:27 +0000 (GMT)
X-Mailer: git-send-email 1.9.rc0.187.g6292fff
In-Reply-To: <cover.1392565571.git.john@keeping.me.uk>
In-Reply-To: <cover.1392565571.git.john@keeping.me.uk>
References: <cover.1392565571.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242230>

We treat these as unsigned everywhere and compare against unsigned
values, so declare them using the typedef we already have for this.

While we're here, fix the indentation as well.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 utf8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/utf8.c b/utf8.c
index 24c3c5c..a831d50 100644
--- a/utf8.c
+++ b/utf8.c
@@ -5,8 +5,8 @@
 /* This code is originally from http://www.cl.cam.ac.uk/~mgk25/ucs/ */
 
 struct interval {
-  int first;
-  int last;
+	ucs_char_t first;
+	ucs_char_t last;
 };
 
 size_t display_mode_esc_sequence_len(const char *s)
-- 
1.9.rc0.187.g6292fff
