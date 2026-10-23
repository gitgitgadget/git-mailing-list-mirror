Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792758934;
	b=mXJHSLpnhfYzyCVMxSzuX1yJnc6ba/+R0AD6zlZT1egc57Vo1QGMiS8SrrCCZd3z+Asc
	 vpgpzp7Z3oIfV0EdDKjk5jKJqpzKnhQ2BaM7nXskip16A1/dy94ZU0JY7dfqP9UzAvnPD
	 IyXwOMEaR+ffgnnKpGwtCwdsel3QhdqnWiVltrZps2J+m0aCjUJKY0Fp8WpnvA/zrSBMO
	 f8QZ5Ygcfqs017gyS0Ylou74e/pRSynCIOKidI9YsCih42Q3HwsAz9KougVJw263NkTeG
	 XYR8Vf4axEHLi7N134Fxi3Cq/RBa8Ltmt7blcufGfwCGecNAbfEI6+hTg1j0Gg/Ojxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=qel1QAHTjU4Fk2jylvAmD8eOvqGMGGJe1xpqRB9IBhI=;
	b=x4eZAjGZHPVHgMFtClwreEik6uHBpo1kf2EBTeLEO/VQRqpu2woVJHi6HO+sB2MehAPh
	 344FawnQrUmlwx3IXelMA19ySIJ/wlsd2XqzJs9x8W8V4IlPUj3F7sTnziqi68pDEW+1N
	 0Nro9Bs4ydW4Z31exoaNIzkxiyPKzZjqs8A9Fm7jTlID2YmRFKOj658aFNLT8JyH+V6pq
	 z/1fUtvlIJTGLTYvwk6kx+RviGH7EDFLOQvJoaPwFxfHNIxMIbdksmZfS4Y5XE+xqN/F+
	 0CNlauwdZ0ibjd1ct2vr7iEgkdTUjOtTFikwMUfNrQRIEZy9M8+xgdJ+kC75zogMELw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BXuhpp3f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B100606A31E
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B100606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BXuhpp3f
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b1a86c0316so1229270a12.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 05:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792758932; cv=none;
        d=google.com; s=arc-20260327;
        b=M7tOraPPHbd5Wkh43NTvbqpwzoa44PPv3aQRGYVcFDPaC3cbhtuV5ZD/4CZRSSi1K+
         2ITD62UDMLB6gNGGAMcr/zFs5FjtzPK2xMRT6gFnazYm7G7a9NxXRkXcHCWCMJ62nPMk
         /fYJ124eugMM+x4Ezl12PqWGF7B4RoGmJTQsEXUDTKq0gKXlC2rp27WA8gsSkZQNN1w1
         LHE4gkTshR47YY9Ymq5cc6F3F3Zj7nIojpyX1wGoJo72QVn/k8IMduOPpD5uUZ6D812a
         yhSNFcpPD8+MMdaDLPGrmIFsPs+KNne5Me4W3Fi/8Qnc6ERgTxdRRTZj5eg4aXz2XsI1
         qQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=qel1QAHTjU4Fk2jylvAmD8eOvqGMGGJe1xpqRB9IBhI=;
        fh=EScYGoA5ve64/IUy1nagOSXunVqPNNMbTKWZUijkHFA=;
        b=NrZi/s3rbYnL+JLN7m6LbugxY5FQhPjl1auOPh9VrUtYh5HwyUtv5FKo7DNn8jduP9
         rm/qy6c00Ly2OrIy6rPjbl+L2J3dOM+0RKZWVlg3htjIFziAro8AwsaUnyUqfK3uw8DI
         ilB2nxa6zFCveWDXM/sLA5A7dLs9K3+2t8veqR2pAtQXwf6zsPrlFVLQip6rbc9yoB8g
         PObPYRxmkyP9aSNtLn3/YczvpX0gPJf7J0D3lOQrObCu+U4K7Xy+XMzVtJTDZQgZYCFm
         SnqILmA2xeekoVqNaHW2ZbmhnBf07Wl4yzykk2uIHiBMiW06StXoVqitT6MsBMGLdlT8
         psgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792758932; x=1793363732; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qel1QAHTjU4Fk2jylvAmD8eOvqGMGGJe1xpqRB9IBhI=;
        b=BXuhpp3fL7Fg4mrM0XViR1UtWn7LRBaah+t4gnHT6Qs0RtCDm1aYfGiKHkIfZdN8J+
         dRMh65sLweaXuPdWxnRtF9Bwkkn357DOvavr4lmQ8/zu/qF2lbmVoe6L+vgl2QyaWgim
         aqiP9zHCH40JE/Gb0M//C3HUI8Wq5RwXbV15pHRDO3eUxaSC+E6bvhzizGsy2vloyzme
         NyfHXZlKT02bsylme+lgDq3cm2JxdV1kx8Bd2bFIoTINTJ3Yd7bqT2z3pc5sgEBn3iik
         h/XFuT5Q5ZumV+4Hm52xUXoCBUUc0+Tn8nhMG2VZRp61neJWZXlMk2TJ8Z0HRvHyRAmA
         hGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792758932; x=1793363732;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qel1QAHTjU4Fk2jylvAmD8eOvqGMGGJe1xpqRB9IBhI=;
        b=kE35ZwYSp/7Glam/BsRbgVaU+GPQvkMjLzwthr8eWIF3r4yL1tnaKIeVBI2EnzwBap
         tf2626/etdli7dw+DkkkfW5sPez4+oT2peGa449YrjgFaRg5yPDO/dQpSGWD1MzuQEMR
         jXBJxi27KbHzBm7Nzuy3lqmiVkRzEfELFvmH9Tf+QJYDN2KHSSnn5Oi/kvIZwIGBi8uk
         C5/9x6zsO1ek2+GSRz6PHycYw69921Ctsb2wRmhj18COmrEGckdCHoVASDOM97yoZuth
         hKpoaOnCrWeoDKWknK7cAH1UCBCt5FtBoZFb3XSkRDvkzyEeHWXuX+t5QtL0dMDqYr6r
         NNuw==
X-Gm-Message-State: AFq9FYLfyAUUPf9CkoLIKWS1vYe6YriY80YePGT7JPL+3ApZncRXNqS6
	nzYOOyHfC6+YpD7NEhpvXZTzm4clP3A9BLx50gUUmFCxCkSf+XAhBci4Fvz6PgU6FyB6yPbZO0v
	89SgW4+w9NHv9P6mlWC29q2k9M63bIeyTTZs4pISyW3Kg
X-Gm-Gg: AYBFou0zkaAK/p5qbKrUMv+p3NMElWpm68NtMC5H4cZGUu9C6FaxxfRZ4mtEEKgCsub
	+d0iTQuHQMOj9bDDE+PgHHtR7KMpRA3Ugqtz+0GKCYSmAu50ACPK8z0ubgUoTXEmeDQH9vNGXL7
	AlLE/OqBT04nJumbDwPcWffEaCluv6NCXZ/j+FD3xBlRxTK+G3ofXWBCainMG7BtSPC7Ry4zs42
	2eJJGzOgn4ZD3qwmvWZNY4Ly/wsN10sXoIQqZnMY/8UgByWxTlO2ewURQrx8HdX9jwEFRJG6SiX
	ZonLqj7BjSExpX1tALcYH0KNxviUu/wSXC6nJfv4SlVYC8LlGOJh2s5rJlRIxBo+2KMpXQtJjhK
	zj4yHkGtV3rqHfKIE6X5UQT2notZwiF5i2TEghL9g1bMcinAgE/mgILTyqQGbxkFlE0zVAlZwHr
	PJ3+bSoQ==
X-Received: by 2002:aa7:d949:0:b0:6b3:d0a0:39e5 with SMTP id
 4fb4d7f45d1cf-6b432bce163mr2537612a12.9.1792758932153; Fri, 23 Oct 2026
 05:35:32 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Joie Joie <soniqjjj@gmail.com>
Date: Fri, 23 Oct 2026 13:34:42 +0100
X-Gm-Features: AclHuK9vWzNp5kzTNItYd5Pq0DxPNjiTUgPE9rxtKLaOeHDkt7wx0a6Xoy5HRdg
Message-ID: <CAH=d44fpMy8eWFd3nPabcddY3iajhmXxYnrEZMFDQyyO0WtWZw@mail.gmail.com>
Subject: [Outreachy] Introduction and MyFirstContribution - Joy Gundu
To: git@vger.kernel.org, christian.couder@gmail.com, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

My name is Joy Gundu (she/her/his), and I am excited to introduce
myself as an Outreachy applicant for the Git project.

I have gone through the Outreachy eligibility requirements and I
confirm that I meet all required criteria.

As part of getting started with the community and the project
codebase, I have taken the following steps:
- Cloned the Git repository.
- Successfully built Git from source with the DEVELOPER=1 flag enabled
using GitHub Codespaces.
- I have completed the MyFirstContribution tutorial as part of my
onboarding. For this practice exercise, I implemented a custom toy
builtin command called git psuh in C.

Find here a summary of what I worked on:
1. Added the core command implementation in builtin/psuh.c and wired
it into builtin.h, git.c, and command-list.txt.
2. Updated the Makefile and .gitignore to support building and
cleaning the new command.
3. Wrote automated shell tests in t/t9999-psuh.sh.
4. Created AsciiDoc documentation in Documentation/git-psuh.adoc.
5. Formatted, signed, and verified a clean patch file.

I am very excited to be here and look forward to contributing more to
the Git project.

Best regards,
Joy Gundu
