Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EAB3AA181
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762865575; cv=none; b=bfuTsRei3eeqaoC3oZ2FP9baW4O0DGHHdF7iEHBMZoj1hwEWlsa44XbPI/gAojfpawJ2jyaYeqYm3FvCWIdWgFOM5y1ZiSqZ8UYnD/EpZg8aptKtalT7mug1KkwZaV6L0yjzuNuDz2cS4cCxLO/w3++J4D2dQ4azjfYvYZx35fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762865575; c=relaxed/simple;
	bh=HGkxFqFPn4p8TL5e9u97Deadm+TxgbfQ7m5o9HCjLEM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Kv3XKnP08OKTOzqjaOrehZeFXsj3T7mZZOTmPIBXN7rLypmDk0XyOAHRutJMaHcPaWZUw2wkRubUKY1W5/2Dage07zxm7dp0yVFqKSpPAv1imwLizq7ZQ0C8eWHgFvlLSbjYJgQN862trsm8wAlS0ylKSi2YVvSLXlW7BSfY9nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwhU+xLp; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwhU+xLp"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso2449594a12.3
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 04:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762865573; x=1763470373; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HGkxFqFPn4p8TL5e9u97Deadm+TxgbfQ7m5o9HCjLEM=;
        b=DwhU+xLp7elLZ/7jFm/G69EXHfl2R32iLEZo9L8LkARCeO636kN8AWfe1rVPEISa3z
         s+bajLJxY1tZhod6N4fogVfxZwTijFnDXB9Z/MclDsApcMdDYJ1FSJo3XRC/Wm69I1GI
         1CwozKkD1kNge3xqaE5dnlrUGs81P/PYDRHENm0OG3eIo6ZAnSRq5AOnj+eyyYujukMe
         9Q8g0OUdooYVeP334sJotY1U0nFI34i1JkgjzeRXqNkjjtRy3J7R0SWJi6YGxu0wwii3
         iIKdYWeBLJEH6LDqgstZUGpH2E4LTQPGBfjCsP42Oa4MymjqEZYn/QMlYUbPFi1F3tww
         0tMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762865573; x=1763470373;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGkxFqFPn4p8TL5e9u97Deadm+TxgbfQ7m5o9HCjLEM=;
        b=M7P7vfH7KNj/mKN676kPnGmpRJhPVVbwAhSA/qwQzpLKSZfwAzdNDZMzdmltr3Zgnt
         z8iEB/eRuCxdYUwkT1XrncIcrVdVFsr0KAttdNdR3WQh275abFy8Qmu+QNQ2GguOa+QB
         XhROWsxv5OJClwEsF9p8c3H/QsyQB670DyMRm2RrXS3QwRcxtZHtTm0JNYe8YkxPir74
         KH+SsSh+BGHTmPAoMc1BIJCamw0fWELKpSg3X2AdgmTMFary2LvagIE7uErCKkJiJDOb
         8qSgrQfykDVbrokLw8ThI6fIIgf41wE4X6/0nY+kusYCTUvWQ9zabQHf5G11Wt/lH7pz
         WYKg==
X-Gm-Message-State: AOJu0Yx9AeMVJsTwoq4L7UF6Rq/hTqv/VbqIGWcwC6mT6UQVDdJz1p7N
	Ez5D4Wy3iupZuYZ1/WOuZmnGsn5eb798TKmPrHmnuAFQ0JD41ZGcgvVQ6j983QsiSY4+Du9gJUU
	VJvOSzDIEROeUiVnj5zk1vfGHovHEiKLDiPOD6jY=
X-Gm-Gg: ASbGncuBTM5CTBjPBtasm79IgH9TrfUXLMwwl5Tn73ad+IXqO4zg5Opi2oiOrxGBY6b
	vKtXtdNy9Ke+oSG7RNcvFg2SRuwsn89s/CnQNMYb8tIDtVZoLbwk+mkUksFbTr5Kl3Y9qCGmhZx
	hAJ8lZNi1z1esOJLs2cueJJGe00ZRKAiOVMGd/M92iJRtNs0z9SYIOJt7xTchUrmX7cFynItnxR
	lZ67/VzGkH1759z50ant9WICWbYYmyyIJORzAWyPmCCGTEtfTYXiozvZTAtYTFuEr2C2z6C
X-Google-Smtp-Source: AGHT+IHIhVR2JkTsU0JgwQxmm0STX0b0Vk5GLeUxi4asIlSEYvabXasYTIQorULzhamGmTiXR2C3w8ujm4vl8yH/U00=
X-Received: by 2002:a17:903:3848:b0:295:f95a:5122 with SMTP id
 d9443c01a7336-297e5627d72mr154521185ad.15.1762865573247; Tue, 11 Nov 2025
 04:52:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bello Olamide <belkid98@gmail.com>
Date: Tue, 11 Nov 2025 13:52:54 +0100
X-Gm-Features: AWmQ_bn51R1RnJH-nV_RNmyoOl8ax3qbUsgzG6OKSlnJ0y1J5iZqx0ynP_LMvqg
Message-ID: <CAD=f0L_F-c-xACU8z+2GwgBwzVsZBLcMvtVbuB3phC73_xHBoA@mail.gmail.com>
Subject: [RFC]: Continue contribution
To: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

I participated in the just concluded Outreachy contribution phase.
However I would like to contribute some more to Git and
I have been scanning the codebase for some #leftoverbits
I can tackle and an example is this
https://lore.kernel.org/git/20251010052256.GB1965904@coredump.intra.peff.net/
which proposes to pass `struct *object_database` instead of
`struct *repo` to `remove_redundant_pack()` and also modify
`clear_midx_file() to accept `struct *object_database` rather than
'struct *repo' in the bid to reduce dependence on the `the_repository`
global variable.

The Outreachy documentation permits continued contributions
after the close of the contribution phase but I would like to
know if the community is okay with it and I can proceed.

Thanks as I await your response.
Bello
