From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/5] git-diff.txt: fix ordering of the [--no-index] form
Date: Wed, 24 Apr 2013 22:03:36 +0530
Message-ID: <1366821216-20868-6-git-send-email-artagnon@gmail.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 24 18:33:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV2dk-0007d0-Ry
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 18:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756893Ab3DXQdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 12:33:49 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:45597 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756435Ab3DXQds (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 12:33:48 -0400
Received: by mail-pa0-f42.google.com with SMTP id kl13so1298862pab.1
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 09:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=jgj8juS+Kz0nshGaKtp2ZLKs8eee/qv6k7SlLQfaqYs=;
        b=CZq125chGNBX1CrA2XH/fUsJ1XVXbHO0fMdDQN/XG2Wpk6MtF+6rDsPsUh8AGx4M0T
         +ZaGJcVv3pVa7PPBQdUVrAb4F51tUXdkIkkKPMNewgethgahg0EOanv6sy63ItAw9p9e
         xScCUtivcsx+hpBgCpdVve1+RR9bvWaa6Nia1xOHfLsdwkJcpJsxE3PfY/+1YevZoguy
         FwQxfZd5JiDrav73JUlsuoW1cnr/T36AtWKtK0thoUQjZIp6xYY15ev+Ez8I15lZGnLD
         JqDamfL9625QG6UyvpOjarth6wTp8ecxY211GIbtgdnAQT+pO1q/SuK2QcLZzdmOM+Dw
         JUyg==
X-Received: by 10.68.252.227 with SMTP id zv3mr49401261pbc.14.1366821227823;
        Wed, 24 Apr 2013 09:33:47 -0700 (PDT)
Received: from localhost.localdomain ([122.164.164.124])
        by mx.google.com with ESMTPSA id dr4sm3646798pbb.19.2013.04.24.09.33.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 09:33:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.502.g2d60b5c
In-Reply-To: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222264>

The SYNOPSIS lists the [--no-index] form as the last item, but the
DESCRIPTION lists it as a natural extension of the first form.  Fix
this with a reordering.  Also since the DESCRIPTION breaks up the
first form in the SYNOPSIS into two different forms (one without the
optional [<commit>], and the other with it), reorder to make these two
forms appear together.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-diff.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 291e250..1f2f681 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -10,12 +10,12 @@ SYNOPSIS
 --------
 [verse]
 'git diff' [options] [<commit>] [[--] [<path>...]]
+'git diff' [options] [--no-index] [[--] <path> <path>]
 'git diff' [options] --cached [<commit>] [[--] [<path>...]]
 'git diff' [options] <blob> <blob>
 'git diff' [options] <commit> <commit> [[--] [<path>...]]
 'git diff' [options] <commit>..<commit> [[--] [<path>...]]
 'git diff' [options] <commit>\...<commit> [[--] [<path>...]]
-'git diff' [options] [--no-index] [[--] <path> <path>]
 
 DESCRIPTION
 -----------
@@ -35,6 +35,14 @@ If exactly two paths are given and at least one points outside
 the current repository, 'git diff' will compare the two files /
 directories. This behavior can be forced by --no-index.
 
+'git diff' [options] <commit> [[--] [<path>...]]::
+
+	This form is to view the changes you have in your
+	working tree relative to the named <commit>.  You can
+	use HEAD to compare it with the latest commit, or a
+	branch name to compare with the tip of a different
+	branch.
+
 'git diff' [options] --cached [<commit>] [[--] [<path>...]]::
 
 	This form is to view the changes you staged for the next
@@ -45,14 +53,6 @@ directories. This behavior can be forced by --no-index.
 	<commit> is not given, it shows all staged changes.
 	--staged is a synonym of --cached.
 
-'git diff' [options] <commit> [[--] [<path>...]]::
-
-	This form is to view the changes you have in your
-	working tree relative to the named <commit>.  You can
-	use HEAD to compare it with the latest commit, or a
-	branch name to compare with the tip of a different
-	branch.
-
 'git diff' [options] <blob> <blob>::
 
 	This form is to view the differences between the raw
-- 
1.8.2.1.502.g2d60b5c
