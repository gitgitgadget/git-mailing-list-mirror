From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH, fixed] builtin-clone: create remotes/origin/HEAD  symref, if guessed
Date: Mon, 03 Mar 2008 18:09:43 +0100
Message-ID: <20080303170942.GB23210@artemis.madism.org>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802260321.14038.johan@herland.net> <alpine.LNX.1.00.0802261128360.19024@iabervon.org> <alpine.LSU.1.00.0803020556380.22527@racer.site> <alpine.LSU.1.00.0803020622190.22527@racer.site> <1204563913.4084.3.camel@gaara.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="SkvwRMAIpAhPCcCJ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Santi =?utf-8?B?QsOpamFy?= <sbejar@gmail.com>
To: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 18:10:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWEBJ-0000yC-Vf
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 18:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbYCCRJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 12:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752456AbYCCRJq
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 12:09:46 -0500
Received: from pan.madism.org ([88.191.52.104]:47920 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbYCCRJp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 12:09:45 -0500
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 8210B308CE;
	Mon,  3 Mar 2008 18:09:43 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 08128451FE8; Mon,  3 Mar 2008 18:09:43 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Santi =?utf-8?B?QsOpamFy?= <sbejar@gmail.com>
Content-Disposition: inline
In-Reply-To: <1204563913.4084.3.camel@gaara.boston.redhat.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75949>


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 03, 2008 at 05:05:13PM +0000, Kristian H=C3=B8gsberg wrote:
> On Sun, 2008-03-02 at 06:25 +0000, Johannes Schindelin wrote:
> > +		strbuf_init(&head_ref, 0);
> > +		strbuf_addstr(&head_ref, branch_top);
> > +		strbuf_addstr(&head_ref, "/HEAD");
> > +		delete_ref(head_ref.buf, head_points_at->old_sha1);
> > +		strbuf_init(&real_ref, 0);
> > +		strbuf_addstr(&real_ref, branch_top);
> > +		strbuf_addch(&real_ref, '/');
> > +		strbuf_addstr(&real_ref, head);
>=20
> What about just using
>=20
>   strbuf_addf(&real_ref, "%s/%s", branch_top, head);
>=20
> Are you worried about performance? :-p

  If he was he would have used strbuf_init(&real_ref, 1024) or sth like
that I assume :)

> Oh and I'm wondering if
>=20
>   strbuf_initf(&real_ref, "%s/%s", branch_top, head);
>=20
> would be a worthwhile addition to the strbuf API...

  I don't think so, unless there are 1289 places in git that would
benefit from the shortcut it gives, but I really doubt it.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHzDDWvGr7W6HudhwRAq8BAKCdAhbdTbh/uf9uQDIEvQqpR+JaPQCfRcIg
683KDklJdH8ds0EZO4YT83M=
=xAu2
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
