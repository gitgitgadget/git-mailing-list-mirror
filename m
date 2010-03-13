From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH/RFC 06/12] docs: clarify <object>, <commit>, <tree-ish>, etc
Date: Fri, 12 Mar 2010 23:52:58 -0500
Message-ID: <1268455984-19061-7-git-send-email-lodatom@gmail.com>
References: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 13 05:54:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqJMh-0007qX-0z
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 05:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933405Ab0CMExg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 23:53:36 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:41701 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757302Ab0CMExT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 23:53:19 -0500
Received: by mail-qy0-f179.google.com with SMTP id 9so1844178qyk.5
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 20:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qLI9rZHx0JUNMSv4ogWhlEPuiFRUYooAHyGEyNZY+AE=;
        b=Emdb1doHeV63iLQG/weOYwWfUQACmMPVD6cIaLPZfIwXMGObdrMH27Xjrf5vYZLi6H
         JchAeV9+PEpBrHqvBBzYngTTMq1at4FCoYR3K3VgE32nTZddRRtWOyVMsDfbreKkXtgb
         rd+AbCa92UUPB5rHzGlH1kol/jUdp2OLCQcOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dMsOYV6s7+NbUJllAXX3sPKqtLEsyCmTJAROnr8T5kisrosggrwNJ+VWAPehubEeuu
         m1a1IaG6pc0IVXqCJw4qix0YOGAMPNEADiNRiEdIQ3A1Bw09d0II6dZFyyTZ207sKxZ/
         7q2tjjJ2q22SL4MYUiZGqF1iRvtkklBIjEYrE=
Received: by 10.224.7.145 with SMTP id d17mr3207378qad.125.1268455998172;
        Fri, 12 Mar 2010 20:53:18 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 22sm1694110qyk.10.2010.03.12.20.53.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 20:53:17 -0800 (PST)
X-Mailer: git-send-email 1.7.0.2
In-Reply-To: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142080>

In git(1), give more precise definitions of <object>, <commit>,
<tree-ish>, and so on.  In particular, differentiate <object> (which may
take generic revision specifiers) from <sha1>, which only accepts
a 40-character hex SHA-1 ID.

Also note that <rev> is another way to say <commit-ish>.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/git.txt |   38 +++++++++++++++++++++-----------------
 1 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index f06e4de..55f3842 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -418,32 +418,36 @@ Identifier Terminology
 	Abbreviated or symbolic identifiers cannot be used.
 
 <object>::
-	Indicates the object name for any type of object.
+	Indicates the object name for any type of object.  Symbolic name or
+	abbreviated SHA-1 identifiers may be used (see "SPECIFYING REVISIONS"
+	in linkgit:git-rev-parse[1] for details).
 
 <tag>::
-	Indicates a tag object name.  This is an annotated tag object, as
+	Indicates a tag-type <object>.  This is an annotated tag object, as
 	opposed to <tagname>, which can refer to any type of object.
 
-<blob>::
-	Indicates a blob object name.
+<commit>::
+	Indicates a commit-type <object>.
 
 <tree>::
-	Indicates a tree object name.
-
-<commit>::
-	Indicates a commit object name.
+	Indicates a tree-type <object>.
 
-<tree-ish>::
-	Indicates a tree, commit or tag object name.  A
-	command that takes a <tree-ish> argument ultimately wants to
-	operate on a <tree> object but automatically dereferences
-	<commit> and <tag> objects that point at a <tree>.
+<blob>::
+	Indicates a blob-type <object>.
 
+<rev>::
 <commit-ish>::
-	Indicates a commit or tag object name.  A
-	command that takes a <commit-ish> argument ultimately wants to
-	operate on a <commit> object but automatically dereferences
-	<tag> objects that point at a <commit>.
+	Indicates a <commit>, or a <tag> that points at a <commit-ish>.
+	A command that takes a <commit-ish> argument ultimately wants to
+	operate on a commit object but automatically dereferences objects
+	until it finds a commit.
+	A <rev> is another name for a <commit-ish>.
+
+<tree-ish>::
+	Indicates a <tree>, or a <tag> or <commit> that points at a
+	<tree-ish>.  A command that takes a <tree-ish> argument ultimately
+	wants to operate on a tree object but automatically dereferences
+	objects until it finds a tree.
 
 <type>::
 	Indicates that an object type is required.
-- 
1.7.0.2
