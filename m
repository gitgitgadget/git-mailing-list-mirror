From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/6] Documentation: emphasize when git merge terminates
 early
Date: Mon, 11 Jan 2010 02:37:54 -0600
Message-ID: <20100111083754.GD23806@progeny.tock>
References: <cover.1263081032.git.trast@student.ethz.ch>
 <e330d8ca1a9ec38ce40b0f67123b1dd893f0b31c.1263081032.git.trast@student.ethz.ch>
 <20100110044949.GA8974@progeny.tock>
 <7vskaefp2v.fsf@alter.siamese.dyndns.org>
 <20100111021322.GA8480@progeny.tock>
 <7vzl4lbcfl.fsf@alter.siamese.dyndns.org>
 <20100111041318.GA9806@progeny.tock>
 <20100111082123.GA23742@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 09:38:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUFmo-000311-9S
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 09:38:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775Ab0AKIh4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jan 2010 03:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752744Ab0AKIhz
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 03:37:55 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:40202 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669Ab0AKIhy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 03:37:54 -0500
Received: by yxe17 with SMTP id 17so20099093yxe.33
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 00:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZRUTTubWpVT6mxm7x+W1j/eQ6FA1Fmk/XVYQXP9GHQk=;
        b=Dm7yxp5m7paznb3lFASRcY1VHnA+d5mXPq2LrDPSzQ1+vP2C87y8KToMFAJjPYvrK6
         Cy2CMJ2ampApzJgFXNgwp59kHHt4+LEXwC9PVH6G84rLRwLNgFlPcKjLB0D1CNSIIcL7
         j//znT0Pa8ojBc9GKLGh3oJgo51sPD2LC+ozU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=dMYUEYCc1xnjYxEyIMdV4119JNIZtVAxnXIUBTSGQ0fa68ytmIXSOMrGdGj75RcYky
         ZAB/hf3WWfxgRKuWHhRgsVBf6tJtRpUvRn8Fl3HgleOWewV91Qqn9LgtciN5j2desC3k
         7RgAFQLNrsZVl6kf1qd41Puvup6qC6BvNWLUA=
Received: by 10.150.104.13 with SMTP id b13mr1479005ybc.147.1263199073330;
        Mon, 11 Jan 2010 00:37:53 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm4632010iwn.1.2010.01.11.00.37.52
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Jan 2010 00:37:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100111082123.GA23742@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136620>

A merge-based operation in git can fail in two ways:

 - One that stops before touching anything (either your index was
   dirty and nothing happened, or your index was clean but you
   had local modifications in your work tree).

 - Another that goes ahead and results in conflicts.

The 'git merge' manual explains half of the first case as follows:

| A merge is always between the current `HEAD` and one or more
| commits (usually, branch head or tag), and the index file must
| match the tree of `HEAD` commit (i.e. the contents of the last commit=
)
| when it starts out.

The placement of this sentence makes it easy to skip over, and
its formulation is perhaps too formal to be memorable.

So give this point its own section and expand upon it.  Most of
the added text is taken from <http://gitster.livejournal.com/25801.html=
>.

Cc: Petr Baudis <pasky@suse.cz>,
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Thomas Rast <trast@student.ethz.ch>
Not-signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This is not signed off because most of the text is from Junio=E2=80=99s
blog.  I hope that is okay.

 Documentation/git-merge.txt |   34 ++++++++++++++++++++++++----------
 1 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index e29bb97..8950aa4 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -60,6 +60,28 @@ include::merge-options.txt[]
 	least one <remote>.  Specifying more than one <remote>
 	obviously means you are trying an Octopus.
=20
+PRE-MERGE CHECKS
+----------------
+
+In some other version control systems, you merge/update and then
+commit, with the risk of clobbering your changes with humongous
+conflicts. You shouldn't be pulling or merging if you haven't got
+your own work into good shape and committed it locally (see also
+linkgit:git-stash[1]).
+
+But novices can make this mistake, and 'git pull' and 'git merge'
+will stop without doing anything when local uncommitted changes
+overlap with files that 'git pull'/'git merge' may need to update.
+
+Also, to avoid unrelated changes in the recorded commit, 'git
+pull' and 'git merge' abort if there are any changes registered
+in the index relative to the contents of the `HEAD` commit.
+(One exception is when the changed index entries are already in
+the same state that would result from the merge anyway.)
+
+If all named commits are already ancestors of `HEAD`, 'git merge'
+will exit early with the message "Already up-to-date."
+
 include::merge-strategies.txt[]
=20
=20
@@ -70,17 +92,9 @@ HOW MERGE WORKS
 ---------------
=20
 A merge is always between the current `HEAD` and one or more
-commits (usually, branch head or tag), and the index file must
-match the tree of `HEAD` commit (i.e. the contents of the last commit)
-when it starts out.  In other words, `git diff --cached HEAD` must
-report no changes.  (One exception is when the changed index
-entries are already in the same state that would result from
-the merge anyway.)
-
-Three kinds of merge can happen:
+commits (usually, branch head or tag).
=20
-* The merged commit is already contained in `HEAD`. This is the
-  simplest case, called "Already up-to-date."
+Two kinds of merge can happen:
=20
 * `HEAD` is already contained in the merged commit. This is the
   most common case especially when invoked from 'git pull':
--=20
1.6.6
