Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD1141FF76
	for <e@80x24.org>; Wed, 23 Nov 2016 09:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756558AbcKWJn5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 04:43:57 -0500
Received: from mail-yw0-f169.google.com ([209.85.161.169]:34083 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756508AbcKWJnk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 04:43:40 -0500
Received: by mail-yw0-f169.google.com with SMTP id t125so6559299ywc.1
        for <git@vger.kernel.org>; Wed, 23 Nov 2016 01:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eugXcSdFLkPfC6XS1YcPtUXUb2cZT5CUffpTTd57NzA=;
        b=O8+2mmDdpQLbY9In76zcX5w1D4VfugIYLy1B+4Ll4tD1PJIFjVklZVln1yV4C4t7g0
         l5aGs9bR7/HeQ5zJpSW/FU4YmO1SHd6zxJDWrnmVbLzsKkoOVJSVG93nnx6857rRKxLx
         vegM9Joh9LFK8JTey1Yi3BybG+bGbOmnu2vhmk+wSNN3mlELsUjbnUQZM8uZ/1ZWBxPf
         cCzOFyxiRv3uBp0Wepbv75kYrJJDv8cOZOjC5j4RtyLBk1UCbTFpfLIscZnfDEOHljt1
         QIkbXfcHXRU1/9EKZ7bL11CRz9kF+1UePcHJ63G3njospRleNQIRkWTAlkTa+G80ZHmX
         kKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eugXcSdFLkPfC6XS1YcPtUXUb2cZT5CUffpTTd57NzA=;
        b=mqIxEk7GcYCUZ7vvyqROueKbEaxUiTBcvClQUiGBn14NBEjSdql7A8VD6tGomsReU2
         H98FTLJj/eegzD2oRrSOZBVCyuUIH3gXgSu/ouIgi+7H3VJ6wS6d9hNu0C+0x8/vNiVO
         CEpwupXUJACXCAt88DxGy29IoPzGhTImE3Re9z3tAtDz99dodFn/ttx8vF+OsRZ3gPzY
         gw2ve5u6ddYQKtnaog+4hqKWWustxZbSQyMyjaRSheJ5a9WPjhsGajGUYWFVWp7e9Teb
         bw6r1Jd8eAsRNAxBFFoCsnIUHVWqqluXcJuuvn5t1gJLboThrbsNEk9KQnAHScr9JLe7
         RjVA==
X-Gm-Message-State: AKaTC02zYjb2h7Mce4AZ0DpRks7FvLNc6tCwboCS6V96h48oCmw6AC75qzzDW/4tvdbb6UqwrldaZo4fV2B1NQ==
X-Received: by 10.13.239.198 with SMTP id y189mr2098084ywe.202.1479894219156;
 Wed, 23 Nov 2016 01:43:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.211.7 with HTTP; Wed, 23 Nov 2016 01:43:08 -0800 (PST)
In-Reply-To: <20161122174946.jy5at4g7rifu3und@sigill.intra.peff.net>
References: <20161122123019.7169-1-pclouds@gmail.com> <20161122174946.jy5at4g7rifu3und@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 23 Nov 2016 16:43:08 +0700
Message-ID: <CACsJy8BFRroifr0OL0O5OZjkPkndeZzVYCkg9vCNk+7Ee4zouA@mail.gmail.com>
Subject: Re: [PATCH] merge-recursive.c: use QSORT macro
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 23, 2016 at 12:49 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 22, 2016 at 07:30:19PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> This is the follow up of rs/qsort series, merged in b8688ad (Merge
>> branch 'rs/qsort' - 2016-10-10), where coccinelle was used to do
>> automatic transformation.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>   coccinelle missed this place, understandably, because it can't know
>>   that
>>
>>       sizeof(*entries->items)
>>
>>   is the same as
>>
>>       sizeof(*df_name_compare.items)
>>
>>   without some semantic analysis.
>
> That made me wonder why "entries" is used at all. Does it point to the
> same struct? But no, df_name_compare is a string list we create with the
> same list of strings.
>
> Which is why...
>
>> -     qsort(df_sorted_entries.items, entries->nr, sizeof(*entries->items=
),
>> +     QSORT(df_sorted_entries.items, entries->nr,
>>             string_list_df_name_compare);
>
> ...it's OK to use entries->nr here, and not df_sorted_entries.nr. It
> still seems a bit odd, though.

Argh.. I completely overlooked that entries->nr !

> Maybe it's worth making this:
>
>   QSORT(df_sorted_entries.items, df_sorted_entries.nr,
>         string_list_df_name_compare);
>
> while we're at it. Another possibility is:
>
>   df_sorted_entries.cmp =3D string_list_df_name_compare;
>   string_list_sort(&df_sorted_entries);
>
> It's not any shorter, but maybe it's conceptually simpler.

Agreed. Shall I re-roll with this?
--=20
Duy
