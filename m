Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D33849B44F
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592322; cv=pass; b=tX1Qm9/aakPjxVvuchVbHRjvCn7qwkpe5v0Go49XRdq3YBeS67Mf47hXuCuCca9ms4P/gFjsxxDpxIlO5b5blh0My6pYV28Vee2f0UYucQPhTRKFEE+7O+ct02fEts0hPNvK5jYwsli05l1v34m79xFWkH2JxE/heLo8NiSGHEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592322; c=relaxed/simple;
	bh=InqphX1ilThtT5B3SVoMr69QixuTclhwu5rR0TSUxXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HY4tjyuHqdOWrDzJb59ymCdDPF+d44x77rC9/3QJvS/zGQjNqYtcjvILDUN3buoETm0ubq5KFa5N+aeUG2G8PwZOW1JRu78aWcZT8zERIbw6BJvHyMhCfKrZIn9nDFRJ6B2ur6bNf9Gkwv5YHwTBIh/QVUClppoOnIbZrSjHKl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zx7/2ojI; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zx7/2ojI"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc1cea4bfb6so51795a12.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2026 13:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789592303; cv=none;
        d=google.com; s=arc-20260327;
        b=WI2QR1lO7d4ul+OgbLX6Z5xBYOy2g35UR52YvaUZUafn1Qw/RnFvfPUhAT9vjlst3Y
         ihLanhRyRY15Cdf60VrVMj6UptfoD/jgvvUHweojkwixlcFF5Z9UVgu3JOaAeaTkNmkT
         B3GHP7sk1ycyv5VDGKHtiJtw2ivTUcFxyv5Ady5qeYoLsCG0VX+132YQ6UR4Kp1GnrjN
         KLHXlgt0RUOfTrxuazwSXL8ZdHaGDfXKcnjPUHae6VGpstRhebMpQR9QnHzgWeVzNYsM
         u+YPBz3CKcjReUVcSO+tvoYAcGCbOMIVJGjqVclNwXMKr+Ea39Uz2CFCPGdMNvofu6PM
         iVCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=adNA6tMqLyZB1EpwDfqXPXBJGN9e4c8wWLKgxwPcimc=;
        fh=ujg3ymYPqnpL5IJaWDx4CQZVnr/PAxBNqtebAzGDWDY=;
        b=DjaCkTaUY9kBHzw/70XYrYliSQOP/mNQNvH7tlvu39rhT22NRPYatnigiGfmm18MbP
         saSMlDYBYVuJGckZQSclRMovDfO61ofyZ6IcAVaQjBi5I7exCPkCKrYCJ254Mo9Pq51X
         2bbbgC6zF66eG8/lUpWVyGw3ink9+e0y/hd/1jqoJvBErxS5QAYaGyhHCRNhzVmzJe53
         wseQSylVJiamODwRTn+sccSNtBtp0u59+55WWFpbmSPY3EREjuAzfJwXuwKj8RQcObzv
         93nB+g6yC53+w3nZl5GETJZX5vIqBnamDP0iNDJFlStGWeAMNetrqK4G+IojNqhMXMqM
         cnKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789592303; x=1790197103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=adNA6tMqLyZB1EpwDfqXPXBJGN9e4c8wWLKgxwPcimc=;
        b=Zx7/2ojIhGxMBn9hqlyLTQjw1Vz9TpVxmtAJwQrfeKbc9Q/VwoAjSh6LkAvu7O/r9R
         5n+3l/Y/pmDVEh9hFd2zWWG+h9YgGbMAPQrIOoyE7UencnYv3Exn+n3eejPWYBUgh5Fd
         8XEPHEFnOljCseA7OWEVTgmfTo8o+lArVSLlOuN+qtHLIcG19vTOeEHsPdy9RApAhq4O
         PyFC8DwLtqxRBbRS3l30FECDVH7kyUNYEBOg7LYkyusRDv2U2UXc4hV1+a+Aqm1x2muI
         W+6uUa4/sGoJ8LtbhLpXbq3iSNljbveSzSZMJ/tTql5Cba6GUVYp1nIXQfN+eMcg6nL7
         RTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789592303; x=1790197103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=adNA6tMqLyZB1EpwDfqXPXBJGN9e4c8wWLKgxwPcimc=;
        b=MkhUmyYFZ0l/PXR6yLMSvg7AyxSHR6yQTYuJEs9/8VqMdTTjmqFhHMOyO1V5yI5ntA
         y5HfdBHMa2TeIkNzqF4JVzDykFJYUZOCVvHueJxNQ7WR1kHwbQIHsjTPbJu0Kwbf3jAI
         Ff34nt3WvuPWrQtAvpEXibBFP9SmXwxXgzp74Km6pnoKMQzOlRj5DWKuaFeyNMq+2Ckz
         ueP+sI8FpmNyeASWHhaK/ET8LU72aCtL1d8NhTEYHS4y1yiPfwblexSTEKR3Z51IEhxl
         lyZKHOQf/1VzhD3xBuLeAnGvQxrxxGPGHwvRmG4eIrtgan95Jru6uXvchgzEfNA9x1HL
         nuZA==
X-Forwarded-Encrypted: i=1; AKwUvBwLAil2YUYwMkA3T4Kip6Yy83h4//Gy3HLzaseVlJRKnDiDItGx+mnl504ZHGySAKbHH58=@vger.kernel.org
X-Gm-Message-State: AFuF++kPac3nrxTcDgbGgkwy6nal8HpwcNRk1DZdX91UXrCDxiCDcqcE
	N5MMV94PhEkpTeDGFEKTWUwFDq6IifXaYdnuZo5WrGGH27ZYpsU6kk6Tl2+LnRHFKlOGt12p+ph
	L5I5n1no6ESZmc6gyOzkutklVoJViMQs=
X-Gm-Gg: AYBFou2wPtq3m49URboBOPAJHaAJST+V/aDavCkQ/GqRkNSZttDZYPjgYjNizlAUtlk
	FZAYkHw3D3CHpEjGRBx7htNzp+92TSJDE9IDoWmHkGByQCW1YTiWf4yV0DAifRaHBF1Iq93IIAh
	L0yfpguEqIR8QKu9Q9m0vZeEfTi6wlaT7Y6bKySJF4c0035FkYayKyXJNdnk5E+Qha9alnq2W3m
	OsdrccQy3EZdPo6T6fT2dtprPVCxmsNp4CTgAQDXgk7Vwf+wmFfvPe5Nin02Fs9WPnUrUL7MME9
	Jf7zX2aJHSrLOkv53xDkySmsBxLfcea2vp8KNN/BJjeYJ7oa1BnEe2JIc50SnLDohqGjyNsobT6
	MnGKClsy1Fe+71e0+YebMGllNw93nty5dN8cAY3AFiX8S0hLBQaDJqmuXp82Cf/WvE1fCQGm3dy
	aUlWx3hSs0/hbT0YbbaYVZlCm5cYR8292V3Us5
X-Received: by 2002:a17:90b:280a:b0:39d:f60b:8121 with SMTP id
 98e67ed59e1d1-39e1e4d39damr13015049a91.17.1789592303103; Wed, 16 Sep 2026
 13:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD367UD=AomNVHEBnhY-2DQmqTNRcBX6NW7YZywWgOmxTQ@mail.gmail.com>
 <CAP8UFD0oYnoXgQ84wHbGg3+QhX78Ucn_CXXYOe8uFpReb7X1Ng@mail.gmail.com>
 <CAP8UFD1hAjtPuWL8asZ2LzEMJKHGh2oO73n_tsUSADtEHh9b-g@mail.gmail.com>
 <DLEWITFIKFFK.NSANTRY5XBCB@gmail.com> <1b904e64-e681-4744-b83e-690f3ca94ea1@gmail.com>
In-Reply-To: <1b904e64-e681-4744-b83e-690f3ca94ea1@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 16 Sep 2026 22:58:11 +0200
X-Gm-Features: AcwNN1VWohLtui7vNI9qmUb9vWjacQ-4392_Vu6KTI8pCgZ8dqMEqORN4tgFJqA
Message-ID: <CAP8UFD3kd=6QHp2oB+t+g-2D8bY-Oe5+_Vk+RJeaCa_xhxGrsA@mail.gmail.com>
Subject: Re: Participating in Outreachy's December 2026 cohort
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, git <git@vger.kernel.org>, 
	Git at SFC <git@sfconservancy.org>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Tian Yuchen <cat@malon.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 11:41=E2=80=AFAM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> On 9/14/26 14:07, Pablo Sabater wrote:
> >
> > I've applied as co-mentor for the libification one, this way we have at
> > least one mentor for each project.
> >
>
> Cool, Pablo. I've approved your application and also Usman's. Right now
> we appear to have 2 mentors per project:
>
>    - Reduce Git=E2=80=99s global state to enable Git's libification
>
>      - Usman Akinyemi
>      - Pablo Sabater
>
>    - Improve how command arguments and options are scanned and parsed
>
>      - Christian Couder
>      - Siddarth Asthana

Great, thanks!

> Given that we already have enough mentors for both the projects and I
> have some bandwidth, I wonder if it would make sense to also propose the
> projects that we proposed for GSoC but were not actually taken up by
> anyone. The following are the projects:
>
>    - Implement promisor remote fetch ordering

I think it's indeed a good idea to propose this project, even if it
seems more difficult than the other projects we already propose.

>    - Enhance promisor-remote protocol for better-connected remotes

This one seems even more risky and difficult to me. I would suggest
only proposing the previous one.

Anyway as you will mentor it, feel free to propose the project you prefer.

Thanks,
Christian.
