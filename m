Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 331BE1F597
	for <e@80x24.org>; Sun,  5 Aug 2018 23:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbeHFBJD (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 21:09:03 -0400
Received: from mail-pl0-f49.google.com ([209.85.160.49]:35264 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbeHFBJC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 21:09:02 -0400
Received: by mail-pl0-f49.google.com with SMTP id w3-v6so4817868plq.2
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 16:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/RJYLORyHH5d6FRU19YurRgpTDyWu8Jgzbm7Z3qD3Lo=;
        b=cZ2ORRyOnvwgX1SESuIB2cr55oFiXm9ut/q7jCM11K8TI2UKXg5RCbNVUe9vhPQHVE
         jeSEsNpopdqULxAagD8dzOyZgOrQlO2MbfC3p2syjB72MxYnSRLuNt0CbzihMS9TDsF7
         M6TkpkKmIT3I+TtdBxSCz1n3DbZSZu+c9jBL6QhBf+vCbFWErEkBRW35cjEk5moxPlBX
         0AAPpfH+3RipFkQGEHl+c5ALIeMseKgWTekc8SONG6CyJYX23AuqhhHZKgsES2/P6O+t
         66UomfBBb1o5nXvg+D1LspjCtjSCJQZ6wgnhY2taMrU7pxe7vCifqmqoKrIgVsWRQlyl
         w8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/RJYLORyHH5d6FRU19YurRgpTDyWu8Jgzbm7Z3qD3Lo=;
        b=Dz2lgb/SEHRj3cs1m7TEfEQq8lU+Acv/9j5fWjCDteY4Jpbelm2U6srHhUGQZ9WFbX
         Vh8B79+0dKfZdcGz7IFC1UVGtv/wea5xUScBPg6WoNvhzM4ihhSvP1EZVi6g1VWW4Nps
         /wAa/HJqP3djE7x8Wetp9pfHBc+Y4vW4e79xXyVL5g4h6w59qZS04fBNTH+JziY1Weud
         GyHaHncQ/I2iMNVxQEWbthibTsD0aZ5zFSNgwBzXkYx7o8BAQg6t7WtUN1QlNIYwnCj9
         552D2t3wb+md8ADp3GUzXqGdyxlppdlbnQ//RoWpESxyduLCqXvQJu8E8FWg05eHs0wA
         AtOg==
X-Gm-Message-State: AOUpUlHp5sFYMYq8Qm0Ul1kj94lWeDfQulBFUSXDyO4aDjAMcsrPw3L+
        Z4LY71ieZ50Bm9XuQEVLhZM=
X-Google-Smtp-Source: AAOMgpcCbpFGXRoxTyP9EDu6U7N/iXihCoTX2C0AadkIpquoyHl2hDhHUybAPEO02Rj07GObKuq1hQ==
X-Received: by 2002:a17:902:2e01:: with SMTP id q1-v6mr11783703plb.40.1533510167337;
        Sun, 05 Aug 2018 16:02:47 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v71-v6sm13382935pgd.56.2018.08.05.16.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Aug 2018 16:02:46 -0700 (PDT)
Date:   Sun, 5 Aug 2018 16:02:45 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PoC] coccinelle: make Coccinelle-related make targets more
 fine-grained
Message-ID: <20180805230245.GB208811@aiede.svl.corp.google.com>
References: <20180723135100.24288-1-szeder.dev@gmail.com>
 <20180802115522.16107-1-szeder.dev@gmail.com>
 <20180802180155.GD15984@sigill.intra.peff.net>
 <20180802183145.GA23690@sigill.intra.peff.net>
 <20180803062144.GB237521@aiede.svl.corp.google.com>
 <20180803130824.GC4671@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803130824.GC4671@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Thu, Aug 02, 2018 at 11:21:44PM -0700, Jonathan Nieder wrote:
>> Jeff King wrote:

>>> I guess you could even replace "COCCI_COMBINED" with "COCCI_PATCH" in
>>> most of the targets, and that would let people do individual:
>>>
>>>   make COCCI_PATCH=contrib/coccinelle/foo.cocci coccicheck
>>
>> The issue here is that the dependencies for foo.cocci become
>> unreliable, so I'd rather have a separate target for that (e.g.
>> depending on FORCE) if we go that way.
>
> Can you be more specific? I don't see how it's unreliable, unless you
> mean that anything relying on "coccicheck" would depend on the exact
> value of COCCI_PATCH.

Yes, that's what I mean: changing which COCCI_PATCH to try would need
to trigger re-runs.

> But it may all be moot anyway, based no the responses elsewhere in the
> thread.

Sure.

Thanks,
Jonathan
