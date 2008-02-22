From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] builtin-tag.c: remove cruft
Date: Fri, 22 Feb 2008 09:53:09 +0000
Message-ID: <20080222095309.32720.qmail@1e4c13667103ad.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 10:53:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSUbC-000349-MF
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 10:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934975AbYBVJwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 04:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758718AbYBVJwx
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 04:52:53 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:41905 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934934AbYBVJwv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 04:52:51 -0500
Received: (qmail 32721 invoked by uid 1000); 22 Feb 2008 09:53:09 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74711>

After changing builtin-tag.c to use strbuf in fd17f5b (Replace all
read_fd use with strbuf_read, and get rid of it.), the last condition
in do_sign() will always be false, as it's checked already right
above.  So let's remove the cruft.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 builtin-tag.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 4a4a88c..716b4ff 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -236,9 +236,6 @@ static int do_sign(struct strbuf *buffer)
 	if (finish_command(&gpg) || !len || len < 0)
 		return error("gpg failed to sign the tag");
 
-	if (len < 0)
-		return error("could not read the entire signature from gpg.");
-
 	return 0;
 }
 
-- 
1.5.4.2
