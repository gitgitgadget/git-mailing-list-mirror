From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v6 2/4] submodule update: add --remote for submodule's
 upstream changes
Date: Mon, 03 Dec 2012 13:38:02 -0500
Message-ID: <20121203183802.GD14981@odin.tremily.us>
References: <20121130032719.GE29257@odin.tremily.us>
 <cover.1354417618.git.wking@tremily.us>
 <ec5d0235322619aff6c1c64b0a346efb0e4d0a32.1354417618.git.wking@tremily.us>
 <7v8v9ft761.fsf@alter.siamese.dyndns.org>
 <20121203181519.GC14981@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=RhUH2Ysw6aD5utA4
Cc: Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 19:39:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tfav0-0005UF-9r
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 19:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903Ab2LCSiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 13:38:25 -0500
Received: from vms173005pub.verizon.net ([206.46.173.5]:44229 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab2LCSiX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 13:38:23 -0500
Received: from odin.tremily.us ([unknown] [72.68.101.162])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MEG0063WX3EVR80@vms173005.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 03 Dec 2012 12:38:04 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 7117C6E5553; Mon,
 03 Dec 2012 13:38:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354559882; bh=kKEo/z33pzQREvvivlKYaSQIWuB//ejr6hHMu0/7HlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ONxU2vZe+huuP+n8Q72kWlvbfxa51fxazqtE4waI2IJGN5ptRxyVM8ED6yqgEyMvx
 Q9TowORF1zL2hRFVEb/kopYgx8n+cl8PYLjJ0z1gsGFKEcvrFFEHhcp4Gnd22k8wOR
 oalVrX/gm2UAUvLGYnYDrZG4fpgDZqGcoBTVjyJs=
Content-disposition: inline
In-reply-to: <20121203181519.GC14981@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211050>


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

As an example to make this clearer:

  $ cat .gitmodules
  [submodule "sub1"]
    path =3D sub1
    url =3D git://example.com/sub1.git
    remote =3D remote1
    branch =3D branch1
    update-source =3D submodule-upstream
    update =3D rebase
  [submodule "sub2"]
  ...

Means that `git submodule update sub1` will fetch remote1 and rebase
the current sub1 checkout against the tip of remote1/branch1.  The
git://example.com/sub1.git URL is not actually used during this
update.  Presumably the user setup remote1 intentionally in the
submodule, and wants to use the URL they've configured there.

Perhaps I need to ammend my

  submodule update: add submodule.<name>.remote config option

patch (#4) to adjust the remote that has it's URL changed by `sync`?

I may also want to append some form of the following commit (from my
submodule.<name>.active proposal):

  submodule add: configure existing submodule url if not set [1]

Cheers,
Trevor

[1]: https://github.com/wking/git/commit/b045c16cffe6eb86c157a6c7397166a46e=
147442

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQvPGIAAoJEEUbTsx0l5OMd0IP/0ga1Blx40RRYGf6Xmk/xHuP
r763tBleeOdcBjRxTx9cWSRVHDj2CjF4KcAjMXQXOgAZyClhny1G60PJWGEGH85T
vZTLBZ7pnboyFWMYRdLDSNJXDzFAB1ram3Lhh56HEnqTZ4Q59bLvEEp0xrBc62Go
EiMe+1dftqAaZJQx6rg4PHWQuBirzwF8enqrxyVVnmODQe/rMRLKiPjudCTa9qa4
ykugVOtuf6FSOn0Tbes0vjrpyec/eWumb76lG8OoS2TJlrqfD25oH8KDpMAhYjbf
/lD70rrW86dS/83805qdrx6d7FvUjtF5kZf1v06WZ97+opIlhZEVMdVlCL4eQB7F
+Iu50scAYh3ZXj8c5RnNS0B8u0d0nggEX0MB20IjikSOfs0qTRIGNXUWN53iC2M9
jyRiBDQcLB5klkXZqXE0q98GfqKZi9rKM8yZXOl5zAS6dGY0Wity4VHG6MJ/wobB
S2+ANSDt6ybpovkPJnFH86z+k3F5pK6zRLf2MjQTNQ/6gUUMaTx5Ffc66uLPZUe5
h6PkB9EU7seg0XCkAOhuSsAZyXTQApZXkkG4ZdRgVp+ls4HUaVosg+yg2le418OY
a8u9ok7DbWQrmH9HXFbQvOXg1xndj7qZ+rEY/IQjNQ211e6qOAFqyV9H2oYtkyWo
GtUoCPhNSTbpn9IcHZC2
=M2C7
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--
