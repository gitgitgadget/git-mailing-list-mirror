Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C33AA1FD6A
	for <e@80x24.org>; Thu,  9 Feb 2017 00:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbdBIASt (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 19:18:49 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:37967 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbdBIASs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 19:18:48 -0500
Received: by mail-it0-f48.google.com with SMTP id c7so4677455itd.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 16:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RscO18MiEwRjOvhQP3a+9+P7JPu7dGwHkiolZvxckEU=;
        b=fDGP3ypWCw0ytd3RHfqdXeR+lgNf0J/MxIlcOKwPlH0p0ZC5EfeyfSoRVxf4VEn9I8
         mMs3dnvA9cRDpvtNsU5QNCh5u/kRmoYNCvFBADQsuBviz4HsoL/9LvqpPZxsoxe7WClo
         U0XzXRXUl9A5GfZn1Go8flb9vbP7ddYHfTjZp96fROie6/gEZsku85dHCE6l7gFpkRxG
         5S2RnO9NyD5UsKvY75GD4H076XudRig7LZxVem4PA2aAL844AwOHua2pdv3Py6vz/I7I
         4BkhcyZIz4jVURBPEcObTBIf4HY0fOWWCoJVz9aU97yZj1BElsUZ03j3eUmfY8gSb/F4
         m7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RscO18MiEwRjOvhQP3a+9+P7JPu7dGwHkiolZvxckEU=;
        b=PC0VGulelZI4WQ2uIRUYyOYolRXiLGbbg+Kyoy9NC2i+5YMKrSq7V9DTyVcX+uRUgf
         0gV+JMaix/bEVN5T+JqsWT0CdRKzLWjvucHfcLDTRHk7FlALjm1QTxp7zeqjh2yah9uS
         Ak8sEgkSyxGfQUuHQezRfp+0difJy8vKRYO22aTAHnH1NvMGPJdT3+D7NzyGHA9/mSEL
         uFwrBwfIzu4GUYLB1+IJiOZF308u4QaOYd7lxo2vh6lVkMsKyxxn2Ng/m8BgyDjTrLk1
         evQYU4EXFaaAw5BeCLVWre1VQA0pY58AHT5p5iFbIF5SmZ7EabqoyfevD5z5oU6irr0H
         YfsQ==
X-Gm-Message-State: AIkVDXJofWSF9cjQBSssO3TbOJMYu5AXOcuYMWtjRirKfk9bcteY2UtLk208mcAQGxKJ5R8eDwycp6iWFwN1t3SX
X-Received: by 10.36.4.2 with SMTP id 2mr18280910itb.116.1486595797414; Wed,
 08 Feb 2017 15:16:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 8 Feb 2017 15:16:36 -0800 (PST)
In-Reply-To: <xmqq37fouvu3.fsf@gitster.mtv.corp.google.com>
References: <alpine.LFD.2.20.1702072113040.25002@i7.lan> <20170208223532.GB108686@google.com>
 <xmqq37fouvu3.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Feb 2017 15:16:36 -0800
Message-ID: <CAGZ79kaGtsaAKbjaX1b+fS_pqAZPsoFLHjf9CpwffP7uBV4R3g@mail.gmail.com>
Subject: Re: [PATCH 1/2] pathspec magic: add '^' as alias for '!'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 8, 2017 at 3:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  - it hints that '!' is the more official spelling, making the
>    output you showed above acceptable.

Long term , I'd rather have ^ as the "official" spelling as that is easier
to teach to people. ! being a historic mistake as it is hard to type?
