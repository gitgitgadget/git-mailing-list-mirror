Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D08345CCA
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788545859; cv=pass; b=a9U0ydRBhdW8etA/k8d+J3+jvyI2JVxQhAYxKKltCPY+8LZI8mU7mWy6YYLI4Kc8wRCY2xm9/JgPvHrhiM10VLyGi4ORhOeO6TV/V5ZG2fKl+/f4al5ogQZUm2U3OJGqbIoACdfJfMaVE4Xc2acJy79cyvnmr21KrvlFK3ZJyUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788545859; c=relaxed/simple;
	bh=6e0mSmgzGrTezWkI/3sEO82lWD4fc7MRZf3AN6IuRp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMhLFjvbjEGZY+88JB74IR/C7JdM6IEXZzUfYVGlS8rcCQJi2aNV3qS+5Fca6KStOOSrQngHphPr2a7OawQChiXdEjG09UZQ+5lWLDXw5/6q540NQadGfkGXz/DVtybSaXyl/rz4uFjiP8R+Vq/oyny9v7SEKHvNHeWNQ8VcOZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=gE2SKQkc; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="gE2SKQkc"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso494397137.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 11:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788545855; cv=none;
        d=google.com; s=arc-20260327;
        b=k/zkAvdlLJNfFiB2YiTYbM2Lj7y3DHAybBWI9XtU4y/6nWuKos9dlSYeLKMSeUSxqq
         wudxuNSXyetHM3P0+aUAPoVuObqiDfEdexCfB7krNX0oEFGwwTgBk6AJENn9gWjZVKH8
         2TmtMHicQNLfdthB4B6kzyAYWcBVgrXLgZpsLf8lpQCXTrvag3NHolo2yri9fz982nE3
         RTWci2n8AF/FTJmCxKXrgl88PhlISaXS+gpuHUmB2Cbl+zSTX69FsBZaFu5NHkepUS9V
         qIT5y7KsQmbnAr860sruu5iNuL++e6BOf+5lZKd+mIEjIxeZBvqsgtidkJON85x6yzYD
         nK8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RNHxQQ02GO9dKaPVqS/2QoC/zVzxyWXZrFhbmUn1igA=;
        fh=TlgRRHOSBLxFT1ys4Acco+YugsaT19gqp03dq68ZgZA=;
        b=nWu+aPuxCmjUfE/b/ZYxG7znRdOJFS45aZOz6QFU7MRdIq35s8GK2qF3UDpxktX+DM
         bktdg21+G5q9+6ddSO6BmY4Ii0PrO4YvgkySeOnRtapJxyi0hPEKR5t/S0DMQWJhRxHk
         25KtqaxHqGXPNdlS7HgsWOOusuy7oQ9jKfWempCEEaN5JvVrjdVI66px9VdRRKJpk0vm
         4FNv3jJW4hJ0Xie7nJd1KP075aWN9QX246DrxAWXkWlIBy+CmrQbr79vKSAp+L5U/EUR
         VhtezGJ1VMzTLUhFnmz/wy0lWx1N+P7nZ48D5v86sfmGscrOuy8x99PxdR5QWeMIpxK1
         Boiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1788545855; x=1789150655; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RNHxQQ02GO9dKaPVqS/2QoC/zVzxyWXZrFhbmUn1igA=;
        b=gE2SKQkcAycHSbdakJQ2JNHGxQ7qrJrNNcfFhm1qlkgvtETMD3vZCWgS8w6oLZEpO4
         ZLWagMc8bCGfG0V+xJRRLPA/0yCV7uIU51rFPPmnZ2DU68NcKmNbYEXVhWEusTYYbO3Q
         deIsRjQKkeS+qKTlvrzte9lvpX0iaUrdCc6z98hY1FexroZIBRwug/3zdHri4twyWGc1
         dX2/Os+LELfyIXBRtwfRWPKb2gSewJVV8uxs0N+IuKIBp/zGMv/k6Ag9ELUDXvPcLnlF
         h4iUhH1X1Iud3NgaETiuA/gQsS4LlDo3oat7bugkNXTBWdWsgfFotPaKvpLjLZ1pmaJU
         km2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788545855; x=1789150655;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RNHxQQ02GO9dKaPVqS/2QoC/zVzxyWXZrFhbmUn1igA=;
        b=NicuhZ6eb7JioPBJOIDHBjzsqtxoMlvx+vt9OnIKxuIkwaHMA+Piyju0Rszb1nKVyy
         aI6WEzugjI2bJwn7ZduIUtk/c25cgdBiqYyqOFaEmBxmVJRgKpP+bIsH2pTXjS3fIoOj
         y0OuyPLu3OGv4wGtxbG6E9mJiUdLPxkwgc8Wk1aTaDvBp/fJIKCzpRvYUnIGR4KEanJQ
         uhTV+nAI0Q0p0gL9ae+MhFKLvus5qySBEIzM+Z+KRRmt1s5Jw5vo62pj2SoowalOD8N2
         FjMY2TW0mFwWsRw65cDaDLMRaf2gebUk+974pQZtxj8v3MuyoaMvGtr/KImyNjTCiSgX
         cpNg==
X-Forwarded-Encrypted: i=1; AKwUvBz1mXVr8cP6PXpjOQ0igBdI1fMsvNEastyFL4xJpPZLHFW/lhKMuR/O6spIrie3i147xOQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l/b86AjCL1Se2QncY7QK5vhvEKLh13WhAFOCBCemUAuFWIdjX4
	w33pHaYXruY674UYitCWfnQK+sOET/exDOzacLG5dQObSq4EK/pQTklzqxIw6RW9SdTZzoav8dF
	VlCui0zL+Gxo4/HxZX9SB77B2l4YmS1Wp8Pbzl4S0MimRm/ikE0Ws4Pp8rxrdTlA=
X-Gm-Gg: AYBFou1ywDgNK9Ja4YWTXcjIm1shmiZKdwAEZDN/TR0PQRaO40HtbaGr3jSDfu54G44
	9+pl5sVti+KnsWbmwCH1BKodqXAJ2VTe3IX1IEDR0PBhltJ3Acpv32Of7aEOOXkyoN7lO8CYhNf
	jSWALgUDUn84ysFJuzLkafQXlLXkK1Rf4e+ShDvzFAb2WPHEkonN3vZ0Sxs8jBd/8uAev/4VqOl
	AVsMfKFbtFfuHqO8s2Fq/jWrLSW3I2oYDIf2Q72g8lO5nC0e7dnx7RslIpGTwxNbN17jMeISNil
	gUS7ZX4f6clyfy+4t6zSGsUaxEZw+lugqYO2s+7hIYC59ZYZgNq7NL35SkpQdXs3TfCHHXCCOPK
	eoNqBzTr+/C39LQ==
X-Received: by 2002:a05:6102:554b:b0:784:4156:80e3 with SMTP id
 ada2fe7eead31-78a4a8951camr2466073137.7.1788545855133; Fri, 04 Sep 2026
 11:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <pull.2214.v2.git.1788507876543.gitgitgadget@gmail.com> <5e613735-60e2-429d-a5bb-1a4f03578604@gmail.com>
 <xmqqfqzp3q10.fsf@gitster.g>
In-Reply-To: <xmqqfqzp3q10.fsf@gitster.g>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Fri, 4 Sep 2026 20:17:24 +0200
X-Gm-Features: AcwNN1W8Uh3fNQvEjxP31CTC9eDo8QIxuoJcw3JCXke5YgVi48VLMAIH5nda2b4
Message-ID: <CAA0xjtr4sDyrkf8VJz3CUBGVvc7LdGhOb1K9kgdskhD+_hbSwQ@mail.gmail.com>
Subject: Re: [PATCH v2] rerere: keep a background gc from killing a rebase
To: gitster@pobox.com
Cc: phillip.wood123@gmail.com, git@vger.kernel.org, ps@pks.im, 
	phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

Hi Junio,

On 04/09/2026 19:06, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> Overall, this commit message is rather long and it would be helpful if
>> you could distill it to remove unnecessary and unrelated details.
>
> Hear hear.

The v3 log message is down to 23 lines from 81:

  <pull.2214.v3.git.1788537081930.gitgitgadget@gmail.com>

> When there is somebody holding the lock, they acquired the lock
> exactly because they did not want to see others (including
> ourselves) to touch the rerere database until they are done.

That caught one more case I got wrong in v3. The rerere_clear() that
--abort and --skip run also waits and then goes on, and that leaves
MERGE_RR behind. The next rerere run then takes each path in it as
resolved by the user and records whatever the reset left there. The
clear is the first thing --abort and --skip do, so I'll let it fail
like "git rerere clear" does, from every caller. That also drops the
flag from rerere_clear() and rerere_forget() again and leaves am.c
and rebase.c untouched.

> What makes `git rerere gc` different among all is not that it does
> not retry.  It just does not insist doing a GC and instead leaves
> without doing anything (and without failing).

Right, and I'll say it that way in the config text. All of them wait
for the lock except the gc, which loses nothing by giving up at once.
When the time is up, "git rerere", "git rerere forget" and "git
rerere clear" fail, and a merge or commit that would record or reuse
a resolution on the way warns and goes on without it.

>> A background job that the user did not explicitly start printing to the
>> terminal is rather confusing as it is likely to get mixed in with the
>> output of whatever is running in the foreground.
>
> Very good point.

I don't think it can happen, though. The detached run has no
terminal: daemonize() reopens the standard descriptors on /dev/null
before the gc runs. Where it doesn't detach, on Windows or with
autoDetach off, the command that started it waits for it, so it
isn't in the background either. The warning a user sees comes from
the command in the foreground, once it has given up waiting.

I'll wait for the rest of the v3 comments before rerolling.

Thanks,
Thomas
