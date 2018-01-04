Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD6681F404
	for <e@80x24.org>; Thu,  4 Jan 2018 21:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeADVK6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 16:10:58 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:36554 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752659AbeADVK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 16:10:57 -0500
Received: by mail-vk0-f52.google.com with SMTP id s139so1706135vkb.3
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 13:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GZeEh2yHIIdaBjXab60rbVJQa/fOpRReAtmfhB3z25Q=;
        b=caSg33sCZt3Iph/yP2uWxcHx94r4QIHxfmq51CHMF2ANrHVW85LpE15cCuO8/UpQrY
         EBwnCgxTwH/pLngih5TtjvhPbJQus/nkUhdKgw7Itadt6Y/LogSV17vST0VY1GtgoeYQ
         Q3/AHQV5MStT9xglJ08a/uNKaW5gZcSLmqAp3AEtvC9gzk/z5WrczcXppLMdbCRyb5ll
         RqIwMTtS54QkO4dVTNKqEHVSS5yKp6s+L4d4+JzKO6rwtStz8y/RJoQ+yFzEkFFZxV2Z
         jPMrVW80Jz+YVnNwV+N2SzQ0ttiSLJu83TW1PIaMWhPulcKOTFeQ9BtuXP+ZVqbXLqwI
         ofRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GZeEh2yHIIdaBjXab60rbVJQa/fOpRReAtmfhB3z25Q=;
        b=YWb+FBAuLpp8ydWuqfA6vE3l6TjLOnDTnm8KO1Q9G/Yvm8Q5nA2ayLx0PqpjtXSP+R
         nAXW7Z2Uw9BgGaQRO/igc1/Em2gjBnGtXFpgF+Nv0InueFK2H/N8cuiK7tr+FstIVQbX
         WLNBYrOVFszIV3DuLgPA3OeD+hY+0/Snp9S0eolyf7sWmeR2wOZCqjBfcYw60CZaVSNV
         Q0D8Wc/4bq75SOSYMQKqVT0Rl6eXkDEoB4S9Jc2hBTGqy3xGD0yRvM09bkMlfYMv5I72
         CCWgo9FGuCvFg5/0d5cTBKjuidMMfsksXc7oA656/kv5pVJMFJ8Y/g4VovHtdW+g2u7Z
         b/+g==
X-Gm-Message-State: AKwxytfafa0NNEBgkXk1eGMXhHfUvfKBotBaCfyzhiZGuWwPw2WQzZwX
        5CIBHJAsIORvrkzc3clB4Nq4ZAzC6rY9vDeEjkM=
X-Google-Smtp-Source: ACJfBotzcTDM2rHirUtFVsjAD/EK9ac38GfqfXFzRrI0/phe9B/xeD9cBry4QFf1PfGpt3JOvYzI20wrReCqmlyXF74=
X-Received: by 10.31.157.135 with SMTP id g129mr900040vke.114.1515100256622;
 Thu, 04 Jan 2018 13:10:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.82.5 with HTTP; Thu, 4 Jan 2018 13:10:55 -0800 (PST)
In-Reply-To: <20180104005223.13566-1-szeder.dev@gmail.com>
References: <20171228041352.27880-14-newren@gmail.com> <20180104005223.13566-1-szeder.dev@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 4 Jan 2018 14:10:55 -0700
Message-ID: <CABPp-BH66p1MU0Ry0LRcSpr7yGZymqwrnBmMh239xO3rgShdcw@mail.gmail.com>
Subject: Re: [PATCH v5 13/34] directory rename detection: tests for handling
 overwriting untracked files
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 3, 2018 at 5:52 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:

>> +             test $(git rev-parse :0:y/b) =3D $(git rev-parse O:z/b) &&
>
> There is a test helper for that :)
>
>   test_cmp_rev :0:y/b O:z/b
>
> Note, that this is not only a matter of useful output on failure, but
> also that of correctness and robustness.


Cool, good to know.  Is there any reason test_cmp_rev is not
documented in t/README?

I already changed these yesterday, as part of trying to avoid the use
of plain 'test' as you suggested (I was just waiting another day or so
for more feedback before resubmitting the series).  Since I tended to
have several of these rev-parse comparisons in a single test, I simply
combined them:
    git rev-parse >actual
      :0:y/b :1:x/c :2:x/c :3:x/c
    git rev-parse >expect
      O:z/b O:x/c A:x/c B:x/c
    test_cmp expect actual

That does result in fewer rev-parse invocations, which is probably
good, but the test_cmp_rev does seem slightly more readable.  Hmmm...

> I noticed that this patch series adds several similar
>
>   test $(git hash-object this) =3D $(git rev-parse that)
>
> conditions.  Well, for that we don't have a test helper
> function.  Similar 'hash-object =3D rev-parse' comparisons are already
> present in two other test scripts, so perhaps it's worth adding a
> helper function.  Or you could perhaps
>
>   git cat-file -p that >out &&
>   test_cmp this out

Yeah, I switched these over to the same format above; e.g.
   git hash-object this >actual &&
   git rev-parse that > expect &&
   test_cmp expect actual

That does have the advantage of re-using a similar style.

>> +             test "very" =3D "$(cat y/c)" &&
>> +
>> +             test "important" =3D "$(cat y/d)" &&
>
> The 'verbose' helper could make conditions like these more, well,
> verbose about their failure:
>
>   verbose test "very" =3D "$(cat y/c)" &&

Also good to know.  Is there any reason the "verbose" helper isn't
documented in t/README?

I also switched these over yesterday to write to files and then use
test_cmp, but

>> +             test "important" !=3D "$(git rev-parse :3:y/d)" &&
>
> I'm not sure what this condition is supposed to check.

Well that's embarrassing.  That was supposed to be 'cat-file -p', not
rev-parse.  And since I'm already testing that y/d on disk does have
"important" as its contents and that :3:y/d matches O:z/c (i.e. has
contents of "c"), the check was rather unnecessary, and too easy to
false pass.  I think I should just remove it (and two others like it).
