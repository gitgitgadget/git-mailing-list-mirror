From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH v4] Docs: git checkout --orphan: Copyedit,
                          and s/root commit/orphan branch/
Date: Thu, 29 Sep 2011 15:44:03 -0000
Message-ID: <3cba6bb85bde4f96903b2b617190a2b8-mfwitten@gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com>
            <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
            <7vaa9r2jii.fsf@alter.siamese.dyndns.org>
            <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
            <vpq39fi9gf5.fsf@bauges.imag.fr>
            <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
            <vpqsjni6kkk.fsf@bauges.imag.fr>
            <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
            <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com>
            <7vaa9oz9rl.fsf@alter.siamese.dyndns.org>
	    <271cc2ed03774b4988bb61cb3e79750e-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 18:41:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Jfh-0005Cc-Qz
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 18:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757073Ab1I2QlN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 12:41:13 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40137 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790Ab1I2QlM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 12:41:12 -0400
Received: by eya28 with SMTP id 28so575725eya.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 09:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Xg3WJd7c5HANc6Oqh2LGZR7nYcis/EHvTSC1HkKLKxI=;
        b=jZNgL7XkRdQTQ17bD8QHMttcpxcP1oeGWhn7vV754fCP27ML1zV1sq/CFcE6/eNGnp
         Y4m1KQIUx89xgkyQq+lEvxS+KsTeB9NMEQuRAWz/1xdzCvs4Dry0sVQ6kXqxetUj7m9L
         i1RZb2Riiot7ZAe0omrcMwQ/jckFgYOnX9pRQ=
Received: by 10.68.15.70 with SMTP id v6mr34387274pbc.85.1317314469939;
        Thu, 29 Sep 2011 09:41:09 -0700 (PDT)
Received: from gmail.com (tor-exit-router39-readme.formlessnetworking.net. [199.48.147.39])
        by mx.google.com with ESMTPS id e8sm8118728pbc.8.2011.09.29.09.41.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Sep 2011 09:41:09 -0700 (PDT)
In-Reply-To: <271cc2ed03774b4988bb61cb3e79750e-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182410>

It's copyediting; it's best just to read the damn patch, particularly w=
hen
there are no subtle details to be considered beyond the exhausting game=
 of
making everybody involved in the email thread feel like he or she has g=
otten
a portion of the bikeshed painted a certain color.

See:

  Re: Can a git changeset be created with no parent
  Carlos Mart=C3=ADn Nieto <cmn@elego.de>
  Message-ID: <1317073309.5579.9.camel@centaur.lab.cmartin.tk>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-checkout.txt |   69 ++++++++++++++++++++++++++++----=
-------
 1 files changed, 49 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index c0a96e6..bf042c2 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -125,29 +125,58 @@ explicitly give a name with '-b' in such a case.
 	below for details.
=20
---orphan::
-	Create a new 'orphan' branch, named <new_branch>, started from
-	<start_point> and switch to it.  The first commit made on this
-	new branch will have no parents and it will be the root of a new
-	history totally disconnected from all the other branches and
-	commits.
-+
-The index and the working tree are adjusted as if you had previously r=
un
-"git checkout <start_point>".  This allows you to start a new history
-that records a set of paths similar to <start_point> by easily running
-"git commit -a" to make the root commit.
-+
-This can be useful when you want to publish the tree from a commit
-without exposing its full history. You might want to do this to publis=
h
-an open source branch of a project whose current tree is "clean", but
-whose full history contains proprietary or otherwise encumbered bits o=
f
-code.
-+
-If you want to start a disconnected history that records a set of path=
s
-that is totally different from the one of <start_point>, then you shou=
ld
-clear the index and the working tree right after creating the orphan
-branch by running "git rm -rf ." from the top level of the working tre=
e.
-Afterwards you will be ready to prepare your new files, repopulating t=
he
-working tree, by copying them from elsewhere, extracting a tarball, et=
c.
+--orphan::
+	Perform these two tasks:
++
+--
+	* Adjust the working tree and index as if you ran
+	  "git checkout <start_point>".
+
+	* Set up git to turn the next commit you create into a root commit
+	  (that is, a commit without any parent); creating the next commit
+	  is similar to creating the first commit after running "git init",
+	  except that the new commit will be referenced by <new_branch>
+	  rather than "master".
+--
++
+Then, by just running "git commit", you can create a root commit
+with a tree that is exactly the same as the tree of <start_point>.
+Alternatively, before creating the commit, you may manipulate the
+index in any way you want; for example, to create a root commit with
+a tree that is totally different from the tree of <start_point>,
+just clear the working tree and index first: From the top level of
+the working tree, run "git rm -rf .", and then prepare your new
+working tree and index as desired.
++
+There are two common uses for this option:
++
+--
+	Separate history::
+		Suppose that for convenience, you want to maintain
+		in the same repository as your project some ancillary
+		material that is infrequently altered.  In such a case,
+		it may not make much sense to interleave the history of
+		that material with the history of your project; you can
+		use the "--orphan" option in order to create completely
+		separate histories.
+
+	Hidden history::
+		Suppose you have a project that has proprietary
+		material that is never meant to be released to the
+		public, yet you now want to maintain an open source
+		history that may be published widely.
++
+In this case, it would not be enough just to remove the proprietary
+material from the working tree and then create a new commit, because
+the proprietary material would still be accessible through the new
+commit's ancestry; the proprietary history must be hidden from the new
+commit, and the "--orphan" option allows you to do so by ensuring that
+the new commit has no parent.
++
+However, when there are multiple commits that are already suitable for
+the open source history (or that you want to make suitable), you shoul=
d
+instead consider working with linkgit:git-filter-branch[1] and possibl=
y
+linkgit:git-rebase[1].
+--
=20
 -m::
 --merge::
--=20
1.7.6.409.ge7a85
