From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] gettext.c: only work around the vsnprintf bug on glibc < 2.17
Date: Sat, 30 Nov 2013 10:51:33 +0100
Message-ID: <m2y546b4ka.fsf@linux-m68k.org>
References: <1385776291-21006-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	vnwildman@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 30 10:52:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmhDj-0005WC-RH
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 10:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979Ab3K3JwA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Nov 2013 04:52:00 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:45914 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab3K3Jvk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Nov 2013 04:51:40 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3dWnt236y1z4KK2s;
	Sat, 30 Nov 2013 10:51:38 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3dWnt22wJWzbbkr;
	Sat, 30 Nov 2013 10:51:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 0knniSe47SoJ; Sat, 30 Nov 2013 10:51:37 +0100 (CET)
X-Auth-Info: iJS6P2bPKW8fIBx1C+MJtAJdjlxpZJVo7lDAf1QD3No=
Received: from linux.local (ppp-88-217-45-183.dynamic.mnet-online.de [88.217.45.183])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat, 30 Nov 2013 10:51:37 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
	id D9A8B1E566D; Sat, 30 Nov 2013 10:51:34 +0100 (CET)
X-Yow: My mind is making ashtrays in Dayton....
In-Reply-To: <1385776291-21006-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 30
 Nov 2013 08:51:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238551>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> diff --git a/gettext.c b/gettext.c
> index 71e9545..91e679d 100644
> --- a/gettext.c
> +++ b/gettext.c
> @@ -18,6 +18,13 @@
>  #	endif
>  #endif
> =20
> +#ifdef USE_GLIBC
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif

Defining a feature test macro after any system header is included is
undefined.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
