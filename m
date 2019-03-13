Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB41B20248
	for <e@80x24.org>; Wed, 13 Mar 2019 22:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfCMWRt (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 18:17:49 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:56302 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfCMWRt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 18:17:49 -0400
Received: by mail-wm1-f45.google.com with SMTP id 4so860550wmf.5
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 15:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=krD8qImhgfUHJ4tewuCTzrd1/1N4sxw3UsnRVpm56ns=;
        b=pvceuYm3C5/+inVm/PeuKoLwX3j5NjttHrzyMe7mUXDQ1EBnhCeP2j3K8BL3IKqRSC
         GhtY83x8p6BqcsJoi07NOCWW8qUzPYwjqATTBRW/AJJwx+xsKC4OPeUTmdR2z8V8U5fH
         0IQOmHWxLX0XtmP3W3zrKz68kRp7B8n0/poc5TW+RiAGlLwGTVCPNsx1nd5qi8VvvUIu
         AwzAJL23SZGRCDYFyXf6jkha1Ahta04MXVwh2nZPnXVxeYyMfQTYbd3lkSSg80c51P0b
         1Pbxo4W9lxM4C2/CTaHR0uL/l+GfTy47HCHjfNSQx0irtGjcTGgkudRpqi/oI35gwdWR
         RqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=krD8qImhgfUHJ4tewuCTzrd1/1N4sxw3UsnRVpm56ns=;
        b=tYI7L91wCQ7PQyF+Pn3lHLfNo5V28DdAaOO3euHFvjs874lNf0koyOPXPggT7vRiMe
         T5AxP/UK39QuyA6RKZqHFptdAcQCJuXjsWClIJo5vzLykWUrwZmN3N/sR5Gm3EMu7j20
         cwCXaqEuCOtiw45hoXaqHWYofhK+FWHac1qgfkW3wUbTnrBTCZvFNReI8kc9hC7GpUQj
         QAPOsdcI96Dn4h3g2Q6IFaonvcKuivKtRJq1HPfu5mep8f5oL83L83ALFlNDicjAT+di
         FNRmCfQ/HRB/aQpC4SIVjgw0YcGZfqi7bDGXm0gg1qQa4ogeqWKQvGpfeGVmnFDjPXzn
         gtcw==
X-Gm-Message-State: APjAAAVusNoLW8ly7rj4nU1skdP1or2bF4dQnotI3SgW7HdsnKEp8P8m
        jzUc6FnI9+VzxznmY3KA0VI=
X-Google-Smtp-Source: APXvYqzPCiZt8W9/coLqFa9vH1Tn2Rd6HaJkXNDBW52ieMLkQMeW9aoeouC4U5pTFZdFmz6hJiiwsQ==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr256554wmh.53.1552515467085;
        Wed, 13 Mar 2019 15:17:47 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id a8sm11839556wrt.79.2019.03.13.15.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 15:17:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [RFC/PATCH] point pull requesters to Git Git Gadget
References: <20190312213246.GA6252@sigill.intra.peff.net>
        <xmqqsgvrfsrh.fsf@gitster-ct.c.googlers.com>
        <20190313193909.GB3400@sigill.intra.peff.net>
Date:   Thu, 14 Mar 2019 07:17:45 +0900
In-Reply-To: <20190313193909.GB3400@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 13 Mar 2019 15:39:09 -0400")
Message-ID: <xmqq36nqe7w6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Mar 13, 2019 at 10:49:22AM +0900, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > infrequent contributors. And there are a few reasons to prefer GGG:
>> >
>> >   1. submitGit seems to still have a few rough edges. E.g., it doesn't
>> >      munge timestamps to help threaded mail readers handled out-of-order
>> >      delivery.
>> 
>> Hmph, I had an impression that the recent "why aren't these sorted"
>> topics were via GGG, not submitGit, though.
>
> We did have one case a few months ago, but I think it was since fixed.
>
> Whereas it cannot be fixed for submitGit without major re-architecting,
> because the mails go out through Amazon SES, which writes its own
> timestamp.
>
> I could be wrong about GGG being fixed though. I haven't noticed the
> problem lately, but we definitely had a submitGit-related one a few
> weeks ago.

Yeah, I was confused; <xmqqtvgk4urv.fsf@gitster-ct.c.googlers.com>
was about submitGit, but somehow I thought the sender switched to,
and the out-of-order thread was sent via, GGG.  My mistake.


