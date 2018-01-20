Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B35AB1F576
	for <e@80x24.org>; Sat, 20 Jan 2018 09:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeATJiS (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 04:38:18 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:43183 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbeATJiO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 04:38:14 -0500
Received: by mail-qt0-f182.google.com with SMTP id s3so9732033qtb.10
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 01:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=uIJDYuWzM+ZQ87Vk81wsKM47sj2wbLEj8T69ACfKtL8=;
        b=fgM3s5pvwxbPow9+sbG2Gdm448v6oUVyKNaJ1CU4NrloOViZ8Som9FeQ4xC/VTEhdr
         5RN43cM7AkhUkDqUFzqUij8djnNJUjc7I2/PdHJCf/TVFarvw7lOWNqHWLQDUpkqZWRd
         xsSRyru/YpPtFHTnryIqdvclo8ZxOcrDKYnN+SZesAP8YWcVjJrZvHru55TABD8NFYNO
         0p/GhlLLI8VinmP+Z0N3W3cJ0owfLz4yQh46nGDPdeyxUGbURA1k8tj7xcU0GhL3/fFA
         6OQh/gD81+k4Y7wQ8T2YyD1WnL9IS5RW7babFh2bNevyoaj1Priuoj+zDfQ03k6zAXhu
         011Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=uIJDYuWzM+ZQ87Vk81wsKM47sj2wbLEj8T69ACfKtL8=;
        b=YfV6YsqOf+YX3n+lk90Z9A5E0AALYuo8kAwp+dY3649kzuvO0CNGXZLq9K7pZ7EdQU
         t3yO3qRWnUHkcfPXssOJvhyCcosTpsrKbpEEg0MVpgE4wzAjds/Wyh8fQeCi5uD96DUB
         7BkQkqSHSkvOvg3iCi99qxGM+cRUJ5eL2uyIc5Pzi06QvYvGRQHoGKrbsnaY2Ub/y8Py
         F1Rb1B2qkjh45Ywr/A8RW7qDNU3S0gu92NOD1+FBHtOp6cfsFok312OPlQ/MKbO+cZqB
         JzJgWx6pu0gP8tFnZ1gtrxI80ydqveUJwM3Y9BPtmfNWHUzmkJTCSVFbVE1H+0gVGVix
         t+uw==
X-Gm-Message-State: AKwxytex1C8fAcPgTMBWo8/vYSgF9mAh96u/79KKOL7bzDG95PP2/oYS
        whzO7c5HvJmRxAjTjMZ3GnQxoX8PohcNyg3mPaU=
X-Google-Smtp-Source: AH8x226+eBJvRfM2ZaMV4vL75iq+AZe1doONqZ+EbWnN60XR56vwTIg7w8gvcK7tMe3TtlFy/AVXMD+dhcEHlQk0Sbo=
X-Received: by 10.200.25.9 with SMTP id t9mr1825322qtj.75.1516441093420; Sat,
 20 Jan 2018 01:38:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Sat, 20 Jan 2018 01:38:12 -0800 (PST)
In-Reply-To: <xmqqo9lpnhdb.fsf@gitster.mtv.corp.google.com>
References: <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
 <20180119041825.727904-1-sandals@crustytoothpaste.net> <CAPig+cTOw5NsSmLHYcBEidDzNyiidJ0Dw1dF227KWDL9JrASvw@mail.gmail.com>
 <xmqqr2qlps7r.fsf@gitster.mtv.corp.google.com> <xmqqo9lpnhdb.fsf@gitster.mtv.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 20 Jan 2018 04:38:12 -0500
X-Google-Sender-Auth: PxFDqeTajBN--Ygky8ibioC_iNI
Message-ID: <CAPig+cR08-EsBGkrGckG5zTN3iPeLL4cj1g5TykicQJe7sK-pQ@mail.gmail.com>
Subject: Re: [PATCH] repository: pre-initialize hash algo pointer
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 20, 2018 at 2:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> Now that we know (due to Duy's excellent detective work[1]) that the
>>> trigger is files with names differing only in case on case-insensitive
>>> filesystems, the commit message can be updated appropriately.
>>
>> Thanks.  Let me apply the following and do a 2.16.1, hopefully by
>> the end of day or mid tomorrow at the latest.  Test to protect the
>> fix can come as a separate follow-up patch.
>
> I actually changed my mind and decided not to rush 2.16.1 with just
> this change.  After all, even though it is better not to crash in
> such a problematic case, a "successful" clone of such a project on
> such a filesystem cannot be sanely used *anyway*, so in that sense
> the "fix" would stop "clone" from segfaulting but the resulting
> repository would still be "wrong" (e.g. "git status" immediately
> after clone would likely to say that the working tree is already
> dirty and missing one of the two paths, or something silly like
> that).

The counter-argument is that filenames differing only in case do not
necessarily render a project unusable on case-insensitive filesystems.
For instance, if the problematic files exist only in a project's test
suite or in some platform-specific resource directory, the project
itself may still be perfectly usable for a person cloning a project
merely to build and use it (not develop it). However, "clone" crashing
_does_ render the project unusable for the same person.

The crash[1] when cloning 'tcell' is an example of a project which is
still 100% usable on case-insensitive filesystems despite
case-conflicting filenames. Each of the conflicting file pairs [2] has
identical content, so everything works as intended.

Case-conflicting filenames also do not necessarily make it impossible
to do development work on a project. I have, myself, on several
occasions cloned such projects on MacOS to make improvements and track
down and/or fix bugs in parts of the projects not impacted by the
case-conflicting filenames.

Footnotes:

[1]: https://public-inbox.org/git/20180119180855.GA98561@smm.local/

[2]: case-conflicting files in tcell's bundled terminfo database:
    terminfo/database/32/2621A
    terminfo/database/32/2621a
    terminfo/database/68/hp2621A
    terminfo/database/68/hp2621a
    terminfo/database/68/hp70092A
    terminfo/database/68/hp70092a
