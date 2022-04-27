Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB04C433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 00:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356485AbiD0AwS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 20:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347338AbiD0AwR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 20:52:17 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C72580DB
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 17:49:07 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 82E585A421;
        Wed, 27 Apr 2022 00:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1651020546;
        bh=xN2aPcZ1SOdt4NbkA5OiWfKURdvQx+qcbglT4PLJlOI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Gd3CEEb0Ie4L8bEByEjH/lSe3/lgtpjpKEMBewHAHkOmbF4jshjROgYGn0HxAFylA
         NYqSHOW4bVT79gzK8wMAVffTZiRon4If2mFhzlvYrIzBwvgFWl4z9gTUWMAteYSN9r
         ftMRWtIPgepy6eYBdVblm3MU4ogSHrRcxMHo2/PtZK6RT4KEi2OBU6Ig3OVQ+LOpt9
         sIEc2nx9oilMUomtbS8r3i6Lo0W8Uyg89t5mxcuHdRIje8exJPEG3M/jghFanSWX9b
         BmWncyDDw7aZJyNeowFWqBDq9rtqdVpuYqGX1mDwBXR/+vV7uxXi+79L+qQMkRb6yc
         vXo6GWzgDXPIAM0o90FkooOKG1n542z+aA9oyWsW9PWY4D6nwzzB83VRnnopojIZck
         BID0jMt1Ki70BKOHyI8geWtEs4ReSO9XVUpsyKE1jMR1hDunRV/2i5v40Vmo0zyYuK
         GpxPSb8UPuDCh/MIksNyQTbTbKUw/+Ur+MAdFVlCBBgwyZueL8U
Date:   Wed, 27 Apr 2022 00:49:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Drew Green <agreenbhm@gmail.com>
Cc:     Drew Green via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] Added Curl Option to Override Request Method v2
Message-ID: <YmiS/U34WJG/qRoT@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Drew Green <agreenbhm@gmail.com>,
        Drew Green via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1225.git.1650970894143.gitgitgadget@gmail.com>
 <pull.1225.v2.git.1650988659280.gitgitgadget@gmail.com>
 <YmhkCAbmNE8A7Wqy@camp.crustytoothpaste.net>
 <CANDN8xGh31E3VwgRUb6YgFuswiyYjzJwK-tyvmo2c6KY+pOtJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T9O0NSYlKGl8l7nn"
Content-Disposition: inline
In-Reply-To: <CANDN8xGh31E3VwgRUb6YgFuswiyYjzJwK-tyvmo2c6KY+pOtJA@mail.gmail.com>
User-Agent: Mutt/2.2.3 (2022-04-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--T9O0NSYlKGl8l7nn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-04-26 at 23:34:32, Drew Green wrote:
> Brian - I understand what you're saying, however I don't think adding
> this feature is detrimental in any way. It is simply leveraging a
> feature of curl without any promises of resulting behavior. Why not
> allow users to take advantage of a library feature if it can help?

Because the protocol is defined to use POST.  We might well define GET
to mean something different in the future.  HTTP verbs are not
interchangeable, and GET requests can be subject to caching while POST
requests typically cannot.  Similarly, GET requests are idempotent,
while POST requests are not, and what you're proposing would allow
creating non-idempotent GET requests, thereby violating the HTTP
specification.

Also, people will expect it to work and complain when it doesn't. People
will complain that GitHub no longer supports it if we fix the bug[0]
because Git has an option to use GET.  People will also expect this
support in Git LFS as well even though it cannot possibly work there,
and be angry that we won't support it.

I'm very much opposed to this.  There are all sorts of broken proxies
which break Git in various ways, and this is just another situation in
which they do that.  The solution is to use SSH, if that's available, or
fix the proxy.  A proxy that doesn't handle POST properly doesn't even
speak HTTP/1.1 properly, and that was defined in 1999.  There's really
no excuse to have such software on the Internet today.  Such a proxy
wouldn't even be usable for a web browser.

[0] It is my intention to fix this bug in GitHub's Git service in short
order.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--T9O0NSYlKGl8l7nn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYmiS/AAKCRB8DEliiIei
gdr4AQDe3cF912T0nn1ElqyuIsHMF0sLEfG1o+M0U9EYyaqETgEArnyZLut5CfbW
1DvVi/JBLR2pnDXbA7E9R9QffCnR9wQ=
=762k
-----END PGP SIGNATURE-----

--T9O0NSYlKGl8l7nn--
