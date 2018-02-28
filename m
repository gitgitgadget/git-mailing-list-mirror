Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 909401F404
	for <e@80x24.org>; Wed, 28 Feb 2018 20:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934774AbeB1Uqq (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 15:46:46 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34932 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934682AbeB1Uqp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 15:46:45 -0500
Received: by mail-pg0-f53.google.com with SMTP id l131so1407955pga.2
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 12:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YQ65c//akoq+J3j98maW6osYjX9q6w0DYnyyXaV7qsE=;
        b=EB6Li9QnEZlDiILrQHIH7JsmzLIFeaKwhICCMFPP7wwlFaJGukmc6Jn1B38HvnbTFY
         zKP7wmBrtPEM3p9lQRExww9Xq2EBcYkbUdHS4Vbcr4tml3DxRQhmwIykbU8F6qT2cmgm
         Ry0YUA4byrFGRMwqcT1E+de63JlIRGE1tloxn5D+6tM6JSI7mmXb9bpKRXykPFAYYq0h
         5W7a0uHs6ezmOp5wRoCWYU75KYfFDvgvNLph59/Qe/I44R+9elrQCc2Zku1+u8EIqp4H
         orTJiJdPvtRaFrnTIYpp6MeRU/iaeYyacU1TWQnfm+F7PGYYFQEVKLZ8W9yzR8KwP8JC
         7pGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YQ65c//akoq+J3j98maW6osYjX9q6w0DYnyyXaV7qsE=;
        b=XFqEo27HlSl37n6FXJL1unZ+DF7c016FLnDNjFEAST4DZVMWlCUg0LXFsYb1876Q55
         wf3pEITp1VHk8HBlsPUvEEApcWKkuJ0TodpTkQghw1ufzLy/hHoWEMel9I+pIo75X6a5
         wkk47WO8Za2+PpWFo+IjNTc3wFZ29nwEwdnwMQ8r1eqmXTzJYmhOb4GoJEUavRNrOf4P
         cz2G3v4LJBd8VkiO9CLNe7Eq8Z2Yd1Tz7Wm+LmWUhR62ncwK4CUZpxfNshGMMBA5ltlm
         Zj7M75SXARf7odTJQ8n5drJ9AuTORe94+0oohamcMR4Hb4xb2plMEH6nVAst5L5q7VBd
         pHmw==
X-Gm-Message-State: APf1xPALhrLzhuAN18yPMSKRtphnEyxdlqY2rvLdQEf7r+UARhJo0SlZ
        U5XKZG7cYRLzDQlrUkecShY=
X-Google-Smtp-Source: AH8x2241I2WYN7sCz8WkbtxRAlcGYU4Xx4zlXwQi+huiv5CFS8eZPQjQHgR+5hynjDIlg1FFxPbfpQ==
X-Received: by 10.98.149.138 with SMTP id c10mr19133365pfk.143.1519850805260;
        Wed, 28 Feb 2018 12:46:45 -0800 (PST)
Received: from shfh2bkyy1.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id m15sm5919228pfi.65.2018.02.28.12.46.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Feb 2018 12:46:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180227212537.GA6899@sigill.intra.peff.net>
Date:   Wed, 28 Feb 2018 21:46:39 +0100
Cc:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <88BE70FC-B809-490C-ADB2-ABA5D9EBF0D4@gmail.com>
References: <DC552BF4-3E87-41E0-BF92-4BA9633D374E@gmail.com> <20180216165815.GA4681@tor.lan> <19EDC192-0D83-4762-AC6A-81F7D693475A@gmail.com> <xmqqbmgfvf2y.fsf@gitster-ct.c.googlers.com> <xmqq7er3tqjq.fsf@gitster-ct.c.googlers.com> <FDF4DEB8-E71A-4BFC-9437-678C8F65BBDC@gmail.com> <20180226014445.GB8677@sigill.intra.peff.net> <20180226173533.GA7877@tor.lan> <20180226204635.GB12598@sigill.intra.peff.net> <20180227210517.GA17555@tor.lan> <20180227212537.GA6899@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Feb 2018, at 22:25, Jeff King <peff@peff.net> wrote:
>=20
> On Tue, Feb 27, 2018 at 10:05:17PM +0100, Torsten B=C3=B6gershausen =
wrote:
>=20
> Of the three solutions, I think the relative merits are something like
> this:
>=20
>  1. baked-in textconv (my patch)
>=20
>     - reuses an existing diff feature, so minimal code and not likely =
to
>       break things
>=20
>     - requires people to add a .gitattributes entry
>=20
>     - needs work to make bare-repo .gitattributes work (though I think
>       this would be useful for other features, too)
>=20
>     - has a run-time cost at each diff to do the conversion
>=20
>     - may sometimes annoy people when it doesn't kick in (e.g.,
>       emailed patches from format-patch won't have a readable diff)
>=20
>     - doesn't combine with other custom-diff config (e.g., utf-16
>       storing C code should still use diff=3Dc funcname rules, but
>       wouldn't with my patch)
>=20
>  2. auto-detect utf-16 (your patch)
>     - Just Works for existing repositories storing utf-16
>=20
>     - carries some risk of kicking in when people would like it not to
>       (e.g., when they really do want a binary patch that can be
>       applied).
>=20
>       I think it would probably be OK if this kicked in only when
>       ALLOW_TEXTCONV is set (the default for porcelain), and --binary
>       is not (i.e., when we would otherwise just say "binary
>       files differ").
>=20
>     - similar to (1), carries a run-time cost for each diff, and users
>       may sometimes still see binary diffs
>=20
>  3. w-t-e (Lars's patch)
>=20
>     - requires no server-side modifications; the diff is plain vanilla
>=20
>     - works everywhere you diff, plumbing and porcelain
>=20
>     - does require people to add a .gitattributes entry
>=20
>     - run-time cost is per-checkout, not per-diff
>=20
> So I can see room for (3) to co-exist alongside the others. Between =
(1)
> and (2), I think (2) is probably the better direction.

Thanks for the great summary! I agree they could co-exist and people
could use whatever works best for them.

I'll incorporate Eric's feedback and send a w-t-e v9 soonish.

- Lars


