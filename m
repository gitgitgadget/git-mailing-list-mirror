From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: Recovering from epic fail (deleted .git/objects/pack)
Date: Wed, 10 Dec 2008 02:06:46 -0800
Organization: Slide, Inc.
Message-ID: <1228903606.4445.53.camel@starfruit.local>
References: <1228867861.14165.19.camel@starfruit.local>
	 <7vd4g051ax.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FPZVNyBFEcF9HcRoNLl7"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 11:08:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LALzF-0006Mw-Mp
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 11:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569AbYLJKGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 05:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753596AbYLJKGv
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 05:06:51 -0500
Received: from mx0.slide.com ([208.76.68.7]:58841 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753549AbYLJKGu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 05:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=9
	DAJN1rckgxB5+B1/0a13nqMX+zw1CgYXNEk3PCwLco=; b=yjUe0fhTOaWvxJgEf
	pzrhJ+QaNjnINblRt5cVE58dBLPhJ2I6ckq3T9sT2AySymxAt/JEr02iQGkk58wS
	300zxf4xbGNPsY33IR066q1f5B3BFz49GuRw39hGBCSpTj0p4CIW0wja1gNYzfAM
	6ygqrRVN1wqdJucp30UsiU6Fvk=
Received: from nat3.slide.com ([208.76.69.126]:36113 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LALxw-0002Rg-IB; Wed, 10 Dec 2008 02:06:48 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 842FB389D487;
	Wed, 10 Dec 2008 02:06:48 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.533
X-Spam-Level: 
X-Spam-Status: No, score=-2.533 tagged_above=-10 required=6.6
	tests=[AWL=-0.034, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gUrJdw22crsA; Wed, 10 Dec 2008 02:06:48 -0800 (PST)
Received: from [10.12.0.194] (unknown [10.12.0.194])
	by calculon.corp.slide.com (Postfix) with ESMTP id 19FB1389C6DF;
	Wed, 10 Dec 2008 02:06:48 -0800 (PST)
In-Reply-To: <7vd4g051ax.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.22.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102680>


--=-FPZVNyBFEcF9HcRoNLl7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-12-09 at 16:19 -0800, Junio C Hamano wrote:
> I do not know about "feasible" and "properly", but ...
>=20
>  (0) take backup of the repository of this unfortunate developer.
>=20
>  (1) make a fresh clone of the central repository that this unfortunate
>      developer's work started out from.
>=20
>  (2) copy the contents of the .git/objects/pack/ of that clone to the
>      developer's .git/objects/pack/.

This approach "sort of" worked, i.e. it worked insofar that I was able
to use the repository enough to generate a series of patch files for the
developer's work from the last two weeks to be applied to their new
clone of the central repository. Why I did this is answered below ;)

>=20
> See if "fsck --full" complains after that.  If the repository was not
> repacked during that period, all objects created by the activity by the
> unfortunate developer would be loose, so ...

tyler@ccnet:~/source/slide/brian_main> time git fsck --full
Segmentation fault

real    27m2.187s
user    10m3.238s
sys     0m16.609s
tyler@ccnet:~/source/slide/brian_main>=20

Oh well, your approach worked *enough* to get the important data out,
and that's what's most important.


Moving forward we're likely going to implement an automated process of
walking through developers' repositories and pushing any unpushed refs
to a backup repository just to make sure something like this doesn't
happen again.


Appreciate the help :)

Cheers
--=20
-R. Tyler Ballance
Slide, Inc.

--=-FPZVNyBFEcF9HcRoNLl7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkk/lLYACgkQFCbH3D9R4W+aSwCeINfva131NyhnNi1aBPi93qrh
ArIAn2oXihsDlBCNUUjk6ugMIceZGpl3
=kFrv
-----END PGP SIGNATURE-----

--=-FPZVNyBFEcF9HcRoNLl7--
