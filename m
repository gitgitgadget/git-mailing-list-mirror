Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531B73B52FF
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 05:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792388294; cv=pass; b=NtH8kETw0fd4OQscYzt9GvvTzRUz+8S6+INClngsgH1Vrcx50Yg26SPdDkZ0ybyx204qOQ1TYNE0j1DpbE6mQBU0Smpoa7ByVZYT0jIcy888iqwR1SOltyxns+2GSPgGjlMegcUDePV4nWkoBnfdHBKtnpOS+u7aOPaFsZ5L3ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792388294; c=relaxed/simple;
	bh=j5ORYKHrNfxZwtqQNWKo/ZJbpUXzhstH38acFeTu+No=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEezr3t15LiFqlKQFVFM4pINAQKrgzKEjtfxbalEkimmexqeF7ioq/ENd6qBUrSJELq7lxquuE1mQWKv7G9XJ6TPZDhI1+8INJPT1lKWPkbNkVxy2LU9HLdkIobCnkN0KhQoXJTey/aKYEYnumjAPGdbSzct5bd+YFCQtoCJeWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Du0VC+lN; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du0VC+lN"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1517bda04a0so922708c88.0
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 22:38:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792388292; cv=none;
        d=google.com; s=arc-20260327;
        b=XS+XBPpINhaOpTbfA1Juq/OwL6klnIqMb+deUY5D9SRi/bOmso7LvpUgz0kpAyyu1b
         Jlyaerk0shvYMiNJq+Z6VoQ3M0WkQNizlA2jkk7coZYYa7t8R3zup92ZRlw0bPGO8yKx
         6dQOOweW+RUWtVwVbQQGtuumPQCcQORJkBRO2/aDN/u2ydvoyfRyIipabomo8DbL1NA0
         ld0bPz2jgxInQmobEJ9BLYhgN6Xm1sNBxGLkSWiXRVrHh7FyODLS6neDfAzb28a7AYOE
         P2T3lCiSsLyKIqfSAsu+aTqfYM+gSHY/3MszFA5NOgiqFs1OIPaVFngM6iRNV53qYKFY
         IQRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j5ORYKHrNfxZwtqQNWKo/ZJbpUXzhstH38acFeTu+No=;
        fh=ZkYjr78flXmpkLw2Oja8zmEvPg5skmwCOd0lh9orgVs=;
        b=IyeSf76iGq6dbCogGsJ3zamHxWUlUBhq9T/FQ1aHDDnUWHthAsTzSSs6orhm5jkEQ4
         JpStFNyE0qagTHG0ix0LQtjnpSCUt7X8FZZm6g3Rvw2WbUrk7ZlOdJluIVS3/J6bLdu9
         sFvron477WREfGfPYdeYgNcN3GnxKhaKR+zYAGJW5ge9GEubHDU0SSMcUKmC6oS45LtI
         IM68ZqWxq5mVqObeUaFMI+fri8rXZVyjWpD6nZEXS4rCmwgiRLXmrLxw6L4nxhqe6CrP
         JNzcgB8xNmE9E+euGwPwrCzAe5KbD7l9Hgoc95ZAZbdGQ0bcD2mtOcp2FjBRk6dOOWtZ
         SRhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792388292; x=1792993092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j5ORYKHrNfxZwtqQNWKo/ZJbpUXzhstH38acFeTu+No=;
        b=Du0VC+lNEzQrOhoIVNwOsB6oZg4nqrFvwuHzNP/Ba4kDctv8LV9/PGCilqgwkX9YnI
         JspafH7koI6sBZLDUBraLAb3PRev/6n2XuXR//bxHAnPwW4JS/gTDMXcXKH18RnnnCWF
         JV/pZYk6TXXJPq/PiGZV07Rjn1joC2H79U/aI/R65tcyFWMx6SUjCgOdyBfeqGAXBB8i
         ntrq+h3Vz4qrZ7fO6co1KBIr+7FuHKKgSzspH0NUy3b/yat8EHWIRjUAcxEUaJbdVOLo
         eMDL73v+PKGCEpMghiV9FqWrIxxomXo29p0PuRWWLtI1M94Hqc9Eas2kS8/6tyO4/UxP
         kfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792388292; x=1792993092;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j5ORYKHrNfxZwtqQNWKo/ZJbpUXzhstH38acFeTu+No=;
        b=10+/H47IRB5x0dEVyTQvX5RTqU/QXH3CSMW6QuZApdvTnt8YDci54TvhEvMl4YBPHu
         uiVVM4RnbYAIjKjBhEaOpk6x5JKUsEYNtsoFxp1eykHa7C11dENcrsM6Y/XzlrlFFEWZ
         dN64aOZrTItJ7mkUHU52IPxeOVfE6BidV0KMjM+8g/SCa6W2IdLjmAvbsxGrOllljsf6
         Z0SsEifbutRh1QfhAaE84y6fVgLXHlwbZnEFRr/4VtGtZhOtrhNisKg68Lgaj2d+IXLX
         12B6y2EkE0P1ix7ZlHO/gemuDlrM9GcL0FsuEmwHuw6/A6zjvuBNyOozCrEtsqt7KmfW
         TukQ==
X-Gm-Message-State: AFq9FYImzCQhFOcWQu2A46UvDcKhbg+AlPMvIkHFw92QsrFsQnADYE2f
	0w0Fw/9FUNOm4FUj9Uxv3ZHg6QsSrgCVaGR9/nHaG8+no6rGePUUH/LSCTGRBL4MkunT9mv2BQg
	b1NBLFEUjOIKcheibTKw1z/EVN4HMuUU=
X-Gm-Gg: AYBFou0uuoOqQ3eEKZ+8TK21TWm2MTZSWaJOhj98wuw+AJzqa2Grz727dyapxsLS2w4
	jXcRLMB4NcZbGdzNRJ3y4azi48BCjwhk3GlnP9sHMkbfmyFts1Kpqo5yIa2ynjYRS9+nlx2tueq
	KTT4o+cItLUPfXrCTayOPzoxmKaqNXomPpHV9dgi3m8q2M5cpD2jMEfeggp97QQc5VhgtOf1jl/
	tK8Qv074lE+ltWOo0Jt1rE5BBwIJre8Atgk5AKdeyhziks+901R1J1PmpO/j6TuZ2dFLsnr6cbj
	b1tmsbp+/sLtNlu4n3+to+XRX20Doj/64bfszGVI4LDGf2AH+dnchNyoEraAoH2H+z4bpUNnWCW
	Gq+EubsImtqnmOQuDbw+d1E31c8xYYUsB9xVmiABLH+/qh08+fwqk/BBwd/Nk134zKwou6rvqiA
	bYs4nzZdfQ31cDaR5cXJoBTf1qQwt6cFMubN46PKq8
X-Received: by 2002:a05:701b:2712:b0:149:1b5b:1f25 with SMTP id
 a92af1059eb24-1851160d1b5mr10034998c88.15.1792388292280; Sun, 18 Oct 2026
 22:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqwlsei1pv.fsf@gitster.g> <76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de>
 <xmqq4ifhgzvx.fsf@gitster.g> <5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.de> <BEEE94B1-EEFB-48CA-8B45-EEDB10FE244F@gmail.com>
In-Reply-To: <BEEE94B1-EEFB-48CA-8B45-EEDB10FE244F@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 19 Oct 2026 07:38:01 +0200
X-Gm-Features: AclHuK-_HLYl-IDKaTvJhIJkHw9OBIHLyzAfE0Y4g0ndN4HVxFeL5AMcAEVAvAY
Message-ID: <CAP8UFD2aacVCDtOS2iTVW-tB8Ozm8K7oaiFSVk3X7infx0TODg@mail.gmail.com>
Subject: Re: My summary of the Git Contributors' Summit 2026, was Re: Git v3.0
 timeline, was Re: What's cooking in git.git (Sep 2026, #08)
To: Luca Milanesio <luca.milanesio@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luca,

On Sat, Oct 17, 2026 at 11:12=E2=80=AFAM Luca Milanesio
<luca.milanesio@gmail.com> wrote:

> > SHA-256 support across the ecosystem had been a blocker. GitHub reporte=
d
> > experimental support, with general availability expected around Novembe=
r.
> > GitLab already had public, non-experimental support, and libgit2 suppor=
ts
> > it, too. JGit remains a gap; Google was not planning to fund that work.
>
> It looks like the above statement needs amending, see:
> https://gus26.gerritforge.com/schedule.html
>
> Google will present their plans for SHA-256 at the forthcoming Gerrit Use=
r Summit
> and jj Mini-Summit at the Google Campus in Sunnyvale CA.
>
> The talk is at 2:00 PM PDT: "SHA-256 in JGit: Why, What, and When (Xing H=
uang - Google)=E2=80=9D
>
> Anyone joining from the Git community?

As I have been kindly invited by NVIDIA folks to the November 11-13
hackathon (about "making partial clones a practical replacement for
Git LFS across the Git/Gerrit ecosystem") at their offices in Santa
Clara, I will also attend the Gerrit User Summit on November 9-10.

See you then,
Christian.
