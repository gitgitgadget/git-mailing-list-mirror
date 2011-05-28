From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: git show and the --quiet option
Date: Sat, 28 May 2011 19:26:11 +0200
Message-ID: <20110528172611.GB28708@centaur.lab.cmartin.tk>
References: <4DE12888.1040506@isy.liu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Cc: git@vger.kernel.org
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Sat May 28 19:34:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQNOw-0001gN-C1
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 19:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611Ab1E1ReA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2011 13:34:00 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:37615 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754103Ab1E1Rd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 13:33:59 -0400
X-Greylist: delayed 463 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 May 2011 13:33:59 EDT
Received: from centaur.lab.cmartin.tk (brln-4db9cec2.pool.mediaWays.net [77.185.206.194])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id CB58E4615D;
	Sat, 28 May 2011 19:25:48 +0200 (CEST)
Received: (nullmailer pid 28803 invoked by uid 1000);
	Sat, 28 May 2011 17:26:11 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Gustaf Hendeby <hendeby@isy.liu.se>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4DE12888.1040506@isy.liu.se>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174666>


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 28, 2011 at 06:53:28PM +0200, Gustaf Hendeby wrote:
> Hello everyone,
>=20
> I was playing around with "git show" lately and realized it has changed
> its behavior regarding the --quiet option, which no longer suppresses
> the diff output as it used to.  The behavior change happened in
> 1c40c36b ("log: convert to parse-options").  Was this intentional?

Very much so.

>=20
> The commit message talks about the --quiet handling being improved and
> the "git show" help doesn't mention a --quiet option.  Is the simple
> answer that the previous behavior was incorrect?

Yes.

 The long answer is that the log family (and git-format-patch, which
is where this started) never actually accepted --quiet, so it would
get passed down to the diff machinery. This (for complicated reasons
I'm not sure I comletely understand, but that have to do with the
internal handling of 'quiet' as 'quick') caused every second commit
not to show.

 As you noticed, the man page never mentions a --quiet option
(because, honestly, it doesn't make any sense), so any use of that
flag is wrong. Part of what the patch does is make --quiet a no-op to
guard against the effect of disappearing commits.

 How are you using the --quiet option and why would you even need it?

Cheers,
   cmn
--=20
Carlos Mart=C3=ADn Nieto | http://cmartin.tk

"=C2=BFC=C3=B3mo voy a decir bobadas si soy mudo?" -- CACHAI

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN4TAzAAoJEHKRP1jG7ZzTFXQIAJZwMJYDb3xqtv+Lv47CfpA5
Nz5F2zr28FhPK650KbEcLBlA5OJPpVKqDUGHggyP43tFkz3fKp1dUpFXm7QJfaiG
3aCjIb2mqOnnqccwFYGlhAQJAWL9OGUQH9jpNWUx4M6shmtM0zxdbPpCShhNRPP4
ZBnlBTkGO9Cak4Q2vKUsfH2zClmzBpWCB6Hxc+kn3gfzyE1Ix69ElYUy8REmFNwT
5RCdHSAIBLjpH1GUeqwu4fM6xERWUPwY2afUj1cereJb7FIj9MjRHFHZIoG99yLe
cDsT3VMSXJRfbO0fJtyyjslxhEMDMyXbHzi7VmwE3E8v9DtSQASFbAilyS2LZ6k=
=elYu
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
