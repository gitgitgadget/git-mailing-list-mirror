Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6421F404
	for <e@80x24.org>; Mon,  5 Feb 2018 19:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751084AbeBEToc (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 14:44:32 -0500
Received: from mail-yw0-f174.google.com ([209.85.161.174]:45158 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbeBEToa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 14:44:30 -0500
Received: by mail-yw0-f174.google.com with SMTP id b16so16412493ywh.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 11:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hS6cEKEhy9GJykrPpw2gNc1XAFPFhBGAPqLtK5iwyrE=;
        b=KFXYqSqPhzPbe0X5G4ArTVUpk8vOA4/TTczrr6RAnzghenMv5w8QOCN0spYxJNixqv
         vxEFvjlScQmjToYnvW0K/gbCBwPGC6PrkG+UiVkdaivhz5qNEiqTEq/T8JWvTgY4utNR
         pdF9TSFQAKwLrhG8eiFYfVmOSp12MMxJ7UuWUjx9Kj4A6WYeqW8PrWACgaUYk2qhUgAt
         LJhLbZN+M1/PFlLxZnM+b8S24V5W/jKsCIXOajzKzZK0x89ptDqmB7qj1V0Z6BSHekbW
         4N0bQHnD62M1DD4RG3BrXdC7OnAO+hgRA28OuqC+OBtoH6L8z1jPQ4NF5pVncnHquvMW
         NKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hS6cEKEhy9GJykrPpw2gNc1XAFPFhBGAPqLtK5iwyrE=;
        b=diVF3OyzJ/B/CqoRrntsMLNeDRzUINnktz9Bfes57AH+BnXLNZ1YMsA9pDvEPc3nwK
         8ETjRhozJrt1aloU7jRck5nnmZs2ohGpidhGhJNCtXe3XkUq1d2w3H90AI2fOLufOhXH
         qlnmf5THiOCi99lVjba3kQ2Qwkk8BQWB5vEcYCFxr1ZIf0ru47jS+ZuabN93sOfy+5Pq
         U7rwwj9ik95EjNF1nK1V0njdLDt1krw3bo/kqYwIwsIaOI/9CY/j0e+/tiAxm70VTjy5
         v0uDrPCLOfU+JRDdBZFFvF4+a7pHr3JI+E13FtI3/ZZLtStwkkaQBwQlnnfKGCaGwIxa
         LhoQ==
X-Gm-Message-State: AKwxytebvZ6Uf4588UadKGi4at2k/DDqFlbDZlnJ5hIEUjWdXrEhsiG/
        eBppm0oZUOb2+JVWc+OTqbccDAiZPvmTHRh6F2X5bw==
X-Google-Smtp-Source: AH8x225pdGPvd07xn5VxY65i3xfzfUK4Ha+XZNvrMijAcwnT96hZJceyCqHMxXSDC6QyIe8fw7nvqZjhWbSHlOm4Fp0=
X-Received: by 10.37.133.12 with SMTP id w12mr24320476ybk.213.1517859869996;
 Mon, 05 Feb 2018 11:44:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Mon, 5 Feb 2018 11:44:29 -0800 (PST)
In-Reply-To: <CABPp-BGc0F5023yY1wRb3Gy+oXdbHAibkHYr35+zE=OnT2bQmQ@mail.gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-18-newren@gmail.com>
 <CAGZ79kYcmq9JyD4smH1Vdm5YOFXRXjhYhhHYjNV=Z7mxz2UVGw@mail.gmail.com> <CABPp-BGc0F5023yY1wRb3Gy+oXdbHAibkHYr35+zE=OnT2bQmQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Feb 2018 11:44:29 -0800
Message-ID: <CAGZ79kaFud05Txp6o2Qjz-kyWu9rb3vNzDGXSA5OZSY4MxyE+w@mail.gmail.com>
Subject: Re: [PATCH v7 17/31] merge-recursive: add a new hashmap for storing
 directory renames
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> Having a stringlist of potentially new dirs sounds like the algorithm is
>> at least n^2, but how do I know? I'll read on.
>
> Yes, I suppose it's technically n^2, but n is expected to be O(1).
> While one can trivially construct a case making n arbitrarily large,
> statistically for real world repositories, I expected the mode of n to
> be 1 and the mean to be less than 2.  My original idea was to use a
> hash for possible_new_dirs, but since hashes are so painful in C and n
> should be very small anyway, I didn't bother.  If anyone can find an
> example of a real world open source repository (linux, webkit, git,
> etc.) with a merge where n is greater than about 10, I'll be
> surprised.
>
> Does that address your concern, or does it sound like I'm kicking the
> can down the road?  If it's the latter, we can switch it out.

I think that is fine for now; the real world usage matters more
than the big O notation. But maybe you want to hint at the possibility of
speedup (in the commit message or in code?), once someone produces
a slow case and digs up the code.
