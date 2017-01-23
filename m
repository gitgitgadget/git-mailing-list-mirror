Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53ECC2092F
	for <e@80x24.org>; Tue, 24 Jan 2017 09:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750767AbdAXJx6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 04:53:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbdAXJx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 04:53:57 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D832F4D695;
        Tue, 24 Jan 2017 09:53:57 +0000 (UTC)
Received: from localhost (ovpn-116-93.ams2.redhat.com [10.36.116.93])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v0O9ruEu028249;
        Tue, 24 Jan 2017 04:53:57 -0500
Date:   Mon, 23 Jan 2017 13:29:18 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [RFC 2/2] grep: use '/' delimiter for paths
Message-ID: <20170123132918.GM29186@stefanha-x1.localdomain>
References: <20170119150347.3484-1-stefanha@redhat.com>
 <20170119150347.3484-3-stefanha@redhat.com>
 <xmqqpoji2851.fsf@gitster.mtv.corp.google.com>
 <20170120141212.GC17499@stefanha-x1.localdomain>
 <20170120141954.xyocl6oqoykqmpl5@sigill.intra.peff.net>
 <xmqq60l9wdb9.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OGW1Z2JKiS9bXo17"
Content-Disposition: inline
In-Reply-To: <xmqq60l9wdb9.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 24 Jan 2017 09:53:57 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OGW1Z2JKiS9bXo17
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 02:56:26PM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > It's not ignored; just as with git-log, it's a pathspec to limit the
> > diff. E.g.:
> >
> >   $ git show --name-status v2.9.3
> >   ...
> >   M       Documentation/RelNotes/2.9.3.txt
> >   M       Documentation/git.txt
> >   M       GIT-VERSION-GEN
> >
> >   $ git show --name-status v2.9.3 -- Documentation
> >   M       Documentation/RelNotes/2.9.3.txt
> >   M       Documentation/git.txt
> >
> > That's typically less useful than it is with log (where limiting the
> > diff also kicks in history simplification and omits some commits
> > entirely). But it does do something.
>=20
> I think Stefan is missing the fact that the argument to "git show
> <tree-ish>:<path>" actually is naming a blob that sits at the <path>
> in the <tree-ish>.  In other words, "show" is acting as a glorified
> "git -p cat-file blob", in that use.
>=20
> The use of "git show" you are demonstrating is still about showing
> the commit object, whose behaviour is defined to show the log
> message and the diff relative to its sole parent, limited to the
> paths that match the pathspec.
>=20
> It is perfectly fine and desirable that "git show <commit>:<path>"
> and "git show <commit> -- <path>" behaves differently.  These are
> two completely different features.

Thanks for explaining guys.  It all makes logical sense.  I just hope I
remember the distinctions in that table for everyday git use.

Stefan

--OGW1Z2JKiS9bXo17
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYhgUtAAoJEJykq7OBq3PIK0sH+wZF2kFU9rHjTT7s+zjeX+D0
zHoT75sZcHzOq/hXSkNSxzpnRgAqjAWKwLZkMiNOWINRGy9ccxXOvqtdY+o0J9VY
92GZu6wAwEMB8vNhR9TfWiDr+kaACl2ijiPuL0/cwutroMJ/tgyEASSpZ9eaxSXj
7aasSjjQg2Kxe4rXZwwH3cFjzYIrzw6gbu+hh+zP4NUe3kUpri98b0fTExF4O3lL
7Lkn+YviI16Ncg+GSPL+OS54DO4McegKb/4/IMdoKt9fgF4Hoifx3OU5+N2nB5/d
yVfuPCX6BDAJ+gdmWFhajmLhwEhospB6juTxcfuiMYX5/7x/OWqtG5OEPRovN+E=
=2PD7
-----END PGP SIGNATURE-----

--OGW1Z2JKiS9bXo17--
