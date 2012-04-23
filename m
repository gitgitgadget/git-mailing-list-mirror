From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/10] i18n: make warn_dangling_symref() automatically append \n
Date: Mon, 23 Apr 2012 19:30:25 +0700
Message-ID: <1335184230-8870-6-git-send-email-pclouds@gmail.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 14:34:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMITh-0005az-6l
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 14:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755360Ab2DWMen convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Apr 2012 08:34:43 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55597 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab2DWMem (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 08:34:42 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so3837007pbc.19
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 05:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RzkyQXk0sz3pwDgUicYHkggM1SSwpOW8BByqx5vKk8A=;
        b=oxgPLw0ctzI2kj6WMB7b63Yd9Sa7ubnd0L8AgeniqCvIc9NDoQElKOUdcjlAh+UnAV
         W/EpQ86HBzV7T7LIFNjsXsJ9GDPKqkLP2ge+2fARwjwpkP9TRi42rfCDACTvOO3NGLy/
         bZRoX91097IbzVZQudBhWGrDk0XpkrNfv0v6CuBnShml+NHVvGkpPfq+iI70HJ0t293z
         GC0R7krLehj/pHCTOc8cMHZJyGfULP8PhPEJvuyl6dk8/KsMKabSJMFxXnWs0dxmQAlB
         yDtXrJe7ql7At4dKFrIdSx/WlUD2xyhJJf+tdKq6FwrDJENST/4+X13M2TlY3e92kftM
         hYKw==
Received: by 10.68.190.69 with SMTP id go5mr15350727pbc.98.1335184482471;
        Mon, 23 Apr 2012 05:34:42 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.59.47])
        by mx.google.com with ESMTPS id p4sm14291224pbp.13.2012.04.23.05.34.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Apr 2012 05:34:41 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 23 Apr 2012 19:31:25 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196119>

This helps remove \n from translatable strings

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch.c  |    4 ++--
 builtin/remote.c |    4 ++--
 refs.c           |    1 +
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 65f5f9b..a8c3e4c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -537,8 +537,8 @@ static int prune_refs(struct refspec *refs, int ref=
_count, struct ref *ref_map)
 	int result =3D 0;
 	struct ref *ref, *stale_refs =3D get_stale_heads(refs, ref_count, ref=
_map);
 	const char *dangling_msg =3D dry_run
-		? _("   (%s will become dangling)\n")
-		: _("   (%s has become dangling)\n");
+		? _("   (%s will become dangling)")
+		: _("   (%s has become dangling)");
=20
 	for (ref =3D stale_refs; ref; ref =3D ref->next) {
 		if (!dry_run)
diff --git a/builtin/remote.c b/builtin/remote.c
index fec92bc..1b03473 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1260,8 +1260,8 @@ static int prune_remote(const char *remote, int d=
ry_run)
 	int result =3D 0, i;
 	struct ref_states states;
 	const char *dangling_msg =3D dry_run
-		? " %s will become dangling!\n"
-		: " %s has become dangling!\n";
+		? " %s will become dangling!"
+		: " %s has become dangling!";
=20
 	memset(&states, 0, sizeof(states));
 	get_remote_ref_states(remote, &states, GET_REF_STATES);
diff --git a/refs.c b/refs.c
index c9f6835..052c2f6 100644
--- a/refs.c
+++ b/refs.c
@@ -395,6 +395,7 @@ static int warn_if_dangling_symref(const char *refn=
ame, const unsigned char *sha
 		return 0;
=20
 	fprintf(d->fp, d->msg_fmt, refname);
+	fputc('\n', d->fp);
 	return 0;
 }
=20
--=20
1.7.8.36.g69ee2
