From: David Barr <david.barr@cordelta.com>
Subject: [PATCH] fixup! fast-import: let importers retrieve blobs
Date: Tue, 30 Nov 2010 10:48:28 +1100
Message-ID: <1291074508-18926-1-git-send-email-david.barr@cordelta.com>
References: <20101128194501.GD19998@burratino>
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 02:20:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNEtG-0007cL-Dy
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 02:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024Ab0K3BUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 20:20:10 -0500
Received: from [119.15.97.146] ([119.15.97.146]:60218 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755993Ab0K3BUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 20:20:09 -0500
X-Greylist: delayed 619 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Nov 2010 20:20:09 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 6CC7FC04F;
	Tue, 30 Nov 2010 12:10:02 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aql6IvkSJLOz; Tue, 30 Nov 2010 12:09:59 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.127])
	by mailhost.cordelta (Postfix) with ESMTP id 3A76DC045;
	Tue, 30 Nov 2010 12:09:59 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <20101128194501.GD19998@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162458>

Signed-off-by: David Barr <david.barr@cordelta.com>
---
 fast-import.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 4dfea07..aa8f260 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2752,6 +2752,7 @@ static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
 		strbuf_reset(&line);
 		strbuf_addf(&line, "%s missing\n", sha1_to_hex(sha1));
 		cat_blob_write(line.buf, line.len);
+		strbuf_release(&line);
 		free(buf);
 		return;
 	}
@@ -2764,6 +2765,7 @@ static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
 	strbuf_addf(&line, "%s %s %lu\n", sha1_to_hex(sha1),
 						typename(type), size);
 	cat_blob_write(line.buf, line.len);
+	strbuf_release(&line);
 	cat_blob_write(buf, size);
 	cat_blob_write("\n", 1);
 	free(buf);
-- 
1.7.3.2.846.gf4b062
