Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF74C10DCE
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 16:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123C7205ED
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 16:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kc57oYUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCRQbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 12:31:20 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:42287 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgCRQbT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 12:31:19 -0400
Received: by mail-lj1-f182.google.com with SMTP id q19so27708837ljp.9
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 09:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IKyx6F5CCqvbbu/C3JoXkqby9WG/6OkbArVOg62rMAk=;
        b=kc57oYUQFOWK2ixooh7Hm4NyTSh/G+bnyIn/dXuI+NVg1wYLTIZyxw6/ey4lMycz/6
         Aj8IS+QYIoPbaKKj8Zyk1jzy6WDXl/kGjzji/XF0lX0tAwW5EYU18Y0MicjhTob+N8Pn
         JOsuS46RdEafmUCaQgLE0BV3Fuc0lcWWLTcuKeXU3CwKK9TPT9xFnurnK+WzyhoRoH9B
         znyyNZtkUf2OYrTgL+Lf0O7s7ZSJhzPV0TzF5zkIXs68VLDqMoCdn75ItIWTVlHL+1Cu
         vENaoWdbJN2XXRmqqdEedaAyTRb4L05mp6VW+ySAxmt8Wzzvv7179OVmZZwwr4PfmIJg
         8gXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IKyx6F5CCqvbbu/C3JoXkqby9WG/6OkbArVOg62rMAk=;
        b=KTUO7s3V4YJPJx/InmTLJsNn0tF7ADqSELqKs0bPdFeCxTxYed4lc0JaXyus7Bs3bw
         b5RXy3akG5n4D7/xiA4cKAVqcNewwV8htHnuB72e5KjpCGMHgnZGG2Ak37iNUXUK2NY6
         o8NqKO51tnTpKPDzY41iDon4uI05gajWI6bufoqQh6Z3lLy24pw1oKOtSltfHnRKDpvU
         2VSr+cNPUU8E1/TyNWniPbB0C0yd0COgm1vV7DSb56dTcN4ziEZ7bAWSbeiPhMqRqYbe
         GDDTMh2BLONtuTURpJxzq7xbSwcKE3NlUQ2l+BjnMw01eiqACFn5ej0bpT+6OHDRafXK
         UKRg==
X-Gm-Message-State: ANhLgQ1jGBy3HJVyGH+mZOvTa9Eyp4Qk+T6t/biVTF1MQttG2hq34Eab
        Tw5qMjQWJ6c5enJKbcgMAP+CqytRDXqLddMGYdg=
X-Google-Smtp-Source: ADFU+vsD0o6B76e+D+1SXsu96tUS/dbKDLnLV4UxLlhdGlOche3d5703U3at1RDJzInaJ2J0qKxmN+9YVVauhyO+WNk=
X-Received: by 2002:a2e:8992:: with SMTP id c18mr670155lji.85.1584549076919;
 Wed, 18 Mar 2020 09:31:16 -0700 (PDT)
MIME-Version: 1.0
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
Date:   Wed, 18 Mar 2020 22:00:00 +0530
Message-ID: <CAHk66fu7dZ4H8tvnbxfdBRcRdx-3f_cJSdVAoKrE3UbR3nehfA@mail.gmail.com>
Subject: Re: [GSoC][RFC] Convert mergetool to builtin
To:     christian.couder@gmail.com
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Christian

Sorry for the late reply - the work on the interval based graph labels has
been pretty chaotic. I am going to roll out the second version of this
proposal soon.

In the meantime,

> Hi,
>
> [...]
>> ### Conversion of mergetool--lib
>>
>> As mentioned earlier, conversion of the mergetool-related scripts has to be
>> spread over 2-3 SoC or similar projects due to the size of scripts involved.
>> Conversion of mergetool would set up most of the plumbing required for
>> mergetool--lib and makes the subsequent conversion possible.
>
> I wonder if it would be better to convert git-mergetool--lib.sh first
> and then git-difftool--helper.sh and git-mergetool.sh that are using
> it.

I had been agonizing over this decision while I was initially writing
the proposal.

My justifications for mergetool.sh over mergetool--lib.sh at the time were:

1. mergetool.sh makes many more calls to git subcommands than mergetool--lib.
Therefore, its performance improves from both moving from bash to C and use of
git internals.
2. I had *incorrectly* counted overall lines to be over 1,700 with
1,200 lines for mergetool--lib + difftool--helper + mergetools/ whereas it
actually stands at rather manageable 1,000 lines with mergetools/ being fairly
formulaic.

There are solid reasons to consider the conversion of mergetool--lib too:
1. The code path of difftool-helper would be entirely in C, improving its
performance on Windows particularly well.
2. It has two well-defined entry points, which makes conversion straightforward
and with less code churn.
3. It could be done with the more frequently-adopted approach of script
calling the builtin.

As it stands now, I am open to converting either scripts.

I have CC'ed Johannes as well. I am sure he would like to weigh in
this discussion.

> [...]
>
>> `get_merge_tool` decides the external tool. This function is used by
>> both mergetool--lib and difftool--helper.
>
> Isn't this function defined in git-mergetool--lib.sh and used by
> git-mergetool.sh?

Yes, thanks for correcting it.

> [...]
>
>> ## Plan
>>
>> Similar to the conversion of difftool, I plan to create a builtin that shells
>> out to a helper script. Once mergetool--lib is converted, we can retire the
>> helper script and conversion would be complete.
>
> So you plan to create a builtin that would shell out to git-mergetool--lib.sh?
>
> Could you be clearer about what the conversion of difftool did and how
> you plan to imitate that?

Conversion of difftool had three patches:

1. difftool: add a skeleton for the upcoming builtin
- Rename git-difftool.perl to git-legacy-difftool.perl
- Create builtin/difftool.c which executes git-legacy-difftool.perl
- Add difftool to builtin.h
- Add "difftool.usebuiltin" configuration option
- Modify build process

2. difftool: implement the functionality in the builtin

3. difftool: retire the legacy script
- Remove git-legacy-difftool.perl from the build process
- Remove outdated "NEEDWORK" comments
- Remove perl dependency from test file

Since most of the conversion was done in a single commit, it is hard to talk
about the exact order of changes. Johannes, could you please guide us through
the process?

Similar to this, my changes can be grouped as:

1. Create a skeleton builtin.
2. Implement scaffolding, implement shared functions, teach builtin to resolve
symlink, submodule and deleted file conflicts, and others. They form the core
functionality of mergetool.
3. Teach builtin to shell out for file conflict (at which we retire
mergetool.sh)

> [...]
>
>> 8. Teach builtin to assign merge tool (July 10 - July 15)
>> - Convert `get_configured_merge_tool` from mergetool--lib
>> - Around 50 lines
>
> Ok, so at this point you start to convert git-mergetool--lib.sh. Where
> is the converted code going to be? Does git-difftool--helper.sh needs
> what you will convert?

Yes. Some functions like get_configured_merge_tool, guess_merge_tool are only
used by mergetool and can be moved to builtin/mergetool.c.

> [...]
>
>> 9. Teach builtin to shell out for file conflict (July 15 - July 31)
>>  - Write a minimal mergetool--helper.sh (similar to difftool--helper.sh)
>> - Call the helper script from the builtin
>> - Retire the legacy script.
>
> Which legacy script?

git-mergetool.sh was renamed to git-legacy-mergetool.sh back in first step.

> [...]

Regards
Abhishek
