Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A1E51F859
	for <e@80x24.org>; Mon, 22 Aug 2016 13:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754383AbcHVNW1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 09:22:27 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37961 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752299AbcHVNWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 09:22:25 -0400
Received: by mail-wm0-f54.google.com with SMTP id o80so143832512wme.1
        for <git@vger.kernel.org>; Mon, 22 Aug 2016 06:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lFAB2C6uJWcmqeBO+hHROTq1IuP9ZNElw5KkMal+8BY=;
        b=qQelDdfZfTz0Iy4gx6ayEK4lRimXCY6iqOir7XY2HbWWPmieslAxO9QWh8q8NfTTE+
         Ew/4LSn+MzNeKAYq+idJzVjmeDFLJrCm4sn20SgJIuqenggeJ6iY4Hs+lIEVTBO2NAi6
         yQ5l8pMgoFmD//KmI8P1yX7vwgAGti0tSUT/vhnqE24mwXvyWqCcg3hqWlT+VpTM5/s5
         JgC4+ICDzPqa924luGWEIBpJ2JQaKnJZu7HKV5/bhKKXdxL4ClUSG6wySjl4SlZQ28TU
         CJLHuZSjzbNLWblz8gJ5hYf3d/o/wsjz+ZkwB7MpSO7h+GYcfPerOzGxfNdHtTJPyslZ
         9FAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=lFAB2C6uJWcmqeBO+hHROTq1IuP9ZNElw5KkMal+8BY=;
        b=WM/Lr/gU3mOTCCpj/sBYYmIaV9vVNse+A/r6qF71xbiSpHR6EwNl/eg7ciSPRdv2bN
         1tJYX79gAqqtcHn0t+3f+fLRnLYaSk5yXcRGlVGwjFVsAS0OOFgAgt2gSzZHPPMS1Du+
         7QezcWlSMYxu/DYZLxJZ9gjEsoO2rMH+oVQ5ecLR6TvnFAH8VP/5pQLHIxMUsbq2K/wl
         Di8vG+SVUQpBvptuxg0wQapGDjaOhtk7om1fPEST/l6roMimWaTAXTk06/V8XbbKDi/i
         MEeoQIXooU9wgcXOL9RSGmqz7msCf74KLKYUkIeSoj36Ep9RPjVzUCtwyMP8qwppu1bc
         0SqQ==
X-Gm-Message-State: AEkoouv7LxNERMQuHZ/tRSZOCYqnlsDfOpZNabuz3Mdfka/M1qK/iFHAORYPfHgCCaQhEA==
X-Received: by 10.28.62.204 with SMTP id l195mr14536948wma.117.1471872144525;
        Mon, 22 Aug 2016 06:22:24 -0700 (PDT)
Received: from anie (anie.imag.fr. [129.88.42.32])
        by smtp.gmail.com with ESMTPSA id d62sm21448051wmd.7.2016.08.22.06.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Aug 2016 06:22:23 -0700 (PDT)
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
        <vpqr39harit.fsf@anie.imag.fr>
        <CACsJy8BNP8GDRxDGTQwcYWTovN9o11TCkUJ28=5zav3QnGv9nQ@mail.gmail.com>
Date:   Mon, 22 Aug 2016 15:22:22 +0200
In-Reply-To: <CACsJy8BNP8GDRxDGTQwcYWTovN9o11TCkUJ28=5zav3QnGv9nQ@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 22 Aug 2016 20:09:39 +0700")
Message-ID: <vpqlgzp9bw1.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Aug 22, 2016 at 7:59 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> On Sun, Aug 21, 2016 at 4:08 AM, Jakub Narębski <jnareb@gmail.com> wrote:
>>>> W dniu 19.08.2016 o 15:54, Jeff King pisze:
>>>>> On Sat, Aug 13, 2016 at 03:40:59PM +0700, Duy Nguyen wrote:
>>>>>
>>>>>> Ping..
>>>>>
>>>>> There was some discussion after v4. I think the open issues are:
>>>>>
>>>>>   - the commit message is rather terse (it should describe motivation,
>>>>>     and can refer to the docs for the "how")
>>>>>
>>>>>   - the syntax might be more clear as:
>>>>>
>>>>>        [include-if "gitdir:..."]
>>>>>
>>>>>     or
>>>>>
>>>>>        [include "gitdir-is:..."]
>>>>
>>>> Or
>>>>
>>>>          [include "if-gitdir:..."]
>>>
>>> I like this one. I can re-roll to address the first two bullet point,
>>> if the last one, the open question, will not become a blocker later
>>> on.
>>
>> I think the syntax should be design to allow arbitrary boolean
>> expression later if needed.
>
> I would be against that. We may extend it more in future, but it
> should be under control, not full boolean expressions.

Why?

I'm not saying we absolutely need it, but if we allow several kinds of
conditions (gitdir-is:... and others in the future), then it's natural
to allow combining them, and arbitrary boolean expression is both simple
and powerful (operators and/or/not and parenthesis and you have
everything you'll ever need).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
