Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A3CD1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbeHMTI7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 15:08:59 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34908 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbeHMTI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 15:08:58 -0400
Received: by mail-io0-f195.google.com with SMTP id w11-v6so15375053iob.2
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+U8JuMBAHRyeSHxkH2axyefKE+19HfnxFOtu0R16jvk=;
        b=s7RlGeUAcHs39s27cR3Cov4b3N3Vpc4HBDZ3b/g3opCGHJv0H//OmYl6r0mtZ6Un7s
         eMKx9YC8QzjdMp8dTXAXpvDcoYNT6IkJLhGyqno4HC/FfDih802XJ91gEKvdhKtCJP8x
         5CXDcaKPVzgq9bmQjCKsw1YM7PFL0ck6fVHMs6C2kq61UiUtFgvWRBal3Mw+wMrVWqMG
         dg3Gadknx0/A8dGKtFsAJH0/CfKFIsmDmWrxb2aPJCdVC3r5hlXQSjaHheb3BivvtlNQ
         mG9tkhLvyor+OGbYvjhOrIV4YL+Uy/0nEe0A8939YZcNzL0MoxY1seCuNLayXdPunibI
         qo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+U8JuMBAHRyeSHxkH2axyefKE+19HfnxFOtu0R16jvk=;
        b=r1pwc6WPSgrHh2BlA5U1CXK0UeN7gF67SUnW5OgXBzHzI8mshL3+tyVF1qtTBTY0kD
         GcRV/n0HpomArdIzaC50/gl82TPBK2R56VA9zeRIFfo651ZoEUhhDmZOR9h6l5NiN7gE
         S55DTGhiFT3ftIglJV5oKAPed5kA5rRy5XZmAY1vhER6x5E2z8JhKMwwf38ANhKa7ZFs
         JTVF3/X6vjDQN+czOdzJYXWiBYTbqHa9w415n/cc0wLqyWdcQATabYKDSFBx/AdtLYt+
         mcpvS0ipENB45Q0g4ePzai+SRbnnvWRcwHc3+kGHO2kXJcN/KZJz1jyD66MCewx9TraR
         ZnFA==
X-Gm-Message-State: AOUpUlERvGaHNj++Td/uMCl0RsR5hikXckcRxhcvx4NtiQJ317IcBqm5
        2wWXYOAdMhF8ICA68vk81FfP3V63KzzYjvPpvS4=
X-Google-Smtp-Source: AA+uWPwQ5AWwzMGpm/DMGaAyHK+LK5QpLbHlTWddX6P/QtgiK0jzIQBe4FRPzP98IShXr4P/C7f3b3OQ+RCiyEL7/rA=
X-Received: by 2002:a6b:a2cf:: with SMTP id l198-v6mr14000390ioe.282.1534177562738;
 Mon, 13 Aug 2018 09:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180804053723.4695-1-pclouds@gmail.com> <20180812081551.27927-1-pclouds@gmail.com>
 <20180812081551.27927-6-pclouds@gmail.com> <CABPp-BEDQfzyZjD0CuZKhvj3iUi0H6Ar0Fgm2UhehjP1pnWKgA@mail.gmail.com>
 <a8543f33-eb1a-4122-87a4-f8d888af7381@gmail.com>
In-Reply-To: <a8543f33-eb1a-4122-87a4-f8d888af7381@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 13 Aug 2018 18:25:36 +0200
Message-ID: <CACsJy8A2L-WX_RLP37fF-f=YBLkCY7+iZLo+Uz=H9EFOWMVnoA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] unpack-trees: reuse (still valid) cache-tree from src_index
To:     Ben Peart <peartben@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 6:05 PM Ben Peart <peartben@gmail.com> wrote:
> I was part way through writing a patch that would copy the valid parts
> of the cache-tree from the source index to the dest index

Yeah sorry about that. I make bad judgements all the time, unfortunately.

If it's sort of working though, please post to the list anyway to
archive it. Who knows, some time down the road we might actually need
it again.

> I run some tests on a large repo and the results look very promising.
>
> base    new     diff    % saved
> 0.55    0.52    0.02    4.32%   s:  read cache .git/index
> 0.31    0.30    0.01    2.98%   s:  initialize name hash
> 0.03    0.02    0.00    9.98%   s:  preload index
> 0.09    0.09    0.00    4.86%   s:  refresh index
> 5.93    1.19    4.74    79.95%  s:   traverse_trees
> 0.12    0.13    -0.01   -4.15%  s:   check_updates
> 2.14    0.00    2.14    100.00% s:   cache_tree_update
> 10.63   4.29    6.33    59.59%  s:  unpack_trees

There's a big gap here, I think. unpack_trees() takes 4s but the sum
of traverse_trees, check_updates and cache_tree_update is 1.5s top. I
guess that's sparse checkout and stuff? It's either that or there's
another big hidden thing we should pay attention to ;-)

> 0.97    0.91    0.06    6.41%   s:  write index, changed mask = 28
> 3.49    0.18    3.31    94.91%  s:    traverse_trees
> 0.00    0.00    0.00    17.53%  s:    check_updates
> 3.61    0.30    3.31    91.77%  s:   unpack_trees
> 3.61    0.30    3.31    91.77%  s:  diff-index
> 17.28   8.36    8.92    51.62%  s: git command: c:git.exe checkout
>
> Same methodology as before, I ran "git checkout" 5 times, threw away the
> first 2 runs and averaged the last 3.  I entered 0 for the "new"
> cache_tree_update line as it no longer reports anything.
-- 
Duy
