Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE144315F
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 06:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728714414; cv=none; b=MGtPobbk5mzTbtxslmovpbw/ga4PH/ghGU+bZMlPhjcKbx42+Rhh6Y4/4el4Abk4wn5Iz3CQREggorgrbPzClzzapcx7NRUxYK+u0ZuTHG7w4oQEkfB0Ddsz8QPQZtGmF/nrPqw1stYQ6LiZX3kanv5k7PhPZ1GQJo3gZEradXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728714414; c=relaxed/simple;
	bh=MR1I9e2NtqoPnQLPIfalEOEP5PVEkP8CDDUrZzGBCPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0jSUGV+97eVwbXrXbwGIPkDHg/EiNzWDO+Hh7EMbFIArdthagFTS28OYukZ/F+OYWWUoxmeuj7RRgrWfHmSdJPDpcDhpjjzMhPSEkIVy+3b3m0DKyf35cIHg5yd3LH7y1rFT9vjtS1MBNF4tdjkOSpkH0rdRePNSguk/cBvSQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cbf113dc8dso2673306d6.0
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 23:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728714411; x=1729319211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oqm7Xi0W1XrCUBLti5LmIF+C7/+PT4LFZjqAsK8zsvk=;
        b=jhT8uy3Sn863L6ch+xptsQUVOkCvr3QcARQiew7yBiKlks3Qqu36AMXbkfh5718mHt
         gpVq3nnb93hVc63BTMEF3K10eJuiOlEtDUNUJEQl/dX/n+1CvG0TOFIBohGNS4hUZWqU
         aTX9WMzwpfEtIswAckxZqyLUIvGyFztZ9DZg1yt6VQChiU+qIjxuHp2QUemtiiY0IrfV
         9NMFolpV8AKWXpwl+fHIfSPKMgvpdHoZywmXP6YAhP66VvhzsxLQkg4v8ISag1mDHttW
         96/BgI6szVP9EHKkNGfHEd/hXAJNxfWGt6INnEQBNDqMQiW0VifbGnC0s50G0EaGZOij
         FZxQ==
X-Gm-Message-State: AOJu0Yw44sDGgAtBzYA9ACu8YX1UV2fI1xqC9os/Flguj2eklol4/90z
	oIt89FxhhKnGkl/cdjh/yipybqYXuSQSqsB7H5xW4HNdODdxhdkIiwZir2gpWxV9fpGzd/IpHq2
	xBXqetF4o/bicmdYmPriXSkvZHfE=
X-Google-Smtp-Source: AGHT+IGY4zjw32OKTzt39qBK+iYxJwx+d9OF3qRdI1NBnfnP23TXub+43+3hQO4/+h+lkxy1nSt2hmYuzC7J9y2UAfo=
X-Received: by 2002:a05:6214:20a5:b0:6cb:4a88:8cf5 with SMTP id
 6a1803df08f44-6cbeff32402mr31761756d6.2.1728714411060; Fri, 11 Oct 2024
 23:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
 <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com> <8d2fa3af7964dacd09d454de4325b1d5eb7a5c3d.1728707867.git.gitgitgadget@gmail.com>
 <CAPig+cRkp3ZrykLvgDaGnKgZNV5GiFqc5zq6ZZ-fM7RJcqxM7A@mail.gmail.com>
In-Reply-To: <CAPig+cRkp3ZrykLvgDaGnKgZNV5GiFqc5zq6ZZ-fM7RJcqxM7A@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 12 Oct 2024 02:26:40 -0400
Message-ID: <CAPig+cQ=WGz4vmkcBR0Rk8KtQiF2vaH1PLt0-rTDvYi=z=EEUg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] blame: introduce --override-ignore-revs to bypass
 ignore revisions list
To: Abhijeetsingh Meena via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Phillip Wood <phillip.wood123@gmail.com>, 
	Abhijeetsingh Meena <abhijeetsingh.github@gmail.com>, 
	Abhijeetsingh Meena <abhijeet040403@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 2:24=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> On Sat, Oct 12, 2024 at 12:38=E2=80=AFAM Abhijeetsingh Meena via GitGitGa=
dget
> <gitgitgadget@gmail.com> wrote:
> > [...]
> > This patch introduces the --override-ignore-revs option (or -O),
> > which allows users to easily bypass the --ignore-revs-file
> > option, --ignore-rev option and the blame.ignoreRevsFile
> > configuration. When this option is used, git blame will completely
> > disregard all configured ignore revisions lists.
> > +               OPT_BOOL('O', "override-ignore-revs", &override_ignore_=
revs, N_("override all configurations that exclude revisions")),
>
> We don't normally allocate a short option name ("-O" in this case)
> when introducing a new option since short option names are considered
> a valuable and limited resource. A short option name may be added
> *later* if experience shows that the option is popular enough that the
> convenience of the short option name is warranted.

I forgot to mention that this patch also deserves a documentation
update; otherwise how are users going to know that the new option
exists?
