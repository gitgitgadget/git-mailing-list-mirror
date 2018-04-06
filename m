Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A1901F404
	for <e@80x24.org>; Fri,  6 Apr 2018 15:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeDFP7S (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 11:59:18 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:25027 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751935AbeDFP7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 11:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1523030355;
        s=strato-dkim-0002; d=aepfle.de;
        h=Content-Type:References:In-Reply-To:Message-ID:Subject:Cc:To:From:
        Date:X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=KckuVmzdbJ8Y2Lpudo4WfuywMF3BG7Tadji2xZLfEyw=;
        b=HiABHDyDX7HrwwNP48KTWhMC9Kbax/L0MxwSFppsOqyx1q5wUDlJnMVm2DkBJHMRD9
        biCqSEXWVDdZMsZfw+igf8ChNjISdDsD+3SIwfUgQiMW2cwlsJKpi9TsWaNgVHNC/NNG
        dz/zNY2nm9qJwMMJhU+Rb+P2U/FCfI8aJRQCaolO+9lys4OqzTLGGOC88OAmmgqp0Dlx
        7l+7G+urkQs8oPNDmlApdfX/sjj0tnfoyb4fdkSqhytY68p0KtX/0OlQQd3CaWLvrWrw
        XBtRmg40Ltku/phhER3UpRgMkvfi5B4Tu5nOuMlEccEoeXHow4NFQbsuAee5nwnXQ/gy
        MpHg==
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivsBRtyRe2qcrldJj63vYUTRQR/0RqPSgWq+RVwc
X-RZG-CLASS-ID: mo00
Received: from sender ([2001:a62:816:91ff:a572:884d:f51d:1a86])
        by smtp.strato.de (RZmta 43.1 AUTH)
        with ESMTPSA id K08137u36Fu2dvS
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 6 Apr 2018 17:56:02 +0200 (CEST)
Date:   Fri, 6 Apr 2018 17:55:56 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: How to undo previously set configuration?
Message-ID: <20180406175556.5b6e16f0.olaf@aepfle.de>
In-Reply-To: <20180405163227.GA25224@sigill.intra.peff.net>
References: <20180405092358.569e0315.olaf@aepfle.de>
        <874lkq11ug.fsf@evledraar.gmail.com>
        <20180405104948.276de0ca.olaf@aepfle.de>
        <8737092929.fsf@evledraar.gmail.com>
        <20180405152525.13d1c776.olaf@aepfle.de>
        <20180405163227.GA25224@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.16.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/5C9mKUT30wMO+YQ_p1sy9kw"; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/5C9mKUT30wMO+YQ_p1sy9kw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Thu, 5 Apr 2018 12:32:27 -0400
schrieb Jeff King <peff@peff.net>:

> The general strategy in Git's config is that instead of "unsetting", you
> should overwrite with whatever value you _do_ want. So a config option
> like sendemail.smtpauth should accept some kind of empty or "none" value
> to disable auth.
>=20
> Most single-value config options should work this way (and if one
> doesn't, I'd say that's a bug we should fix).

This does not work. Initially I copied the global config into the repo and =
set all unwanted values to <empty>, like 'smtpuser=3D'. Perhaps the config =
parser recognized that fact, but the consumer does not?

Olaf

--Sig_/5C9mKUT30wMO+YQ_p1sy9kw
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCWseYjAAKCRBdQqD6ppg2
fqmEAJ4w3l/bbloSpjp3wYp8nkCAwXrGqwCfdrX0/PaoKPyMuzgl4pwsWWEljkY=
=hKQz
-----END PGP SIGNATURE-----

--Sig_/5C9mKUT30wMO+YQ_p1sy9kw--
