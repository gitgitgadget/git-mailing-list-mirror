Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5480215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 15:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754315AbeD3P3H (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 11:29:07 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:34118 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754559AbeD3P3G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 11:29:06 -0400
Received: by mail-vk0-f46.google.com with SMTP id t63-v6so5315395vkb.1
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 08:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n5Ra7r7IuxV1nhnYq0uvz170xyRgvFTqAid3ACs926E=;
        b=bZKWRtbWdu8WpnN8zCBNz6EQEWkf+4Z8HUatjHVr/OOMfUU0aVzCZuyU+zzNZE+9Sa
         snQhfMEJ2kmUu6xixYCF6d9fF9Ha+TL4LeMqLX0ePeFGia/9YXYdo6bjPKV0q+5PohT+
         +XuWizXD83sFkyO+r3LoWi0AacwjJ0ANMF6wy293pMZJLmuYcs3DuYiBUObiqqVLMUaf
         B/MB/4RNA9sTh37jFdvq2ZR44ntZTe4XVT5K/aDRpMSRkCVFy5WGl7iLDRRtGbi85Ovd
         yFkyIGlCJFoN4xUbjpuUQ9paaxgeWVOzAuYw9yPK+PcBXtOOQVkvYyAg6B/ixaOk7+8M
         hZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n5Ra7r7IuxV1nhnYq0uvz170xyRgvFTqAid3ACs926E=;
        b=pvkwhjSISR5oqwpHjo6XB7Z+lTaC3hqJsL0ZS17Iw7s+koq5/VuOYLwvtoLUWLG/Ha
         ZRXBnPGjIwI2h+S8y+mQnGXe1Gilkp0foMB0Pe6GAffbqdVJgz1chqYtTEYoG1DN3QLQ
         xO339ySBQwLxcClJzz5tHSv3MZTsg1qXkUnlj58Ue3ZqkqbClt6rQEqjJ/P6wiO1z2KV
         lcgFu6yZ4pkIWhmaqhoHU9rdh4bqKJoUdRBbTwRFr/hLbpm7mIVeg9TrBMb98vALeDRZ
         0Mdvse7OiEyacQHxJ9xlmXt8nTWfIuGK7nPt/3dQcplNifxGwCm6WIEWMKRgBp7+2cAl
         L+kQ==
X-Gm-Message-State: ALQs6tDKD0knVdrVs572JhgvAUJAgacov1Y/IWD8VeRNi1gMlr9bzBvm
        6s3VqSPp80QrB1rTrAC1NagetozwZ7Y+15gGtkg=
X-Google-Smtp-Source: AB8JxZr471RIm0Bm51zS+KU5TPAmaYy+7/Hkn/nFoAN96i7vOlxksbEYj0xRSR6xZNOeEqofkoY7Rc/Gx0mxHycOZmw=
X-Received: by 2002:a1f:a50a:: with SMTP id o10-v6mr9176775vke.187.1525102145111;
 Mon, 30 Apr 2018 08:29:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 30 Apr 2018 08:29:04 -0700 (PDT)
In-Reply-To: <7f9feab0-3638-56cd-18bb-4de0122aabad@web.de>
References: <CABPp-BEe+BK6Ew0ZLnkgCn=1J6kyJa5VTaibuJOEVeDdgLd_Ow@mail.gmail.com>
 <94c6fa4d-afe0-5a08-f844-85d3c091d3b2@web.de> <CABPp-BHitvta8we8di-tFiNdVV7vXnMNAhiAs2=CrQc-gGuSJw@mail.gmail.com>
 <7f9feab0-3638-56cd-18bb-4de0122aabad@web.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 30 Apr 2018 08:29:04 -0700
Message-ID: <CABPp-BG_uYuZuKzARRKgoKmihEVuibyG8E-QZ-XB79Yz0+GHAw@mail.gmail.com>
Subject: Re: BUG report: unicode normalization on APFS (Mac OS High Sierra)
To:     =?UTF-8?Q?Totsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Apr 27, 2018 at 2:45 PM, Totsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
> On 2018-04-26 19:23, Elijah Newren wrote:

>> Sure.  First, though, note that I can make it pass (or at least "not
>> ok...TODO known breakage") with the following patch (may be
>> whitespace-damaged by gmail):
>>
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 483c8d6d7..770b91f8c 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -1106,12 +1106,7 @@ test_lazy_prereq UTF8_NFD_TO_NFC '
>>          auml=3D$(printf "\303\244")
>>          aumlcdiar=3D$(printf "\141\314\210")
>>          >"$auml" &&
>> -       case "$(echo *)" in
>> -       "$aumlcdiar")
>> -               true ;;
>> -       *)
>> -               false ;;
>> -       esac
>> +       stat "$aumlcdiar" >/dev/null 2>/dev/null
>
>
> Nicely analyzed and improved.
>
> The "stat" statement is technically correct.
> I think that a more git-style fix would be
> [] ---
> +       test -r "$aumlcdiar"
>
> instead of the stat.
>
> I looked into the 2 known breakages.
> In short: they test use cases which are not sooo important for a user in
> practice, but do a good test if the code is broken.
> IOW: I can't see a need for immediate action.
>
> As you already did all the analyzes:
> Do you want to send a patch ?

You know, despite seeing the "test_expect_failure" and "TODO...known
breakage" with these tests and even mentioning them, it somehow didn't
sink in and I was still thinking that there might be some kind of
unicode normalization handling in the codebase somewhere (similar to
the case insensitivy handling that I've seen in a place or two) that
now needed to be extended.  I should have realized that
test_expect_failure meant there wasn't, and thus all we needed to do
was to mark it as continuing to fail with the new filesystem,  Should
have realized, but didn't.  Oops.

Anyway, it looks like you've already submitted a patch and marked it
as having been reported by me, which is just fine.  Thanks!

Elijah
