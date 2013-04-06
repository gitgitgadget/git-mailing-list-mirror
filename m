From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] gitremote-helpers(1): clarify refspec behaviour
Date: Sat,  6 Apr 2013 19:13:41 +0100
Message-ID: <505914600ac7f4afc26f8b29fbece26156c87519.1365272021.git.john@keeping.me.uk>
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 20:18:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOXcq-0006re-4l
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 20:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755356Ab3DFSOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 14:14:00 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:42605 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697Ab3DFSN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 14:13:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id E58926064AA;
	Sat,  6 Apr 2013 19:13:58 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rATbbLKbOPlh; Sat,  6 Apr 2013 19:13:58 +0100 (BST)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id A3B366064DD;
	Sat,  6 Apr 2013 19:13:52 +0100 (BST)
X-Mailer: git-send-email 1.8.2.692.g17a9715
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220258>

The documentation says that "If no 'refspec' capability is advertised,
there is an implied `refspec *:*`" but this is only the case for the
"import" command.

Since there is a comment in transport-helper.c indicating that this
default is for historical reasons, change the documentation to clarify
that a refspec should always be specified.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/gitremote-helpers.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 0c91aba..f506031 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -174,8 +174,8 @@ ref.
 This capability can be advertised multiple times.  The first
 applicable refspec takes precedence.  The left-hand of refspecs
 advertised with this capability must cover all refs reported by
-the list command.  If no 'refspec' capability is advertised,
-there is an implied `refspec *:*`.
+the list command.  If a helper does not need a specific 'refspec'
+capability then it should advertise `refspec *:*`.
 
 'bidi-import'::
 	This modifies the 'import' capability.
-- 
1.8.2.692.g17a9715
