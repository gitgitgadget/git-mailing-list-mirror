Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0C3B207D2
	for <e@80x24.org>; Fri, 23 Jun 2017 23:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754679AbdFWXEh (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 19:04:37 -0400
Received: from hahler.de ([188.40.33.212]:53085 "EHLO elfe.thequod.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754621AbdFWXEg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 19:04:36 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jun 2017 19:04:36 EDT
Received: from localhost (amavis [10.122.1.24])
        by elfe.thequod.de (Postfix) with ESMTP id 373366212E;
        Sat, 24 Jun 2017 00:57:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thequod.de; h=
        content-type:content-type:in-reply-to:mime-version:user-agent
        :date:date:message-id:references:subject:subject:from:from
        :received:received; s=postfix2; t=1498258678; bh=Clu+ebXHej43Lig
        HsxPaJvSq1ROT8S0mKz7p+yua6WE=; b=r6UaS45blSgCSZef24qiCiL3Aowg5Hl
        wnJvVi8UdPqiMwkqDXY9etxRvYiXV2h3cN+nLrJQcI8LHE7i0Cjj7pnAN1LjzFVC
        822PzAwdOApr7/80QRxlKjhcA9jlMTaXo5hPjoKBl2mF5kS2VAdSJeaoNfxuqN/h
        miYjkj3IzZv8=
Received: from elfe.thequod.de ([10.122.1.25])
        by localhost (amavis.thequod.de [10.122.1.24]) (amavisd-new, port 10026)
        with ESMTP id QH1_DNzym-Ng; Sat, 24 Jun 2017 00:57:58 +0200 (CEST)
From:   Daniel Hahler <git@thequod.de>
Subject: Re: [PATCH] xdiff: trim common tail with -U0 after diff
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <20170623103612.4694-1-git@thequod.de>
 <fa350688-1831-f979-b984-3b6d54e32b8c@web.de>
Message-ID: <436f31fb-3a06-e6ca-094e-8e92aa1ee1d1@thequod.de>
Date:   Sat, 24 Jun 2017 00:57:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <fa350688-1831-f979-b984-3b6d54e32b8c@web.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nBRpFaNgrMrIQu5Qcuo6IaeHcQ1Utc9FW"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nBRpFaNgrMrIQu5Qcuo6IaeHcQ1Utc9FW
Content-Type: multipart/mixed; boundary="9aQxDKvC0wpAxvaRKQsgjgXOUG5DciRVs";
 protected-headers="v1"
From: Daniel Hahler <git@thequod.de>
To: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 Stefan Beller <sbeller@google.com>
Message-ID: <436f31fb-3a06-e6ca-094e-8e92aa1ee1d1@thequod.de>
Subject: Re: [PATCH] xdiff: trim common tail with -U0 after diff
References: <20170623103612.4694-1-git@thequod.de>
 <fa350688-1831-f979-b984-3b6d54e32b8c@web.de>
In-Reply-To: <fa350688-1831-f979-b984-3b6d54e32b8c@web.de>

--9aQxDKvC0wpAxvaRKQsgjgXOUG5DciRVs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.06.2017 22:39, Ren=C3=A9 Scharfe wrote:

> The changed test script passes just fine for me even without your chang=
e
> to xdiff-interface.c, which is odd.

Sorry, I've apparently messed this up - it seems to be the case for me, t=
oo.

I would assume that using the functions.c context/diff in this test file =
might prove it, but when I wrote this test I was already unsure to base i=
t on an experimental feature, that might just get removed again (with its=
 tests).

> Do you have another way to demonstrate the unexpected behavior?

It was clearly reproducible with a local test case, based on "copying an =
existing test case, and modifying the header for it only".

Given the other replies, it seems like it is more a question now if the t=
rimming should get moved down, or removed completely it seems.
So I will not update the patch/test for now.


--=20
http://daniel.hahler.de/


--9aQxDKvC0wpAxvaRKQsgjgXOUG5DciRVs--

--nBRpFaNgrMrIQu5Qcuo6IaeHcQ1Utc9FW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS1psIggp+uXWnrnKN8Ar+FP+Y+AAUCWU2c9QAKCRB8Ar+FP+Y+
ANs+AJwM0pwHmXVLGQgqCswSHvtT4+T1zACgyLFY4I4LsoLa/DOZxm1N7hNefhM=
=SJdR
-----END PGP SIGNATURE-----

--nBRpFaNgrMrIQu5Qcuo6IaeHcQ1Utc9FW--
