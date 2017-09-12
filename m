Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8523520286
	for <e@80x24.org>; Tue, 12 Sep 2017 11:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbdILLzv (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 07:55:51 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:33984 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbdILLzu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 07:55:50 -0400
Received: by mail-wr0-f178.google.com with SMTP id v109so21280654wrc.1
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 04:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Bh2naFp1DOyQoWVdTYDnP7MTYN0QTKs/0VM974JRZnk=;
        b=E4jytqPKkgET0WlIXSx/fC7C1btIfre4sGvnmv/lj8Htn3oqVurPdT9TsUz9iDRMtq
         IEQn4EiBFq6PIWmlgBHMoqCzP/TkpI4DwzSsa+xQPN0N1iT6DkcI+SUmMmwlJ+EI4S0D
         7F89Nnf3LqLQalM5Pgo42TCTqnrnm4VwCWDOHRcj3vqy508YAuEHGjxGD6UVpvZSFsKS
         Jv3kLQ04GqdnhXOYY5Ad7K+0Kro0S970JY1uHUITbIoKesMzWSwFfQAZ/lK9qvtn2mPx
         +LWNYUmaZZg0FOiIcyzdMdUYbSzvSlUM4Kw/7HUCiOYTpHIEOJNINm5wUqKlSUnE1bib
         4/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Bh2naFp1DOyQoWVdTYDnP7MTYN0QTKs/0VM974JRZnk=;
        b=hWM0nlMAcCJ9rPtBkrRCxEQ88rTkM0WiYHhE0S269CypteXYYKp+unHrHm5m9sslbZ
         J2wQdbg7cq3pJeHEIXMzfSK+F+JflhHJFWsA4+MhDk5+McSr1D+RsVkd242utu8tmgmp
         9Pd2CCMiVOQ2cYOHMRhjnNOUVbtbTGEPy3mYgsnBu3rLXwY020ivCVA0FEGkrJwwwEEW
         no8ci9Ugq6ZcHMw92DIgDOsyBlsLH+nu5/L4d5hTddARySnG7XC4TY8E3EE65fRuBJ0P
         uYPSixWes/HMPCwB+VLbq+BWAxPL7nefseFFk/CduOQxCpGj52pX5OoJSGE2ZC+koJ1X
         kV5A==
X-Gm-Message-State: AHPjjUgQrJqutrR0ivs6x4DLg5K4EjXu6eyP219p/Yvjl79JMHedeELi
        GehIsJ6hI/8Emw==
X-Google-Smtp-Source: ADKCNb4+ktbQj2IXv5rBJNhgKngwjhNrz2P22fY1tesuS9T9sLDgR/jnBi8x1ub3McTPRA4Y8EU26Q==
X-Received: by 10.223.134.25 with SMTP id 25mr11951213wrv.186.1505217348958;
        Tue, 12 Sep 2017 04:55:48 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id q4sm5034551wmd.3.2017.09.12.04.55.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Sep 2017 04:55:48 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 00/12] Clean up notes-related code around `load_subtree()`
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170910073928.ys4nbap76tmiurjh@sigill.intra.peff.net>
Date:   Tue, 12 Sep 2017 13:55:47 +0200
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <85A146BA-6AF8-455A-96F5-A81CE25FE220@gmail.com>
References: <cover.1503734566.git.mhagger@alum.mit.edu> <20170909103131.pppm346qbj2cdxuo@sigill.intra.peff.net> <2b7c0053-bf7a-fbdd-3cf9-39b5d9a962c3@alum.mit.edu> <20170910073928.ys4nbap76tmiurjh@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 10 Sep 2017, at 09:39, Jeff King <peff@peff.net> wrote:
>=20
> On Sun, Sep 10, 2017 at 06:45:08AM +0200, Michael Haggerty wrote:
>=20
>>> So nothing to see here, but since I spent 20 minutes scratching my =
head
>>> (and I know others look at Coverity output and may scratch their =
heads
>>> too), I thought it was worth writing up. And also if I'm wrong, it =
would
>>> be good to know. ;)
>>=20
>> Thanks for looking into this. I agree with your analysis.
>>=20
>> I wonder whether it is the factor of two between path lengths and =
byte
>> lengths that is confusing Coverity. Perhaps the patch below would =
help.
>> It requires an extra, superfluous, check, but perhaps makes the code =
a
>> tad more readable. I'm neutral on whether we would want to make the =
change.
>=20
> Yeah, I do agree that it makes the code's assumptions a bit easier to
> follow.
>=20
>> Is there a way to ask Coverity whether a hypothetical change would
>> remove the warning, short of merging the change to master?
>=20
> You can download and run the build portion of the coverity tools
> yourself. IIRC, that pushes the build up to their servers which then =
do
> the analysis (you can make your own "project", or use the existing =
"git"
> project -- I checked and you are already listed as an admin). I recall
> it being a minor pain to get it set up, but not too bad.
>=20
> Stefan runs it against "pu" on a regular basis, which is where the
> emailed results come from. So just having Junio merge it to "pu" would
> be enough to get results.
>=20
> I noticed that they now have some GitHub/Travis integration:
>=20
>  https://scan.coverity.com/github
>=20
> I'm not sure if that is new, or if we just didn't notice it before. ;)
> But that probably makes more sense to use than ad-hoc uploading (and
> maybe it would make it easy for you to test personal branches, too).

Coverity scans Git already:
https://scan.coverity.com/projects/70

I requested access to this Coverity project to integrate into our =
TravisCI
build.

- Lars=
