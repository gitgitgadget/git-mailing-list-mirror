Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823C1248867
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785007436; cv=pass; b=EggQxboe7dAdmd7SLVXdBLd9lpxqvKpnEhcKeU9qr4NR5RqCwgLGVQueSpD6iQl1AKuiAhLaYtjStRwHKxqHhJPdlyUSX+6rGwyDE6Orzp7OwZ0hUkHesoRQO2Ij2kydJvMVN5QnFL8Ph8MVpUYQ0aVykoAlVTKXA+PFzmEI0as=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785007436; c=relaxed/simple;
	bh=a9mpoZybFAZKk0aRnUaNjNnh9NI1/LZ5MgBnhFWRrs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8tdYFzXAzA3fhOXcW7/GgaKp5nPJNPKeImwbYo7+MGnUl90hbGoVZAm7XFU9U+MTDCW/HuBPXRU3niv/C4WSj48A1bKn+67JgEipD51QuAAyLofWr28BPUu7QZUsfM1uhQPyRC9ITcxOq3NlRRpbprDkVOSWdjXyDY2gHNXD7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sGmPm4Do; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGmPm4Do"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84867f07d63so1827081b3a.2
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 12:23:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785007435; cv=none;
        d=google.com; s=arc-20260327;
        b=M3s/J9rU4wxmRUm3pU98yXZ3GzA4DNipqhVNmtN3hXjt3gNQi2ZBPRivxt95F31Gry
         mk06kvYzHO183YcBI0Pfz0gvduk0I0Nm4pzhNLUUQGAy7pltjb1zD6cOzPqQWdElh8Gs
         0/4marbkKl+QeyW/VG1J9+Hhq/rZi5KWeFf5TpsZbthZPyOTICkahYsBkLhvVRjoeVts
         Zz/Ax+J/Gow75ATpRqlkcXFNa2eIyTV1t+Vb6xscAuJGVgFFbyLc6sLw3NaJAlAAij/k
         KfJmJZEZESybTrGh5MF7ziYdeli0oxoDZ0FphUZeRHGURqqw+n9GTKePPLkAEc1e6LpL
         bYag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=a9mpoZybFAZKk0aRnUaNjNnh9NI1/LZ5MgBnhFWRrs4=;
        fh=rxXce4A1BYmBKDcyAP6CTTeBLAKxymZR1D9vVH84xcg=;
        b=jwLo11Q5zZYq/7xV6HUoiZV3qOquTEYaSPRIRYxD0mAJIL5pSldrI2oVFm1/8oY1IQ
         prNFxOs40BNfPF/0GBPfHDP37TEK4aXOd5SiDpG662ngUUMKJXk3F7a2Y4ID2PtDd6aB
         hfuOL9qoUnFQQiCruQbvEpq3aOy/dztg6piIFmzW68cobmsgp+1t/4OXNxQWn/msJgNT
         P6AkINtlnOQFn5M2KZkKGw4eK4IkLqQI1N6ut7Yk/grxCj+P0TX+vwZjH/ZIXbs9R+pO
         BmAjZsoj2mBZViCzJjQrdnpC/ndt221jy2PlkiFQGT9lsGujPuDP0+3KoAv8JNADkWqn
         jbnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785007435; x=1785612235; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a9mpoZybFAZKk0aRnUaNjNnh9NI1/LZ5MgBnhFWRrs4=;
        b=sGmPm4DoBYnEDSfGxpMqjMS+rpp2u2izXLNUpxA+b/WZNLw5oBCqXK2Q7Sq9cwO7EW
         ZAss+YoxvLAolI6FL3nVCN6vcvt60jAI3L2Kw6o3mXFz0xvxlwHndu0glkfQWAT9ONuW
         qxwbHVBA6jVOquN+BFcZ5CnIa06jwTYzW3jYVlXf9dETQ/IkFw5MU3Mh4e0dIMfBVvdF
         DHtmSbk2+y/naRaCiOirVQPMamUg6ZUlaUybH50lj3m4zItm7kAps9oEHg8C1cpI3R2D
         vd9fbfQixSd8XWq/B6DPRJVYl5QzpgWIMqX38hvcPjFUPvm/ZfSjQg2ChW+F0njRM6ve
         /CAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785007435; x=1785612235;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a9mpoZybFAZKk0aRnUaNjNnh9NI1/LZ5MgBnhFWRrs4=;
        b=ROWAb1FhN39ZZn3fPWPL+PxuwiGHktsIVVv91qRmVKF7dusg6aitk0X5hoW28y4Ran
         h8RTTRUYdWbjloEK+lkM5VvaxQB8blvC/cVkCLwNITOXdbnmajnKfkOswfn1rQY/ZmPg
         6kjJw6Lt29R75zhUjPRvZcUT+H3IaXzPkQ91LVHPorIc3cFS8WvRQuI7WtRd34PdDG0a
         cqqNz6uAIKCZdOkGYnVBBYFuCRtp6Q8Pz0LDBhmYRqViqn9hj/xsL5iqTL5H0DeOiE6P
         h9zXAxXicwGEgCdpR8I6Xn0wF1dqXmrZLaiJECdwgYW9GjkMLeBL0ioWreR87AnbQXw+
         PsvQ==
X-Gm-Message-State: AOJu0YyX3L7Z0ah9aGMb3E0DDCIrAo4lMsp4U0pMUVa/CrZm0H0tYztM
	P2U86EYx0pP5sRTAetjba9j9ODovnz0c6SnqDvLKkn2dYeTqEt9qU5bNP51qU0qp+HTIszaxOz7
	n6zfMR7le4tLU8yD6H6HD5BdTMU/4pUA=
X-Gm-Gg: AR+sD12OZXSnDM09Te55vXELFsukXHUlnoTe5YrtemNqkp4Lnzc4B7SXNS3R9VT4VKN
	fTahTufiFo6RbNZn2koLI7dB/tCcVrzxwaZ+tKIsURjK6VLh6/aLSnkkcB+eMGvyiR9eGlySJSV
	lQoSp7rhB2OAsW1XQMFGFh9pieLlYRPnbY0UCu69rXMtNm7R51aq6Xd7VnU5CbPv8YoEIakjpGY
	F5CrYoiCZofUUhrl9QXQMeKXzphac4DZ2fyURgCyHvj6UzNflIO0tgtpzXhXn7l0KXsD1dGNryl
	QaMrtBStSQFIdZKy37quW7vszo4+7SrQLxWP83wso9Os4iwoIRICDKozIT49+3xeUYGi6UqaPOG
	FDmiGEViBkvSQK4GB
X-Received: by 2002:a05:6a00:2989:b0:84e:456d:ab2d with SMTP id
 d2e1a72fcca58-84e59544f23mr2486164b3a.45.1785007434649; Sat, 25 Jul 2026
 12:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com> <f9c26c07-1dde-4bb6-a919-37d5229642f5@gmail.com>
In-Reply-To: <f9c26c07-1dde-4bb6-a919-37d5229642f5@gmail.com>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Sun, 26 Jul 2026 00:53:17 +0530
X-Gm-Features: AUfX_mxFRGRvRkcpEa63RRM8hnJ2O0AMbGLpFePev8ReiLRTZHs1OkdiFdWJpWw
Message-ID: <CAGWgyh_3xnVXLvBwGPTQfhBK3FzXuC50Xoy6xBN_+KQafDi-4w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] repack: add --drop-filtered to reclaim space in
 partial clones
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com, 
	me@ttaylorr.com, ps@pks.im, johannes.schindelin@gmx.de, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"

Hi Siddharth,

On Fri, 24 Jul 2026 at 00:56, Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:
> I think these matter before we present this as a real space-reclaim
> tool. Without the index guard especially, users may drop blobs and then
> immediately fetch them back on the next command that needs the worktree.

right, I will move the safety guards into v2; refuse to run
mid-merge/rebase/cherry-pick,
and refuse to drop blobs referenced by the current index

>
> The drop log and remote-object-info can wait. I would not block the
> next RFC round on them.

sounds good, I can pull the drop log out of the core series and keep
remote-object-info as a follow-up that upgrades the remote attribution
once it is available.


> On the UI, I am fine with a separate --dry-run for now (same as
> Christian). We can revisit a --drop-filtered=<mode> form later if we
> grow more drop-specific options.

i will keep the separate --dry-run for v2 and add a note to the commit message
explaining the choice, so the --drop-filtered=<mode> option stays open for later
without committing to it now.
