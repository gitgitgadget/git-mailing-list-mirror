Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCFDE1F453
	for <e@80x24.org>; Tue, 23 Apr 2019 22:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfDWWsn (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 18:48:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46374 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWWsn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 18:48:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id v2so5900387pge.13
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 15:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RlleMx2TcU8qPsNw9x/aPdPbEmO4UXSDHPIrZkYheSk=;
        b=LE0u5WHVXlwrWzpgbJm1MG2axxZoKqBiO/c8rECkqcvnsZYkxdu6g9c1Q0Mx/f5XHj
         2Mdl5u/ssCWMVaWWQlTexmRkn0YDnrztJ1TOq0zFelqHdxYU5MBmp10/CcNMxPTx/TyP
         wCHWHYiSmR/WwmQ3v1kLArYnUzBRRs46tbuoyke7xmAowRkvBa0k/KvOmDx1uypdGjbj
         KFyVQqW6PkP4PrwDi5R8KmPeUtSGaqVw6UwHK3ivkHCuHy45CgCrHJ8i+rFCN++pee6I
         ZC384wxofLF5ca7A3uWnDmRT4Bfr4O/fa2Z/+XGpLPCakIrtNCplvfnv6Vf6ODhNa0H0
         i+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RlleMx2TcU8qPsNw9x/aPdPbEmO4UXSDHPIrZkYheSk=;
        b=ECiniF8JOsARchgAMnkHm4FjQm9ekVVstOK42o/HI3ink/T5yGqWV7oJx0GvixhMSt
         Zcc2lb1nNEf3ff5DF7RkwcM+ivT5+Hw5fhWXoK7R/rI7lAPxGu8STKzOK3uVvqP6+ZhX
         AKi0C7N4hGVLwaSW7Zpltf5Ru7JFdewJx/jTpW55sER6e/hijNrXDZz0Zg7poLqOVAcH
         7RvUUAowFSkjPCL9F1S+S4gzn5t4D7YCGz/udgsdqcZVrYHKCNuXOpTKL3+vYG5ij1Xt
         7ccchbAvXxnzGJeZzUXkoC6ttMQnnOu5YQ+RILbXDg7CzYMn47k1xzhQF02TeAEE+WhA
         503Q==
X-Gm-Message-State: APjAAAUoux1quXXEqOssedko8sowkJfU4l6yDgBMOTXsiIhDxJMEKpcl
        HwrYE9SadoAQ39IniJl4mQI=
X-Google-Smtp-Source: APXvYqyhzHlaDX9A/MtUeRb4uHCDJdOR/8fYUdkAG87q/N5H3ijlBbeNMRthbi4qG9TMShSGapscSw==
X-Received: by 2002:a63:4c26:: with SMTP id z38mr27759290pga.425.1556059722112;
        Tue, 23 Apr 2019 15:48:42 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id j12sm20761050pgg.79.2019.04.23.15.48.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 15:48:41 -0700 (PDT)
Date:   Tue, 23 Apr 2019 15:48:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/8] Documentation: add Packfile URIs design doc
Message-ID: <20190423224839.GC98980@google.com>
References: <cover.1550963965.git.jonathantanmy@google.com>
 <cover.1552073690.git.jonathantanmy@google.com>
 <5ce56844d3fb740e29d2f3d4be2ade0b2ad5f7fd.1552073690.git.jonathantanmy@google.com>
 <20190423053130.GA13162@sigill.intra.peff.net>
 <20190423221159.GA98980@google.com>
 <87zhogs6k6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zhogs6k6.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> On Wed, Apr 24 2019, Jonathan Nieder wrote:
>> Jeff King wrote:
>>> On Fri, Mar 08, 2019 at 01:55:17PM -0800, Jonathan Tan wrote:

>>>> +If the 'packfile-uris' feature is advertised, the following argument
>>>> +can be included in the client's request as well as the potential
>>>> +addition of the 'packfile-uris' section in the server's response as
>>>> +explained below.
>>>> +
>>>> +    packfile-uris <comma-separated list of protocols>
>>>> +	Indicates to the server that the client is willing to receive
>>>> +	URIs of any of the given protocols in place of objects in the
>>>> +	sent packfile. Before performing the connectivity check, the
>>>> +	client should download from all given URIs. Currently, the
>>>> +	protocols supported are "http" and "https".
>>>
>>> This negotiation seems backwards to me, because it puts too much power
>>> in the hands of the server.
>>
>> Thanks.  Forgive me if this was covered earlier in the conversation, but
>> why do we need more than one protocol at all here?  Can we restrict this
>> to only-https, all the time?
>
> There was this in an earlier discussion about this:
> https://public-inbox.org/git/877eds5fpl.fsf@evledraar.gmail.com/
>
> It seems arbitrary to break it for new features if we support http in
> general, especially with a design as it is now where the checksum of the
> pack is transmitted out-of-band.

Thanks for the pointer.  TLS provides privacy, too, but I can see why
in today's world it might not always be easy to set it up, and given
that we have integrity protection via that checksum, I can see why
some people might have a legitimate need for using plain "http" here.

We may also want to support packfile-uris using SSH protocol in the
future.  Might as well figure out how the protocol negotiation works
now.  So let's delve more into it:

Peff mentioned that it feels backwards for the client to specify what
protocols they support in the request, instead of the server
specifying them upfront in the capability advertisement.  I'm inclined
to agree: it's probably reasonable to put this in server capabilities
instead.  That would even allow the client to do something like

	This server only supports HTTP without TLS, which you have
	indicated is a condition in which you want to be prompted.
	Proceed?

	[Use HTTP packfiles]  [Use slower but safer inline packs]

Peff also asked whether protocol scheme is the right granularity:
should the server list what domains they can serve packfiles from
instead?  In other words, once you're doing it for protocol schemes,
why not do it for whole URIs too?  I'm grateful for the question since
it's a way to probe at design assumptions.

- protocol schemes are likely to be low in number because each has its
  own code path to handle it.  By comparison, domains or URIs may be
  too numerous to be something we want to jam into the capability
  advertisement.  (Or the server operator could always use the same
  domain as the Git repo, and then use a 302 to redirect to the CDN.
  I suspect this is likely to be a common setup anyway: it allows the
  Git server to generate a short-lived signed URL that it uses as the
  target of a 302.  But in this case, what is the point of a domain
  whitelist?)

- relatedly, because the list of protocol schemes is small, it is
  feasible to test client behavior with each subset of protocol
  schemes enabled.  Finer-grained filtering would mean more esoteric
  client configurations for server operators to support and debug.

- supported protocol schemes do not vary per request.  The actual
  packfile URI is dynamic and varies per request

- separately from questions of preference or security policy,
  clients may have support for a limited subset of protocol schemes.
  For example, imagine a stripped-down client without SSH support.
  So we need a way to agree about this capability anyway.

So I suspect that, at least to start, protocol scheme negotiation
should be enough and we don't need full URI negotiation.

There are a few escape valves:

- affected clients can complain to the server operator, who will then
  reconfigure the server to use more appropriate packfile URIs

- if there is a need for different clients to use different packfile
  URIs, clients can pass a flag, using --server-option, to the server
  to help it choose.

- a client can disable support for packfile URIs on a particular
  request and fall back to inline packs.

- if and when an affected client materializes, they can help us
  improve the protocol to handle their needs.

Sensible?

Thanks,
Jonathan
