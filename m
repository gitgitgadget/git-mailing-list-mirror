Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793622249;
	b=TOxGoxgFWqZKhA4hgCRad2UTHwpkaQ7pmF8r/PA3HGnn123c7+Rf6L7egeWryDALuNe6
	 UXNFFvobbIjfM6klE3sbYckxvYU5Gdd1CMj8w+gl+3Wif8wfO3uage6Fin4Vy8CXleQi7
	 HBGHe5Qfq2xWdJOufLcvJIh2zYZ6pyTViYzETPbjG0RhWezgefK1+qLvq/cQkJa24KWhZ
	 zGxEgFmu52xRk83E3Ov+VcCR2YCc8Tx6N9yJVBoD9rXrk9JAkyiAltrd2MRlzH+ErR9WN
	 PEcEQFtL9qDocIFGa3FeiDRfPhs8sVz/4yz3V0W3uXjdFrKYffNZ2q6HRoz1pofP6dg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=3egEkF8fz+K8EO6rtWj1C9y/zqizqvra///xoBB1jOw=;
	b=GRPfe4pTHUhEb8KT+R6F/oWq7kCSpGvaIO6qj649IhhBOOM5gix0q/ynxN5+bLqDhIes
	 AJyK9AgS1Z+7Az2NhYx2EYJyLRu1E0SMyHcCh7yXcNFWO3tLvWkr73HDzZW8snp5iTq98
	 H7LsheM59VehrTF4RXEDHLARAunOpAYAWbRUklUN0zAr2EOdqaleXlSw2BT+AURpE0pX9
	 FqNlqqCdu3hQcKx3KAPx7d8mh1yx25ymK033dxBkDziVfjrtGfvalmTSqN03ibluU07bd
	 pqI9+B91naxYQf2GjQa9Vkkr5vU6npHBeR/5y9OAz9t3EvCrHHS7t+EZ7VDmRrh+A4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k4Awoa0d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA4B606A327
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 12:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BA4B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k4Awoa0d
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-675676afc3cso2799575d50.3
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 04:24:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793622248; cv=none;
        d=google.com; s=arc-20260327;
        b=SlC290dHEE0wcSmnhML+6B9o1WTqLCpCZ2fn04mYsLMJVj2Tp/sgHquJd3Alb2zoCi
         LVsRoQlXuZf446fk3lPwQjatFuX7qE7t8urULA2eR383IVysj+Os1jfdNno3mrEiP2Go
         3m5xLkH+JBUvoF9iJgdOYK1kdHA+AJJ89PpC4variZ+cIDpcsbXUoU9RSb5rm7gV+F8u
         XnNrxaif46sF3FrgbDpP7PWoO3dC1ZQNvvtifgZFY7jtuXLNgVezveoGSHILVaNyVCJy
         KBreIXoEZkAylZduOACOX/HLVE/afQYAfNN3tqPvmBtl173n133pn+CTJcP8qXvnVnZV
         rBDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3egEkF8fz+K8EO6rtWj1C9y/zqizqvra///xoBB1jOw=;
        fh=UFgS+MemBBR4Io3o06YEiljwKGXt0sXLpVmBlF/0XOo=;
        b=debuFsKnbHkZsG9JHodfwKm08XP8BIFqHkWJtmxDbwUQkVYHvrV/jG1v+GCNsBt7Mn
         g2TmCdjrZuNeWuk+Jp0jCB3V4cPq2BuwNPVdjC9+GiH2nnpb+8unKEIvQS9Fma+rdIA2
         EMgYeKH7XMCnwhSWw00qrMhiiEaRaCL4dPy7q1XxexSErhcbKrVTT6UH+bpDf95EpJmz
         SBuNZq6FZ7Uy2pKUFY7baAXu3hH+k3JGElKK7Aer1x/XD/H6gaFi1KCYGWHnnCt7tso+
         NwtR7I5qWO42kwk2mpr2Vclc5tPd30nkvA+/RUiLpXj0WxZ9YEN4k2zzK4PeaBlbQEqr
         BNNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793622248; x=1794227048; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3egEkF8fz+K8EO6rtWj1C9y/zqizqvra///xoBB1jOw=;
        b=k4Awoa0dUWzOFKa+dnskiw1n02Kw91i7sP+oAiQ7U/Ojd1FDmJE+A6C0YJ7aSaaewa
         Zy8oWlMudL46nPdOpbe5TIKuW06hd7ok6j2NZce3dqLAVRVFeVRNkuiFfvFSuvkVhFvG
         FiZ5j1Pjgu81MNn5CS0Cf9ZEhh6JXoUaLcJ42hMwSYyjoENOfaJbukZa8oK99ULP242t
         7GIu4o1mcyIJgZUBehpK5jI+Hs8hpxSzArVA38KpZw4gaTATWXbB5qXTc4LNKZuEp0N9
         M4zqmiKcS4DxvdqbbOiA2xdmrr+hxDzjw0Kn9flBv7pp+pjFGdqmVsUMSEEJlbjNRgha
         L8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793622248; x=1794227048;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3egEkF8fz+K8EO6rtWj1C9y/zqizqvra///xoBB1jOw=;
        b=YWtYHTxj9s0GZjk9xriNr2FueoWp3CPk6s6sdxKe7IbPLDeUK1K5QZ3y29r00Vmbfu
         RPYvqzc4MvJGF540lWYYyOEO3SKKiWttDSQ/6ILl+Ty4Pu1yzwnvnV1n918Fh0o7L115
         bBfBY00rOGt6O9pE4oFnL26x9AwCIYz6IqNEkkIYS8UeDZcGRg2pCrjaAvby9C9Obyp1
         3iK0km1k+fuFvEziNCIAypLGh06wv0U5ZWQNcX5JDYh59JWbO308uN7imWQFQVGSHd+x
         44pFqvmRqVtHIC9FrsfYyuY9rxeX9sy3eCb+MZJXkvKVWOJQkNndebv50v2DE1S2+3mt
         I5vQ==
X-Gm-Message-State: APuU4Z8eG7FYYVrFXZcdPcIIhdRvbcNh0MrgBl8h7X4pS7TrBXwCyiLm
	sCEUM2NpbTN7h1OPDcN060zGtvPN19z9LO0kbYWIg9myOKGcs9JUu0j4E0Ss7HrVL/mDsCK1df9
	FECzjBHF9OjxIOcSy65Y/fJDQygfYMp8=
X-Gm-Gg: AYBFou369gbU4nkM07Cl9tu7oFBDda9xGWbQAzkDd86teSenUjqcQOaR13eU+0MQuKq
	XjBXqMATh7mkLNSlYszip3NI4uJ7QRLeoqn7mOfTJf5dyjwQ4eEczYJFScc8K6+e/vs9dQtaGQF
	sd3fJlgMLrVGFEfRHdy5epmzfl1h61P2RpG51MtB2b5cRy4DfqcupIZ6QweNqE/kayfGFgZJbQI
	XDNDdziuP8GrEKfoqcbCVtikuqcbLW7CP5YEVk2/WaPxBkJg7a6lj1/jqyZVR1lv8tMAfTLw9w3
	TKyipKZrdhcA90ZnpajnnlBnBvuqyDcZf6gy4BL+I06X4miGBF7opm7AXcI37IssOFzq+7gtcWz
	i/lXCA4ClNjTx2X1d2nWR1wd0eHAZ5a1JhB8JkQ==
X-Received: by 2002:a05:690e:43c3:b0:677:ad90:7002 with SMTP id
 956f58d0204a3-67ba50f368emr5011804d50.96.1793622247871; Mon, 02 Nov 2026
 04:24:07 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101105859.25579-2-pushkarkumarsingh1970@gmail.com> <auhJ0B_1__9z3DEC@pks.im>
In-Reply-To: <auhJ0B_1__9z3DEC@pks.im>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Mon, 2 Nov 2026 17:53:53 +0530
X-Gm-Features: AclHuK9epM4C3Eu3uMW-O7M7Nj7A4vSuoNICBesvb32OBkppVVafPygQPyzCZRQ
Message-ID: <CALE2CrSNCpjLJcfqU6=qwQZbWwV4Vn5bgfEmp8piCy7CR3JxOA@mail.gmail.com>
Subject: Re: [PATCH] maintenance: trace when auto maintenance skips due to lock
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, mail@thomasbachem.com, 
	ttaylorr@openai.com
Content-Type: text/plain; charset="UTF-8"

[snip]
> So we now know to report failure when the lock exists already, but in
> any other case we don't log anything at all. But wouldn't the caller
> want to know when we failed because of for example EPERM, too, or
> because of any other error?
>
At first I only considered EEXIST, but you're right, we should be
reporting other lock acquisition failures too. I've included the actual
reason in the Trace2 event.

> >               if (!opts->auto_flag && !opts->quiet)
> >                       warning(_("lock file '%s' exists, skipping maintenance"),
> >                               lock_path);
>
> It's quite curious that we only print a warning when `git maintenance
> run` has failed to acquire the lock instead of bubbling up an error. I
> would have expected that we:
>
>   - Exit successfully but print a warning in the case where we are
>     executed with "--auto".
>
>   - Exit with an error code and print an error in the case where we
>     execute without "--auto".
>
Agreed. The current behavior for manual invocations is a bit odd,
especially since we end up returning success even though we couldn't
acquire the lock.

[snip]
> This is of course outside the scope of your patch series, but if you
> feel like it I think it could be easily fixed while at it in a second
> patch.
>
I was thinking of including this in the same patch series since both
changes are around the same lock acquisition path. I've included this
in the v2 as well, so manual invocations now report an error and return
a non-zero status, while --auto still exits successfully but prints
a warning.

Thanks for the review :-)

Pushkar
