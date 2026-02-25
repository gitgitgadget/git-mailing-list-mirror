Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070E02222A9
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039107; cv=pass; b=hSOyoZK3AMan2nW+ouv1Rrfx0FUA3tG3ioLgh6jUoOuZiw/BHrzg3O197nfv3GZqB1PIQL02gRReAL5AYzme9XBrecBshWPf9sTwFUcALpbFkF26soz9U9T4pJCv4VPawBBqNWQQ4bfNF6IJTsujJpHeBMBN4PyAj0l7cRxqZMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039107; c=relaxed/simple;
	bh=UoCzslm8S4KTeKkL9q0iDDOC/O713otCz+zU8buChEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IePuI3GbyaytqdqjNmJsR1NsRb+BZBufSgR6V+9ctAHPWTtHsJcuyJXkHi/b/OijyCQ/RGOuu7eN7LeQDsbJooXn3QUDgpZeb1oQwFZszVRrA1818cXAE23eV8+WeYIirdAE9OZ9fLqwjuR2VMLJWtFx6dXgkKhHW7EGAiBWjvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnRwDyyF; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnRwDyyF"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-354c19bf64bso549678a91.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 09:05:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772039105; cv=none;
        d=google.com; s=arc-20240605;
        b=dzJlHuwePPrCVSyfPhU1Q/MbNN4q6/IfyJwlGX+jWChNMecAM2D9O4/mhOneX4dbcr
         551Kq0cpN+Rk8J1qVo8xMuUjDcH/qRbzo6duRFl6OGu/+S4gncXZmlZgEwMXwAi4yG2m
         h+hqy3CTc9wXUlElw+VCwXot/uLi9eujdp79Y+KznahsKARaaDdc8v6XMVwJ8xGDSfC0
         9f+PtMsaznFhhzgIDSb62P3r+EFbFPH/dSwYqnAkyUaqnl28tOcejdgKMU+WYBmvUNsL
         vLZIjYUXki59FWPPl0efuyA/ljt0c2O4iDR0WgE8FgriCLdXpfrYfwdSDyTEOWwYcv8A
         OnPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UoCzslm8S4KTeKkL9q0iDDOC/O713otCz+zU8buChEo=;
        fh=TpfKpXOOwUDBOvXq+SoSb+j35VyizoWBxVJ98kzlhF4=;
        b=gyoJVlH4ZV3QDwaCUOvOXFyqoXgyxK4/+x+DIr9xN3C1izVoQHcge3rx//FxbAXIpg
         R+bXM/Nc9zt4pYm6iGh3Ged5houJ/mHwJZDCN49+rgswa85fF8NvL6P+eKQipBclxo6L
         i1m6wEjoiMfK0m/y8KOD6U7asfGtcOYO43QcPeW1i9/Bb2mmrhHXXjDH0hbXEYs1zxbB
         GDZxemwIWCOFcc1EI1LP5zh3FIWEko7TndJOpmS2Hbt7oios/VfagXw5+7X8ayvnPY5s
         B9gbruJPRbHFER6vsOiLaAYFPlWk0LKGzpDyBogkC+UoHYkyE/gDRQYO1TBaaww5173y
         xDoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772039105; x=1772643905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UoCzslm8S4KTeKkL9q0iDDOC/O713otCz+zU8buChEo=;
        b=OnRwDyyFSC923xgL7QHFDfOoAC4Nnef2d54As5K7X8Xq77gsohWApHzkA0TU9ITBc2
         iPk9Hf4fujV0e+LuBNNZqp648Rtc0b2NtNyhGbTJD/XrxwSW6/n2MyWf4yQq1h4fpTHx
         nMP4KN9Hz4AGSRQ0QsdiNFTxw0FKpw4C6m07JgP3Kgro/oZteYtWfp0FRowSe532hL0g
         dhrvazPrYcnFGYaK+lbvbp1723RhZ0rlE0HaXbxCDyEu3a9itptOgVqGHnwH0TAVIHOR
         1/o2R3360V7VTZS7wzqeT6c6iEKagpmAeiLH08Q75WjAF9gPHi5loHRbIMv39fNNg8aa
         J5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772039105; x=1772643905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UoCzslm8S4KTeKkL9q0iDDOC/O713otCz+zU8buChEo=;
        b=kdQQ4q7OFg1qTL9i2QIxpJ0f+AYpSjTXlEAJ6oxHYOvDBxNQx90k3spUqZd3IhNadg
         qhiVYRDW0mjC8ZLp1a/1kwpl4NiXWOQtTh/pfjApaAxKBDkQdU/fzi+VwVFjs5MJFp6X
         hV8xnM1TsgAl2ih/bc+bD9s9J4sEvdf58TKKVWZ/JmTjpb4tJD9B4JVgLhNABcVSX6CU
         sfS8aenJ7qm/QIXW8UbR6CNq6/iPoR7TYb/cwVzkpE7TGbNXctTCc2ylg4yDy5srHXm1
         EWEm2NJUwWL360/82MTNlhnn+cj6GVKRqUFg4axm/AnuH8xHQPq8bwJJPjWDLcoo5Wuz
         dqFw==
X-Forwarded-Encrypted: i=1; AJvYcCVH2uRAk0l6tseZyQzJMhxFA8ChROOGA69NFGXWSn48m84zB1JO7K6Un1WbRRulYxFE0VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuSwHQHIHYGuR+L2d6Z3oAjulqT2fc3p28e3/2eHIazlYKyjB2
	h30LJUrQhRbNzKd9qvhsEXtOGlK6TM/x7VW+fqcmMfka7uDcNlWxNE0m7MZl83j2HmBd1Z8gxZq
	9SYv4RunXbV7Ct+YZeNQYbumdHSyqFVo=
X-Gm-Gg: ATEYQzwbKqG3gFPZQG4bNQ+eRHXgM0yMCfgiDK3oC3ppGqhph5TDFtX22/cGv+KvvAJ
	WnsIRk3OR25zMWH+UQBmcjfIudzU/cfzsl+wp0VRtl06bEtyEZ1t31Tb1Jsr+MjObpuhzayXKDw
	npAeZZFiU5RMPNSCl63LLE6PphE2T3BM63Zy6bqguNbJjxNLArzcK7TxWU1K0yFPJ05MpEQyC94
	tp/EIpfMvb0HLSz+gy8CCYKxl5SOlm4Z6aocugCxVZPXrbuGqJqjmGQpdpaxCqk0XQp3JldFw9q
	Q2OI/u/oqrp24vKBBtQz1alAivx1KUKCw5Tyf79B0vHaRKu1M6PXQVMzH23jH+6UagoXChoFk1A
	4pBFe
X-Received: by 2002:a17:90b:57ce:b0:358:ed1d:2834 with SMTP id
 98e67ed59e1d1-3590381ade0mr3353279a91.6.1772039105105; Wed, 25 Feb 2026
 09:05:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqms0xeqaq.fsf@gitster.g> <20260225102228.95152-1-haraldnordgren@gmail.com>
In-Reply-To: <20260225102228.95152-1-haraldnordgren@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 25 Feb 2026 12:04:52 -0500
X-Gm-Features: AaiRm53WcFDVkbBGstsa-o-ohNHs2rQ7aBKzKfeeniLNg8JtZU3ZmoHI89bKBbo
Message-ID: <CALnO6CC5WE=K4sX+1NdNc+dV7KJWQvgdChoOfWWJyDQKH5uzJA@mail.gmail.com>
Subject: Re: [PATCH v28 2/2] status: add status.compareBranches config for
 multiple branch comparisons
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org, gitgitgadget@gmail.com, 
	peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 5:24=E2=80=AFAM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
>
> >> So what about this. We add a config option that takes a list of items =
to
> >> compare against. But it _only_ supports @{upstream} and @{push} for no=
w,
> >> and interprets them as branch@{upstream} and branch@{push} (but probab=
ly
> >> done manually, not via dwim_ref). That limitation gets documented.
> >
> > Sounds like a good way forward.
>
> So if I do these changes, are we ready to merge then?
>
> I worked on this feature for 2 months, and then it got marked as stale
> instead of being merged. Will this time be different?
>
>
> Harald

Try not to be discouraged. It is not unusual for a series to undergo
lengthy work and many revisions. It's part of what keeps Git working
so well.

--=20
D. Ben Knoble
