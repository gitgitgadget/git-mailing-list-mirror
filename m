Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE6181F516
	for <e@80x24.org>; Fri, 22 Jun 2018 00:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934113AbeFVA7t (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 20:59:49 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:46065 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933948AbeFVA7t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 20:59:49 -0400
Received: by mail-qt0-f182.google.com with SMTP id i18-v6so4610154qtp.12
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 17:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=mCR8NbAL9J3bnaI0u8HWmRYUU6EcHJjGG2AiLbtkvFk=;
        b=JCVEJup/XITbc2HYLY4AmKW/O4DFY+k7Sq8b3iPMB3+ljox6vaFqVxR3BHjOsWDZYc
         YVQl0WKaJaay6jvpf4rt4xEZGnfZq9Q/WgAgaRhItXXKCTNoZBj9+3utbqSiw+/K8T0K
         dTQXC6YCyrzXUurRcwI2/MZWWonZYCvWqelK+QdtGiSkS9Vdznf4jPRgC4B0bEZ/9pnw
         VlmklM/KutRHEFR8wHBwbVCScY9ZlP5mCWA3SCuQ+hrlaqGMWRLpvWc4tm0jgbvbEeNG
         MwZ6Ecwe/C0tgz3k8hGuwD5M72ZW5bhRvuf9iMTLhobzHJd+q/MDrF82qT9pLC5MZuCw
         R5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mCR8NbAL9J3bnaI0u8HWmRYUU6EcHJjGG2AiLbtkvFk=;
        b=aEdnVBEpL+TSqu+aDC7CDusdjgmx+XqqReZ1+TYUK/1Bsc+7plqIk6SidFQW4GXQ/K
         E63mxTeMdoJydzkLonAl3CxqsqAfS8Kcu0595lQ/dCAMxyKfYskHVwSWZaMjkbU0rNql
         3iWslMHvY9jvp6FaOBucY2eGdPobcUKh9rEMuWC2/pEU0/PKTK+1X9mr0/hoTuYagD7U
         r3qJE56/AQ8ZCAWatOxw1Hu2onJAfl0/o/r9y5qkY+odKA9O2h4x1QOkaPfYYD2S9d4g
         eGOYZYiwp1t0LCaNdFYBPqaUvtXelmYNMo7nItbptcfoAEj6yLK88eKjlI7KPgkpOhHu
         h7Gw==
X-Gm-Message-State: APt69E3rYBwK6HkMIkkEUYHZurMW0yj5Zq+/0Ut0YyplaFw/4XelwgwF
        tYjW7RN6Ua5WihbJu5GoEhHfAGAg
X-Google-Smtp-Source: ADUXVKKxNrTjwv42Y+GbECz4TzbDG3WGGA/dKflNJGfklLqGlPRQhbng9zXeR8NVXxnyjB0f38FzKA==
X-Received: by 2002:a0c:a063:: with SMTP id b90-v6mr24560153qva.115.1529629187993;
        Thu, 21 Jun 2018 17:59:47 -0700 (PDT)
Received: from [10.0.1.20] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id f9-v6sm3234187qkb.43.2018.06.21.17.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 17:59:47 -0700 (PDT)
Subject: Re: The state of the object store series
To:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
References: <CAGZ79kZtEZA1rvgfSCS+m4dsrB86Cf-XiePWQmeU-kCNxP_NLQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4e7600f1-6dd0-3b21-5f5d-26af2b3c0b1a@gmail.com>
Date:   Thu, 21 Jun 2018 20:59:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZtEZA1rvgfSCS+m4dsrB86Cf-XiePWQmeU-kCNxP_NLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[My email client says I sent this two days ago, but it doesn't appear on 
public-inbox.org, so somehow it didn't land on-list (Stefan pointed out 
that the message was in HTML). Repeating the message now so I can 
reference it in another discussion. -Stolee]

On 6/19/2018 6:07 PM, Stefan Beller wrote:
> There is an ongoing effort to remove global state currently and switch over
> to pass around the relevant data structures; for most of it we end up passing
> around 'the_repository' as it contains everything there is.
>
> Merged into master:
>
> fcb6df32546 Merge branch 'sb/oid-object-info'
> a2cec42213c Merge branch 'sb/object-store-replace'
> 3a1ec60c43b Merge branch 'sb/packfiles-in-repository'
> cf0b1793ead Merge branch 'sb/object-store'
>
> Currently cooking:
>
> 8c69a7d7e80 Merge branch 'sb/object-store-grafts' into pu
> 42d32d07298 Merge branch 'sb/object-store-alloc' into jch
>
> (both marked for "will merge to next" in the cooking report)
>
> Floating on the mailing list, not cooking yet:
>
> "sb/object-store-lookup" 
> https://public-inbox.org/git/20180613230522.55335-1-sbeller@google.com/ 
> This clashes with other series in flight (Stolees get_tree series; see 
> https://public-inbox.org/git/709bd61c-70fc-a925-efba-58ab9be265c9@gmail.com/ 
> I'll rebase this series on top of that series once the currently 
> cooking series stabilize) "nd/kill-the_index" 
> https://public-inbox.org/git/20180616054157.32433-1-pclouds@gmail.com/ 
> This converts the_index to pass around index pointers instead of 
> the_repository; it fits into the theme, but Duys end goal differs from 
> mine; he is less submodule focused. Work that still needs to be done: "xx/object-store-commit-graph"
>    Convert the commit graph to have no global state, but be part of the
>    repository struct. I think this can go in parallel to
> "sb/object-store-lookup",
>    so I'll tackle that next. Thanks Stolee for looking ahead: There is only the
>    commit graph itself as well as whether it has been prepared as a global
>    variable. So this series will consist of passing around a repository struct
>    for all those higher level functions that do not pass around the commit graph
>    or parts of it.

There are some patches in ds/commit-graph-fsck that would be helpful for 
this effort, and may be easier for you to take.

Specifically, these ones:

  - commit-graph: load a root tree from specific graph
  - commit: force commit to parse from object database
  - commit-graph: parse commit from chosen graph

I'm waiting for sb/object-store-lookup to be in 'next' before I re-roll 
that branch. If you're not in a rush to send this series, perhaps wait 
for the next version here.

> "xx/finish-object-stores"
>    This requires "xx/object-store-commit-graph" as well as
> "sb/object-store-lookup";
>    it will convert parse_commit[_gently] to take a repository argument and will
>    finish the actual object store part. This might be optional for the goal of
>    converting submodules, that I have in mind, but it sure is a nice finishing
>    touch.
>
> "xx/convert-revision-walking"
>    This series aims to convert get_merge_bases(), in_merge_bases() and all its
>    revision walking code to take a repository argument.

I'm playing around with a series that groups most commit walks into one 
file, so they can share more code and we can more easily test their 
correctness and performance. I'll send an RFC sometime that will 
absolutely collide with this one, but I expect a full v1 patch will be 
based on this series.

Thanks,

-Stolee

