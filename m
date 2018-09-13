Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 097E71F404
	for <e@80x24.org>; Thu, 13 Sep 2018 18:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeIMX7s (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 19:59:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43568 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbeIMX7s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 19:59:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id z27-v6so5445059edb.10
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 11:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=yedzpdG3V7iwaZvJ1szrshdwVPbNop2eEBxXuTNsVEM=;
        b=iJbwTfxE1GeT0E11Xo2kVAAyAqpscXYIu5s3xoF5fYltbD2B2U427Fa8g11UO+znxJ
         iX977HaqC1+KL/sY0W6FBKzE7AIfisMnrePZg+LshimTTuR6MKSv+4KSVVN+FETwQ4Af
         RLL4j6vykHlbdMGe/tKIV7CXKDvygLR5oE+hlg/wv7DUDuQyqqSF+7lr3UUMm9hBjKxL
         4wsugtpyOs7hrL5iyIS905nutZvnCV4VwgtUdB81Uot+LlzuDMT2cSA6Azn53rbtdusf
         ZYbyD4G9BatnGVJpFGAsvLjDeazqLJ2gl5thVqsBU0Jx/2/Lc5f35d9tfdKtxXbukPDZ
         3yjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=yedzpdG3V7iwaZvJ1szrshdwVPbNop2eEBxXuTNsVEM=;
        b=Gky8R/2lVxC+Y4EpDfM3xiZtjZ85HUoa4yN5ulGY2GhkakjywvW/igm4LGr/RRQnAA
         T59+6zn5B0d2akH104qXmRq9m0jdo564wle5f4QesJND/qheBTS6WFwmQxivKk2N4hgG
         p1EmUBWuONx4R7C3uIb1bEuIvjHMJIbeweMFaP1PsNEx+4itjM3KPLfQFimA9SMRDReI
         KG+Q3Cdi8LIHb6T20gwBVsb9aCNchoe9pFVGBim8iz2s8QwtAWNGVwDZTvVe+5Sl6GeB
         ac/eRQuUJ5cj/da+tNt+pw0ntENJg6M7dD7TgpS/pFslGE2o+spP8dVowFwsggriUat1
         AFcg==
X-Gm-Message-State: APzg51BKnXh7WEIdQ7uNkm8eS8O8tIiDGROBLXwTsgotT11duCQRFzIL
        +NdX0sqzk7W1dMj1HkPZ1NNByIxorx4=
X-Google-Smtp-Source: ANB0VdZKRylF+6FrYv4khgLxA8pao/R5B0WvGFwTvIikKqivYgQvItdEOJmhhlggOLnk/SAZQuGbQw==
X-Received: by 2002:a50:91da:: with SMTP id h26-v6mr12970833eda.87.1536864542453;
        Thu, 13 Sep 2018 11:49:02 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id l16-v6sm2337734edb.41.2018.09.13.11.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 11:49:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v1] read-cache: add GIT_TEST_INDEX_VERSION support
References: <20180912212544.33624-1-benpeart@microsoft.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180912212544.33624-1-benpeart@microsoft.com>
Date:   Thu, 13 Sep 2018 20:49:00 +0200
Message-ID: <87in39kzc3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 12 2018, Ben Peart wrote:

> -GIT_TEST_OE_DELTA_SIZE=<n> exercises the uncomon pack-objects code
> +GIT_TEST_OE_DELTA_SIZE=<n> exercises the uncommon pack-objects code
>  path where deltas larger than this limit require extra memory
>  allocation for bookkeeping.

If re-rolled maybe better as a leading "fix a typo" patch.

I was reading this in a mobile client earlier and couldn't see at a
glance (small screen+wrapping) what the change was here, so that sort of
nitpicking isn't purely theoretical :)

> +GIT_TEST_INDEX_VERSION=<n> exercises the index read/write code path
> +for the index version specified.  Can be set to any valid version
> +but the non-default version 4 is probably the most beneficial.
> +

I'm not familiar with this and haven't dug, so I don't know this: are
any values of 1..4 OK? 0..4? Would be better to say that here...
