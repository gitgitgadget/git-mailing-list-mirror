From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH v4 16/73] gettextize: git-branch "remote branch '%s' not
 found" message
Date: Sun, 27 Feb 2011 20:14:11 +0100
Message-ID: <4D6AA283.6010102@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org> <1298418152-27789-17-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 20:14:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptm4Y-0007oU-SM
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 20:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320Ab1B0TOW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Feb 2011 14:14:22 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47685 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab1B0TOV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 14:14:21 -0500
Received: by bwz15 with SMTP id 15so3183039bwz.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 11:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=AgT9tiMllXZv42M6f1yRaoCNr3uhRmEJBwMfUyq5Y+k=;
        b=JkmFdtCM6xuJQowOTh/LeBG+k6fEN07KgGyoJBVgKnEFJnd6ppkUk3BazCqF2bQP7V
         b43n7SK/l0/pbRS1Oqt1u0tWGjaz/GsaB8pbXGSQzO82Db+jlIXzagFGWt2T9GFdaMDK
         UyX4dWJ6/16F55R7HBk9gQZ6SdKUnYV0l28Vk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=eNTXogJ4QmcQ2WtnvrKAvUjbr+V2g58+cBQnsGTrVHtYsFw/flvlExSaPwzRJv3I/+
         9DFW/dElIxRJVF1DAGiZ3mVyP/cMutda0tutrhphoeuhloeZl7g717Fs7LefCjRkzWT+
         Rn9yCkMpXX8SqJigmMRn4B0HKMrzA9YIFIIyo=
Received: by 10.204.66.65 with SMTP id m1mr4012659bki.71.1298834059929;
        Sun, 27 Feb 2011 11:14:19 -0800 (PST)
Received: from [192.168.1.101] (apj236.neoplus.adsl.tpnet.pl [83.26.143.236])
        by mx.google.com with ESMTPS id j11sm2010446bka.0.2011.02.27.11.14.17
        (version=SSLv3 cipher=OTHER);
        Sun, 27 Feb 2011 11:14:18 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <1298418152-27789-17-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168049>

W dniu 23.02.2011 00:41, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason pisze:
> This could be done better by splitting it up, but it would change too
> much code, which I'm trying to avoid at this point. Instead add a
> TRANSLATORS comment to explain what "remote " does.

Not sure what you meant by splitting it up. Hopefully not splitting the
text even more?

IMO all such code will have to be rewritten to allow better translation=
=2E
Example patch at the bottom.

I remember at least one more such case - it was sth like "%s %s %s" whe=
re
first part was translatable but defined somewhere else.

This can be done before or after applying the i18n patches, but if it's=
 going
to be done after, then I think it'd be better to mark such places as "t=
o be
rewritten" instead of just simply marking them for translation.

>=20
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---
>  builtin/branch.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 6695db4..e9d8a5a 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -157,7 +157,8 @@ static int delete_branches(int argc, const char *=
*argv, int force, int kinds)
>  	switch (kinds) {
>  	case REF_REMOTE_BRANCH:
>  		fmt =3D "refs/remotes/%s";
> -		remote =3D "remote ";
> +		/* TRANSLATORS: This is "remote " in "remote branch '%s' not found=
" */
> +		remote =3D _("remote ");
>  		force =3D 1;
>  		break;
>  	case REF_LOCAL_BRANCH:


--->8---
=46rom a82add2f0562839e60611e7c3f3409d6cea87ad1 Mon Sep 17 00:00:00 200=
1
=46rom: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date: Sun, 27 Feb 2011 19:55:48 +0100
Subject: [PATCH] Change how error message is created for easier transla=
tion

When a text is split or stiched together from several
texts it's very hard/impossible to do a good translation.

Signed-off-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
---
 builtin/branch.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index fe8f2fc..e4adc34 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -149,20 +149,20 @@ static int delete_branches(int argc, const char *=
*argv, int force, int kinds)
 	struct commit *rev, *head_rev =3D NULL;
 	unsigned char sha1[20];
 	char *name =3D NULL;
-	const char *fmt, *remote;
+	const char *fmt;
 	int i;
 	int ret =3D 0;
 	struct strbuf bname =3D STRBUF_INIT;
+	int is_remote =3D 0;
=20
 	switch (kinds) {
 	case REF_REMOTE_BRANCH:
 		fmt =3D "refs/remotes/%s";
-		remote =3D "remote ";
+		is_remote =3D 1;
 		force =3D 1;
 		break;
 	case REF_LOCAL_BRANCH:
 		fmt =3D "refs/heads/%s";
-		remote =3D "";
 		break;
 	default:
 		die("cannot use -a with -d");
@@ -186,8 +186,9 @@ static int delete_branches(int argc, const char **a=
rgv, int force, int kinds)
=20
 		name =3D xstrdup(mkpath(fmt, bname.buf));
 		if (!resolve_ref(name, sha1, 1, NULL)) {
-			error("%sbranch '%s' not found.",
-					remote, bname.buf);
+			const char *error_str =3D is_remote ? "Remote branch '%s' not found=
=2E" :
+				"Branch '%s' not found.";
+			error(error_str, bname.buf);
 			ret =3D 1;
 			continue;
 		}
@@ -208,12 +209,15 @@ static int delete_branches(int argc, const char *=
*argv, int force, int kinds)
 		}
=20
 		if (delete_ref(name, sha1, 0)) {
-			error("Error deleting %sbranch '%s'", remote,
-			      bname.buf);
+			const char *error_str =3D is_remote ? "Error deleting remote branch=
 '%s'" :
+				"Error deleting branch '%s'";
+			error(error_str, bname.buf);
 			ret =3D 1;
 		} else {
 			struct strbuf buf =3D STRBUF_INIT;
-			printf("Deleted %sbranch %s (was %s).\n", remote,
+			const char *error_str =3D is_remote ? "Deleted remote branch %s (wa=
s %s).\n" :
+				"Deleted branch %s (was %s).\n";
+			printf(error_str,
 			       bname.buf,
 			       find_unique_abbrev(sha1, DEFAULT_ABBREV));
 			strbuf_addf(&buf, "branch.%s", bname.buf);
--=20
1.7.1


--=20
Piotr Krukowiecki
