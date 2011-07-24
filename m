From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 9/9] bisect: add documentation for --ignore-checkout-failure option.
Date: Sun, 24 Jul 2011 15:57:54 +1000
Message-ID: <1311487074-25070-10-git-send-email-jon.seymour@gmail.com>
References: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 07:58:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkriK-0007w3-O8
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 07:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab1GXF6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 01:58:35 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:56778 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab1GXF63 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 01:58:29 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so6276942pzk.1
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 22:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iQl1fROQO766bvx6WIrSzkMJRIhCfV+K6O9ylpjNfF4=;
        b=Xep1uuIXD0PT7yUJA7gBFKAsGz2licuEPgs2Kk9Vcutqt6FzJUCN+Dhgfu92pxv/M3
         S2H1nnx03IAnMdH/fZAsV50Y+ibmROy7/a+1vO7K4kPNO8CmqnBC59V+d7U7gyK1kRBL
         RqwJKkmNOnXArddXKNkJn1ocZqh+pbzIk33XA=
Received: by 10.142.240.19 with SMTP id n19mr1961241wfh.34.1311487109098;
        Sat, 23 Jul 2011 22:58:29 -0700 (PDT)
Received: from localhost.localdomain ([124.169.157.32])
        by mx.google.com with ESMTPS id b4sm3359124pba.43.2011.07.23.22.58.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Jul 2011 22:58:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g96e0b.dirty
In-Reply-To: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177726>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-bisect.txt |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index ab60a18..f7412a1 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -17,7 +17,7 @@ The command takes various subcommands, and different options depending
 on the subcommand:
 
  git bisect help
- git bisect start [<bad> [<good>...]] [--] [<paths>...]
+ git bisect start [--ignore-checkout-failure] [<bad> [<good>...]] [--] [<paths>...]
  git bisect bad [<rev>]
  git bisect good [<rev>...]
  git bisect skip [(<rev>|<range>)...]
@@ -263,6 +263,17 @@ rewind the tree to the pristine state.  Finally the script should exit
 with the status of the real test to let the "git bisect run" command loop
 determine the eventual outcome of the bisect session.
 
+OPTIONS
+-------
+--ignore-checkout-failure::
++
+This option, specified on the "git bisect start" subcommand, causes
+bisect to ignore checkout failures during the bisection process. This allows
+git bisect to be used on repositories that contain damaged trees. The
+user should expect that, in cases where checkout fails, the detached
+HEAD refers to the trial commit, but the working tree and index
+may differ from that commit.
+
 EXAMPLES
 --------
 
-- 
1.7.6.347.g96e0b.dirty
