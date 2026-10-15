Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DFA497B6D
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 06:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047077; cv=pass; b=jaP6I4TFVhDM3ymkzXp42o3c0IfYfwdDPAJLvsMzvWxf7QKADkZu/cLG/MtV2PhqCLPGy7iKRnNMMdKkG72gOWuGmi9EIglBl9iAyy965eDrlU5PANtaooRgwLTUTLj0YQpCsHB/1UDE41KeTDvsQ43D5u7DRo6nxurChA6ZRSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047077; c=relaxed/simple;
	bh=5Zxald4LhS3+xONBubOJ+VV5KxK1CHN0k965+sHrXTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAPj1BPij8bYG4EtRKypVoEj08nnvCZVrDNWisS9jd3bORHnlkaAWEZwEpYM9ILcEjb8A5fCuj5M1UHPQ+aCENeKwmiaRGhLbporDxsBfWhi6ZZvw9UBNjXUVpFjKkEEWi2FEddqkH+S3oZsKXCvKQuBdeulf0QJlZAdL5+yaOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcr+X38s; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcr+X38s"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-98301b325c4so1458285241.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 23:51:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792047075; cv=none;
        d=google.com; s=arc-20260327;
        b=s5SfGx1T6fiV+T5REAgLKKTjWkxw8cnSze1fXgQRXO7fPSXvExHYwsBTzsLC5zEehm
         ZxEmHPnZCGp/i0GZU+CHFckhxpLxWB6t95J+UCDXkYIgQBKRbZzTyt7b4MKgkBYxI2QY
         1uc4QGtShnxeSQc6b+r9IxOA4uNFCcLiSNjh5+Pg+qSlEzhtQV9u4Jfyk5jnBkbVVmCU
         cbRbPIdomO3TOla8Bv+X1YECok4gaafodK06eldJramtf8WtNQjJtB0/qiGHZjJvEczW
         08FN6EzG4JVKpcnCWP5iCqCX3SKT3Fc05pfm785dqXkrt4baT2/9P4Su0vihGmdr8ZPP
         T0Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5Zxald4LhS3+xONBubOJ+VV5KxK1CHN0k965+sHrXTE=;
        fh=gdm4ivTNiHElmcg3D34npza6lBb5jMN/kRjssdR2ApE=;
        b=k8Yj2voOQelwpAzckLRAUTs906wLAXRBZvXXipd0romv2zOIBEk4tMIEOknIYu9lNW
         63G8iXW0UzEkcmzYPL94hZn3eexskQYQF498Go9lwTSgK4h+8VaH36D+OtDjqC+79gaF
         6ptw5kxl1zFu2JRpCgt0JoZ1ewga0iDnqXoEOVF29WzjiLVEg+EdgzXSzVwtoFmJayop
         Dy2hOemNvGJ0cF0dn1PPXnbYelus40ntsdGyz8NydmYxVnAvTjvxBEBtosJePRcdOT8c
         ItmsUg1AZ3fpid+LCMQ0wkv5obrOrxS4rjaAbPP6xC6z3sPRrzCJa8ZbgQlZdjnAZ9/L
         n1aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792047075; x=1792651875; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Zxald4LhS3+xONBubOJ+VV5KxK1CHN0k965+sHrXTE=;
        b=gcr+X38sysTWQjwZLO8DTm9hizVDA+qa27HRh+CgoTpktII93zoHEzOOA2V/0ibWQr
         3v42FCb/7a+2fyfJ6g5qakJ3v3fo46k2WUyQWpU25RZFsuDVNgQ0TuuQM6TUiodEV15O
         aPodOmDe8cfAqdC14vgCATpogQpl7s8ktS5GAxoQ5NSWaHKN8o6QdRMjr2yrhi5LQKuD
         T6vGVhJPuekJRTItc7QqvcbARO+RwSZNmxqBwRNgURHe/1VYIrp3mOOeLV/bDD+i0V3s
         z6XupCTqYJJRf6++Rbl2BKaC8ob7aAwZu+g3aWqX79Pf19M3c6myT6mSVrjmjpq/ZaBa
         ruxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792047075; x=1792651875;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5Zxald4LhS3+xONBubOJ+VV5KxK1CHN0k965+sHrXTE=;
        b=m4GqbHq+AihdIDqO23OnyiB9fybB+XP10pA1dSjjRKIVVGkqLFNVvZIX87pIU2P/OF
         F9FPeRGaiPxwiwOs97M2iG/QwhKhBJBwaaVjIh8B4iM1IXESjl6/Du4EfgdP4QWfJmYD
         g9e8eFdkGcnQTG4kwoEbhMcqyBBOHE8vLP2N1lzUjdHEzNfcZSQtKWr1I/cha8Tku1Kp
         x5TADhnGgz5bLK94Wdlv72JIqIjj5PpIe4L2XFq/tcYii/ORkAYgJBj/RF++w4Zkww0c
         mEFV+ASp0jfwOQNI15GyArEX7oWTtouRz9C1j2O+DIPDdKBkyEgyBCm52XVBrcvS50D3
         GVuA==
X-Forwarded-Encrypted: i=1; AKwUvBymo8/Ok5e66C/4U83hgVhurrteT7loUwvDief1VOa/YtNhFV7njdLE24DGbMAk7Y1iFhs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTYPyWIYQGfTv872VjHn3sGm5MYjGEL85Dh5rHVhjHCpbemKNH
	K+YPgLjku/AZ7dwzKGYuVF9VvYFdyeMCabyEERivyVScCKXLOoFqoZHMELtZuaA5SZJKboIEZuW
	NHJI3QJCpCM5UKv7M2iwCzSjJ6f/i7PXa/vn5
X-Gm-Gg: AYBFou1Aj9kWyrE3mXCxxcFo1fPuphq7tvKRntt/Uq8B8+cH14EvVW4ZTRKw2cqyhoK
	HdclkspV4grjcUl6Hjw8wmUIHcJYwTSJDyxs5pr+5A5c3CzWWFPLxWNktgqo0pA7pODBIxdjE3B
	EV2RH+AK8GA3+OHLt0mUgRlFkW+iHrwcsCem/dOouK6k1QvpRWneT2+nVeBauuYXC8k13Wxi6JG
	ICzGOENcVXEUQpLohkHzZleDC2L6qIKszNrtQ/WwB2LVGVDM+kN6fyFdgcarkNp1uMVj+xfTt4o
	uctK4Jonz5AJQmxT6DbpXnUxYfzsHMkhhHxp20Gb+1doDqWZ2V0LjJTaywBjy2Dgiw==
X-Received: by 2002:a67:e711:0:b0:7c1:6de4:9f67 with SMTP id
 ada2fe7eead31-7cb3981c43bmr4563006137.2.1792047074769; Wed, 14 Oct 2026
 23:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2254.git.1791962806807.gitgitgadget@gmail.com> <CAPSxiM9-F-1XKvWeEnBk=_FyKyev5pfnid4fiN-OjLYLnCTWVw@mail.gmail.com>
In-Reply-To: <CAPSxiM9-F-1XKvWeEnBk=_FyKyev5pfnid4fiN-OjLYLnCTWVw@mail.gmail.com>
From: Shashank S <shashu8660@gmail.com>
Date: Thu, 15 Oct 2026 12:21:02 +0530
X-Gm-Features: AclHuK-mM--5QxPgCC_-_cFcOPbnpuUVkmEnmF6BZ3C0uIkPi7p3ncrw5Ws5FiA
Message-ID: <CANHmUQQcn8fX70NFMicOZUHTr1sYU44Avc8KER32TX1aK+rrfg@mail.gmail.com>
Subject: Re: [PATCH] t0081: modernize the code testing whether a file exists
To: Usman Akinyemi <usmanakinyemi202@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: Shashank S via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Oct 2026 at 15:19, Usman Akinyemi <usmanakinyemi202@gmail.com> wrote:
>
> > From: Shashank <shashu8660@gmail.com>
> >
> > Replace the old-style shell `test -f` command with Git's modern
> > `test_path_is_file`.
> >
> > This instance was found using:
> > `git grep "test -[efd]" t/'
> This is not necessary, remove it.

thank you for the review , i will remove it and i will submit patch v2
