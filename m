Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8721220188
	for <e@80x24.org>; Wed, 10 May 2017 21:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbdEJVhR (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 17:37:17 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35811 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbdEJVhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 17:37:16 -0400
Received: by mail-wr0-f196.google.com with SMTP id g12so1084343wrg.2
        for <git@vger.kernel.org>; Wed, 10 May 2017 14:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Atob4VUCr9ml5sPXIMSpBIGl4EPfj2FKAeebkHqkpLo=;
        b=tZImrroONn2I1+JSI5xND341u+OpcSJPq//rxYAH88Wn2tWUTOlYzLFhIxuXZ0iQAY
         XiNKxQthYQz0efbqHIacM2HwGF/NMppic7ERc9ukaP4EZdeTyJk8/B9QueehWN9WFKkE
         n1AR/03tPAeePljCdm8Z7OVZHcN9WwhSo1uLbXGvmjVIr6tuUQe4wA9DAA1wWFv5cOLm
         qf17jznohmQyIHQCLbG+fgfoXY/bWAYI3kk0vukx3x6cIS2WYUAKnO3KX4JHAXv2v5CR
         wbIj4F8NROkFsMRUfHT2tEW6fbKbuaNBqnmQ5gIVj/R1SvEubUjvwS37JU5B81vIK2wy
         ORWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Atob4VUCr9ml5sPXIMSpBIGl4EPfj2FKAeebkHqkpLo=;
        b=gh5VoHoCCD672pDRL+3G8lszv6lJMhtlhRHoanHnX/d5zRPOYnrHOCK/ivX2RH9SwO
         PxqNi/aL2W652vTEutLuxXlFsZd3CZCFpQMx/ffK/yTX3RoX1Pk9TThAAjaVP/9rwUvM
         bnufiQnBhX1yxL/COnxVsrj47t03EZuOqORQdtKFDGI3vlwW25CbXx4Bcm/QYxWGpFNW
         EAhjdjzSo9kknqJ61drjII9PxFi9f7C0oCbT4J9nnxlrx7yqVMWermZH43qbtcCLrHtr
         ql1m7X9SmiBz9rStznWPr9fm/6cEqU7in26e/YwMvm/TxGFzjLxlTqkP/ssdJoAYerEl
         WSgw==
X-Gm-Message-State: AODbwcBStu74EtYABdSFj5HgZmq0FqH3TOqYpoGmDnp4vEtLar8K9zx+
        QAZ0vjC0dO8ifg==
X-Received: by 10.223.165.14 with SMTP id i14mr5704711wrb.127.1494452235208;
        Wed, 10 May 2017 14:37:15 -0700 (PDT)
Received: from [192.168.2.100] (p4FEB91C5.dip0.t-ipconnect.de. [79.235.145.197])
        by smtp.gmail.com with ESMTPSA id l7sm147020wrc.52.2017.05.10.14.37.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 May 2017 14:37:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Possible bug in includeIf / conditional includes
From:   Raphael Stolt <raphael.stolt@gmail.com>
In-Reply-To: <CC77A0CE-88A5-4A3C-97AF-ED0180FE385B@gmail.com>
Date:   Wed, 10 May 2017 23:37:13 +0200
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C2EAA2DF-B7F4-4011-BB0F-4F3BA9E96890@gmail.com>
References: <C1ACB28C-F1B4-42A1-8135-797DEFD9F03C@gmail.com> <b80c68fa-fe1e-3cf8-3c7e-527a4d941108@gmail.com> <CACBZZX7CgeW1OK+g9Mbir62MMaCx4sHFZngUuWz_H241Sb355g@mail.gmail.com> <CC77A0CE-88A5-4A3C-97AF-ED0180FE385B@gmail.com>
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Am 10.05.2017 um 23:21 schrieb Raphael Stolt =
<raphael.stolt@gmail.com>:
>=20
>>=20
>> Am 10.05.2017 um 21:48 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com>:
>>=20
>> On Wed, May 10, 2017 at 8:58 PM, Sebastian Schuberth
>> <sschuberth@gmail.com> wrote:
>>> On 2017-05-10 19:00, raphael.stolt@gmail.com wrote:
>>>=20
>>>> Current configuration which finds the conditional configuration.
>>>>=20
>=20
> a)
>=20
>>>> ~/.gitconfig
>>>> [includeIf "gitdir:~/Work/git-repos/oss/"]
>>>>  path =3D ~/Work/git-repos/oss/.oss-gitconfig
>>>>=20
>>>> Expected configuration which doesn't find the conditional =
configuration:
>>>>=20
>=20
> b)
>=20
>>>> ~/.gitconfig
>>>> [includeIf "gitdir:~/Work/git-repos/oss/"]
>>>>  path =3D .oss-gitconfig
>>>=20
>>>=20
>>> My guess is, because includeIf might contain other conditionals than
>>> "gitdir", the generic convention is to always use an absolute path =
for
>>> "path".
>>=20
>> [CC'd OP Raphael Stolt, please reply-all]
>>=20
>> In both cases the conditional is the same, but the path is relative
>> v.s. absolute.
>>=20
>> Raphael: Does the config get included if you cd to
>> ~/Work/git-repos/oss/? =46rom git-config(1):
>=20
> Given I=E2=80=99m in a repo in ~/Work/git-repos/oss/ e.g. =
~/Work/git-repos/oss/project-repo-a and I=E2=80=99m using config a)=20
> the config is used from ~/Work/git-repos/oss/.oss-gitconfig
>=20
> Given I=E2=80=99m in a repo in ~/Work/git-repos/oss/ e.g. =
~/Work/git-repos/oss/project-repo-a and I=E2=80=99m using config b)=20
> the global config is used because there is no .oss-gitconfig in $HOME.

Given I=E2=80=99m in ~/Work/git-repos/oss and I=E2=80=99m using config =
b)
also the global config (~/.gitconfig) is used.

>=20
> I guess it=E2=80=99s an intended behavior since conditional =
configuration files __SHOULD__ reside in $HOME rather than=20
> in my case in ~/Work/git-repos/oss.
>=20
>>=20
>> ---cut---
>> The included file is expanded immediately, as if its contents had =
been
>> found at the location of the include directive. If the value of the
>> `include.path` variable is a relative path, the path is considered to
>> be relative to the configuration file in which the include directive
>> was found.  See below for examples.
>> ---cut---
>>=20
>> The commit that added IncludeIf (3efd0bedc6) does something with
>> relative path (just skimming, need to get to other things), but =
unlike
>> [Include] the docs don't explicitly mention what it's supposed to do
>> with that, and all the examples show absolute paths.
>>=20
>> So whether this is a bug in the code or not it seems to definitely be
>> a doc bug, whatever it does with relative files should be in the =
docs.
> + 1

