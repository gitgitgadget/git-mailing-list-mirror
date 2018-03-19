Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 042BD1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 16:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935466AbeCSQYW (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 12:24:22 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33883 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935460AbeCSQYR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 12:24:17 -0400
Received: by mail-oi0-f46.google.com with SMTP id u141so2914094oif.1
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 09:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2zORqfZR86pUmP0O872fKRl7mVwtIvk65CqrQE8Z1fk=;
        b=LgO5yulrR5XEFd04HjkxiPrzjKaSv5f2IqXFl/zOg1tYhaYolQTXY+jEmdsn69XlOK
         BIg+2NBry7irqK5T39f2o7OWFE+aS5h/gF2x7LnL3ixEcmRbDwL/m/PbqHMFECAyDGSH
         keATiC5TJKeSCm0yJq/Y6mYBG7JpVwQA3Pv3RCD36Pv31XojAoGpLRZRSkw/CZIlOMfT
         IZOTKjFizMGDwEIypt/js2+oQ0767I+cmBUa9uINmocNywGUFKRO43q8OOuoaTozHNX0
         EKempr8yJKTUNZ4ZBUKOPM5wTqVnDzZJbO6XFFifPkjpMuPKNwZoBmDXd54zdWwVAmQ1
         vASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2zORqfZR86pUmP0O872fKRl7mVwtIvk65CqrQE8Z1fk=;
        b=H7bGEpkCgpJFlxkdCfdQ1YCdVWA2HycjlUitWVsI1L32SpTjeyBDTlIKMaUjS1yTP+
         4RLwBRmj9aTJ6IiG8q1px38/zb/SPkU3mkQUhmaP+acgmHdJRJMiWq4g71gl50AB2sZe
         FGBXd8OfN5VqhWHIoGXvMNn7di+Ev2wHch7avIqHnZSNbWwY1cpS5/LV6rESmqk4kXqj
         RAaGBQ/3JphyzssPS8j02dDw74vETEX65Qt+xT74Pf5IJrwqUCpXw8UVWLLhaO5xapjD
         TAMrJIsi/tmznm7lVHKK57Sobh+DtlTR8s1qmCMcdy/IXLik0dSKYt7VQiqJ962UdPtH
         bXXQ==
X-Gm-Message-State: AElRT7ElO6qTRzRDmT5wQc0Nvftlbxoor18AO4QV1zdunLyMtO4JG19l
        uBfs53zlm4TmnPy2WebEmgO1ju46wChtkkk/mf0=
X-Google-Smtp-Source: AG47ELthCwafj2KbJbpzjvuRhVGmnOvTZJz6IfDT2Tv3iuRIMlgHod6f6WU7rYty+phMZvx3KRCE/1PsT4m73p1DHuc=
X-Received: by 10.202.81.200 with SMTP id f191mr7306048oib.32.1521476656079;
 Mon, 19 Mar 2018 09:24:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Mon, 19 Mar 2018 09:23:45 -0700 (PDT)
In-Reply-To: <xmqqzi34vy01.fsf@gitster-ct.c.googlers.com>
References: <20180317141033.21545-1-pclouds@gmail.com> <20180318142526.9378-1-pclouds@gmail.com>
 <20180318142526.9378-10-pclouds@gmail.com> <xmqqzi34vy01.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Mar 2018 17:23:45 +0100
Message-ID: <CACsJy8CFZhUfCuzkKTYg9-_qrz4OtkZD3B3-4_P0B8KTgNR4cQ@mail.gmail.com>
Subject: Re: [PATCH v6 09/11] pack-objects: shrink size field in struct object_entry
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 5:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> +static inline int oe_fits_in_32bits(unsigned long limit)
>> +{
>> +     uint32_t truncated_limit =3D (uint32_t)limit;
>> +
>> +     return limit =3D=3D truncated_limit;
>> +}
>
> I do not think it is worth a reroll (there only are a few
> callsites), but the above has nothing to do with "oe" fitting
> anything (it is about "limit").  Do you mind if I did this instead?
>
>         static inline int fits_in_32bits(unsigned long size)
>
> ... or other suggestions, perhaps?
>

I just tried to not pollute the general namespace too much. That works
for me too.
--=20
Duy
