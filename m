Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E3C81F462
	for <e@80x24.org>; Wed, 19 Jun 2019 22:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfFSWZd (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 18:25:33 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41971 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfFSWZd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 18:25:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id p15so1515392eds.8
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 15:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f4pvc/I8Kj5DNBVcIeZJwqpTEULjNs1r50LqO9JIx4M=;
        b=sinPk0H2xCFSO4jfpqHkEi3qnJVGa6ol48+VsvjK/BtfpvvwOjunbWl09K0slpxZ2N
         ZR5Tvt8hsEmld6RTnzv4hxQXWUu5tpC+FuMVNDYhhFWhldaZvQYCSboit1Ykszda4UGu
         SFz6MnqFpAYBZ0t4nXeRGm9NY0ykzbLlqXbgclCBCInwau5kTDxhHUKO32kvCqwV36tv
         hiHvDWxLLZSVGteZfKDlMw6oJo3YdWLjucykHTm6YckIxAenAXq+YYNCeyLCEr8/D63h
         DwOWWX65jtvJpxLDIAEmCaohTpAdXXhj7bc5sWTC8r+K+EuZHlvI2qGXCwSPyNHV8a+8
         3A2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4pvc/I8Kj5DNBVcIeZJwqpTEULjNs1r50LqO9JIx4M=;
        b=gLM1h7XiHKSRQfUNVYhuPpsDTl6dG0m5ddc8ycBx+ABbgNpDdWNYaoY0UFVJhHWfOA
         W78yi8TDJt2yS9jAZDXkkYpnh30I7r4WJepU17wpmFYndno0lshVu1M4aZddKPYKUS5j
         +TLIX/cudyFvHdF3tl2G7v6Y++7x7lgqeknGPVUyvrxYFViaZwasib14XOx+jllfh4SA
         Wm4a1s4MqKKbbC43n2BsAJhamAlg5cF1kYm7V2qkOWw3dq5yB+Ln5wqqTtA+ULyMXysl
         lrdMu7Db2CzvUG0wVWQyBhEwF/CW7Bq3PwtByktLjqgpa+MFYiZuxi1s7crgo8IUyg4J
         drlg==
X-Gm-Message-State: APjAAAWDMBFjeQBBru11kridovK1uozdl+8nHU8nqLyVNz5wJR8qr9yE
        K0q+AOtciLZ2OXj8f7U5Z3Ki7yuqgz3Tf+8FlVs=
X-Google-Smtp-Source: APXvYqyfQtuh2tsdnxyHfoUdkkAj3cm8dSXStMLNJsGMf/mhoZE6LmPTeTLsgd9ukbuQ18hS8fGvfYlOKBHIpPITgjE=
X-Received: by 2002:a17:906:2594:: with SMTP id m20mr110130897ejb.217.1560983131632;
 Wed, 19 Jun 2019 15:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190615100702.20762-1-chriscool@tuxfamily.org>
 <20190619214212.GE6571@sigill.intra.peff.net> <20190619220925.GF6571@sigill.intra.peff.net>
In-Reply-To: <20190619220925.GF6571@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 20 Jun 2019 00:25:20 +0200
Message-ID: <CAP8UFD2=_q==e0UxFyHrZS-Bue36PDow28DpFBURnkG=0brUcQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Test oidmap
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 20, 2019 at 12:09 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jun 19, 2019 at 05:42:13PM -0400, Jeff King wrote:
>
> > I do think that sha1hash() will eventually go away in favor of
> > oidhash(), but we can approach that separately, and convert oidmap along
> > with everyone else.

Yeah, deprecating it is a different topic.

> > It looks like we are close to being able to do that now. Grepping for
> > sha1hash shows just about everybody dereferencing an oid object, except
> > for the call in pack-objects.c. And skimming the callers there,
> > they all appear to have an oid object, too.
>
> Actually, it does get a little tangled, as our khash implementation also
> uses sha1hash (though IMHO that should become oidhash, too). There's
> also some preparatory work needed in pack-objects, which I've pushed up
> to:
>
>   https://github.com/peff/git jk/drop-sha1hash
>
> I got interrupted and may try to resume this cleanup later; mostly I
> wanted to post something now so you did not duplicate what I'd already
> done.

Thanks for your work on that,
Christian.
