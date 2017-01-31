Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C17E820D07
	for <e@80x24.org>; Tue, 31 Jan 2017 02:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbdAaCe0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 21:34:26 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35110 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751909AbdAaCeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 21:34:25 -0500
Received: by mail-qk0-f175.google.com with SMTP id u25so150077007qki.2
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 18:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SSps1yHBUKpwOeKEnHY3DXpR2tDeQ+I2vk8Px3jSPTs=;
        b=ebtiKXWuzlOXWivxOnQ8QQ1oOe8wWUerfWG8P6F4PXiOxUDI7YLu/RNkcL5yOLn/B5
         zNMo0pKNsslQkqpETNR93Id3rnt9EcQMyrvJlLIFN27L03SjyaWigOK8P40tyT0gcJvQ
         MFSZFoAtLY7eRAuei+Xo52t8YTS6DtL8FPHR5Yy8q/Ow/zega+4pkESEJKVhAXH9G5iG
         GZ5HTKnHcxiZ3NvEE+iSSQ6SPpk3mNPWpZ8ey7DwQzLYhAv9k51yDZvJAakU4xbLtMtA
         cB9zn0V+d4xfx3PVawRAKqmsKbTma1GErHVmlMqX5zoU4zOQXArhoPf5orxA+dCbuCcO
         GVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SSps1yHBUKpwOeKEnHY3DXpR2tDeQ+I2vk8Px3jSPTs=;
        b=MAqbtLFLhcYSVMRKOaOYJ7+HTK4ZuSo904mpoTjnOw5vrRZfmVPg5bI04tCavqQElu
         2CyAtQafvr+XO8FH/X7xUcl4ZFTVsWSNEs1wOhdTOLAWxOcVsFDvBQ04/2a1laJfmg0J
         TmsmNFLo2+SGSoyNLN9DYMNpPx/emlKqd/zv0cKQyCME3KnXxY1Gw3dhr9IdnVa8HybR
         JWkCpZgMFFOzbOBlgZZuL9978J9/bLPx0+RQ7EGWPt8TuEvR/rHt9LGQi/QISzat2FT7
         wDUOzdT+dR9qKKsXb/K4tlrt1OKRCjmNhC2S6oCF6gdhFyPl/rToI8PSkxjdLPg1bgSB
         l+3w==
X-Gm-Message-State: AIkVDXJZumjJE1hwU/SCJni2ItGwbD4uYAmqq40BPMYoLkMoqjoYjKpyazlw+viHmM6GEuo50SiGjNaW7v9J0w==
X-Received: by 10.55.118.67 with SMTP id r64mr23991159qkc.285.1485830059833;
 Mon, 30 Jan 2017 18:34:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.45.226 with HTTP; Mon, 30 Jan 2017 18:34:19 -0800 (PST)
In-Reply-To: <20170131022830.8538-1-eantoranz@gmail.com>
References: <20170131022830.8538-1-eantoranz@gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Mon, 30 Jan 2017 20:34:19 -0600
Message-ID: <CAOc6etbZ56V_9GSwOO3eFqg1TCwXT3+hDT67xEgZvui7DO-dRg@mail.gmail.com>
Subject: Re: [PATCH] blame: draft of line format
To:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        pranit.bauva@gmail.com
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm basing in on the "pretty API" so that we don't have to reinvent
the wheel. I have already noticed that many of the formatting options
available for pretty are not working... I'm sure it would require some
work setting up the call to pretty api but the basic is laid out
there.

Let me know of your thoughts.
