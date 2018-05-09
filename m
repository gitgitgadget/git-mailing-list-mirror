Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 497371F424
	for <e@80x24.org>; Wed,  9 May 2018 17:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935125AbeEIRyu (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 13:54:50 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33124 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934331AbeEIRys (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 13:54:48 -0400
Received: by mail-pg0-f67.google.com with SMTP id i194-v6so23005744pgd.0
        for <git@vger.kernel.org>; Wed, 09 May 2018 10:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HDWpiFVIE0Cd7KeuOQjBubUeP6MbUUeox+AK5NChGxM=;
        b=TYxDvOn7vrut0Cgd4ifnRxjecZpvy+kiwaE4ZW1kwcbplUySUdebCP7cGl7GzdamNU
         plxDRlLAYJuCbE/Sungac9nvhpErq/oln9A5yncUakcqM+T3esa/4B8GYO72li07BjrJ
         bkowXMBIfX125ssa8FOYD0uw62+I9D1Rl7R2VmhboRPqi82UExypsEahIFVmIkNH1Ur3
         1RBXVM2lI3xvC7X5+vXjFA0fnfRZ6WiYqBgELBjFpHD6zM+WMLtUFklpQzJPc+WLDbZu
         rVu6vhhCc7cimitAyRMtoRkEIWRKdqyT8MToXIUgybhk/8R5gy235UyxOJ8F7Z7y0rDC
         /0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HDWpiFVIE0Cd7KeuOQjBubUeP6MbUUeox+AK5NChGxM=;
        b=k5t4FEt6P4Ha0l57+iPjpl7/CR5PAekMY+/4dNdfr7yTNsWY3tjg06rtABUCWP68mk
         D8J1wnkV2niOcdXoxvyr2q8zoGcDURgrxfXKr+jc+Y8ppQXrPAWxPHwopSm17TUgXGHx
         RegiexJWihCh1oQG/sxkYF66zHMNTULYPu7AunezCiwxX10uK92MEgQgHbrdSLfqBkJY
         CDL24O4nLfG/HPF3eSxsznSqlIxkZklfH4G1T0ppsaQ3LaCLUxiG40DehSfNQPgFp4m1
         mIar0wXtX4uMk8aaaBUSzw+/toxkJy2K26zwLQpZ47jjgHvR/FYChGYWgFwKBj4ewjBH
         i86w==
X-Gm-Message-State: ALQs6tBx9LdTElqw8nuPJQfXHggu1VwOYbrO0AN5/C8gr2+y5D6fTqXl
        8R1h6ZLfGRYuXvllUSi18edyzRdN
X-Google-Smtp-Source: AB8JxZprI1iZLq/wPcnYOKL+k5hKgno+GBzrQVlTz1+oDiQXZBfzwlkT4C4YSqEon+GCbjRA1pYYWw==
X-Received: by 10.98.33.28 with SMTP id h28mr43638776pfh.249.1525888488247;
        Wed, 09 May 2018 10:54:48 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id x124sm1827765pfx.72.2018.05.09.10.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 10:54:47 -0700 (PDT)
Date:   Wed, 9 May 2018 10:54:45 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@dwim.me>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        ethomson@edwardthomson.com, ps@pks.im
Subject: Re: Implementing reftable in Git
Message-ID: <20180509175445.GK10348@aiede.svl.corp.google.com>
References: <CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcXzPBjPBg@mail.gmail.com>
 <20180509164807.GI10348@aiede.svl.corp.google.com>
 <67fd1816c4da0e54fb88dc29a44b897d41a36602.camel@dwim.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67fd1816c4da0e54fb88dc29a44b897d41a36602.camel@dwim.me>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlos Martín Nieto wrote:
> On Wed, 2018-05-09 at 09:48 -0700, Jonathan Nieder wrote:

>> If you would like the patches at https://git.eclipse.org/r/q/topic:reftable
>> relicensed for Git's use so that you don't need to include that
>> license header, let me know.  Separate from any legal concerns, if
>> you're doing a straight port, a one-line comment crediting the JGit
>> project would still be appreciated, of course.
[...]
> Would you expect that this port would keep the Eclipse Distribution
> License or would it get relicensed to GPLv2?

I think you're way overcomplicating things.

The patches are copyright Google.  We can handle issues as they come.

Jonathan
