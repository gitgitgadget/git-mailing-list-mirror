Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 988C71F404
	for <e@80x24.org>; Tue, 27 Feb 2018 18:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbeB0Szy (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 13:55:54 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53539 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeB0Szx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 13:55:53 -0500
Received: by mail-wm0-f66.google.com with SMTP id t74so543213wme.3
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 10:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pQ4kIZZ6+rWgqgTCXhahKfWvPAdsJXuUOC7VBOhZfXg=;
        b=PGudnZ93/EBPpr8+5JH3IcIEzZVx0uOmFdaVQ6Y/dRh4P+1e4jhnhrgkzUjs46NT/0
         Kv1IZGwI0/nnk5mfA4oAZf1M5kLYPyepe9IW6dYdkOfX9klcNQySfLtiSmDXMz6mB1nG
         dzcEgxtQy0nFaAdcqNuVrzpn0Wxy0MFU94KeufQod8vljLpOAb9unPekSwHIJrmsISjS
         +59LnvPNPOVWGaiQ5/py3jQDGGl7jiq5PiTGq3YFWWDzsMr2e2eM8m0lAvQygztEkyLe
         fms4krG+LJqzULhv2zlbF8+HW3xVmiAqUHwS0G7qApQHMktId6NBznRTELkFFUwYNEd/
         wdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pQ4kIZZ6+rWgqgTCXhahKfWvPAdsJXuUOC7VBOhZfXg=;
        b=P8VzT/QVUX3tXhcXfc4s6X460L4pAU0rvKqRPUg9QdOThDJ3/94qtq354pW4HPWQEY
         nPOTGgf9Luw9bLxrMrpW7EMzUCrYBn7JVp8G+bQfkm9g8jcPAww858XXUKC7JCqQE8Ww
         mnPFl5hr0pERbAf5+YoyLDghPRxt8/jlB62mHKZc3KP+kraI1Qa6IzRX2lkOGCxYre90
         w8FwEMsBy4KYbGzO0cm6oN3XsuH8M7HJedPBdOiQTIEhixzJ1K5CtE2mlpEW9hIh4VWG
         +/s2gXjHlO5aUk7Y9Myx6GJRLiTKBfE7l9hc4D3qwmcmyg2DEuVxhJCNGHelZOHRwx74
         vjwA==
X-Gm-Message-State: APf1xPDPKVp5xA1nQJi2UaITkX/lV0mS8C67UzSnryDupgsumn9Q2HPJ
        qWe7m/RLdEeoJZYVKzPq82U=
X-Google-Smtp-Source: AH8x227bFL65e5ptnWkbvDufLo0Mv9KzHm98LQb5V6EbhTREiTIcCUY14gNeFEBb4u72NtFd3PIrmQ==
X-Received: by 10.28.106.18 with SMTP id f18mr12118038wmc.51.1519757752193;
        Tue, 27 Feb 2018 10:55:52 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id b185sm218637wmb.24.2018.02.27.10.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2018 10:55:51 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
Date:   Tue, 27 Feb 2018 19:55:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 27/02/2018 17:21, Johannes Schindelin wrote:
> 
> Do you have any way to describe the idea in a simple, 3-5 lines long 
> paragraph?
> 
> So far, I just know that it is some sort of confusing criss-cross 
> cherry-picking and merging and stuff, but nothing in those steps
> shouts out to me what the *idea* is.
> 
> If it would be something like "recreate the old merge, with merge 
> conflicts and all, then generate the diff to the actual tree of the
> merge commit, then apply that to the newly-generated merge", I would
> understand.

It would be more along the lines of "(1) rebase old merge commit parents, 
(2) generate separate diff between old merge commit and each of its 
parents, (3) apply each diff to their corresponding newly rebased 
parent respectively (as a temporary commit, one per rebased parent), 
(4) merge these temporary commits to generate 'rebased' merge commit, 
(5) drop temporary commits, recording their parents as parents of 
'rebased' merge commit (instead of dropped temporary commits)".

Implementation wise, steps (2) and (3) could also be done by simply 
copying old merge commit _snapshot_ on top of each of its parents as 
a temporary, non-merge commit, then rebasing (cherry-picking) these 
temporary commits on top of their rebased parent commits to produce 
rebased temporary commits (to be merged for generating 'rebased' 
merge commit in step (4)).

Regards, Buga
