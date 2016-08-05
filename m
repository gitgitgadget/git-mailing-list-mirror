Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0E612018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968465AbcHEVVf (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:21:35 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34594 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1948706AbcHEVVc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 17:21:32 -0400
Received: by mail-yw0-f193.google.com with SMTP id j12so22058955ywb.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 14:21:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CIGo8Ud8ZR7v6+STKyi9tQONVT1rIHmfLZmGvmCqXH0=;
        b=ZbB5kpdk3eU/kIOvB1iJIxPaD4qXFodq0Hem4VIyivqS614pk6rtBl6Lt7ZrhABdHp
         quJ1IH25NAWDha17sDgIdj18xXxNxQ6Z/nlK6FxazmF+vXJh0U8JMjY0/4qeZQSTxW2F
         yNCAZYsARXmO0vlg9sgBj460to+JJMgtVhgIoKat/BYsVd1pWhJv9nM5RYdKKF6axYD6
         1uGAabtrB8469SUIlq6dQYudRCFYN/8Bf+6ryISRwTRL2L1RHSQv273dqnik4+dK2BIP
         VS9EuJ5aOZttHh6963wBuwPjtgqBHd5Zot2f+vBS/X0thXcKlqYHHN8t0klQ96MGeNFG
         791g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CIGo8Ud8ZR7v6+STKyi9tQONVT1rIHmfLZmGvmCqXH0=;
        b=MORUeKu4oaW5+Oqi/XaG/0BCC903hcZCLf6ft7i5+2sypCZa+zKT5f2gK3tb+kBcUX
         26vxOSl5ueLSiSxsQ4E31ZEzmnYnMyac1HYgd+hK3P5BB8dQO3NnkB/B7BbSCSQzxSXe
         NjSYIhFYujplGpFhIwFLwLtWMTr2In+8kNBOV0Cb2jVjVw9Qq0PMC3MBZ73LkslkNMEC
         dV/u6EkA2ygMt5o5dkNRcnA3s1FY61MBe/Agcc0vTtwWCcPKKIO5PODDiwyj9kaWuf8O
         l+bFNqarr9bWl1vE/+MLlT5VTPZeXssJQddsuw2iN6zvelYQthTl+uOZ1364RfknRk6j
         oV5g==
X-Gm-Message-State: AEkooutioEtDDg+aEuPXa8WzImSm1CwLshxZCiaRurXtkAsGptVbB0Bcys5PQa9YA9VoX43ZAa/rxKSciiKEqQ==
X-Received: by 10.129.106.139 with SMTP id f133mr64479365ywc.163.1470432090777;
 Fri, 05 Aug 2016 14:21:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Fri, 5 Aug 2016 14:21:10 -0700 (PDT)
In-Reply-To: <20160805211434.54mtaw2cty4gaxsr@sigill.intra.peff.net>
References: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
 <1470147137-17498-6-git-send-email-git@jeffhostetler.com> <20160805210222.a2rvlmioim4psbhw@sigill.intra.peff.net>
 <CAPc5daUr7OgFeefbwWLWFt3KW_9X-ijRmHa2oj0--zY4fqt82A@mail.gmail.com> <20160805211434.54mtaw2cty4gaxsr@sigill.intra.peff.net>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Fri, 5 Aug 2016 14:21:10 -0700
X-Google-Sender-Auth: LDnz2ipFiP_EglBpnlFj0DAJdAI
Message-ID: <CAPc5daUb-8uUU-BsLVFoYZKcySgMYGCu70hTwh1A7L8X0vSJ4Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] status: print per-file porcelain v2 status data
To:	Jeff King <peff@peff.net>
Cc:	Jeff Hostetler <git@jeffhostetler.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 5, 2016 at 2:14 PM, Jeff King <peff@peff.net> wrote:
>
> Unfortunately it is hard for me to test a one-off, as running it locally
> is a complete pain. Stefan set it up long ago to pull "pu" and email out
> the results from their central servers, so I just scan those emails for
> things that look like real issues.

Ah, running check on 'pu' is an excellent way to catch issues early,
before they hit 'next'.

Thanks.
