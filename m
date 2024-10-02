Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB71D131B
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 21:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905439; cv=none; b=df/w//nUbrXLAP0JeQBnpo1lOPT3hMlm29eCUuTXhXo/UJnTIR7QNvpIzFJYkX+QdQLihdNIukzvX/TVvjp6tfFGuQI+0+aqWs187fRXmmf2jkLds47Hn/19/0fSYOVETFAyTcFs3KOzTNDjzShCVGJD9rMIoVAe3Mmx1HMOp7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905439; c=relaxed/simple;
	bh=pPbiH6b/KK4DliptiFA4WVDW8JDBUcSEYMzDdjD50sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwW3hPk5MeF8viypkxZvpJcLHTFDUpxNKpEAQoaWT9rYgIyyUPr6PAzdsbyisl3g/JacKmKxhy1mL3B94x4pjF9FMzOxuKecKi1AQbm8MAVXJV5oHYBngetCXJnnFjdbBQVLb+nhNYK59Z7pCv89qgW5s3WGDI6vLvKOO98S87c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cb21f041c8so364216d6.3
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 14:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727905436; x=1728510236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKsvkCNXPsBc4O+ld1avegIfuSPJxZH57QvyXvETYvM=;
        b=ZCg2ZlnGPwPYL7Ijx3HCrlZ/DU9+yipIs9li3/t+wKQoNVnzAfzNKhsPB/jIsrxgi4
         F+/Wl1gJiCvtX9J5dEPXBRnSjl+uuVoHSzggNSLIy0h1+U/Q/bgjqdhcH5wVFWhzJzVW
         oNhHMTqQq6HphxmB+5fya/0nm7sL850uXv0ptpZLxG79ZptR0gEBGVrdAmDIQb2FwLiR
         wXfr60XYopNSmemXlxA93AkZNvMW6erRpeCDW9W52QyRLR2elPPY0Fs7nLxRo3gN0Cge
         bqHS9tujD1+DGnmG8IY1OIA4ptb2dHNqj+fKkicH4OAyvPoGv7AMw/CoCvjegd3L1X8K
         uJBg==
X-Gm-Message-State: AOJu0YxhGajEoURK/WNcHwMOOq5759B/U+Nr30XpQ+/GYYEuOWCFOg1m
	Sa4ET2K/XaugU/dXwOXYjDAyvotaku+szVWBHknXH6ETa3+KVOcEyCc09DtT1O9XCCCA17LSwhy
	5ql+PbLsSUAghAe9Pdiutz45uyxYvZKmo
X-Google-Smtp-Source: AGHT+IGBUFLHCzYZNIC1xOz4g7Q/wEwORmhgA/g3o8mDBsXW+VJtx0PUolKax0J9XN6WYq95Eby6j6eSZ1tZ+QFjFvE=
X-Received: by 2002:a05:6214:1c47:b0:6c3:5db9:e722 with SMTP id
 6a1803df08f44-6cb81a2dcabmr31055266d6.6.1727905436202; Wed, 02 Oct 2024
 14:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727881164.git.ps@pks.im> <00fd829833cae1d192d6c42237aa13427156e3ea.1727881164.git.ps@pks.im>
In-Reply-To: <00fd829833cae1d192d6c42237aa13427156e3ea.1727881164.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 2 Oct 2024 17:43:45 -0400
Message-ID: <CAPig+cSqeKJX99jbxouJZHdGZuyAgNz-wOgt+0C5OPvW3MHgLw@mail.gmail.com>
Subject: Re: [RFC PATCH 05/21] t3404: work around platform-specific behaviour
 on macOS 10.15
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 11:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> Two of our tests in t3404 use indented HERE docs where leading tabs on
> some of the lines are actually relevant. The tabs do get removed though,
> and we try to fix this up by using sed(1) to replace leading tabs in the
> actual output, as well. But on macOS 10.15 this doesn't work as expected
> and we somehow keep the tabs around in the actual output.

I presume this nebulous explanation is due to the fact that the reason
why macOS 10.15 exhibits this anomalous behavior is not yet known?

> Work around this issue by retaining the tabs.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.s=
h
> @@ -1917,18 +1917,17 @@ test_expect_success '--update-refs updates refs c=
orrectly' '
> -       cat >expect <<-\EOF &&
> -       Successfully rebased and updated refs/heads/update-refs.
> -       Updated the following refs with --update-refs:
> -               refs/heads/first
> -               refs/heads/no-conflict-branch
> -               refs/heads/second
> -               refs/heads/third
> -       EOF
> +       cat >expect <<\EOF &&
> +Successfully rebased and updated refs/heads/update-refs.
> +Updated the following refs with --update-refs:
> +       refs/heads/first
> +       refs/heads/no-conflict-branch
> +       refs/heads/second
> +       refs/heads/third
> +EOF

Although this works, the problem with this change (and its sibling
later in the patch) is that someday someone is going to come along
(say, for instance, a GSoC applicant doing a microproject) who submits
a patch to (re-)"modernize" this test by using `<<-` to (re-)indent
the heredoc body. A better approach would probably be to retain `<<-`
and use q_to_tab():

    q_to_tab >expect <<-\EOF &&
    Qrefs/heads/first
    Q...
    Qrefs/heads/third
    EOF
