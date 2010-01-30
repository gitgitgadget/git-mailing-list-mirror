From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [RFH] rpm packaging failure
Date: Sat, 30 Jan 2010 14:47:46 -0500
Message-ID: <20100130194746.GN29188@inocybe.localdomain>
References: <7v8wbgueqz.fsf@alter.siamese.dyndns.org>
 <20100130151921.GM29188@inocybe.localdomain>
 <7vsk9nsemh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="4f28nU6agdXSinmL"
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 20:48:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbJIa-0004UU-H0
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 20:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713Ab0A3Tr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 14:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752642Ab0A3Tr4
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 14:47:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50344 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164Ab0A3Trz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 14:47:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0930995161;
	Sat, 30 Jan 2010 14:47:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=iE+MQWR2FxubbmSA5lMog94fRlA=; b=KMrlNlU
	UFlSiHOtexlEuQzdl1S/JUiZGy6YaBzDd3EX0Buxt0lQbOacSJi+lOTGT9DZ47h2
	15X5SNglbJFwVztG680aXRFYuaixqrtCL0f7E6WLxIyv7fb9U5hZ572Onz/DzNis
	Gog0rwkc9bgkYoDgNsjBBJXP0qK/W1XfrtIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=vwX5ZqZ4UTyvgk/5CZf+MAitZjXvwWsXQ
	Yr5+BSJsy7LPrObEw6yaFei0jAb81lgGK3+U9yoRlKRelP1sFxC8x4gPbkeIkJoZ
	bc+qZQEvo7smfwSNVR/ob/0CRLKsnAjjDeJEvZ7vmoPkCuu4wNkJAo5cccDagByv
	1WQXOZSygQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CBACE95160;
	Sat, 30 Jan 2010 14:47:50 -0500 (EST)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38FA19515D; Sat, 30 Jan
 2010 14:47:47 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vsk9nsemh.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: 596025F0-0DD8-11DF-8607-6AF7ED7EF46B-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138497>


--4f28nU6agdXSinmL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> The files that are problematic are only infrastructure bits to
> support "remote helpers written in Python" (which we don't ship at
> all yet).

Ahh, I hadn't followed along closely enough to know that nothing which
used these files was installed.

> And if the removal is the way to go for 1.7.0, is the following an
> Ok approach to do that removal (this is asking an RPM help again to
> Todd)?

Not shipping them if they aren't yet used/needed for anything other
than folks working on remote helpers seems reasonable and the rm in
the spec file should do the trick nicely.  But I have to wonder why
even bother installing them via make install if folks packaging via
rpms, debs, etc. will all have to manually remove these files?

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I have never let my schooling interfere with my education.
    -- Mark Twain (1835-1910)


--4f28nU6agdXSinmL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJLZIzdJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzj0S4H/3c4+W+gC/FYirtcwInFhLaI+C6l2gPmJ2jt
G5Im4OdLdliuj2dLXJjQjF/H86npKUl259jrLZlqPB1WRDhY9Ijm5dUuWus4nCo2
0Rb9mJ6ALPCy6a5M8xUO45IbG+1srzjhV4uatDczLijgMQwpIbotcFaHHIiqajCe
9hv87Cq1DVSixdC7qQpbjq+dhSAbUGKknf+UNKgh0q4s3VTFnrr+rsrqnW9s8qVo
OkNgVgec7kjNS+3XC4VkvKEAkxWL1nukjsCOwJ025sNud0LN+P61XPWhipbMZefc
g3QSOpvcgq/qAbW/1iPxalAeeAcoMh/m9nmJmmfRpc1OLXZ9V8Y=
=Qi6C
-----END PGP SIGNATURE-----

--4f28nU6agdXSinmL--
