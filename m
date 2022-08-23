Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5609C32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 21:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiHWVPn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 17:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiHWVPb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 17:15:31 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD43110B
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 14:15:30 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id E41FD5A1AC;
        Tue, 23 Aug 2022 21:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1661289329;
        bh=+jTzlKT1y0hmcbsHE/LDf4GsFBMX2PGLp0h5WdXPQr4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=1hP99qUtKYE24AOVi5ejr4bH8bzA164AA7Dg5O6n3MeYlbg/oDkZyThoSD841Pf78
         PE478vvNHCNMldCik+QW4rB6xwaEKp6UhXvJqKjn7dWCKqt0T7bycp7RX2N6fd0VfO
         iZDLMgJt2/90Oc3iJm3WA/iZJEb1vWPnc1+R6l+6tukpGH2ZBurN8VRZShnE6WBdFz
         X9Io7x46wPMYvSSNWvUD3qetdN19wH8S5i8Y3r0Sl1rTOQPW6iRnlH01+YNciNCP08
         ARjz2TkeqccnYnC7iWQB2cqPKEMHMWqeL5NeoSoOllh00ZqtLjHV8Vc3/8t2sSy++8
         Ugnpx430kcBzO6uB56gnOmNC2bfSVGq6qK+jLj/iCQ9/NfK973khzEHzNCW1qUSWdD
         ZYb1wnTReZkSXM6QZAAxUPHztBzc/oAHeE0L48ZnRS9n7OuNgJgrovlRCrVvPcIN1V
         DSwZJAth3rcHHxSbzSLilKOIY5610QdvUhkX9yVoog/Fe7drWlD
Date:   Tue, 23 Aug 2022 21:15:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Renato Botelho <garga@freebsd.org>,
        Todd Zullinger <tmz@pobox.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] gc: use temporary file for editing crontab
Message-ID: <YwVDcO/V+zx2iy4I@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Renato Botelho <garga@freebsd.org>, Todd Zullinger <tmz@pobox.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
References: <1dd29f43-1a8e-eb69-3320-7f5140a0e18e@github.com>
 <20220823010120.25388-1-sandals@crustytoothpaste.net>
 <6428252p-ssrn-7qs7-9p26-5so10r96s3os@tzk.qr>
 <9e737b4b-4a17-09d5-6452-4ca5eef3d9da@github.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vavYoabV/w66Ijsg"
Content-Disposition: inline
In-Reply-To: <9e737b4b-4a17-09d5-6452-4ca5eef3d9da@github.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vavYoabV/w66Ijsg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-08-23 at 17:06:03, Derrick Stolee wrote:
> On 8/23/2022 5:12 AM, Johannes Schindelin wrote:
> > Hi brian,
> >=20
> > On Tue, 23 Aug 2022, brian m. carlson wrote:
>=20
> >> +	tmpedit =3D mks_tempfile_t(".git_cron_edit_tmpXXXXXX");
> >> +	if (!tmpedit)
> >> +		return error(_("failed to create crontab temporary file"));
> >=20
> > It might make sense to use the same `goto out;` pattern here, to make it
> > easier to reason about the early exit even six years from now.
> >=20
> > We do not even have to guard the `close_tempfile_gently()` behind an `if
> > (tempfile)` conditional because that function handles `NULL` parameters
> > gently.

I can do that.  I'll need to make sure we initialize the pointer to NULL
first.

> This is focused only on the cron integration, which is not used on Window=
s,
> so I'm not worried about that.

Correct.  The only place this could go wrong is Cygwin, but I believe it
has the proper behaviour (and if not, lots of stuff will be broken).

> I was initially worried that we lost the fclose(cron_in), but of course it
> is handled by the close_tempfile_gently() at the end.

Yup.  I originally called fclose here and glibc screamed at me about a
double-free, so the fclose definitely should be removed.  I'll mention
this in the commit message as well.

> Here's the crux of the matter: we are no longer using stdin but
> instead passing an argument to point to a file with our desired
> schedule. I tested that this worked on my machine, and I'm glad
> this use is the POSIX standard.
>=20
> There is something wrong with this patch: it needs to update
> t/helper/test-crontab.c in order to pass t7900-maintenance.sh.

Will fix.

> While the memory release is nice, I also think it would be good to use
> delete_tempfile() so the temporary file is deleted within this method,
> not waiting until the end of the process to do that cleanup.

Sounds good.  I'll include that in a v2.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--vavYoabV/w66Ijsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYwVDcAAKCRB8DEliiIei
gW4tAP9XnJUuaZ1yYy/bmitf5rGVrgxSnnazIvhDH0Vjcm8KugEAsdtBtpC7g2Sl
NBcXVDCTpQ+aI177qdSChGX8zZc/gA4=
=58M6
-----END PGP SIGNATURE-----

--vavYoabV/w66Ijsg--
