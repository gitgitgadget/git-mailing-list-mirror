Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170DDC4708E
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 08:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiLGIke (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 03:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGIkb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 03:40:31 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BB66317
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 00:40:30 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h10so17472686wrx.3
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 00:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wikimedia.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9nhO2nDO7K0Op99MX/WAnbST0YnGhrRzorevF1no/ww=;
        b=mbCw+5Y744gsS+yy1wR2jGRrxypROGevIm8TqA9Qizcu0MgnpIB0djOMCbQXE1uLvF
         cRCzuWT6JaBYTb69tH+nhYcPoAX3M/RMNLurevXtl/8mvCVZ6+I3I578Ch5WhvQawDp/
         y+C+FiUqrXTNR4jikPvg1pH8FekgZjrOCxAUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nhO2nDO7K0Op99MX/WAnbST0YnGhrRzorevF1no/ww=;
        b=2CkDXU9reriLkcEJMF7Dtte8FUh1es/RLr5464Ml0fnntgjWwNM9qOLvQi8My9/K0O
         Nv15HhT1I05tMm3LAKd3LtqQEo3vSoZfEpV2ySIj+4D/L2bRx3VYaqJOiYwpjECURf41
         5qqXu8gGCUZi+J2HEqS5wyfXRo6hZCKlEBYkdfTtXBTQvn5JZq3utBdjU42yKAVmZ3Id
         i+06lYfXjwp/kzlDaPMJh5MAkPhF55tQOzZhknTTP8CA4OCkNTuiknhnG/9CfxcHScHg
         Y9M7YCwF6FhR6tGzny2VwBHQolXwoM0nQsnWfL0A3LhqBEWYEmzDKIkxH0pEmKwTVhs9
         aLzA==
X-Gm-Message-State: ANoB5pnjbOdcDZKybAx+Qzam8h/H/TxzmKDGoPa43nHSczs696NT23Lq
        SRRYo9/RbotJXXdIFK6J0FoDTafSdtnW4egN
X-Google-Smtp-Source: AA0mqf5BsoUN2b2BknkyfaN0GpO6f9bolUl6CCmb1rWj6Yq7FJXbtl7BTTc70LMkhwrzvULuYDj24w==
X-Received: by 2002:a5d:4b0a:0:b0:242:7eb7:5f6 with SMTP id v10-20020a5d4b0a000000b002427eb705f6mr2187383wrq.416.1670402428785;
        Wed, 07 Dec 2022 00:40:28 -0800 (PST)
Received: from localhost ([2a01:e0a:8e6:e040:a8e5:5d56:8e6f:5401])
        by smtp.gmail.com with ESMTPSA id p18-20020adfce12000000b00242271fd2besm18656148wrn.89.2022.12.07.00.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 00:40:27 -0800 (PST)
Date:   Wed, 7 Dec 2022 09:40:27 +0100
From:   David Caro <dcaro@wikimedia.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: Skipping adding Signed-off-by even if it's not the last on git
 commit
Message-ID: <20221207084027.7dhyaatkzaawrg4g@vulcanus>
References: <20221206170646.6lnpr6h7oprziy5b@vulcanus>
 <Y4/xSObs9QXvE+xR@nand.local>
 <xmqqlenj7t0b.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ezbbegwpmmj3j4sl"
Content-Disposition: inline
In-Reply-To: <xmqqlenj7t0b.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ezbbegwpmmj3j4sl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12/07 13:11, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>=20
> >> I propose enabling it for commit, merge and am.
> >
> > So I think that there are some legitimate uses outside of 'format-patch'
> > that we may want to keep the existing behavior. So I don't think we
> > should necessarily change the default to have other commands outside of
> > 'format-patch' start passing APPEND_SIGNOFF_DEDUP.
> >
> > But I could see a future where we add a new option that controls whether
> > or not we pass that flag, perhaps:
> >
> >     $ git commit --signoff[=3D[no-]dedup]
>=20
> That sounds sensible.

Agree, I will implement this then for commit for now, thanks!

--=20
David Caro
SRE - Cloud Services
Wikimedia Foundation <https://wikimediafoundation.org/>
PGP Signature: 7180 83A2 AC8B 314F B4CE  1171 4071 C7E1 D262 69C3

"Imagine a world in which every single human being can freely share in the
sum of all knowledge. That's our commitment."

--ezbbegwpmmj3j4sl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEcYCDoqyLMU+0zhFxQHHH4dJiacMFAmOQUXoACgkQQHHH4dJi
acOsFAf+NhA9s4Q/d+25HUnoAuUKIq8pOAP1tt95X4QF46Mmau6M9/0rvA4qQfQR
zI0z3tUOvXjmIuLH115BOgUPEhky/7pETosj1K9LnPKiqcriO1v/DjYZfNG38baY
NHP+cyXbo5bgBLhW2I9esLpJ/08f2fWr7wxAJGJKY/1yPAT/EAPKX4MFCib032XD
BMiynkXc6hnschaX2TJglaLUNOGKdjp0s4+Fk3w3jpOzazM1iCBRHmwS4XO5VKMM
/xHdhBP7ST545e2sWj2e+iBYnzaBAzEuBVku9BVTNNIdykIbGyZeow4p/E3dmxJw
n2/SYiS3+bN8bszUy1t8IhwDHcJWaA==
=mRy6
-----END PGP SIGNATURE-----

--ezbbegwpmmj3j4sl--
