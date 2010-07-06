From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: =?UTF-8?q?=5BPATCH=20v2=5D=20use=20=22up-to-date=22=20instead=20of=20=22uptodate=22=20for=20consistency?=
Date: Tue,  6 Jul 2010 17:55:44 +0200
Message-ID: <b49995cd151b36cfff5231b28f5e8ff3970c14a2.1278431239.git.nicolas.s.dev@gmx.fr>
References: <AANLkTimvQ8_SKa_VSvQk1_c3aRVv1lZCMYNOVLXBuC4W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, <git@vger.kernel.org>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 17:56:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWAVP-00059p-8y
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 17:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861Ab0GFP4O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 11:56:14 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37930 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031Ab0GFP4N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 11:56:13 -0400
Received: by yxk8 with SMTP id 8so212052yxk.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=SthbTJl41gCgv1jMDq+2uAHvtrkr/v4LdP2+AlTpDRs=;
        b=vq0t7PMwmK2xP63xYDfaQkkh934WZZoGOFQbF1tnGkoz5QMsIUn3enlx+9X5sMcMbF
         y7nkw2wPPSd0nVxIp43dHLvPgRCxEVriwKPW33HuMnrZ5vChixvuD5/7Qn5uGiDxAOpl
         Ss7KjpSoGSLonKHzcPIcZXWecK88mMvWlSVEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        b=BtV07g0lCIwXbLx55TjGk0kAdQCVjKRWEJUdjdVbSv3FfAFj6CqfKAxTXdOwGtFyJP
         bwhUDe06Q/Eb8/hP9xyH4+GGnGiSZ5g6WCR4FT588+VIGArnpNfyjyvHhAaeFl3JyBWK
         +nFl8xxfhxmJBdoGnaNWfDWU77sJEMgiNgAcQ=
Received: by 10.213.2.132 with SMTP id 4mr4189689ebj.94.1278431769112;
        Tue, 06 Jul 2010 08:56:09 -0700 (PDT)
Received: from localhost (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id a48sm52344518eei.13.2010.07.06.08.56.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 08:56:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc1.212.g4c287
In-Reply-To: <AANLkTimvQ8_SKa_VSvQk1_c3aRVv1lZCMYNOVLXBuC4W@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150366>

Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
---

The 06/07/10, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Did you run the tests after applying this patch? This looks like it w=
ould break:
>=20
> t/t7110-reset-merge.sh
> 176:    grep file1 err.log | grep "not uptodate"
> 192:    grep file1 err.log | grep "not uptodate"

I forgot about them. Thanks for a reminder.


 Documentation/git-checkout.txt |    2 +-
 merge-recursive.c              |    2 +-
 t/t7110-reset-merge.sh         |    4 ++--
 unpack-trees.c                 |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 261dd90..c04eceb 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -263,7 +263,7 @@ the above checkout would fail like this:
 +
 ------------
 $ git checkout mytopic
-fatal: Entry 'frotz' not uptodate. Cannot merge.
+fatal: Entry 'frotz' not up-to-date. Cannot merge.
 ------------
 +
 You can give the `-m` flag to the command, which would try a
diff --git a/merge-recursive.c b/merge-recursive.c
index 856e98c..fb6aa4a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1214,7 +1214,7 @@ int merge_trees(struct merge_options *o,
 	}
=20
 	if (sha_eq(common->object.sha1, merge->object.sha1)) {
-		output(o, 0, "Already uptodate!");
+		output(o, 0, "Already up-to-date!");
 		*result =3D head;
 		return 1;
 	}
diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index 70cdd8e..6a5f78d 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -173,7 +173,7 @@ test_expect_success 'reset --merge fails with chang=
es in file it touches' '
     sed -e "s/line 1/changed line 1/" <file1 >file3 &&
     mv file3 file1 &&
     test_must_fail git reset --merge HEAD^ 2>err.log &&
-    grep file1 err.log | grep "not uptodate"
+    grep file1 err.log | grep "not up-to-date"
 '
=20
 # The next test will test the following:
@@ -189,7 +189,7 @@ test_expect_success 'reset --keep fails with change=
s in file it touches' '
     sed -e "s/line 1/changed line 1/" <file1 >file3 &&
     mv file3 file1 &&
     test_must_fail git reset --keep HEAD^ 2>err.log &&
-    grep file1 err.log | grep "not uptodate"
+    grep file1 err.log | grep "not up-to-date"
 '
=20
 test_expect_success 'setup 3 different branches' '
diff --git a/unpack-trees.c b/unpack-trees.c
index 8cf0da3..024846e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -22,7 +22,7 @@ static struct unpack_trees_error_msgs unpack_plumbing=
_errors =3D {
 	"Entry '%s' would be overwritten by merge. Cannot merge.",
=20
 	/* not_uptodate_file */
-	"Entry '%s' not uptodate. Cannot merge.",
+	"Entry '%s' not up-to-date. Cannot merge.",
=20
 	/* not_uptodate_dir */
 	"Updating '%s' would lose untracked files in it",
@@ -34,7 +34,7 @@ static struct unpack_trees_error_msgs unpack_plumbing=
_errors =3D {
 	"Entry '%s' overlaps with '%s'.  Cannot bind.",
=20
 	/* sparse_not_uptodate_file */
-	"Entry '%s' not uptodate. Cannot update sparse checkout.",
+	"Entry '%s' not up-to-date. Cannot update sparse checkout.",
=20
 	/* would_lose_orphaned */
 	"Working tree file '%s' would be %s by sparse checkout update.",
--=20
1.7.2.rc1.212.g4c287
