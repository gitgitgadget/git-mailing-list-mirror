From: Keshav Kini <keshav.kini@gmail.com>
Subject: [PATCH] git-svn.txt: mention how to rebuild rev_map files
Date: Mon, 23 Sep 2013 16:19:05 -0500
Message-ID: <1379971145-8971-1-git-send-email-keshav.kini@gmail.com>
Cc: Eric Wong <normalperson@yhbt.net>,
	Keshav Kini <keshav.kini@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 23:20:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VODYZ-00050g-IJ
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 23:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204Ab3IWVUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 17:20:22 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:43165 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033Ab3IWVT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 17:19:27 -0400
Received: by mail-ob0-f169.google.com with SMTP id wp4so4110553obc.0
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 14:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=hcvkBxLG5Rsq4IIy5Bv7eTDy4XJrvP6ZgtRE4f/m1NQ=;
        b=piRFHCYsDAY18RUAP7jNEQHs5HJxEh+P7Mlx+w1Pu3YFyjwWUIDDgGtkJwxF8zwvov
         HaXWsePCjXwLgvtkvcBmPT/EiMWx7O1FBoerYM9YRDudYV7VxqyqOZzjxIt/+AY4mL6z
         +bZLJvpp9qOOliWcQyoVawMhfVlQ/rryhqF3sZ+GWCZBCNu4qCudkMtM2hod6rtu2Tuu
         BIYKPNN4AujVj0KfcV/5YrouKO1eoXQKchYk1RfViDOajeEfnCaVEfdmVmHopxrMq0/U
         X+aNRFKHpDXPbwijlL4/K8MkRi+onAOdHmjr5trazknY/vjzchILV94vgVUWYlP328Qr
         THwA==
X-Received: by 10.60.65.37 with SMTP id u5mr2110392oes.72.1379971167324;
        Mon, 23 Sep 2013 14:19:27 -0700 (PDT)
Received: from localhost (nat-128-62-40-141.public.utexas.edu. [128.62.40.141])
        by mx.google.com with ESMTPSA id gc8sm16209476obb.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Sep 2013 14:19:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235246>

The man page for `git svn` describes a situation in which "'git svn'
will not be able to rebuild" your .git/svn/**/.rev_map files, but no
mention is made of in what circumstances `git svn` *will* be able to do
so, or how to get `git svn` to do so.

This patch adds some language to the description of the 'fetch' command
to rectify this oversight, and also fixes an AsciiDoc escaping typo.

Signed-off-by: Keshav Kini <keshav.kini@gmail.com>
---
 Documentation/git-svn.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 4dd3bcb..040117a 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -103,9 +103,12 @@ COMMANDS
 
 'fetch'::
 	Fetch unfetched revisions from the Subversion remote we are
-	tracking.  The name of the [svn-remote "..."] section in the
-	.git/config file may be specified as an optional command-line
-	argument.
+	tracking.  If necessary, rebuild the .git/svn/\*\*/.rev_map.*
+	files, given the requisite information exists in commit
+	messages (see the svn.noMetadata config option for more
+	information).  The name of the [svn-remote "..."] section in
+	the .git/config file may be specified as an optional
+	command-line argument.
 
 --localtime;;
 	Store Git commit times in the local timezone instead of UTC.  This
@@ -684,7 +687,7 @@ svn-remote.<name>.noMetadata::
 +
 This option can only be used for one-shot imports as 'git svn'
 will not be able to fetch again without metadata. Additionally,
-if you lose your .git/svn/**/.rev_map.* files, 'git svn' will not
+if you lose your .git/svn/\*\*/.rev_map.* files, 'git svn' will not
 be able to rebuild them.
 +
 The 'git svn log' command will not work on repositories using
-- 
1.8.3.2
