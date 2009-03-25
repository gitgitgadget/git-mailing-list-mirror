From: newren@gmail.com
Subject: [PATCH] Correct missing SP characters in grammar comment at top of fast-import.c
Date: Wed, 25 Mar 2009 15:22:13 -0600
Message-ID: <1238016133-13509-1-git-send-email-newren@gmail.com>
Cc: spearce@spearce.org, gitster@pobox.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 22:26:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmac0-00014x-Ln
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 22:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600AbZCYVXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 17:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754326AbZCYVX3
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 17:23:29 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:17932 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755430AbZCYVX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 17:23:28 -0400
Received: by wf-out-1314.google.com with SMTP id 29so253779wff.4
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 14:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=JrhyuD6hq5zVdM6YKkK+bKe94tiu3T6K8j3VuMyB2Qg=;
        b=um6ja/a3f1tLN+kqFv7HHcyIPpLGe7wL1qXRyUpgOGSSrjXEww23zHp3BUkx/vVQlv
         A/dQGHExory73Hsey5R3jI2K5YGuS+sqmsuArdOaaNmOogAycSdzMV+YjZ0NGTlCCDr7
         Sgn9KUw9bco1pyJXo3V5Sn1mMvitBrQZTbDu0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=cLcBH12BegPPsAiH5g91E6exhznJmyfYo8ts0yrH/SaMpZ0jpKQVXyVtED1pU81Pav
         p4cvMoaHdIOuwbLDjOgZqXIwzYUMrUpqpVTN0mZaftzthQHreC4D2RwjcBG3eDb+N4Ry
         pLXfwJ6YA+RB6hzZu1vgJUCdGLif0Wp9FFMo4=
Received: by 10.142.173.8 with SMTP id v8mr24885wfe.55.1238016206934;
        Wed, 25 Mar 2009 14:23:26 -0700 (PDT)
Received: from localhost.localdomain (c-69-254-130-124.hsd1.nm.comcast.net [69.254.130.124])
        by mx.google.com with ESMTPS id 28sm16558491wfg.51.2009.03.25.14.23.25
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Mar 2009 14:23:26 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.317.g3d051
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114666>

From: Elijah Newren <newren@gmail.com>


Signed-off-by: Elijah Newren <newren@gmail.com>
---

Some point after discovering this 'bug', I noticed that the documentation
in Documentation/git-fast-import.txt was accurate, so I added a comment at
the top of the file pointing people at that document, as I suspect it is
more likely to be kept up to date.  If my assumption is wrong, or would
prefer different wording, I'm all ears.

 fast-import.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index beeac0d..db44da3 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1,4 +1,5 @@
 /*
+(See Documentation/git-fast-import.txt for maintained documentation.)
 Format of STDIN stream:
 
   stream ::= cmd*;
@@ -18,8 +19,8 @@ Format of STDIN stream:
 
   new_commit ::= 'commit' sp ref_str lf
     mark?
-    ('author' sp name '<' email '>' when lf)?
-    'committer' sp name '<' email '>' when lf
+    ('author' sp name sp '<' email '>' sp when lf)?
+    'committer' sp name sp '<' email '>' sp when lf
     commit_msg
     ('from' sp (ref_str | hexsha1 | sha1exp_str | idnum) lf)?
     ('merge' sp (ref_str | hexsha1 | sha1exp_str | idnum) lf)*
@@ -43,7 +44,7 @@ Format of STDIN stream:
 
   new_tag ::= 'tag' sp tag_str lf
     'from' sp (ref_str | hexsha1 | sha1exp_str | idnum) lf
-    ('tagger' sp name '<' email '>' when lf)?
+    ('tagger' sp name sp '<' email '>' sp when lf)?
     tag_msg;
   tag_msg ::= data;
 
-- 
1.6.0.6
