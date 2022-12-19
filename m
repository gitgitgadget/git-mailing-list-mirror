Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F52C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 14:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiLSODb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 09:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiLSODZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 09:03:25 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B2BDFE6
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 06:03:23 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id BB3EA5A20E;
        Mon, 19 Dec 2022 14:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1671458602;
        bh=HLIHfMb/+fQBsgPRVp36DLdHgk+ZRqw/Go9xHoIeVKU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xHO7vyp3VI8URfYN3wrYFC220QLqqlVzUF6FwJ3tmnowKyXHJTGiKQv0cOJXsQgfD
         ImB6lBK/xj+2KpQugkKAozHTjh0jFjW6frHXt0Xe4y9mTU8l0W3GX4B9bOeRzjIga/
         2FM7a/EApecJ2P9l6aqk18CqmAP0+hqRi18RVNLtkaFoKzs3kMz3K3LVumufSIh/Sd
         8pqMwmVc5y+gvcLGSuH004pzMJ3ePG4Lid9xYMIRDnqyYpxLFS6GypE1pBGKUlQr08
         PbP6aVzZEN2zZ90qlHJu+nx6IDvsf5MV1kizOoqDIWsR1QwxnZO3Mk+Jxb+2VgMAlX
         TJQd3fmZS5O7v1n+tUkG08OkqzBFjC3LR0CgCwGgWZ1ZLWX4UgXX6nfOsKtBaVW45Q
         ta/CHACXoToDMU4iz2geOM6hQB633pRWqAX0w0L5ExJLzkEMmX0+uKT98Ve0tjXVSE
         STk39YuFn0Fj/0vYvbzMIdPsADKzgOE8H9upqTTstzzroq2QkFL
Date:   Mon, 19 Dec 2022 14:03:21 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: make 'test_oid' print trailing newline
Message-ID: <Y6BvKdWJIHKq7GMs@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20221218162905.3508164-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EGxfMnx6atw6yzxe"
Content-Disposition: inline
In-Reply-To: <20221218162905.3508164-1-szeder.dev@gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EGxfMnx6atw6yzxe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-12-18 at 16:29:05, SZEDER G=C3=A1bor wrote:
> Arguably we would be better off if 'test_oid' terminated its output
> with a LF.  So let's update 'test_oid' accordingly, update its tests
> in t0000 to account for the extra character in those size tests, and
> remove the now unnecessary 'echo $(...)' command substitutions around
> 'test_oid' invocations as well.

I don't recall that there was a particular reason for me to do it the
way that it was, and if the commit message doesn't mention it, I think
it's fine to replace it.  Perhaps I intended to allow writing the binary
form as well as the text form, in which case a newline would be
undesirable, but I simply don't recall.

All that to say, I think this patch is fine as it stands.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--EGxfMnx6atw6yzxe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY6BvKQAKCRB8DEliiIei
gYDCAQDhOu0YnS/UFha/ku91Mcp4MmqD0lyMPHwLfpae58C1PwEAxxIgq868BiIu
rQ//lKvxtSF5aVatewZrMXCbjl55iwE=
=khSD
-----END PGP SIGNATURE-----

--EGxfMnx6atw6yzxe--
