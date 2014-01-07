From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH 2/2] Introduce git submodule attached update
Date: Tue, 7 Jan 2014 23:51:28 +0100
Message-ID: <20140107225128.GC10782@sandbox-ub>
References: <1388890249-3577-1-git-send-email-ceztko@gmail.com>
 <1388890249-3577-2-git-send-email-ceztko@gmail.com>
 <20140105203349.GB3737@book.hvoigt.net>
 <CALas-ijjzyRVuc0NaAS5QS98pX2198mv4HoHDacgYFYNLXbXFw@mail.gmail.com>
 <20140106140627.GA27265@t2784.greatnet.de>
 <CALas-ihHD_eJOXLUrhCVZjidQDmrCN=QpdfMKoN1i9A7FAo3RQ@mail.gmail.com>
 <20140107041004.GA11060@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	x-action=pgp-signed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Francesco Pretto <ceztko@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Jan 07 23:51:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0fUq-0003E7-Ci
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 23:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754461AbaAGWvh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jan 2014 17:51:37 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:38567 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399AbaAGWvb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 17:51:31 -0500
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1W0fUf-0005nl-Em; Tue, 07 Jan 2014 23:51:29 +0100
In-Reply-To: <20140107041004.GA11060@odin.tremily.us>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240179>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, Jan 06, 2014 at 08:10:04PM -0800, W. Trevor King wrote:
> Here's an attempted summary of our desires, and my ideal route
> forward:
>=20
> * Preferred local submodule branches for each superproject branch.
>   * Not currently supported by Git.
>   * Requires some sort of per-superproject-branch .git/config.
>   * Fall back to the remote-tracking submodule.<name>.branch?
>=20
> * Auto checkout of the preferred branch
>   * Can do this at clone-update time with my patch.
>   * For later submodule branch switches, maybe we want:
>=20
>       git submodule checkout [-b <branch>] [<paths>=E2=80=A6]
>=20
>     Then if a user blows off their detached HEAD, at least they'll
>     feel a bit sheepish afterwards.

Well, for development on a detached HEAD in a submodule we are currentl=
y
not very careful anyway. A simple

	git submodule update

will already blow away any detached HEAD work. But AFAIK it should
trigger the "you are leaving commits from a detached HEAD behind"
warning, so there is some safeguard and recovery.

Cheers Heiko
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iEYEARECAAYFAlLMhPAACgkQjLR3Aoip+rqP6wCeIhtpWLJC3XVO3nu2ViQTbHPg
T5wAoLLEZ256GOOjBxoTKo2/FmfvQGLp
=3D+bqm
-----END PGP SIGNATURE-----
