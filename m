Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830E8194080
	for <git@vger.kernel.org>; Thu,  1 May 2025 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746122430; cv=none; b=JmK4jw7rxb8AyKj/iCPykuJXXfPNnQ5KzYye88f46tigjQPKNCFFpmUaXEMxw5EJDnnIM8N6LKFwTGVTQXDOYUe3KV3EJkA1QGAHE8rhWoItqVealO1GG0y9XotJMJphkDs2LGYNBvLE1KVVz7q2Smc+kE5cVomFdPhlC8oDiNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746122430; c=relaxed/simple;
	bh=SBTerVFEXcd6BXIAj2g3BQDeGEz8IExwAtgwePOI4ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRGoThEuOwf/EV4gknqvsvkxWeAQnf/CS68RXoBaV1ZUEHo5QsQUNgPUfvf1QDfvQ4HqQgSYa9c7t7eJlZlQ1C9Vvo5vuEH6koB+XS3RdVsRSGQWoDP2jQO8vADfEU2+4BK19tVGZfP4qYLYOBbWNVkmo4B06eKQkD0zL+/cuVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yu+YE0ll; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yu+YE0ll"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so1818850a12.0
        for <git@vger.kernel.org>; Thu, 01 May 2025 11:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746122427; x=1746727227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uk7nUFnemGt0MrdG6lWwSvB3EFv1ttgkjSHZf8GqsxQ=;
        b=Yu+YE0llJ0d3IZX2wmf1dAwY/hbhvH79NdJsgiz0tjR/zq1Y6pH8/9J/htEf+jqTq1
         Ab19kf6wHrp/MDieZxFLSRj6n1SnWFrbX3TmDhyxKZkY+vaEiFu6lKmVBprFfud4AOML
         8r9Y3t+pgCiWlKf1/iilMrzPVt/G6byfprd5uNUZgQdczZhCMjM6KDAxxMZYT1rfINHF
         n15CutfdaHUZ5aYfPkzJ1kB5guElR+sA2hvQVGVR9QxZ+bbNTFis7BbVElZHgJ7Fk+UJ
         EzeYcSgEIYg0Y5S9HtgKUt00ZKU4ir5qTba+ykoQAWGS6hM85juCP9CsyKCeVW9xmef5
         GScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746122427; x=1746727227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uk7nUFnemGt0MrdG6lWwSvB3EFv1ttgkjSHZf8GqsxQ=;
        b=uqHI1/CxNX1/JgyPcy/EyiiRQAkQqT1UWrSWjHeQ4JsIz0nSkS3QAJArhW0d5ZTlC0
         TGZgvsLbjezzY8NZuSnlzzjKkvQt0lpYFAoS9xhJ7ck3JBoVeCm7Yn6C2cWf+R/9zFJ0
         4TDo94ZZAu/a1KrhuzY9LOrHfPV3G8atO/ajLflilRKrvsVQhQ87IkGz3oUAXsKYJjI5
         VeOuECTE3SY2qdZOYchg0Pjze9JN0X7f2SmIcRiwwArBCN1vD6I6a6tn5uSJJl7J78lk
         41+2VDJtjZqgJt5Pk5oZBaMaQUJKAV13urUKWPNeX3YWTOE4k9Y02CPSaIqsDBNYB5wR
         3NhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUCbtz6gQztUUwOcSHLPVCXSWKmwfNYBKZfnHgCdqmzDPw3pOyqDgvye6Dv2ug4/jVSYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFI19MA51Pg3a3AM9dP6QWq4DFinX63ezPP7LxWtLxKtS6f52W
	FSeWEsPLWm2FV4fglW1VYRTLP9AsZLZQDaJhdoyZbKKDmc0syLanLUYv+GRjT8lsqZbLHVfmobe
	Ai9lfGFhaJIwGh7bkFYYm5j/N8XA=
X-Gm-Gg: ASbGncusGT/wqLmjCqkG55n1zKIcczni1J663eClA4Jy3dWZLe5yPmZqv7vjbDLQRZl
	Du1LjiVeKakMUmgZjg5ch/yzG9cVNLTAJvIyaFVtQqzr6hMxU8e4Dnqs3UR9JNMD0wl9Ny4e9Mx
	aLXIzgGn62qL9A073UGxHBgc17wktdy2LYGp7qNbydliKUdX5IvXeupB9N
X-Google-Smtp-Source: AGHT+IGJ4XsudTqMjXfB3TTj5+01MxFUOIPpuDKv0zfXHYbkolVx0fyN2N77VIUeE41IkzowCsiLn59DhDKroT7I8bI=
X-Received: by 2002:a50:cbc1:0:b0:5f6:ace4:9fa6 with SMTP id
 4fb4d7f45d1cf-5f9193dfcccmr2288395a12.16.1746122426621; Thu, 01 May 2025
 11:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAms34P=fuow0kvxvQKxbr0jhqjnBu=VsP=xAxDieG-QA2ocVQ@mail.gmail.com>
 <CAPig+cQ6L60gRGZqapkVdGjo_C_k4Wi1miK8nv5=AZeNXnK_4Q@mail.gmail.com>
In-Reply-To: <CAPig+cQ6L60gRGZqapkVdGjo_C_k4Wi1miK8nv5=AZeNXnK_4Q@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 1 May 2025 14:00:15 -0400
X-Gm-Features: ATxdqUH4DxZ6qSqWyDTYah36vu6EIgYPpJIRvbEJ5VzwH5D-cPherJmVrDQCXBI
Message-ID: <CALnO6CBXqZ76iovr6JQq439RTOR6E+B2sivKWEEFtBXMj2EZXQ@mail.gmail.com>
Subject: Re: Feature request: automatically read .git-blame-ignore-revs or
 allow global optional config
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Michael Grosser <grosser.michael@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 3:55=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> On Fri, Apr 25, 2025 at 2:42=E2=80=AFPM Michael Grosser
> <grosser.michael@gmail.com> wrote:>
> > I have many repos where I use .git-blame-ignore-revs,
> > but I cannot set it globally because then I get
> > ```
> > fatal: could not open object name list: .git-blame-ignore-revs
> > ```
> > so please make it either the default for `git blame` to check that file=
,
> > or add a "blame: ignoreMissingFile: true" option so I an set
> > ```
> > [blame]
> >   ignoreRevsFile =3D .git-blame-ignore-revs
> >   ignoreMissingFile: true
> > ```
> > and can use this feature without constantly having to think about it
>
> Relevant threads:
> https://lore.kernel.org/git/pull.1947.git.git.1745088194384.gitgitgadget@=
gmail.com/T/#u
> https://lore.kernel.org/git/20241014204427.1712182-1-gitster@pobox.com/T/=
#u

Did that second set of patches ever go anywhere? It seems similar to
what Junio proposed in the first linked thread and possibly worth
resurrecting. (A log --grep :(optional) didn't find anything.)

--=20
D. Ben Knoble
