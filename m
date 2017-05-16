Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6E611FAA8
	for <e@80x24.org>; Tue, 16 May 2017 20:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750876AbdEPUrn (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 16:47:43 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:36240 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbdEPUrm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 16:47:42 -0400
Received: by mail-io0-f174.google.com with SMTP id o12so101772786iod.3
        for <git@vger.kernel.org>; Tue, 16 May 2017 13:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=UQj/n+tNBa8SQSe5BNt3ayDmgADR/586liDjIGdxNOQ=;
        b=Rt4CtFaLPUUpgE64ymaydGDdH9izlIZS+FZB9+yVO52HMJq/tReT+H29ADHgDvI2wV
         SQLuDR7bd1uEWr5ee5dbMhZ8a2eGz1343M3Z6D0jjQvPIPJQhfoREWqQj61sGj/Baf+m
         vYNJYW7BHrkO6E3WU6bJ+h2CHMZbIX9pDldnWung2U9KUGOin+h1qhdl0pS1AQL4gSQs
         c9j2l3/6TkwQ0es6pThfdXEekqVljuMSqF7lzABOn8nP5E1Zhurer/U1GRA7vIMrQZRt
         IgCIVwrMYBhJoWGATdXe4GNCah40pcYl8IlKE66wiQ0amepGLpkDHvvzYRJAtHnByXI3
         oG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=UQj/n+tNBa8SQSe5BNt3ayDmgADR/586liDjIGdxNOQ=;
        b=SHTlCdlYU9M/JWkaMePs2aj3EqFyYsmrkdLatnLWx3S6BnpfvmnlhFwVdYH6/e5GIe
         iiKe/hBvhlSU9K9yMc2vUDMjggtyxB+iLz2XR3+WJjLHaJz3qLRFhRD3QHQzSSjA7Xbz
         YjceP+WPVT5rHwD1kmbQRtW/JLIm4Tg0dglRZVRORz6TCFBh5wtdVCM2sOQDnZLAwdfx
         mRCHZaITVKudIUyi+BW/oSScrNYoeg6vEa02ar2BO8aNlOFhYf9GXPv+lze/pn3+03ex
         /sESXjHNVdNNxOXySBulObdUA48I7hmJnSRlDZ7qCmkZPQISGCwu6dKUxS3OWgAOYPfV
         P8SA==
X-Gm-Message-State: AODbwcCCEdWy1Ts4g//kuFLgXvocAYCwxhGUOjBhBOuPtURCtEmqY0nT
        IBt6EJGayZgKZC8nI5WJ+h+CVpSkqiVY
X-Received: by 10.107.6.94 with SMTP id 91mr12900519iog.78.1494967661627; Tue,
 16 May 2017 13:47:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.204.3 with HTTP; Tue, 16 May 2017 13:47:41 -0700 (PDT)
In-Reply-To: <20170516193557.GA14257@dcvr>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
 <20170516032503.bzkxmtqpmppxgi75@sigill.intra.peff.net> <20170516033736.23cfkouus3p67vhc@sigill.intra.peff.net>
 <20170516164124.GO27400@aiede.svl.corp.google.com> <20170516164750.3tw6xlbcbyuu5t72@sigill.intra.peff.net>
 <20170516171540.GG79147@google.com> <20170516172307.36hyshwypomlsubx@sigill.intra.peff.net>
 <CA+55aFwB-MWASj7dZWkXWhgd4gvEfoOhL6Fo7kXeJSm9dht4Jg@mail.gmail.com> <20170516193557.GA14257@dcvr>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 May 2017 13:47:41 -0700
X-Google-Sender-Auth: Kw6gmiqyubmR1Wg0rl1GchTXDIw
Message-ID: <CA+55aFygKMJH3BRitQftmtCTx6es93CTR4_y1ULGGE2rSsMyog@mail.gmail.com>
Subject: Re: [TANGENT] run-command: use vfork instead of fork
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Rannaud <eric.rannaud@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeremy Serror <jeremy.serror@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 12:35 PM, Eric Wong <e@80x24.org> wrote:
>
> Fwiw, most of the vfork preparation was already done by Brandon
> and myself a few weeks ago, and cooking in pu.

Oh, interesting. Was that done for vfork(), or is it for something
else? Some of the changes seem almost overly careful. Is this for
prep-work porting to some odd environment that doesn't really have a
MMU at all? There's nothing fundamentally wrong with allocating memory
after fork().

But yes, it looks like it helps the vfork case.

               Linus
