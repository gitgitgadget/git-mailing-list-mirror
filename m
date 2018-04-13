Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E6021F424
	for <e@80x24.org>; Fri, 13 Apr 2018 07:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbeDMHCj (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 03:02:39 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:32909 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbeDMHCi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 03:02:38 -0400
Received: by mail-vk0-f50.google.com with SMTP id d201so4783642vke.0
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 00:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PaTiQVE67Rpd4Ojrczfj6w8NZUsxIQWmuKGt/vjpoyg=;
        b=tr8PRiu6UIccWd79uKehzrFmAnc94K01h82yd1il3R5pCgiwhk50L3lvvIoboHYrQ1
         7nCty3bogcgvEjPTOSuXfDRW/gv0r3H/CQekHdyl9fhLlIpTCuhDtMoixu+DbIrrWjcJ
         aCtE39jrtEp3f+h5pKfaasR8lOKugeepOrYt11jx7xzJhNIDlY/37uaM94xIVDURR/Uu
         u72ANkitE6WuIoG9++hb78lKKviQ33CHXxwtl3CFe+kabQSQLJcvvcTqcTeWim8zdnJF
         BRrTxOkjMU+Y1OGYSJJMDxDptlSHKWx/xzORig2YKI2Xisz8pEVxKwhH1pK66Tuz7+8w
         OWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PaTiQVE67Rpd4Ojrczfj6w8NZUsxIQWmuKGt/vjpoyg=;
        b=WJSNvU2o5HFPfjoZOOC3skPIBP/Fz9lin8qQS8Wyk6nwgq1m+hkrBpXCzKZiRBZ/S+
         49qk+rLaCp6qLTfwi9qHt5+39NO8Yj8JQOeu3AdQsETPLMkDXwzPD5lwHeTbHN/WtOKK
         guiUL4k8vq+q6h9qORgqahVeR3Ahke/m0yUxMW/x/oZyH4rpxxGfg/xHejfVSf5+zafA
         7PNlzXAzYWYdPk8mZwaBBVia9Zl+hNF74q4oNDL3V/G48ocirX4PJVF/v2FHhk9GSgdo
         ZSmUnD/z81TjgTmOTcGnMHQv3gPaEE5x+Jhd9OV3erVUrOOndEbRwaUKtu+0GyfSqOqA
         WxcQ==
X-Gm-Message-State: ALQs6tAyHvFhNU3OjvXCyWFhBhCr0+JZ0esR+AqR36sYot0Ap8aZwB3j
        NuvOFyQ1w5YFXZGLCCmBtZAjtYtZtWbH2CmAYvFOvw==
X-Google-Smtp-Source: AIpwx4+rX8wXX7H0c+Kp8iSf4EBmQtefc217HvXfJ5OE0GSNdjN1lYcqUMFq+rL3F6OMZfsELqNsbpZlGIN39Hq+H0s=
X-Received: by 10.31.192.146 with SMTP id q140mr2769803vkf.7.1523602957507;
 Fri, 13 Apr 2018 00:02:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.40.42 with HTTP; Fri, 13 Apr 2018 00:02:36 -0700 (PDT)
In-Reply-To: <CA+55aFwwVZDetd-SobOzzLQW4_GEwm3krxEGR+cpqzkzK-yiwQ@mail.gmail.com>
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
 <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com> <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com>
 <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com>
 <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com>
 <CA+55aFw5mpEcEpPTOWych-kjNLc8pEn8FdjJHe2u7HUBBLy-Fw@mail.gmail.com> <CA+55aFwwVZDetd-SobOzzLQW4_GEwm3krxEGR+cpqzkzK-yiwQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 13 Apr 2018 00:02:36 -0700
Message-ID: <CABPp-BHQsOSCJiPU9Ku5b67QTkAjnEBrhx04mTXf2QdPBriHmw@mail.gmail.com>
Subject: Re: Optimizing writes to unchanged files during merges?
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 12, 2018 at 5:01 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> [ Still talking to myself. Very soothing. ]
>
> On Thu, Apr 12, 2018 at 4:55 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> [ Talking to myself ]
>>
>> Did it perhaps mean to say
>>
>>                 path_renamed_outside_HEAD = path2 && !strcmp(path, path2);
>>
>> instead?
>
> Probably not correct, but making that change makes my test-case work.
>
> It probably breaks something important, though. I didn't look at why
> that code happened in the first place.
>
> But it's nice to know I'm at least looking at the right code while I'm
> talking to myself.

I hope you don't mind me barging into your conversation, but I figured
out some interesting details.

What we want here is that if there are no content conflicts and the
contents match the version of the file from HEAD, and there are no
mode conflicts and the final mode matches what was in HEAD, and there
are no path conflicts (e.g. a rename/rename(1to2) issue or a D/F
conflict putting a directory in the way) and the final path matches
what was already in HEAD, then we can skip the update.

What does this look like in code?  Well, most of it was already there:

if (mfi.clean && !df_conflict_remains &&
    oid_eq(&mfi.oid, a_oid) && mfi.mode == a_mode) {

That covers everything except "the final path matches what was already
in HEAD".  How do we check for that?  The current code is just making
an approximation; your modification improves the approximation.
However, it turns out we have this awesome function called
"was_tracked(const char *path)" that was intended for answering this
exact question.  So, assuming was_tracked() isn't buggy, the correct
patch for this problem would look like:

-               path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
-               if (!path_renamed_outside_HEAD) {
+               if (was_tracked(path)) {

Turns out that patch was already submitted as c5b761fb
("merge-recursive: ensure we write updates for directory-renamed
file", 2018-02-14).  While that patch was for a different bug, it is
identical to what I would have proposed to fix this bug.  A big series
including that patch was merged to master two days ago, but
unfortunately that exact patch was the one that caused some
impressively awful fireworks[1].  So it, along with the rest of the
series it was part of, was reverted just a few hours later.  As it
turns out, the cause of the problem is that was_tracked() can lie when
renames are involved.  It just hadn't ever bit us yet.

I have a fix for was_tracked(), and 10 additional testcases covering
interesting should-be-skipped and
should-not-be-skipped-but-is-close-to-a-should-be-skipped scenarios,
verifying the skipping actually happens if and only if it should
happen.  That should fix your bug, and the bug with my series.  Rough
WIP can be seen at the testme branch in github.com/newren/git for the
curious, but I need to sleep and have a bunch of other things on my
plate for the next few days.  But I thought I'd at least mention what
I've found so far.

Elijah

[1] https://public-inbox.org/git/xmqqefjm3w1h.fsf@gitster-ct.c.googlers.com/
