From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 07/23] Documentation/git-worktree: add EXAMPLES section
Date: Mon,  6 Jul 2015 13:30:44 -0400
Message-ID: <1436203860-846-8-git-send-email-sunshine@sunshineco.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:33:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAGn-0000Hv-9g
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455AbbGFRd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:33:26 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36085 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565AbbGFRbg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:36 -0400
Received: by iecvh10 with SMTP id vh10so118195516iec.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rDLMEQzImoifYvmDVp4wpYKxgKuhUkF91piluuun4F8=;
        b=ToxI3iBj7eS9hkqbADII/f5mHrywBjXXSfZJ9nrALKZKmVyAxwPs3IHqrtjQiLradC
         2W7KGRlrzErEsqT1iEeRgirS58/PXpNjGyjdrcqRN4sXOEHeSVoGsT53DaxR5J2994fZ
         LxcsnG5bnzd6TgvjkyUnzJRCbwBgpTglK+fMHuql/CpHDXo2BDhU8aW4QMzD3Y/XhC/4
         Ch97T6pl5HGaHYyLk94V47jqZl4x7ecIC1/CVPv1IW0Eq7selPVix3YQPkPdi4HyFblT
         HYXeVfpEhMTAmqK1jrZMDtYA3eLRlvFBf9PHmclO4C5TMCMkv9DQ5vnRSnDYJtmi4fy/
         PBCA==
X-Received: by 10.50.43.227 with SMTP id z3mr73430997igl.22.1436203895764;
        Mon, 06 Jul 2015 10:31:35 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.34
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:35 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273432>

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 0385e9a..6afff1e 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -105,6 +105,28 @@ to `/path/main/.git/worktrees/test-next` then a file named
 `test-next` entry from being pruned.  See
 linkgit:gitrepository-layout[5] for details.
 
+EXAMPLES
+--------
+You are in the middle of a refactoring session and your boss comes in and
+demands that you fix something immediately. You might typically use
+linkgit:git-stash[1] to store your changes away temporarily, however, your
+worktree is in such a state of disarray (with new, moved, and removed files,
+and other bits and pieces strewn around) that you don't want to risk
+disturbing any of it. Instead, you create a temporary linked worktree to
+make the emergency fix, remove it when done, and then resume your earlier
+refactoring session.
+
+------------
+$ git branch emergency-fix master
+$ git checkout --to ../temp emergency-fix
+$ pushd ../temp
+# ... hack hack hack ...
+$ git commit -a -m 'emergency fix for boss'
+$ popd
+$ rm -rf ../temp
+$ git worktree prune
+------------
+
 BUGS
 ----
 Multiple checkout support for submodules is incomplete. It is NOT
-- 
2.5.0.rc1.197.g417e668
