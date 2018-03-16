Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63B171F42D
	for <e@80x24.org>; Fri, 16 Mar 2018 07:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbeCPHUF (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 03:20:05 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38391 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753160AbeCPHUD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 03:20:03 -0400
Received: by mail-wm0-f43.google.com with SMTP id z9so1164334wmb.3
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 00:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e7/xTIw1CFPkD67fT55gdMKy0h9MWcfEw3N7Ai1ms8I=;
        b=WWqKqaxIimjRnfE4QOLbk8FumZOM5ZXVqC38dqbaYVcsDTKTdAlBtzIlXbC4/XtHki
         lSFO+NrhNCfT4QVl+ceTsevWeua3lUwBFvq6lyYKDwybeb10TYGBvf273ADT61jtjLKl
         gql2KUmHhAAK3/kh3iS4Mhlb3bqYxJc+Q/KNiopkiLRTvJfd7I+2P7mGO787e1PtAeXl
         FmuXTBranumvG33amWF398+h8KayDGts/fpT9VblhAfuQw/sKTBajilmPs4kY0uqklL9
         dcbLCZWBKaeI6vi85iANveM1s0+zAfbnI4zADIZP5eMIWMu2QxrY6nL4eZHtrteXxntb
         F4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e7/xTIw1CFPkD67fT55gdMKy0h9MWcfEw3N7Ai1ms8I=;
        b=siLVplmdMHvdjRVClOxpGec4MlfcN/U9bi5sJvoWrxmwIGua8+SYOnD04KK40SMKlN
         P4Vw7BLFrOcrVw+T3EOsyMF7xtk7OnD6dL5c2r7d2jHirxPGiyiLB0ST8rqSRfYOsh48
         DUoyEvV9oQZvLGUQW62mOqSawN4PDAlO66p7I8s18QfHSM0qPPOHfFKVwJly/Qh0+RFh
         sDD/5zscuW217/lfIZNrt6Eth+rD9OCCoDLiyZY/B/rYJsZBnAV9xuOZRA9RRQAKUSex
         OU8z3rqVNCWH5PBcf9teKWDXwmeF1b3/a3MfmODLhLA85qp1x4mpoJZ0cB8whv/3vhik
         kkhQ==
X-Gm-Message-State: AElRT7EOSAuy451ULIECwDahXXLOnbkYCCWyQqWjiIidID6hexfnCkXn
        NGx/DxN5tYYcw0TuaL6+ipZXFd0qeqDOmjAwtBM=
X-Google-Smtp-Source: AG47ELveTYT9sCbDM8yq04rgB2cV4mlelUMDjB9vWMkfkry/fQUe3GySjfNshb4VQRuRVqsJA5ymgJNzSooiYv222w8=
X-Received: by 10.28.93.78 with SMTP id r75mr744032wmb.110.1521184802047; Fri,
 16 Mar 2018 00:20:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.197.147 with HTTP; Fri, 16 Mar 2018 00:20:01 -0700 (PDT)
In-Reply-To: <CAPig+cRbsDTTfbeQS5tXCCoDKvf2pXAe_suGs-yHY_qj=Go_1A@mail.gmail.com>
References: <0102016225e61cc2-0d0c05ef-b999-4bf2-88ac-db9840dd2a87-000000@eu-west-1.amazonses.com>
 <20180315204709.1900787-1-martin.agren@gmail.com> <CAPig+cRbsDTTfbeQS5tXCCoDKvf2pXAe_suGs-yHY_qj=Go_1A@mail.gmail.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Fri, 16 Mar 2018 10:20:01 +0300
Message-ID: <CAL21BmmXz7wsq9kPzbvjo3b5ZEvmZA5qi-XqoXf6X8rRwOg_aQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ref-filter: get_ref_atom_value() error handling
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-03-16 0:01 GMT+03:00 Eric Sunshine <sunshine@sunshineco.com>:
> On Thu, Mar 15, 2018 at 4:47 PM, Martin =C3=85gren <martin.agren@gmail.co=
m> wrote:
>> These are "real" errors and yield several more changes in the remainder.
>> Ignoring those BUG-type messages at the beginning of this patch would
>> give a patch like the one below.
>>
>> +static int get_object(struct ref_array_item *ref, const struct object_i=
d *oid,
>> +                      int deref, struct object **obj, struct strbuf *er=
r)
>>  {
>>         void *buf =3D get_obj(oid, obj, &size, &eaten);
>> -       if (!buf)
>> -               die(_("missing object %s for %s"),
>> -                   oid_to_hex(oid), ref->refname);
>> -       if (!*obj)
>> -               die(_("parse_object_buffer failed on %s for %s"),
>> -                   oid_to_hex(oid), ref->refname);
>> -
>> +       if (!buf) {
>> +               strbuf_addf(err, _("missing object %s for %s"), oid_to_h=
ex(oid),
>> +                           ref->refname);
>> +               return -1;
>> +       }
>> +       if (!*obj) {
>> +               strbuf_addf(err, _("parse_object_buffer failed on %s for=
 %s"),
>> +                           oid_to_hex(oid), ref->refname);
>> +               return -1;
>
> Doesn't this leak 'buf'?

Yes. Thanks a lot.
>
>> +       }
>>         grab_values(ref->value, deref, *obj, buf, size);
>>         if (!eaten)
>>                 free(buf);
>> +       return 0;
>>  }
