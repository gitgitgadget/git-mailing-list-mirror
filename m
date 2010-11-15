From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] use persistent memory for rejected paths
Date: Tue, 16 Nov 2010 00:30:49 +0100
Message-ID: <20101115233049.GA4782@localhost>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
 <20101114130205.GA27560@localhost>
 <vpq62vymmsz.fsf@bauges.imag.fr>
 <20101115194133.GA3297@localhost>
 <7v62vyjiho.fsf@alter.siamese.dyndns.org>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 00:30:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI8Vi-0006sl-PE
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 00:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758749Ab0KOXat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 18:30:49 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41104 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758345Ab0KOXas (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 18:30:48 -0500
Received: by bwz15 with SMTP id 15so70125bwz.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 15:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=6oMNf5j8b/rLnXsI6BVF9JW2fpfQcUUmMTtOR2subwY=;
        b=dgScJaxxOLWeKbzEkwhFyDKGkePCc43MaLZZnenRDStIUtoKTaNRAyPmI6mqfLcJ3E
         NvH/3eR2a+HAMZ/X6iIvS9OyA4rjIHN2caxTZXKZaUHY/XTw/ll/Ibmd98clWAZCg0lC
         4JW3ORsFDiakRrDsUATXA50ZnwShyWH1SEpHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=qjaRpVUdjyRcqGCIhLYJzmeMeMkK8JACa1KrhiqsHf6o4YGpOJqrNQzzTlyZVbn1Uo
         taSZ4kh30wrFzaAgT5tZvbjT3QMs4tuiEP1sV6EfoC2DYuEoL6s5rS2xEuJFOlGNIOsG
         5bZ+c8LzMWnkbEpI21J66oQ+1CfaQxab96xrk=
Received: by 10.204.53.193 with SMTP id n1mr6979130bkg.3.1289863846772;
        Mon, 15 Nov 2010 15:30:46 -0800 (PST)
Received: from darc.lan (p549A63CB.dip.t-dialin.net [84.154.99.203])
        by mx.google.com with ESMTPS id p22sm281008bkp.9.2010.11.15.15.30.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 15:30:45 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1PI8Vd-0001Gi-R8; Tue, 16 Nov 2010 00:30:49 +0100
Content-Disposition: inline
In-Reply-To: <7v62vyjiho.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161526>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 15, 2010 at 03:05:07PM -0800, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> > You don't have to take my word for it, just try the test. It should
> > be failing nicely.  :-)
>=20
> As far as I remember the tests were about the output order and never about
> "ah we are showing stale contents from stack" (which is rather hard to
> arrange for reliable testing anyway).

I changed t7607 to reject two paths 'sub' and 'sub2' and test the
output.  Without the fix, the output is

 error: The following untracked working tree files would be overwritten by =
    =20
 merge:                                                                    =
    =20
        sub2
        sub2                                                               =
    =20
 Please move or remove them before you can merge.                          =
    =20

since the same buffer is used for both rejected paths. So it does
fail reliably.

Clemens

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJM4cKpAAoJELKdZexG8uqMnj8H/2Y531Ep3Y6gjaWhvqohtffE
GNE0T4QVjGAHF6nPVVv/Bk7u+Ndi3LhvTLTwVn4J4yyTdR+qod29gyAkvFcZcjrj
NdeoG5APWVzrDSzjEWbVbWPmeWp8eD9QkbhKtuJ3E1LyOtB7DjIFGS3q5hE6S1rG
JajrWXow30SL1OQOVLrf5YKVuJKmA10/QtGZdfx8dJ7vrkz38Hqe8hur5MzGaG2/
afrJ0ngZqOzHip/yk7Khw17Dhe2i7D3zAEoMRsWV/TPUUX0YSUbaa4Zg90sUhp1i
wuZLeMoc8KShxYVvqlOPxoevlnQYErMIm9wP1wpmT60lXu+qORLXDGO4dkyx+3s=
=+4yX
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
