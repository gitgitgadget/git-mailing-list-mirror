Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB1C213224
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169613; cv=none; b=OJsl+BsKz9NmYk0qnAXTuxusv8fiOzfXxJPlT4ZM7i30KIbaKy8YMzF1MaQvYdd0YiC5tEd5Pj7zvOPLSKAgA3YvPGOKd2G9YpZ5+ZRoadKDLJ3VsSFCG0TuqgcPxTAy7/Y6rC9OfoBWz7nUotLGVJOw2jPXGt3fxvgsF78uDOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169613; c=relaxed/simple;
	bh=8Ip4mZ96/dmGKxXwM6/qQBHWonZ48XU8r01st/PmZ5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0MYXMtBv4e3y+WilLTvKBrM4l0BLdTlC9+rC36MRb1OKCBrQJvEOYRLwm9JZXR3zuhOYjw17Aa/b2M1Svihl4q9ISTBiq3YiXCYk0BXxz0CmaLHgboUvGDrUcQF2PLQCHpgcfbqbNuuRCjCEBj5aiQ3M3cSehFV33snQ3KBi+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a43e5c2b1aso1517241cf.2
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 10:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752169610; x=1752774410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObEJkq9KRXl8LHTBryumx8cNcWe6Q2Qa6YSueyae3tY=;
        b=lMW5+ku2+39LUm3uXnfhBgywf6uHWew0VdqhAaGFn3glHsMUHm3YdKom4Hplf9Jk2m
         49CsYi6bMDOQVX+CT+feS7mm4aF7MPBoo7sffdV2XfsAXaGDz5xRw6EkyrCSPfjpT2at
         MzSybF4T91BZojz6GWWsbi8AqO3IINF4Xopicgim3MkmEhWis0Yja1ENWi4PGGGaqUBK
         moV/pp5C10kiynMccigTQqUdwz/rYC6BZ79suKyiOnRYilhIgBE5PpiHxBDeBzuWOOpD
         QlUY/11Ui99fMzccX+z8UOx98sIB4q9FjyXdwGJiFlWD7D4Os1iYmzJvdThZJF+KnY6m
         rV+g==
X-Forwarded-Encrypted: i=1; AJvYcCVnZP35uBazAyl+7wyjiNl2cq6JXFKtsBz7sKZFZzuhv5LigsvlR9TjMkAYathq91LCm74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNkYJ+QZ6o5s2YPSUx6YwfvPZ/ukt7/Y/eE9Bz/98mPskU+eU+
	f444PCUreImBZl13W9s/p/vccn2W3jgdUY4EzDEDfGwGHJHuLvyCk/Ryv0bWHNtdkyGl7+PAaLV
	14F0JWtlyuyGbDRRwJW8tCUDVRaKl7v8sMA==
X-Gm-Gg: ASbGncskj0W6MwYjRDEgFvb+rujQExOZhzGQ+HqCfz7rrOYMwQl09PmcihCnS9eRxp7
	vM18SGE9nEEvg5fKAt2sw2h2aDloix/AjKzRf5qenmXURtEJqbSW3+8NQ3tK0kSAkyzKmgZE41Q
	UJLOtGepvctgeVye4jLNZ/JRg1/LFxJMRH/QT2q9OwzPj+z/ByIIuISsTNdYT1ZJciKs5iyF+Ha
	Q==
X-Google-Smtp-Source: AGHT+IHPeg3Py3rb/jhHqb79Wg2KBQ/Ojd9q+PzUH+uimZpNgg/fCjPh/zZAkvq+6t2Ys5AekLRs/HNiFT0n2GoRdcI=
X-Received: by 2002:a05:622a:1f9b:b0:4a6:fb4d:b4e with SMTP id
 d75a77b69052e-4a9fb918eadmr1491351cf.13.1752169610061; Thu, 10 Jul 2025
 10:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACpw4KCYrgjCPO6z-czSa=rW+5z5m4Xpy_RSgxEkUGdeMEvULA@mail.gmail.com>
 <xmqqecuo82xq.fsf@gitster.g>
In-Reply-To: <xmqqecuo82xq.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 10 Jul 2025 13:46:38 -0400
X-Gm-Features: Ac12FXxG_MCx0IGcuau5qA71UG8pwLcQ3JGSEiORGc5oCtjxKFgeDYXAFtS7-r0
Message-ID: <CAPig+cT_5LhE7caRhviRXZ_U3UUcfxo-d74yOYtep33dYJQ2Uw@mail.gmail.com>
Subject: Re: bug: `git commit --verbose` not removing text below scissor-line
To: Junio C Hamano <gitster@pobox.com>
Cc: Oren Levi <orenl@exon-media.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 11:50=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> Oren Levi <orenl@exon-media.com> writes:
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> > 1. Run `git ci -a`
> > 2. Edit COMMIT_EDITMSG (using vscode)
> > 3. Save&Close
>
> Here is what I did as a quick sanity check
>
>     $ git checkout --detach HEAD
>     $ git reset --soft HEAD~23
>     $ git commit -a -v
>
> Since I do not use vscode, my reproduction attempt used an editor
> different from it.  It is possible that your editor may be mangling
> the line that it is not supposed to touch, but that is not something
> I can tell.

I don't use vscode either, but I did install it (in a Linux VM) to
test this. Like you, I was unable to reproduce the problem using the
provided recipe. My attempt was using the factory settings for VScode,
which may be different from the settings used by the OP.
