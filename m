Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D6821F404
	for <e@80x24.org>; Tue, 14 Aug 2018 23:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732479AbeHOCCB (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 22:02:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46348 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731640AbeHOCCB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 22:02:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id u24-v6so9901192pfn.13
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 16:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ecLS5OCnqq9V1wB7pgGqHfZz5EB5SXrSHw9XX5OEviI=;
        b=fwaef7xMaKPUzH2IbTsL9eY1YtxKs9A9dsFJ67B1720mds+wT5SouVKmz6zX603JaU
         5G2QIvqFVECIpBJ/5/ucv8XBb82w8YmvRBUV8BYuYOozRp9aeGG6QgOggZo9Ll7nxffn
         NjOVyD4qRsgKeZvFA7nvY0BVvagxlh4t9q9UVcjqiyjAJxfIvIHtO2HKirrfo/HjzQFD
         WBqu1EpS114TZb2zsevGIxBMx47JcFgc4tffF722o9RDXELLKH3DYTBOYCgmq7oOGmMJ
         UyJhvJ3S1lQBBi3OZ2P3AxJfjc2zArgjLiDAd/88Dji5cU2HIIz12oap555tahBAFi3m
         u5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ecLS5OCnqq9V1wB7pgGqHfZz5EB5SXrSHw9XX5OEviI=;
        b=r896cOS+pCY3OERqEWNw86NqyYE2Fhj5m10qd3wvFC3tJcghqT9dt6w1d9AUwf42Z3
         so0IJ+mO02fPpeJhC8XjUkpdUZlG2vPjpQf8Q5Jnfju0FwKDI7+8R2qabfXiFpBnEed6
         FZ5DbOZRHtdf7jQz+p3Ehd/s8XDEAHaOze1QMcUKtrEWkJuEHtmbkPQ8fK1+gyfqdP9x
         s+Msgp+BPvpQ9aQ7wBBsGS4jzp6sTcxLAIKK853w3Q7PrrtbgcFvrvCkPXWN0tXNmcai
         FZyhciDROJcTF4i4fA+vUJzEJ6Ybn+7kRLVXKgsZETwxJ1o1pEY1EChAPj+TDF9GBxi/
         gNqA==
X-Gm-Message-State: AOUpUlFTw6My16e6q+lB+d/sUDjiBJWMolNSb9cOUAta3C7QeSIlf5Cv
        hv8ITgf5nErdTDEPBiR7Z7imaydj
X-Google-Smtp-Source: AA+uWPzfnN3gp8cid21Ki5IFPCjyx2NbmUM7ytetQ6u/BMVIyOhnfP5JDdTYK94vMvWo1smZ5jznRw==
X-Received: by 2002:a62:8d84:: with SMTP id p4-v6mr25757765pfk.251.1534288354856;
        Tue, 14 Aug 2018 16:12:34 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h24-v6sm36199332pfk.113.2018.08.14.16.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 16:12:34 -0700 (PDT)
Date:   Tue, 14 Aug 2018 16:12:32 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] partial-clone: render design doc using asciidoc
Message-ID: <20180814231232.GI142615@aiede.svl.corp.google.com>
References: <20180814222846.GG142615@aiede.svl.corp.google.com>
 <CAGZ79kYbmTXXwWO6Sy5ytOLS6=p=9gMzgbjdrSbJPkkQqsyJTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYbmTXXwWO6Sy5ytOLS6=p=9gMzgbjdrSbJPkkQqsyJTA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:
> On Tue, Aug 14, 2018 at 3:28 PM Jonathan Nieder <jrnieder@gmail.com> wrote:

>> repack in GC has been updated to not touch promisor
>> packfiles at all, and to only repack other objects.
>
> We'd need to adapt this documentation in Jonathans series?

Yes, or in a separate patch.

>> -[0] https://bugs.chromium.org/p/git/issues/detail?id=2
>> -    Chromium work item for: Partial Clone
>> +[0] https://crbug.com/git/2
>> +    Bug#2: Partial Clone
>
> This is more than a formatting fix (I did not quite check the rest,
> but this stood out), but some change to the actual content?

"git show --word-diff" tells me it's the only place that touched
wording.  If you'd like, I can send it as a separate, preparatory
patch.

Thanks,
Jonathan
