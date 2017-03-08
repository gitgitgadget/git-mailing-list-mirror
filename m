Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC38B202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 15:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbdCHPHk (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 10:07:40 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:33442 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbdCHPHi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 10:07:38 -0500
Received: by mail-wr0-f182.google.com with SMTP id u48so25417198wrc.0
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 07:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9fXvHgTUpLLkZFKWuFEbCcDOpwFrh33Z2Gu2FRGajDE=;
        b=HslVGObLhfTTiS80SOe3ZP0Cfm3kZKjC+oh3LQM0ZPBn2eG3IQEJJH+9VDg0YTg0Vn
         6+ntuRL2kEv7qu/MjqC37am5UEyZT44qtw/yyT9AShUFEeA/eeuBZnO+T9P2tzvQEDmx
         2CBSC1LA+6S/d6uIhbxGYk6gD2rqDJ21N1I7p23tkBVhEJpTq+6WDmugj1lNY3us6Vl6
         9bJxyJDkKNwcjzGF5iICMhIi5piRkHvNxgPtlW7t190X4C++upzFt5xVG9h0MEyZtj44
         Qo8c01iokoS8FeGymDg8deszz8B6NJIevOx51+zxjPZHprdUE8MFzyXXhZz1a13oAtlT
         XPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9fXvHgTUpLLkZFKWuFEbCcDOpwFrh33Z2Gu2FRGajDE=;
        b=R21PvkH+KzY+ylRBmEO2gZ9GvLxuRKSU0I6ub3ZDbW2Hg8XSgII/FOok18Cu8QOOrm
         bveir3prGvLIVcCs9YMs79OkDf7XVZHsbvdQsmrTfvvUdH6dTE00H7IM6FgqhoWxjhTX
         QTw5+MOFbukE7lMxjy7txE/WCwGW8GjUlW/ALDMFp6WbZyOWMaMPbixTwTNQcf848+Cb
         7GfJjIsmNVsxpsiocMs7++zOeuqC4dqGqRIKObm0yUctcTF4aqI0WH68cq0/RAr3PSfQ
         TP04mHxdGR6o0ylv+B1IEslMzBBThX5NOPjf03JYNPqncmGXA1sWJ/lhNj+9Gx4MEa5t
         813A==
X-Gm-Message-State: AMke39ldhBtTCw4BwfRoRlSuNs+KVZVEA/iBDS6KPa+5CR0VUPuY0xN1B085XSCg4QIbBcbeys4cEqgIWOfinA==
X-Received: by 10.223.177.148 with SMTP id q20mr5967071wra.154.1488985652121;
 Wed, 08 Mar 2017 07:07:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.126.201 with HTTP; Wed, 8 Mar 2017 07:07:31 -0800 (PST)
In-Reply-To: <20170308140110.wgdedquqwm75zws2@sigill.intra.peff.net>
References: <5e5b1b92-f7c6-2987-356e-1aab2bff557e@gmail.com>
 <20170308133348.2ovfsi44vq2rpgom@sigill.intra.peff.net> <CAHGBnuM3iM-kHdxdox_1i56uLbv7gQ5ZUY9Xqf4BG7G_kTf+jQ@mail.gmail.com>
 <20170308140110.wgdedquqwm75zws2@sigill.intra.peff.net>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Wed, 8 Mar 2017 16:07:31 +0100
Message-ID: <CAHGBnuPGPcWwbrZX_92XDJu47bpH=kj2PZ7yWHK=MRfZ_RHXrQ@mail.gmail.com>
Subject: Re: diff.ignoreSubmoudles config setting broken?
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, Jens.Lehmann@web.de
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 8, 2017 at 3:01 PM, Jeff King <peff@peff.net> wrote:

>> > Hrm. Isn't "all" the default? That's what git-diff(1) says (but I've
>> > never used the feature myself).
>> >
>> > That would imply to me that there's another config option set somewhere
>> > (perhaps in the repo-level config). What does:
>> >
>> >   git config --show-origin --get-all diff.ignoresubmodules
>> >
>> > say?
>>
>> It says:
>>
>> file:/home/seschube/.gitconfig  all
>
> OK, that looks right, so my guess is probably the wrong direction.
> Peeking at the code, it looks like there may be some per-submodule
> magic, but I don't know how it all works. So I'll stop looking and wait
> for somebody more clueful to respond.

+ Jens

-- 
Sebastian Schuberth
