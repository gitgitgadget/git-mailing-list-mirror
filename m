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
	by dcvr.yhbt.net (Postfix) with ESMTP id 044FF20248
	for <e@80x24.org>; Sun, 24 Mar 2019 19:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfCXTEj (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 15:04:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37430 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCXTEi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 15:04:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id v21so5688799edq.4
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=TXJDZUdsVXIYAOatfcFUG5KhHjYs48Vkkxj6iTNtMZ8=;
        b=FP0WNCM8eeZLtbhM1nWjpeoCY0ttEVIUImeAM2pGiIKjZMGVOAwjFpx6Y/Dp8FmxG6
         RGjxgY3Qxqcj1oGRGl2FrgkukjMzSEk3lke0DE6SM3R+0bQ3iWtpxONPtNVFzZKPw2tn
         PrBNwrWm0gD9+YSww4m9+EmM9XcZExvRlMXjz++fa3TBfhJk5tciQJ8MnFQkpbUHuU3C
         AuygBRlfWLGCVjwe+QKq7itR6PWLIuL0uPLx7HoM4kH8h655Be9ewEJozHtJ9rKv9WXV
         OoPWbbzlo8QPV1cmT19h88P6ej7+g7emTVBgSnlM+5fBTMcyT7ndVCf7ulOrwUQsRbwh
         rFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=TXJDZUdsVXIYAOatfcFUG5KhHjYs48Vkkxj6iTNtMZ8=;
        b=iOZuSSkxBRS+CfclmCJfuV/J/SjUaAm0jAcl2rr1slIRAdb+DIx4x6wPxEFmVfXgtb
         6lFpXKMExxjvf4HbX20uTFcFTC+iyPSYmGo8S5oQB89BaKoPFdIm4SbTButKbkolZ1eB
         cA1aSjn6iv6Y59oLtr8CU4Cncei5ddABykT7c+FO5kKffU1sydwMe9JYHU2Xiqz2+OQb
         3KDD5yiGxxilTJV9Ej5JbZuArtdQJCwUQ48l581GLzTMBErKvYm8tNw4qcsZzCUJhyCp
         1wPfJqA0zLXJNjIGM33H+tAmH7z7gBtBIfRAMeI0TN1/hfa3NVytle1OxgdEQvn4XOsZ
         ldTw==
X-Gm-Message-State: APjAAAWTZOEvXGhL8OU7niUBcn+vPuXNcQiUSEcXScyFut4PmDKJgb0F
        xg3PSdYpW9287OM2b49+HsGQuxHy
X-Google-Smtp-Source: APXvYqyX2qm6KF4car3g4BAONmZ/ztWCsoDz99TKoft8hDlYrzIuMPWFdK6EvcvtDg1EXAUrgHZ3+A==
X-Received: by 2002:a17:906:c827:: with SMTP id dd7mr11753914ejb.100.1553454276115;
        Sun, 24 Mar 2019 12:04:36 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id l22sm4630693edc.68.2019.03.24.12.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 12:04:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     jonathan chang <ttjtftx@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC][PATCH v3 2/3] t0000: avoid using pipes
References: <cover.1552835153.git.ttjtftx@gmail.com> <5a3c6e24eb901c830e8e43608d81aef5d7b60315.1552835153.git.ttjtftx@gmail.com> <87imwha1o3.fsf@evledraar.gmail.com> <CAOAu_YJs_ZL0nAARNmdSFjmdh6mSP+e7KvzNB3wj-JGe5sHcdA@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAOAu_YJs_ZL0nAARNmdSFjmdh6mSP+e7KvzNB3wj-JGe5sHcdA@mail.gmail.com>
Date:   Sun, 24 Mar 2019 20:04:34 +0100
Message-ID: <875zs8ccvx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 24 2019, jonathan chang wrote:

> On Mon, Mar 18, 2019 at 12:47 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Sun, Mar 17 2019, Jonathan Chang wrote:
>>
>> > The exit code of the upstream in a pipe is ignored thus we should avoid
>> > using it. By writing out the output of the git command to a file, we c=
an
>> > test the exit codes of both the commands.
>> >
>> > Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
>> > ---
>> >  t/t0000-basic.sh | 28 ++++++++++++++--------------
>> >  1 file changed, 14 insertions(+), 14 deletions(-)
>> >
>> > diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
>> > index 53821f5817..47666b013e 100755
>> > --- a/t/t0000-basic.sh
>> > +++ b/t/t0000-basic.sh
>> > @@ -1118,27 +1118,25 @@ P=3D$(test_oid root)
>> >
>> >  test_expect_success 'git commit-tree records the correct tree in a co=
mmit' '
>> >       commit0=3D$(echo NO | git commit-tree $P) &&
>> > -     tree=3D$(git show --pretty=3Draw $commit0 |
>> > -              sed -n -e "s/^tree //p" -e "/^author /q") &&
>> > +     git show --pretty=3Draw $commit0 >actual &&
>> > +     tree=3D$(sed -n -e "s/^tree //p" -e "/^author /q" actual) &&
>> >       test "z$tree" =3D "z$P"
>>
>> This change is an improvement just changing the "git" invocations. But I
>> wonder as we're reviewing this / churning this if we couldn't also
>> modernize this style to just:
>>
>>     git .. >tmp &&
>>     sed -n -e <tmp >actual &&
>>     test_must_be_empty actual
>
> Do you mean something like this:
>
> -       git show --pretty=3Draw $commit0 >actual &&
> -       tree=3D$(sed -n -e "s/^tree //p" -e "/^author /q" actual) &&
> -       test "z$tree" =3D "z$P"
> +       git show --pretty=3Draw $commit0 >tmp &&
> +       sed -n -e "/$P/d" -e "s/^tree //p" -e "/^author /q" tmp >actual &&
> +       test_must_be_empty actual
>
> It works. But the semantic is different if we use test_must_be_empty.
> I wonder if you mean test_cmp because I found some commits[1 2 3]
> that changes 'test "z...' to use test_cmp with 'git log -G 'test "z' --on=
eline'
> and git-show. However, they are all around 2013, so I'm not so sure
> this is what you mean either.
>
> I did found some use of sed's 'd' function in conjunction with
> test_must_be_empty, using:
>   git grep -A 5 'sed .*/d' | grep -B 5 'test_must_be_empty'
> However, they don't use parameter expansion in sed.
>
> There are some places where parameter expansion is used in sed, but
> that would require test_cmp in this case, and would need to write to
> another file to compare.
>
> Maybe this 'test "z$A" =3D "z$B"' syntax is fine, yet most of the existing
> usages are added around 12 years ago according git-blame I saw on
> github.
>
>
> [1]: 03c893cbf9 ("t1006: modernize output comparisons", 2013-07-10)
> [2]: 848575d833 ("push test: simplify check of push result", 2013-03-18)
> [3]: ed838e6615 ("t1300: style updates", 2012-10-23)

Yeah there's many ways to do it. Generally we've been moving to the
"test_*" wrapper that e.g. given X lines print out an explanation that
we were expecting Y instead.

>> > @@ -1162,12 +1161,13 @@ test_expect_success 'very long name in the ind=
ex handled sanely' '
>> >       >path4 &&
>> >       git update-index --add path4 &&
>> >       (
>> > -             git ls-files -s path4 |
>> > -             sed -e "s/      .*/     /" |
>> > +             git ls-files -s path4 >actual &&
>> > +             sed -e "s/      .*/     /" actual |
>> >               tr -d "\012" &&
>> >               echo "$a"
>> >       ) | git update-index --index-info &&
>> > -     len=3D$(git ls-files "a*" | wc -c) &&
>> > +     git ls-files "a*" >actual &&
>> > +     len=3D$(wc -c <actual) &&
>> >       test $len =3D 4098
>>
>> Ditto. Maybe the initial author wanted to avoid writing out 4k lines,
>> but now that we're doing so anyway...
>
> This is 'wc -c', so I think I don't have to modify it?

Yes, that's a brainfart of mine. Although as an aside I have a WIP
series that adds test_byte_count which can be used for these types of
cases.

> By the way, I found 2 lines that can be changed to use test_must_be_empty
> in t0000-basic.sh. I paste the diff below:
> ---
> @@ -51,7 +51,7 @@ test_expect_success 'verify that the running shell
> supports "local"' '
>
>  test_expect_success '.git/objects should be empty after git init in
> an empty repo' '
>         find .git/objects -type f -print >should-be-empty &&
> -       test_line_count =3D 0 should-be-empty
> +       test_must_be_empty should-be-empty
>  '
>
>  # also it should have 2 subdirectories; no fan-out anymore, pack, and in=
fo.
> @@ -1110,7 +1110,7 @@ test_expect_success 'git update-index --refresh
> should succeed' '
>
>  test_expect_success 'no diff after checkout and git update-index --refre=
sh' '
>         git diff-files >current &&
> -       cmp -s current /dev/null
> +       test_must_be_empty current
>  '
