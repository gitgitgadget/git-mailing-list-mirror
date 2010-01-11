From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/6] Documentation: tweak How Merge Works
Date: Mon, 11 Jan 2010 02:43:56 -0600
Message-ID: <20100111084355.GF23806@progeny.tock>
References: <cover.1263081032.git.trast@student.ethz.ch>
 <e330d8ca1a9ec38ce40b0f67123b1dd893f0b31c.1263081032.git.trast@student.ethz.ch>
 <20100110044949.GA8974@progeny.tock>
 <7vskaefp2v.fsf@alter.siamese.dyndns.org>
 <20100111021322.GA8480@progeny.tock>
 <7vzl4lbcfl.fsf@alter.siamese.dyndns.org>
 <20100111041318.GA9806@progeny.tock>
 <20100111082123.GA23742@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 09:44:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUFsW-0004oe-RU
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 09:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542Ab0AKIn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 03:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752494Ab0AKIn4
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 03:43:56 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:55133 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296Ab0AKIn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 03:43:56 -0500
Received: by ywh6 with SMTP id 6so21254926ywh.4
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 00:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0nlaUYlbbG1E98Uu8b4eKAvgJt4DjfehXbeF77IOaWs=;
        b=wKnUjmOxdNrLPV6CJgFvY4SsCr97sYmRKozd88un/SG3nOhBhImbqPhYdzqwrnMj/d
         cXPT72rRG2MygdpeK/R8Rk8aaDHpczDHorgCKdC6bXa0EFdDNRBUmnFxug33uHKuNAsM
         ZPtqJlNk5Z0J/oGCqklyGy6Kg7EosJDMIDln8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=X5Gx/fINNVTqdKn674uXb7Oio/qrgLVjdMEs5yITX6zDnz7NslWQqB37sVa3P855Cr
         t6+9xhcd8UCXqYvYSNJjrPtZZATP9/jVJUFox2ps2z9e6DhNbVWNIW+pZUe3kafRDIZQ
         0glLnNxxZj0XGWd4A77NUy2ax+vTc8WB+vig0=
Received: by 10.150.213.18 with SMTP id l18mr4848702ybg.183.1263199434867;
        Mon, 11 Jan 2010 00:43:54 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm4303460iwn.15.2010.01.11.00.43.53
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Jan 2010 00:43:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100111082123.GA23742@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136622>

Change heading to TRUE MERGE.  The whole manual page is about how
merges work.

Start to explain what it means to merge two commits into a single
tree.

Do not assume the commits named on the 'git merge' command line
come from another repository.  For simplicity, still assume they
are branch heads for now, though.

Do not give start any list items with `code`; a toolchain bug
makes the resulting nroff look wrong.

Recommend reset --merged for safely cancelling a failed merge.

Cc: Petr Baudis <pasky@suse.cz>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-merge.txt |   56 +++++++++++++++++++-----------------------
 1 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index ec9c6d3..7ae0f65 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -96,62 +96,56 @@ merge commit.
 
 This behavior can be suppressed with the `--no-ff` option.
 
-include::merge-strategies.txt[]
-
-
-If you tried a merge which resulted in complex conflicts and
-want to start over, you can recover with 'git-reset'.
-
-HOW MERGE WORKS
----------------
-
-A merge is always between the current `HEAD` and one or more
-commits (usually, branch head or tag).
+TRUE MERGE
+----------
 
 Except in a fast-forward merge (see above), the branches to be
 merged must be tied together by a merge commit that has both of them
 as its parents.
 The rest of this section describes this "True merge" case.
 
-The chosen merge strategy merges the two commits into a single
-new source tree.
 When things merge cleanly, this is what happens:
 
-1. The results are updated both in the index file and in your
-   working tree;
-2. Index file is written out as a tree;
+1. A version reconciling the changes from all branches to be
+   merged is written to the index file and your working tree;
+2. The index file is written out as a tree;
 3. The tree gets committed; and
 4. The `HEAD` pointer gets advanced.
 
 Because of 2., we require that the original state of the index
 file matches exactly the current `HEAD` commit; otherwise we
-will write out your local changes already registered in your
+would write out your local changes already registered in your
 index file along with the merge result, which is not good.
 Because 1. involves only those paths differing between your
-branch and the remote branch you are pulling from during the
-merge (which is typically a fraction of the whole tree), you can
-have local modifications in your working tree as long as they do
-not overlap with what the merge updates.
-
-When there are conflicts, the following happens:
+branch and the other branches (which is typically a fraction of
+the whole tree), you can have local modifications in your
+working tree as long as they do not overlap with what the merge
+updates.
 
-1. `HEAD` stays the same.
+When it is not obvious how to reconcile the changes, the following
+happens:
 
-2. Cleanly merged paths are updated both in the index file and
+1. The `HEAD` pointer stays the same.
+2. The `MERGE_HEAD` ref is set to point to the other branch head.
+3. Paths that merged cleanly are updated both in the index file and
    in your working tree.
-
-3. For conflicting paths, the index file records up to three
+4. For conflicting paths, the index file records up to three
    versions; stage1 stores the version from the common ancestor,
-   stage2 from `HEAD`, and stage3 from the remote branch (you
+   stage2 from `HEAD`, and stage3 from `MERGE_HEAD` (you
    can inspect the stages with `git ls-files -u`).  The working
    tree files contain the result of the "merge" program; i.e. 3-way
-   merge results with familiar conflict markers `<<< === >>>`.
-
-4. No other changes are done.  In particular, the local
+   merge results with familiar conflict markers `<<<` `===` `>>>`.
+5. No other changes are done.  In particular, the local
    modifications you had before you started merge will stay the
    same and the index entries for them stay as they were,
    i.e. matching `HEAD`.
 
+If you tried a merge which resulted in complex conflicts and
+want to start over, you can recover with `git reset --merged`.
+
+include::merge-strategies.txt[]
+
+
 HOW CONFLICTS ARE PRESENTED
 ---------------------------
 
-- 
1.6.6
