Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B7CF1F453
	for <e@80x24.org>; Mon,  1 Oct 2018 15:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbeJAVoc (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 17:44:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55565 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbeJAVoc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 17:44:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id 206-v6so9170066wmb.5
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 08:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=smKsQfX/dzHjxtvgWv4JELuZRXS/iEwfljutPGZvJQk=;
        b=gOkdRVCpRNRZG3k0o/EF1zOCrvPfI5DCyWEjATEzUFqQrIvf0543GEIgaIx3WtPr6P
         CPN2IfsQXLnT1Rik8OOwWOQOV1Sg/xlLCHUi73YJQV6aw/kjOLfiJUTa2rmz7d5UM6Qe
         3opQ1QNtHvvkJeeq8by0AP8GnmlUMIR+u98VYT7iIAk18LHeZluYXeXWT6TLt5ynZdI+
         NzF4ibYhva8cCnAHiarXNcYzET2Zlq5dO7KgcPrHkAu7wS/ek2Tm9PCRH4wB2fsV3kA2
         4dHL2pXi/pxSCJJbg8mAn+xqmG4hhf8UE2JSGNsnAjcfrX76dVRYajAe8u01GUS67FCW
         JPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=smKsQfX/dzHjxtvgWv4JELuZRXS/iEwfljutPGZvJQk=;
        b=Hqw2yA6CF+68bD9xQXMx+zwQrRz9k28TRpzbDATw2aeU0k5fXsw07kTDfaeXcjVoxd
         e6YdUqGbh56LhfAYVvBPg660uojecNl/UreLFaqm4VWPg2u0Z/zjw2SOuLD/PNHkZUUG
         eqouGGpZEo3Cn8V6R+JaW07fSFiJWdNR44Ltupif6fdyn24ayUS+h4I60uVzp0MrsPub
         xOVbiC/9+bdZAPFBYlPw0zHv57dv2Vmj0UHxt/NB5Xktsw4qC18+vyYQ7zlfEMESETQv
         a4RBb5lCtPpeRQ7RFJF1ZWMMzzefAUUO1Xyv8GNEBxaGtpCzi6ryAs6FB2bamg9+3x04
         gt9A==
X-Gm-Message-State: ABuFfogZ0pnxHRHHow6FrxAudL9grGXffCVj2UccSKjEqoCejaU6B7oZ
        8kf8Iobuf49jvxWj43KHXR8=
X-Google-Smtp-Source: ACcGV638KBVnMH4q94V8ZdgahRq4V06NuRMKlrIXDiWYVMQVqbu0TUyhrgHmTFu39gbLwz7nT7lQzA==
X-Received: by 2002:a1c:48d:: with SMTP id 135-v6mr8967142wme.102.1538406376702;
        Mon, 01 Oct 2018 08:06:16 -0700 (PDT)
Received: from localhost (x4db10555.dyn.telefonica.de. [77.177.5.85])
        by smtp.gmail.com with ESMTPSA id z16-v6sm8531292wrq.78.2018.10.01.08.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 08:06:15 -0700 (PDT)
Date:   Mon, 1 Oct 2018 17:06:13 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v6 4/7] config: add new index.threads config setting
Message-ID: <20181001150613.GK23446@localhost>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180926195442.1380-1-benpeart@microsoft.com>
 <20180926195442.1380-5-benpeart@microsoft.com>
 <20180928002627.GO27036@localhost>
 <cbc48a95-62f5-a098-fb70-97b6cf241920@gmail.com>
 <xmqqsh1tczyz.fsf@gitster-ct.c.googlers.com>
 <a58a5cce-b3c2-62a2-598b-6b7dbe1a86fc@gmail.com>
 <bf0c24ac-6e2a-9a3e-835f-f21e763ab2c7@ramsayjones.plus.com>
 <xmqqo9ch9slw.fsf@gitster-ct.c.googlers.com>
 <48d6e62f-bf44-ffa1-befb-fef33ad00411@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48d6e62f-bf44-ffa1-befb-fef33ad00411@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 01, 2018 at 09:17:53AM -0400, Ben Peart wrote:
> 
> 
> On 9/28/2018 6:15 PM, Junio C Hamano wrote:
> >Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> >
> >>>                 if (!nr) {
> >>>                         ieot_blocks = istate->cache_nr / THREAD_COST;
> >>>-                       if (ieot_blocks < 1)
> >>>-                               ieot_blocks = 1;
> >>>                         cpus = online_cpus();
> >>>                         if (ieot_blocks > cpus - 1)
> >>>                                 ieot_blocks = cpus - 1;
> >>
> >>So, am I reading this correctly - you need cpus > 2 before an
> >>IEOT extension block is written out?
> >>
> >>OK.
> >
> >Why should we be even calling online_cpus() in this codepath to
> >write the index in a single thread to begin with?
> >
> >The number of cpus that readers would use to read this index file
> >has nothing to do with the number of cpus available to this
> >particular writer process.
> >
> 
> As I mentioned in my other reply, this is optimizing for the most common
> case where the index is read from the same machine that wrote it and the
> user is taking the default settings (ie index.threads=true).

I think this is a reasonable assumption to make, but it should be
mentioned in the relevant commit message.  Alas, as far as I can tell,
not a single commit message has been updated in v7.

> Aligning the number of blocks to the number of threads that will be
> processing them avoids situations where one thread may have up to double the
> work to do as the other threads (for example, if there were 3 blocks to be
> processed by 2 threads).
