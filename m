Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD0691F597
	for <e@80x24.org>; Thu, 19 Jul 2018 21:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbeGSV5r (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 17:57:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38183 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730749AbeGSV5q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 17:57:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id t2-v6so8117929edr.5
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 14:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=eI5zMmXmCd6ryaowk9m44+4OvtyiOiKlDLJ9guFPeTQ=;
        b=CkeGf4nNf7XeaMEnPFxoOPJM5Nnh/BkWxgaKDJbw+AOSlqxM7QPD5tVFHYwpVusNOZ
         3C/SlTO69YTqm9FStc1D05fLB7RA3qxvGb2t2jkaospkfUassBsdkhoVfKd4Tpc15tdl
         XhRJ/KOgbyTP6h45kkl9YXERWQ6ZCncki0JS7iLvuyNEB9pj1Gkp4SsUidTc6YcRrlpt
         xqFFJEHo1IBkQam/U9IgXdSEWu+pF4UOUwLyt+OEI2Sf1lJKY7nKIx2xaxpZHHBkMqkd
         EDTK4+UtSVvkByuuOs5L6yAGy5Fd00qGITR17oZtVkV4SqyvccUkS5krts52bl6g2pRL
         wFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=eI5zMmXmCd6ryaowk9m44+4OvtyiOiKlDLJ9guFPeTQ=;
        b=A6xgH38rp61Fx7QBSvS7V8oAl4//j0A64mV1dS0Xpzdbgrn/0OO4R9/rHPvh0urALh
         KW5Ei++Uai32V1hCBWBT2dG9ATnkaTQdYMxIoJ43CMi9s/nAzsrYOQQx4KAn+B1xpvNa
         r2wb3jT9nB82imiBPrMC4pa67iDoqy1wPcmVLs0sHB7lpoPkNz/jj1HR5AnEJuCLbsaa
         O7mTWt2tuasIPOIFyv5ba+1VCkmbo0qx7zSOrlfhUycvl+Rc/WIA+1r6xTVCpigP9TgZ
         UIrcLCLwn5gYZZ26+UTer2RY0pxfMy8CzQQLMOYA0z+U/Biyon4WZ/+N6/cptRo1iPvL
         yucg==
X-Gm-Message-State: AOUpUlFFDI23ob64PGprjqb6O5xGZ4Cn2f70oe44ae2yCaznX4wOM/vD
        cGF9mBkZLNBjlZt/wFxSBB/F3dd2
X-Google-Smtp-Source: AAOMgpcStZcXGLaTiyyomz3NbY0w1zMcPZNMaXIubQpe/gMKXMJxSjvnAynnsbcfLFcVr6hOq5jRWQ==
X-Received: by 2002:a50:97fc:: with SMTP id f57-v6mr12280830edb.21.1532034771099;
        Thu, 19 Jul 2018 14:12:51 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id b2-v6sm243900edn.27.2018.07.19.14.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 14:12:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] banned.h: mark strncpy as banned
References: <20180719203259.GA7869@sigill.intra.peff.net> <20180719203934.GB8079@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180719203934.GB8079@sigill.intra.peff.net>
Date:   Thu, 19 Jul 2018 23:12:49 +0200
Message-ID: <87y3e7aq0e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 19 2018, Jeff King wrote:

> Since this use of strncpy was verified by manual inspection
> and since it doesn't trigger the automated ban-list, we're
> better off leaving it to keep our divergence from glibc
> minimal.

FWIW it's s/glibc/gawk/. It's originally from glibc, but gawk
perma-forked it long ago, and an ancient copy of thath is the one we
use.
