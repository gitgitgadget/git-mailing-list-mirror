Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 621051F461
	for <e@80x24.org>; Tue,  9 Jul 2019 19:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfGITpn (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 15:45:43 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43036 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfGITpn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 15:45:43 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so29663qka.10
        for <git@vger.kernel.org>; Tue, 09 Jul 2019 12:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aVThblOYfPCSDuG2X60N4AimsK194W8XDE9AlBzWeNY=;
        b=b2sRPjPLUbFUEx9VnLhEQ876WEiOieVrP5hVuxxW921sSK3E7rzXfWbU3pW7czHLoN
         /GcqR02vf9sEmctw2plIE4SswREiIujOPa9qDVuJrTlURgFgk092dYeIU63TN5QI8e4F
         ak417T1lZMHMwpuElyROyPNXzUdrgObDzCD/w2tCM9GefNRDWWRDNs9+DVJuqbcm2zNd
         rBnG/JDt7vob0JsCe3q9+SxHOLVf9IRUlS57F2GCUI6eAyGryNMG4NR3/3M8fdNNrBPu
         tcsPGPZB+Re9fW5b/phXL0A9xjAtiWfSI34qMVYcZCppuZp6bUC++ZvJXs/KaXeJ+LAO
         yXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aVThblOYfPCSDuG2X60N4AimsK194W8XDE9AlBzWeNY=;
        b=A6MvPmCVPobNWgOMkTAbfBmWTzHq7Io42FvHrd0NX9UDo33WsoNGNS0oW8vP4Hwfod
         Z9t7+YMOjAap2HG+Niuu0l/9Sdtz8JqwqpiLj+Faqo8qQo1erW5SWD9l0GwTNHi2ffIM
         rybqRjH9xdcugRZDGJpOAfeOMXSml2mFYlcKP1BN7hQvo8a+QBJbORc6Fa/OIn4Pwto2
         YxlWKS+sS+stuhC9kHCGZ0mKjdKI93cL1sLy8AGO1NejdHGMFugLHhxKuCxSYBvepqWr
         xXqpWeg/2wixeGqc1fqhgUAK8dqOsZkyOVnzTlWmxgo4ThKGEHaqR3ItP3Ajxg5cI31y
         x6Rw==
X-Gm-Message-State: APjAAAVd/psWakYqRpA48e9iz025jCO0PgJwdNq3SW/Et1zb2QqsIVcw
        0UXk2zbHCesixVJTfI0AmKg=
X-Google-Smtp-Source: APXvYqyTy8k4GlL+9QhaPjPQDLiWlRkbXKPLnOow0+8JbU7lgX9egL8UEiurf8Evdv56d/yuldHzmw==
X-Received: by 2002:a37:6844:: with SMTP id d65mr19987685qkc.398.1562701542301;
        Tue, 09 Jul 2019 12:45:42 -0700 (PDT)
Received: from [10.0.1.15] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id j78sm7128771qke.102.2019.07.09.12.45.41
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 12:45:41 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] [RFC] Create 'core.featureAdoptionRate' setting to
 update config defaults
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.254.v2.git.gitgitgadget@gmail.com>
 <pull.254.v3.git.gitgitgadget@gmail.com>
 <50955e76-8b61-8ffd-b8ee-3621ecbd912b@gmail.com>
 <xmqqo923ui7x.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <afdaaa93-8769-c859-e957-e61d27b6d5a9@gmail.com>
Date:   Tue, 9 Jul 2019 15:45:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <xmqqo923ui7x.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/9/2019 3:21 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> The other category that has been discussed already is that of "experimental
>> features that we generally think are helpful but change behavior slightly in
>> some cases".
>>
>> 	feature.experimental:
>> 		pack.useSparse = true
>> 		status.aheadBehind = false
>> 		fetch.showForcedUpdates = false
>> 		merge.directoryRenames = true
>> 		protocol.version = 2
>> 		fetch.negotiationAlgorithm = skipping
> 
> Other classes you listed I can easily support, but I have trouble
> deciding if this concept itself is bad, or merely that some/many of
> the sample knobs you listed above are not exactly appropriate.
> Either way, I have hard time swallowing this one as-is.  You may
> think aheadBehind==false is helpful, but I don't, for example, and
> there may be people for and against each of the experimental knobs.

Thanks for the specific note about aheadBehind. I'll drop that one
from consideration.

I suppose that fetch.showForcedUpdates is in the same category, and
it has a self-discovery mechanism (a warning message) for users who
feel the pain of checking for forced updates (i.e. it takes >10s).

> But there may be a clear set of "this is agreed to be the way to the
> future, but the implementation currently is too convoluted and
> suspected of bugs, so we'll let early adoptors opt into the feature,
> and when that happens, eventually this knob will go away (i.e. you
> won't be able to turn it off)" type of knobs.  Or it may change the
> behaviour drastically, but as long as it is agreed that the future
> lies in that direction, I think it is OK to throw such a knob into
> this class.  The key points are (1) we are committed that in the
> future everybody will be forced to have it and (2) it is not merely
> "we generally think", but "the decision about the future has been
> made---there won't be any other way".  The feature.experimental
> becomes merely a way to let early adoptors in.  If you limit the
> individual features governed by feature.experimental to that kind of
> knobs, I can be easily convinced that this class is a good idea.

From this list, do you think any of these settings are likely to
become defaults? It seems that protocol.version = 2 may be a default
now that _most_ services have an implementation, and it always falls
back to protocol v1 without extra cost.

When pack.useSparse was first introduced, I considered making it true
by default after a while. But you protested, saying you want people
knocking at the door saying it is useful. What if it lived here?

fetch.negotiationAlgorithm and merge.directoryRenames seem like
valuable features and maybe just need more time out in the world
before they could be considered defaults.

I appreciate all of the feedback, and to drive the discussion forward
I'm trying to tease out very specific opinions.

Thanks,
-Stolee
