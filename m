Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700A61CDFC1
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736891851; cv=none; b=YLZNNsHOKI8na+2a54kD77R26GcUSMIeQ6r0ierKU/HFw/HzIZBwcJzfZ9lCOvNfPSupbzKNApWS3OLBqv4SyGbdYlNyPZGZfLkU7LvQlClAPJa+KMWwTPpoWljRq2tz+5T24bbm85EIG1qhE0Xse+AnRiJMhO+LiA8tb85iwuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736891851; c=relaxed/simple;
	bh=eu+fkamJl3daDQu7nVzxo0rvTgjUxhZe8m/MVM4S3SE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSqSCZIkLtL3kII4maKctUcIaZji8FPHJPWJvKb3xScF0If138U5yRcTQnxVxFLniaTz+WwAZ0qH8gIoqPkAdDY4yXpQvsKdtsHHS3eW843US+BHP1S48tXRrSynXWfvr91uLEGS+FMD3jtGgh9uvLF99wG1rvI+YV89CHJr4zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbtL5PjC; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbtL5PjC"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aafc9d75f8bso1155359666b.2
        for <git@vger.kernel.org>; Tue, 14 Jan 2025 13:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736891848; x=1737496648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFoSvTuGUcgalhMtkYtYr/w5JjETkOnhHteQEWuuOcg=;
        b=TbtL5PjC+L1Gmf9ELqp8Fm1fWOd8D+JYHO70mywyj7MXlBfm5umzWsdBRWSyZ+aNqz
         cCfmioGBlI3+vt5C1QbwbdiJ70D/U2ZENbfTgu00pxINwpHDtcKQfnAeq7ZbPgQQmpEr
         Ri8MLwcd8tSNb3bm1LS8NpHkb8riGwqyekyDSa1khkoOnlJ7f6kD3QY8aFcgYH3xQRiK
         io7OkKbSYimW13vjgRw/1yuaMJKzJ7FheDehwf8P+1n1ZjdetoAOYIAO/l6Rml3rMnrr
         i22cU4MLFtNXpHNa5dnV4DEM83BGrMrjhjDjh9egQyv3Fe6srhFdVQlN+bPhCRwIDJhO
         tRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736891848; x=1737496648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFoSvTuGUcgalhMtkYtYr/w5JjETkOnhHteQEWuuOcg=;
        b=pewrMjn6F8B0GuziN+8fDrgNN2HuHq7XG6uLCXd+g8hQmr1pwPNHvSUltUdsHAJVhM
         zfOXfokgEJ+V2+PoWuK057ZZxBRdtOooDzok4ZVb8RFLTO1+pZRAQ9PGiZqpbp1dJZSP
         0Hib1QVKGtV3TEa9PACBr/Sp/mAKdLGkOwMUY9rW8JwZscTD47884d2275BEN/emKwYw
         SXiNDi7NxCgvxVtUIPMnm8qN3Cacy0h+tN/WbmUy9HENoSacD0rymIyRqprgYm/Iizan
         rM5wUEoHqHheMayiSOqaKpa80ednhFX4BLEdWvz9HQGrApb+M7pWREZpWgEruVhtHNLq
         2pIQ==
X-Gm-Message-State: AOJu0YwB1KoXfD9p5gJG+47tJ26/va6VSvGiAiddIwv7pG+yIpWzLleI
	E7b/lJGatVrtumIzzCs5/7LnXPwj79gAlDLElPnJa9y6FVnBKIO7nffYjVhEvrtAqZU3EEHV1q9
	y6XZQWDXGN/akTs8x+Rtnrp5HtKCOIIlp
X-Gm-Gg: ASbGncsPKJUj5VEtVhT/ldrRGiSsMyHkiyMERiCSkMwFE2rLziSME/B0Yw59oCnkeQA
	/2bXWdzMVuUD+yDFYZFkH2y0PFNb3O0gKilA+ndYtRtWkvrXjHh6LvX+HVAWhasvu0pUytw==
X-Google-Smtp-Source: AGHT+IE72NnHFEuSA4xPld50eaK6UPIT0186naoeNPGjHR1z46GQm7yX30yA1rb/XRMyIt6Z6EHbbl5wWl7uFaWeO3k=
X-Received: by 2002:a17:906:c156:b0:ab2:faed:e305 with SMTP id
 a640c23a62f3a-ab2faedf8bbmr1153944866b.10.1736891847526; Tue, 14 Jan 2025
 13:57:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <C2871318-4745-4481-9199-72D4544ECD5C@gmail.com>
In-Reply-To: <C2871318-4745-4481-9199-72D4544ECD5C@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 14 Jan 2025 16:57:16 -0500
X-Gm-Features: AbW1kvaLMlDicIA0ePC4XZxh2sYQEi6ETgWo_guZIVUUTUGLCvCRIHi7RNEYE2U
Message-ID: <CALnO6CD35K9O=Wgotij1SiY=N50WiCODY5i-_gBBcGgD73CPjw@mail.gmail.com>
Subject: Re: Bug report - Apple git
To: =?UTF-8?Q?Andr=C3=A9_de_Castro?= <aramosdecastro@gmail.com>
Cc: git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 9:23=E2=80=AFAM Andr=C3=A9 de Castro
<aramosdecastro@gmail.com> wrote:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> Checked out a branch, ran "git diff --merge-base <some-annotated-tag> HEA=
D".
>
> What did you expect to happen? (Expected behavior)
> To see a normal git diff output.
>
> What happened instead? (Actual behavior)
> Didn't get a diff output. Got the following error instead:
> "fatal: --merge-base only works with commits"
>
> What's different between what you expected and what actually happened?
> I didn't get the expected diff output and got an error message instead.
>
> Anything else you want to add:
> Seems it happens when I use a tag as one of the commits for git diff
> --merge-base. This is on a macOS, with apple git.
> On Windows, with Git Bash, it works as expected.
>
> I can get this to work with "git diff --merge-base $(git rev-list -n 1
> <some-annotated-tag>) HEAD".

A shorter workaround is probably "git diff --merge-base
<your-tag>^{commit} HEAD" (this is the "peeling" that Kristoffer
references)

>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.39.5 (Apple Git-154)
> cpu: arm64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Darwin 24.2.0 Darwin Kernel Version 24.2.0: Fri Dec  6 18:56:34 PS=
T 2024; root:xnu-11215.61.5~2/RELEASE_ARM64_T6020 arm64
> compiler info: clang: 16.0.0 (clang-1600.0.26.6)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
>
>
> [Enabled Hooks]
> pre-push
>
>


--=20
D. Ben Knoble
