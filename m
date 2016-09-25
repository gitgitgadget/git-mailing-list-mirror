Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AF4120985
	for <e@80x24.org>; Sun, 25 Sep 2016 22:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938417AbcIYWit (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 18:38:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36380 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933709AbcIYWis (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 18:38:48 -0400
Received: by mail-wm0-f65.google.com with SMTP id b184so11490114wma.3
        for <git@vger.kernel.org>; Sun, 25 Sep 2016 15:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=EOqxtz0cfY9QNiMuH3YCVhEgiVv15seOiEfBBxcQlb0=;
        b=w5zhp19HdDVuSL9TMLrZsM6cvEUrsvNQblGa9udKCsjdxTGnLmJyg2n2O1bO0nlUvC
         aSOnUXkBY8zDPZniqxQ5XDSpef7fPdf6GMUJ9vyzxEJWtvp8oG0m5pcRern2VoydtZHX
         bAkYdTiF8FnQS4Oo6XwogWCdyWx7DX5Se973Nx2DyLLPJ8pkJpxtGOpz9Fp6EMivxM/P
         CpfyRbQ0E4hXN7URmWpF0sp4xLKGXAlR3k6ZKWkXYLoL8s6UHMEa3S0fEQeCl0C97jMZ
         EdnO1lrz9smHEqXuSiXR3cF9Jy10KwiVR/tXrhCQYIPFnjZl96uX1Y7ko2BbrSHOCn4p
         9SvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=EOqxtz0cfY9QNiMuH3YCVhEgiVv15seOiEfBBxcQlb0=;
        b=hEMFG266xZv64UiUOO8nV0SiE2YA4o8Q1DJI9IZDUQg4auG1nVYTrNa+j56mTMYCiy
         ibcfocmGvvlFYJd5bHUuk6edB9wSQddoYDi7bUdJvx3XPKiMr36OnuBNeFVBd9PZSLqV
         9ZwhNzEAUhcIOuKjE48JeeluhJnz9rsxK7xs+duM07bm45f7D9Jon3CGWZqweeAnESDx
         48pn4jLHdVh2Sn6z7kHda5PgCO3tgMj63LW095rtQkm8rcMo6IuGFmGX8rXep1p7iRKN
         R600IyMoNywCEWo/SjbAo6sivLp2mwVzEBowPB4qgr9OH7MvAaDrm+XQXBOiqPYTeFLW
         pJgw==
X-Gm-Message-State: AE9vXwM8NIhxqXXgKXdK4D6WnilUgd4pJpOPviM9zNleouurI0cn7Xwi3u12YxhtIEdRCg==
X-Received: by 10.194.81.106 with SMTP id z10mr15099492wjx.140.1474843126995;
        Sun, 25 Sep 2016 15:38:46 -0700 (PDT)
Received: from [192.168.1.26] (dbd108.neoplus.adsl.tpnet.pl. [83.23.29.108])
        by smtp.googlemail.com with ESMTPSA id xb6sm19074496wjb.30.2016.09.25.15.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Sep 2016 15:38:45 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] mailinfo: unescape quoted-pair in header fields
To:     Kevin Daudt <me@ikke.info>, Jeff King <peff@peff.net>
References: <20160916210204.31282-1-me@ikke.info>
 <20160919185440.18234-3-me@ikke.info>
 <20160921110934.f6eu2dz6i2mlpa45@sigill.intra.peff.net>
 <xmqq60pn37gs.fsf@gitster.mtv.corp.google.com>
 <20160923041540.5fvl6ytp2tvcflsk@sigill.intra.peff.net>
 <20160925201713.GA6937@ikke.info>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Swift Geek <swiftgeek@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <0b6cbc53-e058-f064-59e8-b73203f3e400@gmail.com>
Date:   Mon, 26 Sep 2016 00:38:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160925201713.GA6937@ikke.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 25.09.2016 o 22:17, Kevin Daudt pisze:
> On Fri, Sep 23, 2016 at 12:15:41AM -0400, Jeff King wrote:

>> Oops, yes. It is beginning to make the "strbuf_swap()" look less
>> convoluted. :)
>>
> 
> I've switched to strbuf_swap now, much better. I've implemented
> recursive parsing without looking at what you provided, just to see what
> I'd came up with. Though I've not implemented a recursive descent
> parser, but it might suffice.

I think you can implement a parser handling proper nesting of parens
without recursion.

Though... what is the definition in the RFC?
-- 
Jakub Narębski

