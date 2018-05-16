Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BECB41F406
	for <e@80x24.org>; Wed, 16 May 2018 15:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750786AbeEPPtk (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 11:49:40 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35478 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbeEPPtj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 11:49:39 -0400
Received: by mail-it0-f65.google.com with SMTP id q72-v6so3198029itc.0
        for <git@vger.kernel.org>; Wed, 16 May 2018 08:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WsXSLFa8owQe+6jQMJrVU87xtVBxn6jAd8FbkrfCbxc=;
        b=VK2dZbOXxddTtAvzsf242tDbL4JtZgSm+WuU9sqzNuzB8Dm27uMY2tdhJJ6tIYKPs5
         AAcqiwCqMmRuWJoYJOpfZUNI1grFd6URsRiUrfUO+IF2+1CVyqBmPLxEuFFel0voTxyL
         OKmcHZR191DnWT4PPRSidnU5VxL8uKQBg0Uu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WsXSLFa8owQe+6jQMJrVU87xtVBxn6jAd8FbkrfCbxc=;
        b=pWY+OYm0VxVf0fDXKK3sdBdMwkZcHEqSAWr/LFzre4fqx0tndP9xG1+ZxgL5uAfLi4
         AE/C5MrnZWmx+2WhLDeGMVaa2JCOFPG2NEpRPQZndVEoErpW8/xJOfGcHj2ASH8LrwUJ
         BUHcU8ZPQYVbEOBPRW3dwLlYJSrbY+xViGyNvKOuK8xWu1y1E56Eg/lUGSbSob0hjXDj
         k25m5aKtOHRQZmmZ1bnCHHExakQn6eajdNxCUgNdpiQf8RQnY7uJvBjycY7wQk5OYL0z
         ZmGEELmNa5j0phH+ArTIjGXUqTBhSYYOopxJVKJaOU5GpwORS6rcKaT3nMSXhj812TK5
         bH1w==
X-Gm-Message-State: ALKqPwdrkodMmhUZjyx9IfeSBSEOHzgBBIz5NuCnNME2xTpiucl9os0U
        13xa2hj7981td3pLRy0zfYmlUA==
X-Google-Smtp-Source: AB8JxZripUaMtYXLoxGwgFN2WUbsRBJzFLBvNY2Z5GHd3TTYo1fYSJsOlwPQ0Tms8pYq98D5mTN3nw==
X-Received: by 2002:a6b:a5d:: with SMTP id u90-v6mr1792428ioi.152.1526485779263;
        Wed, 16 May 2018 08:49:39 -0700 (PDT)
Received: from chatter (ca2x.mullvad.net. [162.219.176.251])
        by smtp.gmail.com with ESMTPSA id m89-v6sm1629967iod.1.2018.05.16.08.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 08:49:38 -0700 (PDT)
Date:   Wed, 16 May 2018 11:49:35 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: worktrees vs. alternates
Message-ID: <20180516154935.GA9712@chatter>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <87po1waqyc.fsf@evledraar.gmail.com>
 <81B00B00-00F4-487A-9D3E-6B7514098B29@gmail.com>
 <87muwzc2kv.fsf@evledraar.gmail.com>
 <fc2f1fdf-222f-aaee-9d58-aae8692920f5@gmail.com>
 <0f19f9f8-d215-622e-5090-1341c013babc@linuxfoundation.org>
 <87k1s3bomt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k1s3bomt.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 16, 2018 at 05:34:34PM +0200, Ævar Arnfjörð Bjarmason wrote:
>I may have missed some edge case, but I believe this entire workaround
>isn't needed if you guarantee that the parent repo doesn't contain any
>objects that will get un-referenced.

You can't guarantee that, because the parent repo can have its history
rewritten either via a forced push, or via a rebase. Obviously, this
won't happen in something like torvalds/linux.git, which is why it's
pretty safe to alternate off of that repo for us, but codeaurora.org
repos aren't always strictly-ff (e.g. because they may rebase themselves
based on what is in upstream AOSP repos) -- so objects in them may
become unreferenced and pruned away, corrupting any repos using them for
alternates.

>> I'm very interested in GVFS, because it would certainly make my life
>> easier maintaining source.codeaurora.org, which is many thousands of
>> repos that are mostly forks of the same stuff. However, GVFS appears to
>> only exist for Windows (hint-hint, nudge-nudge). :)
>
>This should make you happy:
>
>https://arstechnica.com/gadgets/2017/11/microsoft-and-github-team-up-to-take-git-virtual-file-system-to-macos-linux/
>
>But I don't know what the current status is or where it can be followed.

Very good to know, thanks!

-K
