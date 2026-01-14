Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27597324B3B
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413210; cv=none; b=r/QMOVC1NVgIuijj4wAKLAmgM66o5jXNe5OOKFSTczgyCXXEI1Sf6/92Dh7IYFH14RYCz/mZvlWdM1uapkxHCNXlfruIeoSCBJ/X44uCPK6kgYnEvHeb6dYsfye87uWmjejW1T+RZ84f8Ha59wqFrDze24YgbL8OFxb28hjDuuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413210; c=relaxed/simple;
	bh=DzdFftRV2znzfC7pYm3o6yFBOYKh+sc0StF/KScSi+Y=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=HQ5NELIHbaQQev9MJFQmH54YGj43KosW7pbyWKBSBrBXa7GSmr9tDNVK+B0h2DHQIHrQGG78UIJrfliaU2x3HbWJHB+RFZM3oDUpfkLFwV0PXhTMPEZV3YTi55N2oPtbloSKorsY1HOM7MGAADdzxyZ3NOa2eTHjmdSDOikiyhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaRLBlP1; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaRLBlP1"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-78c6a53187dso57286387b3.2
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 09:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768413208; x=1769018008; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jP5BLUK5iSzxBM+wVnWAJYYIQF5YATQWTwn9azLOSM8=;
        b=IaRLBlP10yswzPSi5CmTilXwh3r8l7liR/mc1POd/dzGFpTb4Jo26/a8a4kO2d7Bwo
         CI/DOXAFjuK9dvqxzOThGcCpDn+tv1TktvKAy5JHbD83pHzh8mGyg1VnL9nAsdznw/aU
         kkgt9pXewrmyFEM0dk/T7jvmmbqm/9q9SaeVnjB9qVWmodEtclNszg4d9ajXGaIVafeT
         zpbnppxEjx4QOmaVyzaXv2NZAbCCuHTtDRe94kO77RsqgImn+y8yxhpU9zFqt4m/4TrQ
         qeBb4P1P0K3GeMGRe2Ie+LWUGP90xewn1zg7fMyx/FfHjr00qSa/KUXyS8EfZ1+cL3Sj
         jhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768413208; x=1769018008;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jP5BLUK5iSzxBM+wVnWAJYYIQF5YATQWTwn9azLOSM8=;
        b=wpTDsZSpUAAOfpn5NLJudYnqnTWx236nvFOQRy3yB992slZPqC/nkjWby9hVIyXinM
         mo6zbnQtvvO1WzJ4xA6feL/xlwR2Y+Mo0xOXbKXhpldVR3qSWkCgF53m+71td/X8Ao5H
         gZwdmkRMhxNcrVtz6H+t1Om3PI4FgnkbIz8mOsljxLwHUcLNjOf/GAM85C6Ob5Cr6iu1
         ozb4/aKILeUT3FtqK0iRknlkGfwLmEmQZu7bRM1w4pWhhcpDyBr+Zny20NhE2nKLn6aE
         Ah1aDdKR2dOvpqB6u+iMOESY5z7p3h5S6uwEm3w1xuSZ17eOxh5kv0xbNYo44bhQJrl7
         Ie4g==
X-Gm-Message-State: AOJu0YwCexAgGd17ZQIxy9I0n97Lgkyj7nkfN9IunqlqiqtZRiy9YHRD
	r/GDEvleKAoxq93jM9GhwE/5dtcNaUXMhJRZ+vdOtlGEa7BAIDRYKDpv
X-Gm-Gg: AY/fxX48HsAmBb2eqjrt5GVlRGWvUtBWTz8zO9nsOOqIzpHYunAZY7Ab9FN0uf6l74M
	Y2Wx3ZirGhGnDoatajBAq/gYx26WGT+/6mZEsjz42gBJY8vKwK37ZYJvE3WdLeqX4pPMcSZtSce
	c9NUmUcpPpFNKNltUSgwRpQ+pDKK49EmPYfaR8DW5HcoDc19YNgXr5tcZm9uBOGCC/Ub+upA6pk
	08EVY3hw4Bv43dhYIpuAmCaN2Jg9hbfthm1YFXcSR01MowyTPL0qrejyohK3Qf2B7PBUX5cUo8a
	ilmDlpGyr1wI46kkhM1XT0qe0mDz8cGmUwjQxbL9HSAkWcvt8Ce649AfiDRcXrdpKKkqN4EloUC
	uXr0lGy35sNkwfqpXrlPouV60HDwjQwD9P408UPxulsTY3ySOp7LkwTW1yhdzbsChiT+VOshZ/d
	fDw3mH3bx7DOWoVLuA/e7jhp1j3+2InrGKZlx2BgUaBk5Lp9WYxE1WO6H1L9koo0A4Bs0KJMwXV
	UHvS6CqGsJAHm8+fLZbQB9bW7Twmc5lQIiGCc8=
X-Received: by 2002:a05:690e:1699:b0:643:c82:ee1 with SMTP id 956f58d0204a3-64901b1de6amr2819032d50.78.1768413208043;
        Wed, 14 Jan 2026 09:53:28 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:18f6:dd0a:cf21:e611])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa670ec0sm93445867b3.36.2026.01.14.09.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 09:53:27 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 5/5] Documentation: update add --force option + ignore=all config
Date: Wed, 14 Jan 2026 12:53:17 -0500
Message-Id: <B94F0800-06B5-47BC-8C22-AAE1882E5B9C@gmail.com>
References: <37fe7956e089394bb1d75f4c8af4a3347b204803.1768376879.git.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 Junio C Hamano <gitster@pobox.com>,
 Brandon Williams <bwilliams.eng@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Claus Schneider <claus.schneider@eficode.com>,
 "Claus Schneider(Eficode)" <claus.schneider@eficode.com>
In-Reply-To: <37fe7956e089394bb1d75f4c8af4a3347b204803.1768376879.git.gitgitgadget@gmail.com>
To: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 14 janv. 2026 =C3=A0 02:48, Claus Schneider(Eficode) via GitGitGadget <=
gitgitgadget@gmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFFrom: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>
>=20
> - git-add.adoc: Update the --force documentation for submodule behaviour
>  to be added even the given configuration ignore=3Dall.
> - gitmodules.adoc and config/submodule.adoc: The submodule config
>  ignore=3Dall now need --force in order to update the index.
>=20
> Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
> ---
> Documentation/config/submodule.adoc | 13 +++++++------
> Documentation/git-add.adoc          |  5 ++++-
> Documentation/gitmodules.adoc       |  5 ++++-
> 3 files changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/config/submodule.adoc b/Documentation/config/su=
bmodule.adoc
> index 0672d99117..250a6133d8 100644
> --- a/Documentation/config/submodule.adoc
> +++ b/Documentation/config/submodule.adoc
> @@ -32,15 +32,16 @@ submodule.<name>.fetchRecurseSubmodules::
>=20
> submodule.<name>.ignore::
>    Defines under what circumstances "git status" and the diff family show
> -    a submodule as modified. When set to "all", it will never be consider=
ed
> -    modified (but it will nonetheless show up in the output of status and=

> -    commit when it has been staged), "dirty" will ignore all changes
> -    to the submodule's work tree and
> +    a submodule as modified.
> +    Set to "all" will never consider the

Throughout this patch, missing =E2=80=9CWhen set to=E2=80=A6=E2=80=9D for id=
iomatic English.=20

> submodule modified. It can
> +    nevertheless be staged using the option --force and it will then show=
 up
> +    in the output of status.
> +    Set to "dirty" will ignore all changes to the submodule's work tree a=
nd
>    takes only differences between the HEAD of the submodule and the commit=

>    recorded in the superproject into account. "untracked" will additionall=
y
>    let submodules with modified tracked files in their work tree show up.
> -    Using "none" (the default when this option is not set) also shows
> -    submodules that have untracked files in their work tree as changed.
> +    Set to "none"(default) It is also shows submodules that have untracke=
d
> +    files in their work tree as changed.
>    This setting overrides any setting made in .gitmodules for this submodu=
le,
>    both settings can be overridden on the command line by using the
>    "--ignore-submodules" option. The 'git submodule' commands are not
> diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> index 6192daeb03..941135dc63 100644
> --- a/Documentation/git-add.adoc
> +++ b/Documentation/git-add.adoc
> @@ -75,7 +75,10 @@ in linkgit:gitglossary[7].
>=20
> `-f`::
> `--force`::
> -    Allow adding otherwise ignored files.
> +    Allow adding otherwise ignored files. The option is also used when
> +    `submodule.<name>.ignore=3Dall` is set, but you want to stage an
> +    update of the submodule. The `path` to the submodule must be explicit=
ly
> +    specified.
>=20
> `--sparse`::
>    Allow updating index entries outside of the sparse-checkout cone.
> diff --git a/Documentation/gitmodules.adoc b/Documentation/gitmodules.adoc=

> index d9bec8b187..3792da96aa 100644
> --- a/Documentation/gitmodules.adoc
> +++ b/Documentation/gitmodules.adoc
> @@ -70,7 +70,10 @@ submodule.<name>.ignore::
> --
>    all;; The submodule will never be considered modified (but will
>        nonetheless show up in the output of status and commit when it has
> -        been staged).
> +        been staged). Add `(new commits)` can be overruled using the
> +        `git add --force <submodule.path>`.
> +        The setting affects `status`, `update-index`, `diff` and `log`(du=
e
> +        to underlaying `diff`).
>=20
>    dirty;; All changes to the submodule's work tree will be ignored, only
>        committed differences between the `HEAD` of the submodule and its
> --
> gitgitgadget
>=20
