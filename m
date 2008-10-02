From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/3] parse-opt: migrate fmt-merge-msg.
Date: Thu, 02 Oct 2008 13:51:19 +0200
Message-ID: <20081002115118.GC17334@artemis.corp>
References: <20080930224623.GQ21310@spearce.org> <1222841106-26148-1-git-send-email-madcoder@debian.org> <20081001145606.GX21310@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="O5XBE6gyVG5Rl6Rj";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 02 13:53:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlMjR-0002KT-Fs
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 13:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbYJBLvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 07:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753249AbYJBLvW
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 07:51:22 -0400
Received: from pan.madism.org ([88.191.52.104]:58034 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204AbYJBLvW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 07:51:22 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 8C6AC3B792;
	Thu,  2 Oct 2008 13:51:20 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 657BB94CA15; Thu,  2 Oct 2008 13:51:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20081001145606.GX21310@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97317>


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2008 at 02:56:06PM +0000, Shawn O. Pearce wrote:
> Pierre Habouzit <madcoder@debian.org> wrote:
> > @@ -347,38 +349,32 @@ int fmt_merge_msg(int merge_summary, struct strbu=
f *in, struct strbuf *out) {
> > =20
> >  int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
> >  {
> > +	const char *inpath =3D NULL;
> > +	struct option options[] =3D {
> > +		OPT_BOOLEAN(0, "log",     &merge_summary, "populate log with the sho=
rtlog"),
> > +		OPT_BOOLEAN(0, "summary", &merge_summary, "alias for --log"),
> > +		OPT_STRING('F', "file",   &inpath, "file", "file to read from"),
> > +		OPT_END()
>=20
>=20
> > +	argc =3D parse_options(argc, argv, options, fmt_merge_msg_usage, 0);
> > +	if (argc > 0)
> > +		usage_with_options(fmt_merge_msg_usage, options);
> > +
> > +	if (!inpath || strcmp(inpath, "-"))
> > +		in =3D stdin;
> > +	else {
> > +		fclose(in);
> > +		in =3D fopen(argv[2], "r");
> > +		if (!in)
> > +			die("cannot open %s", argv[2]);
>=20
> Really argv[2]?  Shouldn't that be inpath?

oh crap you're right. I'll submit and updated series soon... *sigh*

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjktbYACgkQvGr7W6HudhxlhQCdEPdwSJBXaSPIZyikwUBK3VJ9
BDgAn3OfkifFOs94KaqOcnh+pj9SPU4j
=7USX
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
