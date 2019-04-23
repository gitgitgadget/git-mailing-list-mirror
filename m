Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02F6E1F453
	for <e@80x24.org>; Tue, 23 Apr 2019 22:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfDWW1I (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 18:27:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33483 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfDWW1I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 18:27:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id d55so14144583ede.0
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 15:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=pTfGPbP8LpO/3iUZoBVq4HERHDsznvaD5K9+Mv8MW8Y=;
        b=Cw+Y5gNfsx+tPeqUFAH1dZYltmyl+tcDX2yXxoWKQe1hcVlkMYlh5BosKp/H6HiJh8
         uhiqJPRiYiyJA0Ni9H03xQjOyc/v98B49pbPhiXDgnR/PQ6vLxGWL4bhFfATAgBioSqE
         /FFi1CYTBuPUc8RyAMR52LnsH1UKmvziegEMoG5dOOgV5A9AAUhFBHvc/SAoiC5EEXmK
         FDeimnE4zMCmu8fqmFbRRMqkGD4CjIYwLvrnxBiFQ6Q2ydvEWEmTEep80bMW/AbPpO/q
         1CR7hS4oz1A1VbSdaszhnyXA6gDs8SNRBlJdTadQnrAAfEz9at6pI9dkmSIv0hKmjBqj
         4/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=pTfGPbP8LpO/3iUZoBVq4HERHDsznvaD5K9+Mv8MW8Y=;
        b=g2ofKU7Uw5GUByVa/UZ55B3wUnSmSvmyLthuyg0M1/iOWUYkE4aJf3Su1fazbavSnL
         tdVYF1QAFpieQTgXMtGq0lujJvwEua0jFM1PCu2Ljtgj9RvKw5ATjfDcIwj0JrgR97DU
         hDSfHo+0zkb1Gtqd+CJqOtS2aRokap7PAmPizl/CrRGtwSi+GMIhGDjlW0XWDV1vBKGo
         j1T2IcKHYeWppOaW+6fFvG+9E2WLrZK+E4aPrpIM6Z97WO+Cc0TlojYfvDiu40wm86d7
         crKe0dqjYJMrqljxaRNwq+xDBOWVbp5POdrqM9T9v9ctMQ3Xn3e6K5qt/1IuZvt2XWW7
         /YRg==
X-Gm-Message-State: APjAAAVxduN9b/MxbuoDCQg/vCLuavWffjwq0iv7JOtMLlnyMCsoJvOY
        AP9NNy48tjVAedOFq57bC4c=
X-Google-Smtp-Source: APXvYqz16NzSG0mI5uIkjPsaKoQwKS+Ja8AMfoFq4LaLjPLXpK3pKzhmKJkb/K1v3DfR7zA1vCLSfg==
X-Received: by 2002:a50:b78a:: with SMTP id h10mr18100479ede.65.1556058426790;
        Tue, 23 Apr 2019 15:27:06 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id s27sm5146880edm.4.2019.04.23.15.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 15:27:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/8] Documentation: add Packfile URIs design doc
References: <cover.1550963965.git.jonathantanmy@google.com> <cover.1552073690.git.jonathantanmy@google.com> <5ce56844d3fb740e29d2f3d4be2ade0b2ad5f7fd.1552073690.git.jonathantanmy@google.com> <20190423053130.GA13162@sigill.intra.peff.net> <20190423221159.GA98980@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190423221159.GA98980@google.com>
Date:   Wed, 24 Apr 2019 00:25:13 +0200
Message-ID: <87zhogs6k6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 24 2019, Jonathan Nieder wrote:

> Hi,
>
> Jeff King wrote:
>> On Fri, Mar 08, 2019 at 01:55:17PM -0800, Jonathan Tan wrote:
>
>>> +If the 'packfile-uris' feature is advertised, the following argument
>>> +can be included in the client's request as well as the potential
>>> +addition of the 'packfile-uris' section in the server's response as
>>> +explained below.
>>> +
>>> +    packfile-uris <comma-separated list of protocols>
>>> +	Indicates to the server that the client is willing to receive
>>> +	URIs of any of the given protocols in place of objects in the
>>> +	sent packfile. Before performing the connectivity check, the
>>> +	client should download from all given URIs. Currently, the
>>> +	protocols supported are "http" and "https".
>>
>> This negotiation seems backwards to me, because it puts too much power
>> in the hands of the server.
>
> Thanks.  Forgive me if this was covered earlier in the conversation, but
> why do we need more than one protocol at all here?  Can we restrict this
> to only-https, all the time?

There was this in an earlier discussion about this:
https://public-inbox.org/git/877eds5fpl.fsf@evledraar.gmail.com/

It seems arbitrary to break it for new features if we support http in
general, especially with a design as it is now where the checksum of the
pack is transmitted out-of-band.

> [...]
>> The problem I see is that the client doesn't get to vet the list of
>> URIs; it only gets to specify a protocol match. But there are many other
>> reasons it might want to reject a URI: we don't like the protocol, the
>> domain name is on a blacklist (or not on a whitelist), the domain name
>> can't resolve, we can't make a TCP connection to the server, we can't
>> successfully fetch the pack.
>
> Christian mentioned this desire to vet URIs before, and I'll admit I
> found it hard to imagine a use case.  Why can't it work like e.g.
> <frame> on the web, where if you don't like that domain, then you
> don't get to access the page?  From a server operator's point of view,
> if you want to support a second URI that more clients support, why
> wouldn't you just always use that second URI instead of making clients
> choose?
>
> Thanks and hope that helps,
> Jonathan
