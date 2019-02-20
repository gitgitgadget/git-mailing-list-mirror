Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_RP_RNBL,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F382A1F463
	for <e@80x24.org>; Wed, 20 Feb 2019 00:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfBTAc5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 19:32:57 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42847 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfBTAc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 19:32:56 -0500
Received: by mail-pl1-f193.google.com with SMTP id s1so11246305plp.9
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 16:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pM2jE16X9KHAenVhmh+l7PkYtiZG76QkZpFkC0GYOIw=;
        b=Epq3H3COAO9x/whb92TiY46cFwuANJ5We887cLimRH0qPIis0t4Rdw2DwyMofo4DhK
         oHsziPSCmbNyWefyx10ybHQXomAxzj60NMrg7zhLavTxkcHKOrm3pi/6ND1fkt/3l1YO
         s5aogxACOlbNWhu3jdalA5BpaiovpBAJI54jY1hDUTCglI56R6vPW9Gn5/eg1KrHe09d
         AfPWkQtz/kEoU3WFdVvqUciAoJeicqsnxaLLs1wwWwaFrZgtAAjDbVZ73t4nBwNZtPbj
         isJYod17QutCpGdIB7i5aib9sWVk7FVgq0NKZxpPzJgmfhlBcQvc6ppbnJF4TtbPmbds
         cAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=pM2jE16X9KHAenVhmh+l7PkYtiZG76QkZpFkC0GYOIw=;
        b=cTAEtvDsxbgQErhdj1KQsS7AQCuxLGzZm5zd9QhxN0+/rRhGwGKqjDMoD6JEnvTrnK
         qo4O21J5QExeINv7v2ssfwL6qM9hI0URHYTStd+RCBl5t+DNVHYxIr1JnyeyGytZJjqT
         Etc1B8w4PszEdc/vJhchCc+IXeBzIF1ZSZGF68Ucoo7XFJBvIXOSw3LQyFSEa20b/0+f
         9Kj34/vYuLM/c0AXf6dihkDokWyLS+AAqHU1yS6Sj8jmyDnqafqRNjVKNgmjU3dWNezI
         +SgdS46+zA27e0fs8+KgWUQ7p5Er9Rgy2tLeGV7gji8Ff1AinU08JzaA48IBAQThavjx
         uL6A==
X-Gm-Message-State: AHQUAuY0upp6ka0dfATVUGIearp7UeOMPxFt3jW8Z6YtDYGhkL68kC08
        er8TPhxgydGNBRNyh2bTL5dJ9w==
X-Google-Smtp-Source: AHgI3IZkcAge8A75zo+d9kqIWLeELHpfZxT/Wzv/9uCRadG7VvGFfW9RlzkrGriKAbDgX35hV0p5Sg==
X-Received: by 2002:a17:902:7896:: with SMTP id q22mr34263305pll.280.1550622775755;
        Tue, 19 Feb 2019 16:32:55 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id e16sm21868862pfn.46.2019.02.19.16.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 16:32:54 -0800 (PST)
Date:   Tue, 19 Feb 2019 16:32:48 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v2] protocol-capabilities.txt: document symref
Message-ID: <20190220003248.GA160251@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org, jrnieder@gmail.com
References: <4ffb11ff776166944673ba3bdb96a9d20eb14df7.1549929088.git.steadmon@google.com>
 <cb1b2834b7365f6277d1ec573cee7fd68a7329d0.1550100949.git.steadmon@google.com>
 <20190214035602.GA7209@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214035602.GA7209@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.02.13 22:56, Jeff King wrote:
> On Wed, Feb 13, 2019 at 03:41:28PM -0800, Josh Steadmon wrote:
> 
> > ---
> > Range-diff against v1:
> > 1:  4ffb11ff77 ! 1:  cb1b2834b7 protocol-capabilities.txt: document symref
> >     @@ -12,6 +12,17 @@
> >       diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
> >       --- a/Documentation/technical/protocol-capabilities.txt
> >       +++ b/Documentation/technical/protocol-capabilities.txt
> >     +@@
> >     + Git Protocol Capabilities
> >     + =========================
> >     + 
> >     ++NOTE: this document describes capabilities for versions 0 and 1 of the pack
> >     ++protocol. For version 2, please refer to the link:protocol-v2.html[protocol-v2]
> >     ++doc.
> >     ++
> >     + Servers SHOULD support all capabilities defined in this document.
> >     + 
> >     + On the very first line of the initial server response of either
> 
> I think this makes sense. I wondered to what degree the v2 protocol doc
> may say "...and you can use capabilities from protocol-capabilities.txt
> here". But it doesn't. It newly lists the capabilities, which makes this
> paragraph the right thing to say.
> 
> It does mean that if we teach v1 a new capability, we'll have to
> document it in both places. But moving forward, we'd hopefully not be
> doing that too often (I haven't seen talk of flipping the v2 switch yet
> by default, but obviously that's where we want to end up).
> 
> I probably would have put this in its own patch, but barring that we
> should probably at least mention in the commit message what this
> paragraph is doing here.
> 
> -Peff

Done in V3. Thanks!
