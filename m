From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/6] completion: add common options for rev-parse
Date: Sun,  2 Jun 2013 19:33:38 +0530
Message-ID: <1370181822-23450-3-git-send-email-artagnon@gmail.com>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 02 16:06:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uj8vC-0000qM-Da
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 16:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792Ab3FBOGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 10:06:06 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:58942 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302Ab3FBOGD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 10:06:03 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so450353pad.37
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RyKw5Ptf6cxEnbcWRTacHjt6Dgjep0K6oPL8Jln/JII=;
        b=HXI+M7V+lp3hFYbaR+ZweC4qGyDyzBBaNFc/lRz2I2/8tEwZ0RVFtRSX+8RQfa3NXK
         AhJ7EyZSVCyv2fFJXbIu4BDhIvtReEC5yzUcRJwQnplB/4Wo9iQ+EO4BuvkFEyYROty5
         Pg52/XlxaLCSD/aafCEuHJGwT2aeF1ksbDV2YNQgYcchHqLmVuYZRoSUzjqy5Ku7Dv6N
         89JwqJPUzMfQYFnk2LWxa39Yat5Xz73ZFs6CWA36Xyv+GTXaYEVxmXFwHca+UW6HJDm5
         sxb2pUB41qfLPS14BtgV0waDJXekz7TaV37/pM5Y0+g+o4i83zrsqL8LzqYnTuACgsrI
         qKWg==
X-Received: by 10.66.226.233 with SMTP id rv9mr21010055pac.155.1370181962754;
        Sun, 02 Jun 2013 07:06:02 -0700 (PDT)
Received: from localhost.localdomain ([122.164.162.188])
        by mx.google.com with ESMTPSA id aj2sm55150689pbc.1.2013.06.02.07.06.01
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Jun 2013 07:06:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.457.g2410d5e
In-Reply-To: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226153>

Add support for completing 'git rev-parse'.  List only the options that
are likely to be used on the command-line, as opposed to scripts.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1c35eef..139f48e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2299,6 +2299,17 @@ _git_reset ()
 	__gitcomp_nl "$(__git_refs)"
 }
 
+_git_rev_parse ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp "--show-toplevel --is-inside-work-tree --symbolic-full-name --verify"
+		return
+		;;
+	esac
+	__gitcomp_nl "$(__git_refs)"
+}
+
 _git_revert ()
 {
 	case "$cur" in
-- 
1.8.3.457.g2410d5e
