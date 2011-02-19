From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 22/72] gettextize: git-checkout "HEAD is now at" message
Date: Sat, 19 Feb 2011 19:24:05 +0000
Message-ID: <1298143495-3681-23-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:27:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsTA-0002tu-0C
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982Ab1BST1r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:27:47 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56673 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755890Ab1BST1n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:43 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1970368ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=c/e6YKxMs0sCYeAr/O53dEdDJRmQxFR5ejBab0DDb7I=;
        b=IOhb1xe5rHqBvEeVVMH1BeW6kh64xsMjyZ0qmb+7ckzYXy96BOSshSBOTu3trHhODB
         n75MsKXT0+2GirL71nHzZAnazxfYpk9hGpsZG23QG9IURNi/Hu5OU/JY+C2GUKBZATqr
         uLEEFTVmPurdwAiF+4cluhcyj7L3CoqhXE/zA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=oDCZpXXLHqUmDZ4GKLdme1+NgGdOzElLpA0lI4s+6UF0zCffW2MPZRCv40PA34FmWr
         i7M5p7vYEWyjVytQvfPHhbEzUvwB/AYJZmyWXD/hIYAuuWglDBPAHRRypMBuBd/F/2wX
         3rogbhcRZ7vatcVfT3/FjK5obbJACN21LUW1I=
Received: by 10.213.30.5 with SMTP id s5mr2573133ebc.44.1298143662341;
        Sat, 19 Feb 2011 11:27:42 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.41
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:41 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167328>

Gettextize the "HEAD is now at" messages. Several tests in t7201-co.sh
explicitly checked for this message. Change them to skip under
GETTEXT_POISON=3DYesPlease.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/checkout.c |    2 +-
 t/t7201-co.sh      |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 698ac63..f833330 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -571,7 +571,7 @@ static void update_refs_for_switch(struct checkout_=
opts *opts,
 		if (!opts->quiet) {
 			if (old->path && advice_detached_head)
 				detach_advice(old->path, new->name);
-			describe_detached_head("HEAD is now at", new->commit);
+			describe_detached_head(_("HEAD is now at"), new->commit);
 		}
 	}
 	remove_branch_state();
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 1337fa5..fe7536b 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -223,7 +223,7 @@ test_expect_success 'checkout --merge --conflict=3D=
diff3 <branch>' '
 	test_cmp two expect
 '
=20
-test_expect_success 'checkout to detach HEAD (with advice declined)' '
+test_expect_success NO_GETTEXT_POISON 'checkout to detach HEAD (with a=
dvice declined)' '
=20
 	git config advice.detachedHead false &&
 	git checkout -f renamer && git clean -f &&
@@ -242,7 +242,7 @@ test_expect_success 'checkout to detach HEAD (with =
advice declined)' '
 	fi
 '
=20
-test_expect_success 'checkout to detach HEAD' '
+test_expect_success NO_GETTEXT_POISON 'checkout to detach HEAD' '
 	git config advice.detachedHead true &&
 	git checkout -f renamer && git clean -f &&
 	git checkout renamer^ 2>messages &&
@@ -260,7 +260,7 @@ test_expect_success 'checkout to detach HEAD' '
 	fi
 '
=20
-test_expect_success 'checkout to detach HEAD with branchname^' '
+test_expect_success NO_GETTEXT_POISON 'checkout to detach HEAD with br=
anchname^' '
=20
 	git checkout -f master && git clean -f &&
 	git checkout renamer^ &&
@@ -276,7 +276,7 @@ test_expect_success 'checkout to detach HEAD with b=
ranchname^' '
 	fi
 '
=20
-test_expect_success 'checkout to detach HEAD with :/message' '
+test_expect_success NO_GETTEXT_POISON 'checkout to detach HEAD with :/=
message' '
=20
 	git checkout -f master && git clean -f &&
 	git checkout ":/Initial" &&
@@ -292,7 +292,7 @@ test_expect_success 'checkout to detach HEAD with :=
/message' '
 	fi
 '
=20
-test_expect_success 'checkout to detach HEAD with HEAD^0' '
+test_expect_success NO_GETTEXT_POISON 'checkout to detach HEAD with HE=
AD^0' '
=20
 	git checkout -f master && git clean -f &&
 	git checkout HEAD^0 &&
--=20
1.7.2.3
