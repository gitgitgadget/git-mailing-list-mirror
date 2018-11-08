Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4AE1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 03:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbeKHNJF (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 08:09:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37778 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbeKHNJF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 08:09:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id o15-v6so15986779wrv.4
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 19:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pyhJtQSHZBxlbMypt7WpOGcD/JstPgS3mgp83BONQkc=;
        b=YOjHHi70NnbTqCoPOyiboZBbINQS3ZcXfDikHnrlcJPTzu6wcoPOG2HcmVs0JqGGEj
         vwgceYlqoiCz5qFtK/i/hFBb/sCNjsXC5gMw0B2vuVd+QhQu8TGDvsZbchF1U4yOcGy2
         N2RmKK6Leyk56187fRIYCryE+i7axCQMq7FAPcHh3AgDuqeaX5jilG9nbqC3GVU/mzM2
         +eIpCzJWiLZiMmKP4XAgyyGPb4BOaANL0s7eYT+bXJrQwoP3bDmY4WfGIfoJSYgLxTQX
         gLmUoTBWeyYIrmCcFMods5F0g0SQM9hgT3BCw+HLc9lzHvEjtP8wHPuOW9eR1/DCbIBs
         5+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pyhJtQSHZBxlbMypt7WpOGcD/JstPgS3mgp83BONQkc=;
        b=D/KhJaQPm3mTVlMr7dWO+H0IvX/gFC6kOVAPJnkGs9X4/aMv6sIbj2wGP93Wx3q3tJ
         VDHEKLoCoxUKFs9eq8cuPN4VBlY66RzaFSmwnIVG+0BggNifhBKdD0BxInYdoJfr0V+1
         6r+yfGnkJuiVCu2WDREnFHPTUBBn4oYuwM4jylhDlaOBRaS3Zb0l0ssjwiB4zCueHZ7u
         vqpA3ivKWhEO/J8/D1/2dzHF1YW9kaok9DDtcdXSdZHEByZ1rNMWtcJ8zLAH9N2NzKgY
         /oxwmup2QTzgxbBNR4tM+XQhOEbvxFaCUjXIx6TGiOSEJdE/bmfVx3kul33hSCNHWMGz
         lbVQ==
X-Gm-Message-State: AGRZ1gLFnbwXilGi8gWAMjsMIBJi2GhX0quivRih4wxS3wk7h4JcS+Ia
        80Qri71U8jJv0zRxv9QzRts=
X-Google-Smtp-Source: AJdET5d68B55ZDYSirbQS17Gq5rbzfn6eDcGFKfvgWByzdPBI8YDvUEvHPm56AensD4c/fQ8I3sfwA==
X-Received: by 2002:adf:f4c5:: with SMTP id h5-v6mr2424082wrp.21.1541648139156;
        Wed, 07 Nov 2018 19:35:39 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t66-v6sm3404629wmt.5.2018.11.07.19.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 19:35:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Daniel Stenberg <daniel@haxx.se>,
        "Force.Charlie-I via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] http: add support selecting http version
References: <pull.69.git.gitgitgadget@gmail.com>
        <alpine.DEB.2.20.1811071443130.3368@tvnag.unkk.fr>
        <20181108011813.GE890086@genre.crustytoothpaste.net>
Date:   Thu, 08 Nov 2018 12:35:37 +0900
In-Reply-To: <20181108011813.GE890086@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 8 Nov 2018 01:18:13 +0000")
Message-ID: <xmqqd0rg8cmu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Wed, Nov 07, 2018 at 02:44:51PM +0100, Daniel Stenberg wrote:
>> On Wed, 7 Nov 2018, Force.Charlie-I via GitGitGadget wrote:
>> 
>> > Normally, git doesn't need to set curl to select the HTTP version, it
>> > works fine without HTTP2. Adding HTTP2 support is a icing on the cake.
>> 
>> Just a FYI:
>> 
>> Starting with libcurl 7.62.0 (released a week ago), it now defaults to the
>> "2TLS" setting unless you tell it otherwise. With 2TLS, libcurl will attempt
>> to use HTTP/2 for HTTPS URLs.
>
> With this information, I think I would rather we rely on libcurl to do
> this rather than putting it in Git.  Users will automatically get the
> best supported protocol instead of having to configure it manually.

Yup.  I suspect that the mechanism _might_ turn out to be useful to
force downgrading, though.
