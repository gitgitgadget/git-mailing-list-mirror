Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361D912B64
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 04:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728275077; cv=none; b=j6ENz+uuROzga9TIj+d6D0ie8AY4M8B5QC9QtSsWxuccAHDKoquuIIEYGFJAK/pNPHrw84zAJ47CdRso6gty0ezP8uXepup3Kllboye/4JqzLf0HQQ2/eWIcfU1AmldLe8266nhg8niNhx1//RFSBdNc0wbtbDaa4aqgyd+EQo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728275077; c=relaxed/simple;
	bh=9Q47ZTDhHr5pOajq9siCKqw+1k2kVy0sUSRg1JC8Qog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ia6WQG+q/8eXGSAwgjpP+0+06fo8GKtXatdVyCv8zsxX+hztZS7mhQmnH5x8+dJiFigUMiIhgr+DY3qTVX2I4vLdtu4jTOasAIJdOtFQD16NtVw+Qsom+DCpou5lUuXFZpVU+8bsjcY4rpuEz77ZCcuM7or/sbmuCgISe2dCsZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cb316db199so6134096d6.2
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 21:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728275075; x=1728879875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pN6SazN9aigkifhtLn8UgZwlFNF71xRA9FBIxEQI8b4=;
        b=Q33mqX3rRRk39lhdW4Kt5XS+vmXcDw5rx3PkICJmeHwmEphkxdcN9cepSPdhUS+stn
         GqZ21EKt/woIJrbqQQxVDgISx4+lr4HyRvN4SZixfq9+114xc4uPe8UToYWBUBFA1FQ0
         MKnrBKWvIcnVYE1NpsfauWzuP5IKpjHLk+aAU1nqnEyPvYEaiB+sX4iFZtEMhl+NWAZG
         V6rbUIfnUKdn+h45juJfsACaCpMitYqoRgXjfJuuXRczPkjTZXXb3Jm5SMMoSgTdMQJ1
         McfIRQbiDNVmCja6NCFI+aQD/16gljoYfMMPPnEOl2Qz9LOTTmOg/DOSD6z3xHIHwhTN
         5e9w==
X-Forwarded-Encrypted: i=1; AJvYcCXUez4TnL2cELvoK0u9pTx7J9G31GCPs7hF7YUuW00Fe5R4SsURrfGNn3gvk4JEvSE+udg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjxJCMW+WzmyrbzplQWWzJ0gVMtHMO+XkrsxQ5fgQu7s0r4jLA
	4bJBWzztLGm3H4+u7AIGXwNMLiNo6wSdmIS94ynGCuJjqoozPBwGD5wuaFgDJATj/l50sFbD9qL
	hiAIKS8uWdltWjs8FSbSYZESvg80=
X-Google-Smtp-Source: AGHT+IHtzRiedIT6uxmkoKz954Vt4sleo305eygZRkl8b/PA7pVCP/R2jUp00R4hqDrWIn+js8uVSx/FXUNEAKtdUj4=
X-Received: by 2002:a05:6214:124e:b0:6cb:4a88:8cf5 with SMTP id
 6a1803df08f44-6cb9a2f7f81mr77049686d6.2.1728275075040; Sun, 06 Oct 2024
 21:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com> <CAPSxiM9eExGxy5biEr_23tCKXaUQg=tsD57VR7e2SVdvVJR+Kg@mail.gmail.com>
In-Reply-To: <CAPSxiM9eExGxy5biEr_23tCKXaUQg=tsD57VR7e2SVdvVJR+Kg@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 7 Oct 2024 00:24:23 -0400
Message-ID: <CAPig+cQ1xC9ky8+NZO0ywmYAa6Vxe2ZUbs_Ae4OTTcWM8tHY_Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] [Outreachy][Patch v2] t3404: avoid losing exit
 status to pipes
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <christian.couder@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>, shejialuo <shejialuo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 12:18=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
> Kindly, help take a look if this is okay now.
>
> Also, I wanted to change this also to use test_line_count,
>  test 0 =3D $(grep -c "^[^#]" < .git/rebase-merge/git-rebase-todo)
>
>  But, I tried a different approach and the test kept failing.
>
> Similar as
>
> git show >output &&
> count=3D$(grep NEVER output | wc -l) &&
> test 0 =3D $count &&

What is the actual error you encountered?

By the way, we have a handy function, test_must_be_empty(), which can
be used if you expect the output to not contain anything. As an
example:

    git show >output &&
    grep NEVER output >actual &&
    test_must_be_empty actual
