From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Transparently encrypt repository contents with GPG
Date: Fri, 13 Mar 2009 12:15:43 +0100
Message-ID: <200903131215.49336.trast@student.ethz.ch>
References: <978bdee00903121419o61cd7a87rb55809796bd257d7@mail.gmail.com> <fabb9a1e0903121434u4a3d71bdi6277071f54557a7e@mail.gmail.com> <49BA39A1.9090203@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1592618.ZQDPQFTDDC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Matthias Nothhaft <matthias.nothhaft@googlemail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 13 12:17:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li5Oj-0008K8-OE
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 12:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbZCMLQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 07:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752459AbZCMLQX
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 07:16:23 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:24655 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625AbZCMLQX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 07:16:23 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Mar 2009 12:16:19 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Mar 2009 12:16:19 +0100
User-Agent: KMail/1.11.1 (Linux/2.6.27.19-3.2-default; KDE/4.2.1; x86_64; ; )
In-Reply-To: <49BA39A1.9090203@drmicha.warpmail.net>
X-OriginalArrivalTime: 13 Mar 2009 11:16:19.0251 (UTC) FILETIME=[2219D030:01C9A3CD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113172>

--nextPart1592618.ZQDPQFTDDC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Michael J Gruber wrote:
> "git help attributes" may help: look for filter and set attributes and
> config (filter.$name.{clean,smudge}) accordingly. smudge should probably
> decrypt, clean should encrypt.

Wouldn't this trip over the randomness included in all encryption [to
avoid generating the same cyphertext for two separate identical
messages, which gives away some information], which would let git
think the file has been changed as soon as its stat info has changed
(or is just racy)?

Not to mention that this makes most source-oriented features such as
diff, blame, merge, etc., rather useless.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1592618.ZQDPQFTDDC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkm6QGUACgkQqUud07tmzP352QCeJ/K3TLnMQKxkL0XG/Qmztkn/
bdcAnR44HoenhC54DsQpWoDNR/DkvYE7
=mkd9
-----END PGP SIGNATURE-----

--nextPart1592618.ZQDPQFTDDC--
