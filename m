Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D3191F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754106AbeA3VJj (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:09:39 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:44202 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754078AbeA3VJb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:09:31 -0500
Received: by mail-wr0-f180.google.com with SMTP id v31so12716444wrc.11
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DNcLqzJ37lhO4JRdlYcUrhlIPd0sT5gZnRaaDVN2Xa0=;
        b=q0t04EwWbcwCu1GaW8qo5G4qc3hw0uuOWG43ECNnH+ReX2FDDz2pv0oNkFgxQmBA6F
         RKj1q31cS0P68G/EUd4G7XD6/eXZO0HLJymyVo7sbZOHqbRIkhe5zeb75r96bj7/NLub
         QleKpobz8vbMobBlK5FQuujkpVEBb0gVLux5wHNIY6F+Pt4WebCAb2q03yYjwmcyTXGL
         ImEkoAdsjbeYiAU5lMZFzZMnUIaVRfwUvSplfJtAjntOiHTHE/OvOAmWNFVD6I4nVBBI
         k1+pxtuR/Cb23wEGBg7I572wqAXbHtFvS9DpGOaTdgzc85WbnWcEpjeP/krgNQD1rpKU
         zAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DNcLqzJ37lhO4JRdlYcUrhlIPd0sT5gZnRaaDVN2Xa0=;
        b=ROaqiluWDcP8U+3FjIgDoekx5pbw7ErTwjCFy18Dk9cTSA6SzwwN3N4WOHCy97+MjT
         8v3ZgAmqAz4zIWRBUA9F2HNMZqhh1UvUMsxuwN2r2Z+h62VmM2ujQpAvtUNRtk+lETU3
         5XjX91Z1SHORcYCUbf0qJz4YC/mnQzKZibdxvt8GDnSg0a115Y7i6fPvp8dnY5NJzkkq
         CHU1GK1JeQdEfxCS6anSP9uvp4aeh4gd5M56+G+ALZhx0TXDP21vrOkY7vCeGnWE112h
         iaFqnTRveHGBdD/EruJ/zvlWS+ah1GNtJ5yKSwwXqelsZpcmy18DUEogKwKXyUHkWV9a
         NS3g==
X-Gm-Message-State: AKwxyteQu0v43Cq0i+X05/B+NpXzsmrQ7SHfpZb/rnByPhlJCoae02z3
        I3dv2fsXB8RQ1pSE9RPj9R8=
X-Google-Smtp-Source: AH8x2265TPS+I9ahVk0mhlcVI+H0C3clrxawpov7yU+hoOZx5hHAK8wGqCMAs57tZWeFsLT478Gtjg==
X-Received: by 10.223.157.200 with SMTP id q8mr228691wre.205.1517346570397;
        Tue, 30 Jan 2018 13:09:30 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h16sm15628722wre.43.2018.01.30.13.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jan 2018 13:09:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] alternate hash test
References: <20180128170639.216397-1-sandals@crustytoothpaste.net>
Date:   Tue, 30 Jan 2018 13:09:28 -0800
In-Reply-To: <20180128170639.216397-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 28 Jan 2018 17:06:37 +0000")
Message-ID: <xmqq4ln3t5o7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This series wires up an alternate hash implementation, namely
> BLAKE2b-160.  The goal is to allow us to identify tests which rely on
> the hash algorithm in use so that we can fix those tests.

Yay.

> Provoking discussion of which hash to pick for NewHash is explicitly
> *not* a goal for this series.  I'm only interested in the ability to
> identify and fix tests.

Double yay.
