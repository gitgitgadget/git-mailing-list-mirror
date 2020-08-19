Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F96DC433E3
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 16:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797F320888
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 16:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="EoE1Ev8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHSQoo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:44:44 -0400
Received: from mout.web.de ([217.72.192.78]:39465 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgHSQoB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 12:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597855426;
        bh=sFgxq75EywJtCWSn/GlQwbKQr7tB6vBKgJsD2Cs10A8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=EoE1Ev8vk4Eo5DhseMNUdkLLaQsOMyIWHmz+DVhbUIrOCFFqzgyVdp2zGGMJb+H+I
         zlCtf1aUEnjuFSr6pbNl+FTb62iVv6q3bOUD5v6VeqwIyAyu82uJDmBHUa9nluc9U1
         hSz3botcGCVPoVMFtAJytWVgHpOiFHPeFPAbz40c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.157]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2dbt-1kxvLb19Zl-00sLKV; Wed, 19
 Aug 2020 18:43:46 +0200
Date:   Wed, 19 Aug 2020 18:43:44 +0200
From:   Lukas Straub <lukasstraub2@web.de>
To:     git <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 1/2] dir/read-cache: Allow adding .git files and
 directories
Message-ID: <b673d675eef04b9cc9b7459c066856dcea7b6eea.1597853634.git.lukasstraub2@web.de>
In-Reply-To: <cover.1597853634.git.lukasstraub2@web.de>
References: <cover.1597853634.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0oFq6E+vWsULHfY2++_5JQ.";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:s3E3odAU8A1/CfgUk1Ar7h8SKFc8/ON4/ZGEz1MTeNo8CFUIOpD
 eRN3HSyOz2qhceeBH8Ka9nGG604nOeW77b+LxCNM4ttYsKIJ8nHIw4EKw2DBdsYQXFIKMxv
 +578CwI2MdpETwSL1jPa5m27TOgkwKF3feYRakDc2/9HdMGlFzg2iH6apxJDwu2W7L2fB7N
 v8snAAdCR4l7lctP9RrhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I8QobicBf98=:/kwHjom3Ed3o9MGoNl7Nyi
 IqqVxhywKmchleUJuJgUXLdVIn6iJa3a96XgK6uu/K+rHpU+TAKpl+kZWTQP3jJcx1DIMAXhC
 Tm0wxB4oPrXI/VOyPXRAaD+83ZbSsVX6FLCnZKZEqW6TnmSM4l2hX3VVM/uGCTExmDBN+nL5I
 pjMsrhiJ+EB+kjjFfEXfkJSmGW/uDw21g72At0By7nlakRqSguaubPyP0xwOxKukwsA9/iIRN
 jEoE0I+qXbkyvaVwil+ofyLdVOg84B8iNidoKU1ThzKtftTFXUGNdrShtzb151f3xFfIMmAFx
 PjiMg+7MiDj5uuG3/IWXL1l52bkiZTqSZeL1/x4hRHg7YU9/tbzV6t5Prwo+KJ0aHu27DXdOi
 TlTea1sP5E+VQ4wUR1b6x1igReO/E5niq/XHsAdHRHv93Y4NBfp02NWnsMrZC7cwVpzv2Lm/w
 9MtANAuyCgUBCxAPBlEf5xncTRSyQIZSzTYiyaM0VLWPAtgC56bMhAmzcDVyJAFPma2o0g7iK
 ILhnfCX9iF8OzTq/4gcq/w5lGItGWM4rdwPUJRGAXS7DAPRJqi5Xr2EIXgMkYBLdIu4LL0ccL
 AEWr9PmNrjBoedA9a56ujJuEnFnyVD9cOvTNvwjN8hAdAPYVzc1gfm3lLHtbBpRCdo0GXXFLx
 tPd2AfOYOGf3H6ctwaOPkHi7XKhtydePwN3jPSUfCokXrWhdDvkXufv6pXXQ4xNm84H+HbTix
 NS5rgrNoa21qQFW0AVmmwz59PAAyTjrgqkGRnJyErK+z02XGQz9CUKqkW6HVIBfOI1VLM5Gr/
 aT4FnPKlWtajaCGupddUkmVNEXbacVPee/df9lz8onNHVldnBtpfjjvePFO55u1I+JF/xGfoW
 TVfcepUV1d6oJdeafG5tLVqFEkBFeEcF6nkOHHbDp7TKM1HNSnrmrc51wdaQdsjF+ZikQZ77A
 sqz4cQnbAzNvTRPcSCRoZ/KnzOOJgYIdZPtQUuM+40SS2IQd+WYNf0EXC8bhjNczaftyq06uD
 h59FS/5gGGDcfSUrxntJ2EBYe0jFSrFUyNbrW0Ya27wGwRsp4f7+H6lxco4jU0NrHuRsAn2qW
 3WEseybDD4b6llKPgXCi70CE7m4NRVwqu4Aivyd5fiKxdIlEwxWWljkrVctaYjZ7PuSnEfgpK
 3y4Yj3nYaRJmijvALqBL0UO0byZClBYjhUT9bQ3Esv4YpAqmus8asoI9JD5sFcEs/Rxg6xdOv
 CJbyUm/hwJgZ/G+7FN4pPjy3okn2yYpy8OdASrQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/0oFq6E+vWsULHfY2++_5JQ.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Prevent adding .git/.gitmodules only in the root of the repository.

This allows adding .git files and directories as long as they are
not in the root.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 dir.c        |  3 ++-
 read-cache.c | 59 +++++++++++++++++++++++++++++++---------------------
 2 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/dir.c b/dir.c
index fe64be30ed..a959885f50 100644
--- a/dir.c
+++ b/dir.c
@@ -2145,7 +2145,8 @@ static enum path_treatment treat_path(struct dir_stru=
ct *dir,
 	if (!cdir->d_name)
 		return treat_path_fast(dir, untracked, cdir, istate, path,
 				       baselen, pathspec);
-	if (is_dot_or_dotdot(cdir->d_name) || !fspathcmp(cdir->d_name, ".git"))
+	if (is_dot_or_dotdot(cdir->d_name) ||
+	    (path->len =3D=3D 0 && !fspathcmp(cdir->d_name, ".git")))
 		return path_none;
 	strbuf_setlen(path, baselen);
 	strbuf_addstr(path, cdir->d_name);
diff --git a/read-cache.c b/read-cache.c
index 8ed1c29b54..7fb25c23d5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -906,12 +906,7 @@ int ce_same_name(const struct cache_entry *a, const st=
ruct cache_entry *b)
 }
=20
 /*
- * We fundamentally don't like some paths: we don't want
- * dot or dot-dot anywhere, and for obvious reasons don't
- * want to recurse into ".git" either.
- *
- * Also, we don't want double slashes or slashes at the
- * end that can make pathnames ambiguous.
+ * We don't want dot or dot-dot anywhere
  */
 static int verify_dotfile(const char *rest, unsigned mode)
 {
@@ -922,10 +917,24 @@ static int verify_dotfile(const char *rest, unsigned =
mode)
 	 */
=20
 	/* "." is not allowed */
-	if (*rest =3D=3D '\0' || is_dir_sep(*rest))
+	if (rest[0] =3D=3D '\0' || is_dir_sep(rest[0]))
+		return 0;
+
+	/* ".." is not allowed */
+	if (rest[0] =3D=3D '.' && (rest[1] =3D=3D '\0' || is_dir_sep(rest[1])))
 		return 0;
=20
-	switch (*rest) {
+	return 1;
+}
+
+static int verify_dotgit(const char *rest, unsigned mode)
+{
+	/*
+	 * The first character was '.', but that
+	 * has already been discarded, we now test
+	 * the rest.
+	 */
+
 	/*
 	 * ".git" followed by NUL or slash is bad. Note that we match
 	 * case-insensitively here, even if ignore_case is not set.
@@ -935,12 +944,11 @@ static int verify_dotfile(const char *rest, unsigned =
mode)
 	 * Once we've seen ".git", we can also find ".gitmodules", etc (also
 	 * case-insensitively).
 	 */
-	case 'g':
-	case 'G':
+	if (rest[0] =3D=3D 'g' || rest[0] =3D=3D 'G') {
 		if (rest[1] !=3D 'i' && rest[1] !=3D 'I')
-			break;
+			return 1;
 		if (rest[2] !=3D 't' && rest[2] !=3D 'T')
-			break;
+			return 1;
 		if (rest[3] =3D=3D '\0' || is_dir_sep(rest[3]))
 			return 0;
 		if (S_ISLNK(mode)) {
@@ -949,17 +957,16 @@ static int verify_dotfile(const char *rest, unsigned =
mode)
 			    (*rest =3D=3D '\0' || is_dir_sep(*rest)))
 				return 0;
 		}
-		break;
-	case '.':
-		if (rest[1] =3D=3D '\0' || is_dir_sep(rest[1]))
-			return 0;
 	}
+
 	return 1;
 }
=20
 int verify_path(const char *path, unsigned mode)
 {
+	const char *orig_path =3D path;
 	char c =3D 0;
+	#define is_root(len) ((len) =3D=3D 0)
=20
 	if (has_dos_drive_prefix(path))
 		return 0;
@@ -973,8 +980,7 @@ int verify_path(const char *path, unsigned mode)
 			return 1;
 		if (is_dir_sep(c)) {
 inside:
-			if (protect_hfs) {
-
+			if (protect_hfs && is_root(path - orig_path)) {
 				if (is_hfs_dotgit(path))
 					return 0;
 				if (S_ISLNK(mode)) {
@@ -982,11 +988,7 @@ int verify_path(const char *path, unsigned mode)
 						return 0;
 				}
 			}
-			if (protect_ntfs) {
-#ifdef GIT_WINDOWS_NATIVE
-				if (c =3D=3D '\\')
-					return 0;
-#endif
+			if (protect_ntfs && is_root(path - orig_path)) {
 				if (is_ntfs_dotgit(path))
 					return 0;
 				if (S_ISLNK(mode)) {
@@ -995,11 +997,20 @@ int verify_path(const char *path, unsigned mode)
 				}
 			}
=20
+#ifdef GIT_WINDOWS_NATIVE
+			if (protect_ntfs && c =3D=3D '\\')
+				return 0;
+#endif
+
 			c =3D *path++;
 			if ((c =3D=3D '.' && !verify_dotfile(path, mode)) ||
 			    is_dir_sep(c) || c =3D=3D '\0')
 				return 0;
-		} else if (c =3D=3D '\\' && protect_ntfs) {
+			if (c =3D=3D '.' && is_root(path - orig_path -1) &&
+			    !verify_dotgit(path, mode))
+				return 0;
+		} else if (c =3D=3D '\\' && protect_ntfs &&
+			   is_root(path - orig_path)) {
 			if (is_ntfs_dotgit(path))
 				return 0;
 			if (S_ISLNK(mode)) {
--=20
2.28.0.217.ge805fe7219


--Sig_/0oFq6E+vWsULHfY2++_5JQ.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl89VsAACgkQNasLKJxd
slihQRAArvtsapMbY11V2JK+YR2nmTduZxyjETZKBd+ziNGvR5HFZbdvRYFUcW5T
/aXGGsJJR8RMCyp4aUHurw7yUK1zDHuInBrjwcsEnFzYSlkNiQntp7vmOv2HI3tm
0+PTZBTrVj3O7YNwhZM/QIlxz/asy5VSaD+FVXFlkB2uSxdCc0rrixayMS5YDUfj
vWGgukkNcvoG/BF4yfmql18G0VV0eri7k4N7OMC29X3sPiBJZ1IsjVXon3H38cuX
EbqlOQ0q88byip/LYsPl+MSL4Qir3AqLl7iYwox9UiUxmpa0nPFJRUxtq0+kWgFc
Nx3l/J/qkSwWvb7qjmUJmFR4LpTLOJXTIE7gchSpTrMscGN100/1Aqxj7yQekxUl
TFsl3whnR5ImdqpV/jVtLD2kBHc+rSVsOou8l7HjozpPBYwB8sRzxeBTSPxVPomJ
HLAC0dIQcfWPR5p9fV3AWmywQ9fKVMxP17b9DiXod4f4ruDbxKNGbgYtMVX7ZnH3
/fhcQLtF8gc4jw4eZtdbg4ZJg8bc9ohuS/QnnfSs6kPEzgIVfTB8w5tIdm3Xr1/j
8qxRVgAWZJk6vbE0c7io/2srB6X2LwfLKTQZGkTiOsiAqZkKwE9cRnnuXeeHgy30
k0fV1+Sbu99wFNC+/lLG70RvASOgTNP/vTcZhFWcvAMG1xLiuyI=
=Newp
-----END PGP SIGNATURE-----

--Sig_/0oFq6E+vWsULHfY2++_5JQ.--
