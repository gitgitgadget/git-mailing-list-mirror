Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96C9D1F51C
	for <e@80x24.org>; Mon, 21 May 2018 18:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750977AbeEUSi4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 14:38:56 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:44782 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeEUSiz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 14:38:55 -0400
Received: by mail-yb0-f194.google.com with SMTP id s8-v6so4173589ybp.11
        for <git@vger.kernel.org>; Mon, 21 May 2018 11:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F5xx0AozeOXLmdV+WY8MD1kC1JYx3XsAyb5n3xswX3Y=;
        b=NTW861L56SR1LnknLknJ6jhM9PeMcTh2nlwuVdQ32S0nYTEOEjkSLy5yriktfH09dA
         QgCqI+npdyKksqeeQFz4YX1T+Z8PGBSvLDdt2wpQFMO9xFbgLQrBnakauVYcUv6ngR+H
         KOhmwTApMrI7wRDcXHwwhD71lF7lVpXMeIkuZt9uscrN7q37mIwtq7uzCLOs1fU1z4Yj
         xEeenB3LPGxMP9VI5PXRyFdaZl3zKJwKoueNvFYz3nqACpZF2jZACygv7doV+/5nwK28
         SxX9FXsAEpUaiA6AQ22CtVdVa3G/NCcMEXi7zjJTyILWnqq9olLnCPubPqegObBE7pA5
         O9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F5xx0AozeOXLmdV+WY8MD1kC1JYx3XsAyb5n3xswX3Y=;
        b=CbP+8mKYGX4HgOHRbGjgVByUyOw83upo19bFULIrCsEDIiZMjx8JcyWzyCgGDg3xNP
         1XugxYwr/VNFAGlN7uu+uYHGDHJeX4Xx6rmnIQarqh8+6LRWyM21SG5/VNcUqRi/Gjfe
         LThSIQNKwhLDmG0NHSg/z7mfvbSPNB5SFqdloDM5vLsCin6UjFlvuhYa8Y+q6/Gd2JQy
         3+PVySMtDnbbliZdLOV154P5aqCJazDIcoqCNexvyHGysgIqXsIDRdb75dhOZNZSEqnM
         qWhsHlQdwlN8cx2OihVsHtGVpFlbD5TGJ2pNE03breLGvj/eCof77dK8u/kXXe0t/qRA
         ywpA==
X-Gm-Message-State: ALKqPwcu6k5uxzPi6Oyp8MY0+tQVZipo4Or2ps72IHUxe/F+pDbedVoK
        svb+yhUZ9snkSC1Dq4GgD4eejrou+OsATTnmbn5prATWR4M=
X-Google-Smtp-Source: AB8JxZqBvWeJyL+KiEkZHIAjK2z1GcdKS6zLt1G8+PCBnIX2OQEFG6xiF4fvmXPudnoZK82SonO0dTfMCSFyB5W2S84=
X-Received: by 2002:a25:a526:: with SMTP id h35-v6mr1151175ybi.515.1526927934201;
 Mon, 21 May 2018 11:38:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Mon, 21 May 2018 11:38:53 -0700 (PDT)
In-Reply-To: <20180519063729.GA14755@duynguyen.home>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com> <20180516222118.233868-3-sbeller@google.com>
 <20180519063729.GA14755@duynguyen.home>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 May 2018 11:38:53 -0700
Message-ID: <CAGZ79kbxptYvDoTqsVRe3KOA_--ja8UZir=MkMXw8_LxVXG_-Q@mail.gmail.com>
Subject: Re: [PATCH 02/11] repository: introduce repo_read_index_or_die
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Antonio Ospite <ao2@ao2.it>, Brandon Williams <bmwill@google.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 18, 2018 at 11:37 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, May 16, 2018 at 03:21:09PM -0700, Stefan Beller wrote:
>> A common pattern with the repo_read_index function is to die if the return
>> of repo_read_index is negative.  Move this pattern into a function.
>>
>> This patch replaces the calls of repo_read_index with its _or_die version,
>> if the error message is exactly the same.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  builtin/add.c               | 3 +--
>>  builtin/check-ignore.c      | 7 ++++---
>>  builtin/clean.c             | 4 ++--
>>  builtin/mv.c                | 3 +--
>>  builtin/reset.c             | 3 +--
>>  builtin/rm.c                | 3 +--
>>  builtin/submodule--helper.c | 3 +--
>
> 'git grep -w -A3 read_cache' tells me you're missing (*)

> (*) yes yes you did mention "if the error message is exactly the
> same". But these look like good candicates to convert anyway
>
> builtin/diff-tree.c:    if (read_cache() < 0)
> builtin/diff-tree.c-            die(_("index file corrupt"));
>

I would expect this to be covered in a follow up patch as I did look
for (read_cache() < 0) specifically.

> builtin/merge-ours.c:   if (read_cache() < 0)
> builtin/merge-ours.c:           die_errno("read_cache failed");
>
> builtin/update-index.c: entries = read_cache();
> builtin/update-index.c- if (entries < 0)
> builtin/update-index.c-         die("cache corrupted");
>
> merge-ours.c is interesting because it uses die_errno() version
> instead. I think that might give inaccurate diagnostics because we do
> not only fail when a libc/system call fails in read_cache(), so it
> should be safe to just use die() here.
>
> update-index.c is also interesting because it actually saves the
> return value. I don't think it's used anywhere, so you can just drop
> that 'entries' variable. But perhaps it's good to make
> repo_read_index_or_die() return the number of entries too.

Yeah this series left out all the interesting cases, as I just sent it out
without much thought.

Returning the number of entries makes sense.

One of the reviewers of the series questioned the overall goal of the
series as we want to move away from _die() in top level code but this
series moves more towards it.

I don't know.

Stefan
