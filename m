Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793111516;
	b=FczVBtRL5Ru1gMRPPyOtbwfICHyIRPoMS4qgwMFIgbegtAbodiDCTHEGGXy0V7+9VLGJ
	 TbuK2Mj3UwY0u6NGsWfqRyOzF4u3lUF/ooK2Jsaufvj1r6mPh6Y+xoywNSQ0YYYzIDDLS
	 nw5K3iEQJa2rHCzAeIPGLpsOnWzFe1o1UtYRpkAITRDice1z3pUbBF7gR/T1WH53Su0Sr
	 AfAIsb9cIaGMugfhRImCzjeIhijodDJr60ujz4F/hMgbzpgcYON/YxpKP1951h1nMVpeB
	 OOymphSDz2AlRILZEXPhHI0ekpelA/MLL6M1eMAgXkSvDHsqaliA9IZE6K69mXFwXWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111516;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=tUXLYgPR9Kfu6zezNLPPU1pJXKmt0kzXeD/ZZfljyC8=;
	b=uf31XEdMFXidfvxm6SXhQ7KqtinXndbm5gDH+aLFl9HbcnQ+tyfsCYKWnOto5HPjq+/b
	 qS9LZ/8pKsGuzEewzSf+qSQEMu8Oo4bkgg3VX0aHpaFawE1bikmBZo6keYcqeBCwfB3KP
	 jAOBTXgOQ6rk/tSPLsnui0qcRJmLLUcxneCtKuDPkyAGnoDbCITlIXYUP5tRFZpMX75VF
	 NgXprBCxlkSWDGwB6zeoKfQlqvbPXKP+CDtp4u7dvzM/gQwZJZovinIXIpOsIBXu/PpbQ
	 to+f2Cl66va8aVIsUkebmST8Td4VwbQw0w6mnPOuBx+oWivPAf2eL/9st7kZwZ5rMRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jqP1xFvR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF9B606A325
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 14:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FF9B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jqP1xFvR
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1438d9363fbso1053588c88.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 07:31:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793111516; cv=none;
        d=google.com; s=arc-20260327;
        b=H2XOpUI+XY3xTS1rOj0mPdFi72bXehl0wsEi4LRTfRsUImeCNoCo3ZSto0LwGNibTs
         RtZ8B1vmF4olXZESv7Zu/SFTvLOQ+XORIwAMMcnJt9HHj+Rc6rUWNyKQBPCatNsOS2El
         as8qdvqpxSmy5e0fS6FPiHLwG7/V7gL2NISvDK9pgOAHhhhw9eomZ+Aak9LR+4x3bTvX
         ZtapKntCl4DdUFBlu/UmjQWFe2r/mCAHTbO+29X1zQmbyyvMmMaohJ7AWJBCIwZvAVTO
         TxD3jM6HrgDoA2a69u7KInUQy9hTg+CnIGpD3Om6q7alB1yCN5SBC5ubOLAzyeMaL2mo
         hsrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tUXLYgPR9Kfu6zezNLPPU1pJXKmt0kzXeD/ZZfljyC8=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=ce7D0RCPLCUMy7SLrrp0QB1Vgs3iCRTASFHQpaVbtjBAVjaOXnlQ9xtrjUIdQNAuhx
         5ALwRd7ocThcMrao7EuAoCwY7neHYK+T4D7zM29uK46/N4FWazMGEtnhY2w3nGRvyQRs
         ipJZu09XkqkTsL1Mvf7hsDJPskvcoDwp3fCv3kyxPTLjadJ0znGZRWtV8W9WFSaMOFLu
         3X272ZegAhlrgBzKMy6NmjI63MZ+UxSl3sYrqs4wZ+y/+yGDpinos32yC4Jsk/YAK23k
         Tv9qEnTCuG/6sqZ7qG+Uq+jBk9ZIDK3O+ybTBQEk1Fk6jKUsN1w7R7ZSOF1XM+bsLv5T
         lwqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793111516; x=1793716316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tUXLYgPR9Kfu6zezNLPPU1pJXKmt0kzXeD/ZZfljyC8=;
        b=jqP1xFvRGCGDvBRiSZ/uVAyNPJIV7Wjgi6BXCCMPhuqB+0kuHn2NeB/yEv0rUIYLJZ
         OMg87SllLKZ/lrYfbPSuIqulm1rlOM7yqJpar8P4nVrhNksjceluJbRRpkQeuhaFjmuB
         whzvNZbJOQ+wIGRhWc30rb+AJZ95uzsjo15Jz3S6KsSluDBMmR1KMcgKw9li9aEMbmcj
         VxVUc6geG3sJmaggz3O9VPtbEbQyGfcX11gqW+YD/iHP+hPy6clRe0sAKU/l8BPJQtua
         7CiLNJW/dYivV9eCvuEgllvcOR4CYQeVk9DAHK88vSP/3QAis0YrhCeKWkaeVz/x1R2Q
         EaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793111516; x=1793716316;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tUXLYgPR9Kfu6zezNLPPU1pJXKmt0kzXeD/ZZfljyC8=;
        b=wPK4/p3BsanJ4S3t+gFtC35Miw4ANGDLFrHgGdIowF8oeNLOi/aF9gG+ac0V/QTf5K
         6Babi0nIyoeJaJGNW+3x0wzNuNQgYGoyqYocU1bTJuQRdef3AWh6DYZBoce7NUcwa14U
         +Cn/JLOHt9+mlruEFUuCvWjLCV93F4RaFe6gLjvxfPzfZ0SUczvXYM27JNAFn/WQeqAQ
         aHtAn3V78ch2d+spRzEHQYlcyd0wQcr4D9Uex04uurCJEHaw+ppJRhmtVOQX0A1tgx0h
         bITVWxtOeQgg9rWTFQZQjZGDMBw3xz/LDwRWkQge74i9t+xn3v2ixbegEha11IgGc42X
         7OlQ==
X-Gm-Message-State: AFq9FYLzdbLs3K6eskWdcgAzo8Kmwt332pM6j7ucBgzOS88YhqOjn9Wk
	sf9TuIEt9tWpGAeCzaEMYQISt5Yjmvo1dTljERLcs9Ue91wnqULyMOnUBHhCs7Em3R57H9TOuz3
	beBu/jT3VDvwZxiMu73bDuxYvhoZlB34OLA==
X-Gm-Gg: AYBFou1pjfUMUbpS+Vyj0T37pp/9IEx44JGy1hNEF4lhyUWhj2UuAH2lWm4Sdfm4act
	pXG5o3xAEtiRTutGnhXP4qtQcNZwYRscE0WkxBhTwDWulbW5jUi6d/CtD06sh/ujp5/rHZx1saM
	6aug3PbvgPJd3dZL3jLaoh9zh7EI6D59wMHTiUiBKIo1W8UjIk4YXJN5dFSurF2U3pEdHlkFRhi
	AAIjBkr2sMd4Aiz3Tbum1jlXvoq7q0VbiflITK3umbVxzEbKXUHH9DqZePdaWT6tTpbA6eXmyev
	PowyhofLM44dSzmXOWG2lhSvEaWKMhC13rrNstasOeYPafJVFNn/aqhIllU7/oCRBV7B+XWSlKI
	5HimsxEZ94lDmeiPbaxoAJZ6AbwkDVufX5sxZXDvvwPkSa8p0u/AAEPBWmlZo8H+B0P0Tb8JkGK
	FYDXWvNdbanZG49EXyQtuiPr2//GcCOiZsudwC5cqdAm95LLbhPmNheITLAGr6NtYDq+xte/irM
	6vMD8OHdbE+uS6qpbIq0B8R
X-Received: by 2002:a05:701b:2214:b0:19e:3464:ce40 with SMTP id
 a92af1059eb24-1a3c324036emr3510287c88.1.1793111515428; Tue, 27 Oct 2026
 07:31:55 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
 <20261023-pks-odb-files-reload-alternates-v2-5-30559d7ff43b@pks.im>
 <CAP8UFD1-Fh-fiGpFiVtBk09JygbD0P5fOYHgXjvk1X+YUCVyPQ@mail.gmail.com> <auCjz2OeO3GiRnDk@pks.im>
In-Reply-To: <auCjz2OeO3GiRnDk@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 27 Oct 2026 15:31:43 +0100
X-Gm-Features: AclHuK-doPNfPYvi79ffcp5KHZZxFXRKvK5I5syYwOywITCwFvocHXYTtw_8D0U
Message-ID: <CAP8UFD0B_ra=GG2GvGX0Sou14gmJFz-PTS-cnCPm0bS=r7E-sA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] odb/source-files: avoid stat'ing already-known alternates
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 2:14=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Oct 27, 2026 at 01:36:35PM +0100, Christian Couder wrote:

> > Does avoiding the syscall means not printing the "object directory %s
> > does not exist" error then, when we know the alternates but its
> > directory was removed?
>
> It depends. When trying to add an alternate that doesn't exist we'll
> continue to print this error. But when such an alternate disappears
> after we have already added it to the object database then we indeed
> won't print this error anymore.
>
> I don't think this really is a huge issue by itself, as it feels
> sufficiently niche to not really matter, and the end result itself
> wouldn't change. But let me know in case you disagree.

I don't disagree, but maybe the change deserves to be mentioned in the
commit message.

Thanks.
