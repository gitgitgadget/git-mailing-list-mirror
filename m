Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B50812023D
	for <e@80x24.org>; Wed, 24 May 2017 07:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966710AbdEXHiO (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 03:38:14 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:33262 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757320AbdEXHiN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 03:38:13 -0400
Received: by mail-io0-f180.google.com with SMTP id p24so112397789ioi.0
        for <git@vger.kernel.org>; Wed, 24 May 2017 00:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xpwgcvhsA0sem/XSKvSxsXuqAjsXUxLDsoMyPzjdEkk=;
        b=cExR9c6j+7Rv/wMGxpKJe0i+IhgZH61qNEUw5/oM+iBCw+lM+GmlubgpyYwUrY83EO
         qJ/DRQ88Qdv/BVvhytDL9Ow4JvY6yUHyOeti5Pr8JxPPj55qFmAy9hSvCB0GGxdq3LhN
         mbdGokijglV5Ne4X4+wAuzShNUwYttiFJEF3ImpjbvUosHlbbQqp8UCoGa6eHHugSPw+
         O09B1XnU1nDAPC5uOBDTfZLvToR14FS1VZvcdlb2S8yMcfxv2Oi7ngVASrPnr/8Zxrf4
         HRN5FHRgYqQrcCDdHPQdSlpn85vQK8hQ0rIkD+cbXf8kQKcvnPpu4luuxYsPm664RFlt
         36CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xpwgcvhsA0sem/XSKvSxsXuqAjsXUxLDsoMyPzjdEkk=;
        b=UWhVH5HWN+KerJvMFanGYdhEPpYIia5DBVt+PdEF0/u8UB0lSGJdnVpcGynFCkv0nr
         +CQB099wD/HiiKNw9dJg7Rfs0RvFDFyvaG5GZuv/iWCxaZqYBz1Bomg3iRwartod0oMn
         TaPj4yGa3vGvmZBNtLeBE9h8o8SJnfeEGrcDH+XrkSJybZoj4gGEPqmiEJ2CEAlctp3Z
         nWN8aZocgHoHOFLZczE23jDAJyBnyp0eMLvJjujdWk4TAlBfjXVBh5gDzvIieVXAZkRf
         nAO9JKdl1VSp2i/TerCus6CUSaAduuyd3IqFs20jJqP5/Y4Jgo3znx6ul3l3keFZ/7Nj
         DFRg==
X-Gm-Message-State: AODbwcCxVLZCngRo01BwmleuQRZJ/ra6IG0cszGe3Dg8G0FiHj3P2yIk
        5unbR47A605IaOJK4DogXlcH1SOQ6VdMkSc=
X-Received: by 10.107.138.21 with SMTP id m21mr30522601iod.80.1495611492610;
 Wed, 24 May 2017 00:38:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Wed, 24 May 2017 00:37:51 -0700 (PDT)
In-Reply-To: <xmqqlgpmhm08.fsf@gitster.mtv.corp.google.com>
References: <20170523192453.14172-1-avarab@gmail.com> <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
 <20170523192453.14172-5-avarab@gmail.com> <xmqqlgpmhm08.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 24 May 2017 09:37:51 +0200
Message-ID: <CACBZZX5MPXR7Z6oSPN+UjQxZhXpe8O3XVcuC8gAGjAbofJ4YDw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] grep: add support for the PCRE v1 JIT API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Simon Ruderich <simon@ruderich.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2017 at 7:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> diff --git a/grep.c b/grep.c
>> index 1157529115..49e9aed457 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -351,6 +351,9 @@ static void compile_pcre1_regexp(struct grep_pat *p,=
 const struct grep_opt *opt)
>>       const char *error;
>>       int erroffset;
>>       int options =3D PCRE_MULTILINE;
>> +#ifdef PCRE_CONFIG_JIT
>> +     int canjit;
>> +#endif
>
> Is "canjit" a property purely of the library (e.g. version and
> compilation option), or of combination of that and nature of the
> pattern, or something else like the memory pressure?
>
> I am wondering if it is worth doing something like this:
>
>         static int canjit =3D -1;
>         if (canjit < 0) {
>                 pcre_config(PCRE_CONFIG_JIT, &canjit);
>         }
>
> if it depends purely on the library linked to the process.

It purely depends on how the the library, was compiled. I just wrote
it like that because compiling the pattern is not a hot codepath (i.e.
we call this max 8 or so times or so, whereas exec will be called
thousands/millions/billions of times), so trying to avoid calling this
trivial function seemed pointless.

But looking at this again it would be simpler to combine what you're
suggesting with just passing a pointer to *.pcre[12]_jit_on directly,
skipping the canjit variables.

>> @@ -365,9 +368,20 @@ static void compile_pcre1_regexp(struct grep_pat *p=
, const struct grep_opt *opt)
>>       if (!p->pcre1_regexp)
>>               compile_regexp_failed(p, error);
>>
>> -     p->pcre1_extra_info =3D pcre_study(p->pcre1_regexp, 0, &error);
>> +     p->pcre1_extra_info =3D pcre_study(p->pcre1_regexp, PCRE_STUDY_JIT=
_COMPILE, &error);
>>       if (!p->pcre1_extra_info && error)
>>               die("%s", error);
>> +
>> +#ifdef PCRE_CONFIG_JIT
>> +     pcre_config(PCRE_CONFIG_JIT, &canjit);
>> +     if (canjit =3D=3D 1) {
>> +             p->pcre1_jit_stack =3D pcre_jit_stack_alloc(1, 1024 * 1024=
);
>> +             if (!p->pcre1_jit_stack)
>> +                     die("BUG: Couldn't allocate PCRE JIT stack");
>
> I agree that dying is OK, but as far as I can tell, this is not a
> BUG (there is no error a programmer can correct by a follow-up
> patch); please do not mark it as such (it is likely that we'll later
> do a tree-wide s/die("BUG:/BUG("/ and this will interfere).

Makes sense. Looks like the convention for this sort of thing is to
just do s/BUG: //, e.g. the code in wrapper.c does that.

>> +             pcre_assign_jit_stack(p->pcre1_extra_info, NULL, p->pcre1_=
jit_stack);
>> +             p->pcre1_jit_on =3D 1;
>
> Contrary to what I wondered about "canjit" above, I think it makes
> tons of sense to contain the "is JIT in use?" information in "struct
> grep_pat" and not rely on any global state.  Not that we are likely
> to want to be able to JIT some patterns while not doing others.  So
> I agree with the design choice of adding pcre1_jit_on field to the
> structure.
>
> But then, wouldn't it make more sense to do all of the above without
> the canjit variable at all?  i.e. something like...
>
>         #ifdef PCRE_CONFIG_JIT
>                 pcre_config(PCRE_CONFIG_JIT, &p->pcre1_jit_on);
>                 if (p->pcre1_jit_on)
>                         ... stack thing ...
>         #else
>                 p->pcre1_jit_on =3D 0;
>         #endif

*Nod*

>> +#ifdef PCRE_CONFIG_JIT
>> +     if (p->pcre1_jit_on) {
>> +             pcre_free_study(p->pcre1_extra_info);
>> +             pcre_jit_stack_free(p->pcre1_jit_stack);
>> +     } else
>> +#endif
>> +     /* PCRE_CONFIG_JIT !p->pcre1_jit_on else branch */
>>       pcre_free(p->pcre1_extra_info);
>> +
>>       pcre_free((void *)p->pcre1_tables);
>
> It is very thoughtful to add a blank line here (and you did the same
> in another similar hunk), but I have a feeling that it is still a
> bit too subtle a hint to signal to the readers that these two
> pcre_free()s fire differently, i.e. the former does not fire if jit
> is on but the latter always fires.
>
> Would this be a bit safer while being not too ugly to live, I wonder?
>
>         #ifdef PCRE_CONFIG_JIT
>                 if (p->pcre1_jit_on) {
>                         pcre_free_study(p->pcre1_extra_info);
>                         pcre_jit_stack_free(p->pcre1_jit_stack);
>                 } else
>         #endif
>                 {
>                         /* PCRE_CONFIG_JIT !p->pcre1_jit_on else branch *=
/
>                         pcre_free(p->pcre1_extra_info);
>                 }
>                 pcre_free((void *)p->pcre1_tables);
>

Makes sense. I'll change it.
