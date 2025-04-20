Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67172134AC
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745127373; cv=none; b=QGzXa5XySpWoYJsV+vR0dwyxx/+46kEICBYKYNXJqokPZlhr/cN5GU2lLzBeuhLGWR7ZG6J1Q5ZHkKRAgrMR1bYi2oZtj9+pXrI1R88Cqf3t3qNJq1U8pF7SVaX3sVQGWdneZkjYg0+1kC8ncWLHmqte+h7t20AJUvDf9TItZsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745127373; c=relaxed/simple;
	bh=+/dx05Cw8SZvZkjLzeLwNmoPRORR0YuLH5uo8/Tww/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPEWAgMpMIZdwD2/DT/KkQWRWnuawCC/0iDwQ5iuGflz1Ev/uYkXQqSf8/KsfmjM9mIcjSyxvdN2ork/AraeopqX11Brd8fPAToSkKGMQ7bMu2m5CLGIPCBpsZ2+L19J5PwLQ7hNjMWIFdOzlnSr+Wf1Ju+MKKDMkYnLsslUK4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ed0d921c6aso4027056d6.1
        for <git@vger.kernel.org>; Sat, 19 Apr 2025 22:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745127370; x=1745732170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBHMGF+raxK7YorYCGnkHd6tx3jOc2SftsNg3lifyi4=;
        b=hfDdTvbeEQb+ZeEnzD3+zNN1t0OkWjw35xBNchJmtSG79TDF41RED1cCJtLjaYNrYQ
         X1DFdEGvjPCGGhxW1JjFNeZozqSsHvtIAX41+8DvZVr4viWrfWOAkejZn193cMaxF12C
         t8DqhvxPKOWoFi9YO/msT+jzihMZ17S2AoKG9WbrPYlKVq2cBIAuPtM8qGZEyWEfdQmv
         aJGsHq7j/0nLCAogRAe9UmGFdKL82H9rKb9t9fo+PyyH4sQU+3puQNJH+YEwl84sjSvT
         sG+eKKfZhbxyCCACRjv2q3x8Qrgg+jllnqpVRpQOjS6zLmHnqNNGs2F2pBPwbwsU+4yL
         H2Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXhfbh82ACL4jn7fAp8zYaAZ/li6/ouNrpGHEOgUKUWQw1VhdX4j+dbsFAi1uRhwNe1Qrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0LIjNXBxPQyICs4isrpcE0WgRAstVcF7azGS3p8iX6J6F00Q4
	UYkrWEhLFiPBex80iFHvsNDpHOBqfHQ53N0N7a1121sSr4zIYhQlPISZApflF7KqMKGHni33zOF
	Oljo3LxsEZag742LZ2Br9mFkLf/4=
X-Gm-Gg: ASbGncvVxX4+2gEyho5P4ckjnCJ+MBEy3Aw6eLai1fSMCEao5OXqaiIjOu48gWNalW/
	NPpNLn4rNu3/NHYjmXAiuWf7dKyfoah0TEZWIS4kew/392Nt+6TTos8FqQI1JADFizkwcQwioGm
	HUC98q92nvGJauV+AUbV22zu1CR6rpPvPGOHrjhgIjX/JOl6yLabRI9B4=
X-Google-Smtp-Source: AGHT+IEzNwX3SpWgcBFdqOCjdlxygLR0w2oSm0oOOzASEuU9IP4g73Pd51kBzsTCxVyU9QPXjOYyBypP6W++6JGUzPA=
X-Received: by 2002:a05:6214:4002:b0:6e8:f645:2639 with SMTP id
 6a1803df08f44-6f2c455d583mr49396746d6.5.1745127370183; Sat, 19 Apr 2025
 22:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1947.git.git.1745088194384.gitgitgadget@gmail.com> <xmqqo6wr95r6.fsf@gitster.g>
In-Reply-To: <xmqqo6wr95r6.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 20 Apr 2025 01:35:58 -0400
X-Gm-Features: ATxdqUFWWJStamjERdhwkKhJmtip1d1vHXgMBEbcABfznTC7foq4lrQ-4c6rj1c
Message-ID: <CAPig+cT1BNXRotrz=rnVgvhQjZZwYgsAOQMonHFFTPfK-C0LOQ@mail.gmail.com>
Subject: Re: [PATCH] builtin/blame: ignore nonexistent ignore files
To: Junio C Hamano <gitster@pobox.com>
Cc: jade via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, jade <software@lfcode.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 19, 2025 at 5:54=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> "jade via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > It's currently a problem to put blame.ignoreRevsFile in a global
> > gitconfig, for example, to use the GitHub (and other) supported filenam=
e
> > of .git-blame-ignore-revs by default if present in a repo, since the
> > current implementation exits the process if it fails to open the file.
>
> An alternative design that goes along the following lines may be
> more palatable:
>
>  - The way to spell for the users to specify a path that is
>    optional, either as the value of a command line option or a
>    configuration variable, is to prefix it with ":(optional)".  E.g.
>
>     [blame]
>         ignoreRevsFile =3D ":(optional).git-blame-ignore"
>
>     $ git blame --ignore-revs-file=3D":(optional).git-blame-ignore"
>
>  - For command line options, all commands that use parse-options API
>    would automatically benefit by updating parse-options.c and tweak
>    its handling of OPTION_FILENAME; when the specified string begins
>    with ":(optional)", you strip the prefix and see if the remainder
>    or the string names an existing file.  If it does, you use the
>    filename as the value of that command line option; otherwise you
>    pretend that the option didn't even exist on the command line.

For what it's worth, an initial implementation of ":(optional)"
exists[*]. It was eventually dropped from Junio's "seen" branch merely
because it never received any reviews, not due to any particular
problem with it.

[*]: https://lore.kernel.org/git/20241014204427.1712182-1-gitster@pobox.com=
/
