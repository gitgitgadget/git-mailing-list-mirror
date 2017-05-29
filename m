Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A82E20D0A
	for <e@80x24.org>; Mon, 29 May 2017 20:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751061AbdE2Uun (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 16:50:43 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33577 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbdE2Uum (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 16:50:42 -0400
Received: by mail-io0-f195.google.com with SMTP id m4so7654895ioe.0
        for <git@vger.kernel.org>; Mon, 29 May 2017 13:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wJ90eM1ZFuCKueFHcX6bDxff6lVYZIgRshavSpdI/Zk=;
        b=E0LRiz5j31EWptYRJtkjDYuUxr3hpbTkjmWdjUJY72Nvf2NzsqWYbBrEFzYPuAfO6l
         xQYgtLb5BV50Tj8pGIofOITl8PNRNAZmBhQAw4p/VVSiMo+6Lc4S0tYT0V53Jqa3yS54
         cCjKPY47Hxb39T5lcqGxgeNvPc+vBl/mnItiPhU3/uTNSO5ZgnsK9vaTxM7AC7w8h7xE
         I9t/UvY4c6AXnp4ichgGVY9zpzhSKnVLmyl3F7SeOdnU7xH8nmxsbVDyzRlEr7TGNeSu
         +Dvkd5z1cW11Wbgjpqdxx/qXn6mLhjCcK0IQkAIE/d+QjoEbs6HQkWrTjTs0E8aWYcKV
         1vqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wJ90eM1ZFuCKueFHcX6bDxff6lVYZIgRshavSpdI/Zk=;
        b=RiUNGW6TIkv3jYXyGleGXUiTYvoMVBSnrjbhdX/o8SHdNHQ9NCgO5BFnmA/JSw7bW8
         YOZ7Vt4QKR1Kuuo+s44Xli5CO45QfCPng5apNi5WMdyKbeSfDRnzlBrrwobAN+cP5ZKw
         8CkJPnCuaQIYlo+ZPhhIes/+1rSP/hz24go4Ff88A7MMHg10Fzn+GPeSVFm+lW0zaiCm
         GApCxUa2TTUIsyFG5K/55pYjuzwEn7lv/Zyt9d7SFkxhLEQ0voRG1L1TdSBBOmZvHnRU
         9NYLWy9OK4mJCXuiE5DiF3/K3466RbN+/oI8BCR0Wumctrs4C8nrlnvBquyFGE+JgPRh
         jHpw==
X-Gm-Message-State: AODbwcB7vTBO5ZIHXE1yEu8RHHmjKKc2XOEp5LCs9xTNqvQGRLObuZDy
        FW+U5guLp5B1XwXyhjStZ52qoe9vzw==
X-Received: by 10.107.138.21 with SMTP id m21mr14482357iod.80.1496091041273;
 Mon, 29 May 2017 13:50:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 29 May 2017 13:50:20 -0700 (PDT)
In-Reply-To: <CALiud+mGovAoPriJxzCB93jwkChyRb49yxVtNijfag2zx-jZ0Q@mail.gmail.com>
References: <0102015c5146c8ca-e5144538-326b-47b8-8c81-af31da4cdfe0-000000@eu-west-1.amazonses.com>
 <CACBZZX4LpRK5q+cxToWqGeW2ZgN4ggo4h9SJpx0mZkZUR15jNw@mail.gmail.com> <CALiud+mGovAoPriJxzCB93jwkChyRb49yxVtNijfag2zx-jZ0Q@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 29 May 2017 22:50:20 +0200
Message-ID: <CACBZZX6LcTzFKTe0fENj95Vm7GrxT5HHs3pzrqajG0XApN-rbw@mail.gmail.com>
Subject: Re: [PATCH/RFC] branch: add tests for new copy branch feature
To:     Sahil Dua <sahildua2305@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2017 at 10:41 PM, Sahil Dua <sahildua2305@gmail.com> wrote:
> On Mon, May 29, 2017 at 1:30 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Mon, May 29, 2017 at 12:56 AM, Sahil Dua <sahildua2305@gmail.com> wro=
te:
>>> New feature - copying a branch along with its config section.
>>>
>>> Aim is to have an option -c for copying a branch just like -m option fo=
r
>>> renaming a branch.
>>>
>>> This commit adds a few basic tests for getting any suggestions/feedback
>>> about expected behavior for this new feature.
>>>
>>> Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
>>> ---
>>>  t/t3200-branch.sh | 53 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>>>  1 file changed, 53 insertions(+)
>>>
>>> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
>>> index fe62e7c775da..2c95ed6ebf3c 100755
>>> --- a/t/t3200-branch.sh
>>> +++ b/t/t3200-branch.sh
>>> @@ -341,6 +341,59 @@ test_expect_success 'config information was rename=
d, too' '
>>>         test_must_fail git config branch.s/s/dummy
>>>  '
>>>
>>> +test_expect_success 'git branch -c dumps usage' '
>>> +       test_expect_code 128 git branch -c 2>err &&
>>> +       test_i18ngrep "branch name required" err
>>> +'
>>> +
>>> +git config branch.d.dummy Hello
>>> +
>>> +test_expect_success 'git branch -c d e should work' '
>>> +       git branch -l d &&
>>> +       git reflog exists refs/heads/d &&
>>> +       git branch -c d e &&
>>> +       git reflog exists refs/heads/d &&
>>> +       git reflog exists refs/heads/e
>>> +'
>>> +
>>> +test_expect_success 'config information was copied, too' '
>>> +       test $(git config branch.e.dummy) =3D Hello &&
>>> +       test $(git config branch.d.dummy) =3D Hello
>>> +'
>>> +
>>> +git config branch.f/f.dummy Hello
>>> +
>>> +test_expect_success 'git branch -c f/f g/g should work' '
>>> +       git branch -l f/f &&
>>> +       git reflog exists refs/heads/f/f &&
>>> +       git branch -c f/f g/g &&
>>> +       git reflog exists refs/heads/f/f &&
>>> +       git reflog exists refs/heads/g/g
>>> +'
>>> +
>>> +test_expect_success 'config information was copied, too' '
>>> +       test $(git config branch.f/f.dummy) =3D Hello &&
>>> +       test $(git config branch.g/g.dummy) =3D Hello
>>> +'
>>> +
>>> +test_expect_success 'git branch -c m2 m2 should work' '
>>> +       git branch -l m2 &&
>>> +       git reflog exists refs/heads/m2 &&
>>> +       git branch -c m2 m2 &&
>>> +       git reflog exists refs/heads/m2
>>> +'
>>> +
>>> +test_expect_success 'git branch -c a a/a should fail' '
>>> +       git branch -l a &&
>>> +       git reflog exists refs/heads/a &&
>>> +       test_must_fail git branch -c a a/a
>>> +'
>>> +
>>> +test_expect_success 'git branch -c b/b b should fail' '
>>> +       git branch -l b/b &&
>>> +       test_must_fail git branch -c b/b b
>>> +'
>>> +
>>>  test_expect_success 'deleting a symref' '
>>>         git branch target &&
>>>         git symbolic-ref refs/heads/symref refs/heads/target &&
>>>
>>
>> This looks good to me. Comments, in no particular order:
>>
>> * There should be a test for `git branch -c <newbranch>`, i.e. that
>> should implicitly copy from HEAD just like `git branch -m <newbranch>`
>> does. However, when looking at this I can see there's actually no test
>> for one-argument `git branch -m`, i.e. if you apply this:
>>
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -699,8 +699,6 @@ int cmd_branch(int argc, const char **argv, const
>> char *prefix)
>>         } else if (rename) {
>>                 if (!argc)
>>                         die(_("branch name required"));
>> -               else if (argc =3D=3D 1)
>> -                       rename_branch(head, argv[0], rename > 1);
>>                 else if (argc =3D=3D 2)
>>                         rename_branch(argv[0], argv[1], rename > 1);
>>                 else
>>
>> The only test that fails is a `git branch -M master`, i.e.
>> one-argument -M is tested for, but not -m, same codepath though, but
>> while you're at it a patch/series like this could start by adding a
>> one-arg -m test, then follow-up by copying that for the new `-c`.
>>
>
> Thanks for the suggestion. Yes, I will add one-arg test for -c. Is it
> ok to send a different patch for adding a one-arg test for existing -m
> option?

Yeah, it makes sense to just make the first patch in the series be
some cleanup / improvement of the existing tests, which the subsequent
tests for -c then make use of / copy. It could even be sent on its
own, but probably makes sense to just bundle them up. Up to you
though, in this case you won't need patch A for patch B to work, so
the that's one argument against bundling them up. Personally I'd do it
if I was hacking this just because it's more convenient to keep track
of fewer things.

>> * We should have a -C to force -c just like -M forces -m, i.e. a test
>> where one-arg `git branch -C alreadyexists` clobbers alreadyexists,
>> and `git branch -C source alreadyexists` does the same for two-arg.
>>
> Yes, I missed this. I will add -C option too.
>
>> * I know this is just something you're copying, but this `git branch
>> -l <name>` use gets me every time "wait how does listing it help isn't
>> that always succeeding ... damnit it's --create-reflog not --list, got
>> me again" :)
>>
>
> Yes, it was confusing to me too in the beginning. I will use --create-ref=
log.
>
>> Just noting it in case it confuses other reviewers who are skimming
>> this. Might be worth it to just use --create-reflog for new tests
>> instead of the non-obvious -l whatever the existing tests in the file
>> do, or maybe I'm the only one confused by this :)
>>
>> * When you use `git branch -m` it adds a note to the reflog, your
>> patch should have a test like the existing "git branch -M baz bam
>> should add entries to .git/logs/HEAD" test in this file except
>> "Branch: copied ..." instead of "Branch: renamed...".
>>
>
> Nice, I will add it. Thanks.
>
>> * Should there be tests for `git branch -c master master` like we have
>> for `git branch -m master master` (see 3f59481e33 ("branch: allow a
>> no-op "branch -M <current-branch> HEAD"", 2011-11-25)). Allowing this
>> for -m smells like a bend-over-backwards workaround for some script
>> Jonathan had, should we be doing this for -c too? I don't know.
>
> Not sure I understand this. Can you please elaborate?
> Thanks.

So the reason we have this for -m is:

    commit 3f59481e33
    Author: Jonathan Nieder <jrnieder@gmail.com>
    Date:   Fri Nov 25 20:30:02 2011 -0600

    branch: allow a no-op "branch -M <current-branch> HEAD"

    Overwriting the current branch with a different commit is forbidden, as=
 it
    will make the status recorded in the index and the working tree out of
    sync with respect to the HEAD. There however is no reason to forbid it =
if
    the current branch is renamed to itself, which admittedly is something
    only an insane user would do, but is handy for scripts.

My understanding of that last part is that Jonathan/someone (see
reported-by in that patch) had some script which was renaming
branches, and it was easier for whatever reason to just make it no-op
if the rename would have yielded the same result as doing nothing at
all.

Most likely your implementation will consist of just re-using the
logic in rename_branch() (and renaming it to e.g.
copy_or_rename_branch() ...) so you could just re-use the no-op
behavior we use for -m, or if there's some reason not to no-op and
error instead for -c we could just do that, but in any case this case
of `git branch -c master master` or `git branch -c currentbranch`
should be tested for.
