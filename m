From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH] Documentation/git-rerere: document 'remaining' command
Date: Tue,  6 Mar 2012 13:21:52 +0100
Message-ID: <1331036512-7626-1-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Cc: martin.von.zweigbergk@gmail.com, gitster@pobox.com,
	Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 13:22:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4tPV-00006i-KM
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 13:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030515Ab2CFMW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 07:22:28 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60355 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030501Ab2CFMW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 07:22:27 -0500
Received: by eaaq12 with SMTP id q12so1791394eaa.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 04:22:26 -0800 (PST)
Received-SPF: pass (google.com: domain of  designates 10.213.35.79 as permitted sender) client-ip=10.213.35.79;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of  designates 10.213.35.79 as permitted sender) smtp.mail=
Received: from mr.google.com ([10.213.35.79])
        by 10.213.35.79 with SMTP id o15mr3249173ebd.224.1331036546867 (num_hops = 1);
        Tue, 06 Mar 2012 04:22:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=rSsp74x/aKZkffIAWRfl4nP/6FlOQJYtCXhT5YrUIxU=;
        b=CRVyqnc2Wq5ZPpHMb33yLBiLcQroWpR7YWJnl6xs3lrchLUcGsSKz5lCuVW9Qz3awp
         OLOVnUCSLBJXG0sN/uNu53d7CrpiPXbaEBw0StD1Kt2FJFsa42ZHgNBBAs2vM6OP52aX
         P/zScvWQxDThSOuo+i5S07gllCVRm7b95IBSGpAEiy0/tEgJFuH3b4k5AnFuDt/NDVKg
         gZvsDBO4mdsPzqmHo8YtKPt3ejDB1nrWjMTmxTO02TP+OWy3I73MADR634QakCaqPBzk
         adpK/oRe/CWOXir38CQ1RPLFqSC/PYjyjeCWRXmgMmvspcXSIJ44d+V945FiQ2fKPJnj
         wOmA==
Received: by 10.213.35.79 with SMTP id o15mr2468397ebd.224.1331036546582;
        Tue, 06 Mar 2012 04:22:26 -0800 (PST)
Received: from localhost.localdomain (wlan-145-94-169-074.wlan.tudelft.nl. [145.94.169.74])
        by mx.google.com with ESMTPS id u9sm73860656eem.11.2012.03.06.04.22.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 04:22:26 -0800 (PST)
X-Mailer: git-send-email 1.7.5.4
X-Gm-Message-State: ALoCoQnTxCuvKmUjPCysC7Up7iIPhmVOf1pGnnTAUg1pGdYRcRk1SBd0DrC84qo9iR8lRt8AXBYj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192339>

From: Vincent van Ravesteijn <vfr@lyx.org>

This adds the 'remaining' command to the documentation of
'git rerere'. This command was added in ac49f5ca (Feb 16 2011;
Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>) but
it was never documented.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 Documentation/git-rerere.txt |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index a6253ba..b75d34b 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -8,7 +8,7 @@ git-rerere - Reuse recorded resolution of conflicted merges
 SYNOPSIS
 --------
 [verse]
-'git rerere' ['clear'|'forget' <pathspec>|'diff'|'status'|'gc']
+'git rerere' ['clear'|'forget' <pathspec>|'diff'|'remaining'|'status'|'gc']
 
 DESCRIPTION
 -----------
@@ -53,6 +53,14 @@ useful for tracking what has changed while the user is resolving
 conflicts.  Additional arguments are passed directly to the system
 'diff' command installed in PATH.
 
+'remaining'::
+
+Like 'diff', but this only prints the unresolved filenames. This
+includes the files for which rerere tracks the resolution (as shown
+by 'git rerere status'), but also the files for which the conflicts
+cannot be tracked by rerere, e.g. files with conflicts that do not 
+have both our side and their side like "we modified, they deleted".
+
 'status'::
 
 Like 'diff', but this only prints the filenames that will be tracked
-- 
1.7.5.4
