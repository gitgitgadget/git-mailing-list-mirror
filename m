Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2000020248
	for <e@80x24.org>; Wed, 17 Apr 2019 18:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbfDQSWI (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 14:22:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36726 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730799AbfDQSWI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 14:22:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id z5so12482132pfn.3
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 11:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tgzHhR9MB3P4LUULYo7Rlcu+23wQq6gNRhqiCQ6xbbE=;
        b=hSUrN8gZogXFG+yJpF7rL4XN7eNv3y/48OVpRcw0zIqDXa2x3CMfvmmD8WEV6Z9bnO
         l/EKkkE3OBK/1/L1EirXUiuLMtTqrMnrD/HR/IxyVYhZPluKh7KWndM7vne9zd5cZYy/
         acgiAOQoSipcsNJAllkOeKjYzDvT0DXv1S2H6VoRLeuKv/acrryCyk+HvkKRT9rL4P6X
         9W7FDaGdXKfWsi6xdC+A5pG1DzZlzzjSW+SmZVpIYq6+pQPObfGrdhV6SyIoetRS4YTb
         O7Ih8lNmdhyiixDndteov7Yr2MmoAnmxi4vFwuj5iWfZ48Oi4svgZGuIBBeXG3Euchcd
         HRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=tgzHhR9MB3P4LUULYo7Rlcu+23wQq6gNRhqiCQ6xbbE=;
        b=XO8oEEhKsYvAHsKa0Z9EtaA/O6gx7GkBje7W7MyayR5+MDh+L34p525l1UHlKmMfyO
         LoODshXpszrCPg2L+iNBzD1lu9/j2SLn/M0F9lSMFErNXGXCiNRF+RCA7tRT03Yo/igm
         V+y/m9qUWbYqpOZ40kEP61s9ytUsy7p1uLTwBC1LhChQTXQUG7iZx12qctORg+wVsZlo
         15RDliikKIu/wA3aujdyNP215tKUOxuvQ8rkEBa2kaeiZdpQHmvrcbxbS5zEkMLteiOU
         hFCWgZuJ4yKvBEGGMNK2owmV75v3LP4b0E2t2w3l4gbfN9xhz1tXSrMwD+lIu/ZXgsgU
         35bg==
X-Gm-Message-State: APjAAAWbSYGuqJPZpAT3AhBX1d0xW48vmsmsCzr7EK+8W1swDfQnaH6t
        +K6/+YDT3moOI8RtSgqhGX3i/w==
X-Google-Smtp-Source: APXvYqwDx3pONdRfxfQCZnq4Ijgz8PnLh1DX8QPp8lbSVZs6MBseu63s81/ulQr5iw8ZG9ohFxxkAg==
X-Received: by 2002:aa7:943b:: with SMTP id y27mr66831985pfo.59.1555525327110;
        Wed, 17 Apr 2019 11:22:07 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id n1sm61719517pgv.19.2019.04.17.11.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 11:22:06 -0700 (PDT)
Date:   Wed, 17 Apr 2019 11:22:00 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 7/7] Turn `git serve` into a test helper
Message-ID: <20190417182200.GQ60888@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <pull.168.git.gitgitgadget@gmail.com>
 <411587e4b80bd4e5a1cb9b1ec438cda7a0681465.1555070430.git.gitgitgadget@gmail.com>
 <xmqqa7grqsbt.fsf@gitster-ct.c.googlers.com>
 <20190417034621.GA19448@sigill.intra.peff.net>
 <xmqq36mhkx3z.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq36mhkx3z.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.04.17 14:40, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> >> I do not personally think, as the design of v2 stands, a standalone
> >> "serve" server that "can serve anything as long as it goes over
> >> protocol v2" makes much sense, but perhaps those who have been doing
> >> the v2 work may have different ideas, in which case let's hear what
> >> their plans are.
> >
> > I too would like to hear more definite comments from people who think
> > git-serve is worth keeping. In the meantime, there's some discussion
> > from this thread in December:
> > ...
> >   https://public-inbox.org/git/20181213195305.249059-1-jonathantanmy@google.com/
> >
> > (In case you do not feel like reading the whole thing, my opinion there
> > is that git-serve is probably not the right direction, and we would do
> > well to demote it as Dscho's patch does).
> 
> I guess we are more or less on the same page, then.  I'll let others
> chime in by waiting for a bit more but I won't wait forever ;-).
> 
> Thanks.

FWIW I used git-serve a fair amount while working on V2 support for
archiving, and everything I did with it would have been just as easy
with a test helper as with a builtin. So I have no objections to this
change.
