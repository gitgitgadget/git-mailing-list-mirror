Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C930B149DF0
	for <git@vger.kernel.org>; Thu, 15 May 2025 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747326758; cv=none; b=Dnk0Os0ZfZUyjbwhqOlDpUi8r3k6QS4z+EQ6oE0eCCB0Tq+F3a1IVhrBTD+bGR6+egu5DIqufhAPk1LSzmfKClDsk5+kH8CyWmdPAB5R87sXqpopVXzf2ergBSqv9FdRpqXKpX8WnFm+5Xmik4vPJ1n3fjpqXyLMhHMG8YGpauM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747326758; c=relaxed/simple;
	bh=2CxCT8Lid3Wl9D0zPrw8XIZ1IeGAAFlwf+/vjYL2z+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cD7aL1WVg6yjV7c11M5f2RJoq+gLI4JtiaGp3Dfp+dFtz2FPMYwO2gHKgzw0cXgBFRfJuc5D2s1SqeQvFhJsZbnSYcwbpTaX1oZusOPZwtn/VoDy01LQlgxkyHC4DzpvzinRKLN2juBYIDuiZBNTU0bp3ax2nWhq+HlTgoKS8Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQoMvtZl; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQoMvtZl"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-605f7d3215cso714175eaf.0
        for <git@vger.kernel.org>; Thu, 15 May 2025 09:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747326756; x=1747931556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRe5mI3nZWMnfamWGxtpoB4kcQlh5TBes6Y/Jy/P3n0=;
        b=KQoMvtZlSCSZgU1XKrVvt8koU9RoyXHAvmoUTilH5nke3WH/MYED7bEr6zNESpslcC
         oefsgid67FPbYbE8Z8JjRUl3NNkkKon7AYTRApPkIvtPhOxttiz9PKRfNNM2CBdyCs85
         stGN0MWTflfaab/bBc4JRm7FY96wpO84UW2MESXBJZ95HtqOJMUOSyZxtLGA2/VpJ19Z
         SvNayHANTyeZcYr/Qm0uiwrtUm4lF+jD1mEEz2E6yHAS10gk3BEytmtm1//6Q5EqJktU
         y/ploqlu9/s/CzA8eYcc7nRTfT0C2tqKd0eOo8EfrhBgk1/c3lISuPaMTh4Xk0O8kEXH
         3wuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747326756; x=1747931556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRe5mI3nZWMnfamWGxtpoB4kcQlh5TBes6Y/Jy/P3n0=;
        b=hBujZ7cmftpVPWGDu6l10ByaPz39m9l1nWaX/p/ba5Ow/NVFa0clD8CkFzGSia1Iyc
         +C8nPU//Zqq1f4vhBZHAQGnn7boaiP3gsZ10BjzWeI0wmZ+mxhG8McE2rZR80+7EmlIl
         J5Y/+zh66enyzvFxbt/5dooVn/hC4msMXldNa5oWrkcLYhdOLUzlSKIjTQZStCHozx4O
         wkvG6aL6JzZZ8MHoFgrfhT0+t5dXEkdnZ5zlkb5odusSHKUUoWZi08GEgRK5Idanyy+l
         R8M2USBtUmCsqE+5EzrDpizyjqKEJ/6TxQCrBdw4gu+mIVY/3MbtsfAzJH+8ICmSWcNp
         CTeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbEFcTiMqrPiFbyMpZIlgwAaFB3fvnDw5BFw15uWm0gKVWuKiJ9SWA82xugENmHmsEHXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXoNoLyuljbtOChs/+7rVyvIQz4D+AEOs2UqNG3ttKz8IQ2VFP
	d0ONuxftl9EBK+2WQyYade9Ab0FruCNazm9cOTGqwU1TYvt2sbcUQKANAxTRYrTCiCa7LOBh9hc
	VAtNJIImjuaf0UpS5tKaM7hfJkw3S9j8=
X-Gm-Gg: ASbGnctsrPjP6TzfABhOUKOH9CDwZeGcuB8nXEeA8VUP/UvRgbyHlM70NjF7Qh/z/Nt
	hfexM+BbYTFfAkNZqPlIvkbbY7mtaXeLyxALlu57NrTmP49ojBZqXKt42mA7jHiAvBbIrUKuwFH
	1XxWFj1jmIPoxdn23cdjejZ1yAXIeoUsSBKw==
X-Google-Smtp-Source: AGHT+IHP/XzyiL9ZHiN90RURIlRNkW3GIanNAfn6ltYxKJ9U+8TmS2kEUS5yr1IZWnYwdPf2iTJwdSr/iKqsGiDxXI0=
X-Received: by 2002:a05:6871:60c7:b0:29e:3921:b1ea with SMTP id
 586e51a60fabf-2e3c1ed632cmr72832fac.30.1747326755730; Thu, 15 May 2025
 09:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
 <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev> <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
 <aAgWytQNqtLzg2TU@ubby> <CALnO6CBq2cqBAhzMh8rnXzc8cPTsB4hz98YVn3B4+PGdiyn9_A@mail.gmail.com>
 <CALnO6CD8JTnNGfuCtb1QKFhx+Vv1txUZ+wCL1nZCDGAvHx6A6g@mail.gmail.com>
 <CAESOdVCKTnUbVuXq-=F3df4i2T-GcDpJMENr8wwm-ZXR95+59w@mail.gmail.com>
 <xmqqtt5pu5g8.fsf@gitster.g> <CAESOdVD-8j9k2Dq9WgiR9WWO09mpfR9Xxe3pMUWg-KoTfELG8w@mail.gmail.com>
 <xmqqjz6jb6kd.fsf@gitster.g> <aCXCgKYpEqxWxIT_@ugly>
In-Reply-To: <aCXCgKYpEqxWxIT_@ugly>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Thu, 15 May 2025 09:32:23 -0700
X-Gm-Features: AX0GCFvThma-e1XCRT1wu7rT_nkTRW8EVIK0QGgWB226F9PYdb2jtOqwW46kU_I
Message-ID: <CA+P7+xrruw=NUJgzV4D6CQbmGJO4CEjhkU_+qFDruD5YMsidDw@mail.gmail.com>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>, Martin von Zweigbergk <martinvonz@google.com>, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, Nico Williams <nico@cryptonector.com>, 
	Remo Senekowitsch <remo@buenzli.dev>, "Theodore Ts'o" <tytso@mit.edu>, Git Mailing List <git@vger.kernel.org>, 
	Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 3:49=E2=80=AFAM Oswald Buddenhagen
<oswald.buddenhagen@gmx.de> wrote:
> one argument against change-id trailers is that they are eye sores, in
> particular in small projects that don't use trailers otherwise. this is
> in fact a common argument against even optional use of gerrit for
> reviews. having a more "subtle" implementation in git upstream would
> certainly alleviate this.
>

At one point, the driver team I work for wanted to include Change-Id
trailers to commits we submitted to the Linux kernel, for tracking
against our own database (we used Gerrit at the time). They were
rejected for this very reason of being an eye sore --  (possibly other
reasons as well, I can't recall the full discussion). Of course, if
they aren't in the commit message but instead a header, it would have
needed some other way to specify them in emailed patch form if we
wanted them to stick around when using the am-based workflows.
