Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C83A51F462
	for <e@80x24.org>; Fri, 26 Apr 2019 06:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfDZGBN (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 02:01:13 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:43998 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfDZGBM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 02:01:12 -0400
Received: by mail-wr1-f52.google.com with SMTP id a12so2651997wrq.10
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 23:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3oPg4WaBQkbZm5V9BLXramus9wBVcxu/fvJhRvNLrEc=;
        b=HPLkhv9cRXslCxj7Cz1SsCUNHwa5hd8C+XSsEHVHwlpr/tsmSmGZ4SMtufHz4pDW3m
         a3DAH6zCS9eUk/yPPMdCxdgggz6w9ZvMukR2oDH/TY7kfURTYCR0oOTTgPaRLoXUhEUf
         Je98v5XCIJl+gyxfNl0JGlOoSCnc8mhwZWLINJ93KjqYo6z9lZFVEtdFa90GEkcpDpNW
         HB2wmMWDGTfs72h8w100orDfUTDNleQ3aRPl8YlwL+ehwyh0Ys2V0MtG14608COSvaHw
         akuh1O0beK0wJgKJHNu3daAdi9Xnhng+xoxTUosiCREu1BpQd8beF+HIfF6Znc+f3kNf
         sn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3oPg4WaBQkbZm5V9BLXramus9wBVcxu/fvJhRvNLrEc=;
        b=S9jJsGeJpdD6R/ibZS+bi/z9GAgiWFX+ZVY4iUNMFenffRw/Lw68X1EowA3OQWGn/X
         JJAJ1Fp/I4NWJ3wSF1BSUOHba00vgIGPpYwMzcxsC+ZQ5wo41tPpm3Aq1lWt1h5hsgmw
         J/0Zc4MlgDhWCCXIfort0d3bv8xiwjvk6zj9shGu3z7Bfn8mo2Zw0aqWvmX2R7/dRUV7
         7JRA1X6uNAYKoRsMPK/KrC32fldI1G5Zsi2HaNNsXo4re3GXwbv16IUkiqgU/nbxX/kV
         noUVPlDal4oL6gB2vsc/Lst3gz8O0hYYqFIFLBAdqoZ4kv0RKjU5ibirzZHiQT3mmmz2
         otyw==
X-Gm-Message-State: APjAAAXS4KYvyZry8e8PLQNx0Xs0N/1nWO6eb2/6LzQKJHiTqXIe0mQP
        F2Dw9ykqs0AOtNzEyqfK8JI=
X-Google-Smtp-Source: APXvYqwNxljgnZrul7m0HCK0eJPorTClYmIyw1Am74bHTzcZjRxXBx64FHAZILN8/CoYBASbuW4rzg==
X-Received: by 2002:a5d:4684:: with SMTP id u4mr5470355wrq.33.1556258470224;
        Thu, 25 Apr 2019 23:01:10 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id f7sm502924wmb.28.2019.04.25.23.01.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 23:01:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #05; Thu, 25)
References: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com>
        <20190426050531.GA7854@Taylors-MBP.hsd1.wa.comcast.net>
        <xmqqd0l9uxv1.fsf@gitster-ct.c.googlers.com>
        <20190426055335.GA16651@Taylors-MBP.hsd1.wa.comcast.net>
Date:   Fri, 26 Apr 2019 15:01:09 +0900
In-Reply-To: <20190426055335.GA16651@Taylors-MBP.hsd1.wa.comcast.net> (Taylor
        Blau's message of "Thu, 25 Apr 2019 22:53:35 -0700")
Message-ID: <xmqq8svxuwyi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Ah, I _can_ see the merge in my local copy (fetched from
> https://github.com/git/git) as c49927fca0 (Merge branch 'tb/unexpected'
> into next, 2019-04-25).
>
> I looked for the commits themselves with:
>
>   $ git log --author=Taylor
>
> on 'next', but only found the first four. I'm sure there's a logical
> explanation of why this happened, but I'm not sure what it is :-).

The last three patches were made out of these messages from you

 Message-Id: <e0bd479e822ce81de280ee6fdd07f608a96b7836.1554861974.git.me@ttaylorr.com>
 Message-Id: <88ca5dfe68c4cdb558aff6e90a525ec06f15dbd6.1554861974.git.me@ttaylorr.com>
 Message-Id: <e9400a9f773adb62315f75347ad7231b4476a2f4.1554861974.git.me@ttaylorr.com>

These were you relaying Peff's commits, for example, the topmost one

https://public-inbox.org/git/e0bd479e822ce81de280ee6fdd07f608a96b7836.1554861974.git.me@ttaylorr.com/

begins with an in-body header From: with a corresponding sign-off,
both by Peff.

