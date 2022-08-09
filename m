Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248CBC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 13:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243109AbiHINhP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 09:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbiHINhN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 09:37:13 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE4C193FB
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 06:37:13 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id d4so6498676ilc.8
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 06:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=j4Z427XwIR49ZMII5U/0yr75J2vG6EfI45uojPBV6uc=;
        b=clFDUZPJQchC71RsmW1zyT/rKInUKeryuizhzOPl7/94JuHxKypZwihSoJ2MK+G2Mg
         g3tKhHG0yJGqRj8uLTbZAgpXJKwkoSJdlWy7Neo+OaqrZS6eT0cquZZAvMF9/WipUHbY
         ArSTLan6ZxrxBGFSL1Nb2ZHKPfcuaCU49Or73k2ZMsF0XX8vSteNa0E7VHTH3uKDuIOf
         NnviuM2+fboOKwNMcHTFU2lg/cilR5Pgr/kNpJdaOUl2Km4xur7KiIRsBCBIAwnhyDpX
         TGoDAC8upfJQ1Sg+QkIMqFafA2id1mXj82n1jQbOQGVyPWJXJYLYcvJTsEbgzDsDVUSS
         bvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=j4Z427XwIR49ZMII5U/0yr75J2vG6EfI45uojPBV6uc=;
        b=OdBzr4PNGNQ9naj9bUNK4cBxePRl+XI4p7w5qg49ssU/8FjXIc2TABQfpEo7HadkBq
         plH7IOvR6y8PWq6AHsu/8JMSokdYvV97Ps1JPzxvSbi/u9IglYhBC4eEoIYvyWvxec2A
         VGxKPVyemxLH0tQNkBNP/Rd409RC5COuv2E/6T3VmXBLyl7YYcXRM+ygyAcX5x9H6lTl
         fZVT3p4GgjuMw8hYz/6Dzub2LpXJX18k/Y24Ncz4MN2wKgNhSeHi/hsTOapP365f/pTi
         56dLe14q8svUSUYE4FH0wwlQdMfktN5jCZuYhadED/vrZrcOTffJJ2Tvym46XhwFHWVJ
         aKsA==
X-Gm-Message-State: ACgBeo2QJUauCrtjacSSshQrxHBDsid2nxM06cd1bRBdcYQJ34LRiAUY
        9khRy54KmCa55LvUmj7QCjwo
X-Google-Smtp-Source: AA6agR5WoGk1rfQJpDORewpfKjRwq5W1PS/plpKvXx0OXSLdsDj5RyDm5H4mlDihaitK3n1N077arA==
X-Received: by 2002:a92:b70a:0:b0:2df:a891:249c with SMTP id k10-20020a92b70a000000b002dfa891249cmr7572696ili.204.1660052232420;
        Tue, 09 Aug 2022 06:37:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:14e1:3e6e:802:8594? ([2600:1700:e72:80a0:14e1:3e6e:802:8594])
        by smtp.gmail.com with ESMTPSA id y9-20020a056638228900b00341668383cfsm6384395jas.33.2022.08.09.06.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 06:37:12 -0700 (PDT)
Message-ID: <46ca40a9-2d9a-3c7c-3272-938003f4967a@github.com>
Date:   Tue, 9 Aug 2022 09:37:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] [RFC] list-objects-filter: introduce new filter
 sparse:buffer=<spec>
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.1316.git.1659958159193.gitgitgadget@gmail.com>
 <xmqqczdau2yd.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqczdau2yd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/8/2022 12:15 PM, Junio C Hamano wrote:
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: ZheNing Hu <adlternative@gmail.com>
>>
>> Although we already had a `--filter=sparse:oid=<oid>` which
>> can used to clone a repository with limited objects which meet
>> filter rules in the file corresponding to the <oid> on the git
>> server. But it can only read filter rules which have been record
>> in the git server before.
> 
> Was the reason why we have "we limit to an object we already have"
> restriction because we didn't want to blindly use a piece of
> uncontrolled arbigrary end-user data here?  Just wondering.

One of the ideas here was to limit the opportunity of sending an
arbitrary set of data over the Git protocol and avoid exactly the
scenario you mention.

Another was that it is incredibly expensive to compute the set of
reachable objects within an arbitrary sparse-checkout definition,
since it requires walking trees (bitmaps do not help here). This
is why (to my knowledge) no Git hosting service currently supports
this mechanism at scale. At minimum, using the stored OID would
allow the host to keep track of these pre-defined sets and do some
precomputing of reachable data using bitmaps to keep clones and
fetches reasonable at all.

The other side of the issue is that we do not have a good solution
for resolving how to change this filter in the future, in case the
user wants to expand their sparse-checkout definition and update
their partial clone filter.

There used to be a significant issue where a 'git checkout'
would fault in a lot of missing trees because the index needed to
reference the files outside of the sparse-checkout definition. Now
that the sparse index exists, this is less of an impediment, but
it can still cause some pain.

At this moment, I think path-scoped filters have a lot of problems
that need solving before they can be used effectively in the wild.
I would prefer that we solve those problems before making the
feature more complicated. That's a tall ask, since these problems
do not have simple solutions.

Thanks,
-Stolee
