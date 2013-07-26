From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] config doc: quote paths, fixing tilde-interpretation
Date: Fri, 26 Jul 2013 16:12:02 +0530
Message-ID: <1374835322-6452-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 26 12:45:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2fWx-0005fU-9U
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 12:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756819Ab3GZKpr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jul 2013 06:45:47 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:39767 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686Ab3GZKpq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 06:45:46 -0400
Received: by mail-pb0-f51.google.com with SMTP id um15so1893587pbc.24
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 03:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=bq+8LAjxR/FMWwXoJAIzoANLyFlzaThQwNGmOqTjxas=;
        b=SyA9V4Cj10ef8W6vSvWHU+6c+xLwqZ9CxfnedtXFqZ61OUSjCYuf6im2r2ywJxECP5
         KRKvKel2Bdt/g1EyRUdrGvSNQW7pkjf4HUcMQngS/ZI3gU6cP0l7obxhYsy5LO/HRWEx
         EQOboQtl9QScuGv/+ScyweLkxuzvxWPWXERLBUWFDgFVY9QY8bibKmr1xW3pgl+6NZxh
         6hhiHcZWvFZ/ijSENk4Af83dAxy+ml1+7p2k115+p+0xo2IOhZ88jPQNo5kV7hwooXcs
         OfKkmxDMFS5/K2DfFdZs8lh9Myop86vUdQaxjgfORNbLq/CGq8ajPpMnv50uKXMnIKB1
         hcWw==
X-Received: by 10.67.22.69 with SMTP id hq5mr32284839pad.174.1374835545986;
        Fri, 26 Jul 2013 03:45:45 -0700 (PDT)
Received: from localhost.localdomain ([122.164.210.116])
        by mx.google.com with ESMTPSA id nv6sm59477444pbc.6.2013.07.26.03.45.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Jul 2013 03:45:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.820.ge3d4493.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231178>

The --global section of git-config(1) currently reads like:

  For writing options: write to global /.gitconfig file rather than the
                                       ^
				       start tilde

  repository .git/config, write to $XDG_CONFIG_HOME/git/config file if
  this file exists and the/.gitconfig file doesn=E2=80=99t.
                          ^
			  end tilde

Instead of tilde (~) being interpreted literally, asciidoc subscripts
the text between the two tildes.  To fix this problem, use backticks (`=
)
to quote all the paths in the file uniformly, just like config.txt does=
=2E

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Candidate for maint?

 Documentation/git-config.txt | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.tx=
t
index 34b0894..2dbe486 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -96,29 +96,31 @@ OPTIONS
 	names are not.
=20
 --global::
-	For writing options: write to global ~/.gitconfig file rather than
-	the repository .git/config, write to $XDG_CONFIG_HOME/git/config file
-	if this file exists and the ~/.gitconfig file doesn't.
+	For writing options: write to global `~/.gitconfig` file
+	rather than the repository `.git/config`, write to
+	`$XDG_CONFIG_HOME/git/config` file if this file exists and the
+	`~/.gitconfig` file doesn't.
 +
-For reading options: read only from global ~/.gitconfig and from
-$XDG_CONFIG_HOME/git/config rather than from all available files.
+For reading options: read only from global `~/.gitconfig` and from
+`$XDG_CONFIG_HOME/git/config` rather than from all available files.
 +
 See also <<FILES>>.
=20
 --system::
-	For writing options: write to system-wide $(prefix)/etc/gitconfig
-	rather than the repository .git/config.
+	For writing options: write to system-wide
+	`$(prefix)/etc/gitconfig` rather than the repository
+	`.git/config`.
 +
-For reading options: read only from system-wide $(prefix)/etc/gitconfi=
g
+For reading options: read only from system-wide `$(prefix)/etc/gitconf=
ig`
 rather than from all available files.
 +
 See also <<FILES>>.
=20
 --local::
-	For writing options: write to the repository .git/config file.
+	For writing options: write to the repository `.git/config` file.
 	This is	the default behavior.
 +
-For reading options: read only from the repository .git/config rather =
than
+For reading options: read only from the repository `.git/config` rathe=
r than
 from all available files.
 +
 See also <<FILES>>.
@@ -218,9 +220,9 @@ $(prefix)/etc/gitconfig::
=20
 $XDG_CONFIG_HOME/git/config::
 	Second user-specific configuration file. If $XDG_CONFIG_HOME is not s=
et
-	or empty, $HOME/.config/git/config will be used. Any single-valued
+	or empty, `$HOME/.config/git/config` will be used. Any single-valued
 	variable set in this file will be overwritten by whatever is in
-	~/.gitconfig.  It is a good idea not to create this file if
+	`~/.gitconfig`.  It is a good idea not to create this file if
 	you sometimes use older versions of Git, as support for this
 	file was added fairly recently.
=20
--=20
1.8.3.3.820.ge3d4493.dirty
