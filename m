From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH 1/9] builtin-verify-tag.c: use parse_options()
Date: Thu, 24 Jul 2008 18:59:15 +0200
Message-ID: <4888B4E3.9000504@free.fr>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com> <1216849332-26813-2-git-send-email-barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 19:00:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM4Ar-0000S2-Nw
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 19:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbYGXQ7S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 12:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbYGXQ7S
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 12:59:18 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:53646 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797AbYGXQ7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 12:59:17 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id BBF8B12B6B7;
	Thu, 24 Jul 2008 18:59:16 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id EA90512B6AB;
	Thu, 24 Jul 2008 18:59:15 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <1216849332-26813-2-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89912>

Michele Ballabio a =E9crit :
>=20
>  	if (argc =3D=3D 1)
> -		usage(builtin_verify_tag_usage);
> +		usage_with_options(builtin_verify_tag_usage, options);

It seems this is broken since the C rewrite: "git verify-tag -v" just d=
o
nothing instead of printing usage message.

Moving the if() after parse_options() call with s/argc =3D=3D 1/argc =3D=
=3D 0/
should do the trick.

> -	if (!strcmp(argv[i], "-v") || !strcmp(argv[i], "--verbose")) {
> -		verbose =3D 1;
> -		i++;
> -	}
> +	argc =3D parse_options(argc, argv, options, builtin_verify_tag_usag=
e, 0);

Olivier.
