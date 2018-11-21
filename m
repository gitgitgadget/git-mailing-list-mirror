Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86C2F1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 00:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeKULLN (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 06:11:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45400 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeKULLM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 06:11:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so2765728plm.12
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 16:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zvijsnn2xt0hvbsrTAX3NclSxqKCd1LFD1njkNLcLnA=;
        b=TWDIS5GvY998ZS6dD7KBfpU+LqyZ/r+jVij9gDIDf4+NN9oaXMxZmcT5eNstqJK+2T
         0zVXeEz1ik5kLR8TI9t5xiZGRbEmoc5niOEUuQrl3H/YOXY8jVgtNIXi7RornKElac+5
         0yRUZsUh/OJtAT32loNXPCyR7hs+0sPhXqcu/VNWc9fBC2cEVo7j9HGOxTmNx0azM1YC
         vUmdEo9sLldjwscgpMq0OTeo+DsRF3u+oNtfdvvu9O8SAskfx3Tgj38t3Nq2C/hKTkvP
         mhLotTmqwlJKoDr9ceB2u/4Uzz3y9jACsdGjMu8my/p6zm5NAvJ5erPi02t96selX3ZY
         h+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zvijsnn2xt0hvbsrTAX3NclSxqKCd1LFD1njkNLcLnA=;
        b=NyETQ2YXMFj/B154C7DUy1HOyS3Tqi+jwr0b5MV8aDSCy7mf23MRXvjuR1ZRalSbT+
         9e8LRZ6Yvm+CQDWB2q7S4paoNmZPQm+xwTkWzUURuAngemNn5+Hzu+8wbJ5qlseQae6s
         yYPzJzr8/dIx6+qJmH1HoxZDtddscS888Z+PDkP1y8yrx4oEe7FTqPFopLbzX6pR9NpC
         Z01RrlJRtLx/yRaYjNUQ77G6njySpicr/izO00YW7rjnzYBAacH8iJmyNPCFtMBYn7+E
         LUK1qBQcygeqRm6nwVo5VZZwjwmvQRf2EurJQDwvw4V/2UTvM34ryiymNinrwfc0VlQP
         f0Sw==
X-Gm-Message-State: AA+aEWZU7kS4sHi0TMgzYPKPtx0popJ4152MGjy1WfRIOS88vT0Rh1U+
        8BEppYW9UVs466EBukibc8M=
X-Google-Smtp-Source: AFSGD/V75eF5F5v0TF5kr8Kolg3TbNlvOv87T8wqOnhWyyxgMQn/YUksKRv8L2bFIpm8UUiPaVdlUg==
X-Received: by 2002:a63:ea4f:: with SMTP id l15mr3899324pgk.102.1542760754707;
        Tue, 20 Nov 2018 16:39:14 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id z62sm27962073pfl.33.2018.11.20.16.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 16:39:13 -0800 (PST)
Date:   Tue, 20 Nov 2018 16:39:12 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>, jonathantanmy@google.com
Subject: Re: [PATCH 5/5] index: offer advice for unknown index extensions
Message-ID: <20181121003912.GC149929@google.com>
References: <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com>
 <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
 <20181120060920.GA144753@google.com>
 <20181120061544.GF144753@google.com>
 <87sgzwyu94.fsf@evledraar.gmail.com>
 <cabd2e37-7389-ac74-6626-629eab7da53f@gmail.com>
 <xmqqefbf9t4j.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqefbf9t4j.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:

> I am still puzzled by the insistence of 3/5 and this step that wants
> to kill the coalmine canary.  But I am even more puzzled by the
> first two steps that want to disable the two optional extensions.
>
> What's so different this time with the new optional extensions?
>
> The other early optional extensions like cache-tree or resolve-undo
> were added unconditionally and by definition appeared much earlier
> in git-core than any other Git reimplementations.  Everbody who
> recorded the fact that s/he resolved merge conflicts got REUC, and
> we would have given warning when an older Git did not understand
> these extensions [*1*].  We knudged users to more modern Git by
> preparing the old Gits to warn when there are unknown extensions,
> either by upgrading their Git themselves, or by bugging their
> toolsmiths.  Nobody complained to propose to rip the messages like
> this round.  This series has a strong smell of pushing back by the
> toolsmiths who refuse to promptly upgrade to help their users, and
> that is why I do not feel entirely happy with this series.

I acknowledge your puzzlement.  I'm not sure what to do about it.

There are a few significant differences from the REUC case:

 1. This happens whenever the index is refreshed.  REUC, as you
    mentioned, only affected resolutions of conflicted merges.  So
    users ran into it less often.

 2. I never ran into the REUC case.  If I had, I would have sent the
    same patch then.

 3. Time has passed and people's standards may have gone up.

I wish I had been around when the message was added in the first
place, so that I could have provided the same feedback about the
message then.  But I do not think that that should be held against me.
I'm describing a real user problem.

Are the commit messages unclear?  Is there some missing use case that
this version of the patch misses?

I don't *think* you intend to say "sure, you got user reports, but
(those users are wrong | those users are not real | you are not
interpreting those users correctly)", but that is what I am hearing.
On the other hand, I don't want to discourage useful review feedback,
and I think adding the advise() call was a real improvement.  I'm just
getting confused about why I am still not being heard.

Jonathan
