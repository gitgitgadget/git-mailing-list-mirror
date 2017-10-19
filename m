Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8FEB202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 18:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753214AbdJSSHD (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 14:07:03 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:57136 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbdJSSHC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 14:07:02 -0400
Received: by mail-wr0-f195.google.com with SMTP id r79so9202025wrb.13
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 11:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S6vYLR/CoIuD1dbk0T0wAKt+WuKHrvFv9llwKZ54xYU=;
        b=asOw9kfh2lg1V7B6Ipwc1W8r6n9RR0RAL40vkc3d30A5bnBkBea04nnw8j/hkXbjMv
         Amg7lAYRPotEP5kTPo288tKOepgujMhyk89W2pSu2DxRevEbRVAJARrkRFDsFMwZkB8T
         MvaeDS+i/MT/TJdZg362D3j/qeKatkwkLuYE78k97kCfTbtScqRBkNa8Rxv7rmtenf0h
         /v1qvlXKjJZWuw6grXVbDcZEVIHN/GLs5Ongk2jX7LQeLSlIgHOoKAs+5HwvHdVyRBN3
         W7Hvd57FE6D/oiPsZFW82ysLXglDToewEJYN5KKw8Gc1u4KUCA2vkM1Z0NqJHGdkMDze
         +n+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S6vYLR/CoIuD1dbk0T0wAKt+WuKHrvFv9llwKZ54xYU=;
        b=CMVSiLe+W1yw2BnevzSFp49HkyLGxjyjJISWN8K98G0lGbTNSvJISJprh+RbNIBr6S
         iNIgbLqG5d72lBx/wVOnQXn8AdXS8Up7eQCsnZ6G6/ne91taQJTw4MgxGsNc3SVJ1TWk
         o3GgsGdnNjB+NtQjj0Jsif2TpT3h7k4Z3pkcuEgE4Zx5QsyhVcXxj40zl5pz9EsGv2fY
         kOj+2fxO2QX/An+y5uwetkN3zqRHSqtKDIC0IVMyQT6l6G5NTUtLbClpnm9T2z7MgnfF
         iOHR2WPeQRT4+aEvNk13paaV2sdECXbPLs2pRs3JdrSzeDO8j1GSr8htmkll9pvzld+S
         N3VA==
X-Gm-Message-State: AMCzsaUscGZwLtq+TYDgb3pTujPPcp9fJmxFrlWI1eaBZ/PFgjFGYa9+
        WO9EAeonK8iDyc0NfRB9oD8=
X-Google-Smtp-Source: ABhQp+RJJSDlmQCwYXtnaVM5bOUJB7Q1qA8N0Kn9NcgcVEOrnT8k/ZVZXIlfCtvPJeqmeckZrWKc8w==
X-Received: by 10.223.192.66 with SMTP id c2mr2338293wrf.95.1508436421120;
        Thu, 19 Oct 2017 11:07:01 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id q3sm12673680wrd.78.2017.10.19.11.07.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Oct 2017 11:07:00 -0700 (PDT)
Date:   Thu, 19 Oct 2017 19:08:01 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/1] mention git stash push first in the man page
Message-ID: <20171019180801.GI15399@hank>
References: <20171005200049.GF30301@hank>
 <20171005201029.4173-1-t.gummerer@gmail.com>
 <20171017041405.eavuutzgzgs4ppk2@sigill.intra.peff.net>
 <20171017214515.GG15399@hank>
 <20171017214708.ixc2hnut2virarzh@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171017214708.ixc2hnut2virarzh@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/17, Jeff King wrote:
> On Tue, Oct 17, 2017 at 10:45:15PM +0100, Thomas Gummerer wrote:
> 
> > > Seems reasonable, though if we are deprecating "save" should we demote
> > > it from being in the synopsis entirely?
> > 
> > I saw that as a next step, with the "official" deprecation of "save".
> > I thought we might want to advertise "push" a bit more before actually
> > officially deprecating "save" and sending the deprecation notice out
> > in the release notes.
> 
> Right, my thinking was that it would still be documented in the manpage,
> just lower down. And that would probably say something like "save is a
> historical synonym for push, except that it differs in these ways...".
> 
> > OTOH, dropping it from the synopsis in the man page probably wouldn't
> > cause much issue, as "push" directly replaces it, and is easily
> > visible.  Not sure how slow we want to take the deprecation?
> 
> I don't think there's any reason to go slow in marking something as
> deprecated. It's the part where we follow up and remove or change the
> feature that must take a while.

Makes sense, let me drop it from the synopsis then.

Thanks!

> -Peff
