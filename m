From: Deskin Miller <deskinm@umich.edu>
Subject: [PATCH v2] Fixed git archive for bare repos
Date: Sat, 25 Oct 2008 11:38:14 -0400
Message-ID: <20081025153814.GA26752@euler>
References: <20081022210913.GB22541@hashpling.org> <1224712023-5280-1-git-send-email-charles@hashpling.org> <49024A05.3090100@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Charles Bailey <charles@hashpling.org>, git@vger.kernel.org,
	kenneth johansson <ken@kenjo.org>, gitster@pobox.com
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Oct 25 17:40:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtlFh-0005mf-O4
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 17:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbYJYPiZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Oct 2008 11:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752263AbYJYPiY
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 11:38:24 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:29586 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbYJYPiY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 11:38:24 -0400
Received: by yx-out-2324.google.com with SMTP id 8so418511yxm.1
        for <git@vger.kernel.org>; Sat, 25 Oct 2008 08:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent:sender;
        bh=bZk/aYxcEJ2NYyGxBOzKNxWW4/oa5UlB7uYRnRwuaXA=;
        b=tbJePDedAtbbLgqV+yuA7ZMHXDG/cGYDr0sk7hjQBiAYlubB/Kggp25wqTfC0K9Mol
         fY+J+WkGH88lt0cMw/jpvy4jEt8V+Gax1aaZeXFpxEJfhflatqNtjdmbLkLWw5KG0TxU
         jw/9ny4u3isvP/XN7OkW1GcMb+kDq+8XShXuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent:sender;
        b=PRVuMG/m4O/NBc4QED2HSbx/J2j66XghT9PE9AwGGDUbqssw7NWT0m5e40n3fW9sA0
         GGn5KVKR6d9MA9zCd7hfWzaRvV2eASrWd7kSm6X40fNvugKx+vFJYY+57PE01++KxPbD
         27AR1HQPuzHJ3rofmsm6u3LiVBNSjs8of5+Ec=
Received: by 10.65.197.16 with SMTP id z16mr3968422qbp.97.1224949102263;
        Sat, 25 Oct 2008 08:38:22 -0700 (PDT)
Received: from euler ([68.40.49.130])
        by mx.google.com with ESMTPS id e17sm1844285qba.1.2008.10.25.08.38.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Oct 2008 08:38:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <49024A05.3090100@lsrfire.ath.cx>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99114>

=46rom 8f0dce75427283e0333cce1f1e66f4eac9978ad4 Mon Sep 17 00:00:00 200=
1
=46rom: Charles Bailey <charles@hashpling.org>

This moves the call to git_config to a place where it doesn't break the
logic for using git archive in a bare repository but retains the fix to
make git archive respect core.autocrlf.

Signed-off-by: Charles Bailey <charles@hashpling.org>
Tested-by: Deskin Miller <deskinm@umich.edu>
---
On Sat, Oct 25, 2008 at 12:19:49AM +0200, Ren=E9 Scharfe wrote:
> Charles Bailey schrieb:
> > This moves the call to git config to a place where it doesn't break
> > the logic for using git archive in a bare repository but retains th=
e
> > fix to make git archive respect core.autocrlf.
>=20
> If one combines your patch, Deskin's commit message and test and exte=
nds
> on the latter a bit then I think we have a winner. :)
>=20
> Here are a few more tests which create a ZIP file in addition to a ta=
r
> archive and compare them to their non-bare counterparts.
>=20
> Care to resend?
>=20
> Thanks,
> Ren=E9

Here's a resend.  I've kept Charles's change and commit message, but ad=
ded
Ren=E9's tests and removed my test, since it was presupposed by the new=
 tests.

Still needs a signoff from Ren=E9.

 archive.c           |    2 ++
 builtin-archive.c   |    2 --
 t/t5000-tar-tree.sh |   21 +++++++++++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/archive.c b/archive.c
index e2280df..45d242b 100644
--- a/archive.c
+++ b/archive.c
@@ -338,5 +338,7 @@ int write_archive(int argc, const char **argv, cons=
t char *prefix,
 	parse_treeish_arg(argv, &args, prefix);
 	parse_pathspec_arg(argv + 1, &args);
=20
+	git_config(git_default_config, NULL);
+
 	return ar->write_archive(&args);
 }
diff --git a/builtin-archive.c b/builtin-archive.c
index 432ce2a..5ceec43 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -111,8 +111,6 @@ int cmd_archive(int argc, const char **argv, const =
char *prefix)
 {
 	const char *remote =3D NULL;
=20
-	git_config(git_default_config, NULL);
-
 	remote =3D extract_remote_arg(&argc, argv);
 	if (remote)
 		return run_remote_archiver(remote, argc, argv);
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index e395ff4..0f27d73 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -58,6 +58,11 @@ test_expect_success \
      git commit-tree $treeid </dev/null)'
=20
 test_expect_success \
+    'create bare clone' \
+    'git clone --bare . bare.git &&
+     cp .gitattributes bare.git/info/attributes'
+
+test_expect_success \
     'remove ignored file' \
     'rm a/ignored'
=20
@@ -74,6 +79,14 @@ test_expect_success \
     'diff b.tar b2.tar'
=20
 test_expect_success \
+    'git archive in a bare repo' \
+    '(cd bare.git && git archive HEAD) >b3.tar'
+
+test_expect_success \
+    'git archive vs. the same in a bare repo' \
+    'test_cmp b.tar b3.tar'
+
+test_expect_success \
     'validate file modification time' \
     'mkdir extract &&
      "$TAR" xf b.tar -C extract a/a &&
@@ -151,6 +164,14 @@ test_expect_success \
     'git archive --format=3Dzip' \
     'git archive --format=3Dzip HEAD >d.zip'
=20
+test_expect_success \
+    'git archive --format=3Dzip in a bare repo' \
+    '(cd bare.git && git archive --format=3Dzip HEAD) >d1.zip'
+
+test_expect_success \
+    'git archive --format=3Dzip vs. the same in a bare repo' \
+    'test_cmp d.zip d1.zip'
+
 $UNZIP -v >/dev/null 2>&1
 if [ $? -eq 127 ]; then
 	echo "Skipping ZIP tests, because unzip was not found"
--=20
1.6.0.3.515.g304f
