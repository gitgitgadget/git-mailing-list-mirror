From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 16/72] gettextize: git-branch "Deleted branch [...]" message
Date: Sat, 19 Feb 2011 19:23:59 +0000
Message-ID: <1298143495-3681-17-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:27:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsT8-0002tu-BO
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755905Ab1BST1j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:27:39 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40522 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863Ab1BST1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:31 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347071eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=HXWf4ylGCC9FTEHSPE5BWlmSryCyvVNiB2AxvPSLQpQ=;
        b=Q9Fo7cd25nGZLVqE2PIXW6pL+aPLLj9Y64dfk352SLoUP1jtTLyo9aO2SxnujtD5Rg
         jna4bNAk6djHt/GLFDxi8CrLZRA02mcd0yJthHDJWUXPrYGF2fdxhZVbzXhX752+500X
         /Y1P450Q2IfO/URowxP9N2nqzlIoLu8D77VWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=oQMVCQ93N5I8DxFTK66O3qSj1CFQKmfDYr+u/FPQbtmUF6otr7ErfaHLJf+dfmeH1o
         vzpXOO3b6vX5lNj14vuF7cvWju9vM+ltDTrbKEBFQkJ+5njl7ML88k6Q2v3aGKT8pK3H
         3DXl3i+9Wa6wKoqTTQY/ZKKURqByMjO178Uow=
Received: by 10.213.17.200 with SMTP id t8mr1003117eba.1.1298143650738;
        Sat, 19 Feb 2011 11:27:30 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.29
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:30 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167325>

Gettextize the "Deleted %sbranch %s (was %s).\n" messages. test in
t3200-branch.sh explicitly checked for this message. Change it to skip
under GETTEXT_POISON=3DYesPlease.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/branch.c  |    2 +-
 t/t3200-branch.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index e9d8a5a..d276681 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -214,7 +214,7 @@ static int delete_branches(int argc, const char **a=
rgv, int force, int kinds)
 			ret =3D 1;
 		} else {
 			struct strbuf buf =3D STRBUF_INIT;
-			printf("Deleted %sbranch %s (was %s).\n", remote,
+			printf(_("Deleted %sbranch %s (was %s).\n"), remote,
 			       bname.buf,
 			       find_unique_abbrev(sha1, DEFAULT_ABBREV));
 			strbuf_addf(&buf, "branch.%s", bname.buf);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index f308235..04997cf 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -203,7 +203,7 @@ test_expect_success 'test deleting branch deletes b=
ranch config' \
      test -z "$(git config branch.my7.remote)" &&
      test -z "$(git config branch.my7.merge)"'
=20
-test_expect_success 'test deleting branch without config' \
+test_expect_success NO_GETTEXT_POISON 'test deleting branch without co=
nfig' \
     'git branch my7 s &&
      sha1=3D$(git rev-parse my7 | cut -c 1-7) &&
      test "$(git branch -d my7 2>&1)" =3D "Deleted branch my7 (was $sh=
a1)."'
--=20
1.7.2.3
