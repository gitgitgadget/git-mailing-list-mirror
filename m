Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 074C71F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 22:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933131AbeGIWss (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 18:48:48 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43775 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932620AbeGIWsq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 18:48:46 -0400
Received: by mail-pf0-f193.google.com with SMTP id y8-v6so14655877pfm.10
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 15:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CbC6HU4iRk8KfHCxEZI/EzzvmfCXDTMQSR9O5nsOg8k=;
        b=VP8GimjWWrmCVoa44eOJO77hL5XkiRSzSg/3CuNX1ywwbZGrIUMZnbkkBHY0iiopSk
         JcfiOivQzjqieQPLF3A3FILmkxlfQUan/EflELK/HuqnAV2cQQyE8YdGkmbr9a9PogHg
         OIR2HN49NjA99YdksKyY5QcK7RlR6Yfg9WXceeBDD3QLqNKDgBYUufix1mXuKO9QsHVG
         EymkKt8hNYyEJEOMV/H5utCpmqwSOR9laE3Hqucc9DESTV4zPZb0ZAO6LjXhiYBopI+h
         sPYwMzNYShg0SHeKSyBLPGnEAafN2bbqNLpXm4xY0S/gJiEG+I0nNSHvE2TXxS5qTIlv
         FegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CbC6HU4iRk8KfHCxEZI/EzzvmfCXDTMQSR9O5nsOg8k=;
        b=I4vYqcATWKaY9PXDL5Xcw5mM/Gc0+zFRF/xccUk6LzadDR5cIqmICIYxMyALt/f5oQ
         9wUIGfEre3nKdKEGeGPsMjh5cCt7GM1h/fOOGQwdVNoAxTvbMiOxiFKETsMMVBE11JQw
         uFTEC6LaeJWqHn2SfxekM/Vy9U3TH5t82qKLQqfxRqon9k8afYmiXERZF8d8c6KV4DvT
         KGHRcevkpqekYE5wr/7wON/sT3u7+cYPBfXR5FW+IU0FtvFhHOSA3BoBvYqkXMg7lLzh
         drcaE/IVQKMly7BwNX8wBERMKiLj/iJnU3srPCvPJMtP7p4AIbXYR+lhHxFVkAb0hMrJ
         wM4A==
X-Gm-Message-State: APt69E39VlFL++XswH/Pqkgw2zAK2oBLUfIlF0l+PcoICrcYxLsa5kwl
        pwqmAMu1LHr7fwjM+9BEk5t0zy41
X-Google-Smtp-Source: AAOMgpf3EVh7T0ZZnN7YOYjXTNuO7FFdRmscDddkFheRSBkYBWO9whWe2C+USzrbPdALzBePTBkUAg==
X-Received: by 2002:a65:5b8e:: with SMTP id i14-v6mr15953259pgr.242.1531176525970;
        Mon, 09 Jul 2018 15:48:45 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id r28-v6sm10281727pfd.37.2018.07.09.15.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 15:48:45 -0700 (PDT)
Date:   Mon, 9 Jul 2018 15:48:43 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>,
        Akilsrin <Akilsrin@apple.com>,
        Christian Couder <christian@gitlab.com>,
        Tim Triemstra <timt@apple.com>,
        Eliran Mesika <eliran@gitlab.com>, git@vger.kernel.org
Subject: Re: Subscribing Apple people to git-security@googlegroups.com
Message-ID: <20180709224843.GJ14196@aiede.svl.corp.google.com>
References: <CAGba+=U4nbxL2uuSxyqyZqiiavJpo_E=GhUkipz6DczLdmnkgQ@mail.gmail.com>
 <20180702195016.GA17102@sigill.intra.peff.net>
 <91A9F3A0-5F3F-4137-9A40-CB42EDE4F243@apple.com>
 <20180703133645.GA20316@sigill.intra.peff.net>
 <20180703154814.GA51821@aiede.svl.corp.google.com>
 <20180703160110.GA26771@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703160110.GA26771@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+git@vger
Jeff King wrote:
> On Tue, Jul 03, 2018 at 08:48:14AM -0700, Jonathan Nieder wrote:

>> Administrivia: do you mind if I bounce these messages to some archived
>> list, either git@vger.kernel.org or git-security?  Or if we'd prefer
>> to avoid the noise from that, do you mind if I work with Eric Wong to
>> get them injected in the https://public-inbox.org/ archive?
>
> I don't mind at all. I'm actually going to work later today on preparing
> other messages from the security list to go to the public-inbox.org
> archive, so that might pave the way.

Thanks, done.

This doesn't work as a trial run for
https://public-inbox.org/meta/20180703160910.GB51821@aiede.svl.corp.google.com,
since I just bounced the mails.  So it won't work for threads like the
326-message thread you mentioned, but it should work in more modest
cases.

It seems that vger only delivered some of the messages.  I suspect
it's related to DMARC.

Jonathan
