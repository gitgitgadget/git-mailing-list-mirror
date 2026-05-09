Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A921E49F
	for <git@vger.kernel.org>; Sat,  9 May 2026 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778334903; cv=none; b=WHI3ljoLoec1DiVHyLWofk6mFwvnrUz5NoqKCa7ug+xfT3gcvcz0ieEjrcSxMZjElXYd0l1/3BmVl6KsnEgbOUcFzJ7RgLP4Vz6rDQuv4OELV30uxESukLiIU4FBg/xckV7Mbnhe3vKSfbm87S5QpBAo4CG4PisxfS7UHpTNt7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778334903; c=relaxed/simple;
	bh=xsqpOyJbJGAockRndbd0EFNnZQVjeF2sH04HDboY7y0=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=jLq37k/XaMglLazhxcZ/R+e5qPPCpokXxR1SZd2S/Jwm9uM/cxWk6U5jBc7gJYqHMCFvdENqoDBbeGLnDssWIKExcA47mMOFPBeebCBewdN5cUEGS02TuCrPkuWjxIyFp9KGq1v3w/ajxN4C6l2sC9P51WKcyv3ACwzytzQ4S2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=devthusiastcraft.com; spf=pass smtp.mailfrom=devthusiastcraft.com; dkim=pass (2048-bit key) header.d=devthusiastcraft.com header.i=@devthusiastcraft.com header.b=OazZ3sh4; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=devthusiastcraft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devthusiastcraft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=devthusiastcraft.com header.i=@devthusiastcraft.com header.b="OazZ3sh4"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50e5c7eb565so27973281cf.3
        for <git@vger.kernel.org>; Sat, 09 May 2026 06:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devthusiastcraft.com; s=google; t=1778334901; x=1778939701; darn=vger.kernel.org;
        h=mime-version:date:content-transfer-encoding:subject:to:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xsqpOyJbJGAockRndbd0EFNnZQVjeF2sH04HDboY7y0=;
        b=OazZ3sh4GNFR8uzfo6atlW9aL3Q7sNE+a7Oew2OPbPuMUQD3XbiqNmPJr6FcZ74kEA
         5/+pZSkbI/FSq9F2B8GBkk8RFx04jSds+x9vNyzd2AkM/Ojpc7psIfnzdJDCj93ldh8A
         CacSK+Crc5ARs6ZTTSIb7CnlsUrFOueyEOp94aaV+2ZWhNBBaJc9d+Isqf5oe+e6sRq+
         pgfCZivMlg5V3YDqTWf7bsYBEertvUOV5EBSrOZhu5JwhiOEIGADknp3kTjFnWFnNjDd
         HlOk3yIiBtSZ6FS4qXOcWDxoscEZ+iYR2h2Ar8c1Z318E/MWFua+/xSzYEN0o/ZXFZyl
         /bSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778334901; x=1778939701;
        h=mime-version:date:content-transfer-encoding:subject:to:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsqpOyJbJGAockRndbd0EFNnZQVjeF2sH04HDboY7y0=;
        b=FmWcsQwzbVtRav63E2HvDS4Gk8sAYVzKXfvaCRwN0RqJGtcXFcBgWag1FSEEYsVeni
         JFVCj87PYwsZjj3DtThsAvxjhqCSDJugPPZbI4wMoW/pYg8y05UukWMT29AeuFySgJv/
         hX96DeZuQADdpyVgFaqMYA3vyuR1ia8vOvwbA2Yua1mUcG7AxcQLYz4Ml2H1CPdPZnBX
         vYzOhCHo2Lw5b04KJU1gg3vzWr9dHQ/xSMxU70R9ToUseQ3BtLRUBQXU/5j9HJxRG1RA
         4dUy8RC9i+48VdJj0GNN4Wmlar9UeLVlgMKPXcz+Yu8gXNKjbPGsMm4VsB5Ot2Tj0yhj
         qEDA==
X-Gm-Message-State: AOJu0YyDVHCzNRCTqi6S+2EJYRI5OKbNU7QIwtkZ0/Z4qGuElYViUmBa
	svxSc1gWG3/tKtLDoy+wqsV4Z5ktsrJk8Z2JAemCKFSSt537hleYXVJRCa7/LWXjv087IXx5eCQ
	pXSoSQg==
X-Gm-Gg: Acq92OF0sGJx4yzPVbbK1sioelTba/NFKwge+NWjWb01nGzuewtIi9H4IUuxVZxe04i
	4QDPm29ciEwOkzQpH9mZIdqTjmeIjuYUKUylhmqJYZH1YpsrIXSMjCvqGvgsVWILARC5cq28zPH
	0nRsI9mdb2ASIFjSm5Gj2vd4+cL/qGJ/WUvbaHlHaFUKzOsgBgVKh/hj73LF8ghngVnGcn5s7OI
	wa7s0J6Pg0BNpv0k1/OEZrIR2A5dc5LAbhFYgrrhKyUP/VrzfHJdB+/vDDvsod9BGmFvsGwLJlF
	hQFd/rT69nHSjDK/U/kG+MwGON9LF+sdu4gRJb/CNgv/j7qzqnITz2tfCT/Hg68uE8bX2fcPFFp
	nVwEWz6FV7F5ylJuMYonYo0USfo6vTtlX3s05lY2n/H3tLSNHSXpy5eKIXOdWnMxRHNHEn7LR4w
	frLOG18nnWz4MggbROh4BrMAQ47425Z9teOSUcFjxvnz7/78ugi1Qbg4DPkkLODAsbtrNK4tuc3
	DiRzVJMP6T8mT52XHlQsDy3ySf37szdj28snp83m6Gq9Pex6zY0VFQ5YKsJ3VUHAjnfYA==
X-Received: by 2002:a05:622a:4c:b0:50e:df41:d34 with SMTP id d75a77b69052e-51461f9fc5dmr228625721cf.30.1778334900959;
        Sat, 09 May 2026 06:55:00 -0700 (PDT)
Received: from 019e0d05-2060-7b52-8a61-cce41dbc2e52.local (ec2-54-172-116-142.compute-1.amazonaws.com. [54.172.116.142])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7c0289sm48411811cf.18.2026.05.09.06.55.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 06:55:00 -0700 (PDT)
Message-ID: <019e0d05-2060-7b52-8a61-cce41dbc2e52@devthusiastcraft.com>
X-Mail-Abuse-Inquiries:
 https://app.instantly.ai/privacy/report-abuse/019e0d05-2060-7b52-8a61-cce41dbc2e52
From: Sarah J <sarah.j@devthusiastcraft.com>
To: git@vger.kernel.org
Subject: =?UTF-8?Q?No=C3=B4men=3A_Gifted_Invite_Enclosed_?=
 =?UTF-8?Q?=28Github_Community_Partnership=29?=
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 13:55:00 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hey No=C3=B4men

Annually, we pick engineers from Github, and your GitHub =
profile https://github.com/bnhassin was selected this year.=C2=A0

You're officially invited to a lifetime membership to devthusiast, our =
email newsletter for tech founders that love to tinker. And because we =
selected your profile, it's completely free for you.

Some of what you can expect to find in our daily newsletter:=C2=A0

- Latest in AI: Latest AI news from our inside sources at OpenAI, Anthropic=
 and Google
- VC Radar: The latest tech funding news, before they come out =
on Tech Crunch
- AI Wars, Model Power Rankings: Today=E2=80=99s leaderboard=
 of the top AI models
- Tinker of the Week: One useful open-source tool =
that is flying under the radar=C2=A0

Please respond with =
=E2=80=9Cyes=E2=80=9D to acknowledge receipt of this message, or we will =
have to choose a different profile. Once confirmed you will get your first =
newsletter edition!=C2=A0

Welcome,=C2=A0
Team @ Devthusiast
