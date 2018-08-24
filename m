Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C67941F404
	for <e@80x24.org>; Fri, 24 Aug 2018 01:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbeHXF1E (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 01:27:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42486 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeHXF1E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 01:27:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so3740684pff.9
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 18:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YISwtz6xUF2Wh4OyRU7/cQqPdOVwLt940RrkDRvwsSU=;
        b=fCkpAUbZcG17zR2B04/WIpCDf3lmeeaoud5kaEklr3TwY4nGrb+qKjJSKKCiXST7WA
         Oj/FOvktFiu1Ad+yRdnvjT5/S6OvzgjgpRiAM5jsO+qTcuYzbzNdkgcGmlSEfFfx0YDk
         a0aPv6ju7szz8k18s3IxMN8gck7q0HeB0bc3rUTrCxVEGUpZ3wKcWmMJbkD7Ji4/2XeY
         Nz2cscWwi5HQYWs8xrIg1axhkOtvnSjYL4Ykjxjzc0tPsxj6CGmzHq3wPxYoichqICpQ
         D2dAWDPd/9f+nnXndpR/cfBfigf8rKoE3LsbVutNl/sJ2PmjEx3I8z1TYl3WQ0fJS5tm
         q0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YISwtz6xUF2Wh4OyRU7/cQqPdOVwLt940RrkDRvwsSU=;
        b=mUFgGT3re9wX0MKZaY6J7XXwSKjx8hvsy0XMURi1xVVuYSO9bC7w1KYQoLwmzJ5Vy8
         VInfUlCWud6Q/WLRnEYxRAlqWnrTv09L1PA/qMyy3Qd1c5cDzHMhaFQvLLej8gnggJTg
         //Fe13UcqWiy9mJKzvph917YGDsXcXQWtbvltI6dk629DJMq3gMs0SzFoxqwrNxe/GZv
         plmHj3VvJLMhvG6Y4wfIDtMI/juiwsrdjZg3d1jlVJySyp5ju4hJ3ODT4UMISIgXmqoN
         e5e6la5w5rc9gjTA2hkiRpDaW5a2fhtv6ArpngwRF0Qhi6+EnS83ymGcAnJ+Dc1djYbZ
         q7YQ==
X-Gm-Message-State: AOUpUlFkld/JgfQmRLXLzgqmwCG2e7t1QTowcN24GutzGcqAyyYwTpxY
        eyeQx4oHqGXs+xKIsxc0V/96gpr/
X-Google-Smtp-Source: AA+uWPxDidbyajEeAOp+7s6+vdkTWHbDdfhMlQzQQqaVuffkrulmf4ZW8onn+XKWzdcURVVP+Z21Eg==
X-Received: by 2002:a63:7b4b:: with SMTP id k11-v6mr23973633pgn.64.1535075681138;
        Thu, 23 Aug 2018 18:54:41 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g15-v6sm15695415pfg.98.2018.08.23.18.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 18:54:40 -0700 (PDT)
Date:   Thu, 23 Aug 2018 18:54:38 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Questions about the hash function transition
Message-ID: <20180824015438.GF99542@aiede.svl.corp.google.com>
References: <878t4xfaes.fsf@evledraar.gmail.com>
 <20180824014007.GF535143@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180824014007.GF535143@genre.crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

brian m. carlson wrote:
> On Thu, Aug 23, 2018 at 04:02:51PM +0200, Ævar Arnfjörð Bjarmason wrote:

>>> 1. Add SHA-256 support to Git protocol. This is valuable and the
>>>    logical next step but it is out of scope for this initial design.
>>
>> This is a non-goal according to the docs, but now that we have protocol
>> v2 in git, perhaps we could start specifying or describing how this
>> protocol extension will work?
>
> I have code that does this.  The reason is that the first stage of the
[nice explanation snipped]
> I hope to be able to spend some time documenting this in a little bit.
> I have documentation for that code in my branch, but I haven't sent it
> in yet.

Yay!

> I realize I have a lot of code that has not been sent in yet, but I also
> tend to build on my own series a lot, and I probably need to be a bit
> better about extracting reusable pieces that can go in independently
> without waiting for the previous series to land.

For what it's worth, even if it all is in one commit with message
"wip", I think I'd benefit from being able to see this code.  I can
promise not to critique it, and to only treat it as a rough
premonition of the future.

[...]
> For SHA-1, I have 0x73686131, which is "sha1", big-endian, and for
> SHA-256, I have 0x73323536, which is "s256", big-endian.  The former is
> in the codebase already; the latter, in my hash-impl branch.

I mentioned in another reply that "sha2" sounds fine.  "s256" of
course also sounds fine to me.  Thanks to Ævar for asking so that we
have the reminder to pin it down in the doc.

Thanks,
Jonathan
