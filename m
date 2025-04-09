Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7B81DF27D
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226106; cv=none; b=qijm55TzAvTLK5GUxsp0UvFsI1NvIJ8DCaVAk7JxcC1SIQ9X76pGNybs7vgNmv0Qq5zJ+3aTOhgMMp/zkwpqFuyzlkNAHGRG5ZJO/PyoRwDcQlwFi35Mde9mxgX0W0ao4tTYxcbmSWOnbX9Pc4PWK87ei2QbdKQiVGTfFnnvM7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226106; c=relaxed/simple;
	bh=C8tQno+oYQwt6gP2OlWd2cZO0syCwt1Wp7TffLc9as4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9SH5zms/bDSYRDq8+kliXbvv641n9rM2hexMBbN0Y6Rmn+XMYvq3Kc/eG9Ej8H49cHtQHZ2Bwxtast7jCJD8gSB583ImZwsYF6Nsve8Ljkwh9i5PjTpgUMAtyIxEXKQHDZEPF9fY4TAOjTx6mufKexE++uJC9eyCSsOvMmvOvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8f43676b7so8422826d6.1
        for <git@vger.kernel.org>; Wed, 09 Apr 2025 12:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744226103; x=1744830903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/jtB9z85h00nMtYyFBq3tWpumAuc3srldEZnH0g2sg=;
        b=px2IFGg3ucg86MXf2FwWjm1Qxtm8uRG3vFeG6I7Yngqf6/LTtAY7R95wItr6SA0F05
         oYw4mULR5htOIw7PwFGmbuS6Hj4MSVTZT2SVP7NMD8lxKMObXvt/aoz5PLHVmM+sw5qR
         jtgS/qUbUPUNXtPlV8swDdogoZRKJoCbTxOc4TX26DeTo8A5/yD5HpOAMH9D5cstt4Ck
         fnDmXTgptWG+vxtpW1OR7YaQ+RaJzFWSjZDUnrn2tE6D2FQSycABY/sU6K1MXEYG5I30
         UTxN8bx3yHlwzWMh1z+7A05rCHdbLtOSNJHoMitM02fZ+2Nh497QYW4sYIrXKYNyklfv
         oesQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVmYB847CzMWnBFZGny6tJVp192FtncPa8hbz1MLWHrJMJTIbBqqdlLzyt8efnh+hefyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqEjeF3p7T12NNrOMaliUjbNSs7c2un2Tgw+2gxcY4rNTsvQDn
	M2AFASJdrQzjzUuhL7fWwJiM+wt29wXwQ6YQ3ol4BJGiVAzYnafzkzUrpVpRYIL0i3N2SX52lwZ
	GNvUJQyvdDQjSSFKibnnivYHT9T0=
X-Gm-Gg: ASbGncv2ReFj8pI6fbLxN4ik1kDUFnKGp1hjntOwEzeNr7xFBmCXpuOHqoAgMF6zf+l
	eSErSC7f2w+COcFC07Eu6ikocas37E+kL0TL7x1/nzn8RXGBWbh9WrjfaOOltV2N5umRiJU9Njc
	A3WfU1r/LJk03R1SM7IkSCZ9PfnNFsdmU=
X-Google-Smtp-Source: AGHT+IF14DLrduSXjjaK2ZhQ6xzU+ABWK0wP+Uc8floAIEOlg30kYEJ0jbZj+ljq4B3xOpdLXrSpABxkiTUwbUgbzMI=
X-Received: by 2002:a05:6214:d6d:b0:6e8:fbaf:fad8 with SMTP id
 6a1803df08f44-6f0dbbb5fedmr20694536d6.5.1744226103311; Wed, 09 Apr 2025
 12:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby> <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby> <20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby>
 <xmqqv7rdqkla.fsf@gitster.g> <Z/a+AVopz+HLa1eL@ubby>
In-Reply-To: <Z/a+AVopz+HLa1eL@ubby>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 9 Apr 2025 15:14:46 -0400
X-Gm-Features: ATxdqUFWetCIdvBc0MPziW1KPcK2aZcyzKiJgzDQP6uD2AwgKrxfopwEEM097xY
Message-ID: <CAPig+cSN97oyYbF=mRijbgxUtED2q=u2PFAV+gPP3qM6Vm0OPg@mail.gmail.com>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
To: Nico Williams <nico@cryptonector.com>
Cc: Junio C Hamano <gitster@pobox.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Martin von Zweigbergk <martinvonz@google.com>, Git Mailing List <git@vger.kernel.org>, 
	Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 2:51=E2=80=AFPM Nico Williams <nico@cryptonector.com=
> wrote:
> On Wed, Apr 09, 2025 at 11:02:41AM -0700, Junio C Hamano wrote:
> > We designed not to etch such wrong renames/copoies in stone by
> > recording them at the commit time.  Instead we compare the before
> > and after image to intuit the _intention_ of what the user wanted to
> > do _when_ you _ask_ (i.e. when you run "git diff" or "git log").
>
> Well, I suspect more likely that Linus didn't want to have some sort of
> inode number nor some sort of explicit rename/copy indication as a
> significant simplification that allowed Git to get shipped sooner.  I'm
> not questioning that nor trying to litigate rename/copy.

Contrary to your suspicion, what Junio describes above was a conscious
and deliberate design decision by Linus[*].

[*]: https://lore.kernel.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.os=
dl.org/
