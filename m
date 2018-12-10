Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7268520A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 16:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbeLJQJY (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 11:09:24 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36352 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbeLJQJY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 11:09:24 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so18986140itj.1
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 08:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NPaIvcnqCD30L0IS/apsUgwYy7eFMg3sarDVcClfOTw=;
        b=JyyeFh6mWtUrJE9+tv+c8NFkcP0illnIldYhz/RTnpYbBFdcrlkmXgsyniXCR9vMFa
         UWFTjfjiMQgkFMM0qpYfBLP6YKU3HNejLcvKPx5fAtWWnT5zrvTw35eTcDQbCEX44yQ+
         5yV5dyV5S9P/fS7cGTpeS2i8j3Ms64RDnxxaTGTezuOyTPLAoRBoCJ2Vm4N57V6r9osu
         FZ7yK8EF6YTMkp521l3M42FnF/lYN40ELeXR2r9pDsTXiL75AInBvw6UYmUvqEBXKAL4
         JZYUqN5lMyqoDaaAbyRx9Kig+FrPxqRpczq+NeVJv3aiCdK+Cy3PmLIeEV25+NY9xDwB
         zcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPaIvcnqCD30L0IS/apsUgwYy7eFMg3sarDVcClfOTw=;
        b=nCurC/ZPSxX2cO8m+Z70wzSImdqxWjr2o0heenRp76SUxVPFaW0i3f9PCgMiRdp7pY
         rxjg0K5SXslShu+gKcRiJxM0/7OhpBDnXKFPAPO9fIbCDpKEgcAPNDlruwu72o5buFPS
         UT8MrhZCqqJL219CpWUVtFaU5h2QF2A0902KQ0USfiPZvQOZpFpaJpWPf3s98nwmuxaE
         jPxlRpqmQPGwWTohGKLOB1nX5tHuXAuqHq4RRRSm8i0JXGGCJwP/uTF53Vb95hXOnYQ6
         cwMQaWijr81ULDqq2fXkS1mp3S8znenysfjLNsyy2RZPUaqpx33UdYUQ4EClhsdu2Yaz
         klVA==
X-Gm-Message-State: AA+aEWYw+GOcwNA9we5Ir5dYq/zbLs99L8z0sM/8P1TxlvkNZXQQaws5
        O1TWGM0x0B99CtK6EeL+XJ1lGHZn381/h4O6Ld4=
X-Google-Smtp-Source: AFSGD/XgcKi09COi+TDIsZjsbYQX34J5+jUo2vB4LkFOpUdsEuj+ZHyspsVyhaYiI5gtbxGRqd8DhLGdjnTkgGHPZEo=
X-Received: by 2002:a05:660c:81a:: with SMTP id j26mr11510443itk.70.1544458163004;
 Mon, 10 Dec 2018 08:09:23 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-5-t.gummerer@gmail.com>
In-Reply-To: <20181209200449.16342-5-t.gummerer@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 10 Dec 2018 17:08:56 +0100
Message-ID: <CACsJy8AiQvu8W4=2HLKMdg+n2HiDrcLvKPRurKvziXaJdqefRg@mail.gmail.com>
Subject: Re: [PATCH 4/8] read-cache: add invalidate parameter to remove_marked_cache_entries
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 9, 2018 at 9:05 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> When marking cache entries for removal, and later removing them all at
> once using 'remove_marked_cache_entries()', cache entries currently
> have to be invalidated manually in the cache tree and in the untracked
> cache.
>
> Add an invalidate flag to the function.  With the flag set, the
> function will take care of invalidating the path in the cache tree and
> in the untracked cache.
>
> This will be useful in a subsequent commit.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>
> For the two current callsites, unpack-trees seems to do this
> invalidation itself internally.

I'm still a bit scared of this invalidation business in unpack-trees.
The thing is, we handle two separate index_state there, src_index and
result and invalidation has to be done on the right one (because index
extensions are on src_index until the very end of unpack-trees;
invalidating on 'result' would be no-op and wrong).
remove_marked_cache_entries() seems to be called on 'result' while
invalidate_ce_path() is on src_index, hm....

> I don't quite understand why we don't
> need it in split-index mode though.  I assume it's because the cache
> tree in the main index would already have been invalidated?  I didn't
> have much time to dig, but couldn't produce any failures with it
> either, so I assume not invalidating paths is the right thing to do
> here.

Yeah I think it's because cache-tree and untracked cache are already
properly invalidated. This merge base thingy is done when we load the
index files up, not when we write them down. The "front" index may
record that a few paths in the base index are no longer valid and need
to be deleted. But untracked cache and cache-tree both should have
recorded that same info when these paths are marked for delete at
index write time.
-- 
Duy
