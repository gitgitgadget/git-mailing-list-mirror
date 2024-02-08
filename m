Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD9E1CD2E
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 00:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707353578; cv=none; b=m1NHgtZkSWfHmw9uixvnl4WJ2Cnahaq9tAO3aGgtjuiEgKE2ICIibwpvRX3sxCQRkicf3B3YEZbbTM0/J7gCCjDXUThDUUBeFOr/lvYZ3pzTcjFHY2lMcIEWQjuYji6Sz75KrkpsC5o9owUQHYjkJdqin8ZsXFi2o6znNHD7vlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707353578; c=relaxed/simple;
	bh=dVdBW8rm7i8CCq70AQ5JIkWaGDxujUFwX4y2yAoReTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eE22PTYjQorjYSs5P0LgeaBcb75sL0SOa5HdJ6ehZcDXBoHPy5n9T/kciYJxwbu59gkMdF59pYxVIWbN8dLQvgalzLWHEGmQzFF8CHCv//WGLsLcjTt46b9Yy3SpS5esmWpizV04jmh7tedqLUbiRSXzqTeufrt6qLCiKQB7370=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68009cb4669so6124426d6.1
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 16:52:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707353575; x=1707958375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fowMwWOhFhtGgNdM2uS25COrQz+nek/r4uXDG1Emro=;
        b=gySKHXhjNfEc52M05OZHK0itiAfZRc5at65pmfaK9QJ3nWK6s7+mD0XwoHFQkCIAwx
         drATOTo55T1dYbNjS8vFpIj5W2FcSFv0xyAGj3/fY5U0XjfossYhukjvjqXjCv99kDrC
         KHfo40b3BUiL6eYzoMmGlM/es17Ou52j6GHx5kzGfbsgBloNHprpvZculJmZB3nog+Ni
         mUZNazJ7N9URnWBLODJ1Uos4PQCGynXtObuqByymIbOgGtt5k1OD+P30236DSmg+YSRY
         3QbsTAzDge9OO3Zaqo9gnWCxYE3wtDhy+W5BWgVXU2DjKVbiVHPbdkaeOc0C0hk+xDna
         gHDw==
X-Gm-Message-State: AOJu0YzOUienbDBLKtXgQSvspTcSHBKJyfb3/2WHqztVL46uMGlwsS8N
	SfXtA5ZEYqikz3fbbc5UoOWepZhLLpEXnj0RYMIC77hGUFW6nKakUL2PF9cMZWjjWG8/7E6gvaR
	F3UAey+FnIp+ymG3aB5meQ0+dFgM=
X-Google-Smtp-Source: AGHT+IFpeQx3iH52Se5SacdVvUfQDjKhS767VIWCflDw0InaqCplc516Ue5fbfqc/iXM8+kNDCB1LX1Lzs+lHqc0mSo=
X-Received: by 2002:a05:6214:f09:b0:68c:8a21:2de6 with SMTP id
 gw9-20020a0562140f0900b0068c8a212de6mr8666880qvb.57.1707353575157; Wed, 07
 Feb 2024 16:52:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
 <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com> <be1dadf28502fe3e9662fa61523e8c57ce3352f1.1707324462.git.gitgitgadget@gmail.com>
 <CAPig+cSJz3U+vT==NhX5hcrTjsCggnAzhzQOvZcSXbcEGuYaKQ@mail.gmail.com>
In-Reply-To: <CAPig+cSJz3U+vT==NhX5hcrTjsCggnAzhzQOvZcSXbcEGuYaKQ@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 7 Feb 2024 19:52:43 -0500
Message-ID: <CAPig+cQx1=wM7v0cCuVwNwhd3Zsh0fZgZ1A-vX--uy0dd1+kDg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] t4301: verify that merge-tree fails on missing
 blob objects
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 12:24=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> Interpolating the $seqN variable directly into the string rather than
> using %s would make it even clearer that only a single line is being
> generated as input to git-mktree:
>
>    tree1=3D$(printf "100644 blob $seq1\tsequence\n" | git mktree) &&
>    tree2=3D$(printf "100644 blob $seq2\tsequence\n" | git mktree) &&
>    tree3=3D$(printf "100644 blob $seq3\tsequence\n" | git mktree) &&
>
> Alternatively `echo` could be used, though it's not necessarily any nicer=
:
>
>     tree1=3D$(echo "100644 blob $seq1Qsequence" | q_to_tab | git mktree) =
&&
>     tree2=3D$(echo "100644 blob $seq2Qsequence" | q_to_tab | git mktree) =
&&
>     tree3=3D$(echo "100644 blob $seq3Qsequence" | q_to_tab | git mktree) =
&&

The `printf` example is probably cleaner, thus preferable. For
completeness, though, I should mention that the `echo` example is, of
course, not quite correct. For the interpolation to work as intended,
it would need ${...}:

    tree1=3D$(echo "100644 blob ${seq1}Qsequence" | q_to_tab | git mktree) =
&&
    tree2=3D$(echo "100644 blob ${seq2}Qsequence" | q_to_tab | git mktree) =
&&
    tree3=3D$(echo "100644 blob ${seq3}Qsequence" | q_to_tab | git mktree) =
&&
