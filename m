Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469653976B8
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786121618; cv=pass; b=B6ZXTpTyAX1Vx168hvn6/6vjVBXr3KJ5vdGFt8YLURA8gNl4oR/NucwkvVDF83CaHM2FKt88hQzAIO18itAwT/a1kCPVeQH2CHttaXjfAx+VfMESuFMK/15FT4JijrGDlJ++Z62n0KS6905cZ2GNvuAmLzex5He5KuoR6NSlX1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786121618; c=relaxed/simple;
	bh=t7E2TJqfwlkAgorRfpHtqVCUpiaAWgQHYoGxY09z65E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYkKr2dRxg4m1+L8fx3AGb7+pMhoe7+jYb3E9Kl8AcWqZwHIeKO45ru/mhmgDX3hVXf7+l4RieYkg2cfh3OczBnob11TaSo+b/0nKK0fP93DB00LmnE39vWubD9mQfNI5hJrW3epmsuh9tOzp2P4V//1/ypERLZOdqBPVrYra+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liZO86Gn; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liZO86Gn"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-448cf99c133so2381049fac.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 09:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786121616; cv=none;
        d=google.com; s=arc-20260327;
        b=FP+N8DihHc10Qin075OqrRAnHDEB6MfnCV00Hx7EYT3mFinuMROyeIKlEvgkQEIQMn
         vxjSkvQ0OUEP/8XwuqgvDgkVJo3kjk3WMzmFmgRJSnOzmQnK0T+e7b/vRVV5xgP7Z9ph
         +ZlqjuPHnbG/r9Qf6gwwBgxakJBjFzSUgUivdfl2GLX7hIZOH8+yx8OBFLwiY8EsJd0V
         Ny6OKcHSlc3cFjYvvvGdS/2u/0qgfXGCGCXLgXMkVY0O9EeVsk9+wfybIz4PihAXBqQe
         mk+obhbQImTzM9IPSspjSEm+CsXq8jvQXtI4KIdnESBSoL17lj3Uom2osPE9f88L/328
         Jjeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6946SitJlk3ReTd24uVh93LaKXukOTfYHZq0LJc1/zc=;
        fh=K+nwAsTgvJIY4kMWVokCW6lJIm9qzCyizIjWP69oThQ=;
        b=SpE3F6ZJL917/qdoDdCvNg3gz9OctIc7vpNPF6rQ6n/bGqjshA6PA7TXmUKmP8BMrv
         p9xuWMQy2pHC2d+ys0xtrxNV2VypqU7ob2r1eNrNa1PE6oUu9dgwEuGYPw8upO0JmIgN
         gOjdne035A7daYF8qBotgTnbT6WPG9qDfH98R+8CD9avfqMWWlsdmbYmGP0qL6DfGjc+
         JXDpwS2kgLEy/A7v2WRqXon8Xa+rsdLfGq3Y9FsyQ1sGJ4rvxeBJdtH5GrI84EKuMMJI
         HJlnDvaBYXC1G96u1uje0aYSQywkK7QqN0L0C3kLpbPdC32yoM++mfaY4pxloaKHkylj
         7SuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786121616; x=1786726416; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6946SitJlk3ReTd24uVh93LaKXukOTfYHZq0LJc1/zc=;
        b=liZO86GnuvORFP2sthTXN2WZqNynPqEd1tzEEuPj9OTTEjG+H5lQ4RQw7WpQicgFx6
         /j/5CsJ/Y1jCQ5p3kmz1Cex28E+fWkP+T/g8RuvQw2iJ9Y9iufcnxPLXEAMNSSRLofaB
         d5p5Mm3TzJ90wbBUfLMBeHZbOaK0QY+zRTE21ehdvsGcn3RpdVKHkcdxp4jbimbIaO+m
         jIng1MCxBGfEHkSNnLUdhmBhYrWr2bBOiewholc0V/tXf7zb1uLSRD8vx0wwwDYv71G4
         B5cYgYkruQlUOwJh+4eLjwJ7wPOaJaTtU6Bogx1WCMlKgUbE/CX6zWW0W084QMeEUvbT
         5w3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786121616; x=1786726416;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6946SitJlk3ReTd24uVh93LaKXukOTfYHZq0LJc1/zc=;
        b=ekTSOXtQgESbiCIXn8df+EYK/ifO7tMqZf/UeHbPipz9wTocrE6C54DGar8Kmw4M0R
         Yy/MZcZRYiW7TcbwcyvrlGp3xVM+TL22j9XDzDYFCc2CrqVpFNwbAn77dGP0KvVPSKBO
         bndBy2W6cFt1sIwydcuVkjFzVMksoZbUJeEiLfRB1jBFvl55K2C7RO4gEdoLaZr7J2W5
         MH90l5GNjr92c0NT/4bjTrAgAQ4gEQx+dn8mDtt3iOjqq1fM4X2JRcHszSd0rL1Be8Fo
         gA4RlL+3KWRHbD8bXOfZTG0h1jT0LplC81VhT2/rHLsEqr/I4FDwzvJSUWWtI6iDa8q2
         pAQw==
X-Gm-Message-State: AOJu0Yy0ULEDBvU7nceiEvMC9a+etWWoKIQjgRaCZ20YOSQhpxWWK+Vn
	/beO2eXxrz+Jv5+/r2FeSXSj8s/iebNFVc+0W3sxTn6FOlbFoRi8Bw/6eWdaIGLJpxZOY+W2wif
	holvFpVQ9DtLp5Gyfp7loNOD4GWSIAq8=
X-Gm-Gg: AR+sD13Aphfz1UQSSNPavJjgxjiDB+YNvVlLTy6OLxP0UDZhCywBDnlZ3y3deoEhXzy
	+4vpwNgCi/+ISkKhoj/sAi4CBBhf7IM7dAbdRRPhvck684gWtm33lQT788PPeLIKKoeYOkNOfSd
	YgOcJV8tpd54iQhvTQG0E62jZGUnlGDwpphiKVJM9uJxV86rjZ0taJ8M4vJHMZrBs8mvLO9TJ0G
	OdMN8tZLH2bgNXcV2nX995yeAsCEU8xX8zdb+Hw+iKr7YGUSdbk9vQZsBR6sZOJCrPGyO4r2ei0
	lrpKJa5GFMqij8URcAuLLJbdHq1uMxv7TxHRqKdOW/M+HE9Hadg0mCfkYwvHqljytWOUTi6/pQC
	jqN+cJQ9QeEwlFDwdlYNRAcmOJDJMaRNhnzcaso3Qbj8GUO3NW6dLvs0mSSMhSyg=
X-Received: by 2002:a05:6820:290b:b0:6aa:e367:a3e2 with SMTP id
 006d021491bc7-6aeb24fa433mr8673594eaf.19.1786121615911; Fri, 07 Aug 2026
 09:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcxw010me.fsf@gitster.g> <20260807161956.1004889-1-gitster@pobox.com>
In-Reply-To: <20260807161956.1004889-1-gitster@pobox.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 7 Aug 2026 09:53:24 -0700
X-Gm-Features: AUfX_myjjg5UZYkfIVmk_He3Y0g7KlkNqCBTSLTRxGMXJYICB593WhPl4N9xwQU
Message-ID: <CABPp-BFdwxTvkcWKNP0-Lk+mqQLnULoYuLHZe0aot4VYfHnjSw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] completion of 'git [-C <dir>] diff'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>, 
	Britton Leo Kerin <britton.kerin@gmail.com>, =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, "D. Ben Knoble" <ben.knoble@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 9:19=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> The primary motivation for this topic is that the command-line
> completion of 'git diff' does not handle paths (unlike 'git status'
> and 'git add') and instead relies on the default behavior of Bash
> command-line completion, which completes files in $PWD; this does
> not work at all with the '-C <directory>' option.
>
> This series teaches the completion machinery to complete revisions
> (unless '--' exists), then tracked paths, and then untracked paths,
> before letting the Bash default kick in.  This way, we correctly
> complete 'git diff' command line even when '-C <directory>' is in
> effect.
>
> The v5 iteration addresses two points identified by Elijah in v4.
> Hopefully this will be the "small and final" reroll.

Looks good to me!
