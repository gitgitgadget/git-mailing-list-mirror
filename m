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
	by dcvr.yhbt.net (Postfix) with ESMTP id F21E21F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 00:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeKULQZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 06:16:25 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38883 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeKULQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 06:16:25 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so2796388plb.5
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 16:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/mmzroa5Ave9akNb/1NrQSwBmVW49AzCgg5q+YCql0E=;
        b=N8G1VneQ+CQN2NuPCwd509ayG56lp8HvmsbyellMrKi/4w5knOot6IrXkyVCFeNNrO
         XVie5yzA9FagBj2TPQOBXRd0TWUolt8pkxrtWuMH8k5vBqanW/ME60xreFgFF0Zr52bU
         +xFzf52Y5rzGF/1Tw7x35v6eqg5LB255lfuwgVshjHIMPA4iLQMEt6jp/TxB2VVMoyDK
         WOSBckc83OlnYYj4dT4zPyutWLw/9llBLtLAKeiKOuQ+CCZ8jB36lt6F5oT7cBrSfy+h
         Byt7Cw6GHHbKujOQ2pFNRj/4taw1H/4gxYSaNUQcfi8Sa6NIqWTLHN2CGQl14qhrzGd1
         J6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/mmzroa5Ave9akNb/1NrQSwBmVW49AzCgg5q+YCql0E=;
        b=Yz1K95ZAxVyTszIj522/CbLmxXznpdOGF92mFHgniKiFwlm15xksqZ2pF39FCcg/MB
         +GbWa9ngo2fzIjAbWzGi87GqE4t8Om/Nxj4xV3yiHLpf/bI2U6OzGo7KNjj/K4AgUq+X
         6aR/eFzEQ3VuQkuIxRf6DXRGnJrG1E9e/jrF5s2zIuq7LR2c6czMmRdEq53dl6CUSq8W
         ZZm2JizjYkR/DRTK3skjIb91Vhqx8zuNlWfcQ45wv6HfHzbg45OoyRnsRkTMWSDsV7Q7
         m7EAQzftP0aJvawNv/1D8v1YHI+sWdw9IZhLWjuhRSVHYVbtiHtvbYPEgUz1l9wZ1Kkv
         iFPg==
X-Gm-Message-State: AA+aEWbUiXHYzh0ely2uQ/gm2VhXSjiRO8ljInsVJs3r2uWDRNSq7xGZ
        l0xe9gRglXPe+GSsHA4VrQI=
X-Google-Smtp-Source: AFSGD/UIOp/j1OWY2BB5JNp/EUfsxcrk3MX+yTpLQSMHjeyLfi4k+FoE/OGiWYntnZTOqR9AVzFjTQ==
X-Received: by 2002:a63:955a:: with SMTP id t26mr3995160pgn.449.1542761065729;
        Tue, 20 Nov 2018 16:44:25 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id s2-v6sm94620282pfk.133.2018.11.20.16.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 16:44:25 -0800 (PST)
Date:   Tue, 20 Nov 2018 16:44:23 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>, jonathantanmy@google.com
Subject: Re: [PATCH 5/5] index: offer advice for unknown index extensions
Message-ID: <20181121004423.GD149929@google.com>
References: <20181113003817.GA170017@google.com>
 <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
 <20181120060920.GA144753@google.com>
 <20181120061544.GF144753@google.com>
 <87sgzwyu94.fsf@evledraar.gmail.com>
 <cabd2e37-7389-ac74-6626-629eab7da53f@gmail.com>
 <xmqqefbf9t4j.fsf@gitster-ct.c.googlers.com>
 <20181121003912.GC149929@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121003912.GC149929@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

onathan Nieder wrote:
> Junio C Hamano wrote:

>> I am still puzzled by the insistence of 3/5 and this step that wants
>> to kill the coalmine canary.  But I am even more puzzled by the
>> first two steps that want to disable the two optional extensions.
[...]
> I acknowledge your puzzlement.  I'm not sure what to do about it.
>
> There are a few significant differences from the REUC case:
>
>  1. This happens whenever the index is refreshed.  REUC, as you
>     mentioned, only affected resolutions of conflicted merges.  So
>     users ran into it less often.
>
>  2. I never ran into the REUC case.  If I had, I would have sent the
>     same patch then.
>
>  3. Time has passed and people's standards may have gone up.
>
> I wish I had been around when the message was added in the first
> place, so that I could have provided the same feedback about the
> message then.  But I do not think that that should be held against me.
> I'm describing a real user problem.

And to be clear, it is the first two patches that address the
immediate user problem.  Whatever improvements we make to the warning
message today, we cannot retroactively change the other versions of
Git that users are using that want to access the same repository.

Jonathan
