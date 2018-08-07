Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99F7B208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 13:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389273AbeHGQAz (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 12:00:55 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:35626 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389094AbeHGQAz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 12:00:55 -0400
Received: by mail-ua0-f193.google.com with SMTP id q12-v6so16147629ual.2
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 06:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IFY0VfhEJsssTTkdS7U9DoCvkqB6pruv2NSNOlHn7fY=;
        b=u1cJDENP9hvO47kGPDirpTbpNI5YOp21+5CnDGSIgP+W3t45jZS3hJFSOixNv8mW3n
         HKNPgblhzrrDF2FY0ONlbnyM+oN26UHDPaDT2/igvEfGe7SxVSyQXUZD2ulnZvFGvNeT
         OEeUeDEgnpzIgWJuwtVqmMEGV7XRHYHN5MJJqrk4jsbrC5r2JR/SQljxJ0RkHzDxVfYm
         Q4hDsSEf3LSDevJwyQOtMFUcdbVZP0Ip3I3hKOrPEg6nMGqSNKJscfaZo616nus99g4k
         oSLNCbZUJawGF2RWQERlAL6/kimCj3MdA9my/UbZIDhifKhX34A+r/TEsf4jDufKllSg
         lzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IFY0VfhEJsssTTkdS7U9DoCvkqB6pruv2NSNOlHn7fY=;
        b=fd50WaorPG8iGfGnf/gJ+IrejahIApuhk1U5jYclZPZNraOItHXV4nuOk0Xl+uwVUI
         4wleKqyt60IQAdms+L9VIfDwoQQz7Vz9jN0Lm/o1YO2SU3MLzCuWpCPTCLf0wPxT0OUt
         QUL6Xv1rhEZD3Q+GlY+T+jZWXCv/XvhdSiC5xXomzT+g70q29iq9uA1v93j0eo7v3Zri
         9VgWvfULzYyTGiE4woEhkovnByKUVNyAlmN5HomrQixndciJHlUDKJVhXCTRdNFw3sKU
         HGQXv1gXExa1VfDSDJXVCvmC7Hnm2cWYSnL20+MKlOc6/Un7HGdUBHKvHXZ6M21WxVFb
         QUVw==
X-Gm-Message-State: AOUpUlGqhd8t1P4X0z3P6NmMPI/+tRQSq6mbKsiA2FaTfmiy6lugxMTD
        TYorqk05fqgBVjd7T/H7pth0ipZHDQWaQ1lC/IY=
X-Google-Smtp-Source: AAOMgpcI24ZWWHeH/vzh9PaBa9rzCwhv7+wulNo/YM67zkTsW2zCGBmsdK+rIzZyRes637KgSGKjCcF2+MQ83zPPxic=
X-Received: by 2002:a1f:207:: with SMTP id 7-v6mr12778736vkc.0.1533649589723;
 Tue, 07 Aug 2018 06:46:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 06:46:29 -0700 (PDT)
In-Reply-To: <20180807090739.5829-1-szeder.dev@gmail.com>
References: <20180803231407.10662-1-newren@gmail.com> <20180806152524.27516-1-newren@gmail.com>
 <20180806152524.27516-4-newren@gmail.com> <20180807090739.5829-1-szeder.dev@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Aug 2018 06:46:29 -0700
Message-ID: <CABPp-BEfmUf+TKMb8oX47qJtXJ-X4einLEdEuvJe4=0Pa5D7FA@mail.gmail.com>
Subject: Re: [PATCH 3/3] t7406: make a test_must_fail call fail for the right reason
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 7, 2018 at 2:07 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>> A test making use of test_must_fail was failing like this:
>>   fatal: ambiguous argument '|': unknown revision or path not in the wor=
king tree.
>> when the intent was to verify that a specific string was not found
>> in the output of the git diff command, i.e. that grep returned
>> non-zero.  Fix the test to do that.
>>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>>  t/t7406-submodule-update.sh | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
>> index c8971abd07..f65049ec73 100755
>> --- a/t/t7406-submodule-update.sh
>> +++ b/t/t7406-submodule-update.sh
>> @@ -603,7 +603,8 @@ test_expect_success 'submodule update - update=3Dnon=
e in .git/config but --checkou
>>        git diff --name-only >out &&
>>        grep submodule out &&
>>        git submodule update --checkout &&
>> -      test_must_fail git diff --name-only \| grep submodule &&
>> +      git diff --name-only >out &&
>> +      ! grep submodule out &&
>>        (cd submodule &&
>>         test_must_fail compare_head
>
> May I suggest a while-at-it cleanup? :)

I think while-at-it-cleanups have become the primary purpose of this
series.  :-)

> Here 'test_must_fail' is used in front of a shell function, which
> should be written as '! compare_head', and indeed in all other places
> in this test script it's written that way.

Good catch; I'll fix it up.  In fact, there's also one other
test_must_fail in front of a non-git command inside t7406, so I'll fix
that up while at it too.
