Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BA71885A0
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728288704; cv=none; b=kkyezwGOn/3qYyXniGKIj3BWjB/YlP//yPvN8N2RNocSQkXYPpGNyhBsUK0CxTCVGKXcuGzeRH1MxSnap6t0FQL6T8Ap+kgy4+gT/uRuY5qU/dDP9pDLn3h8hzfwiAe9ijXaZ1hgDWXD5gJuThxxGSRPfXtci46QcjD3qmn/Y+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728288704; c=relaxed/simple;
	bh=aedWBTxNzMdJrpTf6FhPfr36GlPA0MC1AFhqIjn/EBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNMzSYxkQ/uPgfiF9hWiSyG+vgkI46zh7a+CUmQnXENoxniOvjHdTjvElG+UtE6dP7vhpV9MGNhEOoiSq2Mhtrkm5vPSxfItIxr46prBCGvTFz1waRpTsi9yW2JVxgAVxsDirTftKlOpoVeKRCixuwo26yoOZk3yRWoXQI7FEhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cb36237f28so5971886d6.3
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 01:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728288701; x=1728893501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aedWBTxNzMdJrpTf6FhPfr36GlPA0MC1AFhqIjn/EBk=;
        b=tnknzxKJ7mjzc/YpKw501u2RdNNYXTeoT5BgvIDMhmFffcrNXjVOiHfERVwG27fAln
         q47Am6HL0wJGvtaDkZJpY+2G4Mh1CE2cax+lbV9ubx7r+ZAb0kDX0J6ykoWQkujsInJl
         p3KKrEOzZF9p+UjazKK97HpXIThv6BuZHzWhzNzUrQbkFwizC0F6rVwIMx5JWaNjWPHD
         RFJNEzPzvCfh6hzDTnWC4BT8Fu/0Tq8qAsJB7+V5IpkDMH+4Iy4X0aapveqTc659+GSW
         Bq2fRV/MPQ7i0duGfiT+ZFsIBr5KTiE2Xxux55q9EK8bHdtoD9it9qkYbcQdLGlFYTov
         k3dw==
X-Forwarded-Encrypted: i=1; AJvYcCV8wgODjmwunhDoPWNENKAXUxsBqkkWmJEvM1NsY5RU5yVGKP8VTu6djo4u4z4S4g6CepI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK8VO1egJakpvqD+oYtNaI2PSsSKQ6Nqwoj700rDvqcU9gnwj8
	u2XUVqrigL5wLywKHUf+1KgdxIh1EoKvEJP0lDgg3iFHEQ0EDCKzNXm8VQnIkNesacI+wa3cOyp
	uQfJjfPchKsIRWscYSM9caiGv6+s=
X-Google-Smtp-Source: AGHT+IHBhtRnZ/YtEbZ0mTmfh08HYilhf+641QGHKsXEnIkIKrPhMYT/oyh5kwNqD37k4HT+c4M+bwQkP/xqraHwkcs=
X-Received: by 2002:a05:6214:dc8:b0:6c3:589b:7ab4 with SMTP id
 6a1803df08f44-6cb9a4556bfmr83488696d6.5.1728288701123; Mon, 07 Oct 2024
 01:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com> <CAPSxiM9eExGxy5biEr_23tCKXaUQg=tsD57VR7e2SVdvVJR+Kg@mail.gmail.com>
 <CAPig+cQ1xC9ky8+NZO0ywmYAa6Vxe2ZUbs_Ae4OTTcWM8tHY_Q@mail.gmail.com>
 <CAPSxiM9Z3q5Oz0PkadC72J0cU2F9D8Rh5eAtNz7aZoUZxp6PUA@mail.gmail.com> <ZwOW96K1_12Kzefo@pks.im>
In-Reply-To: <ZwOW96K1_12Kzefo@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 7 Oct 2024 04:11:29 -0400
Message-ID: <CAPig+cTGESaCMfCzP7Zt3Y6JmG_uroCn1cd6_12W1QKLU7hk8A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] [Outreachy][Patch v2] t3404: avoid losing exit
 status to pipes
To: Patrick Steinhardt <ps@pks.im>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <christian.couder@gmail.com>, 
	Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>, shejialuo <shejialuo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 4:08=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> On Mon, Oct 07, 2024 at 07:25:44AM +0000, Usman Akinyemi wrote:
> > test $base =3D $(git rev-parse HEAD^) &&
> > git show >output &&
> > grep NEVER output >actual &&
> > test_must_be_empty actual &&
>
> That makes sense. The expectation here is that `output` shouldn't
> contain the string "NEVER" at all. And as grep(1) would fail when it
> doesn't find a match the whole test would fail like this. So the below
> would likely be the best solution.

Thanks. I was just about to respond with the same answer. As a bit of
extra explanation, the &&-chaining means that every command in the
chain must return "success" (status 0), but the return code of `grep`
depends upon whether or not it matched any lines. In this case, it
returned non-zero which caused the test to fail.
