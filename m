Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E8A3DF01A
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 18:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774896602; cv=pass; b=XE4pm+Fm+ir2ecNNc/UjTKgZq0TeaPQmYxpbcWXbLHDlnrsblFRhGM2KFkE3fe8jNGMbkQZNMZgBfdlndr+iVU+r09AeAS+kua5E5yJPE7oLVpofsFdBK73fx3ubQ7KQIPNEeh87qj87W85FBgLQpBw4Bvigrd5t324kfrUAIvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774896602; c=relaxed/simple;
	bh=+Votq5dfpEgdqJ9maviY1xLYbzd9cK4h8ZgfqBcCD5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVNsaBywo4A37yIaaQAweN86tVT9iXhcnEfi8CNlEDeYx8f3bLjswB1rvoPvQ6Z/C3iNhW7KZ92cQBG27NW99AL7HWgvCED9s5H/33fR+mRbvSwwzaMSGwX5981X9DSZe+bA/XVfo6dI7PHjpDnRMRcf8xMzii8le0DH32EwNPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r16WAWdL; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r16WAWdL"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65003f40a22so5317372d50.2
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 11:50:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774896600; cv=none;
        d=google.com; s=arc-20240605;
        b=Jlm6MI7FuvghZfS6uHQ5cgvH/zmOrZTHvF+qnxDDkAN0V9F5aLEwfV1p711u5r6aCG
         /AKmQJ3WohJ2H+lvMhh8zouCP+g1Le2wX3gY4YgMYSlqbCVOMkiFAsGqKqHkaQrHHObI
         6VMlYzcs2UGUvFOOEbbmAJ8DBoG+Ks1cNzb+KgZcd9rBHMQm0ALYccWS8qBzCV4sO7uf
         o0ANIsqsxW4WSvUDtqa/J8luH9lZNywjy0ll5oPdEsryz7kmrERTinkH3HzqGTKjvmvU
         0es/0EzRd7awtKQDN6bx4e9+fYBpj5vK2tpEbra9GoRiKJ9m0NsiRvBm1YHe6Gj1W4qG
         dY+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=am1fShQHqbG4vITTGAf4dyWWqWB+HKZHhAd08wexNW0=;
        fh=k+mOvMd5I/O06uugmR9q98vGBPIE69oJ8LyYXAknNR0=;
        b=ihP+ypuFejM58Ie8i5t32h4JNrXIWqy+EkJCbSdCfZGD1qk2Typvjj82PNP4IPUYUh
         DEcT/CoBGUqvZGW6SY023ed+ItU9KaG13JvM2nL+gkjyXv9X4eU5vILtwU/n5IWOfUgR
         tbE6o++ZzYRuSa3TnOyZOZ5XuJM0xHaOe+ToZiObwtcilSY4sX7jRP++Vn13PVX6J3lx
         t0abULRLPcAc0wWgTh9GolSN969hDYv19eCbjBBdI8xco8vVV0v4Wb+PUYKKYXm/xuUP
         Vcn9ZnZlan3Q1aTHS+r9FDdhA2n9J8x+fbMrQyylruVooapeFnVyK434Yr9q/aVSM4d8
         l/HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774896600; x=1775501400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=am1fShQHqbG4vITTGAf4dyWWqWB+HKZHhAd08wexNW0=;
        b=r16WAWdLfhUZLFeFu2F1dEaS6ygvUqCqhDyQoRIxyNE3ubN2LLNKme0X5upTwEP13G
         DqikRSyBX/1aQZOqvJfWDIZO63oB1Wka0tC50zLpsgsiRCl25Ahd2NS6vKjKgKxhM9bC
         UerKJWcx3bXifAMiFzQ9AE5vKt3mTmKSQLsCVE5qDU2eP6/w7PUMkSwH0y9w1iUIRMkI
         qLCpjUp8cnAYQUFXAEbhG741q18q5UEY3RAksM2T3ddJoyiSO7mgbETmGQN/qr5XgYZ0
         cXHww7cOPifHcKh8xB10ekgjwNcsa5Zx6nKwfxJDo+JIU3NhpscPkUv1eLtL4qvvp7cs
         UMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774896600; x=1775501400;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=am1fShQHqbG4vITTGAf4dyWWqWB+HKZHhAd08wexNW0=;
        b=kJ3gJebbqUKH7BZJ3Sbi7V+Mbeiqx/W4Ayg/smE0nKPNjYI3e8L5A1XlhyBodeUIDK
         lM95ly6eojHpv4tdRl4RxfE303wZ9dZgErn8nHXJLxqT+60+iYVKGfaIlhLCwT7wet1D
         MfZbEOeTtnh3bBPrRAkSRSBrh7OHH694m8M3uFq7DLPO+pYTT7N1uZQWzYVAJojp0fnr
         JX8NUL78bwTCgYb4+OVBfXRI1g6Bs+0ZrZjnwmeFKbBjMHmcKkDRWemjX5biyTpvxR6v
         bqy0rhIFXBBCNEim4rhq4j9L/6VzpWHQfxtfH+IuC4ZE/BtBtWW4LQczCbdVMT0xaW1X
         /xsA==
X-Gm-Message-State: AOJu0Yw5iboivJ9P/VXMMhRyqRUCfh0ywqGGpG89hpwDIs3sncanG4fS
	ek9Dm5AjBPpLHB5IUa3kX2HAc05q1/2AgsQCEnc/++icTCC3RiZcIXTBjGX0eHSWnfrT2cMXlLE
	Ntxri09VZxKoXiBvSmVc0xGET9ZLvqGA=
X-Gm-Gg: ATEYQzwhDTQb2+uD/TomZNkx+FiHDyEMxOH0E4v46xSSOyR9nbDD+5nPY4eRDJKqh0H
	X/hDgFQLibuHTd2rXuH4Im8XORpYFkOXXVmxHg7BmX8A1lMscYk8gcK4V5aw9nJ4tF+6MmpEg1U
	xqqCE0Ej2PCSqiW5sexSbw2+ddaSQymPQywMmWI4F7SRy7VY0N8h7cqDXRnflsD5IUUm1IBlShw
	jH8n2v/IgSmmRrq8o9WuaU60nI0ysT9KbMdxl1OBDLM6A7vlTqBYhYpGkg079Bd9e3PRh1lgP0r
	er7sb1HUEv9yCLRctT3IHJcYng8dgSzOmVK8R9atEAooJk1PvRDYqlRSyrKQ0gLNSWt3I4BmDRf
	PK4ib5N/uEM+qePX6HQw+N2g=
X-Received: by 2002:a05:690c:90:b0:79a:4ba5:f32e with SMTP id
 00721157ae682-79bde09e2f8mr128307357b3.31.1774896600377; Mon, 30 Mar 2026
 11:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223141236.22476-1-me@runxiyu.org> <20260330111822.165188-1-pabloosabaterr@gmail.com>
 <xmqqy0j9e3t9.fsf@gitster.g>
In-Reply-To: <xmqqy0j9e3t9.fsf@gitster.g>
From: Pablo <pabloosabaterr@gmail.com>
Date: Mon, 30 Mar 2026 20:49:45 +0200
X-Gm-Features: AQROBzAPfktbW_BEtKaXy1R8hqmt9-EOcfCG1DRrwy-cpNAgKtyEn08bTCJsUuk
Message-ID: <CAN5EUNRYpzbT58jAaheBVNG_jxVFJy5a=r_v7gREPyspQ8zTyw@mail.gmail.com>
Subject: Re: [GSoC PATCH 0/3] receive-pack: fix HEAD check for updateInstead
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, me@runxiyu.org, christian.couder@gmail.com, 
	karthik.188@gmail.com, jltobler@gmail.com, ayu.chandekar@gmail.com, 
	siddharthasthana31@gmail.com, chandrapratap3519@gmail.com
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano (<gitster@pobox.com>) writes:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> > When a bare repo has linked worktrees, and its HEAD points to an unborn branch,
> > pushing to a wt branch with updateInstead fails and rejects the push, even if
> > the wt is clean.
> >
> > This happens because HEAD is checked only for the bare repo context, instead
> > of the wt.
> >
> > This series includes Runxi's test, a cleanup of a test that messes with Runxi's
> > test and the fix for the issue.
>
> It would have made a perfect cover letter if you said in a very
> early paragraph what Runxi is and how it related to this issue.  I
> am guessing (from the fact that the same word appears in the patch
> list below with family name) that is a name of a person who first
> reported the issue?  If so, the missing sentence would have said
> something like "At https/lore.kernel.org/git/$MessageId, Runxi Yu
> reported ...".
>

I thought that by sending the series in-reply to the original Runxi's
report it wouldn't be needed. But yeah, it isn't clear if someone would
only read the cover letter.

this is Runxi's original report which is the parent of this thread:

  https://lore.kernel.org/git/20260223141236.22476-1-me@runxiyu.org/

Thanks for the feedback :)

> I have to leave the keyboard now, so will take a look at the patches
> later today.  Thanks.
>
>
> > Pablo Sabater (2):
> >   t5516: clean up cloned and new-wt in denyCurrentBranch and worktrees
> >     test
> >   receive-pack: use worktree HEAD for updateInstead
> >
> > Runxi Yu (1):
> >   t5516: test updateInstead with worktree and unborn bare HEAD
> >
> >  builtin/receive-pack.c | 39 +++++++++++++++------------------------
> >  t/t5516-fetch-push.sh  | 15 +++++++++++++++
> >  2 files changed, 30 insertions(+), 24 deletions(-)
> >
> >
> > base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
