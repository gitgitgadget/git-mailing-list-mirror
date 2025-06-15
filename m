Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E2B29A2
	for <git@vger.kernel.org>; Sun, 15 Jun 2025 00:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749947100; cv=none; b=SFQ26D9I1/q/VuByeLBrC+paFYMgCrTzvZCK78HWMZneq5UB0O6fj0SSRo9TgAzYkHKNQtFWiGNN5YUTylbB0p4iTLba895mE11nQci7Lw6XBFOI6AQMMuBk0+h6rKlvhmi8v+nyQyaS2Yaz8fa3kIyOQ/lTecAospqJ2NnJ1Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749947100; c=relaxed/simple;
	bh=aZ0RwGa3QQjkWnWj/5eCPt23wwxSE0gtIS29SBw1/fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxCVikRqNIsaCq7ICW55QUWyKimETvXSHsHgZYTk0BDOxcSDPfzbwg3wUZy+NvtuZrHEn5RbktUovL9TuxvkZ+9Aq3TlgKh8SrwWwFyj1VoqqSgXyPQ/NcbcTJTufbz/1WdXk38qrEw+BdmKzUSJQf4V5OmykeEzrNNGraYarIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1WoQd/L; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1WoQd/L"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c597760323so353358985a.3
        for <git@vger.kernel.org>; Sat, 14 Jun 2025 17:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749947098; x=1750551898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSYgU0M+OO7kKXGwRrcoePh99egJQHynCHS9eQ2jlT8=;
        b=G1WoQd/LKAUE0C7ssaQnhWqPWZBNWyBAFgkZ4cxIJLpoLn1uLKBGo1pzTmuSL/Ov77
         qziusx2f9YqGIQVmycVU6nHbBj5QgTOUnv9QCi20cpCymV2Hytb+bOO07L+boz3RF8up
         IlInZNRWxxiu+rMx2df/yR7aAh5i7W5G+uX+SCEaSkJhIMkmCwBr2uFaQG+CEtKMGVBR
         8RQili81nSfjJV7TCPnWuiz1uRGvAuLS52oXFzIMuCJTFi6FsMhfw/wq1oV16S1/9mnz
         tQoKuCVVVEubYPCCu8fRaDSLJtvbB2f+Wu9TASQk2HMNlibyMWV09rx6IRIK+U6OyxgD
         /ZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749947098; x=1750551898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSYgU0M+OO7kKXGwRrcoePh99egJQHynCHS9eQ2jlT8=;
        b=MoxOupC2xGN220w3IpcKQjjLcyjm2Vl4gCsf+rrKGgzvNgAIrcoELhg4x4RhsPPOHV
         fPrrQ5n3xbFk7AGxfu6gMd6E1AIFfZU/xl8IWfJSCG4EG7V/Pvp0a0gSfWYqmKky5v/x
         1ccaQ1JS6eKfORS2EVkUIyxj49zUuFamOBTae7CU1d9pw8G51q/JWihTDCQwBGgtG4Cb
         i8LboYPhFC0Oc6LG1ihQ9YjgtKXOZYpGy3FdIlRleHmtebh1z+hyBrUhTcq+kdNKelnP
         m821sN5xRgSaoB4fEnsRrnt0quLyDoz1WSJNDJeZRTubRxxc/BIc7acgsg6x1XMTtMpg
         Dtkg==
X-Gm-Message-State: AOJu0YzdrYY1zhwbFSHFco7wg7DasgXZyHzQy4O2ODLXpwOoSg5wLo1y
	fbVgkkZXgWGssee2L1CQViZ0RkyOtWAAHmSZd70Y8Zwbf0dIc1vSiyc+ZmDkmEKrUSm4+19DK79
	4l/2Mc3DR6ocxddT8Z+K6ExLYsguwdb4=
X-Gm-Gg: ASbGncvi+MpyI0rY1Tj2HZZhddJECZ/8eYfZT612gMwP8xr5vhw91YiXI/UPr8I7MLR
	TjtBvI9cQWZbkXyhsypd4P+4D/mnJ7MnKkkQr1A4X2zRIEvr5VsX6BOQCnnIIbFAeTTGcmgZpEz
	tf30RBjH0NmUD0gIqmzMZe/b9m64P9keOmgAWN/bVXDYXjzufybkgCk7DQSssoSg5WwiacjH86k
	as=
X-Google-Smtp-Source: AGHT+IEPDmsjKhCEASjedOaLl/WVpU9rdr4TwFHZ4WNXLUbmYEF0Fj7aNnzTaImiY3SbVsmYK29tTtc88bcxZ+lUbdA=
X-Received: by 2002:a05:620a:4606:b0:7ca:f65b:c341 with SMTP id
 af79cd13be357-7d3c6d0bc76mr738089685a.52.1749947097971; Sat, 14 Jun 2025
 17:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLf8Lf0gbPEUjTU9Zc9KQrzui4pjyvfxhA-LT4YuafqeOQ@mail.gmail.com>
 <xmqq8qlu72hz.fsf@gitster.g>
In-Reply-To: <xmqq8qlu72hz.fsf@gitster.g>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sun, 15 Jun 2025 05:54:46 +0530
X-Gm-Features: AX0GCFtIdcjKQxwonQn_DO22RVrxoyUIsC5C06XeSjZT5su2v95KhY2_FDc_KWU
Message-ID: <CA+rGoLehMUWPMBrZ1hOk-GBQBCvSY0_ivFCn1w1C-V_bGTDgZg@mail.gmail.com>
Subject: Re: Question: regarding understanding code base
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 9:13=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:
>
> > The main question is
> > What are the best and smallest set of git commands to do this as
> > I can set this up as an alias and use this trick for many other project=
s too.
>
> Sorry, but I have no idea what you are trying to refer to as "this"
> in "commands to do this" and also "this" in "use this trick", so I
> cannot help you here.
>
>

What I meant was:
You previously suggested that one good way to understand Git is to
start from the initial commit of the Git repo and move forward
chronologically through the commits.

I'd like to turn this approach into a repeatable workflow, possibly
through an alias or small script.

So my question is:
What is the smallest and most effective set of Git commands to:

- Start from the initial commit of a repository

- Walk forward through history (one commit at a time) probably which
changes my file system (I currently use a terminal based command)

I use
git rev-list --reverse HEAD | while read commit; do
  echo "=3D=3D=3D Commit: $commit =3D=3D=3D"
  git show --color --stat --patch --pretty=3Dfuller "$commit"
  read -p "Press enter to continue to the next commit..."
done

I wanted to know if there are any better ways

Thanks again,
- Jayatheerth
