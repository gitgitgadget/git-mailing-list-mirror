From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/10] t3404 (rebase -i): move comment to description
Date: Sun, 31 Oct 2010 02:39:51 -0500
Message-ID: <20101031073951.GI11483@burratino>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-16-git-send-email-newren@gmail.com>
 <20101031014654.GC29456@burratino>
 <7vr5f73umz.fsf@alter.siamese.dyndns.org>
 <20101031072640.GA11483@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	avarab@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 08:40:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCSWO-0006qy-Lv
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 08:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab0JaHkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 03:40:04 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51828 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508Ab0JaHkB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 03:40:01 -0400
Received: by ywc21 with SMTP id 21so299451ywc.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 00:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SVcxr1j4UTZl39juCpb1YDVYujcoConWyFWZUa+XzWA=;
        b=W2P7tPJK9QysPTEguLSqp0cT60ght948AHBWppyn0ONBlF3TBn0/8bHN54obYY+wRD
         JSc/jZO/OeWzGRMWWto+9n+CxvzoHoonevGX+4onEWwXwqbqqk5eKC0ylKnen+Coyuhk
         rH89Av59yoFJUA5AqeaO11m3Pvw/f/xt3rxV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NvHQHVXoEFCopR7HcO3MpJV6arU/Q4JqXSj5VwoCLThV1x0NhR1aVy724yCc3YcWW9
         h2nFcKsRucQMjQ7vvuihPed13s1l4E7/mq7DCi5VXyrCbtTPCYl/UA0HKxPGc7qNmz3d
         j+uM4Mjww2m15u+DBDJZ3MGbixWTo+xKuNgmA=
Received: by 10.151.109.3 with SMTP id l3mr25670241ybm.56.1288510800722;
        Sun, 31 Oct 2010 00:40:00 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id p38sm160664ybk.4.2010.10.31.00.39.58
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 00:39:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101031072640.GA11483@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160427>

Add a comment describing the setup in t3404 to its --help output.

This should make it easier to decide where to put new functions
without disrupting the flow of the file or obstructing the description
of the test setup.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t3404-rebase-interactive.sh |   35 +++++++++++++++++------------------
 1 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index b372314..4097a2d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -7,6 +7,23 @@ test_description='git rebase interactive
 
 This test runs git rebase "interactively", by faking an edit, and verifies
 that the result still makes sense.
+
+Initial setup:
+
+     one - two - three - four (conflict-branch)
+   /
+ A - B - C - D - E            (master)
+ | \
+ |   F - G - H                (branch1)
+ |     \
+ |\      I                    (branch2)
+ | \
+ |   J - K - L - M            (no-conflict-branch)
+  \
+    N - O - P                 (no-ff-branch)
+
+ where A, B, D and G all touch file1, and one, two, three, four all
+ touch file "conflict".
 '
 . ./test-lib.sh
 
@@ -14,27 +31,9 @@ that the result still makes sense.
 
 set_fake_editor
 
-# Set up the repository like this:
-#
-#     one - two - three - four (conflict-branch)
-#   /
-# A - B - C - D - E            (master)
-# | \
-# |   F - G - H                (branch1)
-# |     \
-# |\      I                    (branch2)
-# | \
-# |   J - K - L - M            (no-conflict-branch)
-#  \
-#    N - O - P                 (no-ff-branch)
-#
-# where A, B, D and G all touch file1, and one, two, three, four all
-# touch file "conflict".
-#
 # WARNING: Modifications to the initial repository can change the SHA ID used
 # in the expect2 file for the 'stop on conflicting pick' test.
 
-
 test_expect_success 'setup' '
 	test_commit A file1 &&
 	test_commit B file1 &&
-- 
1.7.2.3.557.gab647.dirty
