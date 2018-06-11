Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D3B01F403
	for <e@80x24.org>; Mon, 11 Jun 2018 22:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbeFKWfd (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 18:35:33 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:41654 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbeFKWfa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 18:35:30 -0400
Received: by mail-wr0-f178.google.com with SMTP id h10-v6so22000423wrq.8
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 15:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bh2rdI8vdV3ypK7y73AyyWY8WI8lQHAQ+1iRoQ7zSgo=;
        b=cLKezLL1IuOzhfGI5bKdHojJKh86rrCzyXEiSVVlZBI8MvDX2di2BA6STb9OfYaDF+
         aph4jtQatSMSFBV23LOXvcNu5YYnrNkDpK6mieQicWBOk3onHjDoMYpScIg5yAgjyOwz
         JUhAAM6t1Y4UMD9KOcPA1HRWIyqn6xYiKwjMX+7XkhRmiYdK7yHIgYKjAKtx3jecZwzb
         UwHEAiSHZ1V9J1uS7Ji01gXduyjMvrrnXzZ+aTJcFAzEoinHIDkPKwhBbR/Yz6Nuq1US
         UtHBpqkDOO/xuceM6mHmt/ypcRrgKmlQ1w8jGk0tX4v2cdv2i9YCkl10IJ1/nuknTndo
         Qk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bh2rdI8vdV3ypK7y73AyyWY8WI8lQHAQ+1iRoQ7zSgo=;
        b=RY6Vm2ftf71rAVfpWXJWp4UuH6UuGJVOKCbHo4kcpQzEdgNvfbnw6r3q5GyH6M6gFg
         sL2kE+K87d0B4WapUCZViOpSFlo7qLF3oVzQjecmr+G4qyRMTfu+j8vTokjMUTjm4vRj
         kQwqo0TmXyMO8ZQi+aIc0bhyoeFz/h5EdG3IVFv5Z/2r1W89AnsSKPBKomgy7sT5ydWO
         sYEI7Z9lSs1XUUNJehiba6AjpiZx1ev1P753El7uWoNgNaghQOoatEL9Q0JKSuB03a79
         nv8QG3HX5QDbY+NKm3L/icAweA89x7HulFuTDiakCqUAi3uTXy+C5uN8OgLPO5tXg4Wi
         KbUA==
X-Gm-Message-State: APt69E36aMSb0p5hw0yi2GQTXF6AI1OrV3Fo/w8YhlA7jyTqAb75OnaU
        M7cIoDsFzxwlm6EvidBvI3I=
X-Google-Smtp-Source: ADUXVKK8DEvjpjD6X2fn7C6j93CbHAqt7nHjUXrz1lhGBsONatALuBmHMSKJkw75gaIYEdIzclHSSA==
X-Received: by 2002:a5d:4307:: with SMTP id h7-v6mr746488wrq.58.1528756529006;
        Mon, 11 Jun 2018 15:35:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b15-v6sm89723642wri.14.2018.06.11.15.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 15:35:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2018, #02; Mon, 4)
References: <xmqqr2lm4pth.fsf@gitster-ct.c.googlers.com>
        <20180604141230.GA26961@sigill.intra.peff.net>
        <xmqqmuw1asd1.fsf@gitster-ct.c.googlers.com>
        <20180611223000.GA29549@sigill.intra.peff.net>
Date:   Mon, 11 Jun 2018 15:35:28 -0700
In-Reply-To: <20180611223000.GA29549@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 11 Jun 2018 18:30:01 -0400")
Message-ID: <xmqqin6par4f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jun 11, 2018 at 03:08:42PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > On Mon, Jun 04, 2018 at 10:57:30PM +0900, Junio C Hamano wrote:
>> >
>> >> * jk/index-pack-maint (2018-06-01) 2 commits
>> >>   (merged to 'next' on 2018-06-04 at c553a485e8)
>> >>  + index-pack: handle --strict checks of non-repo packs
>> >>  + prepare_commit_graft: treat non-repository as a noop
>> >> 
>> >>  "index-pack --strict" has been taught to make sure that it runs the
>> >>  final object integrity checks after making the freshly indexed
>> >>  packfile available to itself.
>> >> 
>> >>  Will cook in 'next'.
>> >
>> > This second patch fixes a regression in v2.18.0-rc1 and in v2.17.1. I
>> > don't know if we'd want to consider it for v2.18 or not (it should be
>> > able to be applied independently from the first).
>> 
>> I gave the topic -maint suffix, but I'd need a little fix-up patch
>> on top to actually make it mergeable to the maintenance track.  With
>> that, let's merge it to 'master' before v2.18 final happens and then
>> also to 'maint'.
>
> Thanks, your fixup looks good.
>
> -Peff

Thanks; I just noticed that an identical fixup was sent by you about
a week ago ;-)
