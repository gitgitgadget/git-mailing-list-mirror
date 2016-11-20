Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E0C11FE4E
	for <e@80x24.org>; Sun, 20 Nov 2016 07:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbcKTHXt (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Nov 2016 02:23:49 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35217 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750728AbcKTHXs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2016 02:23:48 -0500
Received: by mail-yw0-f194.google.com with SMTP id b66so24078248ywh.2
        for <git@vger.kernel.org>; Sat, 19 Nov 2016 23:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZB/7FeslEwREVPYMIRLKOeq+Ke7vYT4bSVevO6TND+M=;
        b=E5+GlVqhFzfUuX1wv8Nm2RsknYn20EkFFysCDvYRThxtKc9QnZ0B+LR/f1qih3Ixwy
         UN4FpDKCs4UIbLBc2WycxwyKGvBYiYeGjvLd3BpJqtnj5k6+OR0ydxjdtGmJmrsaNhyX
         QMb8M7GWGdkftZ+3lVIGkY6nknbbnKqkVLdNL0y2QCwTz2+8wc54dxhDGLuqtNHtpE06
         wDVtQFT/VRD7k07qUo/eZmGOXb5gIMdE/5LieRmVLGEdYCTRgyHXBQbsinYHiDC/cwa4
         4YHpD4O3hZ3bHpxF1jnvP+Gkloj0Xnlt+GqDr/Irx6BWXeLzfmjtWICFPx6/kvYCqHIO
         DTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZB/7FeslEwREVPYMIRLKOeq+Ke7vYT4bSVevO6TND+M=;
        b=boTwpqf7OqvscKpENLehZ5KUoKtoafqWIn2Nr8WAJN2pr0WLPRF4x3vHAaRthUhaJo
         Ajw2yAegmSMaZCQ16XnCyowNyvG6LLAdxGR5IlUE06sAOgn3ADBQ/bQBDGgwe0XZRl9W
         k0SBsuc0GRjo+Av4oRTD1RQqmaHV+oL3Kjd2Klm7/QlWnd3fV+U0IDy0dmX5Q5TCtkq+
         noarN2WORHljHlYT/7EG1/IlQk+IfPpeim5smfM9zRC7EOD+FMnrQjBdDXnPYiusyVDt
         56e38CbTwCmfW6AM1Rxsi3cVNlmtD8DYraNuiCphGLjH7r8vAqgCWwGwFncGBJWenAJ2
         6uzw==
X-Gm-Message-State: AKaTC00S2tql+nsxjyUeGQnSGv+e3rfi008I7FnYp4ZJCbswf9ui3dSf/fB28Wsb8Z7r1YRPAWnhb/3HY71eyw==
X-Received: by 10.13.229.70 with SMTP id o67mr7418748ywe.131.1479626627966;
 Sat, 19 Nov 2016 23:23:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Sat, 19 Nov 2016 23:23:17 -0800 (PST)
In-Reply-To: <37c2cbf2-7160-49d7-f8f1-3b65d9ecf9ec@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-4-Karthik.188@gmail.com>
 <37c2cbf2-7160-49d7-f8f1-3b65d9ecf9ec@gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sun, 20 Nov 2016 12:53:17 +0530
Message-ID: <CAOLa=ZQ1wPhd=aXck5e+Zd0020CbEwaohVX4eOGjy50BTqsTpA@mail.gmail.com>
Subject: Re: [PATCH v7 03/17] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 19, 2016 at 1:28 AM, Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:
> W dniu 08.11.2016 o 21:11, Karthik Nayak pisze:
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> Implement %(if:equals=3D<string>) wherein the if condition is only
>> satisfied if the value obtained between the %(if:...) and %(then) atom
>> is the same as the given '<string>'.
>>
>> Similarly, implement (if:notequals=3D<string>) wherein the if condition
>> is only satisfied if the value obtained between the %(if:...) and
>> %(then) atom is differnt from the given '<string>'.
>                   ^^^^^^^^
>
> s/differnt/different/   <-- typo
>

Will change that.

>>
>> Add tests and Documentation for the same.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  Documentation/git-for-each-ref.txt |  3 +++
>>  ref-filter.c                       | 43 +++++++++++++++++++++++++++++++=
++-----
>>  t/t6302-for-each-ref-filter.sh     | 18 ++++++++++++++++
>>  3 files changed, 59 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-=
each-ref.txt
>> index fed8126..b7b8560 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -155,6 +155,9 @@ if::
>>       evaluating the string before %(then), this is useful when we
>>       use the %(HEAD) atom which prints either "*" or " " and we
>>       want to apply the 'if' condition only on the 'HEAD' ref.
>
> So %(if) is actually %(if:notempty) ?  Just kidding.
>

It's not a bug, it's a feature ;)

>> +     Append ":equals=3D<string>" or ":notequals=3D<string>" to compare
>> +     the value between the %(if:...) and %(then) atoms with the
>> +     given string.
>>
>>  In addition to the above, for commit and tag objects, the header
>>  field names (`tree`, `parent`, `object`, `type`, and `tag`) can
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 8392303..44481c3 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -22,6 +22,8 @@ struct align {
>>  };
>>
>>  struct if_then_else {
>> +     const char *if_equals,
>> +             *not_equals;
>
> I guess using anonymous structs from C11 here...
>
>>       unsigned int then_atom_seen : 1,
>>               else_atom_seen : 1,
>>               condition_satisfied : 1;
>> @@ -49,6 +51,10 @@ static struct used_atom {
>>                       enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG,=
 C_SUB } option;
>>                       unsigned int nlines;
>>               } contents;
>> +             struct {
>> +                     const char *if_equals,
>> +                             *not_equals;
>> +             } if_then_else;
>
> ...to avoid code duplication there is rather out of question?
>

I believe it holds better context without the use of anonymous structs/unio=
ns.
But that's my perspective, I wouldn't mind changing it.

>>               enum { O_FULL, O_SHORT } objectname;
>>       } u;
>>  } *used_atom;
>> @@ -169,6 +175,19 @@ static void align_atom_parser(struct used_atom *ato=
m, const char *arg)
>>       string_list_clear(&params, 0);
>>  }
>>
>> +static void if_atom_parser(struct used_atom *atom, const char *arg)
>> +{
>> +     if (!arg)
>> +             return;
>> +     else if (skip_prefix(arg, "equals=3D", &atom->u.if_then_else.if_eq=
uals))
>> +              ;
>> +     else if (skip_prefix(arg, "notequals=3D", &atom->u.if_then_else.no=
t_equals))
>> +             ;
>
> Those ';' should be perfectly aligned, isn't it?
>

This should be dropped with the new changes made on this patch.

--=20
Regards,
Karthik Nayak
