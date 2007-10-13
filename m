From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git-fast-import crashes
Date: Sat, 13 Oct 2007 09:50:27 +0200
Message-ID: <20071013075027.GD7110@artemis.corp>
References: <e66701d40710120242p6fc05148hd40d19d295373ac4@mail.gmail.com> <20071013032916.GL27899@spearce.org> <20071013033407.GM27899@spearce.org> <20071013073640.GC7110@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="PPYy/fEw/8QCHSq3";
	protocol="application/pgp-signature"; micalg=SHA1
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Shun Kei Leung <kevinlsk@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 13 09:50:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igblh-0004VV-NL
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 09:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbXJMHu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 03:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbXJMHu3
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 03:50:29 -0400
Received: from pan.madism.org ([88.191.52.104]:46334 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537AbXJMHu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 03:50:28 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 69EE124BB6;
	Sat, 13 Oct 2007 09:50:27 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 101CAF161; Sat, 13 Oct 2007 09:50:27 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Shun Kei Leung <kevinlsk@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071013073640.GC7110@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60725>


--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On sam, oct 13, 2007 at 07:36:40 +0000, Pierre Habouzit wrote:
> On Sat, Oct 13, 2007 at 03:34:07AM +0000, Shawn O. Pearce wrote:
> > "Shawn O. Pearce" <spearce@spearce.org> wrote:
> > > Shun Kei Leung <kevinlsk@gmail.com> wrote:
> > > > I am using git 1.5.3.4.206.g58ba4-dirty on Mac OS X 10.4.
> > ....
> > > > Program received signal EXC_BAD_ACCESS, Could not access memory.
> > > > Reason: KERN_INVALID_ADDRESS at address: 0x64617469
> > ....
> > > This looks like it is
> > > memory corruption (e.g. someone overwriting a free'd segment),
> > > but that sort of memory corruption is very hard to track down.
> >=20
> > OK, so the version you have (58ba4) is the latest fast-import after
> > the strbuf.c series went in.  The one immediately before that series
> > was 4bf538 and is probably actually stable.
> >=20
> > So I wonder, can you test 4bf538 and then if it is good bisect
> > between those two commits?  There must be a memory corruption
> > introduced by one of the strbuf changes...
>=20
>   Gasp, if you get the offending sha1 commit, don't forget to Cc: me.

  Okay, given that fast-import uses quote_c_style, I believe this is the
same but that the one that was reported already. I've read the full
`git diff 4bf53833dbca666f61b5177977e96d453527db20.. -- fast-import.c`
and nothing alarming shows up.

  Please try to apply:
http://git.madism.org/?p=3Dgit.git;a=3Dcommit;h=3D7406e83342cd445ac38c1753c=
5fce75377737e2f

  And see if that fixes the issue for you. Else a bisection would be
much appreciated. Thanks.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--PPYy/fEw/8QCHSq3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHEHjDvGr7W6HudhwRAkhRAJwKuvQS9EEuu47AAsRKsumA0pdlJQCfW+nJ
Va2O6NhDOFGIutqCyxFBSbA=
=SJFk
-----END PGP SIGNATURE-----

--PPYy/fEw/8QCHSq3--
