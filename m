Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBB6B1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 17:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeH1VEA (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 17:04:00 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:38525 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH1VEA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 17:04:00 -0400
Received: by mail-pf1-f175.google.com with SMTP id x17-v6so1001418pfh.5
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 10:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZwFM5pI8YoCRGwDLqeCVWlwRZcHvV2hBIp241cfMA/w=;
        b=PwITIeW7E6umSXLXssvC2IeBGfJTYyxZzTgz2MIMRGgQOZpFjbVCz+iYv1LNwSeUQR
         OJbFzCgsED5PiaB4RHq26g7OpGGcD8smq4SKjWLAP79ogLKN4Nmkecxj0aE0lvP9Hfhu
         GS6t8wmHFuOgT1ZNLl52rHO2AbMbKsP6lxUkVEcUDBUxOXztppbQkn3JJ9okMnr9LhfF
         /prvS414XLOZiMBOyArR46YenhELVM7WI57PcKP813YT+KTb0F0bl/LZZODEnsesSlsZ
         yDea1UTWOiG/jvEjbKFHy/xiC3jji40Veefm4qIaYu71a/YGSyTpKchox/iONiZYcD1R
         pX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZwFM5pI8YoCRGwDLqeCVWlwRZcHvV2hBIp241cfMA/w=;
        b=UMGlFAHiBDTg7BYLBPYLbRXTESPrzrMHg6EemVfmCyRMN4sW9ztEN+kCEYdKUvvJFa
         7iW4utcLAt9/hXly7z4+iosF4UHDqhTX14dqHyw0IUUg43407UHvSFa80Xz2Z2aj2dsh
         BDYpfwPjnLyezMk7ZT5sxaWS9oQjblm2w6NzFSvyoP68oI9q1Ybuy2r9hX9U0ELGgm8y
         /96Q2fgpMSXFLR0vjhOFv4u9rTbRryvhFU2647LJJlm6xaRqv5T2Kell4ZhLUJii+B13
         6ZKa+ijjVbVAEsXtkcIpz/zqHUZuT2Zlrs1nr8htsLJ+dC2/cViPfHwJ8e/Zc6EBk9Uv
         gLrQ==
X-Gm-Message-State: APzg51A+Dv8AaaVQs7V5jP+fiNvIhU2PiAF4F63nRqVZaggvJbSc6PYO
        CE7gRtnva+2lSf8LSXuLE8qaCJvP
X-Google-Smtp-Source: ANB0VdZv4O5UPe2cpgolb75WXnzGee+7XVq/JZt6vgD/ko/HfkxTspMhjqcPs1B2gftzYu3DM8ZjMQ==
X-Received: by 2002:a65:614a:: with SMTP id o10-v6mr2376003pgv.387.1535476283114;
        Tue, 28 Aug 2018 10:11:23 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id c4-v6sm2736459pfh.180.2018.08.28.10.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 10:11:22 -0700 (PDT)
Date:   Tue, 28 Aug 2018 10:11:13 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Questions about the hash function transition
Message-ID: <20180828171113.GA23314@aiede.svl.corp.google.com>
References: <878t4xfaes.fsf@evledraar.gmail.com>
 <20180824014703.GE99542@aiede.svl.corp.google.com>
 <nycvar.QRO.7.76.6.1808281402510.73@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1808281402510.73@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:
> On Thu, 23 Aug 2018, Jonathan Nieder wrote:
> > Ævar Arnfjörð Bjarmason wrote:

>>> Are we going to need a midx version of these mapping files? How does
>>> midx fit into this picture? Perhaps it's too obscure to worry about...
>>
>> That's a great question!  I think the simplest answer is to have a
>> midx only for the primary object format and fall back to using
>> ordinary idx files for the others.
>>
>> The midx format already has a field for hash function (thanks,
>> Derrick!).
>
> Related: I wondered whether we could simply leverage the midx code for the
> bidirectional SHA-1 <-> SHA-256 mapping, as it strikes me as very similar
> in concept and challenges.

Interesting: tell me more.

My first instinct is to prefer the idx-based design that is already
described in the design doc.  If we want to change that, we should
have a motivating reason.

Midx is designed to be optional and to not necessarily cover all
objects, so it doesn't seem like a good fit.

Thanks,
Jonathan
