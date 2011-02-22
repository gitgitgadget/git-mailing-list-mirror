From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 23/73] gettextize: git-checkout "HEAD is now at" message
Date: Tue, 22 Feb 2011 23:41:42 +0000
Message-ID: <1298418152-27789-24-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:47:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1wv-0001H8-3L
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:47:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755782Ab1BVXqy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:46:54 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39209 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064Ab1BVXny (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:54 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866615bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=rCRS9lbBd88OW9hFPOKUQw2+UUHOgfbKJK+rxY4JVmE=;
        b=x8mhd4A5QOaatKNrQDxpRgSAUJ9RrytJ7y1SpoxTZm2Gd+jvw0zy6k3kBz9aifmFO6
         BQ0kB/5N1N8dEIzwnLE+MIWRxJNyDhqcMBVpp08W6DJffgszjQWV7pj8gEJAx5mLnNhh
         j3mioDplfeMezugBOV+48x9vRMTWT1haoFV2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xF3A+sgwhdqVWfVbmDHuXMQK0NGdJOzT/9OvMoMERWlkXJaXYHgZ/E+gOIyt7GLXpP
         J9oONd6DGofZUkqJTtW4B3iXDc37TEb3+RbmkDSYwG+UFFVWOka0jwv2r7Rxq3vfHOPA
         fFAD8hVzgvUFcYI2iAawGfQ+Lu8b6sQ2vBESw=
Received: by 10.204.6.212 with SMTP id a20mr3047297bka.210.1298418234110;
        Tue, 22 Feb 2011 15:43:54 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.53
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:53 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167652>

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
index 1337fa5..fb1fe68 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -223,7 +223,7 @@ test_expect_success 'checkout --merge --conflict=3D=
diff3 <branch>' '
 	test_cmp two expect
 '
=20
-test_expect_success 'checkout to detach HEAD (with advice declined)' '
+test_expect_success C_LOCALE_OUTPUT 'checkout to detach HEAD (with adv=
ice declined)' '
=20
 	git config advice.detachedHead false &&
 	git checkout -f renamer && git clean -f &&
@@ -242,7 +242,7 @@ test_expect_success 'checkout to detach HEAD (with =
advice declined)' '
 	fi
 '
=20
-test_expect_success 'checkout to detach HEAD' '
+test_expect_success C_LOCALE_OUTPUT 'checkout to detach HEAD' '
 	git config advice.detachedHead true &&
 	git checkout -f renamer && git clean -f &&
 	git checkout renamer^ 2>messages &&
@@ -260,7 +260,7 @@ test_expect_success 'checkout to detach HEAD' '
 	fi
 '
=20
-test_expect_success 'checkout to detach HEAD with branchname^' '
+test_expect_success C_LOCALE_OUTPUT 'checkout to detach HEAD with bran=
chname^' '
=20
 	git checkout -f master && git clean -f &&
 	git checkout renamer^ &&
@@ -276,7 +276,7 @@ test_expect_success 'checkout to detach HEAD with b=
ranchname^' '
 	fi
 '
=20
-test_expect_success 'checkout to detach HEAD with :/message' '
+test_expect_success C_LOCALE_OUTPUT 'checkout to detach HEAD with :/me=
ssage' '
=20
 	git checkout -f master && git clean -f &&
 	git checkout ":/Initial" &&
@@ -292,7 +292,7 @@ test_expect_success 'checkout to detach HEAD with :=
/message' '
 	fi
 '
=20
-test_expect_success 'checkout to detach HEAD with HEAD^0' '
+test_expect_success C_LOCALE_OUTPUT 'checkout to detach HEAD with HEAD=
^0' '
=20
 	git checkout -f master && git clean -f &&
 	git checkout HEAD^0 &&
--=20
1.7.2.3
