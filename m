From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 12/72] gettextize: git-add "remove '%s'" message
Date: Sat, 19 Feb 2011 19:23:55 +0000
Message-ID: <1298143495-3681-13-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:27:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsSs-0002nl-BB
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:27:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755862Ab1BST1Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:27:25 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40522 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818Ab1BST1X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:23 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347071eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=ot2yztTgxFYeXpA74eZtUbgkDNlY+uENNVJS3KP+fpA=;
        b=VTR1FoJHSs3/bNrRiefoVMDooDd0A0+wZBez/9hk1Lk+mST7FdodWtryuHY+bBUD8C
         7aFeUKMXqSz7YT39vyUIx5Him6CdTxR/nzfP2xWeIUDCvGFkRtTJeIfi0Jex5GlG23cy
         PUa0Wbk1NbH1IsAugANbNtGV1leQRkt5gE8PM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=IIgPrnXBlieIgD4qfvjIgHWH7L3Hxn9tj+z8Fc812PdO7GigiIz2PWeYA7NVrMnfCO
         4hX5Qwvk1eh1EFF+nbPwiD/mkjWOsyByCuNsSJwKpBvRsBXHCcxD67C0JsxO5IRXeNpb
         cXy2XserDGO2BZEoc6AB0azO4rnZglLH8x1Zk=
Received: by 10.213.27.71 with SMTP id h7mr432365ebc.20.1298143642295;
        Sat, 19 Feb 2011 11:27:22 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.21
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:21 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167320>

Gettextize the "remove '%s'\n" message. A test in t2200-add-update.sh
explicitly checked for this message. Change it to skip under
GETTEXT_POISON=3DYesPlease.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/add.c         |    2 +-
 t/t2200-add-update.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index b3640c5..e399d19 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -74,7 +74,7 @@ static void update_callback(struct diff_queue_struct =
*q,
 			if (!(data->flags & ADD_CACHE_PRETEND))
 				remove_file_from_index(&the_index, path);
 			if (data->flags & (ADD_CACHE_PRETEND|ADD_CACHE_VERBOSE))
-				printf("remove '%s'\n", path);
+				printf(_("remove '%s'\n"), path);
 			break;
 		}
 	}
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 0692427..64182d9 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -111,7 +111,7 @@ test_expect_success 'touch and then add explicitly'=
 '
=20
 '
=20
-test_expect_success 'add -n -u should not add but just report' '
+test_expect_success NO_GETTEXT_POISON 'add -n -u should not add but ju=
st report' '
=20
 	(
 		echo "add '\''check'\''" &&
--=20
1.7.2.3
