From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 47/72] gettextize: git-reset reset_type_names messages
Date: Sat, 19 Feb 2011 19:24:30 +0000
Message-ID: <1298143495-3681-48-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:30:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsVJ-00042j-Rt
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756365Ab1BST3s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:29:48 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39339 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756104Ab1BST2H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:07 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347149eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Pv2BnFaXtTL5pzBUzYksPNNC4AbGRbSI7jABCocSAdY=;
        b=AJvkGNiymn1NnnE5ogAs42mVdhaAgAMInmng4yR9yEWlOtRq7R1vk5dNM3CdnfjZa1
         UpkMslOhrL0cpNhgI06MQS2hO1RaOt6BOtNT/bHh++KCjO2ijR7rGGbTa0+0psiF1PwE
         dbyVJ0UULVtvLnhihTT+jQW+tZi+Gau/0brZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uozXpnMrE9xpDhi7eLPDwMeXq5vtzuVFHfLWtMIKuTwcu4NtzBisJ2W9Y0wCS/821f
         fO/k/lfiygYo6F90iQEaM9qVk8N79Nl9yOKlC1ILjnmZqHkfZhZjeWYYMAc6C6oPG7P7
         xLj5DSnBo1w9c9q229tXfOqxRxHiZuoTDM82k=
Received: by 10.213.27.204 with SMTP id j12mr1918498ebc.85.1298143686408;
        Sat, 19 Feb 2011 11:28:06 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.05
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:05 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167368>

Make the messages in git-reset that use the reset_type_names static
array to be translatable by marking the array items with N_() and
using _() later.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/reset.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 0823955..1465174 100644
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
-			die("Cannot do %s reset with paths.",
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
1.7.2.3
