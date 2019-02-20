Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F8321F453
	for <e@80x24.org>; Wed, 20 Feb 2019 01:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfBTBxh (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 20:53:37 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52871 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfBTBxh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 20:53:37 -0500
Received: by mail-it1-f193.google.com with SMTP id r11so11567744itc.2
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 17:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/0CdTPX2NyXYQWXAmxjbBP8dokM32L/Fob1CTb78Ak=;
        b=OFFjcELcWh1KPmWUPOUHNBF6+hGDppj8Y+JolbBAdIVkFDjMlTDTplgeI3P/pyK7aK
         wuTbsxfsAf8zBB0hF87vk29x5R0x4twJzbTb1zqFDQ/G0NeKxvrhKYrcAHQl0oKaplE3
         QKkEpY7V/H2/g+atTZJIVFWiUZcyeuxh+AeB4oHsrFWrB5CN7b19lN3YZFja6CnVNC28
         v1UuWEhg/BCn/nIONjZ68I5s5U2j/N2ru7f78aE0AgF4JTxqxASVOIjKxysfOOtgk2zS
         YXKqe3dMyDKfdStRRMpUgqKFZO0Ux622jjmiwZ9n9oPm8kw+aaXpzdLENJhsYLJ+mAi6
         YeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/0CdTPX2NyXYQWXAmxjbBP8dokM32L/Fob1CTb78Ak=;
        b=gZEusgpW73YKC0IOdh5491nA7FZHiirCzzwDTYUJd6o70lRpBd7XQPsD2Z3NxRGBFp
         +X03aDmU67KS17RQ2sAByf3h7rhnwS061SL55dC3bzqEIJjI3PfhsNEPqC5O0S8trqgT
         1Ek/i6Cn7i7g1X4mlHtcO0338H2KD+UxI3sm4SoGX/lYEPQsae5sVmFU868fJRwP4R3A
         AmWh9mB3F1I7km8Cd9dB3HjpSEzUfuogheSvAS3BW5OKHwybc1I9eYpYoN3EKjax4Qm1
         3cEbTYgWtUQ8jkNkoxu5T7NyTLY5CakVNuQeWmODEcftLzXEZ3790ss4ikpRumsyQW7n
         4qiw==
X-Gm-Message-State: AHQUAuabb2tS9kJMcX3tASav2l7B4RPCQEYQUxK0NWIH45b2lA6C6Yjg
        OU4HqgMJnfUQBicHZwN/L2pqWH5yJbEGe4im2MplcA==
X-Google-Smtp-Source: AHgI3Ib8D4j8vXJRDXPBM1LqBqe9MWtTYOgrlaF9XPhB8GPMTv4h7Nh8U9id9WxHdE8sPoCHknbbqmMmzd1S+dL2JDs=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr3982916itf.123.1550627616095;
 Tue, 19 Feb 2019 17:53:36 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-7-t.gummerer@gmail.com>
 <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
 <xmqqva40lps2.fsf@gitster-ct.c.googlers.com> <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
 <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
 <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com>
 <xmqq7eek3ax7.fsf@gitster-ct.c.googlers.com> <CACsJy8CHHT=9e9ti7VA4X4h3FrZcUKvLuzkL56mXLgjk4c5Qcg@mail.gmail.com>
 <xmqqlg2zz90l.fsf@gitster-ct.c.googlers.com> <CACsJy8CQhWeC3b6eGPePuRejfOx7c17X61-wqq5kOiRzYkRESw@mail.gmail.com>
 <CABPp-BGkJOgKqE_vHsA1fkjQ80U10Hv7-HCvScq7WOgj1UF9=Q@mail.gmail.com>
 <xmqqsgwj1ts9.fsf@gitster-ct.c.googlers.com> <CABPp-BGp53DrP6=FpYpxy5cmWkcygCz_nrunXisC55KV1ydyXg@mail.gmail.com>
 <xmqqsgwjz9q1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgwjz9q1.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 20 Feb 2019 08:53:09 +0700
Message-ID: <CACsJy8BD7OoO-K_ww-QssDiAK7Yi9zy5binGvQ6GBJvvt2f8iA@mail.gmail.com>
Subject: Re: [PATCH 6/8] checkout: add --cached option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 20, 2019 at 5:36 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> As long as worktree-only mode does not lose track of a
> >> previously-untracked path in the index (perhaps use the i-t-a bit),
> >> I do not have a strong objection against making the worktree-only
> >> mode the default.
> >
> > Could you unpack that for me a bit?
>
> Suppose in an ancient version v1.0 there was a file called
> README.txt but these days such a file does not exist (there may be
> README.md added though).  By default, the command does not stuff the
> contents to the index out of the tree and instead operate only on
> the working tree.
>
>   $ git restore-path --source v1.0 README.txt
>
> At this point, you are assuming that README.txt will become
> untracked and the user needs to manually add it.  I was asking if it
> makes sense to at least make the index "aware of" it with I-T-A bit,
> and I am leaning towards answering "yes" to that question.

I completely forgot about i-t-a! Do we want the command to add i-t-a
bit by default, or only when --intent-to-add is specified? So far
i-t-a has been a conscious choice, both "git reset <commit>" and "git
add" require --intent-to-add to use it. The first safe step could be
require --intent-to-add even in git-restore, then we could introduce a
config key that enables --intent-to-add in both "git restore" and "git
reset" (and perhaps "git apply" later, I still need to finish that
part).
-- 
Duy
