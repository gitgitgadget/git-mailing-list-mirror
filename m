Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9ACF1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 21:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934799AbeF2VsK (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 17:48:10 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:36050 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933723AbeF2VsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 17:48:09 -0400
Received: by mail-yw0-f173.google.com with SMTP id t198-v6so4214363ywc.3
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 14:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xmBuNcGov9ui1SK1++ZYKLVB3Us33upkROc3Jyw7r08=;
        b=nSh2arrPAfHbU9eIiLX2yoU0iVPVKDxQgYbUkAxpmnscfsGuFk4Is+zht12nTDVLZE
         RWBBRJzStIpjbj4j6nkgKrzulESx92d3iI0asxJZAuuv49+ftbtf8iKuvrtE4o8Nwzd5
         sqWyCV0UPuj2X2qfdZHXKh1FouQXKogHvS/kx9P2f8phV2D6zZL8RJoPhp1dgJWIEjT4
         wqYC7kLBAslRcKfJDYT28z6CrYOqJ7ZiQa2/4lggYzfuS8GspMAMEeeDbDmqOIN+MniR
         rp+2A0VV7/ZSs0d/CAo9W8DgmDt42gbKeW346W3LjUJrscc+c4sck9EPhBDZnbFNfJAj
         bmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xmBuNcGov9ui1SK1++ZYKLVB3Us33upkROc3Jyw7r08=;
        b=s1/OL5HUpqX5bysf9sKoE7NbFY8yaEjKmyZE2Utpv/Th5hd5lGOGIZ8HH75oCG/zho
         31H4kT7yz5sUjJcdJ+0uGFlf0y/AOaFFnAkrIhroI3/hfhhy/bFAH/DATvSzoLuABVH/
         GKKq12wnVEXIq97sL8hWkJV/iGa6WTgoYjkynLE5GKNdjXGrpqRRgX07B/bFq8v1y+8w
         N9AnWN36k3MEtSCLyf2i+NiKR79S3SvqX4zI5dvY27c9n0SKoUsfkluux/R+rb8Z6odT
         YmuwebZhO7TZFSr26TA2k5i71cHthwYnONGIdxeMdS+1W4q2mmOPAqiCKLYzNrDAyxRF
         MBmA==
X-Gm-Message-State: APt69E0RlNXgZEFYzZNWi2z1e7PF/eA7UftSD3Q/d/6GK/lvzXW3Gins
        CfAYgw1HeEw5/rERF/sNAQ9snNG34DQRnY0/Qw6zbA==
X-Google-Smtp-Source: AAOMgpdFbEHBsNqCMAq1TfIVPyPvNwXC55OEpAHSc3y9+bB3+NmgA31do/gQw8+IJRm+ak0O+OL2yK8/b2kDYeijMsM=
X-Received: by 2002:a81:b283:: with SMTP id q125-v6mr8220781ywh.414.1530308888920;
 Fri, 29 Jun 2018 14:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180629161223.229661-1-dstolee@microsoft.com> <20180629161223.229661-7-dstolee@microsoft.com>
In-Reply-To: <20180629161223.229661-7-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 29 Jun 2018 14:47:57 -0700
Message-ID: <CAGZ79kYR1yHxkcDTJh7YoNJydkE_WhdL1mdMKL3hDXgEk+gLxw@mail.gmail.com>
Subject: Re: [RFC PATCH 06/13] commit-reach: move can_all_from_reach_with_flag()
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

> +static int reachable(struct commit *from, int with_flag, int assign_flag, time_t min_commit_date)
[...]
> +               if (commit->date < min_commit_date)
> +                       continue;
[...]

> +int can_all_from_reach_with_flag(struct object_array from,
> +                                int with_flag, int assign_flag,
> +                                time_t min_commit_date)

Can you expand on why we introduce the min_commit_date in the commit message?
(It looks like a rebase error as I would have expected a move only,
given the subject)

Thanks,
Stefan
