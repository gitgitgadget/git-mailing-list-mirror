Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11CD3202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 16:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932331AbdJZQ6y (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 12:58:54 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:52006 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932137AbdJZQ6y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 12:58:54 -0400
Received: by mail-qk0-f173.google.com with SMTP id 17so5102890qkq.8
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 09:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Bc6so4NkOS5DXSWfgPOnCguwgdVq4u9tV8TrIB8P64o=;
        b=hBwUUfWSfkr9TWmZiHAo4hauJw3dZ4tXqDy4GQf1bpLdGOBAfw0+09tirich+3hq4g
         UdQrkChNQShNHDOqWKnGACpskAtNjNzWZAi7TCIHVncPOYVIjrGDJIV7i9P60f0eB1Te
         +nkrF9VrhKKnCQHSi1NZQrXwUfQbv4i6w9nL85CLMznaEPt+/+nJ0OfLzqQ5aeJe4xnw
         PQXaEivsvGrkFm2bVPERGNX5Tk+hY/L6ECUL4WFhuIKESVH4472Ykmp4Wbn5kUR8v9zr
         PR7pdYChAr0zsrge4A9JpKvKKBy7t7u6PG2wzpjts1mbyuaEod0ldC7cAxQ+qfwFGQep
         g7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Bc6so4NkOS5DXSWfgPOnCguwgdVq4u9tV8TrIB8P64o=;
        b=unTV35Udq1w6sbLFl6dVVXMQCax1k50ykcOOwquYgzO73ACG1USb9VgT3fY27DOCg3
         fMVLvzAXHtuVfOinfWDWy//YVI/CZAm3KSplInjcU8MHHyuqHm3o9GpgN1UI6+tNH4Da
         ekIkaRIaZD91hDOvvqLiJwVW51Qp5IGyGd2SxVeSD/v35UcasGkCvSObaMvSgCf0bv2e
         RxLt0FagFOS6N0ZeDWzwYykbMSAFgz2eVZx5XTY0+48pLNOH6U3hNbiSBaC+dh/85xpj
         97ZlS/+/58sJfFrD9iY6zdtiwAWvGfQyKhBpwIyXUDuKc4NaXYkJuDBjrrTFGhPSw1hB
         La5A==
X-Gm-Message-State: AMCzsaWAETeMVbG87jF3MDc9FUklOvsSxFrBALq7WcmKkj6Ze0KmbqCU
        hF5ULszXk/HXYLUI8xjFhJWTtR2KZ3e/oKCebi4t0y9N
X-Google-Smtp-Source: ABhQp+Qgi9o1Gpt9tvUPLim0RMKlV5T7tQCdTDCMjlyEEI8blVlSTyYjvEmHjbb2l6GeqOP9v55frmpUwb6qW4nSFQE=
X-Received: by 10.233.239.140 with SMTP id d134mr9133871qkg.308.1509037132222;
 Thu, 26 Oct 2017 09:58:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 26 Oct 2017 09:58:51 -0700 (PDT)
In-Reply-To: <1509030170.10651.59.camel@perches.com>
References: <1509030170.10651.59.camel@perches.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 26 Oct 2017 09:58:51 -0700
Message-ID: <CAGZ79ka41NdzNxGAvtVW802088KydKkp3yHx=Z5q3Mc9GGa_+g@mail.gmail.com>
Subject: Re: grep vs git grep performance?
To:     Joe Perches <joe@perches.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+ Avar who knows a thing about pcre (I assume the regex compilation
has impact on grep speed)

On Thu, Oct 26, 2017 at 8:02 AM, Joe Perches <joe@perches.com> wrote:
> Comparing a cache warm git grep vs command line grep
> shows significant differences in cpu & wall clock.
>
> Any ideas how to improve this?
>
> $ time git grep "\bseq_.*%p\W" | wc -l
> 112
>
> real    0m4.271s
> user    0m15.520s
> sys     0m0.395s
>
> $ time grep -r --include=*.[ch] "\bseq_.*%p\W" * | wc -l
> 112
>
> real    0m1.164s
> user    0m0.847s
> sys     0m0.314s
>

I wonder how much is algorithmic advantage vs coding/micro
optimization that we can do.
