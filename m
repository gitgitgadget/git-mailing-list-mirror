Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D45CF20193
	for <e@80x24.org>; Thu, 27 Oct 2016 19:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964804AbcJ0TIO (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 15:08:14 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33523 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965111AbcJ0TIO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 15:08:14 -0400
Received: by mail-qk0-f182.google.com with SMTP id v138so4416301qka.0
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 12:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iBoyXvt3Y0NMeg4AtE6W7o6a9YGSk1AJHy5mz5m7lN8=;
        b=ljDVth8MDpgqauzwFIRfIrP5/OQKDxRT9aqTup12YU9mJDrnjObcyLur57/9IN81TE
         3CMGpCLwU3fOR6+veRBkpP/ZsRnOXcdAWSXcorcOxh6iC4R4/XsAhrhpV75b72y9AltB
         CXemKMdVIjdZ80HDbHi/4HH8XI/x/zhpV5tG/mOCar/ypYX7khz80TIJO02TITxPEs0L
         pAW3jyINSx0R8F0DIsGicOcZPNHm8dkjr9eUuI/A+tR8kGrd/UDuyo4fGPOyOycwU0C2
         XICMZXbtGqmlpSbhLpA8RHN1xJWuhPYRELucyNdq2KmERUBEfpMY9JviL1Z45TLmkTUw
         6asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iBoyXvt3Y0NMeg4AtE6W7o6a9YGSk1AJHy5mz5m7lN8=;
        b=B0KohITGNsMvz1VKNXgKjFzek2Rk2AQNNGN0lwGt+MYX/fJ6bUjrqSjETnTgJaBsx7
         uboSpiz/a+B161KtYZkKkq4MCCBWZhsdOf5KMCtyUr8y1UAcHgylDzFk2dzdObfblX4o
         2BZrNnisR//eUdcek2UhIhwEFWghTYpXpHMkrmcjVfkUYzSKaVOcm5sf0yQIMz3Opg4K
         eABtuWnTXb+nr69qAfg4/ttnhAEhB+KB7L50ZynuBeWfe4BTorYPkXdRMlWhmIMNmccQ
         uE0kAK5wRbEKOa9ZANKA0TFtFInPbVxgg6rfjrfgqjZoGY6BE7KZTxN/WduScsnAixMK
         81NA==
X-Gm-Message-State: ABUngvf7ug8tUZjlS53fcwLwcmm2oIqkBbBHsCQZt5uox56kDHIKm77YrUT9tJO2dKatzbrxjbh5i3ZhPmg0PrFf
X-Received: by 10.55.184.2 with SMTP id i2mr8099016qkf.47.1477595292753; Thu,
 27 Oct 2016 12:08:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 27 Oct 2016 12:08:12 -0700 (PDT)
In-Reply-To: <xmqqr3716301.fsf@gitster.mtv.corp.google.com>
References: <20161026215732.16411-1-sbeller@google.com> <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org>
 <xmqqlgxa8h3a.fsf@gitster.mtv.corp.google.com> <67e38b43-0264-12f2-cca8-4b718ed7dc9d@kdbg.org>
 <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com> <xmqqd1im8foi.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbP3pgPHgv-x1Q-Q1QwmXc=gOyxWhXh2SngO8WSZc3PFA@mail.gmail.com>
 <34c88c40-2088-fd74-5d26-56c0599b7eb9@kdbg.org> <xmqqr3716301.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Oct 2016 12:08:12 -0700
Message-ID: <CAGZ79kY_fZ_pDtVnwJoDkR6PjTNoqDMN5OC70Z8SH_J0Wvkq-w@mail.gmail.com>
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Simon Ruderich <simon@ruderich.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2016 at 11:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Am 27.10.2016 um 19:01 schrieb Stefan Beller:
>> ...
>> It is not possible to mark a mutex uninitialized on Windows without an
>> extra piece of data. A solution would become quite complicated quite
>> quickly, and at the cost of additional operations that are in the same
>> ballpark as an uncontended mutex. I'm not enthused.
>>
>>> The positive aspect of this way the patch proposes would be that any
>>> future contributor not knowing the details of how to do mutexes right
>>> on Windows, would not totally break the whole system, i.e. this seems
>>> to be more maintainable in the future as it reduces the friction between
>>> pthreads mutexes and the way we can do things in Git in a platform
>>> independent way
>>
>> This is a non-argument. Coders have to know their tools.

Windows is not my tool.

>
> The codebase should strive to give coders a coherent abstraction
> that can be implemented efficiently on platforms, so that coders do
> not have to care too deeply about quirks that exist on individual
> platforms.

Currently working as a coder I care about "submodules, that work on
linux." I do not care about Windows in the big picture. I am however
willing to go an extra step to not break Windows. However that requires
a little bit of effort from both me and you:
* I need to be aware of what I cannot do with "not-my-tools". (So please
  somebody tell me, also in the future when I break obscure platforms. Mind
  that I don't equate obscure with not widely used or in any other way negative.
  It's just that people working on linux find some quirks on Windows
not "obvious")
* the workaround should not be too time consuming in the bigger picture,
  which is why I propose to make the API a bit clearer by emulating posix
  mutexes harder. (From a Windows POV this might sound like making it
  more obscure because posix mutexes itself are obscure.)

>
> It is OK to argue that the particular solution Stefan lifted from
> somewhere (perhaps msdn article he cited???)

A stack overflow article that I found with my search engine of choice, because
I could not believe that Windows cannot have statically initialized mutexes.

> does not qualify as
> such an abstraction.

The implementation under discussion (well we did not discuss the
implementation a
whole lot yet) may even contain an error as the first memory barrier
needs to be in front
of the first condition.

>  But I do not agree with your "Coders have to
> know" as a blanket statement.

Well I do to some extent, I just disagree what my tools are.
