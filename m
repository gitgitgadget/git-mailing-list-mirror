Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B72E1EA7F1
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744368121; cv=none; b=IJMDp7u7V6tsu2HBd9qm4gjW3CdJQeEpQRDcf8Ew+ASJLo09ZF0ibq9qvs2PGnzl8ghW9yfApqwaU/Yt6tHT4ybtm1GM7O9n1sirnGBwUUjxEanpscmWrO8OvwrfByc7KwUggozo6SF+sbdZk8dh+q7kAoQ4PL6k2Bnemagsvo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744368121; c=relaxed/simple;
	bh=1CtL0gueMeOzfpIqMUysUMD/XEfMCdqKgi5X44/IEeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrUoZb4CB35kwZ8DafFa4ahS+IJcOQ/+rcuQt+edMx82Qb91hWAzdgdhyXLdx2RanGmGjv7yLvnxk6U5QBcQ9o7tHIgtEWLFHXOLub8oixZ+qWmXQJ5m1cipwWi4kSEMFjIdSiPaYGEUPpoEeFZ3al5k50rq9qIxkFAao9WBB2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qk+d4O2A; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk+d4O2A"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ed1ac116e3so2818343a12.3
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 03:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744368118; x=1744972918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evXpafDvWk2J3w2KZdsgaR6nz7S9AEuOWV/R6j0eF60=;
        b=Qk+d4O2AHF0AX2ibaX8lpytSpuUiNjWa/I5gi3VJmPhOt1t08S6Ow6wyXnXE/z4enK
         StQAU4hTgHVN1X3uTWU6Aa0tbwHs4NrYk2rqCminx++tuncFGHXMzYy2fzVE5VnWFlK7
         i2KQOZxaKcRDuwfaN4oTVcCdTPRJM4o+BlQ4T9gMqss7yfPJpGqJVgkHaTDKGunYjSy2
         X5gHT1zAKGpchbVTxT2xLIWFFwn5lM4RmpC/NziCd9C7oQI7ZNUTcgdFYdWWGI1Y6fIx
         TvubKuJCO/p48nyV+K7M8CRoUJSuYAsEyUPSvmJGRRe8Q8PkL0UCB2rWaXWE3MEKffC+
         K0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744368118; x=1744972918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evXpafDvWk2J3w2KZdsgaR6nz7S9AEuOWV/R6j0eF60=;
        b=mbxUtetJ/bK/0oyYQcKMi2P4NXxQfAtxcq8gjgqg4sxnfIPO7ACldx9/Kx5/Cx9GkI
         t3gINp0nyi68celcpLJk9BILEyVF6/CjXhQyjZia/MVofxUMezS6lAOS4iJeVSresh/z
         Gr5oYumhXAqNjWGtRBdduIHvRIkqx+1jL92zHMhRzocCD1Xtg+ikVXuTScmbo5QdDfJh
         Qi5l/2JqjzqcNOMC++nLAW9S4MknTw2jZ31aHPQMP50BHONdl4D1xhC6X11O5P/SSJSj
         ZhT6lomH8uX6qDcoDBhdxqgea2LBRXUkEd5BtlWK/FyUOgjIER5E8xuOruMoB6Cy4nPa
         f4eA==
X-Gm-Message-State: AOJu0YxlbV+C8Mw/hmUbLxW0ZhC03w2Cl2txqd9/ZCElzzXHhUI+2qmp
	0pykx1Bgp+60o4O/Pvj+fW6/1FlTY9B8El/rgpsTC4Y9HGlxf0jHU2Y7CtvPZ9CczuiJnfn7HD3
	OUsyuxfQg19fSG3kOhgwI0yxSFQJr4XI2
X-Gm-Gg: ASbGncukpiPcepNWrtmVTPhSxTdL/qzZuGh9phBY/vRAEBC6QzKJmUYVHW5WpsekuFS
	aodBBBVRJTc/68MOHidXLHdCElNBU4mLfwdRduoIsZwgHc4gUzeSG05w+VabgOTzxqJAl7AWNg9
	Qd62tf8QUrhYIgcpJ02PO2DA8mpXnA2X3AH8xVdx3GOzPljKzXon2S6rTdQX4VPDVSJg==
X-Google-Smtp-Source: AGHT+IHA84ZF7Ak+hFA2KZpjeOkg5EkryQ7S63UQ0jR9FljS4zwTsRdgid/R8t5PKsLx5jrgJkIKqfVx5+wzvcd4Pxg=
X-Received: by 2002:a05:6402:34d6:b0:5ec:cbf8:ab28 with SMTP id
 4fb4d7f45d1cf-5f370012552mr1516005a12.22.1744368117906; Fri, 11 Apr 2025
 03:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2020782.usQuhbGJ8B@nb0018864>
In-Reply-To: <2020782.usQuhbGJ8B@nb0018864>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 11 Apr 2025 12:41:45 +0200
X-Gm-Features: ATxdqUHFlidBCARakIefO-G5g76qFLCzA_1RXqf17i4Uy72srMPBxGuNvVgH2mE
Message-ID: <CAP8UFD0aPOLgWHPM5eQRHFhegaM-O+wKFEB3cJ9kHy+ciShm6Q@mail.gmail.com>
Subject: Re: sendemail.smtpPass is truncated
To: =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 10, 2025 at 11:48=E2=80=AFAM J=C3=A9r=C3=B4me Pouiller
<jerome.pouiller@silabs.com> wrote:
>
> Hi everyone,
>
> "git send-email" started to complains my credentials were incorrect. If I=
 run
> git-send-email with --smtp-debug=3D1, I can see my smtp password is trunc=
ated.

git-send-email is a Perl script, so it might not be too difficult to debug.

> "git config --list" show the correct value. I am also able to properly us=
e my
> password with "--smtp-pass"
>
> My password is not insane:
>   - < 20 characters long
>   - just a mix of ascii printable characters (no unicode)
>
> My password contains characters like '#', '$', ... So I need to quote it.
> However, I use special characters for while without issues and "git confi=
g
> --list" returns the correct value.
>
> I have successfully used this command 5 weeks ago. Meanwhile:
>   - I think I have not changed my password
>   - I believe git-send-email has not been updated
>   - I believe none of my Perl packages has been updated
>
> So, I have to admit I have no idea from where the issue come.
>
>
> [System Info]
> git version:
> git version 2.39.5

v2.39.5 is quite recent (May 2024) and it looks like there were
send-email changes in it compared to v2.39.4, so it's possible that
your machine was upgraded from v2.39.4 to v2.39.5 recently and that
those changes broke send-email for you.

Maybe you could try to downgrade to v2.39.4 or v2.39.0 just to check
if send-email works better.

Best,
Christian.
