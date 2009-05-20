From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] setup_revisions(): do not access outside argv
Date: Wed, 20 May 2009 10:15:56 +0200
Message-ID: <4A13BC3C.5070000@viscovery.net>
References: <1242806900-3499-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 10:16:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6gyD-0008S7-OT
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 10:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbZETIQG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2009 04:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752793AbZETIQF
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 04:16:05 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:59016 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbZETIQD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 May 2009 04:16:03 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M6gxz-0006Hm-Gl; Wed, 20 May 2009 10:15:59 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 480356D9; Wed, 20 May 2009 10:15:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1242806900-3499-1-git-send-email-pclouds@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119588>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  revision.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/revision.c b/revision.c
> index 18b7ebb..be1e307 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1241,9 +1241,9 @@ int setup_revisions(int argc, const char **argv=
, struct rev_info *revs, const ch
>  		if (strcmp(arg, "--"))
>  			continue;
>  		argv[i] =3D NULL;
> -		argc =3D i;
> -		if (argv[i + 1])
> +		if (i + 1 < argc && argv[i + 1])
>  			revs->prune_data =3D get_pathspec(revs->prefix, argv + i + 1);
> +		argc =3D i;
>  		seen_dashdash =3D 1;
>  		break;
>  	}

Why is this necessary? I'd expect that argv arrays have NULL at the end=
=2E
If this is a bug, why did noboy notice this earlier? IOW, your commit
message is really lacking justification.

-- Hannes
