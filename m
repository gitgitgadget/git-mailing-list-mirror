Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F6EA1FE90
	for <e@80x24.org>; Fri, 21 Apr 2017 11:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1037365AbdDULwh (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 07:52:37 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:34500 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1037302AbdDULwg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 07:52:36 -0400
Received: by mail-io0-f170.google.com with SMTP id a103so117255930ioj.1
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 04:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=HxnG1WAjAV7zPx4zN5m5sqnX3OaQxnhgSV5FpS1pXtM=;
        b=Wul0m/Lhvh9rv99lnzGFKTbn2JxbdYmAfgNxKpdegdmyOH/syZ8nFkAfhUCBDIGu8b
         Jti6Mt4iPl+Arn1n2cfw8tsX4u6WMOpprrR3gbqAWqtRnuEPMRS2h7HZPdOWZ1btsRS3
         eofsfD1TdfxfJ4V4BSEA8V8z/TSkUDDOlTIOjIpqAc7Nxg2pC32fWjvoihZRI3n3nvt5
         mIQHlTLbimZRen/UUNvyc4ZI0KLMHdfuvrkfkOEQrEZmKV9Viwn/fH+u0YhXzi/+X15I
         jFSBOWXVHeNp4v6qG8SBf34LPnJZb4rSZcX+Jbq/K6N56mK2mzEW8WQsVeUMQyU9OSwp
         iQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=HxnG1WAjAV7zPx4zN5m5sqnX3OaQxnhgSV5FpS1pXtM=;
        b=jVoqnIJzi6/OVxOsdOvujDvg+3tk40zhKoZgAcHMF9jLM5WyoOF8YkVNgKdxjvyT49
         17X+jEv9bPRsUeVFLtDWkPXS88tnJWlBJ4V/UacxGgy83/YQXn9myIDadz8vwxSXJuhc
         gJaYHQOaXdQlgVU8olX9VRoiwDIDPoZTCpRd9ibM2eGLNWfkK3TjhiLPMy+6FlAAQo6X
         hBTjpd5Zkhx5xQfv1bLSzYmtS9gtUSyEKZkYzK7zXrbIzvryevous6AkpTE6J7LUypdn
         i4j8jE4/9Ba9kkGDdiPi5eSPnmwjwKBBFXgM+yNYRIqwCXpXIVldr5LzsSVbB6g6zaSw
         nVYA==
X-Gm-Message-State: AN3rC/522FS+6995mRqhKb205tNFXEKTf2+ufKEsKjEnezj2yGIaU0hw
        +w1sdJWjXHs0j6JdvIo1E1hOukph4Q==
X-Received: by 10.36.78.10 with SMTP id r10mr4235594ita.110.1492775553878;
 Fri, 21 Apr 2017 04:52:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.47.88 with HTTP; Fri, 21 Apr 2017 04:52:13 -0700 (PDT)
In-Reply-To: <CACsJy8D1LuH6qVp15MSkCM_oQphVUUK0r9SeKC5AzX+9Xi2dcw@mail.gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com> <xmqqlgqu7cq8.fsf@gitster.mtv.corp.google.com>
 <xmqqk26e5swj.fsf@gitster.mtv.corp.google.com> <20170421062915.he5tlgjqq7kj5h32@sigill.intra.peff.net>
 <CACsJy8D1LuH6qVp15MSkCM_oQphVUUK0r9SeKC5AzX+9Xi2dcw@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Fri, 21 Apr 2017 20:52:13 +0900
X-Google-Sender-Auth: 8RLO5hYFTpfTdQoh-0Xt1Xq6d7c
Message-ID: <CAPc5daXPgEFibr28-EZjk9_vYrrO2qt9VLXW6PepmFXUChpk7Q@mail.gmail.com>
Subject: Re: [PATCH 00/15] Handle fopen() errors
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 8:04 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Apr 21, 2017 at 1:29 PM, Jeff King <peff@peff.net> wrote:
>>
>> I had a similar thought while reading through it. I think it would be
>> shorter still with:
>>
>>   FILE *fopen_or_warn(const char *path, const char *mode)
>>   {
>>         FILE *fh = fopen(path, mode);
>>         if (!fh)
>>                 warn_failure_to_read_open_optional_path(path);
>>         return fh;
>>   }
>>
>> And then quite a few of the patches could just be
>> s/fopen/fopen_or_warn/.
>
> Jeff.. oh Jeff.. you have made it _way_ too convenient that after a
> quick grep at fopen( again, I found a couple more places that I would
> have just ignored last time (too much work), but now all I need to do
> is Alt-f to the end of fopen and Alt-/ a few times. Too tempting.. :)

Yes, but (1) we'd need to be careful about --quiet, and (2) we would also need
a wrapper for open(2).
