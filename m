Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56E9C20984
	for <e@80x24.org>; Tue, 13 Sep 2016 22:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758882AbcIMWSu (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 18:18:50 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:36097 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758800AbcIMWSs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 18:18:48 -0400
Received: by mail-it0-f46.google.com with SMTP id o3so18063527ita.1
        for <git@vger.kernel.org>; Tue, 13 Sep 2016 15:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dssBnFR5Qt60WeWqc4dnzBd1SZ00kXACBk6IPgg9M6k=;
        b=g4feUj8Zf00S/YB8WNp37PxVGlcHdyTqdySlrICfV/n1CiN/2P6SlD5rxF+OLwW8yU
         gdPiUeKEwZ93ks06HvbXqpOMuBJykpX1uW4fAGJGHARk2FxEneA6B5xxug5+zeoCmw3Q
         S6Ar13i2XWgjTxGCzIsJDg/TOnbI0Sj8ybqtgNjlKg3BTM1NL4Wol3yb/CgOY0ZOamVf
         qF6okODjqMBcL5AYa9g8UCWQhmztiKbMUTvR1wfFV/J2xq/M5R7DUJwCjdxSCxSieF4e
         cHvosOdUxOWVnnEiSZ03ns28JEdZJezfnqjlcMhDGIQKbQLbdYDNd9Tg7gWNfcdCW40x
         N6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dssBnFR5Qt60WeWqc4dnzBd1SZ00kXACBk6IPgg9M6k=;
        b=BQrHHJJJ0h810hKHb9tbuajI6absVY188c9q+ynLjNBmy27Fqf340Dh0IR5zllBalk
         ek9C5kZS3XZCFgAsN4NbelAyh+/R2HOHbXV4dBJ4ndawG41Raj/oJut6otoe6RYlQz3z
         SKnyNd4YoMbn/bleXOIOHcLkinzuyMgSoTL1746r0q0ehPSBbX49UM6TCshGN/NWwIcj
         V/gIgSWbRuyL1dRp+pJI9+NN4Rv2CadU6IF+Hh1jo/dqAiHhxxe1qbMKNnwLHkGDTjwv
         sw8AsaWGf8hhpoPmD22o6DkfBCLy/qvafcPPNSGZAIP6OGJtD66GD2aK0mj224lpgyiU
         WngA==
X-Gm-Message-State: AE9vXwP75Lag+7K87avJc5xrSJiw2aPfKIcb9JEDMEw/8qcvNVJ8+vr9Zo/URXhNwUBFrJ4M9bI8lM7O+9hfU+4Z
X-Received: by 10.107.131.8 with SMTP id f8mr5749006iod.91.1473805126906; Tue,
 13 Sep 2016 15:18:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Tue, 13 Sep 2016 15:18:46 -0700 (PDT)
In-Reply-To: <20160913032422.xy22la6uw23hnvje@sigill.intra.peff.net>
References: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net> <20160913032422.xy22la6uw23hnvje@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Sep 2016 15:18:46 -0700
Message-ID: <CAGZ79kYEN7Zg2cQfVisHwHDG0YuFSGRLYjm0BC9w1hYKG_CBOQ@mail.gmail.com>
Subject: Re: [PATCH 16/16] init: reset cached config when entering new repo
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have reviewed all patches though I am no expert on
the init routines. They all look good except for the one
nit I noted for the commit message in patch 6.
With that, the whole series is:
Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks!
