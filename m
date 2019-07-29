Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5539C1F97E
	for <e@80x24.org>; Mon, 29 Jul 2019 12:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfG2MvA (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 08:51:00 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:45885 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfG2MvA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 08:51:00 -0400
Received: by mail-ed1-f54.google.com with SMTP id x19so53282525eda.12
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 05:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=LuekFi6Sm4A2u9/PU4HgBZUywZFliYHRPmd1kRFIV/0=;
        b=U+jbNKv0VOO9wVK46weA42pbyRewztDuW8RYek95ZT245zeNgx8yzrUqr5AtVjzLUT
         xDh+GCSp3eWGSmu4kdT/UAiCbyCbNGYX7lL0zRedvh+qP5U7bqKp09b7XV7cupeWmUCI
         etIKJTkdnwiaTvpq+iXVqCOA2ZTLfTRygNCz0cZD/DSbRHMgcGN+I8+UogNHfZakikGZ
         Mlsp18mf4fjj70omDWFgdVhITUx4y2kpa3X9af8LMnkbkQJBQc5B1Hz+ZGXONhlTO01J
         hf07BsbhCmN3HTz+0nj6TU+dbxxMtObqc1Q4BI6v8HeyBU6/06lp8x4TESXZL+aSUriR
         XWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=LuekFi6Sm4A2u9/PU4HgBZUywZFliYHRPmd1kRFIV/0=;
        b=pAugI7Y6wfbzD9bqrw2iWvo+eihFxuEp4M+MMeYs1N7CcJ4RO95k6zlN4LfnAepvJU
         D2a8dyyNxoojcHcy++z+SGKND0/ZvUKOsNAPQUOVWeE77cNeWDds7O3+zSM4brxG8zGo
         dDwFoN7d2LnXHwxqhbFoiJDEqjSAZqerrnpuneCX9tA6qpglOgNBWMUwm6q5g0LyHISN
         RS+OgjIpajIZCuuW5Tu3AmuuP6EkihSQ9+PK9W6ND4EdVThHDcGIeqgPdJOFHt+FOz46
         fq76MSrRNaaK9Zx1vemRixr3Hzc9fnup6ruWqbbO78yFhc8OXTIC9nj7jjfsqnN0D5cX
         ohbA==
X-Gm-Message-State: APjAAAUc+7QImCLTOL/1KqdfaGEyrlpiqiAaWz2iydukIu8a39BRuTzd
        L1UaxDtk5Bz3Xfg27EWcr03rqf7xGP4=
X-Google-Smtp-Source: APXvYqyT3JtQyjglo8rJX0OD+IZXmHN5NbTFRiHHAxbD1chivAXB+u7PGeM66dgcBsTl4u4gPxU3MQ==
X-Received: by 2002:a17:906:489a:: with SMTP id v26mr84973240ejq.234.1564404658266;
        Mon, 29 Jul 2019 05:50:58 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id bq1sm11509774ejb.45.2019.07.29.05.50.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 05:50:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Gregory Szorc <gregory.szorc@gmail.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
Subject: Re: Warnings in gc.log can prevent gc --auto from running
References: <qhdnuh$5m5r$1@blaine.gmane.org> <20190729100745.GA2755@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190729100745.GA2755@sigill.intra.peff.net>
Date:   Mon, 29 Jul 2019 14:50:56 +0200
Message-ID: <87v9vl57in.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 29 2019, Jeff King wrote:

> On Thu, Jul 25, 2019 at 07:18:57PM -0700, Gregory Szorc wrote:
>
>> I think I've found some undesirable behavior with regards to the
>> behavior of `git gc --auto`. The tl;dr is that a warning message written
>> to gc.log can result in `git gc --auto` effectively disabling itself for
>> gc.logExpiry. The problem is easier to trigger in 2.22 as a result of
>> enabling bitmap indices for bare repositories by default and the
>> behavior can easily result in performance degradation, especially on
>> servers.
>
> Yuck, thanks for reporting this.
>
> As you note, this is a special case of a much larger problem. The other
> common case is the "oops, you still have a lot of loose objects after
> repacking" warning. There's more discussion and some patches here:
>
>   https://public-inbox.org/git/20180716172717.237373-1-jonathantanmy@google.com/
>
> though I don't think any of the work that came out of that fundamentally
> solves the issue.

To add to that Gregory probably finds these two old reports of mine
interesting. The former is pretty much his report (but for a different
root cause, the loose object issue):
https://public-inbox.org/git/87inc89j38.fsf@evledraar.gmail.com/ &
https://public-inbox.org/git/87fu6bmr0j.fsf@evledraar.gmail.com/

>> I don't prescribe to know the best way to solve this problem. I just
>> know it is a footgun sitting in the default Git configuration. And the
>> footgun became a lot easier to fire with the introduction of warning
>> messages related to bitmap indices and again when bitmap indices were
>> enabled by default for bare repositories in Git 2.22.
>
> IMHO one way to mitigate this is to simply warn less. In particular, if
> we are auto-enabling bitmaps, then it doesn't necessarily make sense for
> us to warn about them being disabled.
>
> In the case of .keep files, we've already got 7328482253 (repack:
> disable bitmaps-by-default if .keep files exist, 2019-06-29), which
> should be in the next released version of Git. But I suspect that's
> racy with respect to somebody creating .keep files, and as you note
> there are other config options that might prevent us from generating
> bitmaps.
>
> Instead, it may make sense to turn the --write-bitmap-index option of
> pack-objects into a tri-state: true/false/auto. Then pack-objects would
> know that we are in best-effort mode, and would avoid warning in that
> case. That would also let git-repack express its intentions better to
> git-pack-objects, so we could replace 7328482253, and keep more of the
> logic in pack-objects, which is ultimately what has to make the decision
> about whether it can generate bitmaps.

Sounds like pentastate to me :) (penta = 5, had to look it up). I.e. in
most cases of "auto" we pick a true/false at the outset, whereas this is
true/true-but-dont-care-much/false/false-but-dont-care-much with "auto"
picking the "-but-dont-care-much" versions of a "soft" true/false.

On this general topic a *soft* poke about relying to
https://public-inbox.org/git/8736lnxlig.fsf@evledraar.gmail.com/ if you
have time. I think a "loose pack" might be a way forward for the loose
object proliferation, but maybe I'm wrong.

More generally we're really straining the gc.log pass-along-a-message
facility.
