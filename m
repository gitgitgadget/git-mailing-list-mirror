Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 628561F597
	for <e@80x24.org>; Wed, 25 Jul 2018 11:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeGYMVh (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 08:21:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39878 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbeGYMVh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 08:21:37 -0400
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so6328650lji.6
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 04:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7I9txWYVQj1Ma2h4XFXwtK1qzX6ONovLvOoxi7A9od4=;
        b=pT2znktlvWynfPVhYF2PSESprmsrjtgiSQrqwFGZfKslqRvTjZYYesa81t1aJHjbMG
         6e1dG7mTlq8fgd06IJg0xRmHV2vpT+NrzVirc5/n8XmPCNMCkY+fQNGs2NpL4/RdEtYz
         jE4dtA11mSxsZ6aTDKL0kL+6Vd6e0Buc7FblJsJE9lAVSiaNtWoUav93BAk8lLF4iD4d
         tlNnA0grEZteSocJw7U73eA5M0jh14MdIT3di7CRrSoHkeFfRjigCYTIE9rNGXxehV5O
         eHWqZezYn+iEUdVJvf0BZdlwdUYB/MQtloaBFpYz7ccVkXZ3BMMHantUJWpsvc94MAkt
         Be5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7I9txWYVQj1Ma2h4XFXwtK1qzX6ONovLvOoxi7A9od4=;
        b=ExvYWKRjR2Vm7tvgaQLCRvAuX73RZ1psAPiZ3MnOtRt5tTkoiOTJXmkndfF1/epRYE
         kzPQI/FmnT0qTh+nHWBlT61ObvqCJGVrk+p56ji3tKySCyA/q14K9Mm222cFuu/rGupQ
         Xf8cQIYzAsY65caQTO/S93Ljvhs64DZjYbh33W83u9I3NkafE3/+bkuOvLByYlUqUhth
         uG++pxIcmZJD/lp7D7G2ziUvSVVJljAdvlw3zLNE7KqiYvN/MbPkc4xZwgHPltCEDccT
         oCs5DVYbT/Qwx6YR3ndhQ471+ne4X9U3/BlgOZ1CnbAg66cgETofh5lbDFfq24WQdFbw
         19AQ==
X-Gm-Message-State: AOUpUlHHFVmzd1CPIg/3riOLR/yUKF2uKLPgZTlhNjYYHwbV5u6VRb+R
        HU//CwKCmui5HQq20J0M2ZYZAbaLtJU6ugJE4xAl/g==
X-Google-Smtp-Source: AAOMgpcLQD36QK9uEhuwGhjD6OhTITPCJcUYC/jx6L/NuUWWbSIhGYOit43igrsd9O2Zgo0g5yte9ebmecsPqj8dMKM=
X-Received: by 2002:a2e:9854:: with SMTP id e20-v6mr431767ljj.143.1532517024925;
 Wed, 25 Jul 2018 04:10:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:88d7:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 04:10:24
 -0700 (PDT)
In-Reply-To: <87tvonbrso.fsf@evledraar.gmail.com>
References: <20180723112736.15088-1-chenbin.sh@gmail.com> <CAE5ih79ndEbnEeV_muQyZwG+01_8Kg0J74rZtOoK1_V40E0z7g@mail.gmail.com>
 <87tvonbrso.fsf@evledraar.gmail.com>
From:   chen bin <chenbin.sh@gmail.com>
Date:   Wed, 25 Jul 2018 21:10:24 +1000
Message-ID: <CAAE-R+9sUUz4eYySDqc-B4RZhVZ_4NoZkvVHsc0T3RSePFsvKw@mail.gmail.com>
Subject: Re: [PATCH 1/1] add hook pre-p4-submit
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Luke Diamand <luke@diamand.org>, Git ML <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for you review. I will update documentation asap.

On Wed, Jul 25, 2018 at 7:14 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, Jul 25 2018, Luke Diamand wrote:
>
>> On 23 July 2018 at 12:27, Chen Bin <chenbin.sh@gmail.com> wrote:
>>> Hook pre-p4-submit is executed before git-p4 actually submits code.
>>> If the hook exits with non-zero value, submit process will abort.
>>
>>
>> Looks good to me - could you add some documentation please
>> (Documentation/git-p4.txt).
>>
>> Thanks!
>> Luke
>
> This looks correct (and you'd know better), but I was surprised that we
> wouldn't just document this in githooks(5), but looking at git-p4 I see
> that we have its config documented there, not in git-config(1) (ditto
> some git-svn config stuff).
>
> Shouldn't we at least update githooks & git-config to say that the
> config / hooks documentation for these utilities can be found there?
>
>>>
>>> Signed-off-by: Chen Bin <chenbin.sh@gmail.com>
>>> ---
>>>  git-p4.py               |  6 ++++++
>>>  t/t9800-git-p4-basic.sh | 22 ++++++++++++++++++++++
>>>  2 files changed, 28 insertions(+)
>>>
>>> diff --git a/git-p4.py b/git-p4.py
>>> index b449db1cc..69ee9ce41 100755
>>> --- a/git-p4.py
>>> +++ b/git-p4.py
>>> @@ -2303,6 +2303,12 @@ def run(self, args):
>>>              sys.exit("number of commits (%d) must match number of shel=
ved changelist (%d)" %
>>>                       (len(commits), num_shelves))
>>>
>>> +        # locate hook at `.git/hooks/pre-p4-submit`
>>> +        hook_file =3D os.path.join(read_pipe("git rev-parse --git-dir"=
).strip(), "hooks", "pre-p4-submit")
>>> +        # Execute hook. If it exit with non-zero value, do NOT continu=
e.
>>> +        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK)=
 and subprocess.call([hook_file]) !=3D 0:
>>> +            sys.exit(1)
>>> +
>>>          #
>>>          # Apply the commits, one at a time.  On failure, ask if should
>>>          # continue to try the rest of the patches, or quit.
>>> diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
>>> index 4849edc4e..48b768fa7 100755
>>> --- a/t/t9800-git-p4-basic.sh
>>> +++ b/t/t9800-git-p4-basic.sh
>>> @@ -261,6 +261,28 @@ test_expect_success 'unresolvable host in P4PORT s=
hould display error' '
>>>         )
>>>  '
>>>
>>> +# Test following scenarios:
>>> +#   - Without hook ".git/hooks/pre-p4-submit", submit should continue
>>> +#   - With hook returning 0, submit should continue
>>> +#   - With hook returning 1, submit should abort
>>> +test_expect_success 'run hook pre-p4-submit before submit' '
>>> +       test_when_finished cleanup_git &&
>>> +       git p4 clone --dest=3D"$git" //depot &&
>>> +       (
>>> +               cd "$git" &&
>>> +               echo "hello world" >hello.txt &&
>>> +               git add hello.txt &&
>>> +               git commit -m "add hello.txt" &&
>>> +               git config git-p4.skipSubmitEdit true &&
>>> +               git p4 submit --dry-run | grep "Would apply" &&
>>> +               mkdir -p .git/hooks &&
>>> +               : >.git/hooks/pre-p4-submit && chmod +x .git/hooks/pre-=
p4-submit &&
>>> +               git p4 submit --dry-run | grep "Would apply" &&
>>> +               echo #!/bin/sh && echo exit 1 >.git/hooks/pre-p4-submit=
 &&
>>> +               git p4 submit --dry-run | grep "Would apply" || echo "A=
bort submit"
>>> +       )
>>> +'
>>> +
>>>  test_expect_success 'submit from detached head' '
>>>         test_when_finished cleanup_git &&
>>>         git p4 clone --dest=3D"$git" //depot &&
>>> --
>>> 2.18.0
>>>



--=20
help me, help you.
