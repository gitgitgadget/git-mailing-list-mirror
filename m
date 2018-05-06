Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4FD12023D
	for <e@80x24.org>; Sun,  6 May 2018 17:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbeEFRnW (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 13:43:22 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:34809 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbeEFRnV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 13:43:21 -0400
Received: by mail-ot0-f196.google.com with SMTP id i5-v6so17936852otf.1
        for <git@vger.kernel.org>; Sun, 06 May 2018 10:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=05b6ee/ivS5qPukqiscubJpZVPwSkDyGoz92OKllPlY=;
        b=L9JYOCFLpbX2XmJsgfgxk1TfrSkYhI4eZjNnynmo8qXGk+9mpMwA8rVu3YWAf3vu99
         2var+fbe3UEihqhfHswo3g78OcZjWrybU21Ad6VeizJY6eI+agA60YJ1/+WrAZEGaJM5
         EjFFsuYhFtmDfAJ6Mf6/UsSC1UdgiPuA2UpQUt5XgDQajC93J4VqGoSVT5MEbGZzExc0
         kN8ukU45xSX3xXpPcj9s+pbeFC293/3v6/RbC3jdzmhK5wvqaZ7TwgGymmi4Fhe8dkYL
         MYEUll+TgP4Zq2ROfr595w91n72CrhsyxPVWbllb2x9H284FB5/rRdq77yNH4qIWtbMT
         lHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=05b6ee/ivS5qPukqiscubJpZVPwSkDyGoz92OKllPlY=;
        b=t5ED0qg+Vg1KOoz/dOKM2qcxHzUYxxREOUlWMhsH2sZ7vsb/+Lh5pPmXj2ZSk3YXFb
         bXI0pTyj6YVAKhJF+4Pvvxu4/EgIKLEY3H12uJqP1pMO1m885ahjL3gdamcw0rpTNgzF
         Kt+zEtqqxfXZId65Fe6rG0vGmrEbKBrZbQhqfPgIrYA4M7jGbqp1bGAEj+u62ffDZIJ3
         xUiZBa3lmo9j3GVWUn219pmlrCaAvPiEwc/jAtaU2GV01XB30YhFe5RoYfA8FU96s9+U
         ukEr9gSmIW7iMCzbjoEf7+U/Jumhg2D3QBTodagU8I3CWsG/Y7RegT25KsGYI1KY9Zwr
         zduA==
X-Gm-Message-State: ALQs6tDUXO185rSaTA/NLDGHHimaiYcRO9O3RKgLr97QgsFkxTXYDQPk
        tevU8lu0p6CqWDk1Uj67Cn6HcpbAHLjv5d8cHcYtog==
X-Google-Smtp-Source: AB8JxZptEFatDdEb8qehmty9KCxDRvUkVrYf/gt6kfRawhXYNQBIIW3IOgmUw/SGWtEWSn9B4vQboN69LT5Dnsla91c=
X-Received: by 2002:a9d:e8f:: with SMTP id 15-v6mr15375115otj.14.1525628600511;
 Sun, 06 May 2018 10:43:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Sun, 6 May 2018 10:42:50 -0700 (PDT)
In-Reply-To: <CACsJy8DyRhQ0DKy8UyK+r7Kmw=0hHD=W6aXXKutk4e-wtGTdNg@mail.gmail.com>
References: <20180506141031.30204-5-martin.agren@gmail.com> <CACsJy8DyRhQ0DKy8UyK+r7Kmw=0hHD=W6aXXKutk4e-wtGTdNg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 6 May 2018 19:42:50 +0200
Message-ID: <CACsJy8Btuc2J4aCTymkvLYyMV5zJrdMUdtV5NDnPqXOjsTVw4w@mail.gmail.com>
Subject: Re: [PATCH 4/5] lock_file: make function-local locks non-static
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 6, 2018 at 7:26 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, May 6, 2018 at 4:10 PM, Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
>> These `struct lock_file`s are local to their respective functions and we
>> can drop their staticness.
>>
>> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
>> ---
>>  apply.c                | 2 +-
>>  builtin/describe.c     | 2 +-
>>  builtin/difftool.c     | 2 +-
>>  builtin/gc.c           | 2 +-
>>  builtin/merge.c        | 4 ++--
>>  builtin/receive-pack.c | 2 +-
>>  bundle.c               | 2 +-
>>  fast-import.c          | 2 +-
>>  refs/files-backend.c   | 2 +-
>>  shallow.c              | 2 +-
>>  10 files changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/apply.c b/apply.c
>> index 7e5792c996..07b14d1127 100644
>> --- a/apply.c
>> +++ b/apply.c
>> @@ -4058,7 +4058,7 @@ static int build_fake_ancestor(struct apply_state =
*state, struct patch *list)
>>  {
>>         struct patch *patch;
>>         struct index_state result =3D { NULL };
>> -       static struct lock_file lock;
>> +       struct lock_file lock =3D LOCK_INIT;
>
> Is it really safe to do this? I vaguely remember something about
> (global) linked list and signal handling which could trigger any time
> and probably at atexit() time too (i.e. die()). You don't want to
> depend on stack-based variables in that case.

So I dug in a bit more about this. The original implementation does
not allow stack-based lock files at all in 415e96c8b7 ([PATCH]
Implement git-checkout-cache -u to update stat information in the
cache. - 2005-05-15). The situation has changed since 422a21c6a0
(tempfile: remove deactivated list entries - 2017-09-05). At the end
of that second commit, Jeff mentioned "We can clean them up
individually" which I guess is what these patches do. Though I do not
know if we need to make sure to call "release" function or something/
Either way you need more explanation and assurance than just "we can
drop their staticness" in the commit mesage.
--=20
Duy
