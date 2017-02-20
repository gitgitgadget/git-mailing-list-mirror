Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89C33201B0
	for <e@80x24.org>; Mon, 20 Feb 2017 07:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750935AbdBTHqZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 02:46:25 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33015 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdBTHqY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 02:46:24 -0500
Received: by mail-vk0-f41.google.com with SMTP id k127so57308050vke.0
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 23:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VALdeCJJhmhx1etua8IuCgEtI6eXwDY/IvAbVbfHDqI=;
        b=qOx2/+pJLG298eN05/AKRoH9yOIuapVkEwvlZJI4XBkQT2/+U+Z88IlnO2hb0jTJJh
         F8V5sTXSGP+9wL/w63QdT7cB5EPQMqI+w4GWaZezeR8FSwQ8TlpBffiARrD1qrUFRZ3F
         duWCavjyjEo+6x2DTEZI7ebWmgvVDS+i7VnBRDBeWBj6B00S9JfBElBP//oHiizXthrf
         wA0Uy8ovmXHtioeUgaSP1vtVRTZpxdZp6IT2yjfrNR2xqB8al2DDCqN7QCcxQS2BNyn1
         MYqvG5uqr2t+6CemhlxTuQHgQsLMbIX1pBdbfiSpUOLulS8oVkGe0ZYMzcVE+tyKunMY
         lyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VALdeCJJhmhx1etua8IuCgEtI6eXwDY/IvAbVbfHDqI=;
        b=I3CDtnzNwQ35bLdFiKR9or+rpcExYuxcHDy4+kqhyVeTSg4Z5KKy8k7PWRKd5uKjix
         zWvCRelgu3ejKekIXLR5U0bGcgqUX7Voyw3Ic47IVnkpbu3PiuMMlV7wV9uVwm1g8ctU
         BTbAok+8LyzR+wpFQaDUCH3wD3dxBGH/oGh4PpVqSNNkc0aABIvrJeEk+ybpgVKpJbmB
         JbfP4aerYAQp7YxoyA3Dy22+WCRI5hl0BAgo+ZFejn/mjS7Pg1x3hPk7p2jma6JyLIA/
         +pKmvrq2REif+EdalJVWCefqAE1TmTY0/KnbWour98BIEzmyASILrfR2yLNNNhxZHY9z
         3+ww==
X-Gm-Message-State: AMke39n3f4JGxQO7VOgDkPtvNcqCdAabcx9C1TwSNMs7IIMqCt9Iuc3GBI29djGLVjUYKOesD5pcse1Tox562g==
X-Received: by 10.31.161.137 with SMTP id k131mr10092354vke.12.1487576292061;
 Sun, 19 Feb 2017 23:38:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.31.242.11 with HTTP; Sun, 19 Feb 2017 23:38:11 -0800 (PST)
In-Reply-To: <CA+P7+xrch9WDo6OgU3vUEpXqAETZ07mkf76dC9nJctm0LTFQHQ@mail.gmail.com>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
 <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net> <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org>
 <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com>
 <477d3533-d453-9499-e06e-72f45488d421@kdbg.org> <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com>
 <CAP8UFD3ngMvVy2XLzYNn9OFbS+zQpWTW=pravpHhA-0PcDVhfg@mail.gmail.com>
 <CAMX8fZVeAEJ5tfCO_4Pebnq=rysaJ2xDMjH-9pjmPeF4FziLFw@mail.gmail.com>
 <d7bb866d-4a50-f75e-ff4c-bcdd54f75459@kdbg.org> <CAMX8fZWRgeK5XjSrFYzZea8YgT9Mqm0XJBxQGt1eqdWZU+DEnA@mail.gmail.com>
 <CA+P7+xrch9WDo6OgU3vUEpXqAETZ07mkf76dC9nJctm0LTFQHQ@mail.gmail.com>
From:   Oleg Taranenko <olegtaranenko@gmail.com>
Date:   Mon, 20 Feb 2017 08:38:11 +0100
Message-ID: <CABEd3j8sgDd8DXW8+2Q7pjANPTr-Ws1Xs1ap875mkxFOfnenYw@mail.gmail.com>
Subject: Re: Git bisect does not find commit introducing the bug
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Alex Hoffman <spec@gal.ro>, Johannes Sixt <j6t@kdbg.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stephan Beyer <s-beyer@gmx.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Then you must adjust your definition of "good": All commits that do not have
>>> the feature, yet, are "good": since they do not have the feature in the
>>> first place, they cannot have the breakage that you found in the feature.
>>>
>>> That is exactly the situation in your original example! But you constructed
>>> the condition of goodness in such a simplistic way (depending on the
>>> presence of a string), that it was impossible to distinguish between "does
>>> not have the feature at all" and "has the feature, but it is broken".
>>
>> Johannes, thank you for correctly identifying the error in my logic.
>> Indeed I was using the term 'bad' also for the commit without the
>> feature. In order to find the commit introducing the bug in my example
>> a new state is needed, which would make 'git bisect' a bit more
>> complicated than the user 'most of the time' probably needs. Or do you
>> think, it would make sense to ask the user for this state (if e.g 'git
>> bisect' would be started with a new parameter)?


> If a commit doesn't have the feature, then it is by definition, not
> containing a broken feature, and you can simply use the "good" state.
> There is no need for a different state. If you can't test the commit
> because it's broken in some other way, you can use "git bisect skip"
> but that isn't what you want in this case.

Commits missing feature == 'good' commit is a very confusing one.

Looks like in real life it happens much often, then git developers can
imagine. For multi-branch/multi-feature workflow it's pretty easy not
to recognize whether it is missing or not developed yet, especially on
retrospective view where cherry-picking/squashing/merging is being
used. My experience shows most annoying bugs are generating after a
heavy merge (evil merge) with conflicts resolutions, where developer
is not involved in the knowing what happens on counterpart changes.
Then feature can be disappeared after it was worked & tested in its
own branches.

@Alex, I'm pretty interesting in fixing this weird bisect behaviour as
well, as far as I struggled on it last summer and continue struggling
so far :) If you want we can join to your efforts on fixing.

Cheers, Oleg
