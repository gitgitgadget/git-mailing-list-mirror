From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] git diff/diff-index/diff-files: call setup_work_tree()
Date: Mon, 25 Aug 2008 16:50:44 +0200
Message-ID: <20080825145044.GE23800@genesis.frugalware.org>
References: <fcaeb9bf0808250652p3d0f483dt714cd68d3122d7c9@mail.gmail.com> <1219675383-1717-1-git-send-email-vmiklos@frugalware.org> <fcaeb9bf0808250746q3366b9cap78c45718287fba80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w1d+AIiKduYp7JzL"
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Karl Chen <quarl@cs.berkeley.edu>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 16:59:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXdQL-00073A-Cp
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 16:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083AbYHYOuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 10:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754082AbYHYOuv
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 10:50:51 -0400
Received: from virgo.iok.hu ([193.202.89.103]:54424 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837AbYHYOuu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 10:50:50 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 36A261B2503;
	Mon, 25 Aug 2008 16:50:47 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 60D704465E;
	Mon, 25 Aug 2008 15:51:31 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id DBBC31788129; Mon, 25 Aug 2008 16:50:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0808250746q3366b9cap78c45718287fba80@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93633>


--w1d+AIiKduYp7JzL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2008 at 09:46:37PM +0700, Nguyen Thai Ngoc Duy <pclouds@gma=
il.com> wrote:
> On 8/25/08, Miklos Vajna <vmiklos@frugalware.org> wrote:
> >  diff --git a/builtin-diff-index.c b/builtin-diff-index.c
> >  index 17d851b..b8e0656 100644
> >  --- a/builtin-diff-index.c
> >  +++ b/builtin-diff-index.c
> >  @@ -16,6 +16,7 @@ int cmd_diff_index(int argc, const char **argv, cons=
t char *prefix)
> >         int i;
> >         int result;
> >
> >  +       setup_work_tree();
> >         init_revisions(&rev, prefix);
> >         git_config(git_diff_basic_config, NULL); /* no "diff" UI option=
s */
> >         rev.abbrev =3D 0;
>=20
> I think this is only needed when cached =3D=3D 0
>=20
> >  diff --git a/builtin-diff.c b/builtin-diff.c
> >  index 7ffea97..86f9255 100644
> >  --- a/builtin-diff.c
> >  +++ b/builtin-diff.c
> >  @@ -244,6 +244,7 @@ int cmd_diff(int argc, const char **argv, const ch=
ar *prefix)
> >         int nongit;
> >         int result =3D 0;
> >
> >  +       setup_work_tree();
> >         /*
> >          * We could get N tree-ish in the rev.pending_objects list.
> >          * Also there could be M blobs there, and P pathspecs.
> >
>=20
> No. git-diff has too many modes, some does not need worktree. This
> forces worktree on all modes.

Ah, yes. I just wanted to say that I forgot do a 'make test' and
actually this breaks at least t0020-crlf.sh. I'll post a fixed patch in
a bit.

Sorry.

--w1d+AIiKduYp7JzL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiyxsQACgkQe81tAgORUJbLegCfe0kBV1CtPcTAf1HzbMq0IGv/
ODUAnjyFlOIWgIExpYx9zVLpCwVQ4N+K
=fkcr
-----END PGP SIGNATURE-----

--w1d+AIiKduYp7JzL--
