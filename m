Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06A2B1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 19:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbeHTWyr (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 18:54:47 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:43363 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTWyr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 18:54:47 -0400
Received: by mail-yb0-f194.google.com with SMTP id k5-v6so2027874ybo.10
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 12:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JtxgzAnHbluPfoBYxS/PMpOIpcBm0UAJeUC9XtRDD5Q=;
        b=votf7V8jMnrgU31Ge2onc8KTmUxAOV6AgUeKFkoH65AzRf8FwZ/sVmYY9Ol0GQaanS
         7WfV8XhlPAsj6pW82O5CVSBGxHuGPytVVHYaIimSRPn5W+eMmf1rq6FcVT2yVCfnN6gp
         rVRb4DJ0OH3TvanLvObsRU3CZ0wweqT2l9yFCP9bjB3VM0q4cZk2lnCi5j9xX4bok1sK
         6eQXCB/7FIgmywvGaJJnhAmAMuE0KMqf5BU89yvnLSHKZQOTDHVbK3j9g//Qjf/P8G9p
         t+7h4ap1lNUsvDQ1t9H9SVuBon/uEFVm/1I8sGm8LF1WWUqWQVQBXO7gZldcWY4/l7LZ
         HI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JtxgzAnHbluPfoBYxS/PMpOIpcBm0UAJeUC9XtRDD5Q=;
        b=Q5LdC2Mv/qd0mE41UEDbrqBNmYIU6ayWCR4ET2TkUisRINEXDn3zTg84DtTX7LbwRd
         LVWvr3louz2d06+ZlPcpJOsxVetfeuLBfVxyfpy+Jke8i9VPlFTjZgt0yjavCrsGqXPY
         k1jt2PBZxpfhXTUS+Dq5E1Zt7A48Dq4ZNDRuwpkq7alhM3/6+jcfsFS9JyGicu/EUIXT
         wEa/DQ2mqr+n8buk42bo2miKnP4aHP+cTvtLsVYCyxvWYyrQsTAbIs3/X8UXaNzRg7sM
         pJfo+rWOLvvN1FD5PpFj1Zo2mt1PP2U88kOzG0jXRDXGBrR56DjeP4lC+ESeLXL966Z8
         IYaQ==
X-Gm-Message-State: APzg51AK/F6xZimMSu6+jDNBqIad/kNGiklptw3OwN85ASA0ZBSmUWmT
        FYO9wpuoXLsywr4+/EWspMNASCnc5QMQazbIR5RdsLU4xR0=
X-Google-Smtp-Source: ANB0VdbjdPq94BNSXDVa/XYUTo9zDprbon65lnesK9yhSpix0IsyIIn1tHF0U5ubWwmeGqe9nqByd1i7jThWzQ6TWuM=
X-Received: by 2002:a25:16c3:: with SMTP id 186-v6mr297697ybw.521.1534793873539;
 Mon, 20 Aug 2018 12:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.11.git.gitgitgadget@gmail.com> <20180820182359.165929-1-dstolee@microsoft.com>
In-Reply-To: <20180820182359.165929-1-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Aug 2018 12:37:42 -0700
Message-ID: <CAGZ79ka6=Zw8pFhwVysoE3Wa+mpUm4E83cf7TCKmYZ7XC0ZL2A@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Clarify commit-graph and grafts/replace/shallow incompatibilities
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 20, 2018 at 11:24 AM Derrick Stolee <dstolee@microsoft.com> wrote:
>
> One unresolved issue with the commit-graph feature is that it can cause
> issues when combined with replace objects, commit grafts, or shallow
> clones. These are not 100% incompatible, as one could be reasonably
> successful writing a commit-graph after replacing some objects and not
> have issues. The problems happen when commits that are already in the
> commit-graph file are replaced, or when git is run with the
> `--no-replace-objects` option; this can cause incorrect parents or
> incorrect generation numbers. Similar things occur with commit grafts
> and shallow clones, especially when running `git fetch --unshallow` in a
> shallow repo.
>
> Instead of trying (and probably failing) to make these features work
> together, default to making the commit-graph feature unavailable in these
> situations. Create a new method 'commit_graph_compatible(r)' that checks
> if the repository 'r' has any of these features enabled.
>
> CHANGES IN V2:
>
> * The first two commits regarding the ref iterators are unchanged, despite
>   a lot of discussion on the subject [1].
>
> * I included Peff's changes in jk/core-use-replace-refs, changing the base
>   commit for the series to 1689c22c1c328e9135ed51458e9f9a5d224c5057 (the merge
>   that brought that topic into 'msater').
>
> * I fixed the tests for the interactions with the graft feature.
>
> Because of the change of base, it is hard to provide a side-by-side diff
> from v1.
>
> Thanks,
> -Stolee
>
> [1] https://public-inbox.org/git/CAGZ79kZ3PzqpGzXWcmxjzi98gA+LT2MBOf8KaA89hOa-Qig=Og@mail.gmail.com/
>     Stefan's response recommending we keep the first two commits.
>

After reviewing my own patches, I flipped again (Sorry!) and would
rather not see my patches be merged, but the very original solution
by you, that you proposed at [1]. That said, I will not insist on it, and
if this is merged as is, we can fix it up later.

With that said, I just read through the remaining patches, I think
they are a valuable addition to Git and could be merged as-is.

[1] https://github.com/gitgitgadget/git/pull/11/commits/300db80140dacc927db0d46c804ca0ef4dcc1be1

Thanks,
Stefan
