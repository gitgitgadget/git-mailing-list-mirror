Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D114F1A6823
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783445991; cv=pass; b=ZzvMhBVHwrZB8XD8gFqHjKDO8JQwSS7a9HQNHyb59aRD5HkmbZktarCH+dJJ3wPpWfXDNGWz0uNOfsM6nN/c5SC4haYTUVCkegVQmPRSZ7EaSEkJN0wfq3AHnitSKbV0yhy8uDrFOCJAnPs60du0niKvnmTA0ATHNTZSEuktzuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783445991; c=relaxed/simple;
	bh=395LyEpBDyCxCh9vL1M9RFXapTeRjFa+NX63T0cSEto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtrqjUu5vdgqD0J5CMNlicc1eNMgpTnKp9iZxVxaMXF2Q5n6vEXmkTr7wt+Ix5rESsk7kdDOYpAZmkUWvXRAyWHEnCm3a6hZAnXtLst6A9c+6Q3MKFEhi52IYHZ1Ocq2Lj2l2Nuw2gUhIC1LkGVcJ2eF87EBJE/KDFJoR0OJ+X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=XDEiw6jo; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="XDEiw6jo"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-664cdeab266so6729101d50.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 10:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783445989; cv=none;
        d=google.com; s=arc-20260327;
        b=eq8KLwGKDuL6XRARRNKb6G1I9j9JXtwrzkiZMc41JSKhy+sHyc0tNFD0e/nBKCg8BC
         lN/q77Q35cyUI5Q0EMLbPTERqQ2b7/4Y6gOW/gXk2LIc1Dq33NtY/DWPfINy/THQLeYV
         BWmwODxT0P/TOYQ2sFMlvnqAMSzA3UQqzg+wocWOPw2kDYiqA48xfFPqvIxnxF74o+lE
         207Vxlbap6Gqu4y9aT4Dr1CMJVPO1rAAPCyuP8Dw1q9e5VKoQIcB+vEkbGUItpfFzSjm
         Mt9iNSdsY80r10iEt3ebm+8qPsjtreEudffYrZ0PDHUZQzociaKhpBnuG3DbrYmIutGa
         T5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=phOLliZDXxZfU5v/9qo/z7SRroHoQaeSDZ6urVaOdZY=;
        fh=9IpTVeom6A1E+c+4RQUbbx703BXb1xnLNNSRSHadErU=;
        b=Sv8ZHihglTQF4yzUthSCUMuzIVCSI4PmNfWwl84+dS/knallMAiyEbdjBUj+Wv/a7D
         qNh1Ox7mb4FXXx48KrKs7PFvVnHykbV+u5WLxuYSOJrcpRFzsZ1Wa+eePgHGccRa0qEg
         CYW9NEon+yx3Y3ulRJSMe0MB8DWDzQXWWD+M5jZXg7RGKp6ndEv4bQ+89e0SVdjusdJ7
         xjkQz7NG8mdGk/0Vll5D0XPRIXHslYSghhfD4GJPy4w5bDdRPcjrQSsc/urFmlXUFMkl
         70Y1KFkGRpgJEgG8xwCEzjiCZPFKHsYiInY/8P3ga4Hplqfp03G0d9fFmO89ocPxvLne
         4N1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783445989; x=1784050789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=phOLliZDXxZfU5v/9qo/z7SRroHoQaeSDZ6urVaOdZY=;
        b=XDEiw6joM1469f5v2t201erFFM6EwGW0U9nwsTzdArrW9bqewOwm2MD3Sa3DKr7TXL
         8JGB3vvt54q8D/IRDTwaHWlTKH6j4ZLCbqRtZhOj+mIBEz1s7o+OG2mYnges4Z/gKqUM
         cMJ/bXj1vt5wOW3PjssUozmuF8m1lxKivn3ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783445989; x=1784050789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phOLliZDXxZfU5v/9qo/z7SRroHoQaeSDZ6urVaOdZY=;
        b=GOgpTEyvfX1Nw8GBKuWdXLIkl1oVaqKwDFqa5N9weTsqE2PJ7gvV4FKA80V5ZRvbzg
         P1MURg2RBk5fQrvpeLva3Jt1y+FCBsRzCBYOxDl9lxpTe+mhtmc1YqLzb1OvE1YvwEB6
         z6VLqqm4KwDNJkHcqmwqqz31KlyrTA1lS1cPQK3IX4u9xrAkgvkPwxd3u4ccDeaoHUYn
         qVo/iAenTrYVSEbvBzvK5YhYhilspCRujujYj4RKSqC1X5fbVV21gnmO2Ku31KrfBj85
         aqKuJuPuJB4Re/XrxotXPDHHjZTPraZMnXKhZ0+pB04U2+ejdAap45rRnbDcI0m6E5dl
         6qKg==
X-Forwarded-Encrypted: i=1; AHgh+Rpn2ifGPxF00DywKvyX+6hvR6dNu5HA1aDF/B81AnkZ5oY1wn5i/gxwSbgCrWhlxHBSUiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjavcLmzjH4cVts9JMWV5KA1Kr3p3y0QER06rHyReQ3MqgurOq
	/0ObILKQ52tznv37Yi9lHyZbQiLgM6IVymFaaZZmBKs9uLXFNPb2XZg4aL5ZzEAGOm+JFzXmAnM
	/16/gZ2kmxOwFspG2+cZyR5E+Q5iVlvhjvULhNhmnQtLmcjQ8NK9cboC2dw==
X-Gm-Gg: AfdE7cmEzp8sCpZBQJH76XFY+m7DqDPQKxZ/6BV727RmdkEm9zJL7jdFMDnn6w1CSX9
	sk4TkP9AQO+JsjxtXEktqa/tiSL33ZIBW4o5JX9s+IPQSKZGh84MPdxRL934/hrATR8JRah1/Rk
	jCpbNebzTCmf8IQUy1vU0ctL3zhw3wHIDB+H9cKFzK/axFi3oQs7goE+g//GhwO3QJ63kwqYeEk
	gscNDcAGN7oJp4M4Xa8hGo7TmMHwboVmHgDjvpfeee5p5gHWGGJzdClgwhNp77nPXXmJ95/X1Hj
	ALUsmTrv
X-Received: by 2002:a53:e00b:0:b0:666:27de:9c1 with SMTP id
 956f58d0204a3-6677fd49367mr3749389d50.80.1783445988641; Tue, 07 Jul 2026
 10:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
 <b865c2bcff53a32637aac426dd2c6ef4a4c27077.1783418384.git.gitgitgadget@gmail.com>
 <xmqq1pde7n8h.fsf@gitster.g>
In-Reply-To: <xmqq1pde7n8h.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 7 Jul 2026 19:39:37 +0200
X-Gm-Features: AVVi8CePYYDfGUjpaXdtpsedMU-dyeW7Ys1gzvJ0YLLjgg1X_LsTtnzUtpOpJRs
Message-ID: <CAL71e4N82nxjXbLD2Lre58r6O8CBQaGx9ddtB4K5k8-6BFV7Yg@mail.gmail.com>
Subject: Re: [PATCH 1/2] commit-graph: add trace2 instrumentation for
 generation DFS
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jul 2026 at 18:56, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Add a step counter and trace2_data_intmax call to
> > compute_reachable_generation_numbers() to make the cost of
> > the generation number DFS observable.  This exposes a
> > regression introduced in 199d452758 (commit-graph: fix
> > "filling in" topological levels, 2025-04-07) where
>
> Where did "fix filling in" came from?  Are you blaming
>
>     199d452758 (commit-graph: return the prepared commit graph from
>     `prepare_commit_graph()`, 2025-09-04)
>
> or something else that happend in April that year?

Hm, I actually don't remember that exact text, it must have been
an oversight during editing back and forth and I missed it in
my local review -- the commit oid is correct though, that is
the one I was referring to. I will clean this up and shrink it down.

I did not mean April though, but September 4th. I was using
the ISO 8601 date format out of habit.

> OK.  I expect that [2/2] would update this exact test to demonstrate
> that with code updated in [2/2] the extra walk will no longer happen.

Yes, I first considered doing this as a single commit, but
I figured it would be easier to reason about the fix if the
problem was identified before-hand.

Thanks,
Kristofer
