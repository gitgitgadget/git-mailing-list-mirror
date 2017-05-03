Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C3DB207F8
	for <e@80x24.org>; Wed,  3 May 2017 23:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbdECXar (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 19:30:47 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36828 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751198AbdECXap (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 3 May 2017 19:30:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 43F40280AD;
        Wed,  3 May 2017 23:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493854243;
        bh=qF+qvRZACnra/11l3s9E+wqddbT358JD1d+PuR6dkCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mbzpnIBOtBssqbkQ627N2Elc3fWjXZpYTwl5czOcG8rr0DbMVNgTV4ZgHWvDbgzHi
         YgGNsEySIewe+dCh8DcG8gW32KRQud0lEDpvMfel3rUB87VMzP1sNo2kCMXU0SEVIm
         t1TCnFvHwNRT2hmpBhNhN6NKlmM+sUeqr6gwfV2AYRv/Evc9j0/VcgYd5BQNlGeefG
         IobolJvrxWMzMhRxAqP4peEL9F0cFQbv7XSt4yg/i2LKxef57aO/9IuAlEw7rtISkd
         qK4HR5seo/CQhZGDTZs6ZaZePBfGmMcW09xLJBp1VfpvXFGzs91hpsWVIvCIfwVGlN
         OQhfOfAbHNz1IzROj4oPnvUl+eGOj2+L4g9xfsF/oEBOrZBPjwDPTyqsvWCMxObGP5
         fWuhVXD92wg9MZUoCopuzouq1TkVdou7YVLacaHLGohwkeOVfzX2runMyGa6RcV341
         tuDw3rRg5OSLnzfBDQJdjZxubJFpc/XrGphptiqL/gZpLyrWQn/
Date:   Wed, 3 May 2017 23:30:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 39/53] refs/files-backend: convert many internals to
 struct object_id
Message-ID: <20170503233038.wjhgvfdw7mubydzi@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
 <20170501022946.258735-40-sandals@crustytoothpaste.net>
 <95a85924-6f5b-a625-e460-ecd14540a621@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h2qgfm5hu4cf6w3a"
Content-Disposition: inline
In-Reply-To: <95a85924-6f5b-a625-e460-ecd14540a621@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--h2qgfm5hu4cf6w3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 01, 2017 at 04:24:23PM -0700, Jonathan Tan wrote:
> On 04/30/2017 07:29 PM, brian m. carlson wrote:
> > -	if (line->len <=3D 42)
> > +	if (!line->len)
> >  		return NULL;
>=20
> I would omit this check - parse_oid_hex already exits early if the first
> character is NUL. (The existing code makes a bit more sense, in that it
> avoids checking the first few characters if we already know a bit more ab=
out
> the string.)

Okay, I can do that.

> Looks fine, up to here.
>=20
> (Also, you requested extra-careful review for this patch, but this patch
> seems mostly mechanical to me.)

Because the rebase ended up moving around a lot of code in a way that I
felt was risky.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--h2qgfm5hu4cf6w3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlkKaB4ACgkQv1NdgR9S
9otpXg//ZpcZih0bec67QnQmDU3drz9FSD+5sX/UNp3D2TB4ppgIsdZRJj5MwyyO
OXz2CKd4Yc2jHYJWoHYxvhe17RU5E/yqCbpvk8Uh8biWXKWm0nZZi2GK6doo0LZM
qhEyJ9FzN8E8ivySEK3rccBR/IAk7cKEKv952PZ/mGMNPvdwLOV2zAaOB0JXt0nh
mSEQjPs81Whg9+F5ronzPci/yLFLTCmoqrLFmRotPF5RT3X8htnoyreW9b7EgN9U
6ID/k/PlnrnASG1yiRHxz102/wQUd1FFhyEknI/OasMP4+86Urzc3tP5OtQ4JpFb
3H/reVpliyS7WvPH0aaww/MOx6l/JQ1kauFDkiZ52J4Rv1aLFOJl9qm0Er/P/yFn
6hUs0oXSd5qwJg2T25C52B2+JkWMmln62do7GQpJ1QDATCp9he3dH9+7+vlteXKE
sIbO7CSjZPxqZ+sLgPThzZFq/MxtJofh/ncJmeWFNlm29I3xk2sE8xLLvLWOVl0v
JCEIsVjadAqP90N5/QbbGhemEWfQnfA4dkwmqrAkfTfOCQdxUd5Op/7pA+Bk6Tme
Yx4hSqyhdHrlLT12YxRgfUUVnvDsOC2S/RKeO71dJ3fteYN3dqFNcCMx4nUORQzT
rtWOGpgtqRIKEtFoPM3YOX2KCBhgmiJoSr4OXmKVrJq+gqMwimk=
=YZas
-----END PGP SIGNATURE-----

--h2qgfm5hu4cf6w3a--
