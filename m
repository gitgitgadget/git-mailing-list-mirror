From: Linus Arver <linusarver@gmail.com>
Subject: [PATCH v2 4/7] Documentation: git-init: --separate-git-dir: clarify
Date: Fri,  8 Aug 2014 10:29:17 -0700
Message-ID: <1407518960-6203-5-git-send-email-linusarver@gmail.com>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
 <1407518960-6203-1-git-send-email-linusarver@gmail.com>
Cc: Steven Drake <sdrake@xnet.co.nz>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Johan Herland <johan@herland.net>,
	Linus Arver <linusarver@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 19:30:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFo0D-00031k-Am
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 19:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbaHHRah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 13:30:37 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:65106 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbaHHRaf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 13:30:35 -0400
Received: by mail-yh0-f43.google.com with SMTP id 29so4331623yhl.2
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 10:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o6P9/JaXqZzZiqEoWr+54xph7fMltUHp24lN+uKY9LA=;
        b=U1FuONI5Oi1uFUKuqapAg/VQWZKD9e6Gia8XAu4QwmYjZPTv0319Ll4icpomhfqLdM
         mbb3ARd2p1gyW/bPBVuX8iFKN15TILN9MyZ01HlQvQ7Fk3BKvS0//W2Vvxk6mqOHdt6q
         SLehyYqYyhXt4PDgfuz6ocEnylHtoQNCchVeudmDDeB726Ce5pMvl+LuRrA+WtyRjKO3
         Ft3aI63oseOMYcNtXnIDEwia3kGKHZ7SWJTi/1sRwIgLlFJRlNeYlrOZnvvUXhVG45nN
         GXWWY/IbUa34JJkP7VJV7QGVhtf4I3PBU+TzG45j89Nh8Jc7lYSIxnktBFfHpFrfTvF/
         fJgg==
X-Received: by 10.236.206.115 with SMTP id k79mr16559902yho.1.1407519035038;
        Fri, 08 Aug 2014 10:30:35 -0700 (PDT)
Received: from k0.localdomain (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id u47sm6776458yhm.35.2014.08.08.10.30.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 10:30:34 -0700 (PDT)
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1407518960-6203-1-git-send-email-linusarver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255054>

Use shorter sentences to describe what actually happens. We describe
what the term "Git symbolic link" actually means.

Also, we separate out the description of the behavioral change upon
reinitialization into its own paragraph.

Signed-off-by: Linus Arver <linusarver@gmail.com>
---
 Documentation/git-init.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 6ffe721..3f4e46a 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -57,12 +57,12 @@ DIRECTORY" section below.)
 
 --separate-git-dir=<git dir>::
 
-Instead of initializing the repository where it is supposed to be,
-place a filesytem-agnostic Git symbolic link there, pointing to the
-specified path, and initialize a Git repository at the path. The
-result is Git repository can be separated from working tree. If this
-is reinitialization, the repository will be moved to the specified
-path.
+Instead of initializing the repository as a directory to either `$GIT_DIR` or
+`./.git/`, create a text file there containing the path to the actual
+repository.  This file acts as filesystem-agnostic Git symbolic link to the
+repository.
++
+If this is reinitialization, the repository will be moved to the specified path.
 
 --shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
 
-- 
2.0.4
