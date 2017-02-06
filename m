Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11C0A1FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 18:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751471AbdBFSRm (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 13:17:42 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34339 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbdBFSRl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 13:17:41 -0500
Received: by mail-pf0-f196.google.com with SMTP id y143so7388929pfb.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 10:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HdP3IUB+Fw9WtlwBX/vzDqugVJHCAsW5kTNpqvp8U8U=;
        b=CE7XR+Z7HtzDFvlVl+aFBUlVjX7W9ElMZpPTCcc5AxKVcIwc4qLQRAxJOuM35gru+P
         S+y8ZV/PHIZEAmjgIbLHi6iclnVwTj/9L0AyPpDkG1lSU/PQ+hoRlFFbB2uzaDiO4nRU
         eSkYFTjtxDsn8e4yT25gs4aWm1pVo12zn6/BK61gJQiAVjRU4E50+5FWEeAOq9U20aVF
         XMGef7/R9M1EdMu9J3dgGgX0GSDG1G4K1Ix5jjtmhFEBrN47d4nb1Cj4Web2krj8Webc
         04K2TEMXQ8CiypLGYDni1URK1abDGdP7PFdOPkSGGmhYVQ2Sv1mLmnri7CKcx7pLamNe
         b6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HdP3IUB+Fw9WtlwBX/vzDqugVJHCAsW5kTNpqvp8U8U=;
        b=hDNuA5C1TS1xkVXtP7+dUAk9Cm3cZgVvOlSJRZUK+sDkKY06mG5CDfFAGRH4jxX4l6
         +z2b6RTnP2kLOb1QdlbAu/vBXGQyLiIHkAIvHORJM0Cp/izkzR+I6PYERTVKclIZMnJi
         oWTUES7jl87jOGa+X53rrzoY1rKGYycqjEF8GL50GPFyzdSV8EKmsQhOp3EO5MY2g2oi
         fVhPW1ubWLpxucwIWNLAYprqkhgSD/sIAyapLvtpl4SsepJ/3do37zLVOELymC70Skpb
         1OlGVcinabcGv/uMJVskzRvJhum83mCjn4kXA6HTjp7pHrc+wHRbmeMh3NybV41FMPyA
         5DHA==
X-Gm-Message-State: AIkVDXK1UyeUmQ4bybDzUpwASKcqWxvjkQzFH2KhZEhWgg1nV9HL5Z0vCGHDT+OtAIYYBA==
X-Received: by 10.84.218.133 with SMTP id r5mr19199534pli.90.1486405060436;
        Mon, 06 Feb 2017 10:17:40 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:310c:cda4:fdbc:2aa2])
        by smtp.gmail.com with ESMTPSA id j128sm2600185pfg.73.2017.02.06.10.17.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Feb 2017 10:17:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3] parse-remote: remove reference to unused op_prep
References: <1486218663-31820-1-git-send-email-kannan.siddharth12@gmail.com>
        <CAFZEwPOdL4mOAnmTUqs5LmfdG2GQCieVGVQ7T3ZWR0n+d6tCQQ@mail.gmail.com>
        <20170206022804.GB3323@ubuntu-512mb-blr1-01.localdomain>
Date:   Mon, 06 Feb 2017 10:17:38 -0800
In-Reply-To: <20170206022804.GB3323@ubuntu-512mb-blr1-01.localdomain>
        (Siddharth Kannan's message of "Mon, 6 Feb 2017 02:28:04 +0000")
Message-ID: <xmqqefzb2ngd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Kannan <kannan.siddharth12@gmail.com> writes:

> Hey Pranit,
> On Sun, Feb 05, 2017 at 02:45:46AM +0530, Pranit Bauva wrote:
>> Hey Siddharth,
>> 
>> On Sat, Feb 4, 2017 at 8:01 PM, Siddharth Kannan
>> <kannan.siddharth12@gmail.com> wrote:
>> > The error_on_missing_default_upstream helper function learned to
>> > take op_prep argument with 15a147e618 ("rebase: use @{upstream}
>> > if no upstream specified", 2011-02-09), but as of 045fac5845
>> > ("i18n: git-parse-remote.sh: mark strings for translation",
>> >  2016-04-19), the argument is no longer used.  Remove it.
>> >
>> > Signed-off-by: Siddharth Kannan <kannan.siddharth12@gmail.com>
>> 
>> This looks good to me! Thanks :)
>> 
>> Regards,
>> Pranit Bauva
>
> Should I send this patch with "To:" set to Junio and "Cc:" set to the
> mailing list, as mentioend in the SubmittingPatches document?

Nah, I was watching the discussion from the sideline.  I'll pick it
up after doing one final read on the patch myself.

Thanks, both.
