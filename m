Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323D02EEE67
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791662792; cv=pass; b=rcbIAjFBqHH/suWhPKh2CS9BdlemTIYN71GjbQqelasZN5SP9S7HC7uFyxIVMoUijy+CPSvoXCh+bZCplSv8TuzCnl70azsQXhmeeU9HguNsfSnfspdQ9yRrZcLaf1kGms45fVdv4TWsNlAj94cQAC3twNykLPOt/wFeeZE5nwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791662792; c=relaxed/simple;
	bh=XfqJbo1JFog/fQCNQ0SDBO8TFINEQjISxxTDl9/cT50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOupekA47xviZBwOp2ldu6WTeXmOlli+qB89uyEvXTOisLyDT3U4hs5SO1gVhOOprvugl/jqSPVFI7FylFUHsUOO9Iw1R8Vz1wJgs7Igmj1fSJ+tHH6Prgh8aHtGTSgkFliD3Tjqd28ko7knzRAEc7FZPlUpdECNE/DviqJy5Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGDJil1a; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGDJil1a"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc758830601so486365a12.2
        for <git@vger.kernel.org>; Sat, 10 Oct 2026 13:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791662790; cv=none;
        d=google.com; s=arc-20260327;
        b=jQKjICD+p+F8D0albp6AjTTHKnf1ZczoRz8QSvNXqAeKLb3970f4TTNxIBYsWTx/NY
         Jg16NglELH0wkq5EpvevlPmrR02IjFgB6OdP3wcU2YuQL0y+RhDsPcjza6C+w/d/O/rU
         zTlfhJDoCIBc2q45FCuH0DUfDNPN+dGtwYlmCj/sxkekA8hX2CvO+gxp/0OP9DhoUZlu
         w17K9yPLNBPckLwM32u1oN/dB0Udji0vPWZJu8bEn4Qo9kC2wqk2rBnjmPlkGGVE6+iA
         1dA4BKjjrWCoQr0jokynnnUp1rreqiV3lLqnfcnLO43unJZoiyYw9bDyR0Zjah1Me2iR
         naVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wNtXwDYh8nt6ooAxnGr9R+tBSqA4ecYPv+C0djQzuFY=;
        fh=1wRPJuRcj69fVlcjMjeNqzjtAI4nfVwfLNlcA538DJE=;
        b=lI+RPxKZzfoAqW7LHbxTkFhnb7QNz3bHI6f6HPoUevyEIoMcNrTwlv4dQSqE43yx1f
         ZtDIha2r1B+R3CM4YFG+xHsc+qC/LfwTLXc6CHsxlWWBIVgzqvHKanh6kj32eZBopNMe
         MAdgKXFKcenVT8N9B578Kyydi24im6hKk40QsbZdPyaYWy4ThWvrsaIy9fhk+4zE6gKD
         Bx/eZ8gbfA3Qy9ivpRhSF+I37PLXWnBdVnEYzlFaAOvq/TRXRHVt9lfV9rKRnCcZr6Wl
         8D2nYBab/Sqz+fub0AQpqp2zx0nV5egvr5/ixahczKhQMQFKNRDrCwYxGDUuplTHJaDg
         jjgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791662790; x=1792267590; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wNtXwDYh8nt6ooAxnGr9R+tBSqA4ecYPv+C0djQzuFY=;
        b=aGDJil1aa8ZxgCa7MNSnAIWSzz1DNdLbYdIlNYqwSfYa75rry7RGMVCsyky6HAY1I2
         HUI+uyLWpJ8BWnV7GgDksG9qkxeriDyhmbrhFIks/VUOiH0ypFxve7y1nWM0yNBDagIb
         dCScIRu6XzdYNPBoJ7zTtpveq7bwLRAALnHQ97n/wL9fZkoHvwmJK7tt/AxjgDYxuwrs
         nGz48Dw0e4gUN+vY+/xt/niEO1C97VKpNSgak/hPln05p9V+9nFk4qdAkxvSsIKUbePm
         G90IPSd8PH9A7nWRpw+NwA53MFDTJp1DNhNoarQAlstfcsiIoP/+nOjeQhc9X63dJpHC
         ft2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791662790; x=1792267590;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wNtXwDYh8nt6ooAxnGr9R+tBSqA4ecYPv+C0djQzuFY=;
        b=DDK/XZcThuvgZgW0S0s3RxxtRiMcib82NhMFbpLpmLmyU2WytAR0kdwMSWh899FIma
         j7A5fA/2dwKAsc3EJ1vQOmURUxIxsrwJ5iz6CUqgG19AI/Xz3qq4QK61Jls1Sx0Ozb6S
         nLdgfGOweIMom//+3kqD4RVe2v5hzRz7e1Xv+jp/ljKdy4Kq1wqjyVACEjkCX0I052Cv
         Foqs7Bb0i63OKvSW1fo3zZjoxnAwkfmHHjfrOWIzin/r5pYT0Bo5gDg/bg0yT+bc1lvr
         YgDw/1PO/ukatbMBl61VkoHX/SX0KP2hh1QLhB461fAH+qBO0pID2bdPYiwpQtGIb8n+
         j65Q==
X-Gm-Message-State: AFq9FYI72CmOum5PgUO58b3YKdTId/evq5NKI3rKPSbCM0xC3NiVIWeb
	Zs6+BjeJSrQsyKGu1mhhbwE9KYbxWgGGIt7Vkax227g7VrRkXV9dOqXvGHc8/D8kNjTce217hOF
	r4fmMmX8Is8mx6Kc8ZV/81FsaTJJnwuk=
X-Gm-Gg: AYBFou3ryDidrwOKkfCtmFl3f1AZGuFGjCRZDIRhefHU90H3e74VU4plGn6KPKYEFK+
	o/i3wMxlWZdtg9Jw6ojegQ7SPM1+0W4eRBKm59b7qeN3OEwBYUkTJ6i5VL01TlnsJ99kCrbDuHj
	W7HkGC03LkFumY/UlHnwdSQZM7jwmQjSEDylLlpjhoZhObxWrHfnQv4Zise9YDenDxzDRk3fPg1
	hNRJvut4se4u1p2Rsgufu3t+/sC7/cztdFvLGNvNRwA4KIus7evyafhrFhjAjAH9fOQzIq8cq3y
	J0y84wb84W3mJ05j4nJ9b68SgSCEda0sXfgrR6TmMreHXJeGgU9eWmyL3mERSd+FJFFAZDX3pJf
	ldMyAwNycqu/zB6FQgj3cCGnpFCdvG7vDCKd4ocXi1KJlyatB6IMI2ZxHp8WQ4XtYI3l5WaxJr2
	N9E7fRADgQXg==
X-Received: by 2002:a05:6a21:329a:b0:3dd:a00a:170d with SMTP id
 adf61e73a8af0-3e16be79864mr4637391637.40.1791662790324; Sat, 10 Oct 2026
 13:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008062521.25505-1-r.siddharth.shrimali@gmail.com> <xmqqwlrs2rvc.fsf@gitster.g>
In-Reply-To: <xmqqwlrs2rvc.fsf@gitster.g>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Sun, 11 Oct 2026 01:35:54 +0530
X-Gm-Features: AclHuK9S-nkx3z1z3G84hRswCMGJpCTpoBcwpXf0e6Zyi_QQswUdcu1_PNLtmEs
Message-ID: <CAGWgyh-rwcHaZ4ymn1n1_RC+eCEomfAeJOT0GSUtU6oBmRbhcA@mail.gmail.com>
Subject: Re: [PATCH] repack: do not rebuild packs on --dry-run
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, coygeek@gmail.com, ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Junio,

On Thu, 8 Oct 2026 at 19:53, Junio C Hamano <gitster@pobox.com> wrote:
> Very interesting finding.  I am curious if this was the case from
> the beginning, or we broke --dry-run unknowingly as a side effect of
> some unrelated changes.  If it is not too much, can you bisect and
> document where we broke it in the log message?

unfortunately, this was a mistake on my end and it has been broken
since --dry-run was introduced in 1e746b00aa. the --dry-run
block never returned early, so it always went on to do a regular
repack, including the deletion when -d is given explicitly.

I will document this in the log message in v2

Thanks,
Siddharth
