Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CAD495034
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208830; cv=pass; b=JrOYGiEFycNHKj71b0oczL4SoxJhQG5CgeWeROedAD6/OqlaY5IzZJCfYLOX5t1hW7o6NLVBqwiXqz8HNEHYz3SgJ1EybOsmSPXAjOsWppC3kaBtzuRPU1tImOdGYMMzpEOrdrxvGvR09czzmC/20xzV9u0qdwRVz0DDfGFBmVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208830; c=relaxed/simple;
	bh=N4qFBO5aOJYZ9gNIpgRdfmEkarf6pDYFsJ38MlaXZbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nShR/Biu0KdzBZYyposZiCbWY7y1SodO+4b+52OscNaXIn1xL9gArLRhGZy4+mkzyT6KJY6ItaSYzD9AKPjFH/1WsPOHu6xySSUVzynRq65JSDyQnb/fi3xy2blDY/Jka1kR/mxKh/VoGVNOrNUjr/Ot+4shryBTrJ0Z63CU7v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOKOKOZj; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOKOKOZj"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6ae14eecc64so2318202a12.1
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 07:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791208827; cv=none;
        d=google.com; s=arc-20260327;
        b=NnKLqgJq8k+RmLRfV6m/vu0ue/+t4Xvy3K2ECJtM/HWUbmQdyadYP0gq5mLjdFCMRx
         AvvVkNx7RckIsJJEoxPm+7jpPTUYNyZcVLUrPJ2HTx576vAWN419dNg/rCqK/3TIQnz9
         q3uCp/C+zT8FwKFLXKLofu3187LTrEZWJeRCpo/Wok6YsJg5Mo8CKlscdZoRfkhH/Kpu
         VtrMB1L7m6Q5TJxstrets0WcXBFR0x1guHBsZDx8iQzzy3CFKQJoKw+E4ym7428xT/2Y
         9a7Dga4xR0gDoHp5KIhv4YL+2eD6FwJZvas1dtFXqRg7HGGZcFGfOUBn7rW7XANpwJm9
         XghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IvynUgmj0dUT50Yabo4IAoSOw/vVAeAGzBOU3ysJI84=;
        fh=uyNcxC6giguqSMZjKxO6s8/nM9tN1ePibm83fnCpdZQ=;
        b=Cfu3xGF929GGnRLeZjK6GWZU8/eqyIF3YOhcjfslCJhvY8n00lUMZhk/gUZnRMEEpi
         eSqwKXGaA/3+EQCnVyJw7AM8D0sjI7av3Pv3VokgEe104p2OrPP1G+4ifpBtOXu+AaY4
         b/bTqNk8XdmmIaHJ2SabxM4Ty8ObRSEpbQ8rCxIKAFKvFD4enMnBvDHlDrmIsbUSnTSI
         bm1zMhJYMBIpBmcj2vUo182CVWmJCzJH8Z0ZRORZYF6DJvWM7yWMiasz+V1Fiouvb1rh
         Fwqhr0qXGmKrwYNJJnla+dwYnPjjy4PT534QuD0606PtS7U4x39Fp8UqsyJzDnVh/17H
         cAeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791208827; x=1791813627; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IvynUgmj0dUT50Yabo4IAoSOw/vVAeAGzBOU3ysJI84=;
        b=oOKOKOZjp9MqvA07zdZlgeTlCnFf7tGRicGN9OIVoS8jlTJl3hbjZYzZO+bUhhhAT9
         YwexSjqoGgBbq7aXUScuIq4pVQv2NKy8zs9R6zokYByL8zSvx6OzDCGFeRl9N5pX06uA
         THZNhCnn2ld7tCXlBV9JgkvB/xAPrLvVccuMdCLTbC852EuybG1YfBKHwoHqncVhF0Kt
         GOn9cnTFCj8/uw0CkXmz2RbFrJeOoXesKpQDUcXVSzw1nFnR4cAf2PdDT0FMc70whS+i
         LKu+Y0Y1SYZF+6SQ3CCkfw6zdqCxG7hZwg9qOCkO7olrN9VfROzH6llmFAPIQ82N8dhh
         yM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791208827; x=1791813627;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IvynUgmj0dUT50Yabo4IAoSOw/vVAeAGzBOU3ysJI84=;
        b=PbMHzKSIXWetStKyjEGE4K5vraYrNb2PuO2MsHHYks/sPHLCmPxAQu4lZ3Jy2AnkTq
         VKMni6GkIx9nhXF1zEhB/40/xtbo3mEALZAgSTj050orbDWBP5K8vmyJW2iosG+rebhY
         eIX3AwPzM67JH4cxi4D7obRi9BhCKba2To2NJUu67DCSEpHsMN0aqGUqHzLVMFlODw/p
         yQjsiRZYMErFMckzk1PItxDHRw8JILkKUCNrwVDxrhhYq5EBbd+2Io4Z4Oy0YjJ2hQQm
         /OR9ln9WQJ0kQRy+FkQ7vWbdWt2Ea316v0lhP8xZbcoo/49CnYu4W/fQl2OQTn4dQvbr
         cc8A==
X-Forwarded-Encrypted: i=1; AKwUvBwJPxQ+mWt/O9iksFVZM4hvKPJ9jnpiwVQ6Gwp7fslORCIycswVBRpFhwMcmfEbVDS3+oE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzY+3J5S1s+TAAZYU5QTtNUMNrPi9YWgJJtmJHsxReaXIKjzM/
	fr+X4WB+nBA6Fp+HfG9BBDkx4X4ihl22GafqO7h7hjwipHJknOkqSURB/ATI/6xi5ZUq/78EFvQ
	fvVsPXLuBf5F54WtXOSCcguk/DNzPDjU=
X-Gm-Gg: AYBFou1l8qN5/LaTUpVCaf+Ukxrbd1OXU9MstDgK/T6DQKvdMgpccuncvD7kKRTHFTg
	LmKMzGo9wdy+ZwK77PHz3h1XvQf2E/QEscHj1zn0nVJBpGM70CrVURfXkg8JWn0tWfxpTqeC82B
	7TZZLZjGgs5nJ5mSQ2fI732dV5aG/PI/9Hi83Rjq6ooUPzcS+7Qc88kx1LCbLS+bW09jfWRY96O
	HNaOFkYUe/Le5EmO38fd81izxbSFCP9wCR+s+ntLFiiVNjDt3WmFhbBRKZl5bzrKsWITbHvrfoV
	fnS0wsGxv5/3Wc81DCYDMy4hSHPZoJY5djMJn9JN1KnfkcVVGYXnIM4=
X-Received: by 2002:a05:6402:2b97:b0:6ad:22cd:1712 with SMTP id
 4fb4d7f45d1cf-6afada2f7cbmr7182117a12.41.1791208826535; Mon, 05 Oct 2026
 07:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
 <pull.2419.v5.git.git.1791015117.gitgitgadget@gmail.com> <3587bf44-1b3b-422f-a926-f8481104dfd8@gmail.com>
 <8b873f2e-b395-4044-ab15-f1eab4148447@gmail.com> <CAHwyqnXBLiAA+aX8uLA3UvsfD4zaMTcvj96H8DX8BhMVopwcfQ@mail.gmail.com>
 <ea988ec0-ef3d-4250-a0d6-ffdf3794b9cf@gmail.com>
In-Reply-To: <ea988ec0-ef3d-4250-a0d6-ffdf3794b9cf@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 5 Oct 2026 15:59:48 +0200
X-Gm-Features: AclHuK8SC8tWgsEOGRdqYka-YCcNJjV-k7bnVvYp_3mZRrQmwYq9UxVRDFHYWFI
Message-ID: <CAHwyqnUO0zvr+hPT2t0CG-7D9vZuWBRdj1RjC356WEuXaZ9Faw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] ci: link failure and leak annotations to the test script
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> > Is this enough to call this a regression? Then maybe it's not worth
> > doing this part at all.
>
> Yes, I think we should drop this patch. The first step to debugging a
> test failure is to look at the test output, so the current behavior
> where clicking on the links on the summary page takes you to the test
> output is more useful than taking you to a diff that may not even show
> the test that failed. The first patch is definitely worth keeping as it
> makes it much easier to see the LSAN output.

I played with instead showing the file name (and line when available)
as part of the annotation text, and leaving the linking as it is. I
think it could gives us the best of both worlds:

    memory leak logged in t1060 (t1060-object-corruption.sh)

and

    failed: t1060.17 partial clone of corrupted repository
(t1060-object-corruption.sh:141)

What do you think?


Harald
