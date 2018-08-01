Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B56E11F597
	for <e@80x24.org>; Wed,  1 Aug 2018 14:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389616AbeHAQn2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 12:43:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38792 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389547AbeHAQn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 12:43:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so17126531ljc.5
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 07:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KVRU18hsk34AH5aa70sxJGpzFa3R0hXX5EBzNDlg/P4=;
        b=K5iCEh8K2u3RU7OdV7icybszS7gdeco1IUcji+bMEz+Haj2MONNKZF0GjKAUMXhudE
         1UOKKPo2DWijnGunfKTMh18D+qoKNNg95GAfvNyo/JMebGhW21/u8ARcK39w4Y6+0ACA
         PmNqDngBBVnwf7ZpF67Ty2Ci28Fbl5YmksdEt6kzRaLmMNbEjMCR/Xd07w7KCjPXhPDD
         McEbbdpPd2NXpvifAZsNakRMdlza133QFqfb3i13kPpYu8FJeFlickeSIyyH9SJCGVwE
         L84tQEwYw6gTuGe4eJQslKsxBl/6ZkWGCUAvEYuec1QBXhH9jb+Z19yCinxzztItDrz2
         m2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KVRU18hsk34AH5aa70sxJGpzFa3R0hXX5EBzNDlg/P4=;
        b=ZRuE/fJQ40Jdw+CVcYHxncpIy22DzGrVH0gJy96S1iOnH31Z2AxA4fvxn17c/WawL3
         YOji5C9C99S3O/04eVuZANDgHr/2lfzQl1vH19Ci+VSM46m0g5AzisPmGoFJQRHIBG86
         ImGYIFYa5bX1Yx2tcXQmIMh5oaZTmtancbtpzDH+nfUEyn75kQTOxxEz7iiQsuv3L/at
         j2TRM/NVpw7PdILSXAJ0OGor0Hyl41NR1sudERaL1wXsgAjwgcZ8spKn9oo++GK6eIBY
         5a+3K6tyCyRDH4Q4+MeaBrSlZSCc3KWL7gb/mXC7Jl50WTLyGeRG/sW0BIdR8ydG6jCJ
         kr1Q==
X-Gm-Message-State: AOUpUlHBZLtvOjeyJAU2sDFx1wEsta0uTnfDLkzrA8AC2WrLGQxS9OWk
        SCtAOowrvcI0CwlW6KmrrFhCicuugxR2NEqe1+Q=
X-Google-Smtp-Source: AAOMgpdlR7ip/v8Mu0H+DtKLMl3zRL98ZJphavEbrSOprIOB6AXsdqXgPmEbmXfgNwjz/aIb7T1xwj9MywpxGNdrulE=
X-Received: by 2002:a2e:9448:: with SMTP id o8-v6mr658049ljh.34.1533135440202;
 Wed, 01 Aug 2018 07:57:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:88d7:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 07:57:19 -0700 (PDT)
In-Reply-To: <CAE5ih7-pLAW8xrY_F2z6gDxaMuA4w+nuUQHeLvGdSyn0GXebWA@mail.gmail.com>
References: <xmqq36w6rlh7.fsf@gitster-ct.c.googlers.com> <20180727112222.19061-1-chenbin.sh@gmail.com>
 <20180731084638.18793-1-szeder.dev@gmail.com> <CAE5ih7_jh55mLVBhiu12gmc0j3mGkm4s0VU2Stx5iGf1tK6yzA@mail.gmail.com>
 <xmqqh8kfeae3.fsf@gitster-ct.c.googlers.com> <CAE5ih7-pLAW8xrY_F2z6gDxaMuA4w+nuUQHeLvGdSyn0GXebWA@mail.gmail.com>
From:   chen bin <chenbin.sh@gmail.com>
Date:   Thu, 2 Aug 2018 00:57:19 +1000
Message-ID: <CAAE-R+8UA5S3Y4iWw=njtVVn8cu+7s8E7L9fS6UY=Q_a5-JwwQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add the `p4-pre-submit` hook
To:     Luke Diamand <luke@diamand.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I updated the patch. But for some reason the test keep failing at this line=
,
`test_must_fail git p4 submit --dry-run >errs 2>&1 &&`.

If I change this line to `test_must_fail git-p4 submit --dry-run >errs
2>&1 &&` the test will pass.

Could you help me to resolve this issue? I'm really confused. I've
already added latest `p4d` and `p4` to $PATH.

The commit is at
https://github.com/redguardtoo/git/commit/b88c38b9ce6cfb1c1fefef15527adfa92=
d78daf2


On Wed, Aug 1, 2018 at 5:54 AM, Luke Diamand <luke@diamand.org> wrote:
> On 31 July 2018 at 16:40, Junio C Hamano <gitster@pobox.com> wrote:
>> Luke Diamand <luke@diamand.org> writes:
>>
>>> I think there is an error in the test harness.
>>>
>>> On 31 July 2018 at 10:46, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrot=
e:
>>>>> +             test_must_fail git-p4 submit --dry-run >errs 2>&1 &&>
>>>>> +             ! grep "Would apply" err
>>>
>>> It writes to the file "errs" but then looks for the message in "err".
>>>
>>> Luke
>>
>> Sigh. Thanks for spotting, both of you.
>>
>> Here is what I'd locally squash in.  If there is anything else, I'd
>> rather see a refreshed final one sent by the author.
>>
>> Thanks.
>>
>>  t/t9800-git-p4-basic.sh | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
>> index 2b7baa95d2..729cd25770 100755
>> --- a/t/t9800-git-p4-basic.sh
>> +++ b/t/t9800-git-p4-basic.sh
>> @@ -274,19 +274,19 @@ test_expect_success 'run hook p4-pre-submit before=
 submit' '
>>                 git add hello.txt &&
>>                 git commit -m "add hello.txt" &&
>>                 git config git-p4.skipSubmitEdit true &&
>> -               git-p4 submit --dry-run >out &&
>> +               git p4 submit --dry-run >out &&
>>                 grep "Would apply" out &&
>>                 mkdir -p .git/hooks &&
>>                 write_script .git/hooks/p4-pre-submit <<-\EOF &&
>>                 exit 0
>>                 EOF
>> -               git-p4 submit --dry-run >out &&
>> +               git p4 submit --dry-run >out &&
>>                 grep "Would apply" out &&
>>                 write_script .git/hooks/p4-pre-submit <<-\EOF &&
>>                 exit 1
>>                 EOF
>> -               test_must_fail git-p4 submit --dry-run >errs 2>&1 &&
>> -               ! grep "Would apply" err
>> +               test_must_fail git p4 submit --dry-run >errs 2>&1 &&
>> +               ! grep "Would apply" errs
>>         )
>>  '
>
> That set of deltas works for me.
>
> Sorry, I should have run the tests myself earlier and I would have
> picked up on this.



--=20
help me, help you.
