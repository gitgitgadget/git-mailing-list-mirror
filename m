From: Ryan Biesemeyer <ryan@simplymeasured.com>
Subject: Re: [PATCH] merge: make merge state available to prepare-commit-msg hook
Date: Wed, 8 Jan 2014 19:03:56 +0000
Message-ID: <4EE4E1D9-6805-4CA8-8368-6F0EA5EA9F4A@simplymeasured.com>
References: <6B177FFA-1797-45FE-9EF1-2C9E6EE8A234@yaauie.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_B96A30D2-2857-4FCB-BE0D-7421AF6D8379"; protocol="application/pgp-signature"; micalg=pgp-sha512
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: Ryan Biesemeyer <ryan@yaauie.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 20:04:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0yQA-0003Kx-Vp
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 20:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756876AbaAHTED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 14:04:03 -0500
Received: from mail-qe0-f48.google.com ([209.85.128.48]:59818 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbaAHTEA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 14:04:00 -0500
Received: by mail-qe0-f48.google.com with SMTP id k5so908580qej.21
        for <git@vger.kernel.org>; Wed, 08 Jan 2014 11:04:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:message-id:references:to;
        bh=iOxdkcyNyaXwpeK/raEkz9URyNNKo7FlXIMpiBXQ4lI=;
        b=Vt5SJtM13P0ZONzyrLqiZwwUMX9+rOytqx4iR6XNtVrofzkVA5mgr//WeJL8iDkqYe
         CG2fL+v5CIBw8C67DDSlJSvjXs2uDkUs0HLUO44WqwwtALimSUkPS5aW7wmwgU5hHa1+
         45hj+WPRgH8wARrVM4MHPbIDqx6vrPEdV+Zcn+hGghVQ+Hy2Udhw7uwuV/e8e1vqDlgp
         nLTtFwgOfDMNHGtYyELuhdMxuulvOrG96NfRTn/2inHksrXwVJwdBCuvgH9nhguRsDkg
         aWismIbBWSsNEVCIQR/ac4qYNIziibk5TOVZ12bbkejz0HI/81V1fWnFn7TGHw/vcToJ
         k+cw==
X-Gm-Message-State: ALoCoQlx+OI1ddOy6MGBxVftlk1wS847+T6c8H/0UwsNYCcI9WeBsjgYZ3Xo6lxv7cRTizqnB1v/
X-Received: by 10.49.86.169 with SMTP id q9mr211341071qez.19.1389207839955;
        Wed, 08 Jan 2014 11:03:59 -0800 (PST)
Received: from [10.40.8.139] ([69.164.175.238])
        by mx.google.com with ESMTPSA id r9sm2634972qey.19.2014.01.08.11.03.57
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 08 Jan 2014 11:03:58 -0800 (PST)
In-Reply-To: <6B177FFA-1797-45FE-9EF1-2C9E6EE8A234@yaauie.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240223>


--Apple-Mail=_B96A30D2-2857-4FCB-BE0D-7421AF6D8379
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

=46rom a1f898fdf560e719d447a544569d5d1457307855 Mon Sep 17 00:00:00 2001
From: Ryan Biesemeyer <ryan@yaauie.com>
Date: Wed, 8 Jan 2014 00:47:41 +0000
Subject: [PATCH 2/2] merge: drop unused arg from abort_commit method =
signature

Since abort_commit is no longer responsible for writing merge state, =
remove
the unused argument that was originally needed solely for writing merge =
state.

Signed-off-by: Ryan Biesemeyer <ryan@yaauie.com>
---
 builtin/merge.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index b7bfc9c..c3108cf 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -795,8 +795,7 @@ static void read_merge_msg(struct strbuf *msg)
 		die_errno(_("Could not read from '%s'"), filename);
 }
=20
-static void write_merge_state(struct commit_list *);
-static void abort_commit(struct commit_list *remoteheads, const char =
*err_msg)
+static void abort_commit(const char *err_msg)
 {
 	if (err_msg)
 		error("%s", err_msg);
@@ -812,6 +811,7 @@ N_("Please enter a commit message to explain why =
this merge is necessary,\n"
    "Lines starting with '%c' will be ignored, and an empty message =
aborts\n"
    "the commit.\n");
=20
+static void write_merge_state(struct commit_list *);
 static void prepare_to_commit(struct commit_list *remoteheads)
 {
 	struct strbuf msg =3D STRBUF_INIT;
@@ -824,15 +824,15 @@ static void prepare_to_commit(struct commit_list =
*remoteheads)
 	write_merge_msg(&msg);
 	if (run_hook(get_index_file(), "prepare-commit-msg",
 		     git_path("MERGE_MSG"), "merge", NULL, NULL))
-		abort_commit(remoteheads, NULL);
+		abort_commit(NULL);
 	if (0 < option_edit) {
 		if (launch_editor(git_path("MERGE_MSG"), NULL, NULL))
-			abort_commit(remoteheads, NULL);
+			abort_commit(NULL);
 	}
 	read_merge_msg(&msg);
 	stripspace(&msg, 0 < option_edit);
 	if (!msg.len)
-		abort_commit(remoteheads, _("Empty commit message."));
+		abort_commit(_("Empty commit message."));
 	strbuf_release(&merge_msg);
 	strbuf_addbuf(&merge_msg, &msg);
 	strbuf_release(&msg);
--=20
1.8.5



--Apple-Mail=_B96A30D2-2857-4FCB-BE0D-7421AF6D8379
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJSzaEcAAoJEC1RdCWfdCiH9IwP/A/Wqk5lwgvCxCgKpnkdRQL8
V7XR30NeDLAJGIsfaMmafOQWFg3HGFK4r+7SOyioBEN/yDWrH2YmqP8GxXIP0eXh
g+IeYWUXYffpGWREFpJWJAzRTOaGFmN6/Exu+yFOsP4BbYOtXrnKvv0VeJcooZPL
sDjHDLiQoDO6e7OL/ft8xkhlm5Pytr8+5D8WKJU56FDwyyCHhdMhPSzIjFOjuDHA
UDF2mMU0y1ud1dEMedywkknztQLS6VLIRafjWs0KMmCoDY8GIsCv0uHUOCLYlROb
CSZFSb5evptoyR4cJ322U1mAviXgi3U15nh1ySxQZSCrgyY/L2xqtvxUz55KwE9l
JxTR9kiQXqJsEQ0d7X1mpYOTIop9clQ6aZ6z3/4+9di2hRGSIgCayYBA4SiAvqW8
wUqfpE73O0Z5s3owOp+Dge5LgkxHDT6zgpdD8zAouIOD4Nc4egd19VCkJq0npwIz
/SBU3bepUtmctiq3+aAyik3QdIjM1DuiJqszrudiSRiEHJU/y3sKFnieCuEBJ/dk
4WIu8zJox3kp37JnQCs6QLSQAcVk9BJZd79pj1zbqGXvlnApLG03C06eGhMnwn4W
1ll6KLkbTXMKZgIocXYy9g1T6z1Tdl0RUD8t1ZL3qvpPdFs+pGK0XSURW5E6+lIK
+E4luAv//SEiP63vQ+g9
=SyNw
-----END PGP SIGNATURE-----

--Apple-Mail=_B96A30D2-2857-4FCB-BE0D-7421AF6D8379--
