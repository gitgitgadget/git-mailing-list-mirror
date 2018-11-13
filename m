Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1C3D1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 23:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbeKNJkb (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 04:40:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39036 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeKNJkb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 04:40:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id c72so2194563pfc.6
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 15:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q3z99B7toSVlNteyq7LgTPBUxO8YdZvRf2A2NdVZHQo=;
        b=WkLBlBy8gnHpprM1tStHH8qjdY/ny2eRI+3GQyJBlIgSH5DITqO35vuXqECEMnGpPw
         qAwqziWP6L6/PORpImFR7cZ2KPJum28YZsarhl3eM+YqidASAAkGm36N18BOAI6g5Ngg
         HQ+cbGIRv6DcV9srhpZUhtIIKujeTkyNoPbVdmMKJqM07J36SAKphSDuAYWuSabJv3p2
         5JOlDccHWkl8r3qIwRxcr/nTPk1Gy0dRtyzopkFtjueeUZfBxwQjqpQZ8ZSjDPT32g/N
         8CtLPQs2dKHE7GgHnll2NALijogELFy1Pg0k0u6dG8c80FPSVkaUbMYTANPPio4VMF+F
         Dhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q3z99B7toSVlNteyq7LgTPBUxO8YdZvRf2A2NdVZHQo=;
        b=Km5RJi0RANPJJ7/II9yccn8pzH5NkwuE0WNJkH7mRpmNuUxBGx73nLdYDzu5LX4kDb
         VT1mEdTx/W9GK5o0z8xRo5cyq2wFBecUpP+h5liRAVBgTVyftDuDjIRt1TfydLgRPM5f
         9scsTDX5e6PiEM/1f1DBrXX/m/6YmCN8rMY4lcaTmXZMzQfJQjSZYW8LX2qjXbbekkCO
         avsQmwtAVYXn6iHLGMYtQbHp0mLT9fy4sLdtwJdPWfC8CcxM2pXmNFKUQBRFqEQcvIZ7
         xHuRG9I+creh93T6mHAVlF/KW3ORTgg/1pUw7O6h4y7DSv8aScsxcGqgYj+4tvQ3RSxs
         jNyQ==
X-Gm-Message-State: AGRZ1gKaoJcJI6B8UxCgT7sfqovlrSuTLLJRXP7jmDbyCtf7kI2ddC0L
        NFaIbnXIWdnu30DjJCDYU+xJkVoG
X-Google-Smtp-Source: AJdET5e2RNx24d/FA0MJLwvVNSr/4fAXrfIjfseOFlwvagU9+6AR0Bzak27e0k15QFhnkGvk2+omuQ==
X-Received: by 2002:a63:f811:: with SMTP id n17mr6815501pgh.23.1542152394955;
        Tue, 13 Nov 2018 15:39:54 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id a17sm25808242pgm.26.2018.11.13.15.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 15:39:54 -0800 (PST)
Date:   Tue, 13 Nov 2018 15:39:52 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 02/10] git-fast-export.txt: clarify misleading
 documentation about rev-list args
Message-ID: <20181113233952.GA226088@google.com>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
 <20181111062312.16342-3-newren@gmail.com>
 <20181111063601.GB30850@sigill.intra.peff.net>
 <CABPp-BHwg2U=b+UGK2SufB7uZPmmiPVKXoTpYt+LuHnLwmwuZQ@mail.gmail.com>
 <CABPp-BFo=UvwbqV06R9PVEJ6JyEsvUCr4pe+3eQw8D2W96D96w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BFo=UvwbqV06R9PVEJ6JyEsvUCr4pe+3eQw8D2W96D96w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:

> Actually, no, it actually needs to be inconsistent.
>
> Different Input Choices (neither backslashed, both backslashed, then just one):
>   master~9 and master~10
>   master\~9 and master\~10
>   master\~9 and master~10
>
> What the outputs look like:
>   master9 and master10
>   master~9 and master\~10
>   master~9 and master~10
>
> I have no idea why asciidoc behaves this way, but it appears my
> backslash escaping of just one of the two was necessary.

{tilde} should work consistently.

Thanks,
Jonathan
