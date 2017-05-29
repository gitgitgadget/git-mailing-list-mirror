Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6751D20D0A
	for <e@80x24.org>; Mon, 29 May 2017 20:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751146AbdE2Ult (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 16:41:49 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34157 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbdE2Uls (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 16:41:48 -0400
Received: by mail-pf0-f195.google.com with SMTP id w69so13336204pfk.1
        for <git@vger.kernel.org>; Mon, 29 May 2017 13:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wTL1pRsp4X8M9kl5QHbpeozlthx3THGzZmLldQwi+7c=;
        b=RgmEqQiqdE2bUtO1Lp87TrcAscLooRYKdRFjCMcwCUNmfQI2fCl5Ybb7FWmIyiCoLF
         rvVGEUthkxIyU+S2gAffnBsIUF5uEoP2khii2v8naZBI5nai3xNZCeHeVBC0Ot9O0UcV
         IyvV0VYCiJLEA+dFjiId1Z7qd35DvzZd7rInbOMhMGuKmwpwHQ+vzRO3xJJ6cxtw8+wZ
         UwxiTnjKKkKYtxJHO9vEBrxBKcfDMoi0a82Vw4zaqSJ/T4rncn/lWj3NsWoeaXy+FIMA
         +pu0Nxz473nQh/Q5YW/CG9uBo2WlBFiBcpmw5zjvsLafqFDKOA+/gZEtpR4kXQ/jokjC
         5suQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wTL1pRsp4X8M9kl5QHbpeozlthx3THGzZmLldQwi+7c=;
        b=haaOrsL89HGbsWI5401SuH348WSf/J7GR7KldaDUpGs+zseGYIMyKWX0HVYYVh8wjK
         aiDtwoBShf29E3eFUfZ05huhhDjCPSaQbE94IEYnx/8MsVXCA3TElQhqpIfPtTd9mS96
         OC8nni/Wn6O88piVs8pDsQEEGsh+SQW5+Pum3dJcurKpE0lAXkdhXtduQDqQCgkZkYzw
         d+efOItfU8Mce+djcDUocS022+/hbOWno8S4T1pBAj53FFLvFrbU48gPDqzBW8WCj8ez
         7weXxKmXcG4hc9mUQwwyjS1lpOqBDzpMIi3KnfMqX5qgjaUrQDID3/Rq8Z+X0qOdBQjF
         OmHA==
X-Gm-Message-State: AODbwcDiBirMUzRvajHU6RVP7gYViJWQP312LcN0iLQYjpqOG6B/4vX2
        sI9mGM5uAO5JpCPjYmob9L7o0YdbSQ==
X-Received: by 10.84.233.199 with SMTP id m7mr78315203pln.108.1496090507983;
 Mon, 29 May 2017 13:41:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.151.14 with HTTP; Mon, 29 May 2017 13:41:27 -0700 (PDT)
In-Reply-To: <CACBZZX4LpRK5q+cxToWqGeW2ZgN4ggo4h9SJpx0mZkZUR15jNw@mail.gmail.com>
References: <0102015c5146c8ca-e5144538-326b-47b8-8c81-af31da4cdfe0-000000@eu-west-1.amazonses.com>
 <CACBZZX4LpRK5q+cxToWqGeW2ZgN4ggo4h9SJpx0mZkZUR15jNw@mail.gmail.com>
From:   Sahil Dua <sahildua2305@gmail.com>
Date:   Mon, 29 May 2017 22:41:27 +0200
Message-ID: <CALiud+mGovAoPriJxzCB93jwkChyRb49yxVtNijfag2zx-jZ0Q@mail.gmail.com>
Subject: Re: [PATCH/RFC] branch: add tests for new copy branch feature
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2017 at 1:30 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Mon, May 29, 2017 at 12:56 AM, Sahil Dua <sahildua2305@gmail.com> wrot=
e:
>> New feature - copying a branch along with its config section.
>>
>> Aim is to have an option -c for copying a branch just like -m option for
>> renaming a branch.
>>
>> This commit adds a few basic tests for getting any suggestions/feedback
>> about expected behavior for this new feature.
>>
>> Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
>> ---
>>  t/t3200-branch.sh | 53 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
>>  1 file changed, 53 insertions(+)
>>
>> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
>> index fe62e7c775da..2c95ed6ebf3c 100755
>> --- a/t/t3200-branch.sh
>> +++ b/t/t3200-branch.sh
>> @@ -341,6 +341,59 @@ test_expect_success 'config information was renamed=
, too' '
>>         test_must_fail git config branch.s/s/dummy
>>  '
>>
>> +test_expect_success 'git branch -c dumps usage' '
>> +       test_expect_code 128 git branch -c 2>err &&
>> +       test_i18ngrep "branch name required" err
>> +'
>> +
>> +git config branch.d.dummy Hello
>> +
>> +test_expect_success 'git branch -c d e should work' '
>> +       git branch -l d &&
>> +       git reflog exists refs/heads/d &&
>> +       git branch -c d e &&
>> +       git reflog exists refs/heads/d &&
>> +       git reflog exists refs/heads/e
>> +'
>> +
>> +test_expect_success 'config information was copied, too' '
>> +       test $(git config branch.e.dummy) =3D Hello &&
>> +       test $(git config branch.d.dummy) =3D Hello
>> +'
>> +
>> +git config branch.f/f.dummy Hello
>> +
>> +test_expect_success 'git branch -c f/f g/g should work' '
>> +       git branch -l f/f &&
>> +       git reflog exists refs/heads/f/f &&
>> +       git branch -c f/f g/g &&
>> +       git reflog exists refs/heads/f/f &&
>> +       git reflog exists refs/heads/g/g
>> +'
>> +
>> +test_expect_success 'config information was copied, too' '
>> +       test $(git config branch.f/f.dummy) =3D Hello &&
>> +       test $(git config branch.g/g.dummy) =3D Hello
>> +'
>> +
>> +test_expect_success 'git branch -c m2 m2 should work' '
>> +       git branch -l m2 &&
>> +       git reflog exists refs/heads/m2 &&
>> +       git branch -c m2 m2 &&
>> +       git reflog exists refs/heads/m2
>> +'
>> +
>> +test_expect_success 'git branch -c a a/a should fail' '
>> +       git branch -l a &&
>> +       git reflog exists refs/heads/a &&
>> +       test_must_fail git branch -c a a/a
>> +'
>> +
>> +test_expect_success 'git branch -c b/b b should fail' '
>> +       git branch -l b/b &&
>> +       test_must_fail git branch -c b/b b
>> +'
>> +
>>  test_expect_success 'deleting a symref' '
>>         git branch target &&
>>         git symbolic-ref refs/heads/symref refs/heads/target &&
>>
>
> This looks good to me. Comments, in no particular order:
>
> * There should be a test for `git branch -c <newbranch>`, i.e. that
> should implicitly copy from HEAD just like `git branch -m <newbranch>`
> does. However, when looking at this I can see there's actually no test
> for one-argument `git branch -m`, i.e. if you apply this:
>
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -699,8 +699,6 @@ int cmd_branch(int argc, const char **argv, const
> char *prefix)
>         } else if (rename) {
>                 if (!argc)
>                         die(_("branch name required"));
> -               else if (argc =3D=3D 1)
> -                       rename_branch(head, argv[0], rename > 1);
>                 else if (argc =3D=3D 2)
>                         rename_branch(argv[0], argv[1], rename > 1);
>                 else
>
> The only test that fails is a `git branch -M master`, i.e.
> one-argument -M is tested for, but not -m, same codepath though, but
> while you're at it a patch/series like this could start by adding a
> one-arg -m test, then follow-up by copying that for the new `-c`.
>

Thanks for the suggestion. Yes, I will add one-arg test for -c. Is it
ok to send a different patch for adding a one-arg test for existing -m
option?

> * We should have a -C to force -c just like -M forces -m, i.e. a test
> where one-arg `git branch -C alreadyexists` clobbers alreadyexists,
> and `git branch -C source alreadyexists` does the same for two-arg.
>
Yes, I missed this. I will add -C option too.

> * I know this is just something you're copying, but this `git branch
> -l <name>` use gets me every time "wait how does listing it help isn't
> that always succeeding ... damnit it's --create-reflog not --list, got
> me again" :)
>

Yes, it was confusing to me too in the beginning. I will use --create-reflo=
g.

> Just noting it in case it confuses other reviewers who are skimming
> this. Might be worth it to just use --create-reflog for new tests
> instead of the non-obvious -l whatever the existing tests in the file
> do, or maybe I'm the only one confused by this :)
>
> * When you use `git branch -m` it adds a note to the reflog, your
> patch should have a test like the existing "git branch -M baz bam
> should add entries to .git/logs/HEAD" test in this file except
> "Branch: copied ..." instead of "Branch: renamed...".
>

Nice, I will add it. Thanks.

> * Should there be tests for `git branch -c master master` like we have
> for `git branch -m master master` (see 3f59481e33 ("branch: allow a
> no-op "branch -M <current-branch> HEAD"", 2011-11-25)). Allowing this
> for -m smells like a bend-over-backwards workaround for some script
> Jonathan had, should we be doing this for -c too? I don't know.

Not sure I understand this. Can you please elaborate?
Thanks.
