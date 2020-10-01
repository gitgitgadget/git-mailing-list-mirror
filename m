Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC4EC4727E
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 23:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84726206DD
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 23:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733240AbgJAXxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 19:53:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42088 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727017AbgJAXxX (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 1 Oct 2020 19:53:23 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 499986046C;
        Thu,  1 Oct 2020 23:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1601596372;
        bh=UOlJuWzOCP2VAWlmrJt9hDU41iOId1LBFZ5gyimLDjs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QFAgm9/gTj+O9jRWgxKMYBKK9XcmL+xIRJRewQuqzjLXMHyFJ3lSsdbU4A3nOskeq
         C5IA5g6MpMIJWL2UAx3eUbevj2F1rBC2lhdPHpKOvBV3XxyxU+R4BMgsfv8S3KZP96
         h29B30NB3CDbJz8EgdJnxeCDKZQKOAqnFcXzRjZSk9VnVn3KN8RxUP7z/Nzxdb1GIE
         Ogm0btPFaTZ/n03QtDDqEjGYc2EwrrtKuEPzZEAApOopb5a+dutvJ4iTWc9bi3DdJq
         abqJ06ShWAdYui9/w9QAUBC0sERpof20nCfE9p3KDdPbl3NzLLOa5wOOqeIoAqsvMi
         60Tj/Jhsvb0JtcDFnI5t05MXK+iAsIgul+1/TtyIqTvtbv05zSdFrinekKFD4BQL0Q
         RnxWgJs+atcMapvvqwAb05LJnf3DhC+HTLKeDjIJYhQw3T+IZv7In2qn9HnsPElAAE
         EgxLBEl+9dZlUda+Bc0q8mSYnS79Zz47QARNqrNdPpu8VxCZc/Z
Date:   Thu, 1 Oct 2020 23:52:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     "Wu, Zhichen" <zhwu@amazon.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Question About Git V2 Protocol & SHA256
Message-ID: <20201001235247.GK1392312@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, "Wu, Zhichen" <zhwu@amazon.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <9FC3DDB4-DE6F-45B3-95F9-1048991713A4@amazon.com>
 <20200929221311.GA15129@coredump.intra.peff.net>
 <20200929224356.GH1392312@camp.crustytoothpaste.net>
 <20200930004630.GA623061@coredump.intra.peff.net>
 <20200930021925.GI1392312@camp.crustytoothpaste.net>
 <20200930122006.GA1900495@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z9t8O/5YJLB6LEUl"
Content-Disposition: inline
In-Reply-To: <20200930122006.GA1900495@coredump.intra.peff.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Z9t8O/5YJLB6LEUl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-30 at 12:20:06, Jeff King wrote:
> On Wed, Sep 30, 2020 at 02:19:25AM +0000, brian m. carlson wrote:
>=20
> > If you have a suitably new Git, it will fail with an appropriate
> > message on both sides.  The client will complain that you are trying to
> > use a remote that uses the wrong hash algorithm and the server will
> > complain that you have failed to pass a suitable object-format
> > extension.  That will look like this:
> >=20
> >   fatal: mismatched object format: server sha256; client sha1
> >   fatal: expected flush after ref listing
>=20
> That makes sense, and the message isn't too bad.

Yeah, it seems reasonable.  If people like something else better, it can
be adjusted.

> > That's true if you're using protocol v2 at all, or a suitably new Git
> > with protocol v1, although the messages may differ slightly.  However,
> > if you're using an older Git with v1, then you'll get this:
> >=20
> >   fatal: protocol error: unexpected '304c98b4860fa40b3e04f3e2e24db1a13a=
b959922a63209685813908c4fabc83 HEAD'
> >   fatal: the remote end hung up unexpectedly
> >=20
> > That's because, as you pointed out, we don't get to the point where the
> > client fails to send the value.
>=20
> That makes switching to sha256 on the server a bit of a flag day, then,
> doesn't it? Everybody with older Git will not be able to clone such a
> repo. That may be OK for some cases, but I suspect it is going to cause
> a delay in servers moving to sha256 themselves. Even if a project is
> ready to migrate, it may be hesitant to do so because of third parties
> outside of its control (whether external tools like CI, or just wanting
> to be open to cloning by random users).

Right, but as the code stands now, those people couldn't make use of a
SHA-256 repository anyway because there's no interoperability.

> On the other hand, any kind of hash negotiation would require on-the-fly
> conversion for that case (i.e., a sha256 server serving an older sha1
> client needs to produce the alternate-universe sha1 objects). That's
> expensive either in CPU or in disk space, and it may well be that
> third-party hosting sites would refuse to enable such an option anyway.

We will eventually have some sort of compatibility, and it's
theoretically possible that hosting could offer SHA-1 compatibility for
those repositories, even if that's only for protocol v1.  So the
repository could use SHA-1 for v1 and negotiate for v2.

The desired behavior for a large hoster like GitHub or GitLab may be to
force v2 only for SHA-256; that's a justifiable decision there, because
we know all clients will support it and we don't have to deal with
remote systems that are poorly configured.  So I wouldn't be opposed to
seeing an option that did that.  As mentioned elsewhere, though, it
isn't a 100% viable option everywhere.

> > Because v2 isn't implemented for pushes yet.  The testsuite does not
> > even come close to passing unless you have a fully functional remote
> > system.  That's why I implemented protocol support, even though it
> > wasn't originally planned.
> >=20
> > That was mentioned in the cover letter of the series that introduced
> > protocol support.
>=20
> Yeah, I think I misunderstood the direction there. I took the
> object-format capability to mean that the client and server would
> negotiate. But it really is the server saying "I'm going to speak this;
> you'd better understand it and be able to translate objects on your
> side".

Yes, at this point it is, and it will remain that way for v1.

> I did realize that getting the test suite to pass meant that we'd be
> passing sha256 hashes over the wire. But I had assumed that was part of
> the strategy to make everything work in a sha256 world, and that more
> interoperability stuff was coming on top. I.e., I thought our current
> state was less mature than you ended up implementing.

More interoperability is coming, but the stage 4 (SHA-256 only)
implementation was easier to implement, so we got that first.

The good news is that the compat code is less involved than I expected
because we providently made the decision to write every new loose object
in the repository using a single function.  The biggest problem is now
the testsuite because we try to stuff all manner of invalid and broken
object IDs in places and that doesn't work anymore because they can't be
mapped.  I'm chipping away at this problem while watching movies on the
weekend, so it's coming.

> > In retrospect, we probably should have sent "GIT_PROTOCOL=3Dversion=3D2=
" as
> > part of the shell command and let implementers deal with the fact that
> > their SSH servers would need to adequately parse and interpret shell
> > commands to function properly.  But it's probably too late to do that
> > now without bumping the protocol to v3.
>=20
> That was definitely discussed, but rejected because of the
> interoperability problems. Not just for servers who actually want v2,
> but it would mean that the v2 probe would cause existing v1 servers to
> stop working. I.e., it would stop being safe to send v2 probes, which
> was the whole point of the scheme.

Yeah.  I guess we can't have everything we want in this case.
--=20
brian m. carlson: Houston, Texas, US

--Z9t8O/5YJLB6LEUl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX3ZrzgAKCRB8DEliiIei
gSiZAP95RogQpwEUAwyp3rRzF3HRrffOToqMfT/AY0J+opIrbAD/cCG3YDfu2y77
IFfZVPHZzC1WcmhjX/yQCKlfr0rRsQ8=
=ysIT
-----END PGP SIGNATURE-----

--Z9t8O/5YJLB6LEUl--
