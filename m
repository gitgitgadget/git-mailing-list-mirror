From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [PATCH] gitweb: use decode_utf8 directly
Date: Fri, 27 Apr 2007 12:22:58 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200704271223.03468.ismail@pardus.org.tr>
References: <200704241705.19661.ismail@pardus.org.tr> <200704271155.24304.ismail@pardus.org.tr> <7v1wi6p4lt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6930967.IWzQKMHHvN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 11:21:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhMe7-00074n-9X
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 11:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509AbXD0JVk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 05:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755513AbXD0JVk
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 05:21:40 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:53738 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755509AbXD0JVj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 05:21:39 -0400
Received: from southpark.local (unknown [85.96.74.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 975BC5F94C42;
	Fri, 27 Apr 2007 12:21:33 +0300 (EEST)
User-Agent: KMail/1.9.6
In-Reply-To: <7v1wi6p4lt.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45712>

--nextPart6930967.IWzQKMHHvN
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 27 April 2007 12:07:58 you wrote:
> Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:
> >> I Google'd a bit but the relevant information seems to be missing about
> >> this error. Anyhow there is no need for a wrapper at all as Encode cla=
ss
> >> has a decode_utf8 function which fixes the problem I am experiencing t=
oo
> >> and chops off the unneeded wrapper.
> >>
> >> Patch against git 1.5.1.2 is attached. Comments welcome.
> >>
> >> P.S: I am using Encode 2.20 from CPAN which is the latest stable versi=
on
> >> available.
> >
> > Ping? This patch should be harmless and it fixes a real error, can it be
> > applied please?
>
> I cannot tell if it is harmless.  The original used
>
> 	decode("utf8", $str, Encode::FB_DEFAULT);
>
> and you made them to:
>
> 	decode_utf8($str);
>
> According to the documentation, decode_utf8($octets [,CHECK])
> should be equivalent to decode("utf8", $octets [,CHECK]), and
> the documentation further says that without CHECK, these
> functions assume Encode::FB_DEFAULT; in other words, these two
> should be equivalent.
>
> Which means that there is something else going on.  Your change
> may fix what you observed (I do not doubt that it fixed what you
> observed for you), but without understanding what really is
> going on (iow, why it is a fix, when the documentation clearly
> indicates they should be equivalent and it should not fix
> anything), we cannot tell what *ELSE* we are breaking with this
> change.

That might be a bug in Encode itself indeed, I will dig a bit more. Thanks.

Regards,
ismail




--nextPart6930967.IWzQKMHHvN
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)

iD8DBQBGMcD3Gp0leluI9UwRAiF1AJ9PNpl26YIsETwzEqXqj/Wt0sGiMwCfXuwJ
6Ud+thGUzG/n/pwkzbeTZCs=
=+pTN
-----END PGP SIGNATURE-----

--nextPart6930967.IWzQKMHHvN--
