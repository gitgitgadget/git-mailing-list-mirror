Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 502F21F404
	for <e@80x24.org>; Thu,  6 Sep 2018 14:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbeIFSxU (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 14:53:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50562 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbeIFSxU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 14:53:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so11626837wmc.0
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 07:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=CR9IJuLSF+I/GgGD5DYCQO3YH/ThKO4ywgjIx7+xpLg=;
        b=lNa7ZspPhTCSgVkEkX06zyscu3fsxsowqgV8REBUMTGJSaR6VX3L46uzLsnMLNzx0E
         hVUk5sl179s4ve5h5ar8vVSk0kivMI04KpC2MbyQi9MzWIccha4YpJmDBENfS3jy4Lym
         3DMzIhsoId+EELFk3TSEGCpbS7sbL943UL8G46B9zEM2xIZsELhleSgQZg9/CQ96F2bB
         19/A9FJYNx3LJZc+lqVjl0Cw26Vrp90L7ABz/FFUrljXcYTyroe2ELVs/gy5y9QzH7wU
         a0rnJe1Ba7aQBUgM36beQ5F8HTFP0UU8W/MoUZ2EjBAL5z2sNFrwEuh3BB9GxLnlrXa2
         gS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=CR9IJuLSF+I/GgGD5DYCQO3YH/ThKO4ywgjIx7+xpLg=;
        b=KXi9M3U+7nfz6e+jFGVOE2WGkcTFRfxaw2VvHx9itZ3qE/8q8gtyzepCAvnndlE/CW
         T+tjdwgk5gWaKovgL3IykZpdcj97LRHJ9qnBxhCQrNjhe8o9deRweH4KaNXRVJR7cmNi
         aUR/qwzyzwCOEUjEHtSFzKqyHU+9zaDchl3Zpw6wMlWz93h49NLDSxDkZb+RIa7Vw+BY
         ChIQvvLs4asydY+ICNFNRSm6IxxMy4v0TIh5l1pZ0ujcHkQKx4F8mmpRn0w5zWTr70HK
         VZUn7onQLBbCyE521nSyqwH6ioPGpEV1MbcwfPWOfgBUSjvqcm1PJ9SUoNwDnzVn/7dy
         tBKg==
X-Gm-Message-State: APzg51BkL+IViUzeRaxmF17afi3cl63ij4cdOEWUjo99lzXLqTeyYv6+
        mYbJ+b+8UJLVHgdCCP7drdg=
X-Google-Smtp-Source: ANB0VdZlkEYDtnIb7W4ei+hUHFUo+tJE7Nvn7lVOwVddwbocTRaqJTxBRqOb+mZ+CBx3TywQDIv9Xg==
X-Received: by 2002:a1c:888e:: with SMTP id k136-v6mr2504439wmd.6.1536243453546;
        Thu, 06 Sep 2018 07:17:33 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id q200-v6sm33417985wmd.2.2018.09.06.07.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 07:17:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tim Schumacher <timschumi@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC PATCH v2] Allow aliases that include other aliases
References: <20180905085427.4099-1-timschumi@gmx.de> <20180905173455.GA2336@sigill.intra.peff.net> <cd9a3a74-fdd6-0fb5-ae22-41d552391478@gmx.de>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <cd9a3a74-fdd6-0fb5-ae22-41d552391478@gmx.de>
Date:   Thu, 06 Sep 2018 16:17:31 +0200
Message-ID: <87o9dar9qc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 05 2018, Tim Schumacher wrote:

> On 05.09.18 19:34, Jeff King wrote:
>>
>> It could also extend to ! aliases if we wanted (i.e., my '!git foo'
>> example from earlier), but you'd have to carry the counter through the
>> environment between processes.
>
> That is a question about "shooting oneself in the foot" again,
> but I think trying to prevent that would require more changes
> than I can make, and it is definitely out-of-scope for this
> patch.

I agree it could be done later, but it would be great if you could
follow-up with that. Right now if you do:

    a = !git b
    b = !git a

You end up with a fork bomb, and we don't guard against this, and if you
have mixed execution / internal aliasing, e.g.:

    a = b
    b = c
    c = d
    d = !git a

The loop detection doesn't kick in.

It should be easy to add detection for this on top. See what we do with
git_config_push_parameter() in git.c already, i.e. you'd add some
simliar env variable, set items in the string list delimited by
e.g. whitespace, and then just pre-populate your string list with that
if it's set, and re-set it & carry it forward.

Then any combination of internal aliasing and custom commands will
benefit from loop detection.
