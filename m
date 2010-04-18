From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC PATCH 2/2] SubmittingPatches: Complete rewrite of section 0
Date: Mon, 19 Apr 2010 01:24:55 +0530
Message-ID: <1271620467-sup-7590@kytes>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 18 21:57:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3ac9-00009C-PC
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 21:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442Ab0DRT5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 15:57:05 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39464 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab0DRT5B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 15:57:01 -0400
Received: by gyg13 with SMTP id 13so2265385gyg.19
        for <git@vger.kernel.org>; Sun, 18 Apr 2010 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-type:cc:subject:from
         :to:date:message-id:user-agent:content-transfer-encoding;
        bh=oSEVSdY5CNxsqTThAq4m338pkUpgy5quatjkfxryvrs=;
        b=uMOryLGpreNKaV2O36s9CW14BIB6MM4KjPpCKy8XH2/zaTzKfcOBYnZWu1Zfo9WUdb
         AGi2D1OHRixbmM2sh6SpaDQTg1IVq5k88GHAnc3RmK9msUUaoL74YIy3dN6n8bbHXfmm
         ulQIWE+bgPSEiSlPEthzqpvZVBY6xDoHeET+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:cc:subject:from:to:date:message-id:user-agent
         :content-transfer-encoding;
        b=vbfcoW3CLAJrltmSsueQXo46gK5A9WOi5K/pnsZTITfJ9farMtheOF4XGc2W02Xy0n
         ZENM21/jmt84hqsvuJKDO0b6AJ4g1ohHbfRZ4l3SnsfIc/4/b1x7WiFWmBGizymLI7dW
         KMpRwJP5S7N3PChyTgJV2QsUlTx80qfHatKyE=
Received: by 10.101.190.12 with SMTP id s12mr10631544anp.177.1271620618701;
        Sun, 18 Apr 2010 12:56:58 -0700 (PDT)
Received: from localhost ([203.110.240.41])
        by mx.google.com with ESMTPS id 21sm4232217iwn.7.2010.04.18.12.56.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Apr 2010 12:56:57 -0700 (PDT)
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145242>

This rewrite makes section 0 less verbose and more readable. It is
intended to be squashed into the previous commit.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/SubmittingPatches |   55 ++++++++++++++++++--------------------
 1 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index a90155c..0b62b62 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -55,35 +55,32 @@ thousand times smaller ;-).  So here is only the relevant bits.
 
 (0) Decide what to base your work on.
 
-The general principle is always to base your work on the oldest branch
-that your change is relevant to.
-
- - A fix for a bug that has been with git from older releases should be
-   included in both the upcoming feature release and the current
-   maintenance release.  Try to base your work on the 'maint' branch.  A
-   work to kill a bug that is in 'master' but not in 'maint' should be
-   based on 'master'.
-
- - A fix for a bug that is not yet in 'master' is the best bug to kill.
-   If you can find the topic that introduces the regression, base your
-   work on the tip of the topic.  "log --first-parent master..pu" would be
-   a good way to find the tips of topic branches.
-
- - A new feature should be based on the 'master' branch in general.
-
- - If your new feature depends on some other topics that are not in
-   'master' yet, and if it relies only on one topic, base your work on the
-   tip of that topic.  If it depends on too many topics that are not in
-   'master', you can privately start working on 'next' or even 'pu' and
-   send out your patches for discussion, but it is possible that your
-   maintainer may ask you to wait and rebase your changes on 'master'
-   after some of the larger topics your topic depends on graduate to
-   'master'.
-
- - Base corrections and enhancements on a topic that are not in 'master'
-   yet but already merged to 'next' on the tip of the topic.  If the topic
-   has not been merged to 'next', it is Ok to add a note that the patch is
-   a trivial fix and can be squashed into the series.
+In general, always base your work on the oldest branch that your
+change is relevant to.
+
+ - A bugfix should be based on 'maint' in general. If the bug is not
+   present in 'maint', base it on 'master'. For a bug that's not yet
+   in 'master', find the topic that introduces the regression, and
+   base your work on the tip of the topic.
+
+ - A new feature should be based on 'master' in general. If the new
+   feature depends on a topic that is in 'pu', but not in 'master',
+   base your work on the tip of that topic.
+
+ - Corrections and enhancements to a topic not yet in 'master' should
+   be based on the tip of that topic. If the topic has not been merged
+   to 'next', it's alright to add a note to squash minor corrections
+   into the series.
+
+ - In the exceptional case that a new feature depends on several topics
+   not in 'master', start working on 'next' or 'pu' privately and send
+   out patches for discussion. Before the final merge, you may have to
+   wait until some of the dependent topics graduate to 'master', and
+   rebase your work.
+
+To find the tip of a topic branch, run "git log --first-parent
+master..pu" and look for the merge commit. The grandparent of this
+commit is the tip of the topic branch.
 
 (1) Make separate commits for logically separate changes.
 
-- 
1.7.0.4
