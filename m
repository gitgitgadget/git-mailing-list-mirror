Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6D4F201A4
	for <e@80x24.org>; Sun, 14 May 2017 15:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758966AbdENPKl (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 11:10:41 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:34108 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758708AbdENPKk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 11:10:40 -0400
Received: by mail-io0-f173.google.com with SMTP id k91so61418387ioi.1
        for <git@vger.kernel.org>; Sun, 14 May 2017 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XdpUMZzIzlKu9p1vxqwYm4ncDZY4WCNuimTXW2rBcpw=;
        b=BHFtjwpIgysFc+n7KFa3/3FDZf36ac3G5PNSwe5ZocCdvo7k9kSdEp3oK2Tt96ZBYh
         xkrIPODSqy5cbGLJx/6gS3aUKnxOOYQojmosJSX5ZM4kT78KBFKfmQSmd+KCuPVWLnqT
         xohuGprwIWRQBrfCE5NaAZvsELk46IQQdCq6z0aVO1EJwkeX/C0OOV+O7aDgbwGXpKfT
         FhiZ7EQLPa6sYTCJBuCUgl/6Ii+593zH0UJKV4NLc6/p5gvZFpy9bpDETpwYwP0p473c
         yp25DuAKMXRhZGSZSx8lj59SSv66vniUOR5C8f25Vr3ueI3LOEtmDx8Gt6WrHg2djOOB
         4dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XdpUMZzIzlKu9p1vxqwYm4ncDZY4WCNuimTXW2rBcpw=;
        b=OHD7Rvb5ZhXFUNiEM7fChbNd7O5lQ+gJMs8R8IyYIfT6XJm8FbOTPjfzV95G76E6vP
         q5vTgXK4ph7aJWnGS2ngCFxjzTsxkRUDe94kSviSwBAz0CU9AEXdTHSbYZaZlGitXZSI
         VZFG0mSdH95qniMMGV/sDtwE0FBw85JqNTYlljpeu1nevpNcR88baxIm+gZEh3oUpr8D
         rvPUtg0XrmhXtD0pjHbe7LT/6LMnf81Cx+ovYwY7FspsHtSsAJ53oSCAcJYkLrpg8gtu
         JOA7JC3TbR6Rpg0Z5PqjawCA2IuB8TRVIy+IORyaTS3MvnC9+oFhxpUfi9z+9tDWiX8Y
         7p5Q==
X-Gm-Message-State: AODbwcDxxZUF4xusesKA9a4KYlAVYgArDw+7xvkUMTa7sdMTbmb/BL4v
        9gYJQOCwPQZPtTbHCgGFH7PFRd3+kw==
X-Received: by 10.107.138.21 with SMTP id m21mr1602423iod.80.1494774639474;
 Sun, 14 May 2017 08:10:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sun, 14 May 2017 08:10:18 -0700 (PDT)
In-Reply-To: <20170514144315.w46t7iggp7yeqn4n@ruderich.org>
References: <20170513234535.12749-1-avarab@gmail.com> <20170513234535.12749-5-avarab@gmail.com>
 <20170514144315.w46t7iggp7yeqn4n@ruderich.org>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 14 May 2017 17:10:18 +0200
Message-ID: <CACBZZX5tL2YJyMgO9dnLzwe0SBPJhdOY4jpnJQBtfVRasS2Xow@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] grep: add support for the PCRE v1 JIT API
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 14, 2017 at 4:43 PM, Simon Ruderich <simon@ruderich.org> wrote:
> On Sat, May 13, 2017 at 11:45:32PM +0000, =C4=98var Arnfj=C3=B6r=C5=A1 Bj=
armason wrote:
>> [snip]
>>
>> +#ifdef PCRE_CONFIG_JIT
>> +     if (p->pcre1_jit_on)
>> +             ret =3D pcre_jit_exec(p->pcre1_regexp, p->pcre1_extra_info=
, line,
>> +                                 eol - line, 0, flags, ovector,
>> +                                 ARRAY_SIZE(ovector), p->pcre1_jit_stac=
k);
>> +     else
>> +             ret =3D pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, li=
ne,
>> +                             eol - line, 0, flags, ovector,
>> +                             ARRAY_SIZE(ovector));
>> +#else
>>       ret =3D pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, line, eol =
- line,
>>                       0, flags, ovector, ARRAY_SIZE(ovector));
>> +#endif
>
> Wouldn't it be simpler to remove the duplication and
> unconditionally use the old pcre_exec() call? Something like
> this:
>
>     +#ifdef PCRE_CONFIG_JIT
>     +   if (p->pcre1_jit_on)
>     +           ret =3D pcre_jit_exec(p->pcre1_regexp, p->pcre1_extra_inf=
o, line,
>     +                               eol - line, 0, flags, ovector,
>     +                               ARRAY_SIZE(ovector), p->pcre1_jit_sta=
ck);
>     +   else
>     +#endif
>         ret =3D pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, line, eol=
 - line,
>                         0, flags, ovector, ARRAY_SIZE(ovector));
>
>>       if (ret < 0 && ret !=3D PCRE_ERROR_NOMATCH)
>>               die("pcre_exec failed with error code %d", ret);
>>       if (ret > 0) {
>> @@ -394,7 +420,16 @@ static int pcre1match(struct grep_pat *p, const cha=
r *line, const char *eol,
>>  static void free_pcre1_regexp(struct grep_pat *p)
>>  {
>>       pcre_free(p->pcre1_regexp);
>> +#ifdef PCRE_CONFIG_JIT
>> +     if (p->pcre1_jit_on) {
>> +             pcre_free_study(p->pcre1_extra_info);
>> +             pcre_jit_stack_free(p->pcre1_jit_stack);
>> +     } else {
>> +             pcre_free(p->pcre1_extra_info);
>> +     }
>> +#else
>>       pcre_free(p->pcre1_extra_info);
>> +#endif
>
> Same here. The pcre_free() is the same with and without the
> ifdef.

Yes I could do that, no reason not to, and as you point out it would
reduce duplication.

I wrote it like this trying to preserve the indentation with/without
the macro being true, thinking someone would have an issue with it
otherwise.

I also thought just now that perhaps if it were changed the code like
that it would warn under -Wmisleading-indentation, but at least on gcc
that's not the case, it knows not to warn in the presence of macros.

Unless someone feel strongly otherwise / can think of a good reason
for why not, I'll change it as you suggest in the next version.

Thanks for the review!
