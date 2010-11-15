From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] use persistent memory for rejected paths
Date: Mon, 15 Nov 2010 20:02:06 +0100
Message-ID: <20101115190206.GA2992@localhost>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
 <20101114130205.GA27560@localhost>
 <7vvd3yl9q2.fsf@alter.siamese.dyndns.org>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 20:02:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI4Jh-0007sL-43
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 20:02:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644Ab0KOTCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 14:02:08 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58010 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932737Ab0KOTCG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 14:02:06 -0500
Received: by gxk23 with SMTP id 23so3136628gxk.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 11:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=agob7UDRZFQv3a6I4iQTn8Sl4x/O4SpsDD3juWOeELU=;
        b=XxVOVw+QCSwx6bq6EYA539jsrACQZswmrUcsbGI+ubve0fL91EGCkrjkQJlMPax4s3
         qCN+9TIaOjdGCuOCXD6nej7jtk4QEuiUvpW6al8pTkSqwy7keDsJ/A/AHVkmMw7QnWH2
         s+OQI7w15doka+WkCcXut6gpu/cnN89/WH7iw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=YHS00nMG9bHHlvqOMh7VjFbVrotstMNqn1AlJRclHcI3r1wgE/y36kl/Xv04VKod4n
         1SknOhiy4zojCR/IfQ3QG0vNcd5DJBYhj9UGrGnBv7mcAkDsWhahHi9XpRj9BL5kNfR7
         ivwRAa6Pf4ME+HQFjLsKpBMWliEdgRiyI3wyI=
Received: by 10.204.79.9 with SMTP id n9mr6418534bkk.126.1289847724765;
        Mon, 15 Nov 2010 11:02:04 -0800 (PST)
Received: from darc.lan (p549A63CB.dip.t-dialin.net [84.154.99.203])
        by mx.google.com with ESMTPS id p34sm172181bkf.15.2010.11.15.11.02.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 11:02:02 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1PI4Ja-0000n9-OJ; Mon, 15 Nov 2010 20:02:06 +0100
Content-Disposition: inline
In-Reply-To: <7vvd3yl9q2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161502>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 15, 2010 at 10:31:33AM -0800, Junio C Hamano wrote:
>=20
> Hmmm, all calls to add_rejected_path() seems to be with ce->name as the
> path parameter,

Yes. All of them except for the leading path checks I introduced
recently. In that code path we have to report untracked files which
do not have a corresponding index entry.

> That is true but I wonder if the order should be "whatever the processing
> order happens to be" in the first place, as this is a report to the end
> user, no?  Perhaps "collect in strlist, sort at the end before showing" is
> a more desirable thing to do?

Is the order of processing not alphabetic? It is at least in the
tests that I touched.

Clemens

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJM4YOuAAoJELKdZexG8uqMZWgH/3ZvuFUwET0CLX0oiPlU3Hsq
idyXHZ4HIR5Nh6S3jBBxGoz5n8O0FbCu91OP35odKSdkflmPfG84VmJhFgdlDgr0
hEvrZf1i6dhCoqiPIBLeELuTZwgA2eH3gdETtMQmXOtQ2khY9ECciD5IoBvnUt5I
tGrEoTlXJF/se2tMWY7d5Dpica6cjfPamEBm2wVMaKa0+AJPL6tDQV6SmUGQwuK1
i/q7oL29fXIIRV2kFEYnxhKTq1DhNlKe1L4g3lcGbDu4hxHpVky7jbgq+wkJkK8O
pqHOUWjBLdiABp5ybKMked6A0weqeve/tAK6cNf5SuEikynealerPPnolfvKPPc=
=cfo5
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
