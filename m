From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH v2] Docs: git checkout --orphan: `root commit' and `branch head'
Date: Tue, 27 Sep 2011 15:46:22 -0000
Message-ID: <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com>
            <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
            <7vaa9r2jii.fsf@alter.siamese.dyndns.org>
            <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
            <vpq39fi9gf5.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 17:52:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Zwv-0005OZ-DJ
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 17:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243Ab1I0Pv5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Sep 2011 11:51:57 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:45253 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab1I0Pv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 11:51:56 -0400
Received: by yib18 with SMTP id 18so5402162yib.19
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=h6gHKL6D0S3uBRFrLPiaJ4NCtcR6Q/l8PPX+wTQocxM=;
        b=I4WvD0L9+wyR+hJggo2c0d0OHk7Er+BrALOc/9xbgURoDYW7WvTONHqFg3BJdaC24/
         0nkM6S5+Si+KS45NrsffVZpL+Eh/jfbmwPkC1tLcPArj03+jg7oxkalNM0SDwD+6oo2u
         BtM0prTyCs2F9rMbD8jyhK3K/401Rgczf7jrc=
Received: by 10.236.156.67 with SMTP id l43mr31070700yhk.10.1317138715415;
        Tue, 27 Sep 2011 08:51:55 -0700 (PDT)
Received: from gmail.com (exit-01d.noisetor.net. [173.254.216.69])
        by mx.google.com with ESMTPS id v28sm34225271yhi.11.2011.09.27.08.51.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Sep 2011 08:51:51 -0700 (PDT)
In-Reply-To: <vpq39fi9gf5.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182245>

See:

  Re: Can a git changeset be created with no parent
  Carlos Mart=C3=ADn Nieto <cmn@elego.de>
  Message-ID: <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
  http://article.gmane.org/gmane.comp.version-control.git/182170

and:

  git help glossary

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-checkout.txt |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index c0a96e6..68ae6c9 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -125,29 +125,22 @@ explicitly give a name with '-b' in such a case.
 	below for details.
=20
 --orphan::
-	Create a new 'orphan' branch, named <new_branch>, started from
-	<start_point> and switch to it.  The first commit made on this
-	new branch will have no parents and it will be the root of a new
-	history totally disconnected from all the other branches and
-	commits.
+	Tell git to make the next commit you create a root commit (that is,
+	a commit without any parent); creating the next commit is similar to
+	creating the first commit after running "git init", except that the
+	new commit will be referenced by the branch head <new_branch> rather
+	than "master".
 +
-The index and the working tree are adjusted as if you had previously r=
un
-"git checkout <start_point>".  This allows you to start a new history
-that records a set of paths similar to <start_point> by easily running
-"git commit -a" to make the root commit.
+Furthermore, the index and the working tree are adjusted as if you ran
+"git checkout <start_point>"; by just running "git commit -a", you can
+create a root commit that records a tree similar to that of <start_poi=
nt>.
 +
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
+Naturally, before creating the commit, you may manipulate the index in=
 any
+way you want. For example, if you want to create a root commit that re=
cords
+a tree that is totally different from the one of <start_point>, then j=
ust
+clear the working tree and index by running "git rm -rf ." from the to=
p
+level of the working tree, after which you may prepare your new workin=
g
+tree and index as desired.
=20
 -m::
 --merge::
--=20
1.7.6.409.ge7a85
