Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2B53346BE
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 22:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785711161; cv=pass; b=eInIs8RALXAS2PPpQuc1yGm2Ryhr+Hn+Fsqrb+oQiWKPZxvIEjddTWxvNuKRhnYuiJK4wyeuhc0MgpHX8FslYsjChVPLkZmtW/pADvyJJ9ATX7QIYGVWz65Ptf2Fcxw07lFyqisYagqzCHwW2s2KoY5J7imCmdDrXx9csfpFAyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785711161; c=relaxed/simple;
	bh=hRYIviGogxArk+ehJl8UHWqd+GQdW8G2+57B6eLdsvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8aH9sLnYmInwVAPGQamM1MCy5ry+yVLpRuQlIeSAr8CmInMLkoa44EVKNbuNgiewyZBQLPisFTnrM46sXzaDY5exHjlcdjZSNuqwfv9NIWLg9BYDL3zzCo/wQO7J7gZFgGz+7WwP0mgxrE23IlBVqhkg/HuALG/axBNbahSvpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoWvyw8O; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoWvyw8O"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7eb42a2f5feso1385940a34.1
        for <git@vger.kernel.org>; Sun, 02 Aug 2026 15:52:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785711159; cv=none;
        d=google.com; s=arc-20260327;
        b=Ttci3Zp+aUxmpgrPHr/9DPLCqNR8euUI3ULfexN2CREIHQX1Hzs0oXrnTEiWzK/BGV
         ab0gTvzDbXsgkQWkJnKNTkgSXUFqs829y9jxzA5ZVF+eD8ZJIVNKWlWU+4OSE7l352rb
         H0kF2alh4hWkOR/WxEMN3Vcp31BzX97h8AbJ8updyMxi6V40+8yCAWqNv6MBPQ8gUQe3
         O/1DzkgisR8AE9qOkN1MveBKYcPhmIZ5bbhzgBqhs+HChkl8/l+iv4FS/HkBgKE1vUFO
         dyq5FQSSmmzKjSV47zQxn9VnQahdfXG84wGCvEy7jZKDNx3tmSCKGRelesu8dXCx2gZG
         E7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hRYIviGogxArk+ehJl8UHWqd+GQdW8G2+57B6eLdsvc=;
        fh=lecRd5VlVnZlvufpm6uqs51mDbQjswE1S01372pJlIg=;
        b=oQKNKyBnnGUkMAMVQ9K4RdbH4hAADbHjOkw2xHYxgrsEi10+XmueWlvXvhbrmQbWYs
         TU14CYnFzS3nN0FgoBcVdhtx8nFi2/QQdqTyhepvuo70R1guBqEPQhmDnYFPJBMbgjpr
         HiRZculzQWd0J6sA0GgJil7sMS3pP/XSOZ1DhPFHUU6OL2ic7mgV1ztF84APaDmjLkd1
         nDul+j3kRDgrRH4NYZ7/my0iBiqt7PTutgQ7D2Dr+tJKua4w/Q6MpyegQsf7N5UE+K/9
         JkYQawtdDD2bM0N2NXzVz9Cz/O5yKvlZg7th+/5fyqaJu9o3rRmfYYD7R7992xQPLhu2
         6FPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785711159; x=1786315959; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hRYIviGogxArk+ehJl8UHWqd+GQdW8G2+57B6eLdsvc=;
        b=PoWvyw8OkYhWW7TvipKxjCk6ax72xtOE02aUa9H8kpzTBrENomENqdHAPtAo2Do1z6
         WN39HoIrzcOA+swhUxuI7nkiImP9DNDTG10pNQHCi5QeHsvHqc0Eqg5kKs3/n0XwoYhX
         I6ImYplddbMnmYomR9FTsBC02lwCBku2pMQmn16HU5mlxNQ9GXv1wumvbotIKGHAO5rJ
         LUFPmRjSQ+JgVnUmhdqC7RRllaWpj//yjcZnUG0jj5oKXO/SII1g6ZQXyfMN5tQfk6Du
         W3i++C8kIoHQWzj/Nri8h24UewMLAqZSFaFFKPcxuwsAdfJpqGBnhjT0UDW6l0umFqee
         JlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785711159; x=1786315959;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hRYIviGogxArk+ehJl8UHWqd+GQdW8G2+57B6eLdsvc=;
        b=Z+ad2dqi0mplKLOEcjn01IZEsiGTW+jP7WBqAMBved0ZF9Q8ALA9pAd/89eF/jZpAe
         t+o4tH5q1Xe/5u6a7IZRK6X97++tctIN5hLyLa6mCbJ2/tke9K/24mNdbUQoJfUCU6uc
         iOrpNVAwgFuYk0t+WPnPOIT8ur7woX73SHIvygAesnx7wXYZSIkW/puQZJdufGrVWj+r
         L9iIesnp+Vq9WP32UyPDXngu868bsnCpGJLODrtUM/z/JwHkD9yuxm59pLMUc0I5fSMB
         1SJnB7lWIVtEU3AwNqjwsm1URaoCVZmbPedWs8YTU8sU50XxjrR/AoZOah+d/k+VzoPm
         YgiQ==
X-Gm-Message-State: AOJu0YyXjJSfHdjLzBFXQpwgBlt6w1/Yc2fG8ps+dDSNuEsqMHK3rlfZ
	aw6jDabQnxZ1U82Y+7sJvF9uFDUEd2toYC78XACs34EQTmDUngdryLB+pdm3yr9ZyMQaKYEqbrA
	V9GzaAI3xF3jHXx3k38lB+PXTUMUSUX2bJb5O
X-Gm-Gg: AR+sD11dJcMYfkxNU2n6rYkzSYN2f2Tl6TTBJ8nFJUUkQDLDrHfGT50VbWk0vQXgX6B
	+36YCFI7Fj77ivOejhTCQjRKSa3qw+qXEhoLJv4fuj7r0Ly3dXGYzbToQ2dvSQduPmMzrjhPvv9
	zqcq3cbi4VRoHtFUoTNjBVDRx7Mvezwyfka2C6QhK+r7/X4t2C0QsjBBYJ6JoUl1lA3JhExly4y
	GXI9UQ5ekOccaP7qKSwBcUjZAFcSCS0yAaLMCG5Xuo30RMdsyQahFRTGsBqr7Y8LtDbQkw/qRdQ
	FNDIsaNi2d+yGHGVaKvfaDeNGyFYMpJ0scvI2pVZlRB+GqFzjqMwrrR6aCLuNbZg0YR2tBl6X1Z
	N+Bjx3nFraNrrZvWRJRMAFyPxqvinjRm878S/h8Wy7/bo6aJvTxyZ/l8RZCkQo4O8udenCHPyzw
	==
X-Received: by 2002:a05:6830:6019:b0:7e6:c9eb:535a with SMTP id
 46e09a7af769-7f196ca4168mr11743417a34.6.1785711158742; Sun, 02 Aug 2026
 15:52:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802032549.50389-1-eddinen77@gmail.com> <am9Vy9vMsixhaR9E@nixos>
 <CAHiURhuC-dnUJ80T7f3ZynV_qj-b9_9Rs0YxyibCNDeNnuKEJA@mail.gmail.com>
In-Reply-To: <CAHiURhuC-dnUJ80T7f3ZynV_qj-b9_9Rs0YxyibCNDeNnuKEJA@mail.gmail.com>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sun, 2 Aug 2026 15:52:27 -0700
X-Gm-Features: AUfX_mwe84tz8fJ8sgDhS8yxSQGgVksd9IwdQrtrawr7TiahPBfpGwOJJ4IvRBM
Message-ID: <CAC2Qwm+xySeQvjWStSvuz5Er0obFTjVEGrXtSmP=oy7nyH-vhg@mail.gmail.com>
Subject: Re: [PATCH] interactive: add interactive command helper
To: Salah Eddine HRIMECHE <eddinen77@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cc'ing so reply is in thread. Generally, you should reply all so
git@vger.kernel.org is included
(coming from someone who is also acclimating to the list's email workflow :=
).

On Sun, Aug 2, 2026 at 2:54=E2=80=AFPM Salah Eddine HRIMECHE
<eddinen77@gmail.com> wrote:
>
> i see the command "git add -i" that come with an interactive mode ,then i=
 say with my self that you want to implement an interactive space for termi=
nal i say with myself that going with a new command interactive is better t=
han use it just like an option of add
>

I don't follow the reasoning here.
