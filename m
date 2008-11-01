From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: libgit2 - a true git library
Date: Sat, 01 Nov 2008 01:02:13 +0100
Message-ID: <20081101000213.GB29036@artemis.corp>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home> <20081031213114.GA21799@artemis.corp> <CBF2AF68-BA41-4394-A837-F62864CF8BFB@ai.rug.nl> <20081031232829.GC14786@spearce.org> <7v63n872bs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="61jdw2sOBCFtR2d/";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 01:03:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw3xh-00016Z-IT
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 01:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbYKAACR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 20:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbYKAACR
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 20:02:17 -0400
Received: from pan.madism.org ([88.191.52.104]:51544 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbYKAACQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 20:02:16 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id EBAE13B776;
	Sat,  1 Nov 2008 01:02:14 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 669FE5EE245; Sat,  1 Nov 2008 01:02:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v63n872bs.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99686>


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2008 at 11:49:11PM +0000, Junio C Hamano wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
>=20
> > You are the end-user of the library, so it needs to suit you.  Ok,
> > you aren't the only end-user, but you and other developers like
> > you... :-)
>=20
> I will be the end-user of the library because if we want libgit2 to be
> anywhere close to successful, you should be able to port C-git to it.
>=20
> I understand that the apidocs/ is a very early work-in-progress, but
> still, it bothers me that it is unclear to me what lifetime rules are in
> effect on the in-core objects.  For example, in C-git, commit objects are
> not just parsed but are modified in place as history is traversed
> (e.g. their flags smudged and their parents simplified).  You have "flags"
> field in commit, which implies to me that the design shares this same
> "modified by processing in-place" assumption.  It is great for processing
> efficiency as long as you are a "run once and let exit(3) clean-up" type
> of program, but is quite problematic otherwise.  commit.flags that C-git
> uses for traversal marker purposes, together with "who are parents and
> children of this commit", should probably be kept inside traversal module,
> if you want to make this truly reusable.

I don't think it's impossible to have something efficient without this
kind of hacks. You just need to dissociate the objects from their
annotations, though use some kind of allocator that allow numbering of
the objects, and use that number as a lookup in an array of annotations.
It will require pool allocators for the annotations, but that should
work fine and efficientely.

> By the way, I hate git_result_t.  That should be "int", the most natural
> integral type on the platform.

I concur.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkLnIUACgkQvGr7W6HudhwmAQCfRZWyACr0PN/AbkFDn4djBX5u
RPIAn21RcNZMPc75RFYZutcG4C4qpBcO
=rQFo
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
