From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [RFC/PATCH 1/4] tag: speed up --contains calculation
Date: Thu, 14 Oct 2010 00:56:01 +0200
Message-ID: <20101013225601.GC2558@localhost>
References: <20100705122723.GB21146@sigill.intra.peff.net>
 <20100705123335.GA25699@sigill.intra.peff.net>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Cc: tytso@mit.edu, Avery Pennarun <apenwarr@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 14 00:56:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6AEs-0007n1-Q0
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 00:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676Ab0JMWzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 18:55:46 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41641 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664Ab0JMWzp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 18:55:45 -0400
Received: by bwz15 with SMTP id 15so160402bwz.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 15:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=599nMO/MddYSlB6R8zemT96NGoo1sY4Es/enhuCtMV8=;
        b=Qlelmgeu6A2P2wqgQUwk5j9d792PlhfC4g1azQ8BexqpNKshsQBkSZYRXSBRzG75pG
         uFnP2VPzdhgOLPKWQaKjbqfg9HbSKvfSJjTctkD2CTsDa4BFfPKX6qrFrJTyiINvXtsx
         2aqMBQjmJaAlmi3UaYDaSR8W/UL/ae5kPTDG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=Xrlhlgs291l4H46499nL/BkoBMF7U6Lf0mR00yTBjNozRcf7jkfI4mZ5YRUymJQOwH
         MSaqDiDDfL7gIOpUp9nvfxrX1dT6JzczZ8HJJiO10Lw3oHW7hlOlq2Ld5EsT32gsZi76
         jcRCLY+78zodWLj6JfRuky0NdT44rGxWe1AhA=
Received: by 10.204.46.33 with SMTP id h33mr3881920bkf.95.1287010543524;
        Wed, 13 Oct 2010 15:55:43 -0700 (PDT)
Received: from darc.lan (p549A5B77.dip.t-dialin.net [84.154.91.119])
        by mx.google.com with ESMTPS id 4sm6659527bki.13.2010.10.13.15.55.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 15:55:42 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1P6AEr-0000yb-Ag; Thu, 14 Oct 2010 00:56:01 +0200
Content-Disposition: inline
In-Reply-To: <20100705123335.GA25699@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159002>


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 05, 2010 at 08:33:36AM -0400, Jeff King wrote:
>=20
> This sped up "git tag --contains HEAD~200" in the linux-2.6
> repository from:
>=20
>   real    0m15.417s
>   user    0m15.197s
>   sys     0m0.220s

FWIW, in the staging tree they have a new tag for almost every day.
My linux repo currently has 677 tags. This same command would
probably take hours. I have not had the patience yet to let it
finish.

With your patch I get this.

$ time git tag --contains HEAD~200
v2.6.36-rc3
v2.6.36-rc4
v2.6.36-rc5

real	0m8.047s
user	0m7.755s
sys	0m0.268s

Clemens

--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMtjkBAAoJELKdZexG8uqMLB4H/3Qdxa69xE6Tu2WcTWbpFBQ4
rpUnqYn1XlyhUadE5edVOObcNQpvF0JWUFweuD7/41qDlHyCBqmhKTD0mqvBQa9Q
wKmGCWKbw6lDHYn//4Y0MFzwQ2NLfaV9/cfNg6slR00Z34EwCD26O0vMTMD5ICz4
sK5kbGbQteO/lDUEIuyNJukFCWtJxE5D01XL6GdxY39hGQarYAQHSuFPEAVbqedy
WcJAKEec4ktoF5xuEd2a+0Y63iIwIxqB49YP/3vjPXmHNCZlz8tiOXrfw3a3Ad0A
hjjljeyD87IRWnEn8RXB15Bik4VxkFC6e7puOkCEgNYazUXtf+AFDAVbu8KXF4Q=
=fpsc
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--
