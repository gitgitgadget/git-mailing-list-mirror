Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62CD6208DE
	for <e@80x24.org>; Fri, 25 Aug 2017 17:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757382AbdHYRf4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 13:35:56 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33427 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755568AbdHYRfz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 13:35:55 -0400
Received: by mail-pg0-f67.google.com with SMTP id q16so641626pgc.0
        for <git@vger.kernel.org>; Fri, 25 Aug 2017 10:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ih1bU58GLGr2t+6zDW6gTc+HzfWayr/92pCA4zE8UNA=;
        b=pVhMul7/biYlE+N/ikc+DZuQx3Lh8kA817yXCwpa5AWVFTpzl+p3sVF+ewhnhvD1jf
         /fmPl1QZADIpOEX+xinI1PmMgIBFuy028NqFPmlSa3+aaSMICk808K/Nxt1mwBn+ck1s
         mGC4t+/aHFJYXyT355+eyqTaldmfRxas+V48TWNqROo1hcntfZnxn2R0bawa0+goUh4Y
         CSKxjZ3fEQaZnqdisW1YCRcMex5i92GNA2oQV7I0ZW7ghfkrkalOqIj4Y71CbvG+j4Zk
         z2ojBwVOrJEzWZJLumvT7NnOzYpkFJ/4U9MHtYuL1Bt9gLCIeJ4UNgx6qAlpGkNfRKgH
         VTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ih1bU58GLGr2t+6zDW6gTc+HzfWayr/92pCA4zE8UNA=;
        b=uj5v8Ib7Lv0sC3Zjd87g7McWhFdH24eVIV2YynxjocrEQC9aPlDJ+6tPX+64oAZWyi
         n013O8GI9iT2ft5Doa40NbXB3O+C6RXRClWVuo5Hd/A97B7TmL2wNqmuNHkzE5XSm/sO
         r3elcY6GK24znzRuPQiqkSpIcihJxZL69PMyvI7MA8iZ7Bx8plONvn2NyxnZybHmoXQY
         QXjgY3DjziVg2zTaBHM63TaAST4aX+eHUkrK9jWtxRZMnVFmQGDw5Hpfay+9KhgX32Sb
         gsQidEB8a+gqQR0QyIWERP7ZJ2sWZBASyh9RtncI+/2JtElpbjSBtMIaoQXyHNApvj20
         2Zng==
X-Gm-Message-State: AHYfb5j4r2rcZg5NyRYYaoILnBs6TLpRwmNb0UM2EdiM8/IQUbqtoOaa
        AbOLKQ6uw5dpLA==
X-Received: by 10.84.217.217 with SMTP id d25mr11664085plj.245.1503682554185;
        Fri, 25 Aug 2017 10:35:54 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:b90d:e357:f4fe:7194])
        by smtp.gmail.com with ESMTPSA id p80sm13485631pfa.19.2017.08.25.10.35.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 25 Aug 2017 10:35:53 -0700 (PDT)
Date:   Fri, 25 Aug 2017 10:35:50 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [RFC 0/7] transitioning to protocol v2
Message-ID: <20170825173550.GJ13924@aiede.mtv.corp.google.com>
References: <20170824225328.8174-1-bmwill@google.com>
 <20170825172901.kvquxafudhelxqq3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170825172901.kvquxafudhelxqq3@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Thu, Aug 24, 2017 at 03:53:21PM -0700, Brandon Williams wrote:

>> Another version of Git's wire protocol is a topic that has been discussed and
>> attempted by many in the community over the years.  The biggest challenge, as
>> far as I understand, has been coming up with a transition plan to using the new
>> server without breaking existing clients and servers.  As such this RFC is
>> really only concerned with solidifying a transition plan.  Once it has been
>> decided how we can transition to a new protocol we can get into decided what
>> this new protocol would look like (though it would obviously eliminate the ref
>> advertisement ;).
>
> Sadly, while splitting these things apart makes the protocol
> conceptually cleaner, I'm not sure if we can consider them separately
> and avoid adding an extra round-trip to the protocol.

How about the idea of using this mechanism to implement a protocol
"v1"?

The reply would be the same as today, except that it has a "protocol
v1" pkt-line at the beginning.  So this doesn't change the number of
round-trips --- it just validates the protocol migration approach.

I agree with you that an actual protocol v2 needs to change how the
capability exchange etc work.  bmwill@ has mentioned some thoughts about
this privately.  Probably he can say more here too.

[...]
> Given the techniques you've used here, I suspect the answer may be
> "yes". We could stick arbitrary data in each of those methods (though I
> suspect our length may be limited to about 1024 bytes if we want
> compatibility with very old git servers).

Yes, including arbitrary data to be able to include some kinds of
requests inline in the initial request is one of the design goals.

>> The biggest question I'm trying to answer is if these are reasonable ways with
>> which to communicate a request to a server to use a newer protocol, without
>> breaking current servers/clients.  As far as I've tested, with patches 1-5
>> applied I can still communicate with current servers without causing any
>> problems.
>
> Current git.git servers, I assume?. How much do we want to care about
> alternate implementations? I would not be surprised if other git://
> implementations are more picky about cruft after the virtual-host field
> (though I double-checked GitHub's implementation at least, and it is
> fine).

FWIW JGit copes fine with this.

> I don't think libgit2 implements the server side. That leaves probably
> JGit, Microsoft's VSTS (which I think is custom), and whatever Atlassian
> and GitLab use.

I'd be happy if someone tests the patches against those. :)

> There's not really a spec here.

Technically pack-protocol is a spec, just not a very clear one.

It does say this kind of client request is invalid.  The idea of this
series is to change the spec. :)

[...]
> I dunno. Maybe it would be enough to have a config to switch off this
> feature, which would give people using those systems an escape hatch
> (until they upgrade).

I'd rather not.  That means there's less motivation for people to
report compatibility problems so we can fix them.

It might be necessary as a temporary escape hatch, though.

>                        Or alternatively, I guess make this optional to
> start with, and let early adopters turn it on and complain to their server
> vendors for a while before flipping the default to on.

Can we do that by making it a patch / letting it cook for a while in
'next'? :)

Thanks,
Jonathan
