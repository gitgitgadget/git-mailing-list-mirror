Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6A241F453
	for <e@80x24.org>; Fri, 15 Feb 2019 17:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbfBORlJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 12:41:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33391 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfBORlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 12:41:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so11249867wrw.0
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 09:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qpbcr7imxU2BORDyZ7n1l93p5pX0WIAPhJc+OwtAqsA=;
        b=Klte/AXkJZk0phQLi9lkOBrpnxh1c8STUDtYmxep+fqdm4t0v4Ar1AGnKi/gPnRoYk
         8L+C7S9TbpslzEpHkUXk+vXDcwl0aa1sazSO8PgS/9RzPXkpRw6KCiJGlu3482/RXEyc
         gn2tXTT52mhJot5Zt52KwfromcQjPt7S7a/jOWkJ/SuL9xbRcB9jSX0JHH6POy4Ouiwo
         XSy27UX+ibBgg/0BHC7z0E0xz375BhpbD7B7Z5pLnBqctUknn3Z43C17hgqjXPEnKFwI
         DXlUdJOEwKEw+amDj7UW3C1blvmy3jf4tfnD1GENUSfa77SrBPPVekuo0p/bqU+0LZ/u
         zfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qpbcr7imxU2BORDyZ7n1l93p5pX0WIAPhJc+OwtAqsA=;
        b=qP8tD96JgsaJmTv0VYwIRqRLouQfPxbC5nHA0/d+S5JPLurUvMdphSN/LR3UkpMeFg
         D6mJyoQaY+gndgtIdFdsU0XbrFi0rijAUwFeUgTLikS2+j+7bWs4Ac/WPbxDcSxCX+RI
         N9dtWl6E6sWNUi1+snyaG5QUpJ0cHqicbQfL+7VQk0Tnr0HUOLpH3OLabvjmzceGZ7oq
         rS7FyPrSC9MUt8y8wr5D41NErhkD62F9upUleUH2p1y7sND459w331P547xqMWyN5P/j
         6dY0t4WPcuO9eUEU4HnTs3gtByaVV5G+r/+orWNJdhfEhEQHpJ8/RKCuBHF/a8s0gXm8
         rjug==
X-Gm-Message-State: AHQUAuYna0SyCJzDSlXpptT+AR/ztHCsA0v/KL/Ll4Hivhom+/B8luig
        xYXkHBNN6xnU2VHj/PJQ2q8=
X-Google-Smtp-Source: AHgI3IYqM25sWALQwQrCQsVRGUznrdKJgoRB36sWB0A6K3J3BIHl5Uoyc8HaV3VjW04HvDgNqP596w==
X-Received: by 2002:a5d:5506:: with SMTP id b6mr7358393wrv.33.1550252466753;
        Fri, 15 Feb 2019 09:41:06 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o7sm4161567wmc.13.2019.02.15.09.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 09:41:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [PATCH 1/1] tests: teach the test-tool to generate NUL bytes and use it
References: <pull.126.git.gitgitgadget@gmail.com>
        <34cde0f2849a098c17ab83786da5ce06f69cfafa.1550179990.git.gitgitgadget@gmail.com>
        <xmqqimxm6msi.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1902151558080.45@tvgsbejvaqbjf.bet>
Date:   Fri, 15 Feb 2019 09:41:04 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1902151558080.45@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 15 Feb 2019 15:59:12 +0100 (STD)")
Message-ID: <xmqq5ztl6jbj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 14 Feb 2019, Junio C Hamano wrote:
>
>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>> 
>> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> >
>> > In cc95bc2025 (t5562: replace /dev/zero with a pipe from
>> > generate_zero_bytes, 2019-02-09), we replaced usage of /dev/zero (which
>> > is not available on NonStop, apparently) by a Perl script snippet to
>> > generate NUL bytes.
>> >
>> > Sadly, it does not seem to work on NonStop, as t5562 reportedly hangs.
>> > ...
>> > In the end, though, what counts is that this here change incidentally
>> > fixes that hang (maybe also on NonStop?). Even more positively, it gets
>> > rid of yet another unnecessary Perl invocation.
>> 
>> Thanks for a quick band-aid.
>> 
>> Will apply directly to 'master' so that we won't forget before -rc2.
>
> Thank you, that will be good, as the builds still seem to fail. All of
> them.

Actually, I am really tempted to instead not apply this, but revert
that genzerobytes Perl thing.  This assumes that your Azure thing
did not have the breakage before we applied that patchset.  What do
you think?

Trying four or more possible band-aids that may or may not work
without knowing what the real cause of the hangs are is not
something I want to see people spend excessive time of theirs on
this close to the final.  I'd rather avoid distraction and see
people spend their cycles on bugs that matter, instead of trying to
chase test breakages that have always been present for those without
/dev/zero.  I am not fundamentally opposed to supporting those
without /dev/zero but I'd prefer to see it happen in 'pu' until we
identify and fix the real cause---which may well be a real bug in
the http-backend stuff---and the time to do that is not during the
rc period where we close the tree for new features and non-regression
fixes.



