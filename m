Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1F251F404
	for <e@80x24.org>; Wed,  4 Apr 2018 18:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeDDSgf (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 14:36:35 -0400
Received: from mail-yb0-f182.google.com ([209.85.213.182]:46341 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeDDSgd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 14:36:33 -0400
Received: by mail-yb0-f182.google.com with SMTP id e5-v6so6512791ybq.13
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 11:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AZ5ArdB7/IbZCEG+7E9eR4BdTLR/E/wC+ShexfkSNGM=;
        b=dGOBmR9EENrwflRKrPDz/rcw0rMmzyvzo9O5GtKYzgdxOue44Ek3kmxEsF4Dqgrke9
         /1eNgUAAq3Oi9R1SJYpDSyzC+1X5Fj7pgY7xFCsvj7M/vrkVAbYYsnhUGCujIRc3N9cZ
         dpGPl6jH1o/2B4hIX7fhMqg4qFYbsLNtvJ6UIgJLe4V+94qarCtAG+arbvWoIHdsZpwn
         54VhwX3Qtr/0F+u4fTsA3xeyGL4EmZpMTWk39Mji9ZF86mkk7Q4bCo2JRWXFl5QJHNUL
         YI7xDz4MLMLnjlAyaYKGBqimcGad55YnZ3nhrz/TiZwgC4mOdjWAzqNobhrCCp8E1WJM
         Pmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AZ5ArdB7/IbZCEG+7E9eR4BdTLR/E/wC+ShexfkSNGM=;
        b=EgJN5jmT2P8gQ54gGV65QbJKt1uIUZ2Qc8zVP5jIkUgHMXOk+jcjx432NPyJa/80PX
         qhhXa7pgC5j6AYTISqG/tjReZldOCGkq4dW/5/Xe9AwjG6S0bIoNiqkNVBnWTrmQD8lK
         MVHf+48Y8lj1/Q6oH1Q6xRF1muSUW5cbPJfJxo7/w/ESAAOuDGTHM8B1AfigqkvMk4FD
         9yj/MrEgXqSWLbduObo6cI4CKk1xs139Yzwel+inSSuEt3Ea+3u/tGHHnnn/oogKAxE1
         kCigtRK1HouohFOsX3CnCAygIZwv1jRUd6svTByyjuoxNV7zFhmLiRjy4YXYxne0DE0a
         bDdg==
X-Gm-Message-State: AElRT7FWWT4Fc09wGZmfqnIL5dooqEQDsxIrwqmGpnC3gK1cgRjZ8QGM
        S/wnJ2awe8+4hUlgba1aZ859DluBXZEJ3L2aOZiSsg==
X-Google-Smtp-Source: AIpwx48gAdurkNelv4rG3eAb8YKWJxrO3AGGDBAhzH7kwuV5sk0RpryAZQb+AL/lGuUmLPL7FO6wKSecVo7M0YR/nWw=
X-Received: by 2002:a25:c713:: with SMTP id w19-v6mr10664544ybe.515.1522866992480;
 Wed, 04 Apr 2018 11:36:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Wed, 4 Apr 2018 11:36:31 -0700 (PDT)
In-Reply-To: <CAK0XTWf=ubDK-4=FknLSFObZrShg=7UDgR5c6iNSjrwiDngayA@mail.gmail.com>
References: <CAK0XTWdpKnMbXs5sq2qsERxQO20sQW6YwL=2kfBHmSwHMmunBg@mail.gmail.com>
 <20180403222053.23132-1-eddy.petrisor@codeaurora.org> <20180403222053.23132-2-eddy.petrisor@codeaurora.org>
 <CAK0XTWf=ubDK-4=FknLSFObZrShg=7UDgR5c6iNSjrwiDngayA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 4 Apr 2018 11:36:31 -0700
Message-ID: <CAGZ79kYu-9vzee=R7uE4fhhrRj19ZT0Z5+7fPLwOpXhEr7aqUw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] t7406: add test for non-default branch in submodule
To:     =?UTF-8?Q?Eddy_Petri=C8=99or?= <eddy.petrisor@gmail.com>
Cc:     =?UTF-8?Q?Eddy_Petri=C8=99or?= <eddy.petrisor@codeaurora.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 3, 2018 at 3:26 PM, Eddy Petri=C8=99or <eddy.petrisor@gmail.com=
> wrote:
> Notes:
>     I am aware this test is not probably the best one and maybe I
> should have first one test that does a one level non-default, before
> trying a test with 2 levels of submodules, but I wanted to express the
> goal of the patch.

This patch only contains the test, I presume this goes on top of
https://public-inbox.org/git/20180403222053.23132-1-eddy.petrisor@codeauror=
a.org/
which you plan to later submit as one patch including both the change as we=
ll as
the test.

>     Currently the test fails, so I am obviously missing something.
> Help would be appreciated.
>
>
> 2018-04-04 1:20 GMT+03:00 Eddy Petri=C8=99or <eddy.petrisor@codeaurora.or=
g>:
>> From: Eddy Petri=C8=99or <eddy.petrisor@gmail.com>
>>
>> If a submodule uses a non-default branch and the branch info is versione=
d, on
>> submodule update --recursive --init the correct branch should be checked=
 out.
>>
>> Signed-off-by: Eddy Petri=C8=99or <eddy.petrisor@gmail.com>
>> ---
>>  t/t7406-submodule-update.sh | 54 ++++++++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 54 insertions(+)
>>
>> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
>> index 6f083c4d6..7b65f1dd1 100755
>> --- a/t/t7406-submodule-update.sh
>> +++ b/t/t7406-submodule-update.sh
>> @@ -259,6 +259,60 @@ test_expect_success 'submodule update --remote shou=
ld fetch upstream changes wit
>>         )
>>  '
>>
>> +test_expect_success 'submodule update --remote --recursive --init shoul=
d fetch module branch from .gitmodules' '
>> +       git clone . super5 &&

I found adding "test_pause &&"
to be a great helper as it will drop you in a shell where
you can inspect the repository.


>> +       git clone super5 submodl2b2 &&
>> +       git clone super5 submodl1b1 &&

We may want to cleanup after the test is done:

  test_when_finished "rm submodl2b2" &&
  test_when_finished "rm submodl1b2" &&

>> +       cd submodl2b2 &&

I'd think the test suite prefers subshells to operate in other dirs
instead of direct cd's, just like at the end of the test.
For short parts, we make heavy use of the -C option,
So for example the code below
       (
               cd super &&
               git submodule update --recursive --init
       ) &&

can be written as

    git -C super submodule update --recursive --init

which is shorter.

>> +       echo linel2b2 > l2b2 &&

style: The Git test suite prefers to have the redirect adjacent to the
file name:
  echo hello >world

>> +       git checkout -b b2 &&
>> +       git add l2b2 &&
>> +       test_tick &&
>> +       git commit -m "commit on b2 branch in l2" &&
>> +       git rev-parse --verify HEAD >../expectl2 &&

So until now we made a commit in a submodule on branch b2
and wrote it out to an expect file.


>> +       git checkout master &&
>> +       cd ../submodl1b1 &&
>> +       git checkout -b b1 &&
>> +       echo linel1b1 > l1b1 &&
>> +       git add l1b1 &&
>> +       test_tick &&
>> +       git commit -m "commit on b1 branch in l1" &&

very similar to above, just in another repo
instead of making a commit yourself, you may want to use
    test_commit <name>
then you don't need to call echo/add/commit yourself.

>> +       git submodule add ../submodl2b2 submodl2b2 &&
>> +       git config -f .gitmodules submodule."submodl2b2".branch b2 &&
>> +       git add .gitmodules &&
>> +       test_tick &&
>> +       git commit -m "add l2 module with branch b2 in l1 module in bran=
ch b1" &&

So one submodule is made to be a submodule of the other
with a specific branch (b2)

>> +       git submodule init submodl2b2 &&

git submodule add ought to have initialized that submodule
already, I am not sure we need the explicit init here.

>> +       git rev-parse --verify HEAD >../expectl1 &&
>> +       git checkout master &&

We go back to master, which doesn't have the nested submodule?

>> +       cd ../super5 &&
>> +       echo super_with_2_chained_modules > super5 &&
>> +       git add super5 &&
>> +       test_tick &&
>> +       git commit -m "commit on default branch in super5" &&
>> +       git submodule add ../submodl1b1 submodl1b1 &&
>> +       git config -f .gitmodules submodule."submodl1b1".branch b1 &&
>> +       git add .gitmodules &&
>> +       test_tick &&
>> +       git commit -m "add l1 module with branch b1 in super5" &&

now we do this again without the nested submodule, just one repo
as a submodule?

>> +       git submodule init submodl1b1 &&
>> +       git clone super5 super &&

does super exist here already? (I did not check, but IIRC
super and super{1-4} are there as we count upwards to
find a name that is ok.

>> +       (
>> +               cd super &&
>> +               git submodule update --recursive --init
>> +       ) &&
>> +       (
>> +               cd submodl1b1 &&
>> +               git rev-parse --verify HEAD >../../actuall1 &&
>> +               test_cmp ../../expectl1 ../../actuall1
>> +       ) &&
>> +       (
>> +               cd submodl2b2 &&
>> +               git rev-parse --verify HEAD >../../../actuall2 &&
>> +               test_cmp ../../../expectl2 ../../../actuall2
>> +       )

Stefan
