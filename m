Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87E437B00E
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681879; cv=pass; b=SboIn1hCoa44p4elLt4nex5UTvmnJp3m1J0uS4Z2bLCrORSuQ8EntdIwITpH0ahIwGeZ+TdjB2LxlhcU6NMCfD9x3GI3oMsdhjtWbHD4DvK4IhTfugRcVB6f54HbQU4LsgWa5Mi9sBO+pT06KutbBJXycjPB34WCc3RSCdl0rnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681879; c=relaxed/simple;
	bh=F17OD3WfZWgttl6EMj4Ewa2f1ZirpsfWZVuwav8Z5bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTOWMS3wfF0DikVKMCGuxT8lrt8h7asGT/1KvhWRJg5jz35W+niM4BFuKj6YtaOItjp13zVleYUD77c7Vb9D+1zTtwUBUFAY4PKs38orS1bIbd93Z2iQoqrjzcqGZYMGdluxvZ2TydcxsUAe2uGZ5Zkl4qkeYJ5igiCxiov37xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0kSW5Ve; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0kSW5Ve"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68b90fc6a1dso4017252a12.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 10:51:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780681875; cv=none;
        d=google.com; s=arc-20240605;
        b=VhJ9LH6wcZl9jVSUewDrWgcIXQwVc50zvR0DhY1OjEhuhD9keLm6IVfGQmO8enczQ6
         kpvmOKQPVO2zGsUj0F7JtbYztgX/vJSnzjNCMac81Vvm98yaJyc1dPT7RMpAoR9i6tvy
         Y5NWK9j31Ds9EbFUQV8m3qNvIhOEt7cYm1RiVny4d9Xl7JaYYpI6Q6XC67t20E3rG8qN
         MpUNHXLm+I/o60XLAn/il2/oqaBSDvduSHqYdSe90QaR+USDQD4W+54l5jutlmyohZMz
         3ar3Sgr2pd6Alj6nGhHljNbOWFcqxEeLpv+I39QlNPqQgTo9fh7brcSmJzWWhfcmj5Bl
         cKFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=F17OD3WfZWgttl6EMj4Ewa2f1ZirpsfWZVuwav8Z5bY=;
        fh=CGJkoTbX4bMFeWf/xqzMBL8S0jlQtCU60oR9DBGDQHo=;
        b=cFV3uNg2PbIxHH4abN5Bncg0R+Ix+J/4ANnwRjMWf34yhFC0U1IJx5dvSTNuScZdlT
         oTXi4ekZQ0Pv5ZwGwpC1J9RX6iSTzNM+RY4Z9VblBbRotXtUh/7p7O/XMZDWMvad+4wS
         6l0O4+nCvZm1f6KPslgb5hsPhC7qXuz6t9JR+hrkMbkaNE3pCSx4AB/f255j7GYigtxR
         djc1NElgQRs/135S6SGHowxtnEXQPGxyfCvYEpRnu91dctqAYkXhmOkftUFQcyf9Xqoa
         PgRMFQ4H3uVJsfRPPBM5o2Sj6L8UkZ8lJWKNGDoGuOsYgrhgyv0F7/XRDYaKlrxXUM9K
         CYgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780681875; x=1781286675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F17OD3WfZWgttl6EMj4Ewa2f1ZirpsfWZVuwav8Z5bY=;
        b=j0kSW5VerSxg6ZjsEPqMpbhj/LRqeua43fT3MB1vOWBPm5ltzUVDZztmS8hLEyzV5p
         sk/wHxJa2hVr2avgFE4S6guUIPjH0dfKwELi84T49L7gcuEGofuboIMT5L5SeZjSu9td
         kwplKrbbb1up6Qahhd3CaAGxXZmcWc+k2O0Ripeusl7H8INWGXjryNNf2j8a0RY3S4o6
         mHBNyWTaV5uGlIVc451IWCEMc+HkP/b5k0vX9Qvj5KQnIShZsaOvIqwKKuLXEdikjJ1o
         WldANIHffoIlFsRDscn2LL97iFUARmk952YqSgEV0na27oVu89OhAQbAvzQJBYpGQ7hg
         hmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780681875; x=1781286675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F17OD3WfZWgttl6EMj4Ewa2f1ZirpsfWZVuwav8Z5bY=;
        b=Bab73609foDYRp6aRY1jpbvvAYJi5g0YnYLf7v1N+6jTCgRptm/JYY3Sqt1OV4kNOm
         vW7umQCIjeIWuubV4KBR9BGYrMwAAzBe30OReItkcO18c4T7fEH9tdASd6xrTYAtcV0V
         pR+CLe/CCmcunAKVpOPYVHn1ynaZKbCy/dTUSOOekpmpr9gVp5GIG9F6+My+MPTA/d9n
         0UUX9ZYRypMi2nbwOBpsDMgvZhInC1LazayVTK0GUMcAGLHH/82N6q+idBBuS6bnKwN5
         7EcXfJGVSOXlomx2kE6MwTFNCSiPjrmabhqVJmb9Jq0YEdaWg2GV7SZzDd8nnEPgmHUh
         4VyA==
X-Forwarded-Encrypted: i=1; AFNElJ+RFn8BDliqy77VL48smqHYGMOlxSc1q0nqHijkdRvRpLfhSDzfW3RvuPwWtCGZfr4wGxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv9RuLCdepAPQmbzI3C/rhx0zqhOIah5VIWIH+WU/oB3fBD8uB
	g2kgfna2Jn6cl13RZ+ZqWE7YNmtqtEm+mc5D3JQfX0AqJG0ia6n8WqNkomCxzNJtP4JZJniG5gl
	lzmr+asA05fCAPlQfsO1LKP+zd3QjYHI=
X-Gm-Gg: Acq92OEZFQz1SAVnG3abQrcvhbWIBHxqurK5H/dbQwH01scUjwHGAe96gC0zaipVaOc
	UY0dS8G31AZoO5m1KT3NQN2TOF6vwCPVN8HErps0n+pQ25SUNJiOX+4FVEkaE+1sxC611nIl/Lj
	xOXja1Q2r6NqAT30LDL4D4b17eA0FO8GpbAnaMuzJc/xxelhuulUvawJPhdioo+G7ziBVJjPc6w
	fL5Aq2h8UDJAt2DPa0Hx8skCwfVwfvAwz7llFfnhQJHCMRmBPMSFI2BjnjRk2yfxxzkcEnLI24h
	sik/1VwxfeLxDjp4OA==
X-Received: by 2002:a05:6402:3901:b0:683:9a51:306b with SMTP id
 4fb4d7f45d1cf-68ff1f6b02emr1897189a12.9.1780681874888; Fri, 05 Jun 2026
 10:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
 <pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com> <8834c424fbd27800636fe21ae73e9cdce75b558a.1780477479.git.gitgitgadget@gmail.com>
 <9f5c36a9-a3b8-403d-9c59-40367eb895bd@gmail.com>
In-Reply-To: <9f5c36a9-a3b8-403d-9c59-40367eb895bd@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 5 Jun 2026 19:50:38 +0200
X-Gm-Features: AVVi8Cc5rTGIiWqf76yUnfPLJpY2TBWAoALLP3CY_LxyV0KSRUqsRhWyVfsp07Q
Message-ID: <CAHwyqnXqPxaSnzqn0=t8ErWW-Nh_cVHAG6KYRROz-M55t16YSw@mail.gmail.com>
Subject: Re: [PATCH v12 1/6] branch: add --forked filter for --list mode
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

Hi Phillip!

Great points all around, I will take a look at implementing them. I'll
respond here instead of for each specific message, and then include
comments as part of the next version.

> > Add a --forked option to "git branch" list mode that keeps only
> > branches whose configured upstream matches <branch>. The argument
> > can be a ref (e.g. "origin/main", "master") or a shell-style
> > glob (e.g. "origin/*"). The option can be repeated to widen the
> > filter.
>
> Do we want to support a remote name as an alias for $remote/HEAD to
> match "git checkout -b $remote"?

I have been going back and forth on this, and while I like the bare
remote, it made the implementation a lot easier after it was removed,
as the arguments from some of the others made sense to me.


Harald
