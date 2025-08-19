Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9559926C39B
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596189; cv=none; b=E7cKW3mHnPluaCrHkI7L1k1Y40LpjY4WFN44ZAiTq/hhmAkTT79IT0jEDCbNeOlx92OT2v8HyYKYe6jKtt9ZFkXhevAoc7t40Td/8RO/rIgdpnoDa7MxNy0SiPVI3b/TLfqL7mbjvmWWhhr3zWc/PuNgrPC64f1xFnG9tDuOnI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596189; c=relaxed/simple;
	bh=92iAg2SRd6QSZiXvfLdxHJij7AxNiSKSa7Lccot3L9E=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdfJAGwPRoAds7sXq4PA1+dR3H6FffmtaVIOfhg+0rS+k1RpQmpc6JPlipy9LyjvH5HqANX+aACPGDsxub1bKzIyfHWcY9PfnqtpbZdf/m4/nxMCao5dpLPuckB9F0jfbGVs7i1Pw5Ax+ttPqVjbhgV3UBW8iuyfk0FS9qg8XbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c88blXOE; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c88blXOE"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-53b17194b1eso4105044e0c.0
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 02:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755596186; x=1756200986; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=l9uY69sOP7zBa39eGl3pm21oCmi6Jb3xNZG0u+bEzR0=;
        b=c88blXOE6bKKZVGFMR37p1SN8wywRB2JV0LV9Y9z1loW6toeGOtD28hsoecBDnTPzf
         ht9E6CjEdmB3sQfTXHBFmX7lJHnjBUMoJk0LH3vrIN8Vth1ehbsRmFBwzrmUdGwhH+7k
         whdcaxfjmNMzR0L5f/STvjdUD6C37oyaO6F7IUs3oWF7ifX4lC4cbF+38L6UTada5OVZ
         7SXx0ltETtRO8q+K6Kli4gRgJXorwMxI/MjiwrYL6urfNqYz6auMPA7AZVK+fn4LWZCw
         L4VZPqQgCHxpVQcnJCf6VgQSDG7ctSOq6f/KhMOWA7FVqYoVYoH41P5c1BlmbpuEeD57
         Byrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596186; x=1756200986;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9uY69sOP7zBa39eGl3pm21oCmi6Jb3xNZG0u+bEzR0=;
        b=Y2Q0ktBprMV8cjN+xU6wGPG7ZR+ic/JAJJeQ9XUoLJA7vaYumnjDY4bKK2ZcY1p2O4
         Uq5nwtg106OcsHwPjGMcl+PcVdYJugiGUQiSk9n3A8S5XQ2rl9aeTG5mwZqSKao7RzOG
         jO7vj4p5hDTEXgy72yXQIFWfBwR3PxtOV64zns6kznBh1tzPi0S+g9AFk/MfysulCuQ9
         0gp4jXpokwg3brGhtxLWkvk4iItcrOjpQ1W4VEtSrY0OvzT2Bt8oUpxhP7UHNSnxHEqq
         oKe4+R+ZdFeiB+Iygw2m+YXTQMiBtXxhGrMM8gwNbeQ858Z2vH5i4RhMwabWM11O7OhB
         QqDg==
X-Forwarded-Encrypted: i=1; AJvYcCWkjdF8HxFSeR2kr05e+iFHsnRuKM6VhJQuoK7E+YRwtsX722F1wTpIuUP5bS0+lRapqoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHYTEwGciMcobEnHCuE0jh0/7acC2oa25hcI06ZmpMiLjuT448
	bB9CXUFb+XNSJEOJ5JpP6sYa+eyMMi25yDPfCmtNmu/FdmfunldWrbkfnJ0uzoeOIdw8k/nsaPh
	XaMzHeuIbzzK+ssQuUWlubxSaSUH82M7KBw==
X-Gm-Gg: ASbGncuTtiPTKfx0DcZUhqTlD18IlCtuP+O33olqnqUR8okerHla9bChbHtf0z7Rzua
	2LiKEK2bU97ILVBLvqKS3yB7IWarv4uvcsOXUMEO6ZAiYssNAkRWsQQcUpcnVSvTcKL63Vlrs8Q
	yKqq1CS5q2/eqVjCHD39FmdWsj/v2dwF+Vkzt5n/ImqnFHCZX6mUHtlZ/We8CpuoPLeq1LgUr1n
	fxsvDcavHK8ME925k8=
X-Google-Smtp-Source: AGHT+IEwFeYTS0bHqOJbjcsrsciw068uuKkRJvG2UPBZX+AujF/Qnw1zHVG9N5ezNRFhEb08tjeUmJg35Xyz6qRzue8=
X-Received: by 2002:a05:6102:370f:b0:4fa:85f:31c0 with SMTP id
 ada2fe7eead31-519241364a0mr472908137.19.1755596186270; Tue, 19 Aug 2025
 02:36:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 Aug 2025 02:36:25 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 Aug 2025 02:36:25 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250819-b4-pks-meson-tcl-tk-v1-1-6bcaff0bc0a0@pks.im>
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im> <20250819-b4-pks-meson-tcl-tk-v1-1-6bcaff0bc0a0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 Aug 2025 02:36:25 -0700
X-Gm-Features: Ac12FXwlyIsa9CPvPbvNgCpbZH4Su4Qp7r3YwHX2zgg5FfpjLK1IKFRxQCZ1IVU
Message-ID: <CAOLa=ZQQoWeYRJLgnjVhonBoBZQLR=VRJXGpRhyanEG=0ewOOw@mail.gmail.com>
Subject: Re: [PATCH 1/3] git-gui: move into "subprojects/"
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>
Content-Type: multipart/mixed; boundary="0000000000000d59b7063cb4978b"

--0000000000000d59b7063cb4978b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The "git-gui" project has recently gained support for being built with
> Meson, but it is not yet wired up in Git's own Meson build instructions.
> "git-gui" itself is wired up as a standalone project, which means that
> we can trivially make it available via `subproject("git-gui")`.
>
> So far the theory. In practice thoguh the `subproject()` function comes

s/thoguh/though

> with a couple of limitations. Most importantly, all subprojects need to
> be contained in the same directory, and that directory cannot be the
> top-level directory of the parent project. Right now we use the default
> subproject directory ("subprojects/") for a couple of fallbacks in case
> some important dependencies couldn't be found.
>
> This means that we cannot just include the "git-gui" directory as a
> subproject as it lives in our root directory. There are three options:
>
>   - We move "git-gui" into "subprojects/". It requires a bit of churn,
>     but should otherwise not have any significant downsides.
>
>   - We create a symlink pointing from "subprojects/git-gui" to the
>     top-level directory. This may not work on Windows.
>
>   - We can create a "git-gui.wrap" file that knows to pull a specific
>     commit from upstream and build it. This would mean that Meson and
>     Makefiles now have different sources of truth for which version of
>     "git-gui" we build.
>
> The first option feels like the most sensible solution. It creates churn
> and requires us to adapt the pull-request workflow a bit. But this
> should be a one-time cost.
>
> In theory we could also rename the "subprojects/" directory by passing
> the "subproject_dir" argument to our `project()` call. But the name
> feels quite fitting for our purpose, as well.
>

Okay makes sense. The most significant changes are in the top three
files and make sense.

[snip]

--0000000000000d59b7063cb4978b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2de3070a0ab9ae7b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pa1JaY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mekFFREFDY05LLytLaVFjTExlMUVGQlkrR2hNLzhtaApqTEw0Z2cwNWt2
d2NoQ28xYTd3MTFzVytobGJVcmdYL3VxSnV0cFIvLzBvZzNTWkx3UHR4ZjZOYUNRM2hQTGR1Cm1q
RzNrcVRHSlAyU1E4VHZqc1J0V0tDaHg4bkRkSlY1MFplSkVSMzU2MytnKzk0UWE4NHMyckxEZGVO
QzA2NTcKSDNnNURLNFlkcXZGNXVtc2xlcUpnS3g3REl1TTdaOEpHcUJSQXJ2MFJ6aW5xeEtoSGVW
bXJXbEUrcEVWSjk0bQpqb05lYXBmM3k0U0c5OUVXVS9xSEttMUtzYUlHcDNDT0xESi9MSVZlS1lz
RllCbk10TGwxZjZROTROT3Fya3RZCnYyRCt4YjZvQW5jRlh5TDBkNHJrSDFMeDJzWTBnSnhQM3la
Q1Iwc1l3Y0p3QUxKaEcyQ3RDbDA5alNSbXF2ODAKR2tZYUpJcXM4cGFJcXlVRGR6dmN4R0tJMW50
aC95bGwwWDhqRDd4TUpNRjQ2QjNrbldhYUlLRUUvTkpUSlozOApxY3g4QjJyWkNuRFk1T2QzRERD
T29tR1FQdUE4a1BsaTZJZjhmVWYrdDcyRjY4aFFzb0RlcXI3d25NYWRSYVNDCmpIcnRSYXZhVmx0
cXRYRGdPMGpkU1VUN0YrcEN2TDBhR0UwbWNidz0KPXBHcmgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000d59b7063cb4978b--
