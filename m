From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 17/19] fixup! reset $sha1 $pathspec: require $sha1 only to be treeish
Date: Wed, 16 Jan 2013 10:00:35 -0800
Message-ID: <1358359235-10213-1-git-send-email-martinvonz@gmail.com>
References: <1358228871-7142-18-git-send-email-martinvonz@gmail.com>
Cc: git@vger.kernel.org, Matt Kraai <kraai@ftbfs.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:01:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvXIT-0006Wx-KL
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 19:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756106Ab3APSAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 13:00:48 -0500
Received: from mail-gh0-f201.google.com ([209.85.160.201]:36376 "EHLO
	mail-gh0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab3APSAo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 13:00:44 -0500
X-Greylist: delayed 130337 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jan 2013 13:00:44 EST
Received: by mail-gh0-f201.google.com with SMTP id z19so192499ghb.2
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 10:00:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=MbNJyEgZV+4GhU1T0Z/7PCGeDgnklViVqDZECVYJgxE=;
        b=iOJD2galUekFUBGssv3H52RR8bSEo05xTdP9k3tr9YGbFw1VyAl3dfraRfrxFbDOFO
         wL4ZPmKRq+4jvV0Cm3Nop+i8efOWE0bXpiBkddJFj3Mz5gVasRWDBtAREk+4aYGvjJZP
         vfVibdJb20h2t27wgyns31GuYGNiJI1PctD2pzH8ai8Thzb+byXCXcL7MzyfbiQ1qLiA
         6eTZd8ojc/H4Aryv1+JUvE3n26u9A0jknemlYu4GUokoDmKQhGJ6KBv/fSdyXMY2mesq
         Xk8WX7hSSdG02EVK3JtHQNtg+mlMCRBspdwbNqSOcBoLKMPMI4OyTFq+fKIGCkPENe6l
         icSQ==
X-Received: by 10.236.165.5 with SMTP id d5mr898559yhl.22.1358359243927;
        Wed, 16 Jan 2013 10:00:43 -0800 (PST)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id x63si484079yhl.2.2013.01.16.10.00.43
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Wed, 16 Jan 2013 10:00:43 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id B7ABD5A4174;
	Wed, 16 Jan 2013 10:00:43 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 60F1E101157; Wed, 16 Jan 2013 10:00:43 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.454.gce43f05
In-Reply-To: <1358228871-7142-18-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQk1PvfP9velfypxEQ1gphvcu0CVjUVn+he1gA6MRdo0s1aCciVewjelN9LIiJrEBNiLyMjST/BqAvgoE4t+bOKxTiPuYZUXoZRFemJAi5EZ9KdEAYXh7hlwHdPFS0K26HwF3wsKvVb3Ufv4L/W863V7h0FEs1YOj/F9ANQuJSDqPckiQffboDwgPfW3hXuY8Mhvyobd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213782>

---

Sorry, I forgot the documentation updates. I hope this looks ok. Can
you squash this in, Junio? Thanks.

I don't think any documentation update is necessary for the "reset on
unborn branch" patch. Let me know if you think differently.


 Documentation/git-reset.txt | 18 +++++++++---------
 builtin/reset.c             |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 978d8da..a404b47 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -8,20 +8,20 @@ git-reset - Reset current HEAD to the specified state
 SYNOPSIS
 --------
 [verse]
-'git reset' [-q] [<commit>] [--] <paths>...
-'git reset' (--patch | -p) [<commit>] [--] [<paths>...]
+'git reset' [-q] [<tree-ish>] [--] <paths>...
+'git reset' (--patch | -p) [<tree-sh>] [--] [<paths>...]
 'git reset' [--soft | --mixed | --hard | --merge | --keep] [-q] [<commit>]
 
 DESCRIPTION
 -----------
-In the first and second form, copy entries from <commit> to the index.
+In the first and second form, copy entries from <tree-ish> to the index.
 In the third form, set the current branch head (HEAD) to <commit>, optionally
-modifying index and working tree to match.  The <commit> defaults to HEAD
-in all forms.
+modifying index and working tree to match.  The <tree-ish>/<commit> defaults
+to HEAD in all forms.
 
-'git reset' [-q] [<commit>] [--] <paths>...::
+'git reset' [-q] [<tree-ish>] [--] <paths>...::
 	This form resets the index entries for all <paths> to their
-	state at <commit>.  (It does not affect the working tree, nor
+	state at <tree-ish>.  (It does not affect the working tree, nor
 	the current branch.)
 +
 This means that `git reset <paths>` is the opposite of `git add
@@ -34,9 +34,9 @@ Alternatively, using linkgit:git-checkout[1] and specifying a commit, you
 can copy the contents of a path out of a commit to the index and to the
 working tree in one go.
 
-'git reset' (--patch | -p) [<commit>] [--] [<paths>...]::
+'git reset' (--patch | -p) [<tree-ish>] [--] [<paths>...]::
 	Interactively select hunks in the difference between the index
-	and <commit> (defaults to HEAD).  The chosen hunks are applied
+	and <tree-ish> (defaults to HEAD).  The chosen hunks are applied
 	in reverse to the index.
 +
 This means that `git reset -p` is the opposite of `git add -p`, i.e.
diff --git a/builtin/reset.c b/builtin/reset.c
index b776867..cb84f1b 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -23,8 +23,8 @@
 
 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
-	N_("git reset [-q] <commit> [--] <paths>..."),
-	N_("git reset --patch [<commit>] [--] [<paths>...]"),
+	N_("git reset [-q] <tree-ish> [--] <paths>..."),
+	N_("git reset --patch [<tree-ish>] [--] [<paths>...]"),
 	NULL
 };
 
-- 
1.8.1.1.454.gce43f05
