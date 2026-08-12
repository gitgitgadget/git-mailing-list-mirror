Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC150366075
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 19:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786562088; cv=pass; b=q0BeXdQDjbmiesaNI84b+rVt3V+1KJURbiL+4IiKRYG3xuBPOekfSWrZf1LJlWaO/2j2pGkPQnrhW0/CD5X8Lm2MEsYXW+sm/bnQoGdv6QXxIzCvMeKr6ltltwP5Ot6Sk7eu1jEeb8CMJD6aB7ij1wKjPohNYKjCixm1tyHxB3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786562088; c=relaxed/simple;
	bh=i79NEIDeiK1IJPPeCKyhq5YiTb76Dat2+H3WbD1PQSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNQHIS/syXSJgzKw5Bzmb8841+wxEUKTCl2feZNgEZIFfjv7X4uSJrvjrnhptovl3XDfPKotiMTc67iHlPjtE/POweUnTHt9zwMydlm6b/m4MnryfkcbtlZWZZeuRyjpdBbWc3kWLBaEvAaJvQhzIH9J3J97C252rlJT6IS/seY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=P9FxKp82; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="P9FxKp82"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66c5101a984so155043d50.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 12:14:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786562086; cv=none;
        d=google.com; s=arc-20260327;
        b=f04UkXWkbAmenKCbQ3ZNZjnqTn4/potSbZUBcbs+nlbyqoQOLIZuo+FhzwGQNfH76o
         THDYT6lFcT8DY2CQEVNyHldJ4Ugs/gECS7JfQewUx3SITI//74TJhhhrtYPm/d8YXquv
         W5AoL/oijeOdLmR71Ut8fPtBtW9cDOljsxjH5ghP3iliSVbvPSjWH7x2aXA67qN/8/jW
         F3nKPhMlY36oC9EBD+ksrW6A5zLdroOS8ghQOELoDP1F+ZJ2UkEvRvwwc6uGhA0jDZM8
         3lZSOB6KoIEwta85toLVKyIKeJWxo4UCCvvtbDHwPaFXppCiyYdgH5AAT7wSNto3+ut/
         ovUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=43n1pH7QNEXSRakWKTgqXO9U16rPbgw7ZmuMWB+5o80=;
        fh=nJAHJ0g/ucRU3wDlE888H6R6UiYluL9by1XveHxkWSs=;
        b=R9mp5G6/+ggtMwX6USYAWwnNGUrx3iezRZeW3ymhoRxb7mu3apdO1O8dBzVYFlDcDH
         Z/gY6jMkT+SX/bWdnZYFvA+1s6BFOiz6r1w6mgryPf/XQ5X27/O05AcxGaCDP9fS8mhs
         ZLSO5wKwSrOeEGdn2FUpXbfF9riK/wDdSn2LcuDrULMql5nePNv80Srwk+y2BAxoSjXM
         /7dKLM+exwH/EEQjRu4vHX/Lg/D/fLMU7Wz0SP5iKlAe6Rupz84IGKRRurgWYYIesIl1
         K1llbec8WYhFvlg20DLyZm29pgWIW00gGkmAisBf2tBRL9TACLkd2zBAxaB+qZRgqYxS
         yGlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1786562086; x=1787166886; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=43n1pH7QNEXSRakWKTgqXO9U16rPbgw7ZmuMWB+5o80=;
        b=P9FxKp82qf2GTeByr23lBEfeR/iogLkWh5+cxUckMnMOqg/DwhdkrnkJQrmArE6IwS
         R5D/KaQfOTy2v3NFjmnrimq55MDqqCNo83v8yUpniUulyrIDg+vxV+EY+R84pGJhJn9d
         Bx0fBIjISQSRR8owwMH63r7F35cXj4vj7wG6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786562086; x=1787166886;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=43n1pH7QNEXSRakWKTgqXO9U16rPbgw7ZmuMWB+5o80=;
        b=IBgkPFqXY9bPzULZTAiximqG51s/U8RhHYmIviUgksH+HrmW1hDXt8mzbEt632la9x
         dNMAKfkFjoEfi+ZsnZBeh0qcWWnRBpM8ro7X7M6qydtyHCRTDkNt+5M4XlgD2WiygXdm
         Ikd517YpY/BNomf8lU7itJ4G/RcvbZ3PX6I62+75XiTzIEmZuN7pbfx+l+3eTWmOrbc0
         Pcmd29Vs5mwOaoaioq8UWkB4vlx4gT7P+Av27JOiAlksn7HRK8hL3tUwgyVMgafnWOzy
         IwdNzRwOwONgLxixi8VO/t2U6j2a8sqGWw9oUMgPZOZ+G2o1zumH7fdqGPRdq1y1TUfd
         xnSg==
X-Forwarded-Encrypted: i=1; AHgh+RoIxGVWGUjhFO1UeRKy0L4vYI5IuHzh2qMVHj5cuqoDo6x0RjBXHIhFqH5h4eYLogLiaXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX+4Glivj0knFIN7lNN/uDsiLuRWuyMg1F4IF9qLwe+2SxcK7A
	n6jP7DVwY83ji0wo2leD1r2xV4OL3V4FEbXvnvyuR5VLXSaG0DX2PyhPhY7EeR/tjsRdoMrOKB/
	V+tTevrztIkzyw8JQB3gp60wJEKIs57Pqzi5CZGMrzA==
X-Gm-Gg: AR+sD10W3+V8HqK8LJ6jD39QQwyTuGLGJn+no0CgnuLDTw5COwGk/bJCvW4SJMErbJ8
	cbEI1SkOPsXaPO6glqzgV/VP/R9oS6T0Rl0sQvlyRdAnwTN2z4EWTJ/34yjmyzIXwcOtg1ODQwV
	LwOsl4ngi7XiFh+zmpS2oN5XZCgsH5UjlwOwUbjEVdD4eyzJL5HgUrH2jnMUcnmnVo6Ownx2uIj
	+4CYu4L0l6NtmSDPQjs147fwbvr5Iq/G/aziG0EUQ8cglVaRtt5pib+hIUv9lBjOi7zEcpLdAvR
	LPXd5kIjI6AFjoLwjCA5gsagvOR9Ebfjj6OiJb1WMu5b
X-Received: by 2002:a53:ee45:0:b0:667:b357:e5c5 with SMTP id
 956f58d0204a3-66c514225abmr208347d50.17.1786562085702; Wed, 12 Aug 2026
 12:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v8.git.1786440533.gitgitgadget@gmail.com> <CABPp-BENLi7kBBu9QsN87aQY5C0kamzsKpXZTKYcHZk+WX11ng@mail.gmail.com>
 <CAL71e4NMdOeL0Mwngpw9qn=sSctFEVMPiYEiWQ=LT+Ct-mP02Q@mail.gmail.com> <xmqqwltvw628.fsf@gitster.g>
In-Reply-To: <xmqqwltvw628.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 12 Aug 2026 21:14:33 +0200
X-Gm-Features: AUfX_mxLR8hyjGOUV-LcCXNceEBVOCkSM-Hn41GYDgxmTNik4JL4YmzDg4JPU3g
Message-ID: <CAL71e4PqgwThYZYCNwr6r_qFG1pwsVWdb02WUjJUOHxxJUZpiQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] commit-reach: terminate merge-base walk when one
 side is exhausted
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>, 
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Aug 2026 at 20:24, Junio C Hamano <gitster@pobox.com> wrote:
>
> Good.  We can declare victory and mark the topic for 'next' now?
>
> Thanks, both of you.

Yes, I would be very happy to have it advance to next,
though I am of course biased.

Thanks,
Kristofer
