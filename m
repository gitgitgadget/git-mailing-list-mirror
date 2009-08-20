From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v4 19/19] sparse checkout: inhibit empty worktree
Date: Thu, 20 Aug 2009 20:47:13 +0700
Message-ID: <1250776033-12395-20-git-send-email-pclouds@gmail.com>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
 <1250776033-12395-2-git-send-email-pclouds@gmail.com>
 <1250776033-12395-3-git-send-email-pclouds@gmail.com>
 <1250776033-12395-4-git-send-email-pclouds@gmail.com>
 <1250776033-12395-5-git-send-email-pclouds@gmail.com>
 <1250776033-12395-6-git-send-email-pclouds@gmail.com>
 <1250776033-12395-7-git-send-email-pclouds@gmail.com>
 <1250776033-12395-8-git-send-email-pclouds@gmail.com>
 <1250776033-12395-9-git-send-email-pclouds@gmail.com>
 <1250776033-12395-10-git-send-email-pclouds@gmail.com>
 <1250776033-12395-11-git-send-email-pclouds@gmail.com>
 <1250776033-12395-12-git-send-email-pclouds@gmail.com>
 <1250776033-12395-13-git-send-email-pclouds@gmail.com>
 <1250776033-12395-14-git-send-email-pclouds@gmail.com>
 <1250776033-12395-15-git-send-email-pclouds@gmail.com>
 <1250776033-12395-16-git-send-email-pclouds@gmail.com>
 <1250776033-12395-17-git-send-email-pclouds@gmail.com>
 <1250776033-12395-18-git-send-email-pclouds@gmail.com>
 <1250776033-12395-19-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 15:49:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me81Q-0007ZS-8Y
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716AbZHTNtL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 09:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754697AbZHTNtK
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:49:10 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:44339 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702AbZHTNtH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:49:07 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1591323rvb.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 06:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=MkPVgGNyGuB0vkiTZrOV9VSBq2flXmIJgN2LzFs50E0=;
        b=JW/eFq2bXhztMTKnPVFRAw6cXqy0YNp20nIH6SGsz0w246B4Q676hBPBSTp/mPVfGx
         cbHMGu7nzTNY2Q6JSE5mSvzh1WeyWLbLWq1b4tgpsIb+rVwubGeWT1PGk82yatDKRYNA
         p0oZyOMrL5OjKk8ozABHVow/fY0z/iXT3wuhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=jVCrQfszm0pK25ZWSqyJK0sVWT9GfOOmH4A3zTTovw+PsSetfGDm3+8GtfzK23zRbo
         n8QjGqHp2xH/jSI/b0rsMbUhIkeWSW3K2IdtlJRH3rDYYmWl5p1aXghC53Xes6aoGfNI
         cWVi6Bv6oAXMQnS4/J2VqNK2crUwU5vmzPJ28=
Received: by 10.140.148.15 with SMTP id v15mr4000217rvd.22.1250776149781;
        Thu, 20 Aug 2009 06:49:09 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.241.222])
        by mx.google.com with ESMTPS id c20sm2156063rvf.1.2009.08.20.06.49.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 06:49:09 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 20 Aug 2009 20:49:03 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250776033-12395-19-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126638>

The way sparse checkout works, users may empty their worktree
completely, because of non-matching sparse-checkout spec, or empty
spec. I believe this is not desired. This patch makes Git refuse to
produce such worktree.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1009-read-tree-sparse-checkout.sh |   10 +++-------
 unpack-trees.c                       |    7 +++++++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/t/t1009-read-tree-sparse-checkout.sh b/t/t1009-read-tree-s=
parse-checkout.sh
index 2192f5a..62246db 100755
--- a/t/t1009-read-tree-sparse-checkout.sh
+++ b/t/t1009-read-tree-sparse-checkout.sh
@@ -55,20 +55,16 @@ test_expect_success 'read-tree --no-sparse-checkout=
 with empty .git/info/sparse-
 	test -f sub/added
 '
=20
-cat >expected.swt <<EOF
-S init.t
-S sub/added
-EOF
 test_expect_success 'read-tree with empty .git/info/sparse-checkout' '
 	git config core.sparsecheckout true &&
 	echo > .git/info/sparse-checkout &&
-	git read-tree -m -u HEAD &&
+	test_must_fail git read-tree -m -u HEAD &&
 	git ls-files --stage > result &&
 	test_cmp expected result &&
 	git ls-files -t > result &&
 	test_cmp expected.swt result &&
-	test ! -f init.t &&
-	test ! -f sub/added
+	test -f init.t &&
+	test -f sub/added
 '
=20
 cat >expected.swt <<EOF
diff --git a/unpack-trees.c b/unpack-trees.c
index 72743b3..80ae2a0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -498,6 +498,7 @@ int unpack_trees(unsigned len, struct tree_desc *t,=
 struct unpack_trees_options
 	}
=20
 	if (!o->skip_sparse_checkout) {
+		int empty_worktree =3D 1;
 		for (i =3D 0;i < o->result.cache_nr;i++) {
 			struct cache_entry *ce =3D o->result.cache[i];
=20
@@ -512,8 +513,14 @@ int unpack_trees(unsigned len, struct tree_desc *t=
, struct unpack_trees_options
 			 */
 			if (ce_skip_worktree(ce))
 				ce->ce_flags &=3D ~(CE_UPDATE | CE_REMOVE);
+			else
+				empty_worktree =3D 0;
=20
 		}
+		if (o->result.cache_nr && empty_worktree) {
+			ret =3D unpack_failed(o, "Sparse checkout leaves no entry on workin=
g directory");
+			goto done;
+		}
 	}
=20
 	o->src_index =3D NULL;
--=20
1.6.3.GIT
