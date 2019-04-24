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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6794B1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 07:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbfDXHsR (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 03:48:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35014 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729565AbfDXHsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 03:48:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id f7so1099861wrs.2
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 00:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=u7IqQVUHeTJe1UyTSqTOJrdDNZmxtnSUB9s/IQBfIX4=;
        b=RYBC+g2zuI/pV77zbK6YfPrr/OODX81KNl3xJ3jshWU0vMGm5Izg0WrUNddalc+Bsu
         0270EyVHXPLxWETVhhHutlHw1FK1d2jrmMym2f+2nrT0c6Had3CMphtXNFnJ5PivumdB
         sjOrxzKm0D1GTUAoS35mTdN9VGKoVGjj87SiyaqLFiphoEulLyvTw8BrNc+wS6/vuQT7
         Z2Au4bCPvcRsoe1yNEHtjs8I56DPIre/sCFJtru93frWTfGAIr/uz9m/fvQUk7nWeCwq
         Ce2V5SvmGMGpTfTch1yyMYyZHSNZrkhBfgCBGSW0tV+6qQl1DjKPtJSxlWLPWjcIfWmW
         EeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=u7IqQVUHeTJe1UyTSqTOJrdDNZmxtnSUB9s/IQBfIX4=;
        b=Y4thzLJO6YM1SMvjxKZl1vvH3bYsxzkT7sZzWxCyynI2KIGe/1dKziCs8lS+nZrQiP
         uMVU9CvHqUwID4wsI8+D/JdyQRD9qW118zO5prubumNoWbRKYaRvuDq5qtFNcBnsi/bc
         hvlrSSTP0B4LbIVp/0MbOcGds8g4eD4dfjYr+cw4iXrqqnwtCWVlTMW/v7Eykd5eoosB
         53AKMD00xQGd7MyJ4S/7crxgJqRCpAMu7W4Up5EPG7PNnJBBGHMKQVN7uSvEZzWG8qrg
         5yAJlubrJ83mGu28Ewrr4Dm7R7oaqcEdtx1FI7Z0yAMhywV7MUcQ30XpVy51r8rqf2MH
         WO8A==
X-Gm-Message-State: APjAAAURsRmHAXMNGE2n80paXqWrLHQYivPpwNBUKoXzA9ffihniDq+d
        FGOPyoadM6gGJtJJ47+z5j4=
X-Google-Smtp-Source: APXvYqz+tPzsRW7XslNp8hqxlfVtrfJm043joAfHfcH5d8jshuSds7F/yEry3Gae2sZFy2d8tlmrlQ==
X-Received: by 2002:adf:f206:: with SMTP id p6mr10180405wro.168.1556092094744;
        Wed, 24 Apr 2019 00:48:14 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id h18sm16095296wrt.97.2019.04.24.00.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 00:48:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/8] Documentation: add Packfile URIs design doc
References: <cover.1550963965.git.jonathantanmy@google.com> <cover.1552073690.git.jonathantanmy@google.com> <5ce56844d3fb740e29d2f3d4be2ade0b2ad5f7fd.1552073690.git.jonathantanmy@google.com> <20190423053130.GA13162@sigill.intra.peff.net> <20190423221159.GA98980@google.com> <87zhogs6k6.fsf@evledraar.gmail.com> <20190423224839.GC98980@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190423224839.GC98980@google.com>
Date:   Wed, 24 Apr 2019 09:48:13 +0200
Message-ID: <87v9z3sv2a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 24 2019, Jonathan Nieder wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Wed, Apr 24 2019, Jonathan Nieder wrote:
>>> Jeff King wrote:
>>>> On Fri, Mar 08, 2019 at 01:55:17PM -0800, Jonathan Tan wrote:
>
>>>>> +If the 'packfile-uris' feature is advertised, the following argument
>>>>> +can be included in the client's request as well as the potential
>>>>> +addition of the 'packfile-uris' section in the server's response as
>>>>> +explained below.
>>>>> +
>>>>> +    packfile-uris <comma-separated list of protocols>
>>>>> +	Indicates to the server that the client is willing to receive
>>>>> +	URIs of any of the given protocols in place of objects in the
>>>>> +	sent packfile. Before performing the connectivity check, the
>>>>> +	client should download from all given URIs. Currently, the
>>>>> +	protocols supported are "http" and "https".
>>>>
>>>> This negotiation seems backwards to me, because it puts too much power
>>>> in the hands of the server.
>>>
>>> Thanks.  Forgive me if this was covered earlier in the conversation, but
>>> why do we need more than one protocol at all here?  Can we restrict this
>>> to only-https, all the time?
>>
>> There was this in an earlier discussion about this:
>> https://public-inbox.org/git/877eds5fpl.fsf@evledraar.gmail.com/
>>
>> It seems arbitrary to break it for new features if we support http in
>> general, especially with a design as it is now where the checksum of the
>> pack is transmitted out-of-band.
>
> Thanks for the pointer.  TLS provides privacy, too, but I can see why
> in today's world it might not always be easy to set it up, and given
> that we have integrity protection via that checksum, I can see why
> some people might have a legitimate need for using plain "http" here.
>
> We may also want to support packfile-uris using SSH protocol in the
> future.  Might as well figure out how the protocol negotiation works
> now.  So let's delve more into it:
>
> Peff mentioned that it feels backwards for the client to specify what
> protocols they support in the request, instead of the server
> specifying them upfront in the capability advertisement.  I'm inclined
> to agree: it's probably reasonable to put this in server capabilities
> instead.  That would even allow the client to do something like
>
> 	This server only supports HTTP without TLS, which you have
> 	indicated is a condition in which you want to be prompted.
> 	Proceed?
>
> 	[Use HTTP packfiles]  [Use slower but safer inline packs]
>
> Peff also asked whether protocol scheme is the right granularity:
> should the server list what domains they can serve packfiles from
> instead?  In other words, once you're doing it for protocol schemes,
> why not do it for whole URIs too?  I'm grateful for the question since
> it's a way to probe at design assumptions.
>
> - protocol schemes are likely to be low in number because each has its
>   own code path to handle it.  By comparison, domains or URIs may be
>   too numerous to be something we want to jam into the capability
>   advertisement.  (Or the server operator could always use the same
>   domain as the Git repo, and then use a 302 to redirect to the CDN.
>   I suspect this is likely to be a common setup anyway: it allows the
>   Git server to generate a short-lived signed URL that it uses as the
>   target of a 302.  But in this case, what is the point of a domain
>   whitelist?)
>
> - relatedly, because the list of protocol schemes is small, it is
>   feasible to test client behavior with each subset of protocol
>   schemes enabled.  Finer-grained filtering would mean more esoteric
>   client configurations for server operators to support and debug.
>
> - supported protocol schemes do not vary per request.  The actual
>   packfile URI is dynamic and varies per request
>
> - separately from questions of preference or security policy,
>   clients may have support for a limited subset of protocol schemes.
>   For example, imagine a stripped-down client without SSH support.
>   So we need a way to agree about this capability anyway.
>
> So I suspect that, at least to start, protocol scheme negotiation
> should be enough and we don't need full URI negotiation.
>
> There are a few escape valves:
>
> - affected clients can complain to the server operator, who will then
>   reconfigure the server to use more appropriate packfile URIs
>
> - if there is a need for different clients to use different packfile
>   URIs, clients can pass a flag, using --server-option, to the server
>   to help it choose.
>
> - a client can disable support for packfile URIs on a particular
>   request and fall back to inline packs.
>
> - if and when an affected client materializes, they can help us
>   improve the protocol to handle their needs.
>
> Sensible?

Food for thought: would we consider ssh->https a "downgrade"? I think
"maybe". We're going from whatever custom setting the user has
(e.g. manually approve new hosts) to the CA system.

But I think it would be fine to just only whitelist ssh->https and ban
everything else behind a very scary config option or something, we could
always fleshen out the semantics of upgrade/downgrade/switching later,
and it would IMO suck less than outright banning a protcol we otherwise
support in the design, and which (unlike git://) is something people are
still finding uses for in the wild for non-legacy reasons.
