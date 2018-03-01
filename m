Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DDC21F404
	for <e@80x24.org>; Thu,  1 Mar 2018 22:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162763AbeCAWtV (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 17:49:21 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:45457 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162589AbeCAWtT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 17:49:19 -0500
Received: by mail-pf0-f172.google.com with SMTP id h19so2234034pfd.12
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 14:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c4DfYtiBTgcmw5mhxyjeZM6K6oRF2jJCjweGDTF8LoY=;
        b=RWWMf030STcYwm28zj1hHG5vxQeHJEuM7pOGlF04H5K6KcGlyZSn5yIZm4/ICc10+x
         uxwdQCNmV5RXevzBOco6S4u5h3j6oqA4OHzla7TWMQqOfF1QD5se/dC09qIhzbpAUMlz
         oLqxQn/Bok50dsGD0+vl3+T6tGbbV0NbtYJbkDaLsJhnS4U2tQIHznMJpH2qYSiGalPN
         dBpZWYSVEcf6cwnT0m4WXQajwd1NBJLi7nnPpMNbZnTcxSMOAMS8XP+m69mczTH6fxK8
         rGjxXIu1ZoTpWJLyPFW6V4buiJs0kijLHS0+dd9euYrz01XJ2W4vlGgz3RIlebPb7y5X
         Efxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c4DfYtiBTgcmw5mhxyjeZM6K6oRF2jJCjweGDTF8LoY=;
        b=QXLWfoSvtbUd9mKv3A4aQ0bWnYpTcnUYpD6k5IFdMu4jbMFvMpOqF1O9caMGgXWFbz
         MLlpgnTAgxIrJztHIPCJlGJQFMN5QzAMuzBo1C6hjuD/5bB96VHRNpoxT1dSxMy8X9Av
         /XDy4UVnmioyB076KbuhA9BpoBk4SfUcDnOiiFaoCssv3VuK+NJdPglTouEbMDEAds1J
         N5EhJ2Lm8VQVPUUzpx2SEhA5Zs9mdIo8V0pKy40OSRv7QzdIU30u+FQ7XJE8IjH4vNsD
         1nP3vbqpYBfdGO0P8jlGzjrUEoqKkiCGXGbSdA9jqvqFhelxe4zt+XupI90ILkdXSChT
         28zQ==
X-Gm-Message-State: APf1xPDrOANyV1f2XS6KwMaoDobbRKGpOiWyxGA4l4Ki1CybrWwrb/XL
        JwDBhdRdhen8qcHq9e9HSZzA4A==
X-Google-Smtp-Source: AG47ELsiKS2cvKOjIJhiWdaJCIkDfYgNItZlBVgKvgufp9JegEYfwQpWmAIcVuALxMozKgtAJAEZKg==
X-Received: by 10.99.156.17 with SMTP id f17mr2895238pge.12.1519944558961;
        Thu, 01 Mar 2018 14:49:18 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id l129sm1834039pfl.82.2018.03.01.14.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 14:49:18 -0800 (PST)
Date:   Thu, 1 Mar 2018 14:49:16 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 03/35] pkt-line: add delim packet support
Message-ID: <20180301224916.GB241240@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180228232252.102167-1-bmwill@google.com>
 <20180228232252.102167-4-bmwill@google.com>
 <xmqqfu5jfrlb.fsf@gitster-ct.c.googlers.com>
 <xmqq7eqvfqx1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7eqvfqx1.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/01, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Brandon Williams <bmwill@google.com> writes:
> >
> >> One of the design goals of protocol-v2 is to improve the semantics of
> >> flush packets.  Currently in protocol-v1, flush packets are used both to
> >> indicate a break in a list of packet lines as well as an indication that
> >> one side has finished speaking.  This makes it particularly difficult
> >> to implement proxies as a proxy would need to completely understand git
> >> protocol instead of simply looking for a flush packet.
> >
> > Good ;-) Yes, this has been one of the largest gripe about the
> > smart-http support code we have.
> 
> Hmph, strictly speaking, the "delim" does not have to be a part of
> how packetized stream is defined.  As long as we stop abusing flush
> as "This is merely an end of one segment of what I say." and make it
> always mean "I am done speaking, it is your turn.", the application
> payload can define its own syntax to separate groups of packets.

Thanks actually a good point.  We could just as easily have the delim
packet to be an empty packet-line "0004" or something like that.

> 
> I do not mind having this "delim" thing defined at the protocol
> level too much, though.

-- 
Brandon Williams
