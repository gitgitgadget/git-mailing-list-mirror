Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA036201A4
	for <e@80x24.org>; Sun, 14 May 2017 15:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759084AbdENPXj (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 11:23:39 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:36475 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758989AbdENPXi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 11:23:38 -0400
Received: by mail-io0-f179.google.com with SMTP id o12so61576445iod.3
        for <git@vger.kernel.org>; Sun, 14 May 2017 08:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tYGdRV+66GjxL+ga/dk1TtfaNCvyy1cSjysPWuIeRig=;
        b=NgSIBYSG5kUFYu7awrIVoMnrLFDlDdhDtsNOpbz8WJVts+K7JZVLympRLqJZln4Gek
         xeqtsBDdy4ShHKkmfqw5Iyf/Lboun8pPhLP49DqnHTbA7ad9XA8IbufKFjZaN0QCaUzY
         9MFoy0rEwXBFecZPVrgCqnc+8fU5Xh5tGnzyDN/9FLZgZ4WijStUjUUmJctklwzquBBX
         nhMtUM2bRUxTFSJvmF/Q00dSjRVN3bbH0T1KpeciLAqxQMHZ9yV3+X4IrdrKsgW6zfZ8
         r4ccu6rEyViFiy6lEAfiYWh/9d/YV8XZf0slXW4eQ28BYVbdaeYtbGWoRcOLTPeC45AN
         /z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tYGdRV+66GjxL+ga/dk1TtfaNCvyy1cSjysPWuIeRig=;
        b=sB7aW+/D42y227MglnXuxSB8ayZmWWdd5yAjowm/RG6KdoSipWhuL/Sbqg5kr3QPgT
         FPh1zusWx380qw7x7GJzxoIXDHnPeStOuuMMWZQIxxtkIYhkg3k+jgK6S8Epm1HXdb6N
         EXJCe2ArU7BxDenryeWCF+2a71NJNBXz8iYLwkmKQ4/w8teBIq8Q+ntn/UcWQGvKrqwT
         obJ7d/4EaJ4fOvxylII2amLhB+ZcAeIpjzIKKcZg6GntWF1niK6BkhgMv+DEPGSR7Top
         6Apltntmf+BSN2Z8bKaUjCNX/yWoJfZhggYwcDe3Szf7u4QtqTYSpMpSqkKW2CVachzL
         kjHw==
X-Gm-Message-State: AODbwcBX3LsciSlRusdMruD2Myhi0O78C8XQhMJ/Die9JwDPI1T1BCfD
        Eb9z/jRQANt2kw0MtCMY8/mjlOuxbg==
X-Received: by 10.107.178.12 with SMTP id b12mr1611163iof.50.1494775418014;
 Sun, 14 May 2017 08:23:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sun, 14 May 2017 08:23:17 -0700 (PDT)
In-Reply-To: <CACBZZX5tL2YJyMgO9dnLzwe0SBPJhdOY4jpnJQBtfVRasS2Xow@mail.gmail.com>
References: <20170513234535.12749-1-avarab@gmail.com> <20170513234535.12749-5-avarab@gmail.com>
 <20170514144315.w46t7iggp7yeqn4n@ruderich.org> <CACBZZX5tL2YJyMgO9dnLzwe0SBPJhdOY4jpnJQBtfVRasS2Xow@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 14 May 2017 17:23:17 +0200
Message-ID: <CACBZZX4OFermQ3jEQOgozP-H+uZauJj6GEdwKZjqs8CF8xHEDQ@mail.gmail.com>
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

On Sun, May 14, 2017 at 5:10 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Sun, May 14, 2017 at 4:43 PM, Simon Ruderich <simon@ruderich.org> wrot=
e:
>> On Sat, May 13, 2017 at 11:45:32PM +0000, =C4=98var Arnfj=C3=B6r=C5=A1 B=
jarmason wrote:
>>> [snip]
>>>
>>> +#ifdef PCRE_CONFIG_JIT
>>> +     if (p->pcre1_jit_on)
>>> +             ret =3D pcre_jit_exec(p->pcre1_regexp, p->pcre1_extra_inf=
o, line,
>>> +                                 eol - line, 0, flags, ovector,
>>> +                                 ARRAY_SIZE(ovector), p->pcre1_jit_sta=
ck);
>>> +     else
>>> +             ret =3D pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, l=
ine,
>>> +                             eol - line, 0, flags, ovector,
>>> +                             ARRAY_SIZE(ovector));
>>> +#else
>>>       ret =3D pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, line, eol=
 - line,
>>>                       0, flags, ovector, ARRAY_SIZE(ovector));
>>> +#endif
>>
>> Wouldn't it be simpler to remove the duplication and
>> unconditionally use the old pcre_exec() call? Something like
>> this:
>>
>>     +#ifdef PCRE_CONFIG_JIT
>>     +   if (p->pcre1_jit_on)
>>     +           ret =3D pcre_jit_exec(p->pcre1_regexp, p->pcre1_extra_in=
fo, line,
>>     +                               eol - line, 0, flags, ovector,
>>     +                               ARRAY_SIZE(ovector), p->pcre1_jit_st=
ack);
>>     +   else
>>     +#endif
>>         ret =3D pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, line, eo=
l - line,
>>                         0, flags, ovector, ARRAY_SIZE(ovector));
>>
>>>       if (ret < 0 && ret !=3D PCRE_ERROR_NOMATCH)
>>>               die("pcre_exec failed with error code %d", ret);
>>>       if (ret > 0) {
>>> @@ -394,7 +420,16 @@ static int pcre1match(struct grep_pat *p, const ch=
ar *line, const char *eol,
>>>  static void free_pcre1_regexp(struct grep_pat *p)
>>>  {
>>>       pcre_free(p->pcre1_regexp);
>>> +#ifdef PCRE_CONFIG_JIT
>>> +     if (p->pcre1_jit_on) {
>>> +             pcre_free_study(p->pcre1_extra_info);
>>> +             pcre_jit_stack_free(p->pcre1_jit_stack);
>>> +     } else {
>>> +             pcre_free(p->pcre1_extra_info);
>>> +     }
>>> +#else
>>>       pcre_free(p->pcre1_extra_info);
>>> +#endif
>>
>> Same here. The pcre_free() is the same with and without the
>> ifdef.
>
> Yes I could do that, no reason not to, and as you point out it would
> reduce duplication.
>
> I wrote it like this trying to preserve the indentation with/without
> the macro being true, thinking someone would have an issue with it
> otherwise.
>
> I also thought just now that perhaps if it were changed the code like
> that it would warn under -Wmisleading-indentation, but at least on gcc
> that's not the case, it knows not to warn in the presence of macros.
>
> Unless someone feel strongly otherwise / can think of a good reason
> for why not, I'll change it as you suggest in the next version.
>
> Thanks for the review!

...and if I do change it do others think this is something that
warrants a comment & some whitespace padding? I.e.:

@@ -378,8 +392,17 @@ static int pcre1match(struct grep_pat *p, const
char *line, const char *eol,
        if (eflags & REG_NOTBOL)
                flags |=3D PCRE_NOTBOL;

+#ifdef PCRE_CONFIG_JIT
+       if (p->pcre1_jit_on)
+               ret =3D pcre_jit_exec(p->pcre1_regexp, p->pcre1_extra_info,=
 line,
+                                   eol - line, 0, flags, ovector,
+                                   ARRAY_SIZE(ovector), p->pcre1_jit_stack=
);
+       else
+#endif
+       /* PCRE_CONFIG_JIT !p->pcre1_jit_on else branch */
        ret =3D pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, line, eol -=
 line,
                        0, flags, ovector, ARRAY_SIZE(ovector));
+
        if (ret < 0 && ret !=3D PCRE_ERROR_NOMATCH)
                die("pcre_exec failed with error code %d", ret);
        if (ret > 0) {

and:

@@ -394,7 +417,16 @@ static int pcre1match(struct grep_pat *p, const
char *line, const char *eol,
 static void free_pcre1_regexp(struct grep_pat *p)
 {
        pcre_free(p->pcre1_regexp);
+
+#ifdef PCRE_CONFIG_JIT
+       if (p->pcre1_jit_on) {
+               pcre_free_study(p->pcre1_extra_info);
+               pcre_jit_stack_free(p->pcre1_jit_stack);
+       } else
+#endif
+       /* PCRE_CONFIG_JIT !p->pcre1_jit_on else branch */
        pcre_free(p->pcre1_extra_info);
+
        pcre_free((void *)p->pcre1_tables);
 }
 #else /* !USE_LIBPCRE1 */
