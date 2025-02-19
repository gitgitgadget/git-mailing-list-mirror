Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3051BC9FB
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953747; cv=none; b=up3BVWbO43FgiUWCfTcFfyVGzzHW17qwQ9v+MEhOIiaB+2gVIqW5cA3alYZOBI3+jCf1v68T+a3zUyRFGJyEG4ijJh5fIIGzibJ8DCqBfpZfhEZzXlXvEJegmB+kamm54NddDHSAmlm5uRwXhTDCiRKZ/opefuY8OiPAIV0bJAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953747; c=relaxed/simple;
	bh=EY5X1lnayPsnYffx4UeX31hvkDKAzZf4pbWfg2a1pj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnCtAUBwa2zKlKPcO0ICAn23Tg9OyuTTlDk71I/sktVLt1/TlyPCW5HmMUz6THVNoPmOvpbSjMKsxyVBP9c4okOft6VIEje/pBM7XKNViOrPtPqRhDjhmR2kwzoh1ZRLnHsnVpZmTQgOSh9jXwkBWn2M1aDFMZ7e3TsB2eT3uKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtE5Jojb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtE5Jojb"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dec996069aso10810126a12.2
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 00:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739953741; x=1740558541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EY5X1lnayPsnYffx4UeX31hvkDKAzZf4pbWfg2a1pj0=;
        b=HtE5JojbRCYhaVMHogcSbD92Peid0NGn6UdVB9RY3qAMXl4gGZLBz2wDGgtgYe4JAR
         BeZgm0WDP/oTK8reaYBMTXLYVDQo0+T+v8FXs75X/VDb9VwYS7NkYy0OoJiNNxq0JKVn
         uUKrCq8oYpog+8l8fefySPlNqum6mZ8JMnhUHM3CLiUrBExgd29YHT2WsX9v5WgJoxoj
         7mxRzACDlnmjqjzAA+pUNkrfwZf6L0EJXWBSYJ8B8PxKbV5F319YLPcbIWqMtJ4qe/xa
         bw3c+T5figfYfj0qpn/2t+yhjRtgJ/oN155z/MYQik/Q0HtGVBLQAQFoP5U5kupw+L75
         x+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739953741; x=1740558541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EY5X1lnayPsnYffx4UeX31hvkDKAzZf4pbWfg2a1pj0=;
        b=MvGMujIKKbsme4mxzivHZCyeKMxtgvf3WT2khfArOjECwEk2KQeAIvDT/zjgYJzL1h
         Q1RD6SCJPkFPAg8KMbI8HhqTZtNS9mdzy6ppBu+Y4RD7Mwem502pzKZ5VngU3zfWT94T
         1uc+Zn++vGaq+AlpvbmHjUPjBzMkT5x7qArtUmdAWQhxqzUCVk6SkTKQAH0cX/V8v3dX
         eyY/vwmMxJRnGQG2VQ1Z7VTEZaEhyrFIRhGov5bRLLmsQzCJVja1S1JDXZUfpQDGvUBb
         7HCujI1RuMopUmK1vxDEXgsxY7kAfqZLUXwcwKvHSzyRCR7TLEcCshcvuXnrhgBV7M98
         4PuQ==
X-Gm-Message-State: AOJu0Yx/DhxhT5Y58GBKK+0mSdF2op2CcFQ+HyX/TYrmgIn+zRTiyCwa
	9qxjjnFHJko0s7MaPGzzoivDnZ1U/ugdDP7qHUPUbIueWulV2I5+15+P+HfUhnXuwbDJdVVWpBl
	qcWE7j/AGInsTw6DwkPWTA0/pu6Y=
X-Gm-Gg: ASbGncsY0Zv0FtpJfy0/RiXhFxCdfzz7M/0YZ/BhxqizNJzxKDqpDlS/jy8+O4TcMv0
	tg0JC5H5e2dq3XDfprljJH/M/l68MYdPy1b5HOAbSMdnhu6u92G++YXiPiXU+9N7MfZia9jcAmJ
	s=
X-Google-Smtp-Source: AGHT+IHnsEykaRy5/5QSn02SJHBxHpbMTkgwMASgRIx5w56IuwK8wlf+fqOfVn1Rp+SvfN5bvrQmBtaKzqqf8BBsD/E=
X-Received: by 2002:a05:6402:34d5:b0:5dc:74f1:8a31 with SMTP id
 4fb4d7f45d1cf-5e089d0b9b1mr2191797a12.26.1739953740241; Wed, 19 Feb 2025
 00:29:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEiLEbOZ7vGE6U69sf5nK+G86zaeAMRTrjaCr=rF2JU1H1p8ww@mail.gmail.com>
In-Reply-To: <CAEiLEbOZ7vGE6U69sf5nK+G86zaeAMRTrjaCr=rF2JU1H1p8ww@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 19 Feb 2025 09:28:48 +0100
X-Gm-Features: AWEUYZnLb3N63UP26r7YOtyQRsHABksg9K0LRrFPSoS_lDR59kpDW8CVRthM43U
Message-ID: <CAP8UFD18tgq6f9N189tn2ZrV5cWU8u34EEpZhkwRosi8qUuhuw@mail.gmail.com>
Subject: Re: Incorrect URL for Release Notes on git-scm
To: Bede Skinner-Vennell <bedesv@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bede,

On Tue, Feb 18, 2025 at 10:28=E2=80=AFPM Bede Skinner-Vennell <bedesv@gmail=
.com> wrote:
>
> Hi Git Community,
>
> The link to the release notes for v2.48.1 on the git-scm downloads
> page doesn't seem to be working.

Thanks for the report, but the git-scm website is managed on GitHub,
not by this mailing list. So you might want to open an issue on:

https://github.com/git/git-scm.com/issues

> It links to: https://raw.githubusercontent.com/git/git/master/Documentati=
on/RelNotes/2.48.1.txt
>
> It looks like the master branch now uses '.adoc' extension since this
> commit: https://github.com/git/git/commit/1f010d6bdf756129db13d1367c888aa=
4153f6d87
>
> Using either of these URLs loads the release notes correctly:
> - https://raw.githubusercontent.com/git/git/v2.48.1/Documentation/RelNote=
s/2.48.1.txt
> - https://raw.githubusercontent.com/git/git/master/Documentation/RelNotes=
/2.48.1.adoc

Thanks for the details. We are transitioning from ".txt" to ".adoc"
for the extension of many of our documentation files and this is
perhaps triggering this issue.

Best,
Christian.
