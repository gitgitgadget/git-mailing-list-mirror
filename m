Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5930E1F462
	for <e@80x24.org>; Fri, 24 May 2019 09:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389985AbfEXJfE (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 05:35:04 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:41727 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389841AbfEXJfE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 05:35:04 -0400
Received: by mail-wr1-f52.google.com with SMTP id u16so5372213wrn.8
        for <git@vger.kernel.org>; Fri, 24 May 2019 02:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zH/49QW70Uc2iYVB1MM4s7UXBXyvkDQ8AeY902eLSdk=;
        b=EohTf4aaSlL4FIV/e8aXwIpdLxbzjC+7g8d5aqUe2euL9gJ1kINF/i6Io4kR51yB7Z
         Ou3q9l+4W3R/xiN3Rwk2Dr3Dcn/vrMve5bml2T6uCDiqYMzqiL2Yk7sc1lkhba/RgsyC
         3PgNzwumbh/LEPBS3Z+k+Ij9I1pEPGAtfcAq32r2kV6XWmXIayFGPpOTi/YcgmqTslcu
         t1x6Bu0ZQKUxl2oz047TZ5lbL6t7vUNntpabQ0772vyaFVNlyd38Yzj8swdg1TaROuQc
         3HmfXYWXzWSDeFZUr1TpvfubxOzklRom3wNXj9EOpYR6HdKu/f01XwGo1jkhd0gDWoqb
         +yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zH/49QW70Uc2iYVB1MM4s7UXBXyvkDQ8AeY902eLSdk=;
        b=kglZ5edv8qx+AREW96vql6msJa+a6a6XexN78Ip2KT/h0l+W1//45+8KrLGabH89AO
         Mot4B0U1exTRY02JNkO9OZW85Tf2dmeWS1RPiyx2angpNwaGMlV7Tmp4Ejf6jyg2e72F
         Hdv0GFGYi8KdhzWw20T0ZPmHKlzdpjarnZ7R+Q6+bZSXqvgj7E7FtC5IMhgyULHDRu41
         zhnAIrjZDb1LcoL1PEgmBdJGSPPl7lFFWOqdlzschU7FzcFR5W+dSR3BrmhAuO+wazGX
         umswbtHUTgFUWmybIDymKeHYqAj1cbQJKmRDV4+ZB8jjsyZg0KHPFuiP2B4J9qGebSf6
         U2BQ==
X-Gm-Message-State: APjAAAWkwrRQlPnjZuLNjT5PDA4MevRccQiKQpfLbkMXbkihWUhjDSYY
        znwjaPRaNjdw4qnSxShRKZSUuCjx/cA=
X-Google-Smtp-Source: APXvYqyIZL6LUmNxk4HF1aa1TToVrUljRKE95XclsoMATaEli71rQWlibg28AgOI9jZpHM13hss1eQ==
X-Received: by 2002:adf:f7c8:: with SMTP id a8mr5211505wrq.148.1558690502191;
        Fri, 24 May 2019 02:35:02 -0700 (PDT)
Received: from szeder.dev (x4db30b59.dyn.telefonica.de. [77.179.11.89])
        by smtp.gmail.com with ESMTPSA id x6sm2554247wru.36.2019.05.24.02.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 02:35:01 -0700 (PDT)
Date:   Fri, 24 May 2019 11:34:59 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Karl Ostmo <kostmo@gmail.com>, git@vger.kernel.org
Subject: Re: standalone library/tool to query commit-graph?
Message-ID: <20190524093459.GE951@szeder.dev>
References: <CAECbv94KF9MhzZqa8BR-RL93mh0NuD3vA69pAT-sY5O74e_duQ@mail.gmail.com>
 <be719a37-ffa0-26d3-eb9c-0f5ccde52e7f@gmail.com>
 <86blztq8ap.fsf@gmail.com>
 <87tvdkg7ld.fsf@evledraar.gmail.com>
 <20190523222031.GC951@szeder.dev>
 <f05405d7-c78d-a0e4-75a1-d623f977400a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f05405d7-c78d-a0e4-75a1-d623f977400a@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 23, 2019 at 07:48:33PM -0400, Derrick Stolee wrote:
> On 5/23/2019 6:20 PM, SZEDER Gábor wrote:
> > On Thu, May 23, 2019 at 11:54:22PM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> and since the commit graph doesn't include any commits outside of
> >> packs you'd miss any loose commits.
> > 
> > No, the commit-graph includes loose commits as well.
> 
> Depends on how you build the commit-graph.

Yeah; I just didn't want to go into details, hoping that this short
reply will be enough to jog Ævar's memory to recall our earlier
discussion about this :)

