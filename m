Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D2B1E1031
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067869; cv=none; b=HBZJG+ivd5afSjHVY0t70gszS4Og5HhdRdDEx7DlWPJMs1kaKsd6yNXAFDxZsYpZ7+9AZNx/AshUXp1NXKqHqvgLRJp6yKu65i/vc5KASISBOStH3FyOgkkB38JJ9bB6defZehj5kfxckW3fn0FnBHisl6tV0f0hty+U3eS2L+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067869; c=relaxed/simple;
	bh=7n90Fc4TQefxf7C0CHcpmkSN7ZTdLAwi0meie9GsXro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=YV58xu5vv+9k9ARWrE6ihXOL4nZPYg8wS/0CLz6ujvHBwTSqqMifpXlKT/EWBLNg0VQST/3FGO2q5WrpqhcrbJpyybmBErsoLIeWD62OxWynw0WKfuwpBG/DesmM/Dy4Z6OT9TOexPOD/eBsvnkVHxzeYY0n0YTTxerKQ33G5LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVCnUVXm; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVCnUVXm"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71807ad76a8so1267849a34.0
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 04:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731067867; x=1731672667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7n90Fc4TQefxf7C0CHcpmkSN7ZTdLAwi0meie9GsXro=;
        b=TVCnUVXmkZSG84LiJxaHQL0XDPFmH+PdEJPBhnxvOCkdCgghtAkaGq4zzdExxPwdyc
         H8/MEnkEyzoqe8rcNSfCx4xvYZtXRftWgCR5tPiWSg9CeFsrb48CoGsEUNrn9IlIRX08
         zXdzkDqknfhvLvgdkaJhujbsPLR648HAlW6UxBrgTfA30BAlvu5hOQ9CG2O+X5hynLhy
         T24dpEoEVMBD2kHKodzEyV1FP/j8q0XkCuwqhkl3wrXwSn2Tbnf51SM2PPM1Hkg6sjLJ
         cIdSJefhVzfufDlLA3xNv9f7xlFnK9BjKCDcdmXEFjDBAmcMIvSVpQzWaxXpjx/gXRoh
         gRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731067867; x=1731672667;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7n90Fc4TQefxf7C0CHcpmkSN7ZTdLAwi0meie9GsXro=;
        b=mZbbfO6KoHF817hvd6GyGkHAGqy37nkbAgqvuHZrCklLWria3xoBGC/097utAo8cKu
         EBKHrYjz0zaj/aaQNKcp0Tw6U2A1xFvB9RwOaAVWbIgXal6UOPtDOOX/MggfRvqGQTj3
         3EBae17w7o/8bQKYGoHF3mxLJ7IGA2pbjoPRamvRYgDGzzE/2R95i5aACXMlzQ5nfzD6
         UjsdfdqJiDSHgQdWO30RKXsawnJN654nGUJCs09+sDLny3n0h/8VJeX/RoNrb73zH1wD
         Nwo49FnuFcW/BeF6FktJMH4AWjFTI7f5Uypvx9D452aN4okw/qqZwbN0EUIiRMOSY51R
         TTbA==
X-Gm-Message-State: AOJu0YwIuLLlT9YJtyPbKF3cgFQq9REvz7SzPY7gNmK6ql4mZV78mF99
	wtatNVmbV8yImatLH+CBItSPK/MHS/rqzu4L6L1hfWwbFpuEuMwnH0zvHTfo5Ih482y6atWTInQ
	w/FDpgWN8ZUV0MqtXY8PyuL6S4k4vxvyf
X-Google-Smtp-Source: AGHT+IGP1WN+462BvlXgZjyTxmm1/HRslZWiW/ZExJ7fQKLoNKZmlg6iof1f9qP7TvK0TyB35eKkm4xLOT1+u17G+Xo=
X-Received: by 2002:a05:6358:72a2:b0:1b5:f81c:875f with SMTP id
 e5c5f4694b2df-1c641e73af9mr149557655d.5.1731067867284; Fri, 08 Nov 2024
 04:11:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFBPeVD7pSOZkaCs_sWfhz6A7EWrV1SmLcCxVErK6GEs7KeYbQ@mail.gmail.com>
 <Zy3MdudlGBoFxDan@pks.im>
In-Reply-To: <Zy3MdudlGBoFxDan@pks.im>
From: Evangeline Rome <kolya007.klass@gmail.com>
Date: Fri, 8 Nov 2024 15:10:51 +0300
Message-ID: <CAFBPeVB_TgNrThv3-GKZiqM3oWvswXjPcePaG1tyzgTCPio08Q@mail.gmail.com>
Subject: Re: Crash report: git maintenance start/stop
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 11:32=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, Nov 08, 2024 at 01:24:29AM +0300, Evangeline Rome wrote:
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> >
> > I'm sorry but i can't remember exactly. I learned about cool new featur=
e called
> > maintenance and tried to apply it for every cloned local repo I have
> > using shell scripts. something went wrong. I'm not sure if its my fault
> > or not. I tried to reproduce it:
>
> This very much reads like the report at [1]. If so, the bug has been
> fixed via c1662a00b6 (Merge branch 'ps/maintenance-start-crash-fix',
> 2024-10-18).
>
> Patrick
>
> [1]: https://lore.kernel.org/git/CAG=3DUm+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFW=
YBe4g6HMbe-iA@mail.gmail.com/

Oh, yeah, I tried compiling `next` branch and it works fine there. I
guess I'll have to wait until new git release will be distributed
through Arch Linux repos. Thank you, for pointing me out, and thanks
to the people involved in fixing it! :)

(Patrick, sorry if you get duplicate email, I'm new to mailing lists)
