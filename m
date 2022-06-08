Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE060C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 16:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245094AbiFHQHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 12:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245098AbiFHQG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 12:06:59 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873765DA4E
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 09:06:55 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s135so3678231pgs.10
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 09:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JVOzOZ/yuCD/n3SdZNSGWmnYeQjCRY+kXz3nMiydQDE=;
        b=i8bSaaC/y8IzPQgNdJwpD52mK96Ljv5JeK7Fxu+f8u/o1RWTgyUjFJZWAb07O4kxDS
         cxlY/Eupban6R0Wqu5yu1S8GGu3l/+U0IiyAdbMiok2qzVGawZW6H8Zk/5V8piVifH3d
         Psw3V786FV3vx0sA8kEcG6lZu9bT01/QMn6agTGaL6VIUc92FfXZx4Cxn9fGNJAOMRtR
         e+VCKgw/+/cYvOetQA5j8Q7YfX2baPsiT9XwfL+HjrlyxDbkbrfh9FVCTVF9u/LX40ch
         ggTwKjVZVAz98HMdj/q1i7+oPaDMQEhjsEbnXYcRF9I4SExlSBwN4fJa81Mo+VrNU92W
         6soA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JVOzOZ/yuCD/n3SdZNSGWmnYeQjCRY+kXz3nMiydQDE=;
        b=44th1gdMCOMyyfpV/wuBBQqIdsWra0dqtL1jmT0FHW35BEg98QkY29fi75lsBBouwV
         fupQgp3fFSuQIDN8Ps633VUNEJZl9xoQ/niHYmmaLkfm6zrHH7lKeinrcVYoc2U78qv5
         iNpAYoKOm8p8LHhieOmA5yQ4FZZ9r2XElmZbTtJ39+DEZMhRvhhs8Iq9YU5sGSn6Gf6l
         Z+HtNXaXqkp+pyqnaUjPhDdvwU2lZNTVID2a2sFYJ+dCFHolbR6mrnKJ8d+ox8cV7M8v
         wfJMhkHlvBB4N7+BdsTJiiP725I69z2jhMB26zepq0Ss5yDj+UgnwHLz+oB+0+ieQOCc
         BVgg==
X-Gm-Message-State: AOAM531xrrL1GlKoF8LXATJrg8FmgSmIBqLK23maQAFbNaM3uIJ2kfve
        KjS6LU5ACMp8KXgxZExhoKQ=
X-Google-Smtp-Source: ABdhPJxXfn2nLV8eOiH9Q0rsQfX+lYh9gJXnoJ72Cv+WpiDp+Qn6sAgP0ZUpDljyb0GABjHHrChnaQ==
X-Received: by 2002:a65:404c:0:b0:3c6:4018:ffbf with SMTP id h12-20020a65404c000000b003c64018ffbfmr30884779pgp.408.1654704414847;
        Wed, 08 Jun 2022 09:06:54 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:2d90:e070:30c2:fb1b:2653:5119])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm14865358pll.304.2022.06.08.09.06.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jun 2022 09:06:54 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 2/3] bitmap-format.txt: fix some formatting issues
Date:   Wed,  8 Jun 2022 21:36:26 +0530
Message-Id: <20220608160626.10332-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqq1qw0uo7l.fsf@gitster.g>
References: <xmqq1qw0uo7l.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> True.  Unless we are going to revamp the text in some major way so
> that we produce "true" HTML, not just the text source enclosed in a
> <pre></pre> pair, I would think we are better off keeping it not
> passed to AsciiDoc and leaving it in text format.  After all, modern
> browsers, which I presume those who want HTML output files would
> read them with, can display plain text files just fine, don't they?

I am not sure whether that's a good idea or not. As I come from web
dev background, I know that people get bored if they need to read
a plain-text long article. SEO optimisation also need some beautiful
designing of articles so that people can spend more time with visual
ease.

Of course, git doesn't need any SEO optimisation as it is very much
popular. But readers want some visual satisfaction while reading
Docs. That's why some people complain about GNU sites (git's site is
beautiful by the way).

Obviously, here I am using `people` to refer non git developers who are
curious about git internals.

Thanks :)
