From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2 9/9] sha1_name.c: get_describe_name() by definition
 groks only commits
Date: Thu, 21 Jun 2012 11:22:07 +0200
Message-ID: <CABPQNSZ246Y80WJN+u2OR8_3KWE_1=8F6WbTgVX-8wqyecGPkg@mail.gmail.com>
References: <1340260532-11378-1-git-send-email-gitster@pobox.com> <1340260532-11378-10-git-send-email-gitster@pobox.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 11:23:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShdbJ-0006N6-FC
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 11:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472Ab2FUJWt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Jun 2012 05:22:49 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47788 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932465Ab2FUJWs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jun 2012 05:22:48 -0400
Received: by dady13 with SMTP id y13so614406dad.19
        for <git@vger.kernel.org>; Thu, 21 Jun 2012 02:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=RgWow8vTc7EMdIZRQHCL0Y4GgUY5+qSnBYirk36F7nk=;
        b=OE61BNSi3YiZQt3RrpYOU9SE1WD7dDc6GpHZaPWIn46f3VxP5qVkxhCFYKChVNp3j+
         2TUTlCgLcL5wY6cYGhLQwpOMIcL18klYXtc/NedDUYFihnIyYdv/AYCSC2quoJMgvdjD
         gu2+HMuYAGocKI42ThR/KN4A6+vgEg6NspXbNiV2Qzckna8dfM6Br/dfb7wXAEv/fRHY
         sihv1P/t3iGLwkTM6JRI5pv/DFWK1gmoP7Ypaw1u6E4MR5RdFWpJnKuynY991jVBMo02
         3U+QM3AJrs7Bnu3Cw97RdyLu8Glym2y/JN3wmxPbT86TWYICmZnau0g3hGX0Ijpk5CiO
         OpBQ==
Received: by 10.68.134.201 with SMTP id pm9mr87527808pbb.49.1340270568009;
 Thu, 21 Jun 2012 02:22:48 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Thu, 21 Jun 2012 02:22:07 -0700 (PDT)
In-Reply-To: <1340260532-11378-10-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200399>

On Thu, Jun 21, 2012 at 8:35 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> =A0sha1_name.c | 3 ++-
> =A01 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 58dbbe2..15e97eb 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -606,6 +606,7 @@ static int peel_onion(const char *name, int len, =
unsigned char *sha1)
> =A0static int get_describe_name(const char *name, int len, unsigned c=
har *sha1)
> =A0{
> =A0 =A0 =A0 =A0const char *cp;
> + =A0 =A0 =A0 unsigned flags =3D GET_SHORT_QUIETLY | GET_SHORT_COMMIT=
_ONLY;
>
> =A0 =A0 =A0 =A0for (cp =3D name + len - 1; name + 2 <=3D cp; cp--) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char ch =3D *cp;
> @@ -616,7 +617,7 @@ static int get_describe_name(const char *name, in=
t len, unsigned char *sha1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ch =3D=3D 'g' && c=
p[-1] =3D=3D '-') {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cp++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len -=3D=
 cp - name;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
get_short_sha1(cp, len, sha1, GET_SHORT_QUIETLY);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
get_short_sha1(cp, len, sha1, flags);

Is there a reason why you chose to put the definition in the
root-scope of the function? There's an excellent opportunity just a
few lines above the only place it's used, and I suspect it would
increase readability to put it there...
