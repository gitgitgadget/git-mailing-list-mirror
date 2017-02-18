Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE74A201A9
	for <e@80x24.org>; Sat, 18 Feb 2017 05:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750807AbdBRFfe (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 00:35:34 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33527 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdBRFfd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 00:35:33 -0500
Received: by mail-pg0-f65.google.com with SMTP id 5so6601922pgj.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 21:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=smOr5nqEwu5LNQrp4tfQYyigh98VRQ0nJmQfSoUSfH8=;
        b=ZyE7QfiVHDs6ltE0rJL50Q/XmGjobnAGbvbW/mpm8Q4d87xU5BwxREDPzhWXcM0ZYq
         sTVqW6WukZ71fuITG0TatXnNbrwH2OZDmo0mPek5o9511XoMNg/nrdyPFrqBALyIHFRx
         V4bAgb8XC3Vm4MVYJpEGws++Bdtfln/S5KLq6tk/WecEptRJBj3uQMtXk3Vmb5YYzeIS
         rkWG0+F+jbNnIzpQYgShj++u2KwBtQXzsTGAuUryb6olpGqLV8rfiKS4B9YW3KV/jdgm
         /6UObh1eZnXmGDP7LQWB587AcHQmQq/IOH3UxtKwR5Lb9bponYwQ6IEKWNQBwzCGMfRN
         ypnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=smOr5nqEwu5LNQrp4tfQYyigh98VRQ0nJmQfSoUSfH8=;
        b=JbEOgeOYdRUSoWsVn7glNDnfkSwV+MrMvQ4ZOQDhhn0mxo9sqA3YR5paKCUFVgRVyz
         tOPdvsLheb0lt1lChupPXVLu6rSEZqX+LwgL8jrQN+SgMg51hNZwWrDOyVo6GKU2+uFa
         SaOfISIRYhHatZLOpdE23f+8tiIVwFk2OEtczFywVMl2Hhi3uvbJWE2DnL33oFudat/A
         did9KpeoLxlf9Hfw/6ngJ1BOtAnX0MbbIE0kOp2Bo6pi1RVaddEwgmhc4lCXvCIDjKJm
         WNCuAROKrICUkkFM8E/n5NkDq7dHXEwBdjc1VWIh/cJXf+XToXT5rrkWt6DrGri6NnW4
         qsrw==
X-Gm-Message-State: AMke39kE0uZ0U7IBCu4F6/0Uzpg8oe9AUZZ/AV35DE6mTelkDnRld2YMQjjxvEd6eVVRPw==
X-Received: by 10.98.196.1 with SMTP id y1mr13526284pff.105.1487395652614;
        Fri, 17 Feb 2017 21:27:32 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id f188sm22489512pfa.35.2017.02.17.21.27.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 21:27:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] show decorations at the end of the line
References: <alpine.LFD.2.20.1702110943460.31350@i7.lan>
        <CA+55aFw2S14a4_4YK0b6PNK4TH_AUo_+2JN+PTyBTufNeB5t6A@mail.gmail.com>
        <xmqq1sv2fq6m.fsf@gitster.mtv.corp.google.com>
        <CA+55aFy-vvOBu5Y4KDeteUyK-7U7yTa1HoqHo+hME1=8bq7Xhw@mail.gmail.com>
        <xmqq7f4tdcua.fsf@gitster.mtv.corp.google.com>
        <xmqqr330779h.fsf@gitster.mtv.corp.google.com>
        <20170215002901.gtzegvhyy7d6cvrb@sigill.intra.peff.net>
Date:   Fri, 17 Feb 2017 21:27:29 -0800
In-Reply-To: <20170215002901.gtzegvhyy7d6cvrb@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 14 Feb 2017 19:29:02 -0500")
Message-ID: <xmqqefywnk5a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> The updates to the expectation look like this (already squashed).
>> The --source decorations in 4202 are also shown at the end, which
>> probably is in line with the way --show-decorations adds them at the
>> end of the line, but was somewhat surprising from reading only the
>> log message.
>
> Hrm, that does surprise me. I'm not sure if that's desirable or not. I
> do think some of the "nobody could possibly be parsing these" arguments
> about decorations do not apply to --source (and also, they're harder for
> humans to pick out from the end of the line as they lack punctuation and
> color).

I just got bitten by a fallout.  I have

    $ git recent --help
    `git recent' is aliased to `log --oneline --branches --no-merges \
	 --source --since=3.weeks'

and often do

    $ git recent name-hash.c

primarily to see if I already queued a patch series to a topic (and
forgot about it), and/or what other recent topics in flight touch
the same thing.

I'd need that the topic name to be shown rather prominently for this
use case, i.e.

    eb2263adb1      jh/memihash-opt name-hash: remember previous dir_...
    0c04267dc8      jh/memihash-opt name-hash: specify initial size f...
    57463ce445      jh/memihash-opt name-hash: precompute hash values...
    dd3170e2cf      jh/memihash-opt name-hash: eliminate duplicate me...

but now the branch names are shown at the end, which defeats the
whole point of the alias.

If nobody gets around to fixing it, I may take a look at it when
able, but for now let me just vent^Wreport a regression first.
