Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCC411F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 20:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753984AbdKJUNw (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 15:13:52 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:40370 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753971AbdKJUNv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 15:13:51 -0500
Received: by mail-it0-f45.google.com with SMTP id 72so3010036itl.5
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 12:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=689On492GjaDMpqg5srWDh4jD4ucnOLBQKht0dN1xrA=;
        b=qtcJ9zDt0gPOltIP3anCUcrzEB90usBndMDMCR/njHK3svMP568UjsTIZlKV3NwJJK
         cusfRbBmnOsOaA7SWN16fpkdv3N7dVJAQDC6HYWMVekcARD7HTaWBb8xjY34f/iXwubu
         LprrPstwldPdlhcC4qQlhaQaAak8QYHTnyYJ6jxXcCiPn6ViRYoSqWZn9VrFUHXpdnfx
         CmLPuTpDXU/64fgUTS3KREpcFmXzsfDZnqDi942vko6/BZ33kMHchabZU79UMxM11foh
         28bWHKK5MCsJonZMHAI2i3Be5ZCMsUBX91iP4i9SIrUCUD2ErC1I89U/0OnMinlA5xTe
         OjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=689On492GjaDMpqg5srWDh4jD4ucnOLBQKht0dN1xrA=;
        b=HYs/TwWOxAl5HTYh2OMzlZVbWQgnbbcgQKVpTQmLgq+normtf27WugCr3fJEsLIxST
         IMRvBmv87BqOzz9JRUS5cJkLu5t/wQu19bVl/f4hoa0PwKCG8rgukTEiFBHA38H9a0Jm
         I45dzpRKW6cKvLmkSMnhQ7kfnJcZfHHZyPnaJlq/AL6HSOV/Rda7GoDmKDmOgIqVThtn
         s+L5UY6BNZa4IWioHuFmaR8VEGmmJOKlJ/Ti8teoF10BWxe9qSU5SBSwkk7d2xyYbtxQ
         mlfwNYZZ5Qjm1WUJvwDRnO5MMKl1j4a1//7mG5zAmWrU6fjBhg24PM/ljq9KaTv9jebm
         IihA==
X-Gm-Message-State: AJaThX5X+o+Gs86JKeaY2jx3hqW30OMBA4CVervGBKtSq8VfhAK5qFAL
        XCyMJ0CKaqGst4bHR4s5x+vaEw==
X-Google-Smtp-Source: AGs4zMakk9YfQxq5wWyA7TWRBMLA1kkEaBmmrcD4MwiaZHNuWB/2Oi0dXEGRCyOEEejDjmiA3aaJVQ==
X-Received: by 10.36.69.222 with SMTP id c91mr1972304itd.125.1510344830194;
        Fri, 10 Nov 2017 12:13:50 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:b965:842e:5afa:853e])
        by smtp.gmail.com with ESMTPSA id k19sm1327033itb.18.2017.11.10.12.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Nov 2017 12:13:48 -0800 (PST)
Date:   Fri, 10 Nov 2017 12:13:47 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, spearce@spearce.org, git@jeffhostetler.com,
        gitster@pobox.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [RFC] protocol version 2
Message-Id: <20171110121347.1f7c184c543622b60164e9fb@google.com>
In-Reply-To: <20171020171839.4188-1-bmwill@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 20 Oct 2017 10:18:39 -0700
Brandon Williams <bmwill@google.com> wrote:

> Some of the pain points with the current protocol spec are:

After some in-office discussion, I think that the most important pain
point is that we have to implement each protocol twice: once for
HTTP(S), and once for SSH (and friends) that support bidirectional byte
streams.

If it weren't for this, I think that what is discussed in this document
(e.g. ls-refs, fetch-object) can be less invasively accomplished with
v1, specifying "extra parameters" (explained in this e-mail [1]) to
merely tweak the output of upload-pack instead of replacing it nearly
completely, thus acting more as optimizations than changing the mode of
operation entirely.

[1] https://public-inbox.org/git/20171010193956.168385-1-jonathantanmy@google.com/

>   * The server's initial response is the ref advertisement.  This
>     advertisement cannot be omitted and can become an issue due to the
>     sheer number of refs that can be sent with large repositories.  For
>     example, when contacting the internal equivalent of
>     `https://android.googlesource.com/`, the server will send
>     approximately 1 million refs totaling 71MB.  This is data that is
>     sent during each and every fetch and is not scalable.

For me, this is not a compelling one, because we can provide a ref
whitelist as an "extra parameter" in v1.

>   * Capabilities were implemented as a hack and are hidden behind a NUL
>     byte after the first ref sent from the server during the ref
>     advertisement:
> 
> 	<SHA1> <Ref Name>\0<capabilities space separated> <symref> <agent>
> 
>     Since they are sent in the context of a pkt-line they are also subject
>     to the same length limitations (1k bytes with old clients).  While we
>     may not be close to hitting this limitation with capabilities alone, it
>     has become a problem when trying to abuse capabilities for other
>     purposes (e.g. [symrefs](https://public-inbox.org/git/20160816161838.klvjhhoxsftvkfmd@x/)).
> 
>   * Various other technical debt (e.g. abusing capabilities to
>     communicate agent and symref data, service name set using a query
>     parameter).

I think these 2 are the same - I would emphasize the fact that we cannot
add more stuff here, rather than the fact that we're putting this behind
NUL.

>  Special Packets
> -----------------
> 
> In protocol v2 these special packets will have the following semantics:
> 
>   * '0000' Flush Packet (flush-pkt) - indicates the end of a message
>   * '0001' End-of-List delimiter (delim-pkt) - indicates the end of a list

To address the pain point of HTTP(S) being different from the others
(mentioned above), I think the packet semantics should be further
qualified:

 - Communications must be divided up into packets terminated by a
   flush-pkt. Also, each side must be implemented without knowing
   whether packets-in-progress can or cannot be seen by the other side.
 - Each request packet must have a corresponding, possibly empty,
   response packet.
 - A request packet may be sent even if a response packet corresponding
   to a previously sent request packet is awaited. (This allows us to
   retain the existing optimization in fetch-pack wherein, during
   negotiation, the "have" request-response packet pairs are
   interleaved.)

This will allow us to more easily share code between HTTP(S) and the
others.

In summary, I think that we need a big motivation to make the jump from
v1 to v2, instead of merely making small changes to v1 (and I do think
that the proposed new commands, such as "ls-refs" and "fetch-object",
can be implemented merely by small changes). And I think that the
ability to better share code between HTTP(S) and others provides that
motivation.
