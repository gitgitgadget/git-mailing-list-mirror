Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 290E61F404
	for <e@80x24.org>; Tue, 13 Mar 2018 19:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752725AbeCMTus (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 15:50:48 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:37678 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeCMTuq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 15:50:46 -0400
Received: by mail-pf0-f179.google.com with SMTP id h11so347436pfn.4
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 12:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CdeVTEpLvYpACA3SV69Pdi5Gkun9Z/mHS1MrSJ50Zl4=;
        b=Vf3CDvmAZkzyJSdO2F7XB1ptatfoBW5Qkgs8SJqVwzuCROBpWKNzOj+WmCuQzBR+f3
         B3WOuRACLnXNx6JppAGLC18wZlFgxA5fDs7l/wAok7us1aBEXgq9phX8cfbcYJRysnXo
         21IKFc8JeS9ctnFXKzjBRJhmugtdiYMLooaIj3slqmWtIQxYe0GHHB6UIWhrgmgX/dKQ
         sJ7apiB6nB23G2ujLRXayM0X0E331KHrMhVZf+9cK2LQfINpVN0UF9NrrvgQHluSGxDA
         wOm4y2S2MTOqWtoCUmX/WHJalIseWXINht7UDfB9TEIQPpi+9viu/YC60pgIoiuqpT89
         xXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CdeVTEpLvYpACA3SV69Pdi5Gkun9Z/mHS1MrSJ50Zl4=;
        b=YzWIOKn6BKBCi5zCUG5WKAWFu+BR9JfqPQdIopEoqJQr+Avc+d8YzucS1RpbCfSa4T
         SquQHOCj3qpAX8Djlw1RaNuY7t69OhZMTDGE/X2jYsMNgN+1k3rqWJt5Z10lQApSK2z3
         1z2SPI0EHianB3EJp4NLCoHCJTpZHJBeHpw8qi5KuNivKFF/oNS1vyRWsE28SCaO0b2v
         fFr+0FZ/JDWe5VJptCAW/Bp1WpnaBXjqaFfG3qJctXYvZrSUayaAT2vN8Nwv0463xi4/
         cl2JtpKmnhHhcONuEZwyB4X+12ETy2pgkoedRD8Wl0D8HrUtFq5Csrk0ZKZCJGuwOKfe
         MZEA==
X-Gm-Message-State: AElRT7FIkLA9Mbn1Q906+uW5suhdp/pbEDQuDxuRbFO5r272jE9jtIs5
        2JOrpECoHlXg617SpxyWWT6ZsTy81AY=
X-Google-Smtp-Source: AG47ELvamU3x7vWBWV38OuCzGS9BuhtlyFKXimdgMnoq3Nb02xT/yfZUsySusPG891a8Gx4unbf3zw==
X-Received: by 10.98.11.145 with SMTP id 17mr1729696pfl.150.1520970645997;
        Tue, 13 Mar 2018 12:50:45 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id g186sm1590252pfb.168.2018.03.13.12.50.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 12:50:45 -0700 (PDT)
Date:   Tue, 13 Mar 2018 12:50:44 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        jrnieder@gmail.com, pclouds@gmail.com, peff@peff.net,
        sbeller@google.com, stolee@gmail.com
Subject: Re: [PATCH v4 04/35] upload-pack: convert to a builtin
Message-ID: <20180313195044.GA7638@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180228232252.102167-1-bmwill@google.com>
 <20180228232252.102167-5-bmwill@google.com>
 <20180313094022.6cbe51d765e2eec61e0cd04c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313094022.6cbe51d765e2eec61e0cd04c@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/13, Jonathan Tan wrote:
> On Wed, 28 Feb 2018 15:22:21 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > In order to allow for code sharing with the server-side of fetch in
> > protocol-v2 convert upload-pack to be a builtin.
> > 
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> 
> I suggested updating the commit message in my previous review [1], but I
> understand that my comment might have been lost in the ensuing long
> discussion.
> 
> [1] https://public-inbox.org/git/20180221134422.2386e1aca39fe673235590e7@google.com/

Your suggested change to the commit msg isn't quite accurate as you can
already run "git-upload-pack --help" today.

-- 
Brandon Williams
