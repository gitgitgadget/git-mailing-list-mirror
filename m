Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794261967;
	b=Kkd5rtB5lsfLiOsxyBvMQiWW4AfrRmq8sAEq6JYW8+KdyzGIo1vO+ONccD6SdjJtkki6
	 M56lo6wzpzzFdk2DcLJn2LQp4P1/k58tD2iYAtOYDDAi79oWEcVGlrgYaMUJkfdiAJMPY
	 UG19wEQYt2z04A0X39BX6QdDiuDI/eJfG6251AZGVfWAAEExNoLlx8NwEC7vh9/pY8s2r
	 OK32EQeJMC1l+EYCBO5qj+pk0AdRJ6Nw4AWJ/iKq3y6VgVxsbS2phhEtBVf0Lo9OqJaaG
	 Tb3U4ohAOU8SJEorA4+OzEg5FnGmTvioQqePfUQZLmw4nlOT3Ne4S7qSdA1BQWxy3Ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794261967;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=cLUfy1qjULh6RHeY+ub6un/gpMIDZ8MKr2x/PJYEQzc=;
	b=C/CVODgo8VWpb74tnsqNE/6d20elkwbjoUMJy4V+1lT1fhtU4G9uSfHFxzY33Eb+lmPj
	 dgK99+p7A4+8uNjRyL56dVQvvcofGHMTFPvU3+B3tGwVNkbV9KxXbTJwoKUj76dr4xyWQ
	 B8Ibs/oqwgsUDYGXWvwerZd968NWc9j/ZPAeIxbb4dz7X66Lvi1BmwAj/wz/MSgEh8JZD
	 umfnD8NrkiwDRajcnblaahPWsE26uEdb4E03SToupJsNh9jHGgNi4yZsLVuU7QUun7T5G
	 Aeo4AADnRpoBJspkc97qqIIPEDZDqjuhmsBdDy5N2LBH/NLdIi5lrJ/eK59r6jRIw9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pwrdrvr.com;
	spf=pass smtp.mailfrom=pwrdrvr.com;
	dkim=pass header.d=pwrdrvr.com header.i=@pwrdrvr.com header.a=rsa-sha256 header.s=google header.b=DqU5SptA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A27C606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 22:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A27C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pwrdrvr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwrdrvr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pwrdrvr.com header.i=@pwrdrvr.com header.a=rsa-sha256 header.s=google header.b=DqU5SptA
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-843b6f8e2c7so1577229a34.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 14:06:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794261966; cv=none;
        d=google.com; s=arc-20260327;
        b=NJYUX1vm0PWJje2ik/9tNcXNiiS16xIT1/iWKInDxix6UgWXK4aawbNHUH8/HIfHoC
         jkqK8f2vPIYCGsYrx4ZfE7ECZfZb3dV8o/uy3Usokr3hr2WcBDMD2rMRP2AXssIrr6UQ
         pQYs/uXoKALalpFCjYR+ZT+CPX06CsEmTZsYwzc9ydF/P9cpTSsMnYh0Gv0562paEp4R
         yEQJwUr4+fuRK9ps8vfm3zHUIix0OFaj1Y231kW08//TyhMUeHISxzDvMdDpvDU6I5mT
         6xZvECI1cGd2Yw52/rKnCYu2NE5BjO4roP3g9nhvupqMKBN5IEDFcKaWHhgzeuQ0g/Me
         kaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=cLUfy1qjULh6RHeY+ub6un/gpMIDZ8MKr2x/PJYEQzc=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=NWwlSmV6SmTUVqhIYKt44tbhhLzcSoASuFxiTasSxXJ2qIfPY6qeO/q5KatdghU0JK
         PBrMDLOxh8GFYxm6VEsMT5qwqn3XCEer5wxXWK3B+rd8Dr7+K8z/ld761FNmG533Qs4e
         uuGRhvQX6rQF7C/1hqd22RBAIDFSicQbMCt+AVyUuq1wrYLHgbRabGcMfn21aFRTrnOS
         xfdUSEe31CF4D/KY9wf/BqGH3spPiq/IUbpJR7Yb3NF14hEIUlRZYKMCBjrsHidEpz/A
         SdgCDrN6MlrAoSuioQjGVzIGlhFpiEG009ztNl3mDqZHTwYFje7HLLuts7SABGlQE8i2
         5qdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pwrdrvr.com; s=google; t=1794261966; x=1794866766; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cLUfy1qjULh6RHeY+ub6un/gpMIDZ8MKr2x/PJYEQzc=;
        b=DqU5SptAwdxSSmmOOWBQuvIk8I5vk9S6XUYdwIjD+Bka5G7+IA3fuSaEgDmEAxDrfG
         6TsBtsmf32jtEpuCjm/eOVT08pUiSDW5va7yq+lNaRC4xRyuVbie3mX7T4JQkfFCFXrm
         kFFmpeVNvPzgmkagLdZI1Nj+I/46ujmr8T1ApHBAUGLDr2vjg4prXz1R0CeIp2+uZDnS
         l3AHN4h7BVmG388KB7RUHGsK73FkF/pFzApLUCC0G5zuRmsEbJRVu8UUrqkymdSzcBwN
         7HRMRFaqoO6OatRyxHDTG5ILLUjEVk1nQ4RGZipjxY1vZnJfWU7HT7ZYThs5Gthi2Kn6
         h5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794261966; x=1794866766;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cLUfy1qjULh6RHeY+ub6un/gpMIDZ8MKr2x/PJYEQzc=;
        b=Y0jy4Cf4TTsq8y4OBO7FgbxGLlB9L/zp8H8EzutT7IyfROFF4hN4vYoEI2CQEk1fKB
         xzJd/aAZI+y36/9THgshv5BezEfDzghZjzybdrAnQyZWf0Xt+XW4RjQYgJIrP6h1xCq+
         HgeCASbT487Ne5eWmxhhDBVC1RyQ/DaqmbxP7MnzRGigHmk2vqy703rvh4ggdhUVQmWN
         WBr2FS3bsHKaFGYTCvffo6ZCrcNCI8feo2s6MelvdeHlKfIGE/zM/mwv/Pc8GxTz9lIq
         flv0Hsq9IalLlLikuYqK61Prq+JD4PjZfihL8twEHyzr/41VYQgRpL1wle8S9mulHmHF
         dpww==
X-Gm-Message-State: APuU4Z+407/weF9F4+oedLbHqBNypxBwHiTtLcJLBbrPquX8WmAaXfWg
	mk7uESHeii/ar2c/WtbLHMI4xAELodmFf/N+7ItU1Z6+d9mPBUXgKCHUju9n31mOCgLjUA90Imn
	bZgocTpmb+5exAS5yFjfV01YXD/1huhaLKF0OM8PUHqQV/7cn9Mcda3wwiA==
X-Gm-Gg: AYBFou2PC16nyfIw3dioS1/BLRkPIpiSrJNKl8/6Haju/A/rrslbY9ZtNywThmdsKxq
	Fw8XRLQjvzQRSCz8zF9gtrPh+9HCy/DoWtEBrGLxuSP24uS9+R56wbrBgPckHc/aKR1Phz1Hu64
	U3SCvAsI6GHsNLasUGC03yHhZ1tFCKaFL0Cyb8kuxnrSZC6ALrMNCLzffQsLjBGbz/bvAr2b82G
	aIp823/DSsOf0AOsHgpt26tUPs7JWN78HwAfF1YgnswekDXyPQo+NHUfEfhUs/ouc8xWfV/P0sk
	vOKUyi3IJ44vKrzvL+x1hgW+ONeYtKV87Er7d5lfBGzBx98AC+wo3poIGwfVG028Dya0DMHMp8Q
	ztYqQSazBnv6srgVr267TiHzY8DyCvB94FXk=
X-Received: by 2002:a05:6808:c3ea:b0:567:cd59:7dd5 with SMTP id
 5614622812f47-568402c0fcdmr784300b6e.68.1794261965953; Mon, 09 Nov 2026
 14:06:05 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Harold Hunt <harold@pwrdrvr.com>
Date: Mon, 9 Nov 2026 17:05:55 -0500
X-Gm-Features: AclHuK-wp7m8NOw-D2dsUaOWRVd-05_qLAhWBwqK-7kCQhBRiqL6IvEz0qCLbYI
Message-ID: <CA+-E0BVhYRsktwaUDxtobAXV98dymKg2n4ghod292imymE5C_A@mail.gmail.com>
Subject: APFS, mmap, and git diff reporting no changes when there are changes?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi All - I used to maintain Cygwin/X (the X Server for Cygwin on
Windows) 20 years ago... it's been a while since I've used a mailing
list.

I'm working on my own implementation of copy on write cloning for git
on a couple Linux fs options and APFS on Mac.  While working on this I
created tests around mmap'd files and how to handle sharing them when
creating worktrees with clones.

I discovered that mmap'd files on Mac can cause existing git to
misreport no changes on various commands, while tools that read the
bytes of the files will see the changed bytes.  I could not find any
discussion of this being an intentional tradeoff of speed over
correctness for git on APFS.  I don't believe this is a security
problem.  However, any tool that mmaps a file, changes it, does not
call msync(), and holds that mmap open will cause this misreport to
continue until munmap() is called, at which point the ctime of the
file changes (mtime does not change on this path).

One could argue that not calling msync() (which updates both ctime and
mtime) is bad form and that git not reporting the changes in this case
is an acceptable tradeoff for performance reasons.  However, on Linux,
git correctly detects the changes via the mmap even without calling
msync().

One could also argue that this is Apple's bug or deficiency.  But that
could take months / years to resolve?

I'm writing to ask a few questions before either extracting and
submitting just the tests or carefully vetting the fixes and preparing
my own PRs:
1. Is this already known or is this nothing?
2. How far do we want to go for correctness?
3. Does anyone else have experience with this on APFS and have some advice?

I have an initial LLM-written PR for this on my fork (I am NOT asking
for review on this... if you want to look, look, but if you don't want
to: please don't): https://github.com/huntharo/git/pull/14

The impact outside of APFS file systems is zero.  The trade off on
APFS depends on how many files are mmap'd and how large they are. If
no files are ever mmap'd by any tools, ever, then the cost can be
zero.  The technique I'm using looks at generation number being 0 as
the indication that we have to examine the file contents as the
generation number drops to 0 while mapped.

There is a related follow-on problem: changing a file via mmap/munmap
(or any other mechanism that updates ctime but not mtime) in the same
second as the last commit will cause git to continue to report no
changes even with the file unmapped.

Thanks for any input you can provide here.  If these aren't really
considered to be a problem then I'll leave them unsolved in my CoW
clone patches when I'm ready to submit.

Harold
