Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 772821FAA1
	for <e@80x24.org>; Fri, 21 Apr 2017 22:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423686AbdDUWC3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 18:02:29 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:33615 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1042724AbdDUWCY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 18:02:24 -0400
Received: by mail-io0-f172.google.com with SMTP id k87so137027805ioi.0
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 15:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dQh421WiWdAmOSWrN4OaG+6RvDxyloS4qXEht/6Zj2I=;
        b=Q15utRYGIPKU+EHFkmlog2Z+v+JGVoeOUtOYgIGHxMckKcclbshO8RFeeDVVmlPJyr
         3XL9yWh+AuRnlUf/mIcDAktwzKNAy6o3br/E78y+5kJzmC8SXwvgHIkwAgXij5CLvwOf
         P8cHT87xt67eFf7b7VxQNvdGeRRikgJLadm7DSkPp6vZ2jnDo9PRymn6fbungwObGgX7
         9NOXkqn870QLruWi/cWFhZXODMbbQ8Gkp50ettyCcNfkBRylwxlswB52WLgYx8ohA3j2
         P9C9Cm+WqPPMf7FE/tSlMXqstvA0g8OfHjHyCtFggQou35gHdWb8p7aG/doHiyJU2wFz
         x74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dQh421WiWdAmOSWrN4OaG+6RvDxyloS4qXEht/6Zj2I=;
        b=pXvJ7EjPMJ/5eSFUEeTYuDnlXxqfsK+EjnSfHO0wfyVJUxJBZSxBZILtCxxwIwoVSl
         DQ3Wgs79moJFd8BHy4sIWvuymFMBGYNI22Nb/edq+6fdeLcFqL+1SCCTnMH5PPMakl0o
         XrbaPT7wZE4/BaU+b3EaP8oW3DlBSLl3Rh+T68FB+gFjgVcubQnPshZxdsL7Ogmzpmt2
         GX5iq5RET1Y7j4HEFa13AnugBIdwnmIf39mjbndbHH5ko7xR45sRG3MfJh3BjVnwZh+I
         XrPIToiyMzUfL0PbWaPIINtmhAum7Q3LHBIOfAK3TYLQqi5fkkx+gS0+T4AuEVQB4rqD
         RM2w==
X-Gm-Message-State: AN3rC/6l3VvXHrBXN12EqDMsE8gBQt2D1tbupRUcI0b5sUBiK9O9jcIo
        4r3UXK7eNn9vqllM7bIRExo19eVA8g==
X-Received: by 10.107.32.199 with SMTP id g190mr19203167iog.117.1492812143551;
 Fri, 21 Apr 2017 15:02:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Fri, 21 Apr 2017 15:02:02 -0700 (PDT)
In-Reply-To: <20170421213553.6vqcmnwolwtieqo4@sigill.intra.peff.net>
References: <20170421194428.1377-1-avarab@gmail.com> <20170421204154.c5mvmnccxkxdm5aw@sigill.intra.peff.net>
 <CACBZZX4oMFkZ93YxXrByh-jCK-eVxNBj+UgF77zm5Pq1mzf+WQ@mail.gmail.com> <20170421213553.6vqcmnwolwtieqo4@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 22 Apr 2017 00:02:02 +0200
Message-ID: <CACBZZX5ERL4ecLL9AvPVKZGXhAS+RQsSSBQEEK7w3yR86A_tMg@mail.gmail.com>
Subject: Re: [PATCH] t/perf: correctly align non-ASCII descriptions in output
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 11:35 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 21, 2017 at 11:28:42PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > I thought there was some "use" flag we could set to just make all of o=
ur
>> > handles utf8. But all I could come up with was stuff like PERLIO and
>> > "perl -C". Using binmode isn't too bad, though (I think you could
>> > just do it as part of the open, too, but I'm not sure if antique
>> > versions of perl support that).
>>
>> [Debugging perl encoding issues is one of the many perks of my dayjob]
>>
>> Using binmode like this is about as straightforward as you can get,
>> the former occurrence could be equivalently replaced by:
>>
>>     utf8::decode(my $line =3D <$fh>);
>>
>> But better just to mark the handle as utf8. There's a fancier way to
>> do it as part of the three-arg-open syntax, but I couldn't remember
>> whether all the perl versions we support have it.
>
> Yeah, I agree marking the handle is better. binmode is pretty
> straightforward, but we'd have to remember to manually set it if we add
> any other handles. That's probably not a big deal in this particular
> script, though, which is pretty short.
>
>> About the "use" flag, you're probably thinking of the confusingly
>> named "use utf8", but that's to set your source code to utf8, not your
>> handles, e.g.:
>>
>> $ perl -CA -MDevel::Peek -wE 'use utf8; my $=E6=97=A5=E6=9C=AC=E8=AA=9E =
=3D shift; Dump $=E6=97=A5=E6=9C=AC=E8=AA=9E' =C3=A6
>> SV =3D PV(0x12cc090) at 0x12cded8
>>   REFCNT =3D 1
>>   FLAGS =3D (PADMY,POK,pPOK,UTF8)
>>   PV =3D 0x12de460 "\303\246"\0 [UTF8 "\x{e6}"]
>>   CUR =3D 2
>>   LEN =3D 16
>>
>> As you can see people got a bit overexcited about Unicode in the 90s.
>
> Yeah, I know "use utf8" doesn't work for that, but I was thinking there
> was some other trick. Digging...ah, here it is:
>
>   use open ':encoding(utf8)'
>
> No clue how portable that is. For such a small script it may be better
> to just stick with vanilla binmode().

Yeah that would work, but doesn't work on 5.8.0, which is the lowest
version we support.
