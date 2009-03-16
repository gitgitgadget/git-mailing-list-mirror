From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] grep: prefer builtin over external one when coloring
 results
Date: Mon, 16 Mar 2009 18:31:17 +0100
Message-ID: <49BE8CE5.2020603@lsrfire.ath.cx>
References: <49B6979B.8080900@lsrfire.ath.cx> <1237170004-27768-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, thiago.salves@gmail.com
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon Mar 16 18:33:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjGgQ-0001EQ-2U
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 18:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218AbZCPRbb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Mar 2009 13:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754282AbZCPRbb
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 13:31:31 -0400
Received: from india601.server4you.de ([85.25.151.105]:55790 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911AbZCPRbb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 13:31:31 -0400
Received: from [10.0.1.101] (p57B7E56F.dip.t-dialin.net [87.183.229.111])
	by india601.server4you.de (Postfix) with ESMTPSA id D77812F8050;
	Mon, 16 Mar 2009 18:31:25 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <1237170004-27768-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113348>

pclouds@gmail.com schrieb:
> As far as I know, not all grep programs support coloring, so we shoul=
d
> rely on builtin grep. If you want external grep, set
> color.grep.external to empty string.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  How about this?
>=20
>  builtin-grep.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/builtin-grep.c b/builtin-grep.c
> index 9e7e766..89489dd 100644
> --- a/builtin-grep.c
> +++ b/builtin-grep.c
> @@ -825,6 +825,8 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
>  		}
>  	}
> =20
> +	if (opt.color && !opt.color_external)
> +		builtin_grep =3D 1;
>  	if (!opt.pattern_list)
>  		die("no pattern given.");
>  	if ((opt.regflags !=3D REG_NEWLINE) && opt.fixed)

Makes sense, thanks!

Ren=C3=A9
