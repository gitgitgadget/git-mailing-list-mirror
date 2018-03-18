Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04CF81F42D
	for <e@80x24.org>; Sun, 18 Mar 2018 08:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbeCRIrW (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 04:47:22 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:34919 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbeCRIrV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 04:47:21 -0400
Received: by mail-qt0-f181.google.com with SMTP id z14so15113484qti.2
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 01:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=+QcEdmXa2G4y2ay1/SPf6rxRPwRErlX1e6J5jul+bsU=;
        b=FaLhTFc+x0CiVLP1rDqCceNIAFGJhi/fg/XsdYietq0cpPhhHBoKRInKy0SORVSy87
         viQsIuQbe4uEWans0Bzh3j0FhC6EXlXyIwnOD6IWudwaUippu39vhreD5O2r1zVlRg1f
         wAHk7zGdeFogctlOkRHRbf94E9t1zQUhi12pySlin0JhCG47VVUNTW4pbzdAqAbH0MEk
         VotD2KYVAkjRlMjZ+KWPYbcBI+jmssQ7AGIqWIa3LmSgkR1vt2ZgNzg3oJHsqueuXM8u
         8NO5WLvAlF0bM/KtXMlKVqr54jjZBEbqDaNVAXN+T9tmyXvB2eCAJrA4OTvNjp5v897g
         8Xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=+QcEdmXa2G4y2ay1/SPf6rxRPwRErlX1e6J5jul+bsU=;
        b=DfPo2y03Z88u5ZbqaKETwGO/Ky8V5mS3a3d9CvRRMVGoPWTk3/pq0t22zJJHxdtPLU
         rdm0C+k9mrGK8wkQuh7wEkJrHhxQpDH37M5No4DM6hTt5zGpzITjYDuNnkUprKbn+s3H
         GnF5Hw/CCAmgHTPaL332BhMG11x7PNqt6Y1Kvr5O+CGJb7lpABlPF49PkOIT0pd+etoO
         XWT+j2R5AisnAUprspxE7xD0gHmgzLcO7Gpafwq4Ss6xJ6rutrrN2VO3VccbDIAQEPbc
         cgebS+sByVQU/VdnVPmykQ+VS9AkV7WSB29SY7Vo601ne4L6qlZwd7MTqFA4ZW7+DlFC
         Mbjw==
X-Gm-Message-State: AElRT7G9b2Y+wBJ5X+lpOxR82qZh6f5chwRQuBbpz9xmTO6JXHvag8dI
        cKZpqjZnljbagV09OftN6TGqgKAEKZah4XWaOJ8=
X-Google-Smtp-Source: AG47ELvLbjOPJ9+odX/NuPX5majDo82fz2lx0q7nCm0sOxVa1WxX27ObZxWfTC+AHZNKbLcs8X90HkfZwaNErlO1PGs=
X-Received: by 10.200.1.2 with SMTP id e2mr6885957qtg.121.1521362841160; Sun,
 18 Mar 2018 01:47:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Sun, 18 Mar 2018 01:47:20 -0700 (PDT)
In-Reply-To: <CACsJy8CeXZJashmh+sLykRR4Mm_EwnASMVyB-4ztEcfQXU7MXw@mail.gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com> <20180317075421.22032-5-pclouds@gmail.com>
 <CAPig+cTSqxLTDoq3xGAmf1xCyCX0jvwyoSL5GApgaNg5PVPGGg@mail.gmail.com> <CACsJy8CeXZJashmh+sLykRR4Mm_EwnASMVyB-4ztEcfQXU7MXw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 18 Mar 2018 04:47:20 -0400
X-Google-Sender-Auth: AfK7_LD78kM11h4pEXmmGqo7uHo
Message-ID: <CAPig+cRGpD1_U5PgO=-1wrsiyWqY4GmE3tWNdgCnuAh7PUjvHg@mail.gmail.com>
Subject: Re: [PATCH 04/36] t/helper: merge test-lazy-init-name-hash into test-tool
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 18, 2018 at 4:25 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Mar 18, 2018 at 3:11 AM, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>> On Sat, Mar 17, 2018 at 3:53 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
>>> -extern int test_lazy_init_name_hash(struct index_state *istate, int tr=
y_threaded);
>>> +extern int lazy_init_name_hash_for_testing(struct index_state *istate,=
 int try_threaded);
>>
>> I get why you renamed this since the "main" function in the test
>> program wants to be called 'test_lazy_init_name_hash'...
>>
>>> diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-i=
nit-name-hash.c
>>> @@ -9,6 +10,9 @@ static int perf;
>>> +static int (*init_name_hash)(struct index_state *istate, int try_threa=
ded) =3D
>>> +       lazy_init_name_hash_for_testing;
>>> +
>>> @@ -33,9 +37,9 @@ static void dump_run(void)
>>>         if (single) {
>>> -               test_lazy_init_name_hash(&the_index, 0);
>>> +               init_name_hash(&the_index, 0);
>>
>> ... but I'm having trouble understanding why this indirection through
>> 'init_name_hash' is used rather than just calling
>> lazy_init_name_hash_for_testing() directly. Am I missing something
>> obvious or is 'init_name_hash' just an unneeded artifact of an earlier
>> iteration before the rename in cache.{c,h}?
>
> Nope. It just feels too long to me and because we're already in the
> test I don't feel the need to repeat _for_testing everywhere. If it's
> confusing, I'll remove init_name_hash.

Without an explanatory in-code comment, I'd guess that someone coming
across this in the future will also stumble over it just like I did in
the review.

What if, instead, you rename test_lazy_init_name_hash() to
lazy_init_name_hash_test(), shifting 'test' from the front to the back
of the name? That way, the name remains the same length at the call
sites in the test helper, and you don't have to introduce the
confusing, otherwise unneeded 'init_name_hash'.
