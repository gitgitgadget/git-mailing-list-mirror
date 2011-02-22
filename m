From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 17/73] gettextize: git-branch "Deleted branch [...]" message
Date: Tue, 22 Feb 2011 23:41:36 +0000
Message-ID: <1298418152-27789-18-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:44:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1tk-0007ye-Un
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977Ab1BVXnv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:43:51 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39209 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584Ab1BVXns (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:48 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866615bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=HhhvRyspQE16z09DeW9kQDRl5bqSL1YcCl12tMNYMcc=;
        b=S5rePGh2UpHGkDFIR/kWu33XfLVr3uoQbItFlLk3agi7X6zkJpUzJb7K4LBNUxVkxr
         /QKcDZclYoZfy3Jd+iwbruATGGLa0/IZsdCNrlWPEqJiiLkGLEj9wxlVijHHAIF9tDNj
         iD2qAJHu7BqNdUD2wvo59qYWZx89GBeDaKlsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Jb3KyzCaW/r/xhUDhJyYCCe21R2tllNshHZxx1ao+SPnzv642WnK5btWhXuu473VGi
         zXKYFoCRbst3oWjrQgmQQ+pJdhw1tnp78kdis4ZeX0VnyLPvxrbEjDBwIc5XwAv4izkM
         fKclNrt628X7zENBK1Gan3HVPqNrIVkW1d5JM=
Received: by 10.204.22.16 with SMTP id l16mr3080251bkb.198.1298418227699;
        Tue, 22 Feb 2011 15:43:47 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.46
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:47 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167594>

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
index f308235..940d7ae 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -203,7 +203,7 @@ test_expect_success 'test deleting branch deletes b=
ranch config' \
      test -z "$(git config branch.my7.remote)" &&
      test -z "$(git config branch.my7.merge)"'
=20
-test_expect_success 'test deleting branch without config' \
+test_expect_success C_LOCALE_OUTPUT 'test deleting branch without conf=
ig' \
     'git branch my7 s &&
      sha1=3D$(git rev-parse my7 | cut -c 1-7) &&
      test "$(git branch -d my7 2>&1)" =3D "Deleted branch my7 (was $sh=
a1)."'
--=20
1.7.2.3
