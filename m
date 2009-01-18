From: Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 02/12] Some cleanup in get_refs_via_curl()
Date: Sun, 18 Jan 2009 09:04:27 +0100
Message-ID: <1232265877-3649-3-git-send-email-mh@glandium.org>
References: <20090118074911.GB30228@glandium.org>
 <1232265877-3649-1-git-send-email-mh@glandium.org>
 <1232265877-3649-2-git-send-email-mh@glandium.org>
Cc: johannes.schindelin@gmx.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 18 09:06:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOSfj-0001kf-AK
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 09:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757837AbZARIEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 03:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758641AbZARIEq
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 03:04:46 -0500
Received: from vuizook.err.no ([85.19.221.46]:42441 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756867AbZARIEp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 03:04:45 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LOSe6-0002ES-0k; Sun, 18 Jan 2009 09:04:43 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LOSe5-0000yD-AO; Sun, 18 Jan 2009 09:04:37 +0100
X-Mailer: git-send-email 1.6.1.141.gb32a
In-Reply-To: <1232265877-3649-2-git-send-email-mh@glandium.org>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106149>


Signed-off-by: Mike Hommey <mh@glandium.org>
---
 transport.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/transport.c b/transport.c
index 56831c5..6919ff1 100644
--- a/transport.c
+++ b/transport.c
@@ -508,6 +508,8 @@ static struct ref *get_refs_via_curl(struct transport *transport)
 		free(ref);
 	}
 
+	http_cleanup();
+	free(refs_url);
 	return refs;
 }
 
-- 
1.6.1.141.gb32a
