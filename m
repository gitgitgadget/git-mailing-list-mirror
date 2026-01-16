Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC86434165B
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768579668; cv=pass; b=Lyp0Cf6m57tYJ2PFoJhyfEGEa5YE1OHOmLozpgd2lIqf/sBrrfYicvZ8CYqs8ompE1mop1A4FgYzXEIegNT6hZk4N6cS/Csq8Hhi323/zBPXIoYjbuwY9qAHYOQn3ReC0nBbWRClUpiAwEdL8ppLl7ujZAZScvbZku+fa/GJ8K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768579668; c=relaxed/simple;
	bh=YWt8d9FXiRsBumcmSn9rjkhJgExdCuRsA6wfGyQvTek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aezruE9yq8bzE50Fjc1ApMKog9d2xa7FKA/r85DMJaEypqE6MSBi0dWWot+Zi9CnHo/PBYyKWoxvxAF4GOMCE8sfEAkzT0/XeqLxdICjIWoqyExZ+VkFWyZKtHLbujF2SsFEixfWwGgBRqSX+yVLEgitY/QAyyLw3RCmtVgJ9ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eficode.com; spf=pass smtp.mailfrom=eficode.com; dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b=etSnRDpe; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eficode.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eficode.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b="etSnRDpe"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b5ed53d0aso3120515a12.3
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 08:07:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768579663; cv=none;
        d=google.com; s=arc-20240605;
        b=TbCUwtg17H8UJtQjTKOLtID0wzAniRYIgWuLL5vM+g4DHnhc99MFDPVMyaL0oBjB+I
         abn1aOGvmXXblK6iq1tJT7V1CuyybBbZcdYGw9L98iCcE7u5blFZfH8co+stfHzlpIUV
         Jl97OTl9DWwtkab4Ili32J+tpKhNT1habFaNZY2FOsM9r9uRe7AU7dU8HvVf1K/lUr2W
         8XQTNjnBkNGGZEg541kAqAvGw4SGqY+zRCeEH5eyOa/kj0wSSzOqmJgQ1eFRsRV9j3a1
         kmG+EP6hPAM1CBikiFHStOU3rYKpX36vc+Ri7SQGx5YcKiBZ8M6o0if5IqaVJ9hcEOPC
         u6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YWt8d9FXiRsBumcmSn9rjkhJgExdCuRsA6wfGyQvTek=;
        fh=KHnCE4Xr/2XPOBpLMD/5sVmJuzR5qGcgh964EBPV50A=;
        b=aKuO504uDCW09Ay+8upYvPkmuTiMebO1LROS6vjiCpbPmRokrwSGtxMfbGdukAE5xO
         TLJJDuX/q47XyPgxZDPCIR8ZlLgJbZWDq2n6T3Dfg6hEDglb0gZ1vpgjr3FXTJmiwQ6j
         A8zGcL5L1jFFzsseirslH1q5NQakcUkj59M9QKOyjG5q44ApYigj3kRppC/Y1koSOkw+
         kcIe4qoYJlq0B7Y05B1Kv7aTcyc2ENJ8s8vLa6FbbiPlzSm5bzQRsaPhhrrsIezAg0jD
         XXRJXOlAuG6TJ4Ox7VMiEEki2gyH27+ufoc5XaLw87x0RkwrZdbgYp3O7jNJubfQKkvo
         r/4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eficode.com; s=google; t=1768579663; x=1769184463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWt8d9FXiRsBumcmSn9rjkhJgExdCuRsA6wfGyQvTek=;
        b=etSnRDpeXcSMgwSXEVdiGBBEAI0ot354Ui8qE4f0PpAYntnr4AyIjNxrPd8AKDn5SI
         EWPu1HwGpGBQQakiKqdBMA48JjoL84MUjlt2Jw4qCrlOMuGfMtwFMoO7aoMs2jB/5e20
         m0b86kEE0XGosXkZbBLn+Q7UJoRU1b7Csnxx/i2zZd6U63/AvOx0KuwjVuMxiMgaxVoK
         w6NGU5O5Nj42MdDSKKqbSlFggqXcAawzYCmdtUBUKmdwiPPYsmoiPSB/V/ZI/YuAp+QC
         x+q6VNo9u0PCMNopwG8cDIJAuTcjx7T71e/C3PeiX1/7YicfqifsqByPHFIePaDWy/GL
         Yk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768579663; x=1769184463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YWt8d9FXiRsBumcmSn9rjkhJgExdCuRsA6wfGyQvTek=;
        b=Nv5Ft7vAv+wispLx75VevhYRP0LELw1nRctaGVBIJkdeFpNVSbCa6LbiqgixtpYdcl
         patdOQcFqLbRD1q5glWYX2foqufdBnGxJO6EpeZLvbIqcN14nVhKcKLnjRv3V2W7DrsP
         cVc31FT343oaPBA3QVR5aTuTpmA4GmhNFqz2GSmnwPTtziDNgDCKmnIiOwRKZPEqGshg
         ZIk+Of7JhtjkSftL05OurD9S+tacwg8yiUrqHOuaeLIBA7fJ04sFDrPK/RUsZc+Gvc3f
         DVqMQYopy85yC/qMZy9dYydRkbIAM2zXh6NfrSM20gC0siCqu2Nr8XJo3K+t8c4t8qFG
         G+/w==
X-Forwarded-Encrypted: i=1; AJvYcCXFoKqUUKNmXlvywMOKb6Qm983pAyHgY5iKXIhzVVaxR32ex97SweLEX3SRtM58IYodwJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOtoADzuASNCELcwyWkSs79In93q8drKtKKto8c1SKymR9Vi7q
	et7pcdZE1g/mRg2uyzRLfECzFtYAvM4mbvOV/1/NGaeFlVUBjZvSoa6rzRZGJa2UKHf8XhONYeD
	4zcq/jaeO/xEu3R7DIkpCeKiQmDTFxOOVH09tv3xx
X-Gm-Gg: AY/fxX6dxNGuQE0IKMT+KVhB8glEJBIMxVb/bLSmAToIEBvijSGF22HwZfPWJTtvOSH
	ipuLXLrhiONC2tr0VRocKgPwbYn3X0XtfdxHY58C6z6FuQOvrQVfdcQ/V50c0np6x36Jl9E9yRJ
	dSm0Z6OWPbACTmCUpWObdW8tvYsBoFRUCFLZfov8lCSOi6euewbtayfF3TmJDWKb445rUCb3ilP
	Qx26JMW8Mm9ZK0ee1LB/eNwsE3raywLCbZQwgaoXSCFqZiG7xG0DM3anyNlA+GbH6A=
X-Received: by 2002:a05:6402:34d5:b0:653:b83b:a68c with SMTP id
 4fb4d7f45d1cf-654525cc828mr2472309a12.12.1768579663019; Fri, 16 Jan 2026
 08:07:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
 <pull.1987.v3.git.1768376879.gitgitgadget@gmail.com> <de72bf0a9135224ed4c4a05ae00deadc28225ac0.1768376879.git.gitgitgadget@gmail.com>
 <f021269b-c89c-41c8-aa08-2ec2443ac7e8@app.fastmail.com>
In-Reply-To: <f021269b-c89c-41c8-aa08-2ec2443ac7e8@app.fastmail.com>
From: Claus Schneider <claus.schneider@eficode.com>
Date: Fri, 16 Jan 2026 17:07:30 +0100
X-Gm-Features: AZwV_Qg0Q4sHhXT8uMH_Roi65ksxx3rJJ17UnOC-Lt91nMesick7WjUdXJu-wB0
Message-ID: <CA+GP4bpwMui5RT9ixo8iWyZ6XZDw3GnYhvgiqVmRq8dW7yo5RQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] read-cache: submodule add need --force given
 ignore=all configuration
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Brandon Williams <bwilliams.eng@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for feedback. Well noted and it will be reworded like this:

....
A message is printed (like ignored files) guiding the user to use the
--force flag if the user explicitly wants to update the submodule reference=
.

The reason for the change is to support branch tracking in submodules
 with configuration `submdule.<name>.branch` or similar workflows where the
user is not interested in tracking each update of the sha1 in the submdule.
You can additionally set `submodule.<name>.ignore=3Dall` and the
`git status`will state nothing and, with this patch, the `git add`
does not either - as
the default behaviour. This patch changes the workflow to a more logical
behaviour and similar to workflow for ignored files.

The patch gives more scenarios for submodules to be used effectively with l=
ess
friction similar to the "repo" tool. A submodule can be added for many
different reasons than a hard dependency. It can be added as loosely couple=
d
dependencies whereas the user wants the latest based on the configuration
`submoule.<name>.branch`, but are not interested to track each commit in th=
e
`super-repo`. Currently it gives friction of handling conflicts between
branches even the sha1's are fast-forward and the user just wants the lates=
t
in any way. A developer can still add a sha1 explicitly to track updates.
...

// Claus

On Thu, Jan 15, 2026 at 4:43=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Wed, Jan 14, 2026, at 08:47, Claus Schneider(Eficode) via GitGitGadget=
 wrote:
> > From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>
> >
> > Submodules configured with ignore=3Dall are now skipped during add oper=
ations
> > unless overridden by --force and the submodule path is explicitly speci=
fied.
> >
> > A message is printed (like ignored files) guiding the user to use the
> > --force flag if the user has explicitely want to update the submodule
> > reference.
> >
> > The reason for the change is support submodule branch tracking or
> > similar and git status states nothing and git add should not add either
> > as a default behaviour. The workflow is more logic and similar to regul=
ar
> > ignored files even the submodule is already tracked.
> >
> > The change opens up a lot of possibilities for submodules to be used
> > more freely and simular to the repo tool. A submodule can be added for =
many
>
> s/simular/similar/ ? Although the sentence doesn=E2=80=99t quite make sen=
se to
> me. Well I=E2=80=99m unfamiliar with the domain anyway. ;)
>
> > more reason and loosely coupled dependencies to the super repo which of=
ten
>
> s/more reason/more reasons/ ?
>
> > gives the friction of handle the explicit commits and updates without
>
> s/handle/handling/
>
> > the need for tracking the submodule sha1 by sha1.
> >
> > Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
> > ---
> >[snip]
