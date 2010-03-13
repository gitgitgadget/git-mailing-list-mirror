From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH/RFC 05/12] docs: differentiate between <tag> and <tagname>
Date: Fri, 12 Mar 2010 23:52:57 -0500
Message-ID: <1268455984-19061-6-git-send-email-lodatom@gmail.com>
References: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 13 05:53:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqJLz-0007Xi-Gi
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 05:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757386Ab0CMExV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 23:53:21 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:41161 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756395Ab0CMExS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 23:53:18 -0500
Received: by qyk9 with SMTP id 9so1844182qyk.5
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 20:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=yD5VqcmbWgaNT2hjPT3p78wODJ2vRlitQAWBTmgW8NM=;
        b=J2wdL52sY//Ay7BjiNjvE2RNzcERz3vigXBSnXNn9CIMgpjR8J0uAh69kglVqZQKKI
         EntMvCuvtHXRVjzgwQFQnF5tJyyCe/gWdb4BiBoKnUP5V9oJDkVnGJZIKcGAM/TNeOOL
         FN4CSxwpqaPGIo9j58VS+pE/6O54mK+oUc6gU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MNgA5TXn+fLyG/NWEP9pJUEKOyErmKZIVoGdJdnfWOYlRUABoV27MpWTwHffQnRkq3
         mCfV9ibyQTaNsj3z8qfgJs7SiiBNUofNj7wFoB7C8wTV7PB7YbMdcopfZ/z9zWhORyGM
         v2XiSas/2EkXc1uwJkj6nBGREvobAu2tiXSAM=
Received: by 10.229.38.69 with SMTP id a5mr2819295qce.15.1268455997449;
        Fri, 12 Mar 2010 20:53:17 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 22sm1694110qyk.10.2010.03.12.20.53.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 20:53:17 -0800 (PST)
X-Mailer: git-send-email 1.7.0.2
In-Reply-To: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142077>

In the documentation and user messages, differentiate between <tag>,
which means an actual annotated tag object, and <tagname>, which is
a revision specifier for refs/tags/<tagname>.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
A similar thing should be done for <head> vs <branch> vs <branchname>.  
The term <head> is not used anywhere to mean what it does in git(1); 
instead, it is used as a more descriptive term for <commit-ish>.  The 
term <branchname> is used for what git(1) describes as <head>, but the 
term <branch> is also used, and I'm not sure what it means.  I'll have 
to look into this.

 Documentation/git-push.txt         |    2 +-
 Documentation/git.txt              |    8 ++++++--
 Documentation/pull-fetch-param.txt |    2 +-
 builtin/push.c                     |    2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 49b6bd9..5445443 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -55,7 +55,7 @@ you can tell git to update the <dst> ref even when the update is not a
 fast-forward.  This does *not* attempt to merge <src> into <dst>.  See
 EXAMPLES below for details.
 +
-`tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
+`tag <tagname>` means the same as `refs/tags/<tagname>:refs/tags/<tagname>`.
 +
 Pushing an empty <src> allows you to delete the <dst> ref from
 the remote repository.
diff --git a/Documentation/git.txt b/Documentation/git.txt
index a635281..f06e4de 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -420,6 +420,10 @@ Identifier Terminology
 <object>::
 	Indicates the object name for any type of object.
 
+<tag>::
+	Indicates a tag object name.  This is an annotated tag object, as
+	opposed to <tagname>, which can refer to any type of object.
+
 <blob>::
 	Indicates a blob object name.
 
@@ -458,9 +462,9 @@ HEAD::
 	indicates the head of the current branch (i.e. the
 	contents of `$GIT_DIR/HEAD`).
 
-<tag>::
+<tagname>::
 	a valid tag 'name'
-	(i.e. the contents of `$GIT_DIR/refs/tags/<tag>`).
+	(i.e. the contents of `$GIT_DIR/refs/tags/<tagname>`).
 
 <head>::
 	a valid head 'name'
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 5dd6e5a..3a947b3 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -66,7 +66,7 @@ is often useful.
 +
 Some short-cut notations are also supported.
 +
-* `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`;
+* `tag <tagname>` means the same as `refs/tags/<tagname>:refs/tags/<tagname>`;
   it requests fetching everything up to the given tag.
 * A parameter <ref> without a colon is equivalent to
   <ref>: when pulling/fetching, so it merges <ref> into the current
diff --git a/builtin/push.c b/builtin/push.c
index f7bc2b2..4227a8e 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -38,7 +38,7 @@ static void set_refspecs(const char **refs, int nr)
 			char *tag;
 			int len;
 			if (nr <= ++i)
-				die("tag shorthand without <tag>");
+				die("tag shorthand without <tagname>");
 			len = strlen(refs[i]) + 11;
 			if (deleterefs) {
 				tag = xmalloc(len+1);
-- 
1.7.0.2
