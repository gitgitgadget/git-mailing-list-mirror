Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FA1C1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 05:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbeHOIgE (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 04:36:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46737 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeHOIgE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 04:36:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id h14-v6so114780wrw.13
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 22:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YI568NamtoHiMLJ0pdofd98BaloxkEDOLEJWxCseis4=;
        b=pdfc8Cy7wmqGnNHrqtMQif6S6ccQNRDfBlYQ1WnGdFgxH+kzIK/PmHLjokM8eamHbm
         05kFl2VphcD8JYNbnlrslDj1oaEExG7nUcHfvWxWjRvrKQM3U7A0xNkIUjNxyiwuILHQ
         HqjFyt9jEvfRK+syJwYKlJNa/Ly4VSBCQCNE0ylPeQdsMMuCcWjk7o7AMTUQlMqI8DhP
         GaXcegYFjvLOepKbkBUCh2CPwQNSHxcsMoWfRsJo9FFAzgc1PgR1yHLmO+bRPkmz8tJ+
         TnMSbkuIkAF7uEYKDwD9nJNvwRAqRuiKfh97xOTrcRpr0NvvB4I1VCp6+OWPqWstpMYv
         56LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YI568NamtoHiMLJ0pdofd98BaloxkEDOLEJWxCseis4=;
        b=nmqD3MoxAUS2JcxJAhhpZAqa91g6I9dTHjE6jUMy1tzcF2UYEF9H0a0Ehu7cHLASoY
         45H3U2EsFMb/eN50mGJ1TMnmS9EmTPYzT1pDyj+axL0H1T3V+4rOIyzm9NuJapm7lGCL
         igGe7LJ8/lfMk7vVCppfXXBsA+6UoEn64Ik0Y0RVv7wfi7b/HTgul6LYQB9IJKyg+bIM
         EwvV4C+72wvtYNdlLxfjqtqhAo6ma47iMw+RiSaJdoX6bUe6RuHBN1wY+JMUpiBuEsTm
         4S3deEGC9jgURYrvN4bVRvum52fgt5SsxjDJ47068Qb4YVJ3WMcfeqt7fypZEuIfdpQK
         URRg==
X-Gm-Message-State: AOUpUlFo0H8VrjTAD4VHljtIWFSEP/qOJA3dvDZQYh7XXOxP3X3cNTfk
        03Tw3Sy/wQrP2MMfxVW7JV8=
X-Google-Smtp-Source: AA+uWPz0RA+dJLKDlEOoKHIkz3lo9P0g3P0ZL+Nko0J9vDZlUPf4kU1tl3eQVOCPwfMxE9ZDzYNsqA==
X-Received: by 2002:adf:90e9:: with SMTP id i96-v6mr15426641wri.146.1534311920942;
        Tue, 14 Aug 2018 22:45:20 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y128-v6sm960062wmy.26.2018.08.14.22.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 22:45:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, danshu@microsoft.com,
        marc@marc-stevens.nl
Subject: Re: [PATCH 0/9] Add missing includes and forward declares
References: <20180811043218.31456-1-newren@gmail.com>
        <87mutts3sz.fsf@evledraar.gmail.com>
        <CABPp-BEADR15gOrH+GBQxKLZR2fCQwhaPWgf3VS--Z0bTNP0rA@mail.gmail.com>
        <20180811173406.GA9119@sigill.intra.peff.net>
        <xmqqr2j25dlm.fsf@gitster-ct.c.googlers.com>
        <CABPp-BHZoWn-mZjop+n9PJ0+A4tZFrU6vJE+A7iSeHDXcDc=Yg@mail.gmail.com>
Date:   Tue, 14 Aug 2018 22:45:19 -0700
In-Reply-To: <CABPp-BHZoWn-mZjop+n9PJ0+A4tZFrU6vJE+A7iSeHDXcDc=Yg@mail.gmail.com>
        (Elijah Newren's message of "Mon, 13 Aug 2018 23:42:56 -0700")
Message-ID: <xmqqftzgxjww.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Mon, Aug 13, 2018 at 11:24 AM Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff King <peff@peff.net> writes:
>
>> As things are slowly moving out of the so-far kitchen-sink "cache.h"
>> into more specific subsystem headers (like object-store.h), we may
>> actually want to tighten the "header that includes it first" part a
>> bit in the future, so that 'git grep cache.h' would give us a more
>> explicit and a better picture of what really depends on knowing what
>> the lowest level plumbing API are built around.
>>
>> > So I think the better test is a two-line .c file with:
>> >
>> >   #include "git-compat-util.h"
>> >   #include $header_to_check
>>
>> But until that tightening happens, I do not actually mind the
>> two-line .c file started with inclusion of cache.h instead of
>> git-compat-util.h.  That would limit the scope of this series
>> further.
>
> Yes, this removes about 2/3 of patch #1.

Sorry for making a misleading comment.  I should have phrased "I
would not have minded if the series were looser by assuming
cache.h", implying that "but now the actual patch went extra mile to
be more complete, what we have is even better ;-)".

