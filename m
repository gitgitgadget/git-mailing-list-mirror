Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CD6C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 13:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244690AbiHINuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 09:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244648AbiHINuD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 09:50:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B871C930
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 06:49:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bv3so14388271wrb.5
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 06:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=JCeMcuP1rxphZdAsgwcEX+jztEs+7b97WBeqKjadQGU=;
        b=USGvn59pnFDP+ld8HrJRhPo6cMKXuSvz0hRiT3JFjyDSnbnJNQ4z12c0Fljah+v/5g
         6zIvyEl/ZiuBjRdb8K/IzkqJAHY/CWeRR8BMJhmn2ITuFEDEeIp0fmow5lyeSEV+REYP
         vZH4mJH+Yv6vVD8a7yt4WB2Ol+gJYhGK9OST3+dd5bKdHWEWCq0GG43ZdwairIlZd0gf
         +lfCZvRlRb17f6E9HS7wCPRflyWoSCzCf6lDCl5DGaWYDri0FeJXzvtcBupLkH0B/07V
         x+ChpArODl+gDW1WIw02pwiPFc4Mp1OWEM9h9qdp2MK6VSbJvFLn1nvR5U6kRHoBRtG3
         i57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=JCeMcuP1rxphZdAsgwcEX+jztEs+7b97WBeqKjadQGU=;
        b=uv0NHqaFiH8yMlZRsJs1N6uL3ZQG9trYxOx6l6872/vPdYlWJX6RZDC+V4ZhQm0RKf
         eXxVauix/EA5e2oUo8y57BrUgWka6Pyp8bBroFg9Igc9vZ09eTK4AbieJ1koS2BVF82f
         kN4e8w+eJnRAz1p32hU7lHXE5UxdbCjDZiWh0jLwVSQoq2c7ttTQMP34crQAUj73Ohrk
         ixX6gXZx1JV+S4iEH1iiTZ2GwIeRHcLLkMow4dWmUuI+vfotQWQadl0tuPkto1fqJDcK
         M97mSFsYDK6V53rQ++WsN5Eml6USczR6ARApOJBugBURKLvmsbNXkS5nBKdKV8jWHHcI
         1nlw==
X-Gm-Message-State: ACgBeo3WT9tC/kiie1Jz7uppaU6nqIyQJXam9/8Gistb4/pHE0qhNB9m
        WlS0aaSAT/Fv2cJR8lfMwfg=
X-Google-Smtp-Source: AA6agR4QsdBd0NZcDBD8PXQDhNUNk3RFP05jHOPs4IAjoourhy4c8O42LUXday0fBFa3q2cwqtArPw==
X-Received: by 2002:a05:6000:a13:b0:220:62e6:5f79 with SMTP id co19-20020a0560000a1300b0022062e65f79mr14478655wrb.45.1660052988501;
        Tue, 09 Aug 2022 06:49:48 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c3b8300b003a550be861bsm2952053wms.27.2022.08.09.06.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 06:49:48 -0700 (PDT)
Message-ID: <5b98f1d8-e829-98db-1d13-7aba6c126f8d@gmail.com>
Date:   Tue, 9 Aug 2022 14:49:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/2] bundle URIs: design doc
Content-Language: en-GB-large
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Josh Steadmon <steadmon@google.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1248.v3.git.1658757188.gitgitgadget@gmail.com>
 <pull.1248.v4.git.1660050761.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1248.v4.git.1660050761.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 09/08/2022 14:12, Derrick Stolee via GitGitGadget wrote:
> This is the first of series towards building the bundle URI feature as
> discussed in previous RFCs, specifically pulled directly out of [5]:
> 
> [1]
> https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/
> 
> [2]
> https://lore.kernel.org/git/cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com/
> 
> [3]
> https://lore.kernel.org/git/pull.1160.git.1645641063.gitgitgadget@gmail.com
> 
> [4]
> https://lore.kernel.org/git/RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com/
> 
> [5]
> https://lore.kernel.org/git/pull.1234.git.1653072042.gitgitgadget@gmail.com
> 
> THIS ONLY INCLUDES THE DESIGN DOCUMENT. See "Updates in v3". There are two
> patches:
> 
>   1. The main design document that details the bundle URI standard and how
>      the client interacts with the bundle data.
>   2. An addendum to the design document that details one strategy for
>      organizing bundles from the perspective of a bundle provider.

I thought the document was well written and left me with a good 
understanding of both the problem being addressed and the rationale for 
the solution. One small query - the document mentions CI farms as 
benefiting from this work but my impression is that those commonly use 
shallow clones which are (quite reasonably) not supported in this proposal.

Best Wishes

Phillip

> As outlined in [5], the next steps after this are:
> 
>   1. Add 'git clone --bundle-uri=' to run a 'git bundle fetch ' step before
>      doing a fetch negotiation with the origin remote. [6]
>   2. Allow parsing a bundle list as a config file at the given URI. The
>      key-value format is unified with the protocol v2 verb (coming in (3)).
>      [7]
>   3. Implement the protocol v2 verb, re-using the bundle list logic from (2).
>      Use this to auto-discover bundle URIs during 'git clone' (behind a
>      config option). [8]
>   4. Implement the 'creationToken' heuristic, allowing incremental 'git
>      fetch' commands to download a bundle list from a configured URI, and
>      only download bundles that are new based on the creation token values.
>      [9]
> 
> I have prepared some of this work as pull requests on my personal fork so
> curious readers can look ahead to where we are going:
> 
> [6] https://github.com/derrickstolee/git/pull/18
> 
> [7] https://github.com/derrickstolee/git/pull/20
> 
> [8] https://github.com/derrickstolee/git/pull/21
> 
> [9] https://github.com/derrickstolee/git/pull/22
> 
> As mentioned in the design document, this is not all that is possible. For
> instance, Ævar's suggestion to download only the bundle headers can be used
> as a second heuristic (and as an augmentation of the timestamp heuristic).
> 
> 
> Updates in v4
> =============
> 
>   * Whitespace issue resolved.
>   * Example bundle provider setup now uses the 'bundle-uri' protocol v2
>     format when describing how the origin Git server advertises the static
>     bundle servers.
> 
> 
> Updates in v3
> =============
> 
>   * This version only includes the design document. Thanks to all the
>     reviewers for the significant attention that improves the doc a lot.
>   * The second patch has an addition to the design document that details a
>     potential way to organize bundles from the provider's perspective.
>   * Based on some off-list feedback, I was going to switch git fetch
>     --bundle-uri into git bundle fetch, but that has a major conflict with
>     [10] which was just submitted.
>   * I will move the git bundle fetch implementation into [6] which also has
>     the git clone --bundle-uri implementation.
> 
> [10]
> https://lore.kernel.org/git/20220725123857.2773963-1-szeder.dev@gmail.com/
> 
> 
> Updates in v2
> =============
> 
>   * The design document has been updated based on Junio's feedback.
>   * The "bundle.list." keys are now just "bundle.".
>   * The "timestamp" heuristic is now "creationToken".
>   * More clarity on how Git parses data from the bundle URI.
>   * Dropped some unnecessary bundle list keys (*.list, *.requires).
> 
> Thanks, -Stolee
> 
> Derrick Stolee (2):
>    docs: document bundle URI standard
>    bundle-uri: add example bundle organization
> 
>   Documentation/Makefile                 |   1 +
>   Documentation/technical/bundle-uri.txt | 573 +++++++++++++++++++++++++
>   2 files changed, 574 insertions(+)
>   create mode 100644 Documentation/technical/bundle-uri.txt
> 
> 
> base-commit: e72d93e88cb20b06e88e6e7d81bd1dc4effe453f
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1248%2Fderrickstolee%2Fbundle-redo%2Ffetch-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1248/derrickstolee/bundle-redo/fetch-v4
> Pull-Request: https://github.com/gitgitgadget/git/pull/1248
> 
> Range-diff vs v3:
> 
>   1:  e0f003e1b5f ! 1:  1bfac1f492a docs: document bundle URI standard
>       @@ Documentation/technical/bundle-uri.txt (new)
>        +	work well with incremental `git fetch` commands. The heuristic signals
>        +	that there are additional keys available for each bundle that help
>        +	determine which subset of bundles the client should download. The only
>       -+  heuristic currently planned is `creationToken`.
>       ++	heuristic currently planned is `creationToken`.
>        +
>        +The remaining keys include an `<id>` segment which is a server-designated
>        +name for each available bundle. The `<id>` must contain only alphanumeric
>   2:  a933471c3af ! 2:  a22c24aa85a bundle-uri: add example bundle organization
>       @@ Documentation/technical/bundle-uri.txt: error conditions:
>        +	[bundle]
>        +		version = 1
>        +		mode = any
>       -+		
>       ++
>        +	[bundle "eastus"]
>        +		uri = https://eastus.example.com/<domain>/<org>/<repo>
>       -+		
>       ++
>        +	[bundle "europe"]
>        +		uri = https://europe.example.com/<domain>/<org>/<repo>
>       -+		
>       ++
>        +	[bundle "apac"]
>        +		uri = https://apac.example.com/<domain>/<org>/<repo>
>        +
> 
