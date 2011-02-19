From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 48/72] gettextize: git-reset "Unstaged changes after reset" message
Date: Sat, 19 Feb 2011 19:24:31 +0000
Message-ID: <1298143495-3681-49-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:30:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsVI-00042j-OO
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:30:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756118Ab1BST3i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:29:38 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60431 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756045Ab1BST2H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:07 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1970440ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=zpbrNjaZwH5ShU7lz1vN8aXot+BJat9Ltfy8MY2uOqU=;
        b=dvrKs+VsBmcXkC8F+vdd8lvkz3jJjN+ZEaZa4eJhORpKD1qp8YGaBPrRaQqV8+HM+4
         yFCHgbKhGSVvuVnhkOcKKYOQ8dOPLcZ1IzV6Vynw90VSb21JkizTyUeJLDNleGGRot1H
         j33ee3x3Glog77dFcff218EFQdJi2rZB2kVBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=REgmUGJIWO00f3fuALqyp9YFgAKv2i/SkKfogJPzJd9uOi3IDIm7fpmN+1y+fopasG
         +xBJX/+/MrtS7nwN38D/48Oy5hJFbVIkm9w5JN+hpK8kNd2M+GjeIX0fsh+gR3CqoLfK
         L0i0CtHfhdFGP5aJpNoPVLUiGxrnfsw1dBJxI=
Received: by 10.213.17.20 with SMTP id q20mr2536901eba.87.1298143687207;
        Sat, 19 Feb 2011 11:28:07 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.06
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:06 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167367>

Gettextize the ""Unstaged changes after reset:" message. A test in
t7102-reset.sh explicitly checked for this message. Change it to skip
under GETTEXT_POISON=3DYesPlease.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/reset.c  |    2 +-
 t/t7102-reset.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 1465174..1fe5b0f 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -142,7 +142,7 @@ static int update_index_refresh(int fd, struct lock=
_file *index_lock, int flags)
 		return error(_("Could not read index"));
=20
 	result =3D refresh_index(&the_index, (flags), NULL, NULL,
-			       "Unstaged changes after reset:") ? 1 : 0;
+			       _("Unstaged changes after reset:")) ? 1 : 0;
 	if (write_cache(fd, active_cache, active_nr) ||
 			commit_locked_index(index_lock))
 		return error ("Could not refresh index");
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index b8cf260..1370949 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -423,7 +423,7 @@ Unstaged changes after reset:
 M	file2
 EOF
=20
-test_expect_success '--mixed refreshes the index' '
+test_expect_success NO_GETTEXT_POISON '--mixed refreshes the index' '
 	echo 123 >> file2 &&
 	git reset --mixed HEAD > output &&
 	test_cmp expect output
--=20
1.7.2.3
