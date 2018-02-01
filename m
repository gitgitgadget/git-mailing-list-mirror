Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1EA11F404
	for <e@80x24.org>; Thu,  1 Feb 2018 18:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752996AbeBAS5l (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 13:57:41 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:43675 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752189AbeBAS5k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 13:57:40 -0500
Received: by mail-yw0-f193.google.com with SMTP id x190so11242833ywd.10
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 10:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d56NKBIMh1OCuNF/nrYQWNYa2v9yRUJQjY5VZ9k5+jA=;
        b=gKoYaT66/rnIWgXmyBOxsi+6/1eiligz63uxOrcsSO0Sw7M2flEOHJoYroNIDzZc6L
         S9TJ7BwQT9RS1+nVGb+d8DSDsiJckm0Iu3toDfBmfJPeVyY3LBN4K8+ZohFB2bNFrmdG
         vauMaLpqKX78xeecwPP3mltg9Bnht9OoTRxbabixkvP/4WtzBXZ5nsnuD3uXiB5kMsNs
         DrWyU1whpf7UEYQgrymyAIAoykZhpJV4dMUPwEaTVuB5IyS6bQpZl7iad5/eWQMedu4O
         eGKCDODY3+iEep1IlpynFpTJjHxyR4nFEcjwFOHHbHp08w7E/C+9R28D0/psMWrmdYhb
         iL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d56NKBIMh1OCuNF/nrYQWNYa2v9yRUJQjY5VZ9k5+jA=;
        b=PKdaw2bQXmO6db+PStaHhtHC+VnP3dyIabldTFfqXrmPMrtmvYZnH5w1qiG70xZlSJ
         wgg0/U0ydxJ+uBLoIfveABnM7ZPeyML8fPNdpRhGAMtcisZ1Z83bJ4GbgUl4zeKVssxg
         SarqHFBu0AJXRTVkP/4DMhPCHdo6P/igvDKoikgq4ePiHYw7TGeMyq3vMe3wyspbBvsc
         M1FwXO4/EuIQJvs7OgdV+tjwsnKl87x39Cvl2sowWl4xlD9qY7EqbElIM6P2r3dzdFmB
         rtF8bZkE+TdLxz3AbCez+7GZBbvIYHP62hHyLutBUi1CNBKfgq/X0AXUmaIN7OgacCc2
         lAuA==
X-Gm-Message-State: AKwxytfM3uP+A982lmJKViUuEphJE8EVlrGzb++MfFQmOTCagJnZ5sqf
        t06E1NjHuRxaSD2J6knlgy2AGhkEkMbhtY1YCUgPpA==
X-Google-Smtp-Source: AH8x224qy/j0lWo/zOskw3OWiMYfnYZeAvDwZXucXI3hIk+xrL7GBSYneKBwY/VdWYQ+r8IDP/Afue6xAmYA8Dhqrvg=
X-Received: by 10.129.108.196 with SMTP id h187mr25779448ywc.249.1517511459005;
 Thu, 01 Feb 2018 10:57:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Thu, 1 Feb 2018 10:57:38 -0800 (PST)
In-Reply-To: <d9a15c0a-35f3-8e9c-ddf2-34420ac7555b@jeffhostetler.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180103001828.205012-12-bmwill@google.com>
 <d9a15c0a-35f3-8e9c-ddf2-34420ac7555b@jeffhostetler.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Feb 2018 10:57:38 -0800
Message-ID: <CAGZ79kZpD6m=5YP0dNuM70Yce=PyxLO6qr6aVpHKa_S9iyACww@mail.gmail.com>
Subject: Re: [PATCH 11/26] serve: introduce git-serve
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 1, 2018 at 10:48 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>
>
> On 1/2/2018 7:18 PM, Brandon Williams wrote:
>>
>> Introduce git-serve, the base server for protocol version 2.
>>
>> Protocol version 2 is intended to be a replacement for Git's current
>> wire protocol.  The intention is that it will be a simpler, less
>> wasteful protocol which can evolve over time.
>>
>> Protocol version 2 improves upon version 1 by eliminating the initial
>> ref advertisement.  In its place a server will export a list of
>> capabilities and commands which it supports in a capability
>> advertisement.  A client can then request that a particular command be
>> executed by providing a number of capabilities and command specific
>> parameters.  At the completion of a command, a client can request that
>> another command be executed or can terminate the connection by sending a
>> flush packet.
>>
>> Signed-off-by: Brandon Williams <bmwill@google.com>
>> ---
>>   .gitignore                              |   1 +
>>   Documentation/technical/protocol-v2.txt |  91 ++++++++++++
>>   Makefile                                |   2 +
>>   builtin.h                               |   1 +
>>   builtin/serve.c                         |  30 ++++
>>   git.c                                   |   1 +
>>   serve.c                                 | 239
>> ++++++++++++++++++++++++++++++++
>>   serve.h                                 |  15 ++
>>   8 files changed, 380 insertions(+)
>>   create mode 100644 Documentation/technical/protocol-v2.txt
>>   create mode 100644 builtin/serve.c
>>   create mode 100644 serve.c
>>   create mode 100644 serve.h
>>
>> diff --git a/.gitignore b/.gitignore
>> index 833ef3b0b..2d0450c26 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -140,6 +140,7 @@
>>   /git-rm
>>   /git-send-email
>>   /git-send-pack
>> +/git-serve
>>   /git-sh-i18n
>>   /git-sh-i18n--envsubst
>>   /git-sh-setup
>> diff --git a/Documentation/technical/protocol-v2.txt
>> b/Documentation/technical/protocol-v2.txt
>> new file mode 100644
>> index 000000000..b87ba3816
>> --- /dev/null
>> +++ b/Documentation/technical/protocol-v2.txt
>> @@ -0,0 +1,91 @@
>> + Git Wire Protocol, Version 2
>> +==============================
>> +
>> +This document presents a specification for a version 2 of Git's wire
>> +protocol.  Protocol v2 will improve upon v1 in the following ways:
>> +
>> +  * Instead of multiple service names, multiple commands will be
>> +    supported by a single service.
>> +  * Easily extendable as capabilities are moved into their own section
>> +    of the protocol, no longer being hidden behind a NUL byte and
>> +    limited by the size of a pkt-line (as there will be a single
>> +    capability per pkt-line).
>> +  * Separate out other information hidden behind NUL bytes (e.g. agent
>> +    string as a capability and symrefs can be requested using 'ls-refs')
>> +  * Reference advertisement will be omitted unless explicitly requested
>> +  * ls-refs command to explicitly request some refs
>> +
>> + Detailed Design
>> +=================
>> +
>> +A client can request to speak protocol v2 by sending `version=2` in the
>> +side-channel `GIT_PROTOCOL` in the initial request to the server.
>> +
>> +In protocol v2 communication is command oriented.  When first contacting
>> a
>> +server a list of capabilities will advertised.  Some of these
>> capabilities
>> +will be commands which a client can request be executed.  Once a command
>> +has completed, a client can reuse the connection and request that other
>> +commands be executed.
>> +
>> + Special Packets
>> +-----------------
>> +
>> +In protocol v2 these special packets will have the following semantics:
>> +
>> +  * '0000' Flush Packet (flush-pkt) - indicates the end of a message
>> +  * '0001' Delimiter Packet (delim-pkt) - separates sections of a message
>
>
> Previously, a 0001 pkt-line meant that there was 1 byte of data
> following, right?

No, the length was including the length field, so 0005 would indicate that
there is one byte following, (+4 bytes of "0005" included)

> Does this change that and/or prevent 1 byte
> packets?  (Not sure if it is likely, but the odd-tail of a packfile
> might get sent in a 0001 line, right?)  Or is it that 0001 is only
> special during the V2 negotiation stuff, but not during the packfile
> transmission?

0001 is invalid in the current protocol v0.

>
> (I'm not against having this delimiter -- I think it is useful, but
> just curious if will cause problems elsewhere.)
>
> Should we also consider increasing the pkt-line limit to 5 hex-digits
> while we're at it ?   That would let us have 1MB buffers if that would
> help with large packfiles.

AFAICT there is a static allocation of one pkt-line (of maximum size),
such that the code can read in a full packet and then process it.
If we'd increase the packet size we'd need the static buffer to be 1MB,
which sounds good for my developer machine. But I suspect it may be
too much for people using git on embedded devices?

pack files larger than 64k are put into multiple pkt-lines, which is
not a big deal, as the overhead of 4bytes per 64k is negligible.
(also there is progress information in the side channel, which
would come in as a special packet in between real packets,
such that every 64k transmitted you can update your progress
meter; Not sure I feel strongly on fewer progress updates)

>  Granted, we're throttled by the network,
> so it might not matter.  Would it be interesting to have a 5 digit
> prefix with parts of the high bits of first digit being flags ?
> Or is this too radical of a change?

What would the flags be for?

As an alternative we could put the channel number in one byte,
such that we can have a side channel not just while streaming the
pack but all the time. (Again, not sure if that buys a lot for us)
