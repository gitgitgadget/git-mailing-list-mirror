Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01EB720248
	for <e@80x24.org>; Thu, 21 Mar 2019 14:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfCUOXl (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 10:23:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40287 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfCUOXk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 10:23:40 -0400
Received: by mail-ed1-f65.google.com with SMTP id h22so5155465edw.7
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 07:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=vvOu3jvCIIDF6MSSGH7FMGt95SMf3Cd7ra7HDhTvbUc=;
        b=tbFe5uvS/fQ1h9so/rDHYkSdoWeEGlLMBk3FHs5YFidtlO70TbaSAbWE0HKsQZbkSG
         5b5h8dRc1a9h6ExzoabWiQke1ZDTeVyejlnctXiyOUxSr1B1z2UDmwgvbART6A/Y33dI
         LIobyvC/8kmKAP5/bmfHW18UwHAepZTO2kV848NlLNoubiVT44iHFS+FmHQilAh4mzo7
         fazC1Gd2yuIoq/Z6xBIaLwnHakXWcEzt1iR5Ne8JBXJcWH0lINzEzMUeyy8VsAVw4wPM
         E0al06tYa8fh3SIPB9Zbkv5difaBsc8G459q0aPYnaYhxmks0kEG8qTSmGz5s3bGDFix
         AwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=vvOu3jvCIIDF6MSSGH7FMGt95SMf3Cd7ra7HDhTvbUc=;
        b=TfWTfK3lqwLFD7jU1VWUXJ6HY1FarqFVY68/CD1LMqhD0pnaI4P4nuRwP52IM2F38x
         G/rkFWldVnYRX8bD7nDwSvWs2eQKS2qEdODaly4/7NkSFqDWSwUstI/aLusW9KnW9wH+
         cX1uU9R8PaWBdRWyHwAc6E3KkCiui0m0/nKt0Puh08dxvhgkz/sms718W6XS5wV2SHq0
         49Ei+kqDg37eBnoinB49VBmknS/sQMtt8AS+1qcDrydDDEo1brexwLImNsTbaEDdK33X
         Yl0XKXpqxF4NOx/K1FltxKojGkyhRcdzJMnRoHmTuL5b9hwo4jCN/flYyVXzDJPuftXH
         GEaw==
X-Gm-Message-State: APjAAAWWYo+PjaIiwcCAJFsvRGhprlXev4xMjFfHzk/TZjkdj/JqxZYr
        QtNSOgTB0zhQmCvR2Wb3QmI=
X-Google-Smtp-Source: APXvYqxTQaH/9JWzk1MtXtrUOraWf8HVGSON0/Xs5K7Wx2CMVgEXdGuunCGYocETrcpRH8ujSp/R+w==
X-Received: by 2002:a50:86e8:: with SMTP id 37mr2710878edu.192.1553178217931;
        Thu, 21 Mar 2019 07:23:37 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id m91sm1671029ede.16.2019.03.21.07.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 07:23:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Richard Hipp <drh@sqlite.org>, git@vger.kernel.org,
        Mike Hommey <mh@glandium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-fast-import yields huge packfile
References: <CALwJ=MzrqPUNw=jc0NRtaJaJG+ErXNb577JNSN66GiGY4UFtRw@mail.gmail.com> <nycvar.QRO.7.76.6.1903211503030.41@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1903211503030.41@tvgsbejvaqbjf.bet>
Date:   Thu, 21 Mar 2019 15:23:15 +0100
Message-ID: <87o964cnn0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 21 2019, Johannes Schindelin wrote:

> Hi Richard,
>
> On Sat, 16 Mar 2019, Richard Hipp wrote:
>
>> I'm trying to transform a repository from another VCS into a Git
>> repository using "git fast-import".  It appears to work, but the
>> resulting Git repository is huge relative to the original - 18 times
>> larger. Most of the space seems to be taken up by a single large
>> packfile.  That packfile is about 967 MB which is about 1/4th the
>> total uncompressed size of all 41785 distinct Blobs in the original
>> repository.  The source VCS is able to compress this down to 52 MB by
>> comparison.
>
> I feel your pain, as I had the same problem back in the day. My use case
> was mirroring an upstream Mercurial repository to a Git repository. This
> use case went away, so I do not do that anymore (and there are more, less
> happy reasons why I would no longer work on that git-remote-hg project,
> but that's off topic). As one of the last rem(a)inders, Git for Windows
> carries this patch:
>
> https://github.com/git-for-windows/git/commit/b91911ff8d3e2cf279b4708be89de2e3bc8e9e87
>
> Essentially, it *always* runs `git gc --auto` after running `fast-import`.
>
> Which is a lot more high-level advice than the rather low-level `git
> repack` hint given elsewhere in this thread.
>
> Now, I wonder whether we should integrate this into `fast-import` proper
> (with a knob to turn it off), maybe even offer to run `git gc --auto`
> every <N> imported commits?

My reading of the combination of Linus's & Mike Hommey's E-Mails is that
this just happened to work for you because the blob import order you
used was such that you didn't get any on-the-fly deltas.

But as Linus notes you need to pass "-f" aka. "--no-reuse-delta" down to
pack-objects for this to work in the general case, so a plain "git gc"
in that GFW patch won't do the right thing *unless* you didn't end up
with any deltas at all (or close enough for it not to matter).

So in the general case you need to run "git gc --aggressive" after a
"fast-import". I'll add some docs about this in my re-roll of my
concurrent gc doc series:
https://public-inbox.org/git/20190318161502.7979-1-avarab@gmail.com/

I wonder if we should just leave it at that. The fast-import command is
plumbing, and e.g. someone running N number of those now and doing a
"git gc --aggressive" afterwards would have their use broken by this,
their "gc" would abort if the "--aggressive" we spawned after the 1st
fast-import invocation was still running.

I was thinking of introducing some sub-mode for --aggressive that
doesn't tweak the window size, but just passes down "-f". It would more
generally cover these cases, and eta less CPU than the increased window
size (although "--no-reuse-delta" by itself is very expensive).


>> Maybe I'm doing something wrong with the fast-import stream that is
>> defeating Git's attempts at delta compression....
>>
>> Are there any utility programs available for analyzing packfiles so
>> that I try to figure out where the inefficiencies are cropping up, so
>> that I can try to address them?
>>
>> Anybody have any suggestions on what I should be looking for?
>>
>> If anyone would care to see this oversized packfile and perhaps offer
>> suggestions on how I can make it more space-efficient, it can be
>> cloned from https://github.com/drhsqlite/fossil-mirror.git - at least
>> for now - surely I will delete that repo and regenerate it once I
>> figure out this problem.
>>
>> --
>> D. Richard Hipp
>> drh@sqlite.org
>>
