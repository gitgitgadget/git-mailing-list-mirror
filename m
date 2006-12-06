X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: [PATCH] cvs-migration document: make the need for "push" more
 obvious
Date: Wed, 06 Dec 2006 15:52:26 +0100
Message-ID: <4576D92A.80307@xs4all.nl>
References: <4574AC9E.3040506@gmail.com> <4574BF70.8070100@lilypond.org> <45760545.2010801@gmail.com> <20061206.105251.144349770.wl@gnu.org> <Pine.LNX.4.63.0612061325320.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 14:52:30 +0000 (UTC)
Cc: gpermus@gmail.com, hanwen@lilypond.org, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <Pine.LNX.4.63.0612061325320.28348@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33464>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gry8H-0005Sx-3h for gcvg-git@gmane.org; Wed, 06 Dec
 2006 15:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760667AbWLFOwU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 09:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760669AbWLFOwU
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 09:52:20 -0500
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:3632 "EHLO
 smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1760667AbWLFOwU (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 09:52:20 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr4.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kB6EqGnE074075 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Wed, 6 Dec 2006 15:52:17 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin escreveu:
> It really is an important concept to grasp for people coming
> from CVS. Even if it is briefly mentioned, it is not obvious
> enough to sink in.

I think the goal is laudable, but IMO it would be better to shorten
the document rather adding more text.

here is my try
 
From 980a0ca1b274e1219c24c3138f95e42206c72875 Mon Sep 17 00:00:00 2001
From: Han-Wen Nienhuys <hanwen@lilypond.org>
Date: Wed, 6 Dec 2006 15:50:13 +0100
Subject: [PATCH] another try at  rephrasing cvs doc.


Signed-off-by: Han-Wen Nienhuys <hanwen@xs4all.nl>
---
 Documentation/cvs-migration.txt |   34 +++++++++++++++++++++++-----------
 1 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
index 6812683..3270c57 100644
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -6,24 +6,36 @@ this document is to put you on the road to recovery, by helping you
 convert an existing cvs repository to git, and by showing you how to use a
 git repository in a cvs-like fashion.
 
-Some basic familiarity with git is required.  This
-link:tutorial.html[tutorial introduction to git] should be sufficient.
-
-First, note some ways that git differs from CVS:
+Git differs from CVS:
 
   * Commits are atomic and project-wide, not per-file as in CVS.
 
-  * Offline work is supported: you can make multiple commits locally,
+  * Branching is fast and easy.
+
+  * GIT is a distributed version control system:
+    This has several consequences:
+
+    - Every working tree contains a repository with a full copy of the
+    project history.
+    
+    - Offline work is supported: you can create revisions locally,
     then submit them when you're ready.
 
-  * Branching is fast and easy.
+    Hence, there is a difference between creating a revision
+    (the "commit" command) and submitting it (the "push" command).
+
+    - No repository is inherently more important than
+    any other.
+    
+    Of course, a project may still designate one central repository as
+    the True Master that contributors synchronize with.
+
+    See below for details.
 
-  * Every working tree contains a repository with a full copy of the
-    project history, and no repository is inherently more important than
-    any other.  However, you can emulate the CVS model by designating a
-    single shared repository which people can synchronize with; see below
-    for details.
+Some basic familiarity with git is required.  This
+link:tutorial.html[tutorial introduction to git] should be sufficient.
 
+    
 Importing a CVS archive
 -----------------------
 
-- 
1.4.4.1.gc9922-dirty


-- 
