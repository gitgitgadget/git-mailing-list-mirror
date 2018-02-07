Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0736A1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 23:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeBGXbR (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 18:31:17 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33783 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbeBGXbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 18:31:16 -0500
Received: by mail-yw0-f194.google.com with SMTP id x24so1357170ywj.0
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 15:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AA4zks7e0vd516C5Ku2eiSXdG4zbK9yq2v/l9gQ3ioE=;
        b=BHVhhuo8NjgDU09/tSnvo8KKlSsVr1q8/xRKXRu93dUVE2BMp+RH8+sXIms3WPH+6B
         QzMrmUxgzFLggc8MAFPGmYESytlLwHev1Ba/nz7FxGhdkZse2WZaeQC1McytKBASAISH
         sbjomDrR2/fFqAR5pmpQK2P38zfdDd2Dp//V0Mj2MiZChVkBYcFm63uJoNNJv9AbAJFG
         oAId8hl9puD+KSee9W9B6DsBLQVg3x3xmwqj6zQPO9TRTtKtbnEa8erlFRucaOaZGj0Y
         zDD43O/mYmsYnI3LZDnsrcZilcO52WL8+UwKaDg8vkcmFfFnfm39kJ5KPmHX0ftcX3OD
         NtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AA4zks7e0vd516C5Ku2eiSXdG4zbK9yq2v/l9gQ3ioE=;
        b=nuaQOKNpzMo+s9We5r6tXN9J2Gu3SYe7Aqc54pF8aBcs5ujLqagFOVFkx/e6raghaK
         Sgq5BT7aSUiA6Xvn+w3aO1GGX69L6NCyqBnrfa5Jh/bnMg+os2e5BePciM4O/S40jtz8
         yGBllEMXSWUzuzVOmiTajKMReZTVoug7CWW1ywykTJPByiBPrGlmzE1ssr85yVdYJ5wD
         TMcYMxvIX3meAvL7yN6NHlwmi8LO6rrkbStAwa79fMHOfWi6YgwU8sRcEOz5S6gBz4dH
         i3cIS7sJyGgfjV2j3gBE2B6naZc5mVtVKyuXbSJjM4ETTJTb2ejEWmR2AZL+PnY/aEvK
         W3Fg==
X-Gm-Message-State: APf1xPDwNDT9K1kRwz1b01aCtooL00DgEJbcZQQ6zOnOt4gGjev/cvAe
        R4mT3djz9V5FoqlgEmHPQQpWlBOYpMDt2j2u/hZNnQ==
X-Google-Smtp-Source: AH8x225R9IL0RVgvBBPY+NPTh0QYG0em3LMukUFZ05sjMas6yyGqgZfp663qJfKraHuWpwYzrTI7aNTft0mhYbHiLmw=
X-Received: by 10.37.37.87 with SMTP id l84mr5281093ybl.386.1518046274983;
 Wed, 07 Feb 2018 15:31:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Wed, 7 Feb 2018 15:31:14 -0800 (PST)
In-Reply-To: <20180207143300.ce1c39ca07f6a0d64fe0e7ca@google.com>
References: <20180205235508.216277-1-sbeller@google.com> <20180205235735.216710-1-sbeller@google.com>
 <20180205235735.216710-18-sbeller@google.com> <20180207143300.ce1c39ca07f6a0d64fe0e7ca@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 7 Feb 2018 15:31:14 -0800
Message-ID: <CAGZ79kaVBeq_29nyvgLtjLkqZxi02RstE3ZtFOFNvKHpNu=k_w@mail.gmail.com>
Subject: Re: [PATCH 038/194] pack: allow sha1_loose_object_info to handle
 arbitrary repositories
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 7, 2018 at 2:33 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Mon,  5 Feb 2018 15:54:59 -0800
> Stefan Beller <sbeller@google.com> wrote:
>
>> From: Jonathan Nieder <jrnieder@gmail.com>
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>>  sha1_file.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> Thanks - I can see that this has been a lot of work, and it brings a lot
> of benefit. Among other things, this will probably allow me to remove
> the "fetch_if_missing" global variable that we need to set and reset in
> the partial clone series, replacing it with a setting in either the repo
> or the object store (and when fetching a missing object, first cloning
> the repo/store and then setting that setting, so that objects are not
> recursively fetched).

That sounds intriguing.

> If we're planning to split the series up for merging in batches (which,
> as a reviewer, I'm very much in favor of), I think this is a good
> stopping point for the first batch, so I'll stop my review here for now.

Thanks for identifying a good spot.

I'll look at this part of the series closer for a reroll, and need to make sure
there are no leftovers with the #define trick.

> After these 38 patches, the net benefit is a better position of the
> packed object variables (in struct repository) and permitting the
> reading of loose objects in any repository. (Permitting the reading of
> any object in any repository, I see, will only come later in patch 74.)

which would then be a good portion for the next series.

Thanks for the review!
