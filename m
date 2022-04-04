Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DFDC46467
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 21:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380142AbiDDVV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379527AbiDDRXe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 13:23:34 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F1E1E3E9
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 10:21:38 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q68so1808794ljb.3
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 10:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UvP8eRYpanv6oyzA2YApgb7Q1B/L5CVvNqwT6bIYoGY=;
        b=auF6GSkIWeFMtsFs9zWzUvSq91uiUghKi47KtcVLwdIYcD1EqfZdWEZCZktosApPCG
         w5bERi7Ew80Q+L8Ro2ejDxXYam89PeOQRwaRFiOUU5xcaGLqibWkhW7QbiOOywmIGJxH
         GWNFygvg9ftP/D54y/mcIDOvR5GCrGtdUOun5FImiYr8gDHu3gb1VUhgXYyeekJPjlmc
         yV5LvoCbssExNZ4upZnPUz7i4NLY8rW6I/VMKFQXaCwu/LUDvoW2+7pLWDtpFzGuJwrb
         a8GTuKfdXdJx8JHYFFcuZsUtZjLZy5hZMY6GmiYjLiU7pfWfpo5hDdEW2Tvi62yvF4va
         dbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UvP8eRYpanv6oyzA2YApgb7Q1B/L5CVvNqwT6bIYoGY=;
        b=Kqussklc/24QT5dxR4wh9OuEl5quGnbCYNqF0D4OHlyumT6xup0Lrphzx2+O/lsoVw
         rkv0201BeHAOpFp76gzs7fGQADDTKO9NwvPCe85ygB+gI2wt2xrj8XXHfN1O9XKheR4J
         R+3zVSr50T8WjCFeQ5r2HrcebZFTVLvCxOZo/5LD7oX8EHSnfU3JNLLwnjfVihLKhb17
         U/1mpUMTYQ120/kFEl6J7gjda/HA8Tm6KkoNnZ+DeCCZN6aGc24EZUsJEcKLI0kwRW8j
         Uw2IjysYCCCXI1dBESisiX15MfXC3rSHfai3nUGm0RENf6Bm/JAPQGg3c1qmhokhknlI
         aWAQ==
X-Gm-Message-State: AOAM532q4UutCqwJXxUVejejiD8Wn3wZhrJVo0yKCAOXXIaEGm3QxxDx
        fuFNK2vV9/DTBSA6aHypfg1HKUVIpDg2qwbHnUr6eppSMBA=
X-Google-Smtp-Source: ABdhPJxyD8yEIKSV4BChHMzTuHbPsVBAyOppF3VciolbpR6mU9EDVDGOg/9mBmuDJwzBjhhVWXd/1Br/iK0S+3GZ1c4=
X-Received: by 2002:a2e:2c0f:0:b0:24b:852:36df with SMTP id
 s15-20020a2e2c0f000000b0024b085236dfmr406883ljs.392.1649092896164; Mon, 04
 Apr 2022 10:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220404055151.160184-1-alexhenrie24@gmail.com> <xmqqtub8rdrw.fsf@gitster.g>
In-Reply-To: <xmqqtub8rdrw.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 4 Apr 2022 11:21:24 -0600
Message-ID: <CAMMLpeQUZ3OfP=G-qKRjUVON=hninYEDQeeCrAdfM9maAZ3j7Q@mail.gmail.com>
Subject: Re: [PATCH] convert: clarify line ending conversion warning
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>, prohaska@zib.de,
        eyvind.bernhardsen@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 4, 2022 at 10:53 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > Rephrase the warning to be clear that line endings have not been change=
d
> > in the working directory but will be changed on the next checkout, and
> > explicitly say which line endings the file currently has in the working
> > directory.
> >
> > Example commands to trigger the warning on Linux:
> >
> > git config core.autocrlf true
> > echo 'Hello world!' > hello.txt
> > git add hello.txt
> > git commit -m "Add hello.txt"
>
> While the "example" does not hurt, because the log message is not
> executable, it would not help to its potential unless you add its
> expected output to go with it.
>
>     On a platform whose native line endings are not CRLF
>     (e.g. Linux), the "git add" step in the sequence triggers the
>     waring in question.
>
>     $ git config core.autocrlf true
>     $ echo 'Hello world!' >hello.txt
>     $ git add hello.txt
>     warning: LF will be replaced by CRLF in hello.txt
>     The file will have its original line endings in your working director=
y
>
> or something like that.
>
> I think the recent trend is to enclose end-user supplied strings
> (like misspelt option names, arguments to options, and pathnames)
> inside single quote, so
>
>     warning: LF will be replaced by CRLF in 'hello.txt'.
>
> would probably be a good idea, on top of what you are aiming for.
> Also, in a multi-sentence warning message like this, I do not think
> it makes sense to omit the end-of-sentence full-stop.

Sure. I'll do all of that in the v2.

> I have mixed feelings with this change, even though I agree that the
> original is not good.  The first sentence of the updated text
> already says that right now, the file ends with CRLF, and that the
> conversion happen the next time you check out the file to the
> working tree.  And that makes "For now ... still" totally redundant.
>
> Perhaps a single sentence, nothing more than
>
>         warning: in '%s', CRLF will be replaced by LF the next time
>         you check it out
>
> is sufficient?  I dunno.

I like your idea to move the file name to the start of the message,
and I think that will address =C3=86var's concern as well.

It doesn't matter to me whether the message is one sentence or two
sentences. If you have a slight preference for one sentence then let's
just do that.

Thanks for the feedback!

-Alex
