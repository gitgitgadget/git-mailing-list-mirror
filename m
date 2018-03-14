Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17BFB1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 13:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeCNNgg (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 09:36:36 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51899 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbeCNNgf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 09:36:35 -0400
Received: by mail-wm0-f68.google.com with SMTP id h21so4111028wmd.1
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 06:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D1odQwNKr6xgmWNIZyK38DhiKe/szA6N9Ikc6FewPog=;
        b=BAsD1UhjuKeniZEgIgxbdcHNRECLKSGTSaCoDjyjYXTMd/EhBHUHOsz5QwQdB8f52L
         oTg0i0qF0eGSEZcHvumgJ1IYa7QNPkv8eMHxCwn5ZWYKL2ZQLuuJQjR02H7RdUb5ndP8
         39DxKaiHYiGIrGbR62jlBjQMkzwPmvZpNzdOAvEza0VGD5MKuXsuaBREJjeAPHvQq+Ej
         zTgBTSfBo6POHEYIYOTRTFdFzDf8erjxA2q9v1PGETjDrx7mDgEBcbLHsWcv123L+Fl/
         hGfhFH46gWJ1bv+WiOmgyg/fM3amJtUP0GIlX+YIBQdVtZm5b1OqguwPupabpeo2yeuS
         vhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D1odQwNKr6xgmWNIZyK38DhiKe/szA6N9Ikc6FewPog=;
        b=Njx6Siqrl5n/AIxsgSIBQslQyUa+5AdiraaS6QPFwm9lv5HuZU/I2BRc0ac9ENaj0H
         D2wY2gTcF1/wzqGZZXRK3JGkVIP48jMmnhg0fN/pLHpQC2YtZm8CMt1GRLZVNH8NTsdm
         RXs6wacwMiVd+BHcUdozOs3HDzwSl/CKZNX6eSDT8i2KCj3p/6HvgxWjlWpsDTtskU8Q
         qoMDHxUSazlNaHdGfjAxtpkm9zZR8Tc64CEwqbMyHUu+0hI2UBHgJxTntKsGgpoIH0WF
         /+08nF8ASiUY0nyi5KsCEGe4R0aBumhJKTlRXAhkw4GGz1Tz2d4rBH9Bt75no1NkmWEw
         y9uw==
X-Gm-Message-State: AElRT7FE/RI6Ih4BrPIN9CGvE0XXDrJzB6H8cy5YAlCHrR3BPK0bXR5F
        QvNvMorv94Xd7sILYzC7qen5nVbo0cIoWXUtuzU=
X-Google-Smtp-Source: AG47ELuDFTszXzeRckbde+nlD6ONUOE4yLoIMPx7tWQpzpGrOem/FlHXl7sjkq6gP692RIsLTP2y2AdBmpk/rrk7HvE=
X-Received: by 10.28.58.199 with SMTP id h190mr1725861wma.119.1521034593892;
 Wed, 14 Mar 2018 06:36:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.197.147 with HTTP; Wed, 14 Mar 2018 06:36:33 -0700 (PDT)
In-Reply-To: <CAN0heSrogCMT-8R4nht=_9syMNUfJe21BvZSVD4AUcf9PwN7rQ@mail.gmail.com>
References: <010201621edc97a4-a4239b1e-86d2-4400-aaac-d81727710f4f-000000@eu-west-1.amazonses.com>
 <010201621edc982f-92123a33-386b-4b94-be0c-f793856e6c16-000000@eu-west-1.amazonses.com>
 <CAN0heSrogCMT-8R4nht=_9syMNUfJe21BvZSVD4AUcf9PwN7rQ@mail.gmail.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Wed, 14 Mar 2018 16:36:33 +0300
Message-ID: <CAL21BmkPrgUtiuV=AMqnOwPX-aXdWU39CFLwGCAmMLvXBdLXWA@mail.gmail.com>
Subject: Re: [RFC 3/4] ref-filter: change parsing function error handling
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-03-13 22:18 GMT+03:00 Martin =C3=85gren <martin.agren@gmail.com>:
> On 13 March 2018 at 11:16, Olga Telezhnaya <olyatelezhnaya@gmail.com> wro=
te:
>> Continue removing any printing from ref-filter formatting logic,
>> so that it could be more general.
>>
>> Change the signature of parse_ref_filter_atom() by changing return value=
,
>> adding previous return value to function parameter and also adding
>> strbuf parameter for error message.
>
> I think the current return value is always non-negative. Maybe it would
> be easier to leave the return value as-is, except return negative on
> error? Unless I am missing something?

That's interesting. I like your idea, but let's see what other people think=
.
If others agree with us, I am ready to implement your solution.

>
>>
>> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
>> ---
>>  ref-filter.c | 45 ++++++++++++++++++++++++++++++++-------------
>>  1 file changed, 32 insertions(+), 13 deletions(-)
>>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 07bedc636398c..e146215bf1e64 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -397,7 +397,8 @@ struct atom_value {
>>   * Used to parse format string and sort specifiers
>>   */
>>  static int parse_ref_filter_atom(const struct ref_format *format,
>> -                                const char *atom, const char *ep)
>> +                                const char *atom, const char *ep, int *=
res,
>> +                                struct strbuf *err)
>>  {
>>         const char *sp;
>>         const char *arg;
>> @@ -406,14 +407,18 @@ static int parse_ref_filter_atom(const struct ref_=
format *format,
>>         sp =3D atom;
>>         if (*sp =3D=3D '*' && sp < ep)
>>                 sp++; /* deref */
>> -       if (ep <=3D sp)
>> -               die(_("malformed field name: %.*s"), (int)(ep-atom), ato=
m);
>> +       if (ep <=3D sp) {
>> +               strbuf_addf(err, _("malformed field name: %.*s"), (int)(=
ep-atom), atom);
>> +               return -1;
>> +       }
>>
>>         /* Do we have the atom already used elsewhere? */
>>         for (i =3D 0; i < used_atom_cnt; i++) {
>>                 int len =3D strlen(used_atom[i].name);
>> -               if (len =3D=3D ep - atom && !memcmp(used_atom[i].name, a=
tom, len))
>> -                       return i;
>> +               if (len =3D=3D ep - atom && !memcmp(used_atom[i].name, a=
tom, len)) {
>> +                       *res =3D i;
>> +                       return 0;
>> +               }
>>         }
>
> If you did so, this hunk above would not need to be changed ...
>
>> @@ -458,7 +465,8 @@ static int parse_ref_filter_atom(const struct ref_fo=
rmat *format,
>>                 need_tagged =3D 1;
>>         if (!strcmp(valid_atom[i].name, "symref"))
>>                 need_symref =3D 1;
>> -       return at;
>> +       *res =3D at;
>> +       return 0;
>>  }
>
> ... nor this one above ...
>
>>                 if (!ep)
>>                         return error(_("malformed format string %s"), sp=
);
>>                 /* sp points at "%(" and ep points at the closing ")" */
>> -               at =3D parse_ref_filter_atom(format, sp + 2, ep);
>> +               if (parse_ref_filter_atom(format, sp + 2, ep, &at, &err)=
)
>> +                       die("%s", err.buf);
>
> And this would be more like "if (at < 0) die(...)".
>
>>         for (cp =3D format->format; *cp && (sp =3D find_next(cp)); cp =
=3D ep + 1) {
>>                 struct atom_value *atomv;
>> +               struct strbuf err =3D STRBUF_INIT;
>> +               int pos;
>>
>>                 ep =3D strchr(sp, ')');
>>                 if (cp < sp)
>>                         append_literal(cp, sp, &state);
>> -               get_ref_atom_value(info,
>> -                                  parse_ref_filter_atom(format, sp + 2,=
 ep),
>> -                                  &atomv);
>> +               if (parse_ref_filter_atom(format, sp + 2, ep, &pos, &err=
))
>> +                       return -1;
>> +               get_ref_atom_value(info, pos, &atomv);
>>                 if (atomv->handler(atomv, &state, error_buf))
>>                         return -1;
>> +               strbuf_release(&err);
>
> This looks leaky: if we get an error, we've got something in the buffer
> but we do not release it because we return early. Stepping back a bit, I
> wonder why we do not do anything at all with "err". Stepping back a bit
> more :-) I wonder if you could get rid of "err" and pass "error_buf" to
> parse_ref_filter_atom() instead. Our caller would like to have access to
> the error string?

Fully agree, I don't know why I decided to create one more buffer. Fixed.

>
> This ties back to my comment on the first patch -- "return negative if
> and only if you add some error string to the buffer" might be a useful
> rule?
>
> Martin
