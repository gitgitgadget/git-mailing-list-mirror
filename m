From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] New files in git weren't being downloaded during CVS
 update
Date: Mon, 22 Jan 2007 12:08:18 +0100
Message-ID: <45B49B22.6050806@fs.ei.tum.de>
References: <200701221044.49467.andyparkins@gmail.com> <200701221056.27599.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD71175DF88335CA2977643C4"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 12:08:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8x2K-00020d-RJ
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 12:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbXAVLIZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 06:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649AbXAVLIZ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 06:08:25 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:41387 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbXAVLIY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 06:08:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id AB42128098;
	Mon, 22 Jan 2007 12:08:22 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id dpY5jmT9i7kY; Mon, 22 Jan 2007 12:08:22 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-209-216.dynamic.mnet-online.de [62.216.209.216])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 276A828096;
	Mon, 22 Jan 2007 12:08:22 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200701221056.27599.andyparkins@gmail.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37407>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD71175DF88335CA2977643C4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Andy Parkins wrote:
> @@ -876,9 +876,9 @@ sub req_update
>                  print "MT newline\n";
>  		next;
>  	    }
> -	    elsif ( !defined($wrev) || $wrev =3D=3D 0 )
> +	    elsif ( (!defined($wrev) || $wrev =3D=3D 0) && (!defined($meta->{=
revision}) || $meta->{revision} =3D=3D 0) )
>  	    {
> -	        $log->info("Tell the client the file will be added");
> +	        $log->info("Tell the client the file is scheduled for additio=
n");

This is nice but probably does not handle a collision (cvs output: file w=
as added by a third party) well and will probably overwrite the locally a=
dded file.  however it is a step in the right direction.  from skimming t=
he code I couldn't find collision handling anyways.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enigD71175DF88335CA2977643C4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFtJslr5S+dk6z85oRAsHTAJ4pTiSnnkpkzCuO3YDmLjm8zLM/bACgn5VO
pjJbIQJAknnm7mXVs3xdZJA=
=x0DY
-----END PGP SIGNATURE-----

--------------enigD71175DF88335CA2977643C4--
