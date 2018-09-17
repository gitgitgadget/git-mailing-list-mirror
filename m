Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC3091F404
	for <e@80x24.org>; Mon, 17 Sep 2018 18:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeIQXzP (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 19:55:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44188 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeIQXzO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 19:55:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id ba4-v6so7812551plb.11
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 11:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0G4nl9Yy1hPN8X1qZV0biMBpuS0QcbxlPjzWgCpvAz8=;
        b=Z4oidUutMHefjAN2hH4VkwCAvh27zkIex8Z2PVDOFRHCPWuM3PjpfxG1lXgc5Mn8+v
         ZDvMzIFvVBz/ASAMXs+t1b1d0HpCWoMp/suQZwlL22MsQNJuHUtgiHVpd6/vMl3A3O6a
         UbZ5/+pxncjim/4KpL0ZSjQtgL3VhJsPTeOHd41n5Bx+vruww28hrtwmLKC+ymBCCaLk
         cun+ufe8idSWUg3ZsbBZEfJ0K9VbR1iiv5roDRNXnf7w9tf9y8PSinEVBMJjdWDNSc79
         3VZTKwEOYSJffW92DMM9pCW/b072AtEuV7dyP8iAKeTK3io9DMyuqat3HLP99xXIJlfn
         cE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0G4nl9Yy1hPN8X1qZV0biMBpuS0QcbxlPjzWgCpvAz8=;
        b=KzVkCN6D+6XdZFTwAlg0dhmibINbrsDf1BaLjVQb5+XmcMIIHydk/rHXfrBZkoq2Jg
         LBk74wANot5DlKEK8hrEB8qOZY5AiOnMs6X0DvfMgmp9zh2pB4R5JapH4Yv/xVcqes8D
         SELsLjdaYroUCqpEbBDxXOiColwy6TEr0yL6RWf/mrdT4sbjj4KhJiFJ2TqcrEXRM2j9
         VOZIrhMycOwpkd0E+SW5c6pox0ZUUH3N7dDwjqKasuELjiC5Yt6Z28qqgctol0oA+sWv
         vyyfr2szJRuSGpiwv/zHng5ciUaLHM9ssy/GMr6rR2BvXDjhhs9XrI3BgVuGMrHyXUP1
         Uoxg==
X-Gm-Message-State: APzg51BZY0GSM4KpeNHEXbOw4L8GZgmmSCMkr1O7W+aZfimTKqJd2IcT
        OIq6fDHOc7MMCNUEB1INt8o=
X-Google-Smtp-Source: ANB0VdbAWxzRuI3o9rYwh67Hej9oql1jBxCIR5sRYPdAI4TL6X45M4P52Cdh6Js/gFjXj/h6AhU2iA==
X-Received: by 2002:a17:902:be07:: with SMTP id r7-v6mr25564088pls.275.1537208802439;
        Mon, 17 Sep 2018 11:26:42 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id x2-v6sm23737784pfi.166.2018.09.17.11.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 11:26:41 -0700 (PDT)
Date:   Mon, 17 Sep 2018 11:26:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2018, #03; Fri, 14)
Message-ID: <20180917182639.GB140909@aiede.svl.corp.google.com>
References: <xmqqy3c3agkr.fsf@gitster-ct.c.googlers.com>
 <CACsJy8DXT8rF_WYE3C0ak7E8_8j=kRS+Yhi1pZjKd5Rr4OsM_A@mail.gmail.com>
 <20180917023912.GC22024@sigill.intra.peff.net>
 <xmqqo9cw6mhk.fsf@gitster-ct.c.googlers.com>
 <20180917182210.GB3894@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917182210.GB3894@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Let me inject some more uncertainty, then. ;)
>
> If we are not going to do 3/3, then should 2/3 simply avoid passing "-1"
> back via return from main? I guess I don't have a strong opinion, but
> one of the things I noted was that we converted those die() calls
> introduced in 2/3 back into returns in 3/3. Do we want to leave it in
> the state where we are calling die() a lot more?

Would you mind replying in the patch thread instead of this what's
cooking email?

That way, I can understand your suggestion better in context, I can
find it more easily later, I would feel less bad about adding noise by
replying, etc.

Thanks,
Jonathan
