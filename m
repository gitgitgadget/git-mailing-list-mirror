Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0AC21019C
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 22:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757717829; cv=none; b=kBuuvQMPpRDa6TSc6ugbu4GertdNamWdU+XRHR+EvozsYLuFSb5PsbSGmHqvoITb3OII1e+8Ifdf4CcreNOvlIzezDjMuFqMSGfRrJIqGda8uk4pBynM/BrtEMeHilY7O6P3MrrHfbmSa0kwQMM2CpYhqe2UbBKACAn6Brw+CcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757717829; c=relaxed/simple;
	bh=3CBvgd7JLmLsYmzjGZ8OW0rmi7JMzwWRQZokA6iEJlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVfyRkeoqI94mCNvD8r9CnyvEx3nCyUWY5+adU1yU2GNzOQ2k35gdzzZWwgeHlK44Z491OSfLsFmlLXeyjAPuT05NSfbjmTBF4ExAnF+TWlX1QVRwb+q7onXqdp5xlvPw1dS2A1H5sgaxZ1v0BaPwTEL/lfSisniOcnGTEz40pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOUhkk3s; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOUhkk3s"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-40f9e28b09dso12183465ab.0
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 15:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757717827; x=1758322627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBF9GH03yh0gbA601l55KVf3ZnZXppxj4+WVY+nawhA=;
        b=AOUhkk3sWh5zOulonCKywFbWDVoOK+3cUU+YZKPOVfY6N8NhStTEVCrsF8+8B5UDKo
         34x3C9GCNUFt4lcwR9BvYvVAMi5thvRKz1k/KvCcfPGicrGMQJdOC2y29vlXoHwTeDvW
         Z9qEb8kNmqe3UhwM8wbCIkUiA6TPRg5JZpA06hMtP5waHfBWV6dDdzvFnH+ldUkP/5ao
         hioN7E0u3Kj8G/KCIAXBlf+3HXuOYXlKIznqUiCHsJaGS8lB9johfriqgAfPJA6stMZF
         atN8eNHKgeVRQRrMflaMDAknk+Sa+SXRL4TeVpAWKUhz0puyoN9jaZqrXwQ4D36M14iP
         eLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757717827; x=1758322627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBF9GH03yh0gbA601l55KVf3ZnZXppxj4+WVY+nawhA=;
        b=ErLluXdgQqfZMGjgK7rdvrH7FHW0ECcVjGtXOZ+u0LbevDmiGyjmEVKItUUNUvH0zi
         ZhEKZwiDVkbxARUp2q+ccOqFk5NvHGRNm2JDRLYA01l/HIS9Fegd6TudM4r0b9hO0D73
         UQjj7SNMOerAXgIkBmd3REhdOYhYO5XyCPG73+B3AigV1Icpz7a9v3zsGTz4KQtwPZhO
         EdE3InTXhNSJRcgacrUK6vbEA2rdiGdqOuyz1EXOQMwF21lg+ez8jXkZ5B5nVN0jymQ/
         0xwvPY1xWbTFZ2CCH+BCIOOl01CybRkmrbTCUS6Z4TH6NRx2Z4lSFaWA7qeTwPdFB8Fk
         b6sQ==
X-Gm-Message-State: AOJu0Yy8Q9r/5HC49oHVskleC7Z//joaZ3v0ARUiyz9QXYx+YwluX+1M
	5GaJNsNGubyVmatJSefWdIeEr/PyVx1E4zKItSE2njR27vhAnUumpFZx1/FZrjRMqaAF2VuUSqd
	8+OqXoseWjK5Vk/GLFHDRjlEi1dqxne4rZg==
X-Gm-Gg: ASbGncsZjop5ND3ecnjWnnQeNHcscfTHcjMH79Fk57+ZxZjAw6r48Ilq1n+YOwfNISu
	EunJM32sd2b9bka/EjEcpgfVw8HQuLgDdq5PY0xOsc2I+p5I+yALyS8T3Ghc7X8QsURzVmfiJ1j
	7aEfbNcxfooodbWg8SO0j1iyG54Vgal1KNw9GhMHdwW/lG7J0HtT4hs5pu/b1spYZnCga+48xSu
	V7L9e1ldQHqOIJSIM7AEntvCEiBJ4ujzp7PmWRyMbfdNDDRzyhX
X-Google-Smtp-Source: AGHT+IEKdxg405JNePcZ7hbxy6mw4v85wGawubWwGCm5B/CIAZOfbmkkb/ETyQAMnpEhfhWS4/xid21G4McWPneoGCs=
X-Received: by 2002:a05:6e02:194a:b0:401:9e1:ce68 with SMTP id
 e9e14a558f8ab-4209e36cd6amr76984535ab.13.1757717827059; Fri, 12 Sep 2025
 15:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SN6PR03MB4285CA9885AE7952EEF762E1AE08A@SN6PR03MB4285.namprd03.prod.outlook.com>
In-Reply-To: <SN6PR03MB4285CA9885AE7952EEF762E1AE08A@SN6PR03MB4285.namprd03.prod.outlook.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 12 Sep 2025 15:56:55 -0700
X-Gm-Features: Ac12FXxO06ABuVuoRsyVd8CMEaUSYc_lerABZgCn1mA39_4pxyHBW79UuEYtZ4Y
Message-ID: <CABPp-BGeZ6no5LdBGKjykQLqUHRjFis7ZtGdEwnzg0gy_CkLqA@mail.gmail.com>
Subject: Re: [BUG] git merge sometimes loses changes from one branch
To: Guo Tingsheng <CoriCraft16@outlook.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 6:41=E2=80=AFAM Guo Tingsheng <CoriCraft16@outlook.=
com> wrote:
>
> Hello Git developers,
>
> I would like to report a potential issue in Git's merge behavior, where c=
hanges from one branch may be lost even when the other branch does not modi=
fy the same location.
>
> Environment:
> - git version: 2.43.0
> - OS: Ubuntu 24.04 LTS
>
> Steps to reproduce:
> 1. On branch A, modify a file at a certain location:
>
>    @@ -1026,7 +1028,9 @@
>    public final class AutoBuilderCompilationTest {
>                 "  }",
>                 "}");
>         Compilation compilation =3D
>    -        javac().withProcessors(new AutoBuilderProcessor()).compile(ja=
vaFileObject);
>    +        javac()
>    +            .withProcessors(new AutoBuilderProcessor())
>    +            .compile(javaFileObject);
>         assertThat(compilation).failed();
>         assertThat(compilation)
>             .hadErrorContaining(
>
> 2. On branch B, make no changes to this location.
>
> 3. Merge branch A and branch B.
>
> Expected result:
> - The merge should retain the changes made in branch A:
>
>    @@ -1026,7 +1028,9 @@
>    public final class AutoBuilderCompilationTest {
>                 "  }",
>                 "}");
>         Compilation compilation =3D
>    -        javac().withProcessors(new AutoBuilderProcessor()).compile(ja=
vaFileObject);
>    +        javac()
>    +            .withProcessors(new AutoBuilderProcessor())
>    +            .compile(javaFileObject);
>         assertThat(compilation).failed();
>         assertThat(compilation)
>             .hadErrorContaining(
>
> Actual result:
> - Git sometimes produces a merged result where the modification from bran=
ch A is lost, yielding:
>
>    @@ -1026,7 +1028,9 @@
>    public final class AutoBuilderCompilationTest {
>                 "  }",
>                 "}");
>         Compilation compilation =3D
>            javac().withProcessors(new AutoBuilderProcessor()).compile(jav=
aFileObject);
>         assertThat(compilation).failed();
>         assertThat(compilation)
>             .hadErrorContaining(
>
> Additional information:
> - This issue occurs even when the other branch (B) does not modify the sa=
me location.
> - It appears to happen non-deterministically and may lead to subtle bugs =
in real-world merges.

My only guess here would be having a non-unique merge-base, where one
of the merge bases also introduced this change, so that it appears
that A made no change relative to the consolidated merge base while
also making it look like branch B undid the change relative to that
consolidated merge base.  But, that's a wild guess and I have no idea
if that's related to what you're seeing or if there's some unrelated
issue at play.

Can you create a testcase to reproduce this, either a repository that
others can clone together with the commands to trigger it, or a bunch
of commands to both create a simple repository and demonstrate the
issue?
