Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9CD52CCFB
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790690013; cv=pass; b=SLcQEYH622LGyDEMyxYzLPcDhcu7qh5J5CmRVaX91HyYW6m7pPAt9J8ofDBrK7lPBe8l7wqWv3FPf7mwuWcHJ5HLZRC9NaTfkMFvwe7O4G3V/YceedHqx0AILZHOeITAlRA9GZ8ryRezKyrCcCoWz9pRrZFM695nHlKCc40Pk6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790690013; c=relaxed/simple;
	bh=kdndImCY3TIPSOhFBa9yN5o3p6U1nHCENTJyCzllbP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poNotecMEbXM5pSMhmoJLCO8wNcxp7NUItDw65DNv4iGDluDSGY8N0KQ/FGm6qX+kPClXiyT4q18tYrkGN4Ex+B9Zzz8iWlDw3Zt5GsWEK4swTUC3onJzJ1+Mmj7/JAW+jbB0jZilK281dqhy+wnSrayUrQFNXylEtozACupAxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKpti/ww; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKpti/ww"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a8038a9f10so5768534a12.1
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 06:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790690010; cv=none;
        d=google.com; s=arc-20260327;
        b=NFQ7RGi0abxwpMHQAkBhxrSO94M58NTd82vSNiwg2dC141G0GqQ+eyx/hRfJr5HRdK
         Pow6Iyn42lQXIJahR4k33VzN4Cd/V6LhETL4AZGGyYOi8jYKoJst0rpFdAMy96Vlh2Uu
         5XFhH4/ArhE2g6lvNwNXFrrgZwIVJ3pIiaUn563T/Crts8L4bkTyLuxlgcGNUv7RCx0k
         pT5EWUkfKaGK82v9s572lHzKP+6q4ZH7Dih0S4YJj3jhb25BmF2ow1PM4IspskKNjMiu
         s+H330j3aYFqvUhWFnn6hXBeZ8yRE47QUxsmOais38nl5eXQXxmOaN39IM6VleoDq1q1
         Y01A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kdndImCY3TIPSOhFBa9yN5o3p6U1nHCENTJyCzllbP0=;
        fh=3dj4MoX22FWzZKJS8nyOk3YXDeos8JxqMY0B/pw6IyM=;
        b=p1NF+vTJum3gkp8NUeWjJ/Ekk6/5DPjinuyVfUQ7K87F2O7Z7+nDJlv0iOBCd9NIho
         Lstd7C2h3aPi2X26658PLCpBZvHjfO2ccc2m9RGYhazAYqvpHtrUQQ5rmSHivdExc++i
         T1hd5r6GFUfle8Tlh3BERj3/7Zz0eJzmtfqsI3NcxBKVS9Yfzif2uKWOhZzX/cRZR5ZR
         w3oGFlPLDkVWI0J9sXml4r+NxQ7U2vSDkGbZG/uF6pBrmqTjizu8toh3owOfryBxFtwB
         nz09v+NYRvf+qfozds1/jxXeYK1IQMWKa752/SCtpXKwAraYgChgRnM23jRdLF2a3rG+
         KBTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790690010; x=1791294810; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kdndImCY3TIPSOhFBa9yN5o3p6U1nHCENTJyCzllbP0=;
        b=iKpti/wwfhs3VNO3pNxyyQ8KyaR7DdF16a95KzN+GXcQpNyNpNdui0+Cvw+jvTYYP4
         QWGvFozSVYEEcXa9qxLCrmzfCkmJFBkbRAQv04Eeub8hlXlxZOGUXaYpezdn3uRejpm0
         aHZWn+at1P6KsA+jQ6bT6aolRq/0GCsPWnvb8ZJgoWal1+aa5sZ6TxY3ypd7shZ5gV4v
         KyYTntYCb4ZhYPT8DtWB5Nk+MTizoMpP1OSPqhOfKB1sg6b5ZU7sgEfyG3QwNcbFekS6
         PS8OSrlAu8kGJdmYtKMqAZY0XxawMpuf2QO/8b2aRMmu3kowdRYESoBeFn9EVPXlxAez
         9ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790690010; x=1791294810;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kdndImCY3TIPSOhFBa9yN5o3p6U1nHCENTJyCzllbP0=;
        b=lsUF48GA3nK/oyN04zltpkCVNjcusUn++FWL8ROGLnMCcrWj7EiYrCP73DmEM8kvKK
         v9Ui1uTxiuVzynl5HqkGbnVoDcRu2MzuSwE87HHUfbLC8jYU+3umw1YGaBxZ48u7BN1Q
         ZUodBid1AoRJiGyPeWyp87wbFN9BRnL1O77KPA0VhYpBCYbN/5LdPXNoQDSNAsfu4m8D
         l6OfVOn+yzCO7mxcE5RNvivOrejCGFY8DuX3xiaZ6wxuYc3DYzlLZmnmPXij59cg3jvo
         +XWO3wOX5Qcy08I1jArju4Xl1gMAjLCLtU8SKwsUHi1cwwc2kxROkVyuO3Zww+qlSYJy
         xH7w==
X-Forwarded-Encrypted: i=1; AKwUvBxUkyN3WbP1OkYTIqoRfAJkYzk00hQGOoks89PPgtyiW504kVjmFVaU+cAazQPVgbrvRYE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBUWZR/m4ejVIiqwPf+gpljIRe0bvR5R59Mp6n7muSuD0OVzN/
	i0k7/qGz2+HwCN1fKycD9Viv35WJIterjOjlMSDRCq25ok+ahvGy2e3vk2eV3/Ay/qQ97Heuf1p
	VVCV+kFhl2TUS6zsIcV1q6JBMDrGJuCY=
X-Gm-Gg: AYBFou3fWIdE4Q7g7h4s3bAWmJB2vSmslvKINZEjvx9j4/i0U7cgGdupGbrAt6VZNWM
	hXW8Er7DpP2tu4AE5SdQKU+zVU9uccWM5kw9vzylCXUfgjl2srOoIbtgy1afV9o6meuoRC1TodP
	3EquTaKe2DqxkXvM+/cFZKGG+c60iTvsPdYFUJqnipkREQyeVcfGRKrNcVkVctIsQ6yBm7UTyii
	16GSo8jQ90A5LuA3yVCsVSjt4fOHrdZVTdfuqN0jDLQkuNB/JsSIv8GhMcNZ7u49jRFHLEjYl8x
	0M/8Tm22P1D/Vpu7mk53zc1CjKCHf87njPJSG/3utXB7R7oi8GoWLPw=
X-Received: by 2002:a05:6402:50c9:b0:6ac:5c83:bb9f with SMTP id
 4fb4d7f45d1cf-6ac5c83bdacmr5815505a12.9.1790690009940; Tue, 29 Sep 2026
 06:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com> <CALnO6CBwWy3aafyDJPKFk5vuWy2EF1n1Oc=W7+RVAE3rxpXwiw@mail.gmail.com>
In-Reply-To: <CALnO6CBwWy3aafyDJPKFk5vuWy2EF1n1Oc=W7+RVAE3rxpXwiw@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 29 Sep 2026 15:52:53 +0200
X-Gm-Features: AclHuK9Qiwfc1n1D6Vzs_sVHfQcDbsoFe1gb9GorHIGRNgCsWANReqJK5K6K0qY
Message-ID: <CAHwyqnXLAQgTen2nu6xX63ch7Z9V8kZ-c3zbZgw_xwEVYaz=oA@mail.gmail.com>
Subject: Re: [PATCH] branch: let --delete-merged find squash merged branches
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Anyway, I can see how this would all be fairly expensive---on one repo
> I work in, git-range-diff can be somewhat slow depending on how many
> commits are in the range, I think. I don't know if it's worth trying
> to state that for folks, though? If we ever make improvements to
> performance, we'd have to remember to remove the "this may be slow"
> text.

It was much slower in my first iterations, so running this on my local
Git repo now does not feel painfully slow. Although slower than
without this feature.

We might hide it behind a feature flag?


Harald
