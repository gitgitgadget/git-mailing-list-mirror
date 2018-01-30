Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35FDE1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 15:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752725AbeA3POJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 10:14:09 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33238 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbeA3POH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 10:14:07 -0500
Received: by mail-wm0-f47.google.com with SMTP id x4so4102013wmc.0
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 07:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bFKgAOdm+eZFChtbiVcn4QvKVV+zDMbT/YnSkAGtZEs=;
        b=IPVMjiFPkZFVZmwwgJkfhOp3EsRTZPNc2SJopQ2pcmXlpWibS0YO7y5AaYLeCD7wrd
         i1uweVqR9KxQSJVeM16S0Dng18so8U/q2/9PhtGPrQDNRMxU3iAMDXsz+HY5hPSCwPwk
         yCMvLydvnwliBBXMk0CrK/f2FZWrfHBy/5TngvP3mFIQPAE1OYeGlLPctAlq6T+tB1hA
         C27OSUEr+Qi+Q6se6kcyiltJtz8Hw3ITq4yCkbO2j6s8EKEj7Y/I29A+Zkmuwrvb8T9C
         +GoN2iYt7uVnQdp1X0C52NfqTj++yOl4EL2VBWl8ypbTIp4QavBuxkRHfFOB6msabKoO
         w3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bFKgAOdm+eZFChtbiVcn4QvKVV+zDMbT/YnSkAGtZEs=;
        b=VaNilnUpXfMIAkLpsysy4oOCd3FuxAWlJUSEkUDzECrCc1CtwnSIPxjuMjXk/XB8FN
         FAgEzwmSXWULM38rsb0hIAi/GtTaVA2j+etiWSk3eStN0F3+FJJyhYz7ArdvQZ+KlYHd
         K4n44CgL080QzrCUOsYxx2afqQmXSElqXXJSqQjefpJPDZYEJLUqcd4Icgc4jvsiJ7h5
         hrB72Y/ADfzamj7CA4whk/FuO49q3feiLBiVIZ7k513ZHZAkpXXQV4g9ADNdzgzpLG7Y
         as1ACjH+noPkJyUfy9pIUgy51vGam86zT0AZuT1qvk0qUZISGXXOtEhJB8CmCiI8UAZe
         ZIhw==
X-Gm-Message-State: AKwxytfk4FDpq4kYyyGiUtoEOPa6nWCKch2dfuEySfYSpJO1ngr2fI2g
        vFXDx9FjiLXubwpUMsfOd4c=
X-Google-Smtp-Source: AH8x226gA3k3J24Escz1L1wULzgDoT+EkZD6MreyRfnD8Akfor9xJENF7N6cvFLF9n+8C17CQazBFw==
X-Received: by 10.28.28.139 with SMTP id c133mr20268326wmc.144.1517325246513;
        Tue, 30 Jan 2018 07:14:06 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id f22sm11894891wmi.24.2018.01.30.07.14.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jan 2018 07:14:05 -0800 (PST)
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH/RFC v5 7/7] Careful with CRLF when using e.g. UTF-16 for working-tree-encoding
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180130144002.GA30211@tor.lan>
Date:   Tue, 30 Jan 2018 16:14:03 +0100
Cc:     Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <10091BA4-1069-4A65-9057-CAAD87F9B55F@gmail.com>
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com> <20180129201911.9484-1-tboegi@web.de> <55B6C3D5-4131-4636-AD0E-20759EDBE8CD@gmail.com> <20180130144002.GA30211@tor.lan>
To:     =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 30 Jan 2018, at 15:40, Torsten B=F6gershausen <tboegi@web.de> =
wrote:
>=20
> On Tue, Jan 30, 2018 at 12:23:47PM +0100, Lars Schneider wrote:
>>=20
>>> On 29 Jan 2018, at 21:19, tboegi@web.de wrote:
>>>=20
>>> From: Torsten B=F6gershausen <tboegi@web.de>
>>>=20
>>> UTF-16 encoded files are treated as "binary" by Git, and no CRLF
>>> conversion is done.
>>> When the UTF-16 encoded files are converted into UF-8 using the new
>> s/UF-8/UTF-8/
>>=20
>>=20
>>> "working-tree-encoding", the CRLF are converted if core.autocrlf is =
true.
>>>=20
>>> This may lead to confusion:
>>> A tool writes an UTF-16 encoded file with CRLF.
>>> The file is commited with core.autocrlf=3Dtrue, the CLRF are =
converted into LF.
>>> The repo is pushed somewhere and cloned by a different user, who has
>>> decided to use core.autocrlf=3Dfalse.
>>> He uses the same tool, and now the CRLF are not there as expected, =
but LF,
>>> make the file useless for the tool.
>>>=20
>>> Avoid this (possible) confusion by ignoring core.autocrlf for all =
files
>>> which have "working-tree-encoding" defined.
>>=20
>> Maybe I don't understand your use case but I think this will generate =
even=20
>> more confusion because that's not what I would expect as a user. I =
think Git=20
>> should behave consistently independent of the used encoding. Here are =
my arguments:
>=20
> To start with: I have probably seen too many repos with CRLF messed =
up.
>=20
>>=20
>>  (1) Legacy users are *not* affected. If you don't use the =
"working-tree-encoding"
>>      attribute then nothing changes for you.
>=20
> People who don't use "working-tree-encoding" are not affected,
> I never ment to state that.
>=20
> I am thinking about people who use "working-tree-encoding" without =
thinking
> about line endings.
> Or the ones that have in mind that core.autocrlf=3Dtrue will leave the
> line endings for UTF-16 encoded files as is, but that changes as soon =
as they
> are converted into UTF-8 and the "auto" check is now done
> -after- the conversion. I would find that confusing.
>=20
>>=20
>>  (2) If you use the "working-tree-encoding" attribute *and* you want =
to ensure=20
>>      your file keeps CRLF then you can define that in the attributes =
too. E.g.:
>>=20
>>      *.proj textworking-tree-encoding=3DUTF-16 eol=3Dcrlf
>=20
> That is a good one.
> If you ever plan a re-roll (I don't at the moment) the *.proj =
extemsion
> make much more sense in Documentation/gitattributes that *.tx
> There no text files encoded in UTF-16 wich are called xxx.txt, but =
those
> are non-ideal examples. *.proj makes good sense as an example.

OK, I'll do that. Would that fix the problem which this patch tries to =
address for you?
(I would also explicitly add a paragraph to discuss line endings)

- Lars=
