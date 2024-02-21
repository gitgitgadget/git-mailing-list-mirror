Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1057F17BA2
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 02:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708481906; cv=none; b=GIp7rH8OQE1rzqd/t0XmvLQOc5NFofHY04apU2Zjx5f5/S+rMNzIHi3jN744yCrYP5Ew/DFM9ameZ2Ih7G2rZj6UhRo29rbV6RaWMDZgaq/ZjQFZPtFDqOqA4bSrqM1xOmnTJs/8vUTEbI0uMx6eu02KUdUWq8l5ii/jroetjEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708481906; c=relaxed/simple;
	bh=DxqZ8vb9a/tpG9C3oj10YDc3SFZ5kcBQSA0C8oDyKYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g675iVPkZTN2C9DLDvcj0kEgLo3OhVz4VDpHYTSW9C+0tKBI7mcsnuxYWlYTjiFGgG6MENowmQMLH8AOpojw54MqlTLAcinQ+YjRyihFQHotjLGftLqEc/FZtHZj/GoGuNQFFFDpJp2jDtw/ju/6uRXVr+qymbJZB61unwDyxtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBYuwY7g; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBYuwY7g"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51181d8f52fso8119955e87.3
        for <git@vger.kernel.org>; Tue, 20 Feb 2024 18:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708481903; x=1709086703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72J/yHuMG4F+Kk0NyVXhtzdvSsIhx0C8MV5pw9IHgJE=;
        b=XBYuwY7gph+0pc3CXJcSG6e1Rp3Z+D2jEA1BWYSfuZvHzNORvfV/QurSM76U+k3DEr
         8wRvq2GE4QxPPBMw1IoNb+iOf/BnxH4MSsiKXByX2EbDhyF3sxrvQVKybG1q+Ib3Sas1
         euEoWt5OZW5i+jQjI2uS9y9Rdkn/UHwPMKr8TGNwQjH8td9XgOUcjRcDqe2ZVM3xlYrH
         F2VnSj+/EKRELS2jnQ0nDxJ6uCLTvvKljXYDV/PfzUKd3eycdBzoaz1IzlNQYk9h9yGy
         hWuh6GulLS7if9/Ev+ezaFHDqxeyHEfnbqdazHcRjfSFP0cmaxPC09qjHAy3/V7gQd6y
         rjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708481903; x=1709086703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72J/yHuMG4F+Kk0NyVXhtzdvSsIhx0C8MV5pw9IHgJE=;
        b=d3toxPFjEv6srZmST1gHdxGtEkidH/tesVJMdAXaviYwwinbXHJpEBem4Y8vEOBZzW
         RuW5MSUZXN7SmQcUIuixZLJ1AbhIHj9/v3hJptTUxa6TaUaxzgAqfxWPi0KIOl5ROiK2
         noBQHGmnLLxsC//7Pks30U6uvSd4ufGfiAH+IDXeT3XTMJpa6X4GWkG/QQw58G9zv9/J
         pe3uL+Fi0TeKNA+C6RBnNI2mD5ljRle0yagjJxcWGUwXV9yBKgLVYJA3IsZ7n0SXFglt
         V5zFCgmcAfZPmYuuNRl2NNKkAhSLP43R1zKDk7QJ+u83FKkSawxs9EPdxRXu4r30pALL
         DUsw==
X-Gm-Message-State: AOJu0YwCCsSL87dcA19skPp2IJ1m3wbYf7NNe59cFdCX1ao91N0R/Bl0
	ulKgrX6xCoT0CSE8SsyOwu7oeXDtCRv3askDMaauX7IF804/PgeVn/3+dHhaBRrUTEjV3a8aH8B
	J9cZCs0rgLxJfyhJBoZiHpd8vmT8Fe/Vla/M=
X-Google-Smtp-Source: AGHT+IEYcouqGJw3zI4rHr2W4zrb0lDRx4hxbEKa8gL/KizwXZ9P9QRZZTYtsnFp78YDSzJCgp+fp+/2jhR32hYAzZ0=
X-Received: by 2002:a05:6512:158e:b0:512:a32a:551a with SMTP id
 bp14-20020a056512158e00b00512a32a551amr7499986lfb.43.1708481902924; Tue, 20
 Feb 2024 18:18:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALPZ9FGr8K=AdqOzX2P7A3T8+_V25SOjcHA5kY-Fg5TUFEvh7w@mail.gmail.com>
In-Reply-To: <CALPZ9FGr8K=AdqOzX2P7A3T8+_V25SOjcHA5kY-Fg5TUFEvh7w@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 20 Feb 2024 18:18:00 -0800
Message-ID: <CABPp-BGi6m3SLce8TbZJOMuu610o0PEf+NgaqqfTzZHrqcYzFA@mail.gmail.com>
Subject: Re: Git rebasing attribute the change to the wrong file [bug]
To: John Gabo <charleforalia@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 12:02=E2=80=AFPM John Gabo <charleforalia@gmail.com=
> wrote:
>
> Hello,
> I think I found a bug in git, where a change get attributed to the
> wrong file when doing a rebasing.
>
> # Short summary
> Assume `master_branch`
> ```
> .
> =E2=94=94=E2=94=80=E2=94=80 parent_folder
>     =E2=94=9C=E2=94=80=E2=94=80 project_a
>     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 file.txt
>     =E2=94=94=E2=94=80=E2=94=80 project_b
>         =E2=94=94=E2=94=80=E2=94=80 file.txt # the 2 file.txt have the sa=
me content on master
> ```
> Assume `feature_branch` from master
> ```
> .
> =E2=94=94=E2=94=80=E2=94=80 parent_folder
>     =E2=94=9C=E2=94=80=E2=94=80 project_a
>     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 file.txt
>     =E2=94=94=E2=94=80=E2=94=80 project_b
>         =E2=94=94=E2=94=80=E2=94=80 file.txt # this file got modified wit=
h a feature
> ```
> Assume `refactor_branch` from master
> ```
> .
> =E2=94=94=E2=94=80=E2=94=80 refactored_parent_folder # got renamed
>     =E2=94=9C=E2=94=80=E2=94=80 project_a
>     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 file.txt
>     =E2=94=94=E2=94=80=E2=94=80 project_b
>         =E2=94=94=E2=94=80=E2=94=80 file.txt
> ```
> then rebase `feature_branch` on `refactor_branch`,
>
> ```
> .
> =E2=94=94=E2=94=80=E2=94=80 refactored_parent_folder
>     =E2=94=9C=E2=94=80=E2=94=80 project_a
>     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 file.txt # the feature got mo=
ved here !
>     =E2=94=94=E2=94=80=E2=94=80 project_b
>         =E2=94=94=E2=94=80=E2=94=80 file.txt # instead of here, where it =
should be !
> ```

You may want to read through the Support section of
https://git.github.io/rev_news/2024/01/31/edition-107/.  You are
dealing with inexact renames rather than exact, but it's still the
same basic issue: git is detecting renames based on file similarity
and you have multiple equally valid targets for it to choose, so it
simply picks one.  As such, it might be considered a limitation of
rename detection that you can't manually enforce which files are
paired, but it's not what we'd classify as a bug since it did
correctly pick one of the files with the most similar contents.
