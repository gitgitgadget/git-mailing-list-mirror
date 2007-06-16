From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 07/11] Document git rev-list --full-history
Date: Sat, 16 Jun 2007 21:03:43 +0200
Message-ID: <11820206343380-git-send-email-jnareb@gmail.com>
References: <11820206272990-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 16 20:58:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzdU3-0007JN-IM
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 20:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbXFPS6W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 14:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753996AbXFPS6W
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 14:58:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:8389 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876AbXFPS6O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 14:58:14 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1101905ugf
        for <git@vger.kernel.org>; Sat, 16 Jun 2007 11:58:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ln56uX5++ACjWBCS2h+HgxC0/ljTUEe9oMY+tRGEjEfbSeZPgmdyvuPgkel52IPe6HDr4I0j6CqL07BrtvSQ9jAZ4RfHCKg0Eff4sTeVjXqkk6NGosKo2descEAT1RIX5B0CIouK5j1wKk/DcaFlEkoDJXLedFiDF/UFpBft6CQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Nw4pNE33G/eOoFPWUmQs+9ZmZBhxbr3mzsQ4WCDT2lO9Gjz+1QAP0rd5P+jlIsZOjKmo0u/+GRCyLubD6Qx/8WvSiNhYV910fo3xbmWVMp9mCIh0j/YuzjwOGnRj/VhfrVA+YGfsjgBUx99LGoUquQBdBDU5AmQIRT84n+wRlpY=
Received: by 10.78.107.8 with SMTP id f8mr1714730huc.1182020293571;
        Sat, 16 Jun 2007 11:58:13 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id d23sm1356492nfh.2007.06.16.11.58.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jun 2007 11:58:12 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l5GJ3tOf004250;
	Sat, 16 Jun 2007 21:03:55 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l5GJ3s21004249;
	Sat, 16 Jun 2007 21:03:54 +0200
X-Mailer: git-send-email 1.5.2
In-Reply-To: <11820206272990-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50298>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/git-rev-list.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index f5e5786..32cb13f 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -16,6 +16,7 @@ SYNOPSIS
 	     [ \--sparse ]
 	     [ \--no-merges ]
 	     [ \--remove-empty ]
+	     [ \--full-history ]
 	     [ \--not ]
 	     [ \--all ]
 	     [ \--stdin ]
@@ -232,6 +233,14 @@ limiting may be applied.
 
 	Stop when a given path disappears from the tree.
 
+--full-history::
+
+	Show also parts of history irrelevant to current state of a given
+	path. This turns off history simplification, which removed merges
+	which didn't change anything at all at some child. It will still actually
+	simplify away merges that didn't change anything at all into either
+	child.
+
 --no-merges::
 
 	Do not print commits with more than one parent.
-- 
1.5.2
