From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/6] worktree.txt: how to fix up after moving a worktree
Date: Mon, 18 Jan 2016 18:21:31 +0700
Message-ID: <1453116094-4987-4-git-send-email-pclouds@gmail.com>
References: <1453116094-4987-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <ericsunshine@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 12:04:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aL7bT-00044a-As
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 12:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754677AbcARLD7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jan 2016 06:03:59 -0500
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34256 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479AbcARLDy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 06:03:54 -0500
Received: by mail-pa0-f67.google.com with SMTP id yy13so32473976pab.1
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 03:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ltnJ2tUSWdzgLVaVPWLdaDdyp7rqnEv1rKs1u3kQ/SE=;
        b=s7jIucuP0599gWvEYwm2iI0hLOOPk+Mo3KUCOAJqCMC8o8O6afhvqXCSbM4UlpxMVm
         Y7+VeFJP5Np9Av5SfX0Omf/fR8s2nNhTNnYFaL6VEI7V2WX+D7mDQ4mjsm3NrBW3sxgw
         orev2Pmi1WFRRhMWyCQxQvFn24DgBG3KX9KpWkMPR+FZxHw8Rovx2sJAsJ/cAOntDgW+
         ikha7woev++iplPEnLcy1KA+YlYby8IP/DWmuHGzjR69szgjI5Xsm5z6k/8V6Fd0WnjB
         Fsv3W8QLv5GQ8bTOvEMu30fwlWa1knJzF3V3QhfoSFZfRVp2ihPFAesZgYWkmiYrDvo/
         66Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=ltnJ2tUSWdzgLVaVPWLdaDdyp7rqnEv1rKs1u3kQ/SE=;
        b=iUKG6FCjk+frpU8eopdsfUSEAmkU5BYdkU6Q7rHO77ncbuFjDQAC5z35d05appxkd0
         NCsKQLUGK+TOhOIzlGVW197hcuaB/AISb/fBCdOODkQAKDavHqWTQifAR9f1uFRVeY0N
         dRZAGznbNRRbP1lWAqWOyGksTAZXjHfD7HI17/dNxNUILX+/B2zF7qz/lyAkOyUFefRo
         yHF8VWLQafNBVxkAhAT8zbPHg2q/q+PBXXNAt/wIGTr+KkxNy5UEYhOTpRk6R6iMq2Yy
         X4ntGyMBbJgnCBKHonKuZTf8QqDakIH9cP9YlUd0lboCwv5KZ+YC7cDvnDZuTS+T+I7R
         0+gA==
X-Gm-Message-State: ALoCoQk5/0BJ53rDTekV8Z1PeRR+JNR64fILtZcVFbT95NZLLEPf5loJ9Iqhn2c99dQGpt1VgK/KVCNa76ZVpWq0BVcjtg0OWA==
X-Received: by 10.66.100.228 with SMTP id fb4mr35151062pab.84.1453115033641;
        Mon, 18 Jan 2016 03:03:53 -0800 (PST)
Received: from lanh ([115.72.43.83])
        by smtp.gmail.com with ESMTPSA id sv8sm33291571pab.13.2016.01.18.03.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 03:03:52 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 18 Jan 2016 18:21:55 +0700
X-Mailer: git-send-email 2.7.0.96.g5373197
In-Reply-To: <1453116094-4987-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284288>

=46rom: Eric Sunshine <ericsunshine@gmail.com>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 4814f48..62c76c1 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -32,9 +32,9 @@ The working tree's administrative files in the reposi=
tory (see
 `git worktree prune` in the main or any linked working tree to
 clean up any stale administrative files.
=20
-If you move a linked working tree to another file system, or
-within a file system that does not support hard links, you need to upd=
ate
-$GIT_DIR/worktrees/<id>/gitdir so that they do not get automatically p=
runed.
+If you move a linked working tree, you need to manually update the
+administrative files so that they do not get pruned automatically. See
+section "DETAILS" for more information.
=20
 If a linked working tree is stored on a portable device or network sha=
re
 which is not always mounted, you can prevent its administrative files =
from
@@ -135,6 +135,13 @@ thumb is do not make any assumption about whether =
a path belongs to
 $GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
 inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
=20
+If you move a linked working tree, you need to update the 'gitdir' fil=
e
+in the entry's directory. For example, if a linked working tree is mov=
ed
+to `/newpath/test-next` and its `.git` file points to
+`/path/main/.git/worktrees/test-next`, then update
+`/path/main/.git/worktrees/test-next/gitdir` to reference `/newpath/te=
st-next`
+instead.
+
 To prevent a $GIT_DIR/worktrees entry from being pruned (which
 can be useful in some situations, such as when the
 entry's working tree is stored on a portable device), add a file named
--=20
2.7.0.96.g5373197
