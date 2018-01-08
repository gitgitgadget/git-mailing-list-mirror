Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0B311F406
	for <e@80x24.org>; Mon,  8 Jan 2018 11:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756191AbeAHLn3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 06:43:29 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:42857 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756014AbeAHLn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 06:43:28 -0500
Received: by mail-wm0-f41.google.com with SMTP id b141so13627924wme.1
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 03:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=fvoVwI68ESCY36fq4lbOlSHNNJtbMbnPfalglFAXsT8=;
        b=lTU3Tf3d9zAhW5dsT7LDasGdsNHQlX54Nw909cjhNAw6A9VQRwGKLHl4mLISrZ7mUl
         ao5IG6nk0zLAU80Kn5nrCF6WetIjtScHnYzucwoepk2YilFnuoo4crNv/xhrgpcrUm6I
         bTsqKXUcUc9q13Uw74vX2Nkp99h5kSK8EfzAOTsJPfKSogdKa0DnbeZjrifHv7fuI6qs
         H86Fr/P5ABaUqtu2BJlPwGIGEkmJ3+x3x4w9ocLHBDszIgiQ449c57jFiPtVPfK7lUcc
         NSfANobASjA2rJcoCJqtqZ1pfIAnaZXeETvz1lTsuhvVR+28lRaqF9lCrIfx2EcG1fCm
         C5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=fvoVwI68ESCY36fq4lbOlSHNNJtbMbnPfalglFAXsT8=;
        b=sT18IB3XyWAL5oPDVz7ePeXg23V6BOazg0ijQbdjwR+nbB9E/+dy07L9vdnUfdHBmR
         bGyPTZp9r5dVbMLdc4adlC6OJ/TVUH89JM8JWP87Ss6ecSjLOapySGp0HGGieiQ6FvGm
         T4YkXXqYf8fRYwQ6J+YdV2oi/quRlRfFPWeLO4mp4HMcJnMznNZsnB3j/kVsSqH27Rhm
         gbe0Pb5EuMEWXRPNu4w9/xNGysDE4Q6QVDJVWwffHtPr+/HfzcFEVipCkHcZ71g0ZwW5
         sdb24Qk9HWwUyaZNtHm2mj9m3UeokqXIB4YSdWEWK3aVJBwRfSXS7EmRWWA5em6M07IT
         FImw==
X-Gm-Message-State: AKGB3mIslrOQMMzihp2I5/o5K9M8Zfpg2EDEei5qdw/3hlRBtrYe+ALT
        n+ezy+ghA547rEbkb6J1AK5tN2Og
X-Google-Smtp-Source: ACJfBouyIf4/AaQVqyxQ9ry5bE+Bx+8EEp5maPKNF2QC+oVaUn/CFRBSIvXmo2XEdlc1A3/cDUsa1A==
X-Received: by 10.80.145.173 with SMTP id g42mr16229364eda.156.1515411807023;
        Mon, 08 Jan 2018 03:43:27 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id 4sm6474076edf.81.2018.01.08.03.43.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jan 2018 03:43:25 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, johannes.schindelin@gmx.de,
        jrnieder@gmail.com
Subject: Re: [RFC PATCH 00/18] Multi-pack index (MIDX)
References: <20180107181459.222909-1-dstolee@microsoft.com> <87k1wtb8a4.fsf@evledraar.gmail.com> <c08416f1-bbec-2037-34a6-f454d85de439@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <c08416f1-bbec-2037-34a6-f454d85de439@gmail.com>
Date:   Mon, 08 Jan 2018 12:43:25 +0100
Message-ID: <87fu7gbmoy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 08 2018, Derrick Stolee jotted:

> On 1/7/2018 5:42 PM, Ævar Arnfjörð Bjarmason wrote:
>> If something cares about both throughput and e.g. is saving the
>> abbreviated SHA-1s isn't it better off picking some arbitrary size
>> (e.g. --abbrev=20), after all the default abbreviation is going to show
>> something as small as possible, which may soon become ambigous after the
>> next commit.
>
> Unfortunately, with the way the abbreviation algorithms work, using
> --abbrev=20 will have similar performance problems because you still
> need to inspect all packfiles to ensure there isn't a collision in the
> first 20 hex characters.

I meant (but forgot to write) that this would be some new mode,
e.g. --abbrev=20 --no-abbrev-check which would just perform a substr()
of the 40 character SHA-1. It might be interesting to add that for
reasons completely unrelated to your series.

Thanks for answering the rest.
