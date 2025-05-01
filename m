Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED53E44C7C
	for <git@vger.kernel.org>; Thu,  1 May 2025 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746124150; cv=none; b=a6DKtx3wxkXi+wYE9vbhQ0CLjYEMABoTo20qEUpGmXJm/otNNHPZ4RMN22B9GqRWpbs8sDew+46anLRLnaFktUhLbkJznAtzShD63WJDWkp/HAnL2i29skTuqQl97wM4HD8+hom8Hc+FRvAluf93uxqA3kya3ZWIdqhubB5zmLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746124150; c=relaxed/simple;
	bh=5dZ02tuz35sDK3dvKUHBbkbjTfG2nh4qTbBxLRKy97o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9M0OULpwiy1LSv/HFey36osjpHfDDDoTAgH2QdnZLRZtCnW5TIIcRd/gQVECyWzMrLcQnUy1wXfm72UV8lGaLgXnLfJiMdRVqjeV9xTNRvlOSq+ogmea/DhzvHe5cHOR+8uQHpiFUIL3iOXyFP4awePT9OP+BnrRG8dwiWs7Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6f0eb824f51so1765546d6.0
        for <git@vger.kernel.org>; Thu, 01 May 2025 11:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746124148; x=1746728948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dZ02tuz35sDK3dvKUHBbkbjTfG2nh4qTbBxLRKy97o=;
        b=GC31g6Jv9EqVDytl2MmFYym193CSuLdOWTcOIUYeEN3nk3FMz3j3L68zWlK0840E++
         5EhnFfwCpPL1apEmR3Ekop90z81WpczrJkM9FULRIb6Qaf8IhEz6uWh1PqNO0+mCZYtH
         maUSQK8pAedTMe5aC0kNb9vfYS9HuNv073xiwTRqC/pisxeNBry2xB9qDch6ZYB3Ir9w
         C8bpLqs58SnKjmCALvlwXzGWbn+DD5HpXdHqURlIPiW1fIeunoK22Hr4izc+nPvpul7M
         7rW871JM+G315usuq27tqR7OJsnPQqkd1N5rxaT5CvLjDwVvx4algv01HAS6ninrAcTp
         OzZw==
X-Forwarded-Encrypted: i=1; AJvYcCWuhxz1Taj8JLfKRAo87PZ8uxPgDoRgbm5oH5EF9ojTsRLrHIyIgy4IrfB8jQTsJSXZBH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfQczwcRgBv86rWMr6q8Vf18i4OlfhvRFZRRI8Fxu9oi+thND1
	eeDqAK+PrEq2CUEJ8icZUWweG08+DpUytj7igWxYbdlNadIj3dcFYjRrX3ndN++zhlpmF81uu7b
	PQH48Z5cY7Q1HHTI4JalzDrDB77KdbJ+8
X-Gm-Gg: ASbGncsE6ItmhjzEzIOMagwxEQBwCKFUlsfqK/VDuvKpPfUCFtqxDECPrqdaa3QivKy
	rlDBNTppUuz4NUbA9sQW6CKLbd8ZItDarhRujBQqH0vFYtpK7aorDerYlCL2jL6aao/P+zrPPiU
	5z+RMPHOTwTPbHRdxM0Rrc48mn3x+DOCst2fJ76j/M1OYexeQO7pK9r2E=
X-Google-Smtp-Source: AGHT+IEBplC87jrUnFj5EB+JugXAmybXXdTFGmU0JZn4LA5NmTrioabV6ZoewYFXJLKMk+xhocDBd2PS2LGzFvhiObs=
X-Received: by 2002:a05:6214:224a:b0:6e4:501d:4129 with SMTP id
 6a1803df08f44-6f51563f041mr1494116d6.11.1746124147842; Thu, 01 May 2025
 11:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAms34P=fuow0kvxvQKxbr0jhqjnBu=VsP=xAxDieG-QA2ocVQ@mail.gmail.com>
 <CAPig+cQ6L60gRGZqapkVdGjo_C_k4Wi1miK8nv5=AZeNXnK_4Q@mail.gmail.com> <CALnO6CBXqZ76iovr6JQq439RTOR6E+B2sivKWEEFtBXMj2EZXQ@mail.gmail.com>
In-Reply-To: <CALnO6CBXqZ76iovr6JQq439RTOR6E+B2sivKWEEFtBXMj2EZXQ@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 1 May 2025 14:28:56 -0400
X-Gm-Features: ATxdqUFYens_yJKPEO5SI1yrJwABZVgJ9QfzXzr5bQy8tN9FXLd5KatVSQ40YaA
Message-ID: <CAPig+cQUycUyto6=cDadaCahzDBQ_GDngAEEtK0bshLr15ok8g@mail.gmail.com>
Subject: Re: Feature request: automatically read .git-blame-ignore-revs or
 allow global optional config
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Michael Grosser <grosser.michael@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 2:00=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com>=
 wrote:
> On Fri, Apr 25, 2025 at 3:55=E2=80=AFPM Eric Sunshine <sunshine@sunshinec=
o.com> wrote:
> > On Fri, Apr 25, 2025 at 2:42=E2=80=AFPM Michael Grosser
> > <grosser.michael@gmail.com> wrote:>
> > > so please make it either the default for `git blame` to check that fi=
le,
> > > or add a "blame: ignoreMissingFile: true" option so I an set
> >
> > Relevant threads:
> > https://lore.kernel.org/git/pull.1947.git.git.1745088194384.gitgitgadge=
t@gmail.com/T/#u
> > https://lore.kernel.org/git/20241014204427.1712182-1-gitster@pobox.com/=
T/#u
>
> Did that second set of patches ever go anywhere? It seems similar to
> what Junio proposed in the first linked thread and possibly worth
> resurrecting. (A log --grep :(optional) didn't find anything.)

The patches Junio submitted[1] did not go anywhere. The topic sat in
his tree for several "What's Cooking" reports and then he dropped it
because it received no response from reviewers[2]. I agree that it
could be a useful enhancement if resurrected.

[1]: https://lore.kernel.org/git/20241014204427.1712182-1-gitster@pobox.com=
/T/#u
[2]: https://lore.kernel.org/git/CAPig+cT1BNXRotrz=3DrnVgvhQjZZwYgsAOQMonHF=
FTPfK-C0LOQ@mail.gmail.com/
