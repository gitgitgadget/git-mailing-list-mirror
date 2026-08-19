Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247EA33F5B1
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 22:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787180231; cv=pass; b=rUQczS7GyM5ParB6URG9fFx9YZPF85x0vuJ1JGJokCMODFiOZzO8dj20jDRN1c64tjfKhKMaAIQMhS+HheshaYhVHx2zt9212SoX8Mr4MxDvgq4LR5rsMVWPuHjTXQZpq3GJDDN8digo/ZqkmzjLExMSWpK2ktKhkdfeJJJdEuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787180231; c=relaxed/simple;
	bh=56f5z3ZuOtcdJrvOFqT/D5zKUzzIQFafMH7pT7R3B88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQ0mz9K+//rGAwaa2tnhz5Z7ud9ncBYERLhPp4x1Lu2r00rM3vIDKOnsiy2dgoKQQUZ1qNJDR5iQPOepRfxEI5u3ooXPtz6CzagK6cQR2r4yFTHeQ/gmwpgKfi8bqTHcJFYzKwzIMz0owwaMOsOdeyajYngFTeZ1f+1p9f25t7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtwU1Ps1; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtwU1Ps1"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84e507b079dso968078b3a.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 15:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787180229; cv=none;
        d=google.com; s=arc-20260327;
        b=EM0vqcepOUmacFGpGNMHHgDfUA4KLxIaFYMmUSkRq+3isQsjnhRgQTm/WQdHIDxwCL
         VqfIPnwur+pgPxOD1rk1Cc7MohKWqXm9aXEDYV/aR4nzVYKykjYPNQxNfzFM1C1jhgOp
         GyejnViaL7J8XA7sHxH6aUa/g3Ga+wbMW41OyFk7q9gTHjfzkht2XAXXrZ1oDGMgc94O
         kIxb5a+a4LIVmgXjgBylDrfe1Or/UIGb2xQiX9MVX/iv6euso4615OiDZK7ShawqroXi
         LFV/RM4dcE2al9HbISLr5VO/5V+W50mGpOADPEz9BHQYh5o88J04LZrkx4BqBrjhQCok
         TcXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BgdNmINPb/gPaqISSDFUmxMArGTonC0lusN7G4Dov08=;
        fh=PYuWHGpNKYgtuxnRlPWEQ1SvyHlzlzZLKBUqq7rqiAk=;
        b=jDlLWNhR3zKJnbt3efpoZl6BZTVP1ofn/+/w3wDoTjsz4MrM6UXez6BN2zh0b3/Ax1
         MZHrnVFYp3eYlPqIKTW7odkIE1liUkdkYcMRl/8CitZuf2ZuBEgCkFEfOgHhla8TsoiG
         plbJq07t4SgSqawh4a9DwJvtNh5SwDcc5kU7OxDx413ytC0m/50FWTkF5sadOLsZ8z/5
         KighDrFNheWQG/6/nO71cXgZ01pygncftKaIYq1aXDvC6MqHqhmenD/C+DIYbzB/RPSR
         dHzc7O3sk62AfrEjNhf/dFD8tC2n3WBI270VNW+JjrHrK9b2esllb6HEIpikUaHb0uQK
         KjuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787180229; x=1787785029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BgdNmINPb/gPaqISSDFUmxMArGTonC0lusN7G4Dov08=;
        b=mtwU1Ps1D/ct9xG/tX9ID9NeV+8dOt5XG8QSwpNrmnB7w7pMvwQsZJ65K09d0ACEBh
         Q2dHv7QwSgwA0q69X+wcS8qjXVMpGi1sPCrBlB8jB7MKTw3xu4vsqjuImQIvow+qYcF3
         IAD5UwT6Ig+phCdtwzryOvWNx4n+ZAl2lEU/ud6xQ0kinrSvO9nHKaojxFqTJQycfnHj
         p25Nln0h0PAs0R/gCUwdLzpDvJYE0Gl77zFeWufACf8S4tVeLJI8RRTxbGKx9YpJmT48
         hayQgPq5Fs/QzgT0pGuThBDjdcqecNAOOf50O1ZZqUsYfY+KyeFqIKURokeGc7xzmy5L
         UypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787180229; x=1787785029;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BgdNmINPb/gPaqISSDFUmxMArGTonC0lusN7G4Dov08=;
        b=VQrNi0LEAWsoeQWCT0RdVhUOdyVmWJStpG45x4WSNKLno7wQAvygjE5b8xV6gL4QxT
         jajI+hXwzdBRPBy/LuByC4yc4/oql2YDUtpW8sTx/gnXu9X41KBoG0mIZW3eIg6/KF9G
         jM9sUPtwWudE7QS3Uup7Rst+f2BCv8Tx+TJtkuBXhLLU5f9OE10CQm/5PVRbYbPMTPjR
         gDRkzYlxUlSwcEUby3CSoU4vN8dtDJedkFNu9lIiarj80xaer12zlrIW1xwldcLzcVG1
         YbvonIoPFx/CtglhVqmAdhltbs8HCiEr2Cj9cT/KLTrCdTx9FoaWhYowUwsP2U8jlb/c
         tk3A==
X-Forwarded-Encrypted: i=1; AHgh+Rp2d69Z9Nx+2WD06zyZmdrDY0Vp9J21JlbGzJ1deF7/KNzBA1tx10/Fg09rg99TRiV6H2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc361ZarMPgA53o+FCL6nqa/DvbC7x/TNdUaNAWJfEjIFp5aZ6
	atOqpPk5xDDnEMOMfI+Ou+pfUhhFmXsLEGGWhp2FQL4czppfFmjvvii3hoPwUwMdj5bgjHoqSAn
	/6pknR9x8ayKXPlZ6uBMRQOvfRmAtyFs=
X-Gm-Gg: AR+sD10bbZLrq04RkOsFA4KweCZoX4p9re6kOERnjURc6ZpWlwf47nCxpcuuRKbPQbR
	OvfZY2vsQSqzO1HPSdobSFCganSDKOA/uRPI/1NpDUuOulbV1u9zgPm/QA/Q6Xrxj5ByjKRwkgD
	dh3fJwMu4hQ+wAA5t9/8MrvHnj/vhCGavTJilVVZVq342CrRPO5B0nP0G3caH9R4DrlA+6YO2kQ
	ao4kC9C8rT/eu4ZgoLyS8AocPDB7yMLuKd9Rn4xPPW8xqUt13p03ZClAAhCxVdKHFxyLl06mx3K
	53Luk/t2Jv+caVoAwA2X87VuFsGtjhHuppOjoBvA+1m/gzIcO0yqTfHdebYlRoU0dyrnuk3KKx/
	KUseG7XQG5lMTkamZXiz6/UN0l7aRvyxkOC4osQY0WWxrQfiSoIKh7C4qNgxqwJIHi29FeUpqEv
	YT00XI+OHQ3xbo4rp6J+M=
X-Received: by 2002:a05:6a00:4197:b0:84e:216d:7e52 with SMTP id
 d2e1a72fcca58-851d3a6e118mr13172048b3a.14.1787180229171; Wed, 19 Aug 2026
 15:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786103607.git.ben.knoble@gmail.com> <cover.1787065125.git.ben.knoble@gmail.com>
 <48fceb4b575ca39346cf2f59f621584a19049008.1787065125.git.ben.knoble@gmail.com>
 <aoVoJ3Ijoaj3u64e@pks.im> <xmqq8q62w0gf.fsf@gitster.g>
In-Reply-To: <xmqq8q62w0gf.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 19 Aug 2026 18:56:57 -0400
X-Gm-Features: AcwNN1XTah2u3ep-u6P62nN6YWyrYeXR3mBWjrnhZuhnQqSH574RPS0jpcJz6xM
Message-ID: <CALnO6CBmJ3AyaSmHNmOm=aKC5Atp+VWGRTxCpN=ztmvU_xbBMA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>, 
	Tian Yuchen <cat@malon.dev>, Olamide Caleb Bello <belkid98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 12:15=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> >> diff --git a/environment.c b/environment.c
> >> index 6676e6f5ae..c7f6b801f4 100644
> >> --- a/environment.c
> >> +++ b/environment.c
> >> @@ -571,6 +571,13 @@ int git_default_core_config(const char *var, cons=
t char *value,
> >>              return 0;
> >>      }
> >>
> >> +#ifndef NO_NSEC
> >> +    if (!strcmp(var, "core.usenanosec")) {
> >> +            cfg->use_nanosec =3D git_config_bool(var, value);
> >> +            return 0;
> >> +    }
> >> +#endif
> >
> > Do we want to omit a warning in case the config is enabled and we have
> > NO_SEC set? Or would that be too obnoxious?
>
> Those who use a $HOME/.gitconfig shared across two machines with
> different builds would be annoyed with one of them constantly
> complaining, I am afraid.

Ah, that reminds me; my shared ~/.gitconfig includes a "site-local"
config path, which could then be used to set this option (or not) only
where supported.

--=20
D. Ben Knoble
