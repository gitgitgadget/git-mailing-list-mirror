Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609AF3BD24A
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466330; cv=none; b=J+TKPsdT0kt9m/A7YzVDhQ55Um9tKn3jsYWN4B6dBrhy/7W9ty7lqStehIGQQrF1rlZlDPac0hWRMcB61Z3UbMm+63QiVaQLW5mxBZOged4UumUW/XJUHnR1mYOezZYGhuyMsdCIKqM/jh7hRx8TvgYYuigey8GOg6WtfYyr77s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466330; c=relaxed/simple;
	bh=+5kfOYHyLsSWWofQacgPkOlfH7Vn5DaxEtSrf/hqmxM=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=eTpgk8Vir7NteMB/j3W2kZgowHWcMd+Qh4i4iBIEfYck4lkdMhN8mx0wkoc5J6v8sfQXyeQB6MuofaRQyGd5Nhd1sVBTrm+rdkhQByxFx87IWdJByPjgmGrzGWOJjpqxgvwOG7cDw15NaIsTB4jdSz8msl8/E1BKsXkBKMeZcPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPBl8hgp; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPBl8hgp"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8228ed0081fso46208457b3.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 09:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786466328; x=1787071128; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yq6C4YWUtyQaeEFDzx5x+e+3yAswS5lyBqIO34anjJw=;
        b=LPBl8hgpdxakE8j7cjkNNnJUQND0mNyY/eRIJ4Ip3Fb+9b3hT0g2rEnJlubHkitk62
         Ai9Q4JZ0fZqc8Ibmmz9yIVEaRMtQ5FTaPrzznYRRV9rTmtFueMavURxdaJGK3sbr/j3x
         TGsLrSGXASeMdy2rgxL8tFcZBMCghMapsOWGlO5XYghTPgm4bCXh8TLS4/QlI+ROM+DQ
         Y2aANLx+bAuOJEAmPoVtsVlqs5aKGGS9m+U4I8l+WY7Mn9ikjokDvDVbCBDHRFvUymwV
         Tu0gNu061Z8gMb9rEXgi2CsLP5Pclw1B4MsOx5s12qqZysiD15jnZweORnIONtvAt9gy
         TOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786466328; x=1787071128;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yq6C4YWUtyQaeEFDzx5x+e+3yAswS5lyBqIO34anjJw=;
        b=ZJkY1E5SGNW2hKQFY2RlKezLhM4OZZEoEfvldI6oOwVpl/yoowM8ivmrgc/anljltd
         0jhrpIKCInR7exNA5vBl3feHbyWjPq7zfDWl1QezcdsFD5Ws499jUFuKMgcoxuWqIwy1
         XrKLvNRMpWqCMzG1IBfPmhzXsf6YrW4SO2qm7x51c8Ygm8dGuTAWFC8OcvwWMdKLipk3
         m9Sacs9QBQ/Ap9OvCW8W2M8J5VSOnv3+Tj8bMsiCqFUrKn/8QfPYRZHnELbLKNjf16tD
         jM7y7kP+a4Q3+homFV1xvPFJdqw2H4t8PGayJVFJJnpFjvD1BAAfx6zf+Yh68NHfyDKs
         zpvw==
X-Forwarded-Encrypted: i=1; AHgh+RqolZIrzL61UizfBdTBTYO2/gVpJ5KZuEVJQBXhg3p92JlicfFIPxe9lNDcnLowdm7U0fo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8lek2IE/yNmXDruOaXNJQ1Siynj/bvsNk864HVkC5luNz8mq6
	JfoshkK+Zb7p2RF/6gMXJHz25ro9sagC1/C6grzhuvsy0Fk1BjQFTB4gounhEHNLuKw=
X-Gm-Gg: AR+sD12IIwrL+GE20f0l6nFstvfdBgPiPBzdTqmjUJ5bZ6C3c9x3dUfJcdbkivHR2de
	i+52E6p1kTm8EVucFFSSfLaaQN2xHC8dcPvKwaYeW6Az98GxtQpxXMaDqkBA9C1VkdifRa4hiWB
	aWtj3VArCTfdG3F16qTCc4JARcFJLVjczG1YYqSTFSBig8pSY+kRh/KMa8RazwvXTurbvmf6xYl
	ViSf/n5900xp3fxQcsgbHXPpOEa73o4cCIFQZz0SKY3l268H9aJeq45MVESRYXDeDF64vjCaFVA
	e3sREUSbJpDE9sSc+v4liPSYTY7/FJkTdW6UD4RhimCblBrkSVKDQBC35PTZrc+BYlsM6HP+hmk
	hs793DVr3WH/Mxc6Khp/hJPxMoh/A6ukjDwXExPUiVWeefw0447J50DQLUXWP7hdqWHdhuHQ1cS
	wE5JkuAKv+J0awnsxUMp0ZfKIx/eOuwoFwJFQUZSUbjooKNcDX4xc219vVpYbypG3+Kdz6L/MoU
	28ZUoVGKPIF/2utKBJirfdgIzi6dIUnGoULTaWBNNHJAP/U2xoJGXZ9yLd5lWIU+33r0gySwn6t
	p1714QR8ucW5pSa48+7Gw/d9GM9/HpiFK96BMRx3F2fvmC6C
X-Received: by 2002:a05:690c:6111:b0:80c:f6bb:565d with SMTP id 00721157ae682-82f2e552137mr33521977b3.19.1786466328298;
        Tue, 11 Aug 2026 09:38:48 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:556d:681f:9688:f449])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-82ebdb7e382sm12849937b3.13.2026.08.11.09.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:38:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] worktree add: improve message for ambiguous remote branch name
Date: Tue, 11 Aug 2026 12:38:37 -0400
Message-Id: <DCB65C9B-5E9F-4FF5-A8EE-27C9442119DC@gmail.com>
References: <CAF5D8-u23Z=f02vF1yAHGKRED8DY-v5=BNf7w-yY3vEDmJChDg@mail.gmail.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
In-Reply-To: <CAF5D8-u23Z=f02vF1yAHGKRED8DY-v5=BNf7w-yY3vEDmJChDg@mail.gmail.com>
To: Yoichi Nakayama <yoichi.nakayama@gmail.com>
X-Mailer: iPhone Mail (23D8133)


>=20
> Le 10 ao=C3=BBt 2026 =C3=A0 17:36, Yoichi Nakayama <yoichi.nakayama@gmail.=
com> a =C3=A9crit :
>=20
> =EF=BB=BFOn Mon, Aug 10, 2026 at 10:08=E2=80=AFPM D. Ben Knoble <ben.knobl=
e@gmail.com> wrote:
>>> -static char *dwim_branch(const char *path, char **new_branch)
>>> +static char *dwim_branch(const struct add_opts *opts, const char *path,=
 char **new_branch)
>>> {
>>>        int n;
>>>        int branch_exists;
>>> @@ -781,8 +791,14 @@ static char *dwim_branch(const char *path, char **n=
ew_branch)
>>>=20
>>>        *new_branch =3D branchname;
>>>        if (guess_remote) {
>>> +               int num_matches =3D 0;
>>>                struct object_id oid;
>>> -               char *remote =3D unique_tracking_name(*new_branch, &oid,=
 NULL);
>>> +               char *remote =3D unique_tracking_name(*new_branch, &oid,=
 &num_matches);
>>> +               if (!opts->quiet && !remote && num_matches > 1) {
>>> +                       if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REM=
OTE_BRANCH_NAME))
>>> +                               advise(_(message_advice_ambiguous_remote=
_tracking_branch));
>>> +                       warning(_("'%s' matched multiple (%d) remote tra=
cking branches\n"), branchname, num_matches);
>>> +               }
>>>                return remote;
>>>        }
>>>        return NULL;
>>=20
>> I suppose the extra warning won't hurt anyone's workflow :) so that's goo=
d.
>=20
> I removed the change (advise and warn) here in the latest patch. But I am s=
till
> wondering what I should do. I think a warning would be excessive if
> there is no match,
> but the user might want to know if there are multiple matches.
>=20
> Thanks,
> --
> Yoichi NAKAYAMA

Sorry if I was unclear: I don=E2=80=99t know what hits this particular code p=
ath offhand, and I don=E2=80=99t think adding the warning is wrong! I meant =C2=
=AB as opposed to dying, a warning won=E2=80=99t break anyone but will let t=
hem know of potentially unintended consequences =C2=BB, maybe.

I=E2=80=99m not particularly invested in how we signal ambiguity, but if we d=
on=E2=80=99t have a documented policy for resolving it in a particular way t=
hen I agree we should signal it.=20=
