Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 121481F404
	for <e@80x24.org>; Thu,  1 Feb 2018 20:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754874AbeBAUGE (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 15:06:04 -0500
Received: from mail-pl0-f54.google.com ([209.85.160.54]:33667 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754703AbeBAUGC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 15:06:02 -0500
Received: by mail-pl0-f54.google.com with SMTP id t4so4359935plo.0
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 12:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AlVILxK93pfiTEAL2G3/igqhecQRFwfvMbzwEw3ILy0=;
        b=g6/BfZ+PW1pPUe0l+uSKHbm2/qGBS9IdSyBUnK8lFSN5sQwE4PKSSkKHHZaWBqd0ba
         YpVpqlyeIlNG/YFK0skooOv2hmWDeWvSps4AOWYo20MFNwj+JoWZAnhI46QCa4qlxmPM
         PZFEEXlP1ByR9D1HcjmElxX757ihnRuGDRCqu4oaxoYmp0VJG7bK0PCZ/n9FMzrnaQ52
         h/PLJZGRz/TennoFtSO2iairdQ8W+AZBoemeCdL0+yWrHLxOMT1WUh9DkLe29YSN8zn4
         5x67hGntBbSOf5uSf2fQ+ed0qPIyFpYPLEui3fyWen42LsF2NuTxeEXygBSDpv/+cIpN
         CxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AlVILxK93pfiTEAL2G3/igqhecQRFwfvMbzwEw3ILy0=;
        b=UEv4zrUZUtWRm6LENqvqYBNGD3qlZfOcQHJD+urA+8UhautY1Vy74kvYxqvY7eMYTo
         ujTeMwhIfOvHCdiWzfTE0pAf4DulEFXUrvkgRIXLA/nCYm3RngEUHoWSq4Q8f2GRX98q
         xLvjOv0Ty52FGnWM5q0yYyj/VNg9u5H0QnW1qy9Nl6BZasCNJV/HtKrTuTHB+8mKOpzl
         W07m2f3SnG1nTPcuoeHd8WAXP4UqJxLQYbyS8862R6sjGEki7LZt85HjH22FuGBRGgBW
         rx0/UzIRmOcpFJtGJnGagDz/p1KlpJFHkQT5vlDJXqo7G8Y6VEgtc7mBtLGXFU9EIwIm
         h+Rw==
X-Gm-Message-State: AKwxytfsidWa1ksVfAubK2XJXuQ05/1bIVZDdyXWXR2S2Srqz6CchqUF
        4PXnR770LSuk/HQo9JqgN61++A==
X-Google-Smtp-Source: AH8x227RIrxfzfzkEgHsQfmrFrBl5TSJ8FINC0Q0NG26Fu7NuL87pMBjpucXkIz8Ac1wmPYh/iRkIw==
X-Received: by 2002:a17:902:8c8b:: with SMTP id t11-v6mr32422928plo.286.1517515561863;
        Thu, 01 Feb 2018 12:06:01 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id o9sm411326pfk.80.2018.02.01.12.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Feb 2018 12:06:01 -0800 (PST)
Date:   Thu, 1 Feb 2018 12:05:59 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 11/26] serve: introduce git-serve
Message-ID: <20180201200559.GB138727@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180103001828.205012-12-bmwill@google.com>
 <d9a15c0a-35f3-8e9c-ddf2-34420ac7555b@jeffhostetler.com>
 <CAGZ79kZpD6m=5YP0dNuM70Yce=PyxLO6qr6aVpHKa_S9iyACww@mail.gmail.com>
 <af1e00f7-b91d-4c1e-bc0e-164371feeadc@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af1e00f7-b91d-4c1e-bc0e-164371feeadc@jeffhostetler.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/01, Jeff Hostetler wrote:
> 
> 
> On 2/1/2018 1:57 PM, Stefan Beller wrote:
> > On Thu, Feb 1, 2018 at 10:48 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
> > > 
> > > 
> > > On 1/2/2018 7:18 PM, Brandon Williams wrote:
> > > > 
> > > > Introduce git-serve, the base server for protocol version 2.
> [...]
> > > > + Special Packets
> > > > +-----------------
> > > > +
> > > > +In protocol v2 these special packets will have the following semantics:
> > > > +
> > > > +  * '0000' Flush Packet (flush-pkt) - indicates the end of a message
> > > > +  * '0001' Delimiter Packet (delim-pkt) - separates sections of a message
> > > 
> > > 
> > > Previously, a 0001 pkt-line meant that there was 1 byte of data
> > > following, right?
> > 
> > No, the length was including the length field, so 0005 would indicate that
> > there is one byte following, (+4 bytes of "0005" included)
> 
> d'oh.  right.  thanks!
> 
> > > Should we also consider increasing the pkt-line limit to 5 hex-digits
> > > while we're at it ?   That would let us have 1MB buffers if that would
> > > help with large packfiles.
> > 
> > AFAICT there is a static allocation of one pkt-line (of maximum size),
> > such that the code can read in a full packet and then process it.
> > If we'd increase the packet size we'd need the static buffer to be 1MB,
> > which sounds good for my developer machine. But I suspect it may be
> > too much for people using git on embedded devices?
> 
> I got burned by that static buffer once upon a time when I wanted
> to have 2 streams going at the same time.  Hopefully, we can move
> that into the new reader structure at some point (if it isn't already).

Yeah the reader struct could easily be extended to take in the
buffer to read the data into.  Because I'm not trying to do any of that
atm I decided to have it default to using the static buffer, but it
would be as simple as changing the reader->buffer variable to use a
different buffer.

> 
> > 
> > pack files larger than 64k are put into multiple pkt-lines, which is
> > not a big deal, as the overhead of 4bytes per 64k is negligible.
> > (also there is progress information in the side channel, which
> > would come in as a special packet in between real packets,
> > such that every 64k transmitted you can update your progress
> > meter; Not sure I feel strongly on fewer progress updates)
> > 
> > >   Granted, we're throttled by the network,
> > > so it might not matter.  Would it be interesting to have a 5 digit
> > > prefix with parts of the high bits of first digit being flags ?
> > > Or is this too radical of a change?
> > 
> > What would the flags be for?
> > 
> > As an alternative we could put the channel number in one byte,
> > such that we can have a side channel not just while streaming the
> > pack but all the time. (Again, not sure if that buys a lot for us)
> > 
> 
> Delimiters like the 0001 and the side channel are a couple of
> ideas, but I was just thinking out loud.  And right, I'm not sure
> it gets us much right now.
> 
> Jeff

-- 
Brandon Williams
