From: Chris Packham <cp.packham@gmail.com>
Subject: [gitbook PATCH] add notes on re-writing history
Date: Tue,  2 Mar 2010 15:07:14 -0800
Message-ID: <1267571234-13565-1-git-send-email-judge.packham@gmail.com>
References: <a038bef51003021336g3ab0b4f6vba2738a18a92dd36@mail.gmail.com>
Cc: git@vger.kernel.org, jnareb@gmail.com, bkorb@gnu.org,
	Chris Packham <judge.packham@gmail.com>
To: schacon@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 03 00:10:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmbE4-0003hV-MC
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 00:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046Ab0CBXJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 18:09:45 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:48645 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347Ab0CBXJn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 18:09:43 -0500
Received: by fg-out-1718.google.com with SMTP id l26so75091fgb.1
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 15:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=1bLdI6hxgnrWjrsnFz+Uqw1BZeJ6wCL5nX0CcHx75qY=;
        b=UQ2QEVs6uIi7DogZXTSDiF8HJQK9jAVKVh3Pd7yPuP31JGtVWSSiMwl12G+kQKOm35
         gCXlyEAcasYIq4t2TuK9U7/PUgAKZChnwqdjNxETY4dhWXb2XbJ1LnH+wDB+4r95O2rM
         kDHLWw0h8BCXHqajfLEvoA+70QJ8t+1dRK2Do=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YgsbEQEI21lIHfyPDaUbDhraF64/VnjH00WaPYdHo4iUrG2/lb4ffCI4EyJMsM7mSv
         sBkOUKBLieveublcnVG4Bj8UmihHv7NgNVWl/FkuDEDwrUO6YFVJ9Dyx+ouWUQBJXf/+
         oC546+jJv3xoeChNtnnXsSsHE4qtVNzYup91I=
Received: by 10.86.236.26 with SMTP id j26mr10723954fgh.77.1267571382075;
        Tue, 02 Mar 2010 15:09:42 -0800 (PST)
Received: from localhost.localdomain (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id 15sm3284923fxm.12.2010.03.02.15.09.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Mar 2010 15:09:41 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <a038bef51003021336g3ab0b4f6vba2738a18a92dd36@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141420>

Add a note on the consequences of re-writing a repositories history in
"Undoing in Git - Reset, Checkout and Revert/Fixing a mistake by
modifying a commit" and "Modifying your History".
---
I didn't sucessfully get the ruby gems installed on openSUSE 11.2 (problems
installing ultraviolet) so if someone who does have a working environment could
have a look and maybe do a bit of polishing that would be helpful.

 .../0_ Redoing_Git_Reset_and_Revert.markdown       |    6 +++++-
 .../0_Changing_History.markdown                    |   20 ++++++++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/text/21_Redoing_Git_Reset_and_Revert/0_ Redoing_Git_Reset_and_Revert.markdown b/text/21_Redoing_Git_Reset_and_Revert/0_ Redoing_Git_Reset_and_Revert.markdown
index b37245d..8b876f2 100644
--- a/text/21_Redoing_Git_Reset_and_Revert/0_ Redoing_Git_Reset_and_Revert.markdown	
+++ b/text/21_Redoing_Git_Reset_and_Revert/0_ Redoing_Git_Reset_and_Revert.markdown	
@@ -43,7 +43,11 @@ fundamentally different ways to fix the problem:
     never do this if you have already made the history public;
     git does not normally expect the "history" of a project to
     change, and cannot correctly perform repeated merges from
-    a branch that has had its history changed.
+    a branch that has had its history changed. If you do re-write
+    a repositories history anyone else who has cloned the
+    repository will need manually correct the problem on their
+    clone see the "RECOVERING FROM UPSTREAM REBASE" section
+    in linkgit:git-rebase[1].
 
 #### Fixing a mistake with a new commit ####
 
diff --git a/text/25_Changing_Your_History/0_Changing_History.markdown b/text/25_Changing_Your_History/0_Changing_History.markdown
index b569f46..160c838 100644
--- a/text/25_Changing_Your_History/0_Changing_History.markdown
+++ b/text/25_Changing_Your_History/0_Changing_History.markdown
@@ -1,6 +1,22 @@
 ## Modifying your History ##
 
-Interactive rebasing is a good way to modify individual commits.
+There are several ways to re-write the history of a repository. All of
+these can cause problems for commits that have already been pushed to a
+remote repository. If you do re-write a repositories history anyone else
+who has cloned the repository will need manually correct the problem on
+their clone see the "RECOVERING FROM UPSTREAM REBASE" section in
+linkgit:git-rebase[1].
 
-linkgit:git-filter-branch[1] is a good way to edit commits en masse.
+The simplest method is to use "git commit --amend" to modify the last commit.
+This is useful to correct a commit message, or make a simple update to a
+commit before pushing.
+
+Interactive rebasing is a good way to modify multiple commits. Commits can
+be combined by squashing, changed by editing or removed entirely.
+
+linkgit:git-filter-branch[1] is a good way to edit commits en masse. This is
+useful where a whole component needs to be removed from a project. For
+example removing a subsystem which is licenced under an incompatible
+opensource licence. Or it can be used to alter the commit authorship without
+changing the code.
 
-- 
1.7.0.1
