From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] document submodule sync --recursive
Date: Thu,  3 Dec 2015 11:33:27 -0800
Message-ID: <1449171207-27201-1-git-send-email-sbeller@google.com>
Cc: cederp@opera.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 03 20:39:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Zj1-0003u1-GP
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 20:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbbLCTj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 14:39:27 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34051 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895AbbLCTj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2015 14:39:26 -0500
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Dec 2015 14:39:26 EST
Received: by pfbg73 with SMTP id g73so13447578pfb.1
        for <git@vger.kernel.org>; Thu, 03 Dec 2015 11:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=j9+VW3zFQ2K67uMFl467hpJMzLcwbEfny0V5z0gZAwI=;
        b=iHSkoMsGd8k+F7jMQCK0mdW31q24Q4rHyrGdDW4f71iCwasvepOE/FFcCK9XITDUWB
         ayyXuGklFpzSgEc/4JRXSfbAuIkZT6Swngi0yWeOfZa5D0Nj7LXmXrrsj/p1Bc6rVtrW
         Iko/Hus+O5ApQ8trLq7YVTBjOCtL3kXbQHiyMJNA+SGEU3mLJyetycqsMWg947wPU3pZ
         OSFJEcJDvzwnK//95e8IQPxV3El1k4tBkZzjKwD7X5H98sAVDG7YxdasCB3C/ew52/sD
         mubHLOqVTLt/wI1u+TY/stQoiERBi2PcM2bdjDeTKWIqLX8gA8yWAOsu67lC4Diel/8G
         cEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j9+VW3zFQ2K67uMFl467hpJMzLcwbEfny0V5z0gZAwI=;
        b=Bp7SqG28HQUJpt1e7VBgKQi2rjbBYJ2vmQjjwTpWJFZ5AWUNJImnmtO/1rU/nTwpM6
         2JlQYdrtuXjJXqSit2b9JD9vaEAks6vQfxDZTK+msPNkop93HbWKpIkK3LX3bgaImjon
         /lfs1Asez212ndBZiWCVFk51I7wgzAZzT+OtJasZU4qd1wCCAFWPDmEAjG7X2s/dZXOt
         puWJG6NI4oBh2LYpWY3fjSdKwpzNGdhW2Bzttcj3nghOMWXUxymcZsu3Llkz9YMO+XUp
         HFThzzwTCTjIreUpgUBw/Nxn9k/nPmrMgsItqHvJaqXkTNRmdsZL+d0krILSxsA1TQQk
         CVDA==
X-Gm-Message-State: ALoCoQkBAy2JPXOULaWYZy5wipdZE0XojQ4Gier4PyZL/iA5Juylo6SQT85GVPZuABFacTBPi3+Z
X-Received: by 10.98.7.66 with SMTP id b63mr15507530pfd.19.1449171212993;
        Thu, 03 Dec 2015 11:33:32 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:29b2:2f9f:f400:babe])
        by smtp.gmail.com with ESMTPSA id a27sm12315880pfj.36.2015.12.03.11.33.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 03 Dec 2015 11:33:32 -0800 (PST)
X-Mailer: git-send-email 2.6.1.255.gcc3df29.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281963>

The git-submodule(1) is inconsistent. In the synopsis, it says:

       git submodule [--quiet] sync [--recursive] [--] [<path>...]

The description of the sync does not mention --recursive, and the
description of --recursive says that it is only available for foreach,
update and status.

The option appears to work, so the documentation should be
updated.

Tested-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

 This applies on origin/master.
 
 Thanks Per for reporting,
 Stefan

 Documentation/git-submodule.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index f17687e..cd8d126 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -237,6 +237,9 @@ sync::
 +
 "git submodule sync" synchronizes all submodules while
 "git submodule sync \-- A" synchronizes submodule "A" only.
++
+If `--recursive` is specified, this command will recurse into the
+registered submodules, and update any nested submodules within.
 
 OPTIONS
 -------
@@ -364,7 +367,7 @@ the submodule itself.
 for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
 
 --recursive::
-	This option is only valid for foreach, update and status commands.
+	This option is only valid for foreach, update, status and sync commands.
 	Traverse submodules recursively. The operation is performed not
 	only in the submodules of the current repo, but also
 	in any nested submodules inside those submodules (and so on).
-- 
2.6.1.255.gcc3df29.dirty
