Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 209C91F453
	for <e@80x24.org>; Tue, 29 Jan 2019 01:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfA2Boa (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 20:44:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35882 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfA2Boa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 20:44:30 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so8892629pfc.3
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 17:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=v5bRE3QKSc7Ny62b14XMwbC/jxWjWZBHLimoiB+s0h0=;
        b=FoiRG/8/Mo6VWWq7SG5CRePp0RYMZxVhOMX8zIv9NThQO4QodSfW+qf4hFtubvotPH
         wE0KTxD7Z0a5oMJiGHed7gRk7f6hmTlfgt3U0+FZb3eobInarmQdXar0b1soWAMXRJvS
         t15OsIh//fK8rMYyL6xip2ZmSpdRxSwHRcgXue1H+Xr6jnmehYX57HqxpKPo9KOsw7nA
         RxuvkkzLIqbvtaB9LfFh5kvXMZgGHdi9alVuvNGLcp9UPX+hyg0vBybEjcSDnhL4ajEy
         KE9uZ0e5abhhUxP8XNZa8DAIGR6l04mcRBpIhTe5SNWtnU5Y7TgZHih+Mbfbf9fyUHbk
         Posw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=v5bRE3QKSc7Ny62b14XMwbC/jxWjWZBHLimoiB+s0h0=;
        b=SEYWtreTwyc/K/BLRie8iZ6D2Hi/9cgkDJQL0/sD1s/2q5w1MzLNUAs8R5YbJwphqL
         e6cIpUgfau5Goi1ONTAIVz+Y4AmbW0yPcl8MIJk0qSriHnDpN/LC1XVawLlNOt2vzUFz
         QB1vYla1S96Zeq+9cTb7XQdGzjtsWpXM/c4BaKcX1anh9K9NNXlg/CvsSNI0AXj+B/0x
         8OfPMB96T0styo7+sIZmE0C7iBvabQD8I6QSwMl8vGc9Lu5cNK+ODcbMzhUuGQQVRE8x
         fJxcEEuMG6NdwufuUmShVuWFREu5tQ1Zup4oBsKf1dgnUq+PrIEcBtP1AoA2OIeTseJP
         KUog==
X-Gm-Message-State: AJcUukfh2alTVzgaF+Kub8kAu7EmPhQ7QcyIVQ4xKLijnOQQZN4Cqwam
        J1pWKGQjMqyHrf4b0Ybj8Bw=
X-Google-Smtp-Source: ALg8bN4qjnBClD1jHtH605kkUbeXlv6nNjqGeP2Z4rQxTAEYLSYM4wOgqC+pUkkV/FnJx6OKmW2PfQ==
X-Received: by 2002:a63:9809:: with SMTP id q9mr21939991pgd.109.1548726269415;
        Mon, 28 Jan 2019 17:44:29 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id o1sm62208879pgn.63.2019.01.28.17.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 17:44:28 -0800 (PST)
Date:   Mon, 28 Jan 2019 17:44:26 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: Re: sparse job, was Re: [PATCH] test-xml-encode: fix sparse NULL
 pointer warnings
Message-ID: <20190129014426.GC7268@google.com>
References: <68a8c70e-dc42-1df3-3616-c096f63cb848@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.1901281706440.41@tvgsbejvaqbjf.bet>
 <a6b689da-b002-0aa2-e9d6-755d004bc320@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6b689da-b002-0aa2-e9d6-755d004bc320@ramsayjones.plus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc: Uwe Kleine-König, maintainer of the sparse package in Debian)
Hi,

Ramsay Jones wrote[1]:

> Hmm, I've never built an Ubuntu package before, so I don't know
> exactly what would be required (spec file etc.) to create a PPA.
> But I suspect you are not talking about doing that, right?

Ubuntu uses the sparse packaging as is from Debian, so no PPA should
be needed.  I've sent https://bugs.debian.org/920776 to get the
package updated in Debian.  If all is well, it should go smoothly.

Thanks,
Jonathan

[1] https://public-inbox.org/git/ef5a8623-e5e6-5cc8-5178-0afce7b5499e@ramsayjones.plus.com/
