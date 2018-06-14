Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D4691F403
	for <e@80x24.org>; Thu, 14 Jun 2018 18:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754862AbeFNSza (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 14:55:30 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34514 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754799AbeFNSz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 14:55:29 -0400
Received: by mail-pf0-f195.google.com with SMTP id a63-v6so3681805pfl.1
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 11:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JmqRqwB7saTS1SSN3nxs0fsMay5uV54ivxDMu8Ojeis=;
        b=dW8+ScKnBLW11zqvuhenwLSYMi/aLKjCYlS2wXQe7GUk9hPcRl8u6MPQ8N3pFVAaX+
         BXOMJlX+YOFYpLXge+erl8hyTuP0PkJrsjARSq+IBFh993Y3aO0NrGduXBPAMdnlXaGj
         hL6YwnuJtnmI9WLIatT4VzIpBY7y4RE74PYWv/xVQRNMJ02K75HRRLO/roSOk/dMgF4Q
         C/b3Rign57GKPbOj0geeXpZ1OD1rNgwqBH01Ous2e+qwKkverVc6xWc5yK/hwrCcxaeP
         mNDtV6P5U7xSPUvlNinJ/1u1KXSZa9clFvj8TEIk9KI80DFeBEeSebS2+zmQlVz+Zvh+
         TqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JmqRqwB7saTS1SSN3nxs0fsMay5uV54ivxDMu8Ojeis=;
        b=p+tYG94vOEdq7LIGbxSxcAlMg/bJ0H6EKV+5v7boJpEVTw5omQbu3zDBD9s7Efe6F7
         nKbqAMDrfEG7luQvwr/Mb90hqiuhMAIIg3Zh4b6xRSZZ51iZe2N4Bna+gPiyNosiOCka
         3Ks6X0NzXbr6fmAXXh/w5lDq4twIKWR0SuXKkIdy0OoO7FFWa6Loc6GbqTi1oD9OAMpn
         L5MOSEGH7QiBguLpv6rfchi401ET9c3eHkRWYX3hOwuYiksOwmfghDZQ1Oh8ZmTSXz7X
         sfC/Dh/7uPr0HWZ9GNZb6ayZT4yBdTZBk5tQYf9trHaKrxlk+/tnhqepvu595P7h+evf
         RQxg==
X-Gm-Message-State: APt69E34Kv+bU/7Py8icYm2SFxcR34hPledCzNZTT7ipUELr6DczU3yd
        vkbKEtD5Vnolm6e23WTRgJs=
X-Google-Smtp-Source: ADUXVKLqj7Bjdso5FHOobvEg+j9GOxG50YjK0hhl8FciIt3I6ZsqnKFv+1KfNq/ada0qWgBuzxbEVg==
X-Received: by 2002:aa7:810c:: with SMTP id b12-v6mr10535937pfi.79.1529002528977;
        Thu, 14 Jun 2018 11:55:28 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h84-v6sm9410230pfd.69.2018.06.14.11.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 11:55:28 -0700 (PDT)
Date:   Thu, 14 Jun 2018 11:55:22 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bryan Turner <bturner@atlassian.com>,
        Brandon Williams <bmwill@google.com>,
        Ben Humphreys <behumphreys@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.16.0-rc0
Message-ID: <20180614185522.GA255581@aiede.svl.corp.google.com>
References: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
 <CAGyf7-FQp4q2vvH1ponQvmVDTu0hiMSK1JKytQZ4O1i0MCnz7g@mail.gmail.com>
 <20180103053516.GB87855@aiede.mtv.corp.google.com>
 <20180608045028.GA17528@sigill.intra.peff.net>
 <xmqqzi009deu.fsf@gitster-ct.c.googlers.com>
 <20180614183018.GA1911@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614183018.GA1911@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sorry for the slow replies.  I was out of office earlier and am back
now.

Jeff King wrote:
> On Tue, Jun 12, 2018 at 09:29:13AM -0700, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:

>>> To be honest, I could easily see an argument that I _should_ be setting
>>> GIT_SSH_VARIANT to explain what my wrapper is expecting, even though it
>>> happened to work before.

Yes, I encourage anyone setting GIT_SSH to also set GIT_SSH_VARIANT.
This way, there can be no confusion about what the setter intends.

The autodetection is in the category of "necessary evil" that wouldn't
exist if we were starting over.

[...]
> No, my wrapper _isn't_ simple. It passes most options to openssh, but
> just doesn't understand the "-G" probing.  So if the default was
> openssh-like instead of "simple", then that would work fine without me
> setting anything, just like it did before.
>
> Which I thought was where the discussion ended up, but perhaps I'm
> misunderstanding.

Do you mean that it doesn't pass "-G" through, or that when using old
versions of openssh that doesn't support "-G" the probing fails?

If the former, then detecting the wrapper as something other than
"ssh" is intended behavior (though we might want to change what that
something is, as discussed in the previous thread).  If the latter,
then this is https://crbug.com/git/7 which I consider to be a bug.

[...]
> So I'm OK if we just leave it as-is. It's mostly that I dug into the
> thread and was left with the impression that it was an unfinished
> leftover that we meant to do.
[...]
>> In any case, from where I sit, I am still waiting for this offer
>> by Jonathan
>>
>>> It's good you caught this flaw in the detection.  Would something like
>>> the following make sense?  If so, I can resend with a commit message
>>> and tests tomorrow or the day after.
>>
>> to be followed up ;-)
>
> Yes, that was the part that left the impression. :)

Thanks for the poke.

The patch [1] didn't leave me super happy, since it means there is yet
another ssh variant for people to understand, in order to accomodate
an old version of OpenSSH that is going to go away eventually.  In
Debian, modern versions of git declare an incompatibility with old
versions of OpenSSH in their package metadata to avoid this issue.

In my defense, I said "If so" and no one seemed too enthusiastic about
the patch making sense. ;-)

I'll take another look and probably resend.

Sincerely,
Jonathan

[1] https://public-inbox.org/git/20180103050730.GA87855@aiede.mtv.corp.google.com/
