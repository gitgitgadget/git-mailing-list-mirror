Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C9311948
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561834; cv=none; b=G2OB7TSUZsaCm5TdeFdk3nhVA2c4LZkOAkoOJNMiZzinerVCNrinh7z2K4XIZEcWoKehS1I8FEzacD219t8byEuOIVY2KxAZoPe1ex1NXKMWP75HZ/SjdkDewLmvM/a/oKxBt7aMhYYGvYlP0Rp2Y/OJ6gQHSE2RN4XzANuUPa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561834; c=relaxed/simple;
	bh=lbBo2Smuazd7clwzo+wz0IUcJNZLPyec/YSPE/vrh7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cR7HgJ4o3N7rbyvAA74s/o8tug4UuVkr+fTRDLNxojr+7a8VyMR078QRJljWP1oPoOvH+yilU/TYxQiAnlsWEy5HQovCNNMvGLadjDBrNlm5bqvqrgfrehgy618UbyHIypFVT/rCvW+VSiQrj44Lwykz7+U/SM3/EmSfSgUBR6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jN0wRDZU; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jN0wRDZU"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-36639c30bb7so25488611fa.3
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758561831; x=1759166631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkrluKOCb5j7YaVEaDbWnUqMSTip23nIZX0J/sEKSfY=;
        b=jN0wRDZUfAaU/Non2HYmWriFG1+39FZRuYLQY8rW6V4Ys3y/0QL30l/s4tiy/J4wYu
         cW6SfOJr1uguhhkm1Vxy+5ymQ02PQmg9fYnGpZIN1s9WAk2qsDlG5aQ7dECc7kwDwRDd
         gQYVXgkya1pFSgq1wPxCxWXS17aIuV/nyN/IYvNwTSA+wElRXCupz2ZFiPqP4rw0vHhv
         G5+AGYYhdqj5CJwLrcNgaA5dE5aJMcv4qHFO6KGHATyvfNX3Gfi16AzlaCXlY5niYADt
         8sItum+fpoOk+j/P4ug+XHDBNDYQah9hQ0C5jAau7mhNgfoN5IZ17WLtJ2b9JZ7lBgml
         TFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758561831; x=1759166631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkrluKOCb5j7YaVEaDbWnUqMSTip23nIZX0J/sEKSfY=;
        b=CY/R9/AWygHQPxH55j+YAiFzWJcrK0+kHEafalRy8gR3BchBYXEdZuSEsYvkecaGdx
         Ppt/nQg+O+5xDaNDSQwgeQIUmk3JRw4kdn6saHMFNiPK794kom29i7B46YoStznx/3YD
         Acq5j4f1EWqlHXfUcfSxCMaINN1FOLew1b5LnJqc4BDkaSDy9ZDpCStcUSIKFX5NnXp9
         5NdzqlL1Y/0qBjBXYJvcUttZJB+TpeK5bJcQjZU0C+po/yQ7u/SmzSc0FoAdAXNotkOl
         Uxc9CUC6Q/+b15Cnp+YrkzUviT93NopTYCnSiCSrd8OoPp5j4cMQ0BYZrUl/5UR0euHD
         kGQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgTN51N9+W5oAWDuQZ11WwLqOVjkf2gmHI4P6SRLztxvbRiOJd+b7Vk+tphwlLBSRTfro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB23zrMskqb5Vlf/M3Dk/QyZdsKmwP5YEx3kSL0ttLMmBeNzCT
	1elxKUmlI0hfehsfyxAgNAhHhGJboV86cCEbdZqVH2QsC285xlAIR3K1R8hoFakasmhYah70N8Y
	39iN/gWNGzSBMgRb1VCr9EnTj8eLCEGHs1Yfu8mc=
X-Gm-Gg: ASbGncugBF3nxV57PE9t0A0VOU9voX2e6sN82tNcIR8tWqAI6I+5lZPbuCZP26jv3p1
	9g5bnaIiCWc/PSo1B11whs9lEnceXOsihNy0TmTSVL84QbMzhhkFGcRZ1IZQLxfGh5pfQlIv4g0
	FYDmRo4xXNPYsErH4O3lJpAUZ5yPAFx+dph8UnGDjlSAPgnfg/S89DhQ2TnVTmhKq4tISe2SZPa
	9ay3/43
X-Google-Smtp-Source: AGHT+IGSTs/XmfiScqvV0ZKkwzMH32Xdd0M78pbxhlAwsB/DlQPtDmBFSQCn1DK6oTgpV97Dh2s4gpmmAjjF0erjwNo=
X-Received: by 2002:a2e:be2b:0:b0:355:8c28:898f with SMTP id
 38308e7fff4ca-36419b57b29mr37651601fa.44.1758561830476; Mon, 22 Sep 2025
 10:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <aMpODEpyaaVhFMO0@pks.im>
 <CAH=ZcbBNFSwU7E+P7hkQnt9UrMKiCRESgGvWPL7pRUa0i2U5-Q@mail.gmail.com>
 <aNFIozagGc0MoseL@pks.im> <CAH=ZcbCZXavx52521cFHdXZn=BCWBiR1aG10ekZVg3PVVJb2VA@mail.gmail.com>
 <xmqqikhav3i0.fsf@gitster.g>
In-Reply-To: <xmqqikhav3i0.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 22 Sep 2025 11:23:39 -0600
X-Gm-Features: AS18NWB4_VDvGvV8RVak4zZkP2_0E1PwNzm6YBTLzINM8bJAwoipOil06tlHO-4
Message-ID: <CAH=ZcbCsKdZAPxBEPUMvE471ogTNptjFy7FFksWnJfnX=J-F2A@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 10:47=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> Ezekiel Newren <ezekielnewren@gmail.com> writes:
>
> >> > I wanted feedback on:
> >> >   * Cleaning up Rust type name collisions
> >> >   * People don't like it, so I'll drop that
> >>
> >> I don't have a strong opinion on this. If it creates issues I personal=
ly
> >> don't mind fixing it.
> >
> > Junio doesn't like it, so I'm not going to do it.
>
> It was not "I do not like u16 as a typename when a perfectly well
> established uint16_t is available", though.
>
> It was more about asking to explain the reason behind insisting to
> use u(8|16|32|64) types in C code.  Perhaps there is a compelling
> reason to do so that I was missing.

I listed 5 reasons in my commit message[1], and I just thought of
another one now.
  * Pseudo reserved keywords: 'new' is not a reserved keyword in C,
but Git treats it as such. Since Rust will likely be added to Git, the
Rust primitive types should also be treated as reserved keywords.
Cbindgen parse's Rust and generates C header files; If a field in a
struct uses u16 as the name then Rust won't compile, and cbindgen
can't create the C header file. Using [ui](8|16|32|64|size) as the
type in C also spreads awareness that those are reserved keywords and
should not be used as variable names.

If these 6 reasons are not enough to explain why we should be using
the Rust primitive type names in C, then please explain how it is
insufficient.

> I know that the kernel has used these types for a long time, but
> that way predates their more recent flirt with Rust.  If your answer
> was "the kernel uses them", then I'd want that answer to cover a few
> additional questions, like
>
>  - Have they benefited from their use of u(8|16|32|64) when they
>    started working with Rust and if so how?

I did not know this.

[1] https://lore.kernel.org/git/2a7d5b05c18d4a96f1905b7043d47c62d367cd2a.17=
57274320.git.gitgitgadget@gmail.com/
