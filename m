From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v4 17/19] read-tree: add --no-sparse-checkout to disable sparse checkout support
Date: Thu, 20 Aug 2009 20:47:11 +0700
Message-ID: <1250776033-12395-18-git-send-email-pclouds@gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 15:49:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me81O-0007ZS-0P
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695AbZHTNsx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 09:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754693AbZHTNsx
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:48:53 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:44339 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689AbZHTNsw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:48:52 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1591323rvb.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 06:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=qv3yVK1rt8+6pGnKvIddKxAq2J6R9EklZJzu8I2fF30=;
        b=uMUekj8xkRqR27bjl/yeI3nz6JFCOmzeSa7xgoweDDkREF8ssUsyt9RrLtEOJGT1mr
         YpzjsWzqbuc68EfF6e3a+QFaQ58fU2mo7z11IrbeiPJu5fHwbW86VEeQqtTn8rFBR8qK
         cGD0EJfzoChqWYv3/vCzAoDQppC3zZgAhP0Ho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=w2L6TQm3v9PJdBj2qTsh3CHveOilDofgpanivVSNrnlAfFRzdHMplDW6fqC7AEOBsk
         HDvORQC5IOamqgl9CjeZIprxsCCYddz//23udOEgDLksTZvEc06uStxUORggZ0fZ8GwT
         ioB+TR2xyMGrPKJesi4M/M79FnUkJyrfWetUw=
Received: by 10.141.29.12 with SMTP id g12mr4584319rvj.38.1250776134433;
        Thu, 20 Aug 2009 06:48:54 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.241.222])
        by mx.google.com with ESMTPS id 22sm186719pzk.10.2009.08.20.06.48.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 06:48:53 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 20 Aug 2009 20:48:48 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250776033-12395-17-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126641>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-read-tree.txt |    6 +++++-
 builtin-read-tree.c             |    4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-t=
ree.txt
index fc3f08b..ea7b0b2 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 'git read-tree' [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<prefix>]
 		[-u [--exclude-per-directory=3D<gitignore>] | -i]]
-		[--index-output=3D<file>]
+		[--index-output=3D<file>] [--no-sparse-checkout]
 		<tree-ish1> [<tree-ish2> [<tree-ish3>]]
=20
=20
@@ -110,6 +110,10 @@ OPTIONS
 	directories the index file and index output file are
 	located in.
=20
+--no-sparse-checkout::
+	Disable sparse checkout support even if `core.sparseCheckout`
+	is true.
+
 <tree-ish#>::
 	The id of the tree object(s) to be read/merged.
=20
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 9c2d634..f5acb1a 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -31,7 +31,7 @@ static int list_tree(unsigned char *sha1)
 }
=20
 static const char * const read_tree_usage[] =3D {
-	"git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<prefix>] [-u [--exclude-per-directory=3D<gitignore>] | -i]]  [--index-=
output=3D<file>] <tree-ish1> [<tree-ish2> [<tree-ish3>]]",
+	"git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<prefix>] [-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-spar=
se-checkout] [--index-output=3D<file>] <tree-ish1> [<tree-ish2> [<tree-=
ish3>]]",
 	NULL
 };
=20
@@ -98,6 +98,8 @@ int cmd_read_tree(int argc, const char **argv, const =
char *unused_prefix)
 		  PARSE_OPT_NONEG, exclude_per_directory_cb },
 		OPT_SET_INT('i', NULL, &opts.index_only,
 			    "don't check the working tree after merging", 1),
+		OPT_SET_INT(0, "no-sparse-checkout", &opts.skip_sparse_checkout,
+			    "skip applying sparse checkout filter", 1),
 		OPT_END()
 	};
=20
--=20
1.6.3.GIT
