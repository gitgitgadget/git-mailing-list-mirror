Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BFD84DF2
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716498375; cv=none; b=IsLNPEbUIjgbNixP4Oek+7ALnQ/t21HLeIkTRaWWJm7x3x0cBT0LmDmMmkbXjEShWlESyy65lyuzz0VLj4jra++TTwAnCX2MY0ykSVDwSiYj4lR7nhjdksTqr/inqk2XPymGGmN9v0IcFxeUV80KA8IGOfs5LhTYuBjWoMIb4yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716498375; c=relaxed/simple;
	bh=d8Lp/zBMkDaDXEtVSB3aiggDOUFhj0Q+EpDLP4s6xns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXyu6pUKHhC/4Q5mrTJHFgt4yIzPhSCPoCUv24/Mjfk2r8hKOMH5q6MSh9TDzljAnKYZ2xkiZO2MUzljYyB7021+WgInd6QynxRvPHJdhOfI457WNFHunVjblbPRV9Zvo04a3MZoii6cNActaYr9tjmh45yvdJ0qj1gy4P+cncU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-794ab4541feso2916285a.2
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716498372; x=1717103172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uJzPnKZ+LsXdU+1WTk8HT640lEUonjR5brXgBLkw88=;
        b=JBKmODSJmATm68uNOhNxW5rZZLX6sSYWTDbNIg7vMMuYCKJOln+PbU0p7JR03I6u83
         1CSG+6dE2at6dXO96R0sDnw0jOTe37ODDtNkO1Eml3A7mrp4j2fXqA59sYuDOuXRWguz
         qWTrB0f95DSWnBdm788oqLKj4geFbARBkDMFFozIfQfhuvPQ5Q794kfaVZtPtEFtPBQU
         MdZjDXqpseXFuAARjU+RWGas9D5cKoAh5Va053ZlSap0QdrQ5rLqr0zqNDYz1vfi+jck
         Z3vcv3ZXFyN4WM5puKVdIsHkCj78nVm6A8xdXIHr9Ol+SRjq9vm6i1azN3qwxGmrgm3K
         al5w==
X-Forwarded-Encrypted: i=1; AJvYcCVNo2aDeOY+jpupIONmRRM0S9FYrFbBuvnd/LtW8GAoi+LJQGI6w1dIo4Y/mGiHm8SLpIkKImOmTwGCmJTnxeLW6zYN
X-Gm-Message-State: AOJu0YwnDCABRvRtri2OVEn+aoZ4jV5f4++H67hcRDOPb5zjeQxWuBgp
	RBf5mBcPjHjBMObE2dbksgsXlen9TMXsIuiYK0VpWEciB29uoNCD+JxTff3PQl4qoIYCvrM5cZT
	De/Qf2SVDtNw2JcAEqTJzBpl6Nog=
X-Google-Smtp-Source: AGHT+IHPoxrDgiPSdBIXoJG2RG8lgw9hbbB6POSVIuYc1GRMEhg5exShrphoLMwMj9FmNUZrItL15W6aThWdFkaAyY0=
X-Received: by 2002:a05:6214:3209:b0:6a9:7306:dc94 with SMTP id
 6a1803df08f44-6abbbc61859mr3112726d6.21.1716498372014; Thu, 23 May 2024
 14:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zkdk7R9GIfsyQjkc@telcontar> <xmqqsey8tnny.fsf@gitster.g> <Zk-nswiCF-SnyxLE@telcontar>
In-Reply-To: <Zk-nswiCF-SnyxLE@telcontar>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 23 May 2024 17:06:00 -0400
Message-ID: <CAPig+cRddr=JTVvkh5xkptag_1C5-z1t9Pzr_OdcGFSVwRg3vg@mail.gmail.com>
Subject: Re: [PATCH] t/t9902-completion.sh: backslashes in echo
To: Marcel Telka <marcel@telka.sk>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 4:32=E2=80=AFPM Marcel Telka <marcel@telka.sk> wrot=
e:
> On Thu, May 23, 2024 at 10:59:13AM -0700, Junio C Hamano wrote:
> > Marcel Telka <marcel@telka.sk> writes:
> > > The usage of backslashes in echo is not portable.  Since some tests
> > > tries to output strings containing '\b' it is safer to use printf
> > > here.  The usage of printf instead of echo is also preferred by POSIX=
.
> >
> > This has cooked in 'next' for some time already, and I'll merge this
> > down to 'master' anyway, but this being a script very much speicific
> > to bash whose built-in echo we are using, the portability argument
> > of "echo" made in the proposed log message does not quite apply to
> > this patch.
>
> Could you please help me to understand how the bash is used to run the
> script?
>
> $ head -n 1 t/t9902-completion.sh
> #!/bin/sh

Looking a bit farther in t9902, you'll find:

    . ./lib-bash.sh

And if you look inside `lib-bash.sh`, you'll see that, if the
currently-running shell is not Bash, it aborts the current script and
re-runs it under Bash.

But Junio's point was that t9902 is dedicated to testing Bash-specific
functionality, so the commit message's justification to avoid this
non-POSIX behavior isn't necessarily a good justification for the
change. (He wasn't saying that the change itself was unwelcome, just
that the commit message wasn't convincing.)
