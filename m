Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB4AB1FE4E
	for <e@80x24.org>; Sun, 20 Nov 2016 07:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbcKTHer (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Nov 2016 02:34:47 -0500
Received: from mail-yw0-f177.google.com ([209.85.161.177]:36257 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbcKTHeq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2016 02:34:46 -0500
Received: by mail-yw0-f177.google.com with SMTP id a10so191131405ywa.3
        for <git@vger.kernel.org>; Sat, 19 Nov 2016 23:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bnoPqXW3ihbwucXICbmqV3M5JqMzrips0fy+eTTyZbo=;
        b=BfLjPQe3l32OVfFFXXF0x+WnkabHc05/TmUs2wW+uWsUAQAXSADJ/W442sPf2vPX8m
         WRGWzIO+3prsASXJPIrFiLxV3V2QRlhEC/WdDKKLFkftjTD8tqAiggDTmSqxyeEjNeGG
         LsNbf+OyQc2HY1tNr6835uzpg5stAXZMZH7Q86V62nokz2HhTON6OPTqEEuMFOd6aZAS
         ciYi6I33vLPHzzrQyucetnWYF0WcAqPWd9iYtD32FBn5igrnWmrgFDP0aeAjucxprbkB
         HIv+XlJr58nNAnmrkW2lD7tZhw4yQNxGBX3FTgsIj9u+Qe9HFsa5I5qbnu1NaqzPjJ0v
         bNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bnoPqXW3ihbwucXICbmqV3M5JqMzrips0fy+eTTyZbo=;
        b=hqJysOhAObEXxhXIuOSWvuKupq9Th0gCscmHAhpdbgj7if592e7FDhftpe8NCJJj+V
         PiLDHI2eXp++FiscjcHaTJeti90ACqbqlXQzig1jbgNokKcboY29eHDhDQzM+ye2zIDH
         s0WJ/2IU1V9Mklw/HvXLjSA5Ev5BYPGeHyUJ40ER6jlFjptVw/8K3UI2yPzi6zOjkCNo
         H5jX5gIONddI/CllB05pFZhCxSkb9PgK7LEIBW5nUIpJlgRql4j31jEoO6n3SsZd/5tM
         wXoaZtb73i9Cil2BrOY1Q+O0wTONSKFZ0Fm8Qt/oCAvK8PHMHXsmclU1Mul87+sTmezI
         os/g==
X-Gm-Message-State: AKaTC01Q3GFuEw8BmHprIuBCBQYH23ODLrZzceCKY1hXBIQTMhSf1YlD30Iv9/Hu8WyHLKY5fmFD3W0fGwQ9Tg==
X-Received: by 10.129.46.133 with SMTP id u127mr7579393ywu.94.1479627285945;
 Sat, 19 Nov 2016 23:34:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Sat, 19 Nov 2016 23:34:15 -0800 (PST)
In-Reply-To: <5df0a607-4d83-8211-457a-96d7bde46eff@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-11-Karthik.188@gmail.com>
 <5df0a607-4d83-8211-457a-96d7bde46eff@gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sun, 20 Nov 2016 13:04:15 +0530
Message-ID: <CAOLa=ZTVTTqRO+Gh2aFJfuSznmnF9zvWw4603kMSTv7_UEOJig@mail.gmail.com>
Subject: Re: [PATCH v7 10/17] ref-filter: introduce refname_atom_parser_internal()
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 19, 2016 at 3:06 AM, Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:
> W dniu 08.11.2016 o 21:12, Karthik Nayak pisze:
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> Since there are multiple atoms which print refs ('%(refname)',
>> '%(symref)', '%(push)', '%upstream'), it makes sense to have a common
>
> Minor typo; it should be: "%(upstream)"
>

Will fix that.

>> ground for parsing them. This would allow us to share implementations of
>> the atom modifiers between these atoms.
>>
>> Introduce refname_atom_parser_internal() to act as a common parsing
>> function for ref printing atoms. This would eventually be used to
>> introduce refname_atom_parser() and symref_atom_parser() and also be
>> internally used in remote_ref_atom_parser().
>>
>> Helped-by: Jeff King <peff@peff.net>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
> [...]
>
>> +static void refname_atom_parser_internal(struct refname_atom *atom,
>> +                                      const char *arg, const char *name=
)
>> +{
>> +     if (!arg)
>> +             atom->option =3D R_NORMAL;
>> +     else if (!strcmp(arg, "short"))
>> +             atom->option =3D R_SHORT;
>> +     else if (skip_prefix(arg, "strip=3D", &arg)) {
>> +             atom->option =3D R_STRIP;
>> +             if (strtoul_ui(arg, 10, &atom->strip) || atom->strip <=3D =
0)
>> +                     die(_("positive value expected refname:strip=3D%s"=
), arg);
>> +     }       else
>           ^^^^^^
>
> It looks like you have spurious tab here.
>

That would have gone unnoticed, thanks for pointing it out.

--=20
Regards,
Karthik Nayak
