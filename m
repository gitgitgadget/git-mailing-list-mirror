Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 581D920899
	for <e@80x24.org>; Fri, 11 Aug 2017 19:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753638AbdHKTig (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 15:38:36 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38406 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753517AbdHKTif (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 15:38:35 -0400
Received: by mail-qk0-f195.google.com with SMTP id m84so4424163qki.5
        for <git@vger.kernel.org>; Fri, 11 Aug 2017 12:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WlPYXf8M1rcsde0vcH3N6poGtqE/pjxeoF15g9G0GFc=;
        b=DXt/BuA/96IJpfynvO5SR+V1XqFE9In+e73JtsjwADaAHgoj4/0hRulDmg+56ezmMm
         Pmt6WYKnQ4/W0HPVSJ0Kg2/OWuYra4RyiZ4Rz0OJOoL+U/p8GdYPASbAKedJ6xv5PM+e
         bdBW5aFjyzyABjYyTbADqflvHNpNMpUYDCyViZ4pomkLsQk6ck/sing0S6bisQ6cW4Ib
         9kXcyDv8NaeBkFeYNJQkc5dQLKaM7iAv9ZSqxiuGjFGR2QZmAF6mQxclDnqoL4KQIN+E
         SdKn1lVKIU11x6xqoKaYMFukMbLFIeHMDJ+Gm/JgBvu5HEEiR9H18Z0ZZEzHgeIhXGp/
         aV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WlPYXf8M1rcsde0vcH3N6poGtqE/pjxeoF15g9G0GFc=;
        b=lO0+dxI4EoM9Zk97C0jAEsngfSX2H4jH9ZL4jDkdsANbOzj2LmoG4nPRrThy6/rhY3
         HFjitiNzPIo7BZuPnVrdFO+y9+ZoKN9sGkSVUNFEiXpnMYmZE540QC3qr4lyYp56YIy3
         I5/m5Rx3/JSMUeoJ9CZh/XqxZSCYiBDzBByDW6ZyIMpYg1IhTMa/iornX8V9m552E9hF
         i2RDLi0bFsZ0aOKKm9nzsJS0GkYPVt6w4oenHQGlnsL/aQXPsPY8+nuQ8OuX7pzmLpEA
         DdmA1MI+otaYc+a+MmFs8K1Ylpp4kRlSwc114bYo7s9w0sbtfEePiZLqedS/nH7EkFX/
         9Dzw==
X-Gm-Message-State: AHYfb5gKlAtbT9JEWHIQQnZBp1XCQvDsF6F5nqE3ESwoIcjECkznwucC
        baTIPad4Z+P7N0+uzdE=
X-Received: by 10.55.42.216 with SMTP id q85mr20322716qkq.202.1502480314216;
        Fri, 11 Aug 2017 12:38:34 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id z30sm1063610qta.84.2017.08.11.12.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Aug 2017 12:38:32 -0700 (PDT)
Subject: Re: [RFC PATCH 01/10] pack: move pack name-related functions
To:     Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <cover.1502220307.git.jonathantanmy@google.com>
 <368a1095557aa5f68cebd4d4e08628351c03b843.1502220307.git.jonathantanmy@google.com>
 <CAGZ79kYQP74fTu1hFDLyKhS-2NTbUhtirWTxRMNavgO09SenYg@mail.gmail.com>
 <20170808135001.48f2440e@twelve2.svl.corp.google.com>
 <CAP8UFD20_Q7djbJfMmrGEnN3j2NasHyvuNAfZHMr_bNRjO0qpw@mail.gmail.com>
 <20170809101646.4bc67606@twelve2.svl.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <b65a5d52-490f-5ea6-aef5-8d2f6c916536@gmail.com>
Date:   Fri, 11 Aug 2017 15:38:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170809101646.4bc67606@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/9/2017 1:16 PM, Jonathan Tan wrote:
> On Wed, 9 Aug 2017 14:00:40 +0200
> Christian Couder <christian.couder@gmail.com> wrote:
> 
>> On Tue, Aug 8, 2017 at 10:50 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
>>> On Tue, 8 Aug 2017 13:36:24 -0700
>>> Stefan Beller <sbeller@google.com> wrote:
>>>>
>>>> There are also packed refs, so one could (like I did) think that
>>>> pack.c is for generic packing of things, maybe packfile.c
>>>> would be more clear?
>>>
>>> Good point. I'll use packfile.c and packfile.h in the next version.
>>
>> It looks like you used "packfile.c" and "pack.h" in v2. Is there a
>> reason why it's not using "packfile.h"?
> 
> Ah, I forgot to mention this in the cover letter. I thought that one
> header was sufficient to cover all pack-related things, so if we wanted
> to know which files used pack-related things, we would only need to
> search for one string instead of two. Also, the division between
> "pack.h" and the hypothetical "packfile.h" was not so clear to me.
> 

I prefer having source and the header files that export the functions 
have matching names to make it easy to find them.  I would prefer 
packfile.h vs pack.h myself.
