From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] improve documentation on mirroring
Date: Mon, 22 Feb 2010 14:22:38 +0800
Message-ID: <1266819758-5572-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 08:44:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjRnP-0002jU-L3
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 07:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323Ab0BVG30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 01:29:26 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:43704 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab0BVG3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 01:29:25 -0500
Received: by qw-out-2122.google.com with SMTP id 8so418903qwh.37
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 22:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Lsa24fvLSkc8Fol8YpbQvLjpiNVRuZwlsCVhaM8ktdQ=;
        b=YfkiYIkeCY7uFvNBVg1tphnX59akJPwzo5uB9m6KlVjP01rFvyx+zBn9y1ucmPG6Y1
         GDQjdAs8Akt233ahRg9psonpzjIdjnDyKwJuvnAsZZaovgY/VozSSB8ybdcFrCx+wZji
         3bYb0Cqh8d+f9WJ40Mggu7rMm3TM69lYPtcwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=uXv0DBEN2OdYwLEECjIqnzKT48Fst2K4f8vxkeZqW2zVNDjyTFgj+W94b6SmM2MJZn
         HkZ3p14gWzPh4dl3XMy+Qt08svyygyP4l5bg8SOBP/Irx6THG/IITRD2pReyCRcR5vuV
         Nps2bKJ/3I8HvF/5wW0+LjtZ77SXWYlKt00gU=
Received: by 10.224.91.129 with SMTP id n1mr5648654qam.186.1266819771007;
        Sun, 21 Feb 2010 22:22:51 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 7sm8102340qwf.54.2010.02.21.22.22.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Feb 2010 22:22:49 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140639>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

  Details on mirroring are distributed across various manpages, and I
  found myself grepping for it - definitely a bad sign.

 Documentation/config.txt     |    2 ++
 Documentation/git-clone.txt  |    2 ++
 Documentation/git-remote.txt |   10 +++++-----
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 664de6b..e87c06e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1479,6 +1479,8 @@ remote.<name>.push::
 remote.<name>.mirror::
 	If true, pushing to this remote will automatically behave
 	as if the `\--mirror` option was given on the command line.
+	(See the `\--mirror` option to the `add` command to
+	linkgit:git-remote[1] for more details on mirroring.)

 remote.<name>.skipDefaultUpdate::
 	If true, this remote will be skipped by default when updating
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 88ea624..3bd57d2 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -128,6 +128,8 @@ objects from the source repository into a pack in the cloned repository.

 --mirror::
 	Set up a mirror of the remote repository.  This implies `--bare`.
+	(See the `\--mirror` option to the `add` command to
+	linkgit:git-remote[1] for more details on mirroring.)

 --origin <name>::
 -o <name>::
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 3fc599c..c2c25fd 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -60,11 +60,11 @@ multiple branches without grabbing all branches.
 With `-m <master>` option, `$GIT_DIR/remotes/<name>/HEAD` is set
 up to point at remote's `<master>` branch. See also the set-head command.
 +
-In mirror mode, enabled with `\--mirror`, the refs will not be stored
-in the 'refs/remotes/' namespace, but in 'refs/heads/'.  This option
-only makes sense in bare repositories.  If a remote uses mirror
-mode, furthermore, `git push` will always behave as if `\--mirror`
-was passed.
+With `\--mirror`, the fetch refspec for this remote is setup such that
+fetched refs are not stored in the 'refs/remotes/' namespace (the default),
+but in 'refs/heads/'.  The configuration variable `remote.<name>.mirror` is
+also set to true, so that `git push` will always behave as if `\--mirror`
+was passed.  This option only makes sense in bare repositories.

 'rename'::

--
1.7.0.20.gcb44ed
