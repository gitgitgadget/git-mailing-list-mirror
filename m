From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v4 1/6] submodule: Make 'checkout' update_module explicit
Date: Thu, 16 Jan 2014 11:22:52 -0800
Message-ID: <20140116192252.GT2647@odin.tremily.us>
References: <20140114224246.GA13271@book.hvoigt.net>
 <43e8f3bfdaffefca9edd7a23574816630690e1e5.1389837412.git.wking@tremily.us>
 <xmqqwqhzzrw3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YvpO9wCO44Ze8QQC"
Cc: Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 16 20:23:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3sWx-0001Y0-Pv
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 20:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbaAPTXC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 14:23:02 -0500
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:35148
	"EHLO qmta09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751004AbaAPTW4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jan 2014 14:22:56 -0500
Received: from omta10.westchester.pa.mail.comcast.net ([76.96.62.28])
	by qmta09.westchester.pa.mail.comcast.net with comcast
	id Ehf21n0040cZkys59jNvtC; Thu, 16 Jan 2014 19:22:55 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta10.westchester.pa.mail.comcast.net with comcast
	id EjNt1n00p152l3L3WjNuDK; Thu, 16 Jan 2014 19:22:55 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 320CBEFF047; Thu, 16 Jan 2014 11:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389900173; bh=gK2sfFmfNxjPailWAcRPR8mHVI9IOID/fMFLrqKTiOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AXpLSv7SKDRz0P8F11g9KdMZ3QQgb2fd+iUxs5W2HwN2OibhNapZwEU7vlFaeg6Sr
	 p2vUBeEmgnahwDMQxCwyLY+WB5Ess1CgIg6lncVkp82U9bq0kcYp+E5emwLmP5QoJa
	 PZkVd5O7sZp6VCn7Src4LUesL/jlujHrCiib63EI=
Content-Disposition: inline
In-Reply-To: <xmqqwqhzzrw3.fsf@gitster.dls.corp.google.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389900175;
	bh=ilD7ZsbppIus957cL6zrGv7qLUyASQzMeeTSvahJpIo=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=VJh+cqDyQESRS+AXukuOFjk7ZXGSvbLr2sK9QiY0Hoxrqg/X/oN1H5Vu33ynRtp9L
	 03JQzhdGelhZHVcVB5cugGHl4kzHyIs9c02kcWZIxp9Tcj+zBq+rc4pHCIN+vrD7gl
	 02j3hjF1SyMEaUrpFrMiSt5yHyRFTNF/W2H48f463txa0HTrJpJDdaroVLpCug04X/
	 r3GBv8N+ZhKhYoLdSRSR5MocYTfUCYZUzVGjqG5B6XaKTCzwWp2xnrprQpDlqi0j4+
	 KIMD/NfbY2mD124anliY68MiCHOW2vt/053mWmH8SJLZxYNUyJCOlUtuEdBBVfAN33
	 pH2jnMY62xH4g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240522>


--YvpO9wCO44Ze8QQC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2014 at 10:46:36AM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
> > @@ -803,17 +803,10 @@ cmd_update()
> >  			update_module=3D$update
> >  		else
> >  			update_module=3D$(git config submodule."$name".update)
> > -			case "$update_module" in
> > -			'')
> > -				;; # Unset update mode
> > -			checkout | rebase | merge | none)
> > -				;; # Known update modes
> > -			!*)
> > -				;; # Custom update command
> > -			*)
> > -				die "$(eval_gettext "Invalid update mode '$update_module' for subm=
odule '$name'")"
> > -				;;
> > -			esac
> > +			if test -z "$update_module"
> > +			then
> > +				update_module=3D"checkout"
> > +			fi
> >  		fi
>=20
> Is this a good change?
>=20
> It removes the code to prevent a broken configuration value from
> slipping through.  The code used to stop early to give the user a
> chance to fix it before actually letting "submodule update" to go
> into the time consuming part, e.g. a call to module_clone, but that
> code is now lost.

Avoiding useless clones is probably more important than avoiding
duplicate "Invalid update mode" messages.  I'll reinstate the case
statement in v5, but I think it should live outside of the =E2=80=9Cload fr=
om
config=E2=80=9D block, in case someone adds the ability to set arbitrary
update modes from the command line (`--update merge`, `--update
'!command'`, etc.).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--YvpO9wCO44Ze8QQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2DGKAAoJEKKfehoaNkbtBSQQAJpGk4pKwmiHr6JxcKYD/yP+
4IUMJ+KC1guB28YPrtKF/s9IMkCrjQAgPYhSAPVX1jb/j3FRT4b2mWg5WbJPwA0I
8A2sB3nk88z7GP6t06fITeTSD7E/UT+DaJB9zUFDYq3BvbxvhkNn30U3NwdKRD2I
hF5lgGq70WTkxNNPkzMwjJkdR8yts2ZzKEXSljF9iU3ARAJ/JZh9jahCih2PY1Of
cFnmmolhq/1yX/DmKl+7cPtU3tPhS2b50cfC9+xtrqAYn3D2t3dr5aPdK4EV+3py
7M15L1N8wsbYyBHHEqzcLH2ha9vbAP2z2KFNuTtki4sGWmRDN5TUmAt+eXpXmWaM
Eiy1CM+AA7PRygnYfV12upEDr7EJJU8IDhhKmyoA3afwLaUYfYhryabtKxf4sy04
YOjR9p68b/u7sm7ATEFYy8pa2pDbYipptMrAa51GqeUp1Jp8TQxlLv13TR/ARxXK
SneBL55xV6yIDb5BJqD7/3a4PeLGlfSEtdGLtXb14LhOSMgNNPD0cnJLoZ+PJ0Bp
CbU3oI3FjBKbhnK3dvebPZMXoEoOydkc2pkQS48Gpmqmerx0Mwn1tcElhOgLGDkV
HPdeAJaLg69E6EpfTqtriydMOXpOyvO+xEwBsIBfb4zz8NjqbjplVywq6MTVZTFv
mSkFMmk8WZ32PknaR3Wj
=4sma
-----END PGP SIGNATURE-----

--YvpO9wCO44Ze8QQC--
