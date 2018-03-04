Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73CB41F404
	for <e@80x24.org>; Sun,  4 Mar 2018 03:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeCDDln (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 22:41:43 -0500
Received: from mail-oi0-f48.google.com ([209.85.218.48]:39547 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbeCDDlm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 22:41:42 -0500
Received: by mail-oi0-f48.google.com with SMTP id t185so9785979oif.6
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 19:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R01lTbSCDAxtiM3y8p50S/brV9L00SR3fTZvSzPf1bo=;
        b=EAvi+EJwI85ZcRu45HYOL4dS/SAimrdd3virT3lURCvkopVpyMXplKXk9TJlJ3UvD5
         V102yYuY3Gy6MgMvIgTk4AzbyIW5MOcyJrzHyR7UdDGZP3I/ls7IO9dRPtcfCvZH/OdD
         Ibuf0IGEMj+RWVvWCbP+HppoqY7h7m6jXcVSFCXqWTa7vCFK0LVl8NL/UZjZmF8JYGTC
         C0XRoQ1/PiIPc7lgd4/zF44BeErRMnedjBYV4/uC26G+iO8EDNx1l3tRSioPuTWgP2a1
         VDQEVDxzPXxkJxEhmEI1Uksn6zttz0fXrddhnvMKOe7HuEkPGpAjQn7mkoYxhIgrxgV1
         9CdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R01lTbSCDAxtiM3y8p50S/brV9L00SR3fTZvSzPf1bo=;
        b=Tny/XRSFv1xlVDL2th/kQRY3EBxozWNEJkA47Fzym9PEnVt6uMcxvDP3+aud+Sp6Fq
         kszHZcLKjbXECef0CIwpjg1N6z5+UqBQS3TlFRbsGOt43PWp08Kx8Zx5V2Jp5l18P2wT
         /ikTF+PFvNJrXivsN92JTsa+qEcVzrct9YDNueqUdyh/NBnI3nM8tHF3ME/WRAXl5v/a
         bPqPn0Uq7NpzKDYhbVsnqvhfsyvMq8fuPneafC1qrykBR3RByKPenIMUejb2dZWUCSJ+
         lfMyZsbWTLLZvi0PZNBGBw7wYCu4eS2DvQ5gbEJd8qd14t/yfsgmzSNCZPLL/3DQT+Ks
         2BJw==
X-Gm-Message-State: APf1xPAevzcCOZoAd/eGmnJ2sJ7omz/iSeoNoOud+HEPKJWbcS1/c0wA
        LkGET5Qka4aEE1CF22GleO/PJQDWgjbv/UqWvI/5sg==
X-Google-Smtp-Source: AG47ELtEYcteXWnUISO7gmnVIJm5bkcvhMADJyJ1IbYR0XDUqi2Wzj94MADJ3T6va/Z6mMFjWX5hWKb2TYRe5bxBxUE=
X-Received: by 10.202.206.71 with SMTP id e68mr7180616oig.34.1520134902118;
 Sat, 03 Mar 2018 19:41:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Sat, 3 Mar 2018 19:41:11 -0800 (PST)
In-Reply-To: <CAPig+cSE_x2f_8RG151MX3+FJhiofBPoVPXP+mxdJpoHXwjv9g@mail.gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com> <20180303113637.26518-14-pclouds@gmail.com>
 <CAPig+cSE_x2f_8RG151MX3+FJhiofBPoVPXP+mxdJpoHXwjv9g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 4 Mar 2018 10:41:11 +0700
Message-ID: <CACsJy8CQxsTPH15jtvDUhc8DFdtPdLNDYtFe7HNn3ntUHAv=tg@mail.gmail.com>
Subject: Re: [PATCH 13/44] pack: move approximate object count to object store
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 4, 2018 at 9:47 AM, Eric Sunshine <sunshine@sunshineco.com> wro=
te:
> On Sat, Mar 3, 2018 at 6:36 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
>> The approximate_object_count() function maintains a rough count of
>> objects in a repository to estimate how long object name abbreviates
>> should be.  Object names are scoped to a repository and the
>> appropriate length may differ by repository, so the object count
>> should not be global.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>> diff --git a/packfile.c b/packfile.c
>> @@ -813,8 +811,8 @@ static int approximate_object_count_valid;
>>  unsigned long approximate_object_count(void)
>>  {
>> -       static unsigned long count;
>> -       if (!approximate_object_count_valid) {
>> +       if (!the_repository->objects.approximate_object_count_valid) {
>> +               unsigned long count;
>>                 struct packed_git *p;
>>
>>                 prepare_packed_git();
>> @@ -824,8 +822,9 @@ unsigned long approximate_object_count(void)
>>                                 continue;
>>                         count +=3D p->num_objects;
>>                 }
>> +               the_repository->objects.approximate_object_count =3D cou=
nt;
>>         }
>> -       return count;
>> +       return the_repository->objects.approximate_object_count;
>>  }
>> @@ -900,7 +899,7 @@ void prepare_packed_git(void)
>>  void reprepare_packed_git(void)
>>  {
>> -       approximate_object_count_valid =3D 0;
>> +       the_repository->objects.approximate_object_count_valid =3D 0;
>
> Not an issue specific to this patch, but where, how, when does
> 'approximate_object_count_valid' ever get set to anything other than
> 0? Even in the existing code (without this patch), there doesn't seem
> to be anyplace which sets this to a non-zero value. Am I missing
> something obvious (or subtle)?

Probably related to this
https://public-inbox.org/git/20180226085508.GA30343@sigill.intra.peff.net/#=
t

--=20
Duy
