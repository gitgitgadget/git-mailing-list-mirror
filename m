From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] branch: reject -D/-d without branch name
Date: Fri, 25 Jan 2013 09:45:29 +0100
Message-ID: <vpqmwvxhcra.fsf@grenoble-inp.fr>
References: <1359102416-1240-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 09:46:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyevE-0000fa-0z
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 09:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979Ab3AYIpj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2013 03:45:39 -0500
Received: from mx2.imag.fr ([129.88.30.17]:36849 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754547Ab3AYIpf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 03:45:35 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r0P8jTVj022902
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 25 Jan 2013 09:45:29 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Tyeuf-0003xb-QF; Fri, 25 Jan 2013 09:45:29 +0100
In-Reply-To: <1359102416-1240-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 25
 Jan 2013 15:26:56 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 25 Jan 2013 09:45:29 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0P8jTVj022902
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1359708329.651@6cD1Q2G83nemm4geo8eTDQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214515>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 873f624..1d3e842 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -837,7 +837,7 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
>  		colopts =3D 0;
>  	}
> =20
> -	if (delete)
> +	if (delete && argc)
>  		return delete_branches(argc, argv, delete > 1, kinds, quiet);
>  	else if (list) {
>  		int ret =3D print_ref_list(kinds, detached, verbose, abbrev,

Shouldn't this error out with a clean error message ("branch name
expected" or so)?

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
