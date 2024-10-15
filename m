Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615F41C07C0
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996337; cv=none; b=a1lXAhbSFMspPefBc/R/l3xTHclzrfibAOK9Yg6hhZdWrc3+rGnQTeMaTE7MRzmLX5FT4xNucgquc9yB1kpDxesGB9C+KpVvNtMcD7WEUp1NycUDeQLhxaXQB0MMXM+luz2sGmFP141Cy3BQ3NWX8jCfnZdStDxeoRBTffaZRDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996337; c=relaxed/simple;
	bh=32W9uSD8O8vaQJgYtf8QgSCr7bsWB+HAeEs0r4wXDpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fi//sOrChessXXva5l8JI81iO++soMyAbWUXTLHDawVzq/MqFyG17hcBJcrXK/9w+2GnU/lyUzXc4SFFA/yPEXWV390nE4cDr+B2bXeLFNjbdzcARyTuEsgSglnj1xqlaPiuoCQb5t2Q63BF/+ZymW6SSHgNeLeN3t3HSOdobXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsU73lsi; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsU73lsi"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c957d8bce2so2726953a12.2
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 05:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728996334; x=1729601134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32W9uSD8O8vaQJgYtf8QgSCr7bsWB+HAeEs0r4wXDpc=;
        b=XsU73lsieuJS75B4OrPVd7C/k4Yn+Ko6jU/MGqXKd1Uxdf20e5sAeQTOZBZqQB5Dl4
         nckDgC2B4HKkS7Uacksp5LHu3g+FhMgHEHAqTzRJ073oG7WeU86y/I3w2m/9E8uLerLV
         29bcxAeKr2w9bzC0bjw+/E6VllWzev8BMZjHLMt084ub8PGwXRjuTEfFqtAHItaF2ShZ
         jqno3UpcB9wLmLmnp+xEs8U7Q+Dt0P2jgvh8l9u8VTw2H59fMyHkRjHcCyrfAz+4oL5A
         EZe5ty6HpP+mzTIE1QuPzGm12oTNSGN6iXo7V57gMCV35gSHFJ/Av9hYd9wmxjMI0Tdd
         ePfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728996334; x=1729601134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32W9uSD8O8vaQJgYtf8QgSCr7bsWB+HAeEs0r4wXDpc=;
        b=CJWQNaIZbVMSFkSXOLZDisD+AjPNAxHeGRpKG7TkcgN8+ILx3L03IKP8ZnDu3jyRxx
         Zh2iwcnE0CMNB1FdrK30+CEXnKrl7YRdd3qWW7mrjBhAjbUhbnoBJIlMFQVvGfwghQyX
         OQGVPPqb7Y0OzuN9CU1o1E3ILbtMoHHNerZopBdKVAqsm580gA20IjT6+dZT7bvWjz53
         EoBbOr5NgvdUtotnY3fn5Jba6IudtCnLNiDuSyTCjETgjgb27oSoJpQ2y9/OyxJmCIwl
         yVV3HngcD22gRDeCNZrbz+Oo1veppHl6UFmzYAPtKlmyVSyJwNkOWcrPNXgApOhGOJVm
         DXRQ==
X-Gm-Message-State: AOJu0YwwDpJ4uen0N9ic5BTMWklYSNw61ecIYFT8vQXaw+3m7eEbISFx
	Q+PwQdj+wtlE0tbgbiP0NfvezNtIR+GtlMwGI72Nop7EMgzx/Kms7rq3jilCilmDL+O9aYIx1XI
	PHJ6wQZvVY92QatZJ5wtLu17JeCo81gt+eeo=
X-Google-Smtp-Source: AGHT+IF/3ykGoScPbV3RhIsXDJaEAWSE9QCXcEr0TdrGaIvLZFvWzN94CCew7hZfcoSVmiE/3QT35ECvt+ynJyE491g=
X-Received: by 2002:a05:6402:2402:b0:5c9:137b:b81b with SMTP id
 4fb4d7f45d1cf-5c95ac50789mr18460124a12.25.1728996333404; Tue, 15 Oct 2024
 05:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <B3A4B5B2-0EDC-4D1A-BC91-0ABFCD1DFE2B@gmail.com>
In-Reply-To: <B3A4B5B2-0EDC-4D1A-BC91-0ABFCD1DFE2B@gmail.com>
From: Prince Roshan <princekrroshan01@gmail.com>
Date: Tue, 15 Oct 2024 18:15:21 +0530
Message-ID: <CAP3G6fr2iTLh53CSWLkcOYy_q9+wjYX8Agk9c_dhBZdTBD=xYQ@mail.gmail.com>
Subject: Re: Feature Proposal: Adding Command for Configuration Diff Between Commits
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the suggestion, but I realized I gave the wrong example.
The issue I was referring to is something that's part of .git/config,
not .gitmodules, and it can=E2=80=99t be tracked using git diff
commit1:.gitmodules commit2:.gitmodules. Apologies for the confusion!
I=E2=80=99ll reply to this thread again once I remember the specific proble=
m.

Thanks,
Prince Roshan

On Tue, 15 Oct 2024 at 17:02, Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
> Hi Git Community,
>
> Hi !
>
>
>
> I wanted to propose a new feature for Git that I believe would be
> beneficial for repository maintainers and developers alike. What do
> you think of adding a command like git config diff commit1 commit2 to
> show the configuration differences between two commits?
>
> Git configuration is not tracked in general, so it is not clear what this=
 command would do.
>
>
> This command could display differences in repository configurations
> (such as .git/config or submodule configuration) across two specific
> commits. I see this being particularly useful in scenarios like:
>
> When a submodule is added or updated between two commits, helping to
> easily track and compare the submodule's configuration changes.
> Identifying configuration changes (e.g., repository settings) made
> between different commits without having to manually examine each
> commit=E2=80=99s changes.
> Comparing various configuration-related changes in large repositories.
>
> For example, when managing repositories with submodules, this feature
> could quickly highlight differences in submodule references, paths, or
> URLs, saving time and providing better traceability.
>
> The .gitmodules file is tracked though, so you can simply diff two versio=
ns of it (technically, you are diffing two blobs):
>
> git diff commit1:.gitmodules commit2:.gitmodules
>
> Hope this helps,
>
> Philippe.
