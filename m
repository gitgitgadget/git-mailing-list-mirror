Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1DB259C
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163469; cv=none; b=f50SIz37wOdEnLXdsjXMb3BMduox8G++76I/z81J6o+WqV54rk028ZinYEOpQyYlnc+cq8x8carm4+G9WI91SbMCYn6Buc93g1DBTXYclQLmN5Lrtj+Ow2ROc/UD290UzX2iEkPYaG75wyh83hSp7ip5gEvhvYE8ZSDsycezxOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163469; c=relaxed/simple;
	bh=zI19Ik/xyBQtNhQ8FBIuGDkZdLiuSfcZgG7SNtCED6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHljbJQixUp5/UPuRakT/j372AowBabPUfyccjrnNKW9rdQfxjYA+P9Q6CKBezdmcGuzbc1GcdAbt+7vtyU4kU0HA6p03QsWt0DF+S24XjjBjnpyUljggQIhyVO3A5mitml2wQUsT2I7AR4Nee0WeyU+L9O9/ISjmivoGFJezmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3wkZjxb; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3wkZjxb"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-50d57c109d5so252717e0c.2
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 04:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729163465; x=1729768265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRlHPgRoK3euT9X0F0l94BRbMwnCMxRXdNGBoRIstEY=;
        b=N3wkZjxbENfYjeu1gXnNfBdQmmCMSo8FvO4/faXvfLUjuFCzbfu+vaq6+n9IJCFZ97
         jO5FhVbP/8Kfkey0zm6oGNTOtLDPp4qlmLj5nv4RHnLkQms8BgrXGFvsO34riZnvzO2a
         udDRdbr8Sa6FQ+AUJhfrJVF/+9x+fgZErNTs+YVViUzd+E7DzaHvY13xkVFNrXbYjAUR
         /w8SmXHHuvBpkU/LK/1Qvt1mkdHlhN87Ydwcy/y9Jdw6YJHMxLhNmeuO0nCodmyy1aEQ
         Ovwku1PgRnWfIkhHuaRNB7wV2VLhgqqVOe+Rp3LDgs0bdeSiWbIVYEmc9Qm9QRkbnEVd
         WxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729163465; x=1729768265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRlHPgRoK3euT9X0F0l94BRbMwnCMxRXdNGBoRIstEY=;
        b=tqAc729lVftmEmw81EMUtbceXK9kEO7tpYMXrOldiK3yGlZ/SW3O476wkNxAihWUOA
         g9EaCLXEFUqN+653IXpS/iM5ReKUK/5jrmRKdJKaCGxJoobj/FbFpRQ+IrSh/OhdEKvM
         s8nk2Q1mSaS3y6bWEF8RMyJHWuaramJqUR56gH8sbi/ZHugKBoFt947sIw5GfIEsUWFp
         XX+/dSrgnyIWMxTfgaJTAn1gYBlF/TfOZ52dpZWoTM9OAJXDpmSZX4NVsiOMWOoPka+v
         sxq9Y44q6Dn7X+pobVdDf9jp95uAUhOl1KERpN5qTnmscPRJYFwhKFn2AMkDCjNQuGrv
         BBcA==
X-Gm-Message-State: AOJu0Yy27/JucTLUiWU/7lvAzvt8agmTOpwkoUj9x/SVfWFN4O0c8SE3
	/hNG+5H0o61ABEicRKbBJxgESkJaAlcqv4+pn8N2mcHCskbbeZ0agJO0sXdH3kWpLB3vCgWLdVv
	baF1zM3aJweHRk1jfChRHDo+DF80R4MRp97Q=
X-Google-Smtp-Source: AGHT+IFppoN4+rEuPrlu0bQCQ6Wc+8o+qzbkta2/7qZf2Y7dBPp7XDnpq83hQa6Vpx/qVZo2IfwYOggAfuGrOzcwR94=
X-Received: by 2002:a05:6122:3197:b0:50b:e9a5:cd7b with SMTP id
 71dfb90a1353d-50d3771d307mr12513868e0c.9.1729163464852; Thu, 17 Oct 2024
 04:11:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zw8JFB/SUN0WlwNk@nand.local> <CAPSxiM_=9qjcrJRiwsSCOy-DvkmZH1ooNqLE-DGJJmtfYbVs9A@mail.gmail.com>
 <ZxArvQMURgclzEFt@nand.local>
In-Reply-To: <ZxArvQMURgclzEFt@nand.local>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 17 Oct 2024 11:10:53 +0000
Message-ID: <CAPSxiM8S0dpd=KoccNJrTcNYHjRt2BpgfvmSi-eWhanDxzaaDw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2024, #08; Tue, 15)
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Taylor,

Thanks for the reply. I will take note of only quoting the topics.

Regarding the two threads.

Kindly keep this(https://public-inbox.org/git/pull.1805.v7.git.git.17283151=
24.gitgitgadget@gmail.com/#t).
Also, It has been reviewed by the other mentors and it has been
integrated into seen by
Junio through this
(https://github.com/git/git/commit/4dae47e02757333b7d6a6508e36ccb5463b6ad92
and https://github.com/git/git/commit/dfdc6a71e76c7a1dab22fc9d9e437c858cfea=
6dc.)

For these threads((https://public-inbox.org/git/pull.1810.git.git.172877457=
4.gitgitgadget@gmail.com/#t),
I created another patch but it was supposed to be on a new branch and
based on the main branch.
It was not supposed to contain the previous two commits from the above
thread. I am currently working on it so, I will update it.

Thanks and I am very sorry for all the confusion.
Usman Akinyemi.

On Wed, Oct 16, 2024 at 9:10=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Wed, Oct 16, 2024 at 01:36:49AM +0000, Usman Akinyemi wrote:
> > > * ua/t3404-cleanup (2024-10-14) 3 commits
> > >  - parse: replace atoi() with strtoul_ui() and strtol_i()
> > >  - t3404: replace test with test_line_count()
> > >  - t3404: avoid losing exit status with focus on `git show` and `git =
cat-file`
> >
> > Hi Taylor, I sent a message regarding this.
> > https://public-inbox.org/git/CAPSxiM-Cn8ZSC+LzRfeyY+Z_Vfj=3DDguweQ+ZjC4=
dau-Z64dnWg@mail.gmail.com/T/#t,
> > kindly check. Thank you
>
> Thanks, I had seen this message, but it is still not clear to me what
> the difference between these two are:
>
>   https://public-inbox.org/git/pull.1805.v7.git.git.1728315124.gitgitgadg=
et@gmail.com/#t
>   https://public-inbox.org/git/pull.1810.git.git.1728774574.gitgitgadget@=
gmail.com/#t
>
> Can you respond in either one of those threads which one I should keep?
> If the answer is "both", please let me know here.
>
> In the future, please trim your email before responding When responding
> to a "What's cooking" message, it's common to quote only the topic(s)
> that you are responding to.
>
> Thanks,
> Taylor
