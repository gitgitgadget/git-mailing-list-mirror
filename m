Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68E231F461
	for <e@80x24.org>; Mon, 22 Jul 2019 12:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfGVMLC (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jul 2019 08:11:02 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43737 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfGVMLB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jul 2019 08:11:01 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so2691508qka.10
        for <git@vger.kernel.org>; Mon, 22 Jul 2019 05:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wxC/LLjzFdN7NCoGnF5wao34HEsj4eJmxp//qKMwtvU=;
        b=nvQJiIuhpBJpEvlfFSdw3N9MP+Hw0wVLNITDjBALifIAOlSd9dcTmuAJULuC/7icD3
         +V4rQ1BZuBHqcPUYbCwn5iE0lX+mNSqU3qtHj8LE/hnrgERcHeShcZ3G/IejDKwQWiKq
         2luSFfaLvBWmjEsnPMZAxkbvrrnHrXGgXShcC/j2gOJDdieFhVsp4OcPm1NMBKOln1CG
         JEB8Vcs4d+k04hwF4tYIsGHnh5xAvD9xlf7Ek9MTpRy3puE0r0Ywo/yFsecZeJkFR7g1
         2XNemnEueQ1s0iJp4FaiG3WIeKN9Lr0lJOyIYgvJeBkO205vVCJdjkXBMlcGaWty52YG
         Fjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wxC/LLjzFdN7NCoGnF5wao34HEsj4eJmxp//qKMwtvU=;
        b=Y9drpvGzNzCN0Ea992/7H7Ll2fSwTvxIa9CFZpPfk3XxqqiI2CD1K34USdS86n/heC
         nbBWLdMSbQXGz60hDu95fDbNySsODtMZCT3u0hZQDnhtCMGXDkBlg0Y6KjLyt7klJ/H4
         FOXKuskGEP0sBtPgSO6wkHC78ito/DLSWGsyK6JBor58aF0CZk+xMnCrXT+q1Y+ZUI08
         phUXPO0YdrwgaZ5uKMcgh3moJZWw9km4WXVQ7MCwSbUOZagL0PSxL9utGkTZBpU6Rzev
         p8A3PZNXE6wZCK1a/ClTm0YgNCVzgdD+QdM8kH8cKxqE7VC05u4HHaSAdMf0icG5U1ll
         4N5A==
X-Gm-Message-State: APjAAAXUgSIDYU2VL7h9MlY6bR9pK6MhrhwY1tnD071+mg5Pzx726M18
        fIQ48KPv3rCfK1NkBJoTrXo=
X-Google-Smtp-Source: APXvYqzTKkO6cB8yaGX38W2XjkuKK3IW39EUZR2iFKOTWGXRAKVI9sqmwvpLSr90lX3hCKjonGWVsA==
X-Received: by 2002:a37:5d87:: with SMTP id r129mr13536789qkb.388.1563797460913;
        Mon, 22 Jul 2019 05:11:00 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:444e:8321:4ee:a890? ([2001:4898:a800:1012:f581:8321:4ee:a890])
        by smtp.gmail.com with ESMTPSA id v28sm16841284qkj.11.2019.07.22.05.10.59
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 05:11:00 -0700 (PDT)
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
 <afdaaa93-8769-c859-e957-e61d27b6d5a9@gmail.com>
 <xmqqef2yvp7v.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <be4f9cc9-ee20-8e4f-c45a-26e93b51c4f3@gmail.com>
Date:   Mon, 22 Jul 2019 08:10:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <xmqqef2yvp7v.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/9/2019 6:05 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> From this list, do you think any of these settings are likely to
>> become defaults? It seems that protocol.version = 2 may be a default
>> now that _most_ services have an implementation, and it always falls
>> back to protocol v1 without extra cost.
>>
>> When pack.useSparse was first introduced, I considered making it true
>> by default after a while. But you protested, saying you want people
>> knocking at the door saying it is useful. What if it lived here?
>>
>> fetch.negotiationAlgorithm and merge.directoryRenames seem like
>> valuable features and maybe just need more time out in the world
>> before they could be considered defaults.
> 
> I mostly agree with the categorization you gave above.
> 
> I think it is perfectly fine for a knob, after proving its worth by
> existing in the world without being a part of any feature.* set, to
> become part of feature.experimental, and then later be ejected
> without ever becoming the default in response to reactions by real
> world users.  This would be easier to arrange if we had at least two
> experiment levels.  One class would be "we are firmly committed to
> make these default in the future and ironing kinks out---please help
> by setting feature.experimental on" and is more for early adopter
> testing.  The other class may be "we try this on users to see if
> there are some populations of them with usage patterns we did not
> anticipate, and will yank it out if it turns out to be problematic
> to some users."  The more guinea pig users opt into the latter
> "Highly Experimental" category, the more help they can give us to
> prevent an ill-thought-out feature that does not universally help to
> become a new default.

How about "feature.preview" for defaults we expect to change in a later
version, while "feature.experimental" is for defaults we are not sure
about?

-Stolee

