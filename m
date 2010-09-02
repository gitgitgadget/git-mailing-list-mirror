From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 19/25] gettextize: git-reset reset_type_names messages
Date: Thu,  2 Sep 2010 19:40:40 +0000
Message-ID: <1283456446-22577-20-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 21:42:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFgS-0006jt-Qc
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756679Ab0IBTm2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:42:28 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61967 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756629Ab0IBTm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:42:26 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so1282023wwj.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=8kkMjizJQ6ovO/4DVgEHsOIryIOa/KWZeJ2SUxSRiRY=;
        b=fNJZtbFzC95AjgDpWCR2g3yJv5sqAzVX5FUndGC+poSa56YHLWiMen+iDlaQkHGkv3
         L6jxgPs8g1y6a6c+Vo8Qi+GXzniKIneb1TsKLAcMxrUQmoRaVQEZFGCgWONhjO8TCwK6
         0nt6Fzici72bF9uwv97zn/BKwMwpwEgV36oQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=CLasQ0xMtFXD5r7ZdIYuV/p0JaZxDokH3Z4ATIv2tOM/3V4j+1wZlMJWITNEFeVxxy
         QsW0fQM3g/JHTHsvpNaBA2SDhmRnXZCoHJ4hB+XlTHSR3cE95BLnuOnTX4HPlni+Qmdl
         kRRAOurobwIEhVYqEFv3nGnohhRWKEQ5NFbl0=
Received: by 10.227.129.80 with SMTP id n16mr212941wbs.104.1283456545793;
        Thu, 02 Sep 2010 12:42:25 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.42.25
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:42:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155180>

Make the messages in git-reset that use the reset_type_names static
array to be translatable by marking the array items with N_() and
using _() later.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/reset.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index bf69444..0557688 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -30,7 +30,7 @@ static const char * const git_reset_usage[] =3D {
=20
 enum reset_type { MIXED, SOFT, HARD, MERGE, KEEP, NONE };
 static const char *reset_type_names[] =3D {
-	"mixed", "soft", "hard", "merge", "keep", NULL
+	N_("mixed"), N_("soft"), N_("hard"), N_("merge"), N_("keep"), NULL
 };
=20
 static char *args_to_str(const char **argv)
@@ -228,8 +228,8 @@ static void prepend_reflog_action(const char *actio=
n, char *buf, size_t size)
 static void die_if_unmerged_cache(int reset_type)
 {
 	if (is_merge() || read_cache() < 0 || unmerged_cache())
-		die("Cannot do a %s reset in the middle of a merge.",
-		    reset_type_names[reset_type]);
+		die(_("Cannot do a %s reset in the middle of a merge."),
+		    _(reset_type_names[reset_type]));
=20
 }
=20
@@ -320,8 +320,8 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 		if (reset_type =3D=3D MIXED)
 			warning(_("--mixed with paths is deprecated; use 'git reset -- <pat=
hs>' instead."));
 		else if (reset_type !=3D NONE)
-			die("Cannot do %s reset with paths."
-					reset_type_names[reset_type]);
+			die(_("Cannot do %s reset with paths."),
+					_(reset_type_names[reset_type]));
 		return read_from_tree(prefix, argv + i, sha1,
 				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
 	}
@@ -332,8 +332,8 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 		setup_work_tree();
=20
 	if (reset_type =3D=3D MIXED && is_bare_repository())
-		die("%s reset is not allowed in a bare repository",
-		    reset_type_names[reset_type]);
+		die(_("%s reset is not allowed in a bare repository"),
+		    _(reset_type_names[reset_type]));
=20
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset
--=20
1.7.2.2.614.g1dc9
