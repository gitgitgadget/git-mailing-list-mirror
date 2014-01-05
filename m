From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH 1/2] git-submodule.sh: Support 'checkout' as a valid
 update command
Date: Sun, 5 Jan 2014 12:44:23 -0800
Message-ID: <20140105204423.GF3156@odin.tremily.us>
References: <CALas-iiF7Og8qjWoYeop3GofG_kR7w5DDcNkA1y3eQhu1Srxkw@mail.gmail.com>
 <1388890249-3577-1-git-send-email-ceztko@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V32M1hWVjliPHW+c"
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 05 21:44:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzuYh-0004ny-5K
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 21:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbaAEUo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 15:44:27 -0500
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:36463
	"EHLO qmta07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751395AbaAEUo0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jan 2014 15:44:26 -0500
Received: from omta14.westchester.pa.mail.comcast.net ([76.96.62.60])
	by qmta07.westchester.pa.mail.comcast.net with comcast
	id ALWt1n0051HzFnQ57LkRLq; Sun, 05 Jan 2014 20:44:25 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta14.westchester.pa.mail.comcast.net with comcast
	id ALkQ1n00L152l3L3aLkQyE; Sun, 05 Jan 2014 20:44:25 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id C71A2E8A6EC; Sun,  5 Jan 2014 12:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1388954663; bh=7hzXvns0CYgvkghVv7QQ4s2upK+zFcIFHlShWKFDN0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VkTqVdngXsPcccrwrbvm+kpwrmJqCqZkqVMo6aYsdfcETlDfxA1JRuj2QnJ75mBZc
	 Dl4DXDOU+D+rzpKI2vijArdRQAnaSHxpk/a/b/ZWGE9ZYOfgHw4qaHzprHrH8Q7gIn
	 hbWqK3+SnAd6hZiUe5pp8ZyyaSxb1LcnsKDczS+M=
Content-Disposition: inline
In-Reply-To: <1388890249-3577-1-git-send-email-ceztko@gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1388954665;
	bh=NkUmoK3R1vEy/2s8N8vbtRdqnV2mSeh6hY8Y8WsIHiI=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=c4C/7U6YO63XQrhmP6SS5aCtc+B4500lb/9EviTTc3ilBHtdkOGhkNKRYdebDRuE+
	 cM9TdqbS723vW02EekSFhWPHYcvSg79vTpZSCmdoRyAhJ4NlwS58Po7tvd3j+8Uk8b
	 qTgnIHuH/XZXBF/BzKKdtpDUD7SKn9D8yxaUVZGB4MgXyjG/kzOLB1fGvVAOuLtYmh
	 NWVLD82OL1PWMbFTqeXfTVX3rUZleYA752pWBc35LvX4ZtsPx55VP+qICs63sGx37A
	 AaoV2vh5c87+r0ufb89o92V6kxU5F+HIqpfBQcXBrSbhvQq1073NErO9sa/9jPkNyI
	 Pg2k+MaI0Xtwg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239972>


--V32M1hWVjliPHW+c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 05, 2014 at 03:50:48AM +0100, Francesco Pretto wrote:
> +			case "$update_module" in
> +			'')
> +				;; # Unset update mode
> +			checkout | rebase | merge | none)
> +				;; # Known update modes
> +			!*)
> +				;; # Custom update command
> +			*)
> +				update_module=3D
> +				echo >&2 "warning: invalid update mode for submodule '$name'"
> +				;;
> +			esac

I'd prefer `die "=E2=80=A6"` to `echo >&2 "=E2=80=A6"`.  It's hard to know =
if mapping
the user's preferred (unknown) update mechanism to 'checkout' is
serious or not.

This commit also makes me think that --rebase, --merge, and --checkout
should be replaced with a single --update=3D{rebase|merge|checkout|!=E2=80=
=A6}
option, but that's probably food for another commit (and a long
finger-breaking deprecation period).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--V32M1hWVjliPHW+c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSycQlAAoJEKKfehoaNkbteCwQAKQwU3bvClH/Ed8TkMf+xkCa
S02PADtc0AcJf0+xmHrNhNGASLw1R5Ee0PiSPAy7gaBzJXHPtAIdwNTdHJRcaMaQ
OI1OzLoZCxFNy6TkLpDKaenKIRp9FlpW20F5ogXBbyMK91xzZzhWbKJ9NO8sgFUT
CRj17sDSyRfMhPPAhZp7MPcANnHtHOd3mZ+JNkVma1rJnfKWgOii4UPrlDcbl/4N
w2RG7Nu6wKb2a/YcbizFbLrmDNQxg0FK1OXdii9WlAaYQOO42nLzlL0y0MNZo7Jc
Hg06UcZMPnZy+IpUN7KR4BQc8htE5p0bQw4fAMeP42NkvtXF2VE/n5RUcU67rYFU
qzf8m128MHVGyNsnbOwkvNXIPGQBRhP6XKrvpgq0PBd9UisOHC+/QagaJL4Y9OEV
c0qU8v7dzO9AVZC6QzvN/lVhDw0+rgwew/gTCKEhL15yQowjYUU9svoOoQv7L3HE
W773AazC5EP4x/XmgHHBSQkeo/F4kE0ypWon39evtbVy1kWWAyZBZRWacn2BZmg4
KTUmMpmpTiQieupCxFKKi085IONZcS8HrPk08cZjI2YEbhH+kNb0CD92YH5ollDw
fr5TiwLfII0hpCx7PHZfbsWGM+bHbmwB08xX/D/0KtLTwvMjzO/CSkaluCiTVofz
2Z/vhkGGqznswgDLfy/I
=hfBF
-----END PGP SIGNATURE-----

--V32M1hWVjliPHW+c--
