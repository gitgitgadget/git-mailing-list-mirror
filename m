Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FADF20951
	for <e@80x24.org>; Fri, 17 Mar 2017 18:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751198AbdCQSIX (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 14:08:23 -0400
Received: from mail.fairlystable.org ([216.151.3.163]:43619 "EHLO
        mail.fairlystable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbdCQSIW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 14:08:22 -0400
Received: from [174.25.131.71] (helo=localhost)
        by mail.fairlystable.org with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <jrayhawk@fairlystable.org>)
        id 1covQC-0000yO-K1; Fri, 17 Mar 2017 10:12:12 -0700
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha256"; boundary="===============7730388699063365766=="
MIME-Version: 1.0
Content-Disposition: inline
From:   Joe Rayhawk <jrayhawk@freedesktop.org>
User-Agent: alot/0.3.6
To:     Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
References: <148971018136.2144.12683278043600094739@richardiv.omgwallhack.org>
 <195b30d7-9ea2-7a9b-79ca-41b7bb890a30@alum.mit.edu>
In-Reply-To: <195b30d7-9ea2-7a9b-79ca-41b7bb890a30@alum.mit.edu>
Message-ID: <148977072642.2144.7040206366650087348@richardiv.omgwallhack.org>
Subject: Re: Shared repositories no longer securable against privilege escalation
Date:   Fri, 17 Mar 2017 10:12:06 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--===============7730388699063365766==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Quoting Michael Haggerty (2017-03-17 05:07:36)
> On 03/17/2017 01:23 AM, Joe Rayhawk wrote:
> > Git has started requiring write access to the root of bare repositories
> > in order to create /HEAD.lock. This is a major security problem in
> > shared environments as it also entails control over the /config link
> > i.e. core.hooksPath. Permission to write objects and update refs should
> > be entirely separate from permission to edit hook execution logic.
> =

> Thanks for the report. This is indeed a problem for people who want to
> set restrictive privileges on $GIT_DIR. I'd never thought of that use
> case, but it makes sense. Is this practice recommended somewhere or
> required by any Git hosting tools? (I'm curious how prevalent it is.)

I had to work out the practice for my own management engine; I have
since deployed it to around eight different mixed-use multi-user
operations, the most significant of which is Freedesktop.org.

Without this practice, core.sharedRepository is an enormous liability
of a feature. I can't speak to whether anyone but me ever noticed, what
with mixed-use multi-user POSIX environments becoming increasingly rare.

> The locking was added intentionally, to ensure that the reflog for
> `HEAD` is written safely. But the code didn't do that prior to the
> commit that you referenced, so (as a special case) ignoring failures to
> lock `HEAD` due to insufficient permission is probably a reasonable
> compromise.

Hooray!

> (I can't resist pointing out that the *real* bug is storing special
> references like `HEAD` in the top level of $GIT_DIR, but that can't be
> changed now.)

Yeah, putting refs outside of refs/ is conceptually pretty nutty.

--===============7730388699063365766==
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Description: signature
Content-Type: application/pgp-signature; name="signature.asc"; charset="us-ascii"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0W3/Ls5On90y4dmX35w74P7tvu8FAljMGOMACgkQ35w74P7t
vu/Lgw/9FFdT80VNlTn9iXKu9/7hEWYg9tDbWZkwXOX2Uf0akbb2SS1qsaMOmL+Y
gff2v2xy8E022yPuCwXk/l21z9Y0wmHm5QBmTr6x71yj15Mjs92bm/XS8ZKy//J4
dh3P3FpQ9AvDkaggET4qzl6mEWqWNfrcdfSp6URvK3JHuimn+cfWDqfgVVwSzPP7
8OMoU4TdytuH5t8oIMuAASKgxZ+u4A5Pe3rrZY9UHa51z4PV8Osd9xJUSZpyWnJJ
iK6tGJ4Gp4wXpsJ91b0YMFoq+vS5eteYS50Ka2mSmF+omUcb0iswQd84wkeUZJux
sAjQq7wF5AFTGI5swSJ633A0sGiZ3o64agzhskYQ3o8J57yBHaAAXxezauFjITrQ
yYc4glYJsCpFWqOmerra2dP/FOVxhJmsIJhwI9MSZDiAXgUi7y+uzzCx4FCmz0yh
BwPRJIS1SAS+td/TW59l1DXFSqwV575c19u8tweSD0dEjkXNQRaxssTBuwMxEXzb
ePNzbq03jXNUqov9mEsoqMwDw5ZOJYE+uCUH9V8zM+u53TiESge4wLMLuiQhjlGR
2VtzYS39djkjNI6FxiDm2W1CQIBpHHuFXpmO/bzMvdsjDVCbDGHiFJTsIbqTWsf8
QR7ArJol6qgFlJMFswR0mAbzBi+m2fReKBDron0f476SEuG2lfA=
=inQD
-----END PGP SIGNATURE-----

--===============7730388699063365766==--
