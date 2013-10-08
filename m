From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] blame: add color
Date: Tue, 08 Oct 2013 16:39:35 +0200
Message-ID: <52541927.5010206@googlemail.com>
References: <1381241929-23378-1-git-send-email-christopherarges@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rW7Uru4MEL6mwjVTuxrwJAqjhH8HViEcW"
To: Chris J Arges <christopherarges@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 08 16:40:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTYSJ-0001Jq-Vz
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 16:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754328Ab3JHOkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 10:40:08 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:55748 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab3JHOkG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Oct 2013 10:40:06 -0400
Received: by mail-ee0-f49.google.com with SMTP id d41so4057440eek.36
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 07:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type;
        bh=XVe0GuQiZNn3KkM/MdaQX/5vsAMNnbWKcg0+J0reOkA=;
        b=SSszT0eeD/N4xaGRzyWcDNzk3JryFvigvDrznjbpOvsCq8mHxR9ehT5qFiffs5v11m
         p+DpZcpt1xhyRsnAWQdGnn4t3WcailaetVYZxQdEk5+rg/9EJHi3tseT642Rw5c5F63O
         IaWsgJuxxQS8eDHTXSK/kM/KMBlO3uwNT9fwK+J29gY8CBMRCfYwwTgXOO/9tkZFCyes
         IWRSpLZT+5zhwlccTXW1ixLnDOotolQ84RxgImgu8HP0efHj8133YAclCsW2HBsZ+raD
         I5Z5bZkqeOEU/R8j1W7uGvIxNouQvAjE1sn7JPPoGZbXiBN6reYAeEelszg1eWRjI9gv
         6d/g==
X-Received: by 10.14.95.137 with SMTP id p9mr2847813eef.73.1381243205078;
        Tue, 08 Oct 2013 07:40:05 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id b45sm76656208eef.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 08 Oct 2013 07:40:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <1381241929-23378-1-git-send-email-christopherarges@gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235778>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rW7Uru4MEL6mwjVTuxrwJAqjhH8HViEcW
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/08/2013 04:18 PM, Chris J Arges wrote:
> Add colorized text for git blame when color.interactive is enabled.
> This work is based on the colorization code in builtin/clean.c.
>=20

Another way to color blame, would be by commit, not by row.
Try "git gui blame <file>", to see what I mean. The colorisation
would be per commit and not by line.
Though I guess that's a lot of more work, but I'd personally find it
better, for what it's worth.

> =20
> +static const char *blame_get_color(enum color_blame ix)
> +{
> +	if (want_color(blame_use_color))
> +		return blame_colors[ix];
> +	return "";
> +}
The only occurence of blame_get_color is in blame_print_color, so why
not move it in there?

> +
> +static void blame_print_color(enum color_blame ix)
> +{
> +	printf("%s", blame_get_color(ix));
> +}
> +
>  static const char *format_time(unsigned long time, const char *tz_str,=


Thanks,
Stefan



--rW7Uru4MEL6mwjVTuxrwJAqjhH8HViEcW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSVBkoAAoJEJQCPTzLflhqpf0P/io6RgdrKtGE2bZ9Ugmx7H+E
cjnoKrFj47edvambwSyXlCzHgPGF1obOU/uFt9cR3XxCnihxCzFHD2NWGvYU4ur0
1Fy4ftsQDHxdBnALVGRoR8FWubs8vYQNC3r6RFjQQAbkuhJH3MkkeXD096kN41+1
SaMIVJVP4raeB6IpM6knxGozzyQsB1hBs92+k5Up62Pp4UoVz5rZYWCvXWfET6lV
3fW0BVqdmju4mQQ9CwvXkSBO6sxisNWlYd0hErNrYsyDDS4G8hotU9Zy/0VU2OaX
ThP4bdlf/2/pP78THu99vgEUSng9qw3SFggc/62jWD255wzkpAv4WVRLCfzolPDB
B8wOfzSbt4rY8OZdaNhDQQvOH6vfdNALFtr8EWYkUayDwGJcPGKb06BHEtXsX1zz
LIEOd76533NKZ82/XfkX7Oy85HPc8qCzrkPdf5F3oB+7YbGJQ1S9Ao4tXUh1pEZ1
LFpi4bHr/vB+GrcJ9NIU5bOV/FrHOLJ2AgFlB4RqkeqNiVPUoSrrJ7eNtjBldoHb
SrKjEqVlNOSXv1PV4ekJKgxsb1xBDLvwaWcpLSfLU4GYEIS42p3uESMT7wEVeX3Q
0XOjGSS5C7s+NDLZ+PzUf7xvneakTMEH0pR9+XP4+AmBJbTIxH0sHPlaXcuDhdxo
SqVm+EtME3zrk0gvKmPZ
=REMp
-----END PGP SIGNATURE-----

--rW7Uru4MEL6mwjVTuxrwJAqjhH8HViEcW--
