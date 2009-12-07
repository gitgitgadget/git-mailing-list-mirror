From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 2/2] git-rm doc: Describe how to sync index & work tree
Date: Mon, 07 Dec 2009 19:35:42 +0100
Message-ID: <4B1D4AFE.6090708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 19:36:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHiRC-0006vf-VF
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 19:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758597AbZLGSfp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Dec 2009 13:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758561AbZLGSfn
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 13:35:43 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:51950 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758589AbZLGSfj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 13:35:39 -0500
Received: by ewy19 with SMTP id 19so802152ewy.1
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 10:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=Wv18mCPBnzHHkzuBOVMYZP+kcCoY+WUsknlju2g2FfY=;
        b=MSftq0JgekFqr6YgdLTfismzhVPNKXysnxByNOegMHelvDcmPH3heFD460FNWhn3YF
         /BqF8baYVmpvaUrd86f1+nERi2RjgbgHhMK44ZgGiLY4JWMLfjkgWkvcWS7dU+SrcZEj
         VWID9m9o8R8evNHLvqWnzYdmFFUO0gVmD2aqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=O4o1+eMWjcqQ+hZtXMgHGokyj7bfN1yDEY4CeGQhHNZexJqUSruWPJ23ydQR8bvUBP
         DCEmknz8i56yS9GBAPl4EQ521rwudz18jCgv/ne4ldMGMAnTBQD5YlkvQ4IzrM/vAxuF
         5J0Gz0Sb5h+0nQIc+vvrZVyKh9WI4OoIzfMtM=
Received: by 10.213.110.7 with SMTP id l7mr632533ebp.23.1260210943875;
        Mon, 07 Dec 2009 10:35:43 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 13sm3546340ewy.5.2009.12.07.10.35.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 10:35:43 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134772>

Newcomers to git that want to remove from the index only the
files that have disappeared from the working tree will probably
look for a way to do that in the documentation for 'git rm'.

Therefore, describe how that can be done (even though it involves
other commands than 'git rm'). Based on a suggestion by Junio,
but re-arranged and rewritten to better fit into the style of
command reference.

While at it, change a single occurrence of "work tree" to "working
tree" for consistency.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
To better fit a reference page (IMO), I have changed the
order of the commands, and have put the straightforward
command last as it is the least useful, and I have removed
the "bad examples" (using two commands instead of simply
'git add -A'). I realize that those examples have their value,
too, but since most people scan a reference page quickly
to find what they'll need, it will just confuse them.

 Documentation/git-rm.txt |   53 ++++++++++++++++++++++++++++++++++++++=
+++++++-
 1 files changed, 52 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index d4162f6..c622972 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -13,7 +13,7 @@ DESCRIPTION
 -----------
 Remove files from the index, or from the working tree and the index.
 `git rm` will not remove a file from just your working directory.
-(There is no option to remove a file only from the work tree
+(There is no option to remove a file only from the working tree
 and yet keep it in the index; use `/bin/rm` if you want to do that.)
 The files being removed have to be identical to the tip of the branch,
 and no updates to their contents can be staged in the index,
@@ -81,6 +81,57 @@ two directories `d` and `d2`, there is a difference =
between
 using `git rm \'d\*\'` and `git rm \'d/\*\'`, as the former will
 also remove all of directory `d2`.
=20
+REMOVING FILES THAT HAVE DISAPPEARED FROM THE FILESYSTEM
+--------------------------------------------------------
+There is no option for `git rm` to remove from the index only
+the paths that have disappeared from the filesystem. However,
+depending on the use case, there are several ways that can be
+done.
+
+Using "git commit -a"
+~~~~~~~~~~~~~~~~~~~~~
+If you intend that your next commit should record all modifications
+of tracked files in the working tree and record all removals of
+files that have been removed from the working tree with `rm`
+(as opposed to `git rm`), use `git commit -a`, as it will
+automatically notice and record all removals.
+
+Using "git add -A"
+~~~~~~~~~~~~~~~~~~
+When accepting a new code drop for a vendor branch, you probably
+want to record both the removal of paths and additions of new paths
+as well as modifications of existing paths.
+
+Typically you would first remove all tracked files from the working
+tree using this command:
+
+----------------
+git ls-files -z | xargs -0 rm -f
+----------------
+
+and then "untar" the new code in the working tree. Alternately
+you could "rsync" the changes into the working tree.
+
+After that, the easiest way to record all removals, additions, and
+modifications in the working tree is:
+
+----------------
+git add -A
+----------------
+
+See linkgit:git-add[1].
+
+Other ways
+~~~~~~~~~~
+If all you really want to do is to remove from the index the files
+that are no longer present in the working tree (perhaps because
+your working tree is dirty so that you cannot use `git commit -a`),
+use the following command:
+
+----------------
+git diff --name-only --diff-filter=3DD -z | xargs -0 git rm --cached
+----------------
+
 EXAMPLES
 --------
 git rm Documentation/\\*.txt::
--=20
1.6.6.rc1.31.g1a56b
