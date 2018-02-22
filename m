Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 349481F404
	for <e@80x24.org>; Thu, 22 Feb 2018 14:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932653AbeBVOS7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 09:18:59 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:55104 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932626AbeBVOS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 09:18:58 -0500
Received: by mail-wm0-f42.google.com with SMTP id z81so4207688wmb.4
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 06:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=thLKr8XshFxywVUd6adD0Ivtyi4foZzDf6UlbTyGNW8=;
        b=EMyArO9It0FQ8vURYWCkYQj0zXVOVZvZDw3cSVmVcq3C6UnU8gsEJHONTavNXJZ4R9
         zPPU7B9QDVHEHJj80DQWaYm/4UHuX8PHE9CNtVESFIVbpsFVRspHqDgXWNqEiBoRLbd9
         UrKaXMiNbDDK0HvSP5+li7y5wgEieni2FkaCHHZNxwxq0+7FcWcWn1NiyiveJ5T2dDXk
         oehjmAgcfirQ9PP4YPBoeycbtJvGKdRKsQw8FiGdAX6ChgaaDHlzhQFdyynjb0U/Xubb
         AiPKngYtZ108M06kdZXjEWFnfw3audhoiehVrWalJNnSuSrPVLpv6W6jiIdMcMfrxVeR
         iH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=thLKr8XshFxywVUd6adD0Ivtyi4foZzDf6UlbTyGNW8=;
        b=TCiI8zTB4eEn4fMSMJuZkLoZUDeFd8h9+Tv7OYWEeOk9tTa1dzViLrcJT3rpsF6Z6A
         pm7hhHDlHEpq5m3+vNENCOHIE/iC+mZ9iXbqSMXzUq02DhfBIAQjQjG0o+XBu0QDwhDO
         2jTvaIjPfSDa5fFDukRjAdQi8+7O53TevYGjjFQyyhIhGagwY9b7c9ZyDxB8j5dLJIVC
         wLx2Lr8Fvaja14Xp/dNxDQrP4xLyYpHzi0LlEZ8oZSVPkK+qXOIh4cg5+4R6q0zNj+Pe
         d730/5fAkJPHpoq9HMcr5gIHXjCrj7SRRRqFv7LRUtLl8N7NpzXgZExu9Rmj/odlJjWi
         o7HQ==
X-Gm-Message-State: APf1xPA/chfRpmdGcXrAuYtU+jQxHHzWdXXxFmlLwgRsFBPLWsaLnh5q
        9VPsXHftN+pdsvoHCzpb6bxEMeqC
X-Google-Smtp-Source: AH8x2245QxOYl0UnXACLiOmmK8WiKR9/abeNnc/T+D/1cUcUuDEtCLuN22YFeLEVRtFm4Ykw85qnZw==
X-Received: by 10.80.218.4 with SMTP id z4mr9649501edj.173.1519309136841;
        Thu, 22 Feb 2018 06:18:56 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id z102sm323538ede.45.2018.02.22.06.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 06:18:54 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v5 00/17] document & test fetch pruning & add fetch.pruneTags
References: <20180121000304.32323-1-avarab@gmail.com> <20180209203216.11560-1-avarab@gmail.com> <xmqq606pyiqo.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <xmqq606pyiqo.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 22 Feb 2018 15:18:53 +0100
Message-ID: <874lm9f6pe.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 22 2018, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Here's a v5 (correct subject line this time!). Many thanks to Eric for
>> a thorough review.
>
> We haven't seen any comments on this round.  Is everybody happy?
>
> I do not have a strong opinion on the new feature, either for or
> against.  I didn't find anything majorly questionable in the
> execution, though, so...

I've been running that here on thousands of boxes (that are actively
using it) for 2 weeks now without issue. Would be great to have it
merged down & in 2.17.
