Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEFF11F859
	for <e@80x24.org>; Mon, 22 Aug 2016 13:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753629AbcHVNAU (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 09:00:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35559 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754692AbcHVNAD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 09:00:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so13379591wmg.2
        for <git@vger.kernel.org>; Mon, 22 Aug 2016 05:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4YSgzZp7DzJxs9qxCqs7INj/+gfCGNQkP2AOWBUkhQ0=;
        b=fthLTHp3qSMMem434qTCRE0u4V9jyET1a9t3CLD7woK2wnIP1iCKvbc+79ekSBake/
         B1TqLfFy4NJIMQv+dp3sleZe0PVmtxJzEe6dcCeqI3MXXNPuZGatYVkfLrO9gl+CZ9r8
         KPO9wqoxoxBetcAmVmuDt5ZrIfPGHoelxHm955551XApobvEaW6CQKKBsNX2lZs2mndm
         bPvurn7P0qDLvec3nhdpyFL3g/NAGIJnXjm9yY4DyQMhPZNrmaSkUDHux2lYLwqMkY7z
         kWZfnqx1RLhlN9mpE/YkJuyXDWtLZmyCa16L+d/BJ5SLH1eM0nVzWqCjJI03ODHulUSG
         kbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=4YSgzZp7DzJxs9qxCqs7INj/+gfCGNQkP2AOWBUkhQ0=;
        b=FjWzWDzci6LJzh9TDesMUlbXTXh7Om+uRVFEhMhlRNSnbJvMZouVVIvWdJoM6joFl+
         X4YBJZBEj35+IEXdY1wz+xZ8CtipEHrlWpdFQj0BOgUOFtYcswJW73T8XDKQTNDz0eiY
         V8lqXmzNcH8/hlEJnlmxoeRCCHqmRN1YZbpdCKvnIFpg/V2MZZ0HZYz/iy/Wcubn5hhH
         t3S5/cvokbsXkWGsi0JXWi13gc8996v9M6TPJWdvT83e/FHXsth5d7462JpOsUoq7Kns
         1KVLIZBuIUYbHrL9hPJ291+7rflUjGJ/yhic1yWoR7VJIp/Ko84uWbKReg2bjpTejCBy
         tbIg==
X-Gm-Message-State: AEkoouu9D6WIO3Kzrz4oZYgU1QFda4Z64y1pNSwFzsAiOIickpht1lyuZPn/N7FFEqyRtQ==
X-Received: by 10.194.48.39 with SMTP id i7mr19881232wjn.173.1471870764101;
        Mon, 22 Aug 2016 05:59:24 -0700 (PDT)
Received: from anie (anie.imag.fr. [129.88.42.32])
        by smtp.gmail.com with ESMTPSA id pm1sm23917987wjb.40.2016.08.22.05.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Aug 2016 05:59:23 -0700 (PDT)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v4] config: add conditional include
References: <20160712164216.24072-1-pclouds@gmail.com>
        <20160714153311.2166-1-pclouds@gmail.com>
        <CACsJy8Bw0ZNu-6SB0P3dBZCLMJWJkbUqb64H_QOcn4UH+_AcNA@mail.gmail.com>
        <20160819135408.ckyw6ruseicvg2jt@sigill.intra.peff.net>
        <5c131421-ae7f-8a37-76ab-0fd05cbe3530@gmail.com>
        <CACsJy8C30=-LGMYQJ6MO17L8Vv1q=iQGC=R8TDhC5qM1f5Lh5A@mail.gmail.com>
Date:   Mon, 22 Aug 2016 14:59:22 +0200
In-Reply-To: <CACsJy8C30=-LGMYQJ6MO17L8Vv1q=iQGC=R8TDhC5qM1f5Lh5A@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 22 Aug 2016 19:43:49 +0700")
Message-ID: <vpqr39harit.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Aug 21, 2016 at 4:08 AM, Jakub Narębski <jnareb@gmail.com> wrote:
>> W dniu 19.08.2016 o 15:54, Jeff King pisze:
>>> On Sat, Aug 13, 2016 at 03:40:59PM +0700, Duy Nguyen wrote:
>>>
>>>> Ping..
>>>
>>> There was some discussion after v4. I think the open issues are:
>>>
>>>   - the commit message is rather terse (it should describe motivation,
>>>     and can refer to the docs for the "how")
>>>
>>>   - the syntax might be more clear as:
>>>
>>>        [include-if "gitdir:..."]
>>>
>>>     or
>>>
>>>        [include "gitdir-is:..."]
>>
>> Or
>>
>>          [include "if-gitdir:..."]
>
> I like this one. I can re-roll to address the first two bullet point,
> if the last one, the open question, will not become a blocker later
> on.

I think the syntax should be design to allow arbitrary boolean
expression later if needed. Then, I prefer one of

  [include-if "gitdir-is:..."]
  [include    "gitdir-is:..."]

because it may later be extended to e.g.

  [include-if "not(gitdir-is:...)"]
  [include-if "gitdir-matches:regex"]
  [include-if "gitdir-is:... and git-version-greater:2.9"]
  ...

I actually already use "conditional include on version number" because I
use push.default=upstream which makes older versions of Git crash, but
fortunately these versions of Git also ignore the "include" directive so
having this push.default=upstream in an included file works. It's a
hack, it worked once but it won't work again.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
