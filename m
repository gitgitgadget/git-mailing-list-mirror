Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A47E1F424
	for <e@80x24.org>; Thu, 26 Apr 2018 00:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751245AbeDZAZg (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 20:25:36 -0400
Received: from mail-ua0-f175.google.com ([209.85.217.175]:45768 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeDZAZf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 20:25:35 -0400
Received: by mail-ua0-f175.google.com with SMTP id j18so16079932uae.12
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 17:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fe54AnAvBHHAy5hxY2ueQ6NCM9+EjkCSIDM2JgVVmVU=;
        b=ENTLh20FARK3Xu2ItoAcw3teeHxI/5kZL/cYmjEV9LglR1tCJAz5WbH2qBN8shImTz
         tjt+6s7upJZsW2vILnMo3BfW2lsc42sSjLAkWuYCdQIi1IQ+YDrRgaaM43j1xV1TlGY3
         lKZg7NsDVMZpvvwrMzBNopgsoUD4HtXzQum+7gsJBCrPRG7cH+/ZCFvs48df8fEZYqMT
         yssJxOMQKO0g9P7+yDS7GYA7kcbnHhHZmO+K3+oCsAg32YsqdGfNkui4QAxGz9lNsVTT
         Ktai+BrKxjU2B0inrD0os4wQonbnJEGhrb/i3j39aPP+5IuCfJnBbYAAYDxOWE5ng4sw
         0/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fe54AnAvBHHAy5hxY2ueQ6NCM9+EjkCSIDM2JgVVmVU=;
        b=edib9wKPM9HSg3sfiRzmywhM2nWD3vfo+9PhHgIBmIQEhDtW1Y05CtQiXE/t+H8pIh
         ozZFBi/jIl/qXkVmOXLwZZVi/Tb0v4i2KCYFFcbk4/D/XIcg2ZI4TxgihNvC1KYITq8y
         dDpHUXU+6U4MmJi0NGGFPQaxu7UwCOgq+cr6BdSkYxbIJgYcHrvFl40S1fPzqfzq6Is6
         4fbluWQq468xZLlueIr2QIrerfZH2NaDXMUFTgkGylxk7negVUXniXtq/REylhkQh5ZJ
         Z1Vx2cVZ+zquZcuA21YVScv7jhC2g9cxJCqfotWeKbM7PsWiIWg3g92oZBLyy9pfbX07
         hYyQ==
X-Gm-Message-State: ALQs6tC+o2L3WCspZw6bqbhfQ0CO/XGWRZvUU81LHk3rc7lLdgx9ktKz
        qg7HAgkjtf0hCPPHIoRMM5ZsAc0IakDEa9LwOCE=
X-Google-Smtp-Source: AIpwx48JEbsNuAemEm1jMaVNAqJ5DVhKmG/pokKw/9qApUK0lhGsKbc1ROVRyFyWSfcgqsfwgsEnI1TGuWLltRU3OhY=
X-Received: by 10.176.91.86 with SMTP id v22mr16648467uae.31.1524702334515;
 Wed, 25 Apr 2018 17:25:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.195 with HTTP; Wed, 25 Apr 2018 17:25:34 -0700 (PDT)
In-Reply-To: <xmqqlgdljok5.fsf@gitster-ct.c.googlers.com>
References: <20180318012618.32691-1-szeder.dev@gmail.com> <20180416224113.16993-1-szeder.dev@gmail.com>
 <20180416224113.16993-2-szeder.dev@gmail.com> <xmqq7ep6v6ft.fsf@gitster-ct.c.googlers.com>
 <CAM0VKjk=JtdoduywJ4t5OPhLGgt90yxJA_Zif6R803XHA=Sfbg@mail.gmail.com> <xmqqlgdljok5.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 26 Apr 2018 02:25:34 +0200
Message-ID: <CAM0VKjkQfTm+qnurvZ_545VXJH2PwuPfkhXaa1sLj5ePSPjBwA@mail.gmail.com>
Subject: Re: [PATCH 01/11] t9902-completion: add tests demonstrating issues
 with quoted pathnames
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Clemens Buchacher <drizzd@gmx.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Manlio Perillo <manlio.perillo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 18, 2018 at 3:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>>> Do we want to test a more common case of a filename that is two
>>> words with SP in between, i.e.
>>>
>>>         $ >'hello world' && git add hel<TAB>
>>>
>>> or is it known to work just fine without quoting/escaping (because
>>> the funny we care about is output from ls-files and SP is not special
>>> in its one-item-at-a-time-on-a-line output) and not worth checking?
>>
>> This particular case already works, even without this patch series.
>
> I was more wondering about preventing regressions---"it worked
> without this patch series, but now it is broken" is what I was
> worried about.
>
>> The problems start when you want to complete the filename after a space,
>> e.g. 'hello\ w<TAB', as discussed in detail in patch 5.  Actually, this
>> was the first thing I tried to write a test for, but it didn't work out:
>> inside the 'test_completion' helper function the space acts as
>> separator, and the completion script then sees 'hello\' and 'w' as two
>> separate words.
>
> Hmph.  That is somewhat unfortunate.

Actually, I used 'test_completion' in these new tests, because there
is that big test checking file completion for various commands, and it
already uses 'test_completion', so I just followed suit.  Now, that
test checks that the right type(s) of files are listed for various git
commands, e.g. modified and untracked for 'git add', IOW that the
caller of __git_complete_index_file() specifies the appropriate 'git
ls-files' options.  For those kind of checks 'test_completion' is
great.

These new tests, however, are primarily interested in the inner
workings of __git_complete_index_file() in the presence of escapes
and/or quotes in the path to be completed and/or in the output of 'git
ls-files'.  For these kind of tests we could simply invoke
__git_complete_index_file() directly, like we call __git_refs()
directly to test refs completion.  Then we could set the current path
to be completed to whatever we want, including spaces, because it
won't be subject to field splitting like the command line given to
'test_completion'.

So, I think for v2 I will rewrite these tests to call
__git_complete_index_file() directly instead of using
'test_completion', and will include a test with spaces in path names.
