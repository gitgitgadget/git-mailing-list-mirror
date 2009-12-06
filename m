From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 1/2] Documentation: 'git add --all' can remove files
Date: Sun, 06 Dec 2009 19:07:14 +0100
Message-ID: <4B1BF2D2.8000506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 06 19:09:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHLXX-0008Gt-Vt
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 19:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934081AbZLFSHN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Dec 2009 13:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933969AbZLFSHM
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 13:07:12 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:61453 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934076AbZLFSHK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 13:07:10 -0500
Received: by ewy19 with SMTP id 19so4745590ewy.1
        for <git@vger.kernel.org>; Sun, 06 Dec 2009 10:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=NJ3z29pEO1fxlXSlBWU3N8ls63O3cOufB81QtFEomus=;
        b=ie5glBGBxuboF93YVDv3/iRbL3ZDF2PfDbW6L7eZ0Nu7KyN5v6MoWIolMTQTjgLvqV
         GKCzLg3Uynd4PgKAiKgf/sgFBjJ8eJFNm4LATFAn6NYG7DYFy5DJcaTUvd19TXaielzS
         mZ0IvtEKzLq95G1DM7n6r9p33pprWKWox7Css=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=LjbKiPyOGp07B1GfvWgUrLrsDVa1wYDuA+ATghKaMH7h8qeYSsfQJz+cwJFNrsz+hf
         nVJ1BtoT6pMzL7VZsRzEO3YgchIy+3iPl0QbV3xHpkYg3Ar+HcnrNBxUDYMXYcEr+N4j
         5r20uaqUSXXOgCWm6SGkdzh60VywchFdqlrMY=
Received: by 10.213.15.19 with SMTP id i19mr873989eba.65.1260122835629;
        Sun, 06 Dec 2009 10:07:15 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 14sm3000972ewy.7.2009.12.06.10.07.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Dec 2009 10:07:15 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134682>

Document that 'git add --all' can remove files no longer present
in the working tree from the index. Also mention why it is useful,
and insert a cross-reference in the 'git rm' documentation to
'git add --all'.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 Documentation/git-add.txt |   13 +++++++++----
 Documentation/git-rm.txt  |    4 ++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index e93e606..b7e8aa2 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -16,6 +16,8 @@ DESCRIPTION
 -----------
 This command adds the current content of new or modified files to the
 index, thus staging that content for inclusion in the next commit.
+(Given the `--all` option, the `git add` command will also remove file=
s
+from the index that are no longer present in the working tree.)
=20
 The "index" holds a snapshot of the content of the working tree, and i=
t
 is this snapshot that is taken as the contents of the next commit.  Th=
us
@@ -102,10 +104,13 @@ apply.
=20
 -A::
 --all::
-	Update files that git already knows about (same as '\--update')
-	and add all untracked files that are not ignored by '.gitignore'
-	mechanism.
-
+	Update files that git already knows about (same as '\--update'),
+	add all untracked files that are not ignored by '.gitignore'
+	mechanism and remove files from the index that are no longer
+	present in the working tree.
++
+This option is especially useful after running the `rsync` command wit=
h
+the working tree as the target to sync the index with the working tree=
=2E
=20
 -N::
 --intent-to-add::
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 5afb1e7..b4dff5b 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -81,6 +81,10 @@ two directories `d` and `d2`, there is a difference =
between
 using `git rm \'d\*\'` and `git rm \'d/\*\'`, as the former will
 also remove all of directory `d2`.
=20
+To automatically remove all files from the index that are no longer
+present in the working tree, see the `--all` option for
+linkgit:git-add[1].
+
 EXAMPLES
 --------
 git rm Documentation/\\*.txt::
--=20
1.6.6.rc1.31.g1a56b
