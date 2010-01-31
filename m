From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [RFH] rpm packaging failure
Date: Sat, 30 Jan 2010 23:12:36 -0500
Message-ID: <20100131041236.GP29188@inocybe.localdomain>
References: <7v8wbgueqz.fsf@alter.siamese.dyndns.org>
 <20100130151921.GM29188@inocybe.localdomain>
 <7vsk9nsemh.fsf@alter.siamese.dyndns.org>
 <20100130194746.GN29188@inocybe.localdomain>
 <7vd40rjks4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="6lXr1rPCNTf1w0X8"
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 05:14:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbRC3-0007Ob-0m
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 05:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219Ab0AaEMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 23:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082Ab0AaEMr
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 23:12:47 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61577 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab0AaEMq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 23:12:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E815957EB;
	Sat, 30 Jan 2010 23:12:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=ufYXJmmpydL+1bodCs1X1t5TOTM=; b=bR4dnay
	4VTBRgnOYmHA4QqMf8bvjuyJNowKrWpmC4CAF9U3i0G/sVD5IkORbXa0G53QA2BT
	SxWIlIPBOObU/HXp8d4Q0bS69voxuI8sFx+LhIwAxMWEmoiUWAeQ7k86pXX+JbFc
	YEyhAt8hgKg9HcZIQwRYQ7yCFid0YJG1T/eA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=Dpu+ab9IphumVsxuJpH0+ufseyEqitaHD
	LzGVOPbT+O2Io0838JO2qn+ujRCVJXaHUj8Y64GKb0OXM1F6w4D6hWpNYjqiHhNK
	3spo3o/StD31dFG48ZQoW0Us/WvFTzanjhBnvz0OQFki1RYSU3akcJK/JzPt52aJ
	dDb+O3TV+Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 17365957EA;
	Sat, 30 Jan 2010 23:12:41 -0500 (EST)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7EC85957E6; Sat, 30 Jan
 2010 23:12:37 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vd40rjks4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: DFC8671A-0E1E-11DF-A676-6AF7ED7EF46B-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138528>


--6lXr1rPCNTf1w0X8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> To allow us to go forward a bit easier, I am planning to use the
> attached, as we would need some parts of it when we do start
> generating a separate package, I think.

Sounds good.  One minor nit, below... ;)

>  %define path_settings ETC_GITCONFIG=3D/etc/gitconfig prefix=3D%{_prefix}=
 mandir=3D%{_mandir} htmldir=3D%{_docdir}/%{name}-%{version}
> +%{!?python_sitelib: %define python_sitelib %(%{__python} -c "from distut=
ils.sysconfig import get_python_lib; print get_python_lib()")}

It is probably better to use %global rather than %define here.  The
Fedora packaging guidelines now recommend this:

http://fedoraproject.org/wiki/Packaging/Guidelines#.25global_preferred_over=
_.25define

The rationale is that %define only really lasts until the closing
brace, while %global persists.  A bug in rpm has masked this for a
long time, but it now fixed in upstream rpm, which is packaged for
Fedora's rawhide and possible other rpm-based distros.  A bit more
detail is available at:

https://www.redhat.com/archives/fedora-devel-list/2010-January/msg00093.html

(Which is linked, with an incorrect trailing '|' character from the
Fedora guidelines URL above.)

Using %global should work on older rpm versions as well as current
versions, so there should be no downside to using s/%define/%global in
most cases.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The secret to success is knowing who to blame for your failures.
    -- Demotivators (www.despair.com)


--6lXr1rPCNTf1w0X8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJLZQMzJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjLkwH/0GnVWw0KGFnjslCqmmqkioZS6TLL4vGCf1m
FaCZ15jn2Gc9Bw/iTQuMDMv/STWJRi8Q4bUHDVZyqI/Y5M0KoLEkf/Cmhh9brlSp
47esn3wfO3kqaosQs8CtLlfeBlUS49Oc4CdH6cDFc6XNgWVV7n9Ay7nksasCdrF1
jngTGxADCpEZV1H10RbuAfAvPGSUxP1K0OVpU8ZXKS6raPNSEuns/huDC+0Ld6fM
GElJqUejt/y9DgXmUl877+aR1EYnwlYgK9OcOV2Olnc38D5v6kyVKaPhTqypbTYh
hV1INv0WjSK82OH/Jan+4XLfLuYzNFDRyBrXcX91d3nwQagQ8aE=
=L2B4
-----END PGP SIGNATURE-----

--6lXr1rPCNTf1w0X8--
