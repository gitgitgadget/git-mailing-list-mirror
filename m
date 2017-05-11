Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA9A6201A0
	for <e@80x24.org>; Thu, 11 May 2017 20:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932635AbdEKUUW (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 16:20:22 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36414 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932432AbdEKUUV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 16:20:21 -0400
Received: by mail-io0-f195.google.com with SMTP id f102so4066813ioi.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 13:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q4vL2GKxEWcaaLS0BOB/8sW2CdJ2QIO2Z8wX+JL271U=;
        b=RNy1jIPPHPv12Ld/Q3v+Fp68dy17h5VnlHOen4ZSo/MpBB1Qe3zE4JKuvul8/9J/Gd
         kbKW0ndl+HV4sZoyTLgCGd4kBWwH71h1JqlAxAEo5QYq56rHprowgPGSWlvXSHqAbxZf
         3fqWvehRz84emX/rcB+7iZB3CY8m7zmfnaMlqglmWyAzivwBJWnmie4xxd5id8qd9QLl
         X8RoGDPodSvbtEx4DG0nC6+VzCa1qD3cbnFS4rv8ZdRzPBkDJpKOxNABAitCtNriuJqv
         Ds7FgoP3qoZymmL2BEmwfX+jT/+uZQwlehFwILH3ZAwjtWWUR9OJusGZRkOfq2IoN7Yw
         6L9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q4vL2GKxEWcaaLS0BOB/8sW2CdJ2QIO2Z8wX+JL271U=;
        b=Qmj10NBX/I7aodTH/AweVloeznZ3FH7UP8JwMbsA3bR30YGjoWmbYAHSRKbSIy16Cu
         JJOMUKDM35iKcr46OsLJvJUyWgyLI3r/pKw6NCdUCGYiqnB+nvS3GMows3edyebikQfR
         3k6eLx9q4dHV/O8P0BkCgeFLvoXpSo84S/GqpKLfiS0LkubRqDEJa96VWy9yg0xT13qd
         xQfWDwD1427ifC56aBN6hjq+ELyAYFSZjbKnUV71CCtLbWT8onzk6mbOjIG1VWc5eGMy
         V2MClNpu5Jl6RXxCE0+UOW1BVfVMumrAtU9D+fz512RWAyM6PQ2Tg0hWa3NhNGlppM3y
         BmiQ==
X-Gm-Message-State: AODbwcBX453ANc9lLwohGxKsFzZaDPl93kdclfw5UnIfoLPo/v+oJ7XN
        nfn/vrscvN+3u8Xf16+ZtVw3CWhzfg==
X-Received: by 10.107.138.21 with SMTP id m21mr392149iod.80.1494534020934;
 Thu, 11 May 2017 13:20:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 11 May 2017 13:20:00 -0700 (PDT)
In-Reply-To: <20170511201404.GH83655@google.com>
References: <20170511091829.5634-1-avarab@gmail.com> <20170511091829.5634-25-avarab@gmail.com>
 <20170511201404.GH83655@google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 11 May 2017 22:20:00 +0200
Message-ID: <CACBZZX4FqGzPn_knPMekP3fMChd_UJihYLmNcm-L-T_mPk4KMg@mail.gmail.com>
Subject: Re: [PATCH 24/29] grep: move two functions to avoid forward declaration
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 10:14 PM, Brandon Williams <bmwill@google.com> wrot=
e:
> On 05/11, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Move the is_fixed() and has_null() functions which are currently only
>> used in compile_regexp() earlier so they can be used in the PCRE
>> family of functions in a later change.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  grep.c | 46 +++++++++++++++++++++++-----------------------
>>  1 file changed, 23 insertions(+), 23 deletions(-)
>>
>> diff --git a/grep.c b/grep.c
>> index 4507765811..5c808f8971 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -321,6 +321,29 @@ static NORETURN void compile_regexp_failed(const st=
ruct grep_pat *p,
>>       die("%s'%s': %s", where, p->pattern, error);
>>  }
>>
>> +static int is_fixed(const char *s, size_t len)
>> +{
>> +     size_t i;
>> +
>> +     for (i =3D 0; i < len; i++) {
>> +             if (is_regex_special(s[i]))
>> +                     return 0;
>> +     }
>> +
>> +     return 1;
>> +}
>> +
>> +static int has_null(const char *s, size_t len)
>> +{
>> +     /* regcomp cannot accept patterns with NULs so when using it
>> +      * we consider any pattern containing a NUL fixed.
>> +      */
>
> Since you're already moving these functions, mind cleaning up the
> comment to conform to our style guide?
Willdo.
>> +     if (memchr(s, 0, len))
>> +             return 1;
>> +
>> +     return 0;
>> +}
>> +
>>  #ifdef USE_LIBPCRE1
>>  static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_=
opt *opt)
>>  {
>> @@ -390,29 +413,6 @@ static void free_pcre1_regexp(struct grep_pat *p)
>>  }
>>  #endif /* !USE_LIBPCRE1 */
>>
>> -static int is_fixed(const char *s, size_t len)
>> -{
>> -     size_t i;
>> -
>> -     for (i =3D 0; i < len; i++) {
>> -             if (is_regex_special(s[i]))
>> -                     return 0;
>> -     }
>> -
>> -     return 1;
>> -}
>> -
>> -static int has_null(const char *s, size_t len)
>> -{
>> -     /* regcomp cannot accept patterns with NULs so when using it
>> -      * we consider any pattern containing a NUL fixed.
>> -      */
>> -     if (memchr(s, 0, len))
>> -             return 1;
>> -
>> -     return 0;
>> -}
>> -
>>  static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *o=
pt)
>>  {
>>       struct strbuf sb =3D STRBUF_INIT;
>> --
>> 2.11.0
>>
>
> --
> Brandon Williams
