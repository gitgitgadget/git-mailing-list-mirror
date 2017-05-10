Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3099420188
	for <e@80x24.org>; Wed, 10 May 2017 21:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752874AbdEJVWA (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 17:22:00 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36244 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbdEJVV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 17:21:59 -0400
Received: by mail-wr0-f195.google.com with SMTP id v42so1047246wrc.3
        for <git@vger.kernel.org>; Wed, 10 May 2017 14:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ozNIlXleeRSo4PWZpNf9VykuTyS4GH/OGcVbF4UUl6M=;
        b=uGJq5P98vKXLXAbxxpyfWyxCMOF96rYjYPh7DB/mY4zNY8IgHEaAfxcMNTRUlwGvsL
         pPN5vI+knJ/lwADkmNouGVo/5HmnMJLJ+mYFoEXBp0kN6ZRYOqyvXG4FM6DSvObkwhs+
         nfprpkskK5zVVxkIQXdEH+5o0fpO5t9n704QM3E++R7iC9i3v0F8D95P6z5/1bKSrZex
         qsGzLznJjMr0YfbYxYAM/gHKoguOubNfDTFO14TZfuza+zJdbolQj5qKC8nkBJWHBg+y
         xMhzwV40vP1RWl2DMiTWnAGUHux0RrX6NDpwb7QVD0tq0SpDT08PzArqz2ZuoX3UbXUO
         7mmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ozNIlXleeRSo4PWZpNf9VykuTyS4GH/OGcVbF4UUl6M=;
        b=TjKJfncHqNnGxPsoMtqe2M0TRwRHa57u935hPfzjg6ZuZgszoF0y8fjZHQEx91/scY
         Rq+xDu0Hh8Eb60UYyDCl/ppq6B4p/V46mfZqnmZBi7Y5CfrSFlFSwLogxPu2Xhdp9boF
         1/L/HVii8Uaax0Vb1l9JCM/qsyWHvR/C8Jtil6wvECjUrm5K5NFqja49ZrzXMPTlTJgq
         8Xd5Ia+G3UHgHbf8llAmBCIihpCMMTqB74g/8dc5cBM43PI11kI1+R/aHPy3d0HIXjkq
         UsevldcdVDxwY4uzajF7TCWv+nazBgeuvBMFhCTH+EIK0HhbVgEry69fHLR/wttTkaJ8
         kHHQ==
X-Gm-Message-State: AODbwcAy6SVT123EaUGCYXS7Jl7BqN1xVSmenuJ+EWWTEYioN/sBlLF4
        MAM0pkZZaQ96vsESRm3u5Q==
X-Received: by 10.223.168.97 with SMTP id l88mr5468307wrc.54.1494451318546;
        Wed, 10 May 2017 14:21:58 -0700 (PDT)
Received: from p2003005d8f6320c321478d3a028e2b4b.dip0.t-ipconnect.de (p2003005D8F6320C321478D3A028E2B4B.dip0.t-ipconnect.de. [2003:5d:8f63:20c3:2147:8d3a:28e:2b4b])
        by smtp.gmail.com with ESMTPSA id v27sm164190wra.19.2017.05.10.14.21.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 May 2017 14:21:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Possible bug in includeIf / conditional includes
From:   Raphael Stolt <raphael.stolt@gmail.com>
In-Reply-To: <CACBZZX7CgeW1OK+g9Mbir62MMaCx4sHFZngUuWz_H241Sb355g@mail.gmail.com>
Date:   Wed, 10 May 2017 23:21:57 +0200
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CC77A0CE-88A5-4A3C-97AF-ED0180FE385B@gmail.com>
References: <C1ACB28C-F1B4-42A1-8135-797DEFD9F03C@gmail.com> <b80c68fa-fe1e-3cf8-3c7e-527a4d941108@gmail.com> <CACBZZX7CgeW1OK+g9Mbir62MMaCx4sHFZngUuWz_H241Sb355g@mail.gmail.com>
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>=20
> Am 10.05.2017 um 21:48 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com>:
>=20
> On Wed, May 10, 2017 at 8:58 PM, Sebastian Schuberth
> <sschuberth@gmail.com> wrote:
>> On 2017-05-10 19:00, raphael.stolt@gmail.com wrote:
>>=20
>>> Current configuration which finds the conditional configuration.
>>>=20

a)

>>> ~/.gitconfig
>>> [includeIf "gitdir:~/Work/git-repos/oss/"]
>>>   path =3D ~/Work/git-repos/oss/.oss-gitconfig
>>>=20
>>> Expected configuration which doesn't find the conditional =
configuration:
>>>=20

b)

>>> ~/.gitconfig
>>> [includeIf "gitdir:~/Work/git-repos/oss/"]
>>>   path =3D .oss-gitconfig
>>=20
>>=20
>> My guess is, because includeIf might contain other conditionals than
>> "gitdir", the generic convention is to always use an absolute path =
for
>> "path".
>=20
> [CC'd OP Raphael Stolt, please reply-all]
>=20
> In both cases the conditional is the same, but the path is relative
> v.s. absolute.
>=20
> Raphael: Does the config get included if you cd to
> ~/Work/git-repos/oss/? =46rom git-config(1):

Given I=E2=80=99m in a repo in ~/Work/git-repos/oss/ e.g. =
~/Work/git-repos/oss/project-repo-a and I=E2=80=99m using config a)=20
the config is used from ~/Work/git-repos/oss/.oss-gitconfig

Given I=E2=80=99m in a repo in ~/Work/git-repos/oss/ e.g. =
~/Work/git-repos/oss/project-repo-a and I=E2=80=99m using config b)=20
the global config is used because there is no .oss-gitconfig in $HOME.

I guess it=E2=80=99s an intended behavior since conditional =
configuration files __SHOULD__ reside in $HOME rather than=20
in my case in ~/Work/git-repos/oss.

>=20
> ---cut---
> The included file is expanded immediately, as if its contents had been
> found at the location of the include directive. If the value of the
> `include.path` variable is a relative path, the path is considered to
> be relative to the configuration file in which the include directive
> was found.  See below for examples.
> ---cut---
>=20
> The commit that added IncludeIf (3efd0bedc6) does something with
> relative path (just skimming, need to get to other things), but unlike
> [Include] the docs don't explicitly mention what it's supposed to do
> with that, and all the examples show absolute paths.
>=20
> So whether this is a bug in the code or not it seems to definitely be
> a doc bug, whatever it does with relative files should be in the docs.
+ 1=
