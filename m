Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1053320248
	for <e@80x24.org>; Fri, 22 Feb 2019 18:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfBVSHq (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 13:07:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40139 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfBVSHq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 13:07:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id q1so3335381wrp.7
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 10:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rWlA6C148azDzPkoorAVpadRNtrhvIpvyPF5RdZ45wk=;
        b=BkaMLNrmYVP92R3Xlwysy2MjSUdVp/waWLJiJoIQ8zQDkjKOeNS4MEZUF64oPtEIGt
         I9lVxSp7X6IOE+1kAxTtzBYO4+XZMrL/ZVONUDpYKlx7eEjB5DMt4kI2arYNLftBh0wl
         FMTUZZGzGC5idXkksHmvOiVTG/bFa9IstcKkkRhYBXHZ8ZSKed9NIWeJjSQI2U2a9Y3Q
         UDLLC88v7KotbfadC5HbsBvNM/akXgdQDAXraBTJlYMti9cjcK+Wh2koKmp9Z6mClz4/
         DSyd4as8zJXBZVJBDcixQE8K9VUAu1te/Dil7vtwaHKvG0n57EE9gAYyre8s9/qJGgu9
         WKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rWlA6C148azDzPkoorAVpadRNtrhvIpvyPF5RdZ45wk=;
        b=tRiupZW7IsuaX8BSRa3RW5jsgRCAGlEJhKUUDaqo/PZW0W4tc5HWlRU3I/iOzhN/Nd
         Q9iogbDVA2SnxFZUkGZO/Q2pA8C9MaRSZA6TPQGezRTkiwvYkQ9AqqmJPp4E4Nj3qK/g
         HJS7kbb3o6yUG68A8GKCisk458wzmEVtFVBP1yzPoumGlYge8DqGVZrdK7ZgC3Z7TMbu
         pep9rYHjwPtaYEzet7Yoy+yKg+9T4cpGdov+mwtnDBLLseVWWjE68nkHeN7xBKYyihB5
         D00dSvTKs0ikWXUQ1W69SAJUbeaObW+OXKKg280kY9HyJ6gCroSOV0GbTH4Kzw01Avt4
         9URw==
X-Gm-Message-State: AHQUAuYwYmmo6KnOLxScV0G32WolREC7N7+YpqLpUw2Drux3TE3DeIsw
        a0FYTKOMjqrMALJ0kriN5yU=
X-Google-Smtp-Source: AHgI3IZjtl/vGPRs9MhyOTTYwNb/CTDew8LL+AAomQwDGb49Jp67TNHA5BLiZAJzYK2rcj/TuZk93w==
X-Received: by 2002:a5d:6112:: with SMTP id v18mr3766121wrt.207.1550858864756;
        Fri, 22 Feb 2019 10:07:44 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o18sm5554531wrg.40.2019.02.22.10.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 10:07:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH 1/1] Introduce "precious" file concept
References: <20190216114938.18843-1-pclouds@gmail.com>
        <20190216114938.18843-2-pclouds@gmail.com>
        <87wolzo7a1.fsf@evledraar.gmail.com>
        <CACsJy8CR7VGp7htC_wKC9BUCaQsmkp5Zd4+M7bddPL-jKyfDMQ@mail.gmail.com>
        <xmqq8syb3b3j.fsf@gitster-ct.c.googlers.com>
        <87h8cy6cme.fsf@evledraar.booking.com>
        <CACsJy8B15hORnaOdYW8TNE3Gniv9NBJopyLYmHR5iF0U3beq6g@mail.gmail.com>
        <xmqqo976ultb.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CB=P9T0XJMWQetExgwDyFN78nuJZq8FtmzG+V1fBY4ig@mail.gmail.com>
Date:   Fri, 22 Feb 2019 10:07:43 -0800
In-Reply-To: <CACsJy8CB=P9T0XJMWQetExgwDyFN78nuJZq8FtmzG+V1fBY4ig@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 22 Feb 2019 16:35:44 +0700")
Message-ID: <xmqqk1hrr91s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Feb 21, 2019 at 5:39 AM Junio C Hamano <gitster@pobox.com> wrote:
>> > So now you would need to
>> > add more or less the same set of ignore rules in .gitattributes to
>> > mark them trashable, and gitignore/gitattributes rules are not exactly
>> > compatible, you can't just blindly copy them over. Every time you add
>> > one more .gitignore rule, there's a good chance you need to add a
>> > similar rule for trashable attribute.
>>
>> I am not sure why you would even need to _duplicate_.
>>
>> Are you saying for each and every rule that specify "ignored and
>> expendable" in .gitignore there always will be "ignored but
>> precious" exception that match the pattern?  Given that we have been
>> OK for so long without even needing "precious", I find it somewhat
>> unrealistic to assume so.
>
> If all ignored files are now redefined as precious and we mark them
> expendable with trashable attribute, then we need to duplicate most of
> the rules. The "precious" attribute of course does not have this
> problem since precious-and-ignored files should be rare.

Ah, so you are saying that ignored (the traditional one we always
had) plus precious is a better combination than ignored (repurposed
to mean ignored-but-precious) plus trashable, because the latter
will cause people configure with a lot of duplication?

If that is the case, I'd agree ;-)
