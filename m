Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CF721F731
	for <e@80x24.org>; Fri,  2 Aug 2019 22:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732085AbfHBWTD (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 18:19:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40376 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfHBWTD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 18:19:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so36686447pfp.7
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 15:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8/OBnVJjXZfQa1SIxruCSfZPhnHs6H6fOSrkeEH9czY=;
        b=VB2P6+Mlg6bkTLEUfta/OL8bMOmUf1T/I/E0VK72RhR40r9nBlHBcxl429CNC4BLJU
         a5YU6iywRC2gXRScU7strIXBfQNmKgl9XQrN0VZHJydS/Hguwkg5AkgmSH2SQDARt+/n
         MZy4IuGm9pdWbO2r1/Yfc64ZnuvRrnuM/0BxRkD5Q05ZEKfzGDDMe8791seqwx0dWb1Z
         2Ue/BSBtixX1eg01q/pTX6ntLZR1QiQQTefJmTXfGntFBdXOZ5gwBe78pNxZO0nGE5nm
         2ECyiEh4+j5KvKG2PMmHlkD3Mgm1JIjdQDlqk1cmifqkqjztJf0P0G+JcDEzY+2u19q4
         S7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8/OBnVJjXZfQa1SIxruCSfZPhnHs6H6fOSrkeEH9czY=;
        b=OK+G5s7U5G7xnGlejmPOmFIq3qQ1oK5oq3Zr30ZZ8NkMm/QrKSikGdmvGsBV74St2X
         KyO8hTjaiRHhU1/xDbG7HUpCyJFMnO/NIphO4MzEmJywyM8M5QaUuSFEGL+/9sn10/L1
         FVXocimqif62Io423VcaXqbTE2CoMUQ/Aj0iH5dnteLse3KSYvmqJAa5wN6uSpGl4Jh6
         pZXc3AuTeUkYdDnUfhYsYv00KhDhe9ailC8v2mMVE5SnR9pnu8pBmWhi2SAbbbdjZlaT
         sneLrI09C9hbzY0D+Azbq5EF5CEICHaSQSFaOWSlQMYhRftwM9bpYXlZvU9754oIOfGa
         dsUQ==
X-Gm-Message-State: APjAAAXb9jUX4OHRTLq/QL4JPKfMHlri+zqH1i0JR31MDLft7z6oL6ue
        8LP4mGcwGb4LEuXWNzOLCJfTmw==
X-Google-Smtp-Source: APXvYqzYi83/RunDXC28JePU+UVrAIhgBXwi6Tej5SC0UX7Vn4dgHc6uLmZtHo5zXKDLnJSRmL56Vg==
X-Received: by 2002:a63:5162:: with SMTP id r34mr8822327pgl.229.1564784342086;
        Fri, 02 Aug 2019 15:19:02 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id p19sm86368627pfn.99.2019.08.02.15.19.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 15:19:01 -0700 (PDT)
Date:   Fri, 2 Aug 2019 15:18:55 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH v3 0/4] pre-merge-commit hook
Message-ID: <20190802221855.GR43313@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>
References: <cover.1564695892.git.steadmon@google.com>
 <cover.1564737003.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1564737003.git.martin.agren@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.08.02 11:56, Martin Ågren wrote:
> [Dropped cc-list the first time around. Apologies to those who receive
> this twice...]
> 
> On Fri, 2 Aug 2019 at 00:20, Josh Steadmon <steadmon@google.com> wrote:
> >
> > This series adds a new pre-merge-commit hook, similar in usage to
> > pre-commit. It also improves hook testing in t7503, by verifying that
> > the correct hooks are run or bypassed as expected.
> 
> I really like those test improvements. Now it should be harder to mess
> up a future refactoring and run the wrong hook. These hooks are "very
> related" so I think this is important.
> 
> I've messed with the test a bit and offer these potential improvements
> for your consideration. I was lazy and just built this on top of your
> series -- if you agree to some or all of these, you'll probably need to
> squash them into a few individual patches.
> 
> The first four are perhaps more or less a matter of opinion, although I
> do think that patch 2/5 is based on an opinion shared by others. ;-)
> Patch 5/5 or something like it seems pretty important to me to make
> sure that of these two "similar"/"related" hooks with some
> "backwards-compatibility-and-code-copying-history" around them, we'd
> better pick the right one when they're both available.
>  
> Feel free to pick and squash as you see fit. (I don't think it makes
> sense to have these go in as-are. They really are meant for squashing.)
> 
> Martin
> 
> Martin Ågren (5):
>   t7503: use "&&" in "test_when_finished" rather than ";"
>   t7503: avoid touch when mtime doesn't matter
>   t7503: simplify file-juggling
>   t7503: don't create "actual_hooks" for later appending
>   t7503: test failing merge with both hooks available
> 
>  ...3-pre-commit-and-pre-merge-commit-hooks.sh | 84 +++++++++++--------
>  1 file changed, 50 insertions(+), 34 deletions(-)
> 
> -- 
> 2.23.0.rc0.30.g51cf315870

These all look good to me, thank you for the suggestions! I'll include
them in V4.
