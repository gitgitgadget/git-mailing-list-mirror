Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B2AB20756
	for <e@80x24.org>; Fri, 20 Jan 2017 14:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbdATOZN (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 09:25:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752169AbdATOZN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 09:25:13 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A24A7E9C0;
        Fri, 20 Jan 2017 14:18:35 +0000 (UTC)
Received: from localhost (ovpn-117-185.ams2.redhat.com [10.36.117.185])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v0KEIYme008918;
        Fri, 20 Jan 2017 09:18:34 -0500
Date:   Fri, 20 Jan 2017 14:18:32 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC 0/2] grep: make output consistent with revision syntax
Message-ID: <20170120141832.GE17499@stefanha-x1.localdomain>
References: <20170119150347.3484-1-stefanha@redhat.com>
 <20170119165958.xtotlvdta7udqllb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline
In-Reply-To: <20170119165958.xtotlvdta7udqllb@sigill.intra.peff.net>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 20 Jan 2017 14:18:35 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2017 at 11:59:59AM -0500, Jeff King wrote:
> On Thu, Jan 19, 2017 at 03:03:45PM +0000, Stefan Hajnoczi wrote:
>=20
> > git-grep(1)'s output is not consistent with git-rev-parse(1) revision s=
yntax.
> >=20
> > This means you cannot take "rev:path/to/file.c: foo();" output from git=
-grep(1)
> > and expect "git show rev:path/to/file.c" to work.  See the individual p=
atches
> > for examples of command-lines that produce invalid output.
>=20
> I think this is a good goal.
>=20
> I couldn't immediately think of any cases where your patches would
> misbehave, but my initial thought was that the "/" versus ":"
> distinction is about whether the initial object is a tree or a commit.
>=20
> You do still have to special case the root tree (so "v2.9.3:" does not
> get any delimiter). I think "ends in a colon" is actually a reasonable
> way of determining that.
>=20
> > This series is an incomplete attempt at solving the issue.  I'm not fam=
iliar
> > enough with the git codebase to propose a better solution.  Perhaps som=
eone is
> > interested in a proper fix?
>=20
> Are there cases you know that aren't covered by your patches?

=46rom Patch 2/2:

  This patch does not cope with @{1979-02-26 18:30:00} syntax and treats
  it as a path because it contains colons.

If we use obj->type instead of re-parsing the name then that problem is
solved.

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYghw4AAoJEJykq7OBq3PIuysIAJPMwwCzD+YKiaM4U5cpaiBv
khWz3dG1vo9R5t5Fwifl4qU3DuHQzCRdCndSRgxaNP/e0dbwaNwJCxMKb4FLDEei
lduUnVfeHo2njMlGzjsWFIimhRSRr8ll+/SkfwlYN+feVqO8JAT2+AF51ZRXBTYj
9RMska/hgYikRoehDpv88YCegWgljV4ZHebSL3KLa1OXO6s1VCGFycF52M0rFxJ/
nno/LxfFoC25JlP9UR4wtyPlIzGYxMnTQf3u4+Wl40y2c8uPmnisOmtSAVbJixWO
lpNavZI35hY/aYUi/j0M2oFnpjKlsuVkX2IO/1lwVyeJ11Dy55WGYuEloWuS+4g=
=KaTo
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--
