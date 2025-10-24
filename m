Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1B733B958
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325077; cv=none; b=axHrZ/ND5spjSV9zTrbT+C9uMXwT/tyOXWzs+dxy9idDnpS0S3cwVe+5MvMOdawe7ax+gxHWbykMEEkGuqq0X/biZgOLHDHUTxPYnRpqbnheCIIPxX7Bo935Gr+t0jHSriQ53qBU4NG38HcjgFFDBvdcOoElGNhTEhaTWONMWUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325077; c=relaxed/simple;
	bh=4grH93WQ2szU7WT+u4pXIxFsQtVHehU33bJ3BxTOZCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbl7+WzzRrfyqae6LNep0ZQu+UVWf6I/UwBBeyt2/Imp5hz4qpI9jh7V5eRCdg8yOF05xSuTYTTNM8kLZTwkyXbzd4ZC6Ee/USli3iEo0Ul5MIb+iP0k7UZcVxkyufDymAyhJWQTjuLo693Ys+/tgvHZOreJvi7tStkLr2VGGBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-87c2b5ccd95so3824516d6.2
        for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761325074; x=1761929874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oakWfDteXeH1zO5rps8cXs30O7ovAKHtgCMBSmiJ3Tc=;
        b=qGiv13eXNnykMdTdbvVWPELMRxrWo4OkjnJyVdbLRFY24VQfuFOf/thiXGBmIhFZXv
         HBZB1GXW7thDL1y+diIM1DxXWUOvsKoUrObTMEifz9tWL+mmpg48vNtzfYzXDtlp/Rhy
         eWAaiPc9AO0zaZByF9ZD9hBcom2weIi9RjWCNnsYLWrrlcYAxHd8Q4iZ7uVe/s1dG6O9
         mFQ5CAdsrTq1MHjyJejzUoaZUsQXPVBcJquRq9n4B1x8TYfM+FZi+D2vJOAdtXOG/TU2
         ZWfZlZ11CPxVWEok6olFg6MbqetKRauQs1vvyPbHSVN4NjoQtLnyTD3UNjO4/wuLXU7G
         QDSg==
X-Gm-Message-State: AOJu0YyM3q4UXfLuL8L4to1EongwriA+RJdwqWOpBMkCpRkC0FO39LbZ
	DHkzE3rrNABhA52dV2yia5gH3MU6P2m3FLj71FoPWZgH0OgcIlVDWeR0dQC/voezUJ8No/R5ZdB
	24sRem3JIeDSi0E0KNbpEiqioeomtZKw=
X-Gm-Gg: ASbGncsNHG9iY/9DUcOADTnffCbUCdoC/1q7YdwUDkHKaLjdJf3/mxwRg/XuJl5IoBt
	8uHIoGUgDUvqB4FtVq0oaN+zlGN0G6tHidOrCtmdIQZJLXYP6Teony/JPsFdtyZdNy/D4FwiqnA
	DeH9wWiN8gD5IMw8n8hU1COx8ukknEgbo/xQQIwUTXvhGTFhBZs/+Qo0LdHAHm4Nx24sOvZi9uG
	7yGuDzxeHyJo2TYz422XhtILtGGLfK9EFak4kIu7Voou7tNXUSOMCp9cqySDecXfDo0xo0UFbKi
	F0HExy1c5RJkIRZ9YA==
X-Google-Smtp-Source: AGHT+IGtjtpRsysEKHodLZ7CcWKEZiPZ8JEdEW23W/+1gADEMAJ1q3JdSUfwomAA8wGM8EDD0YaDnU8Nk80XQpU8LEc=
X-Received: by 2002:a05:6214:c47:b0:87d:cb51:4015 with SMTP id
 6a1803df08f44-87de70be665mr131751646d6.1.1761325073759; Fri, 24 Oct 2025
 09:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a203b35538847f3c9358a5ae26fb4ebea5734cfc.1759420102.git.msuchanek@suse.de>
 <0e11e6fb394ffa3a1286deea5a8ede5ba3e4bdf4.1760115862.git.msuchanek@suse.de>
 <CAPig+cSNesf0UwS4=Bxe-Qn+G9y3YYPyOK+7y3q8QJk+o7jaVg@mail.gmail.com> <aPtRzTwVgVfqjaZT@kitsune.suse.cz>
In-Reply-To: <aPtRzTwVgVfqjaZT@kitsune.suse.cz>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 24 Oct 2025 12:57:42 -0400
X-Gm-Features: AWmQ_bl6T9e7VZsfSkJNg3dyCil7EixSJLdHfW5L00C573162C0K7wK9Daq6Bsg
Message-ID: <CAPig+cQoL_=WdNpcO_9mTLDRRDHCOC1-nYMwUyfaev3BZyzaow@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] doc: git-worktree: Add side by side branch
 checkout example
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <avila.jn@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	Ben Knoble <ben.knoble@gmail.com>, Jason Cho <jason11choca@proton.me>, 
	"Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 6:15=E2=80=AFAM Michal Such=C3=A1nek <msuchanek@sus=
e.de> wrote:
> On Sat, Oct 11, 2025 at 01:17:47AM -0400, Eric Sunshine wrote:
> > Third, the example seems overly complicated, especially with its use
> > of `--git-dir`, which feels less discoverable (at least to me) than,
> > say `-C`. What I have in mind is an example more like this:
> >
> >     $ git clone --bare <repository-url> myproj.git
> >     $ git -C myproj.git worktree add feature-a
> >     $ git -C myproj.git worktree add feature-b
> >
> > That should be more than sufficient to get people up and running with
> > associating worktrees to a bare repository.
>
> That creates a mess. First part is not creating the directory to contain
> the worktrees related to the repository. Second is creating the
> worktrees inside the bare repository, contrary to any reasonabe usage
> advice.

Sorry, I mistyped that. What I meant was:

    $ git -C myproj.git worktree add ../feature-a

which makes the worktrees siblings of the bare repository.

As for first creating a directory to contain the repository and the
worktrees, I purposely omitted that step in the example since I
assume/hope that we don't need to hand-hold the user to that extent.
