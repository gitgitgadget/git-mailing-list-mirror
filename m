Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA8861F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 11:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbeKSWF1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 17:05:27 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39940 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbeKSWF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 17:05:27 -0500
Received: by mail-ed1-f67.google.com with SMTP id d3so24503363edx.7
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 03:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LSeUA0P72LyhCa7gsuTPvVAqkjI1CwDpmcUWBNqodK0=;
        b=PCc8PbUyI+ipgvZlvcXG36bKJ/oI9N0LWHZXvWVl6DlB6OJfKtliGqoZmbQAxSnUuS
         Q6P0Q/thpX4pKdx/Qy9dhoMe2g26fXM2znyZK8qFZDV3Aqiw5DL56EfVv46K31PGBaxj
         xvuJCkpaHFlRj+EaEpBZjK1msSRTuCfyg9KupduC4lGtjYwo2cbvWj9NouAV/EUC04z1
         1laRlgHd3R3zMPzWHN4Xqp5UgAG0QOx1Bn/naU3FwntkpueHiCjwxVIqvW2oBVRkke9R
         lWasm802LsS4UhFnJKTlKBNoGHmuVIH7sacTXz+QJm5J79NL/S8jk3Ms3NHc02P6AZcr
         wtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=LSeUA0P72LyhCa7gsuTPvVAqkjI1CwDpmcUWBNqodK0=;
        b=NX/V5++ZrVGfqwMRO9SHX1eebIFRee0MHN4q7KlxiggNLN4TJAtMKlqmUl6p7WI6BK
         ts7uCnKqChz0pQdz9gegLYcbd/OGyRGpkbC2YQDnfV6eLJdbou2M5QlOKef4SuwWlauU
         NYRx7tYUOuogjR8AyUg7PHYiVvwoUZmQYDm/vjtU4Q2L2HDF+/Fi+1nuFUl9flVCj4vn
         0swCIt9cY6SEMLjf7YOec2C84TvgXvyll0Tzf3G6wPDO6RXUVDCtLA2fMrVRhox2jm2R
         EzAhvGuze+lYn1EbrE3zWEVexA9jZVmsYLHBSpnc+wecBcQnzGrVrk49tuLvBH3yvZDr
         mnAw==
X-Gm-Message-State: AGRZ1gIlJRMoWQ7C32l/HlB7U8Zk0rDgiRnsbY6bzQlFPwEFcTCRHAne
        /O0mlW75KyIHx6i3Bw1Uy1wCYYo0aA0=
X-Google-Smtp-Source: AJdET5fwgXL+jCXP554OsSZ7PJ2NeFvx9On5SWdTGD3NEvMvtCZLlZD7ChnUP3s1Tn0A//ANQYC1EA==
X-Received: by 2002:a50:d48a:: with SMTP id s10-v6mr19514878edi.127.1542627723293;
        Mon, 19 Nov 2018 03:42:03 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id c29sm5882351eda.75.2018.11.19.03.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 03:42:02 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@fb.com>
Subject: Re: [PATCH 0/5] Make :(attr) pathspec work with "git log"
References: <20181118164800.32759-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181118164800.32759-1-pclouds@gmail.com>
Date:   Mon, 19 Nov 2018 12:42:00 +0100
Message-ID: <877eh91egn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 18 2018, Nguyễn Thái Ngọc Duy wrote:

> When :(attr) was added, it supported one of the two main pathspec
> matching functions, the one that works on a list of paths. The other
> one works on a tree, tree_entry_interesting(), which gets :(attr)
> support in this series.
>
> With this, "git grep <pattern> <tree> -- :(attr)" or "git log :(attr)"
> will not abort with BUG() anymore.
>
> But this also reveals an interesting thing: even though we walk on a
> tree, we check attributes from _worktree_ (and optionally fall back to
> the index). This is how attributes are implemented since forever. I
> think this is not a big deal if we communicate clearly with the user.
> But otherwise, this series can be scraped, as reading attributes from
> a specific tree could be a lot of work.
>
> The main patch is the last one. The others are just to open a path to
> pass "struct index_state *" down to tree_entry_interesting(). This may
> become standard procedure because we don't want to stick the_index (or
> the_repository) here and there.

Another side-note (this thread is turning into my personal blog at this
point...) I found an old related thread:
https://public-inbox.org/git/20170509225219.GB106700@google.com/

So this series fixes 1/2 of the issues noted there, but git-ls-tree will
still die with the same error.
