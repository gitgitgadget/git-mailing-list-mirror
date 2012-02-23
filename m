From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 1/4] strbuf: improve strbuf_get*line documentation
Date: Thu, 23 Feb 2012 10:42:21 +0100
Message-ID: <d5522f8d1154321804cb60fb4f53d538242ead88.1329988335.git.trast@student.ethz.ch>
References: <cover.1329988335.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 10:42:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0VCB-0007ak-5a
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 10:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316Ab2BWJmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 04:42:33 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:28309 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754463Ab2BWJmb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 04:42:31 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 23 Feb
 2012 10:42:27 +0100
Received: from thomas.inf.ethz.ch (129.132.209.211) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 23 Feb
 2012 10:42:29 +0100
X-Mailer: git-send-email 1.7.9.1.430.g4998543
In-Reply-To: <cover.1329988335.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.209.211]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191338>

strbuf_getline() was not documented very clearly, though a reader
familiar with getline() would not have had any questions about it.
strbuf_getwholeline() was not documented at all.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/technical/api-strbuf.txt |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index afe2759..cc6db5e 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -255,8 +255,16 @@ same behaviour as well.
 
 `strbuf_getline`::
 
-	Read a line from a FILE* pointer. The second argument specifies the line
-	terminator character, typically `'\n'`.
+	Read a line from a FILE*. The second argument specifies the
+	line terminator character, typically `'\n'`.  Reading stops
+	after the terminator or at EOF.  The terminator is removed
+	from the buffer before returning.  Returns 0 unless there was
+	nothing left before EOF, in which case it returns `EOF`.
+
+`strbuf_getwholeline`::
+	
+	Like `strbuf_getline`, but keeps the trailing terminator (if
+	any) in the buffer.
 
 `stripspace`::
 
-- 
1.7.9.1.430.g4998543
