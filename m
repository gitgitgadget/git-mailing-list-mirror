From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 06/16] upload-pack: use a separate variable to control 
	whether internal rev-list is used
Date: Sun, 1 Aug 2010 22:25:00 -0600
Message-ID: <AANLkTinznVOCA-SKNZOpGVtB9L+Ns2DnDtW5aRwX-Aiy@mail.gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
	<1280593105-22015-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 06:25:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfmaN-0008UE-Aa
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 06:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721Ab0HBEZF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 00:25:05 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49860 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505Ab0HBEZC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 00:25:02 -0400
Received: by wwj40 with SMTP id 40so3444153wwj.1
        for <git@vger.kernel.org>; Sun, 01 Aug 2010 21:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sJrUScHuFxUpq5DL9JGN5aAomkDqhochub2Wj/a2M7w=;
        b=kEecWtm6YymOyNflDUC15iGNyCm8mHl6ZEv8RlkU+o/W0NCn5ObtpxPHryBC9jpjBH
         NuUGJoR98e0QD5crGeiqm6EpYmiA1D2AkBXPasZIfHyo/Y5n++OI1lrzInsLhGaqv2f1
         LvwaRFxOYTg9wRbnBEBlReLVwTfqbtmKIIAdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h56z6SChqEF78yaTvzz7w8C5wGJW0ObeZIKj92a6Nu2COjPbc+CvZPAfFXitiGJj+K
         47zbtHLz7UF2fVWKEdzTDZ3kohNh82TwReLSiSPqFECjZzmG82GLR7mI1LVio3spIrol
         dKGXR2N0NPWk0rqk2rYjrCDrBt1YyYVlZBT4I=
Received: by 10.216.0.10 with SMTP id 10mr2242073wea.12.1280723100820; Sun, 01 
	Aug 2010 21:25:00 -0700 (PDT)
Received: by 10.216.132.8 with HTTP; Sun, 1 Aug 2010 21:25:00 -0700 (PDT)
In-Reply-To: <1280593105-22015-7-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152390>

Hi,

2010/7/31 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> =C2=A0upload-pack.c | =C2=A0 =C2=A09 +++++----
> =C2=A01 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index dc464d7..e432e83 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -160,8 +160,9 @@ static void create_pack_file(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t sz;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *argv[10];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int arg =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 int internal_rev_list =3D shallow_nr;
<snip>

I've got the exact same changes in one of my in-progress-patches in my
sparse-clone branch.  That is, other than the variable name, but I
like yours better.  Needless to say, I agree with this change.  :-)
