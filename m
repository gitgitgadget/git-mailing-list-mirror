From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 49/73] gettextize: git-reset "Unstaged changes after reset" message
Date: Tue, 22 Feb 2011 23:42:08 +0000
Message-ID: <1298418152-27789-50-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:44:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1uK-0008HI-UA
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558Ab1BVXo2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:28 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39375 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755544Ab1BVXoW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:22 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866600bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=GX53SZBixH5TmKAJYNesoyTmzNiBO8oNmzFeO151OaE=;
        b=l58HIldhhTAAr9+UATIf7/tNve0goeuKIOBlfZQiWQigRz7CVD1UiJxxYDKr8v1dbq
         7cVRbGyhPMTW92MxnbfMoyo/AlS+u+SpbBzn8GG42o8H5wOADKxa+BgXCTbawOsGpYnd
         9sFavQEzZaCDdMBiLuEmgAJzfhksIqT2bhIrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=km7fwvwQ9/2vO3n7kO1SN6uOEEhuCRr5jku5FIxW+O+p6Q7Bw6FBsyQUMdmo4PqYFz
         cLc459ZX9bH49Fjvxom0i8bJYri5el4PBSvhDVT2HivhxAx++pnvGjcW5yiAQfnnJCwf
         XRJ7cOAcwRBGreve47Yn09PEAnfNSdA//eazI=
Received: by 10.204.123.7 with SMTP id n7mr3064407bkr.33.1298418261347;
        Tue, 22 Feb 2011 15:44:21 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.20
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:20 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167608>

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
index b8cf260..7be2ff3 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -423,7 +423,7 @@ Unstaged changes after reset:
 M	file2
 EOF
=20
-test_expect_success '--mixed refreshes the index' '
+test_expect_success C_LOCALE_OUTPUT '--mixed refreshes the index' '
 	echo 123 >> file2 &&
 	git reset --mixed HEAD > output &&
 	test_cmp expect output
--=20
1.7.2.3
