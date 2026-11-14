Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794672667;
	b=lt+FZMh1433YOCBcLpwqn7HZfjva3R+4GSpD6bR53ctri299vvwNEjcu2xXCQ+M++z/K
	 5NOismejVQ7GzK3gvYeLDmayYfm/b3po9RCkFWyUyRCbX8o8UnjYqVy1I18rYgu64x60V
	 vZGyqrP+2/5Xd1YJwrLsF9wtVpwscxFueR8QP2HvB9LjltOrrOUw0NkcTdd2lmkWGwGlh
	 3mgQT6xfunj3xkjZs0p06MlmTgPNj3rYZzJY1a7DJ6RtF6ChzshWYWx9wJas89aIu0YOh
	 6JqvFGE9Y9YhkDcI71q4KIrfj+efNSMmuqMi1/sUNMtUCVmQAhnGnyLfspd9/sjeaBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672667;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=9VCgsa7js/Dncd9JGdHsguM5wSg77C7WbxZkLC6SAiQ=;
	b=aKpsS/Ru3k1R84cEDv+lo4tbnaOquqmsR7NMqxq1oTO4SFNSAGGJ+Qc9dTEKI+bpj+V9
	 qta0P0U7uNqaMQTh1YT9Vd1mHj6w06JBgT5oigpXkzaHr3xxrKdEcRpc7fWdlFy5QyJ9m
	 aG2JocALF4DlOxqq2cb1GStSVcqIuZDa1PKG6KCAhvnqJ3goG0ifX81l7fE4GIs20JLc0
	 5WTcp8MG8cBz6PXnvle12Yylou0+wR8ley207B/+Pv11WjRmbf3OHl7ia0BBirti8ZgSl
	 EMs5QiPt83b/Nho+ulVo4M2JHbJK0j7FvY9MXUHrVXwn7IEx6O2GofNH1g3pG3U8w4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UJo92fA5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B6E606A329
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 16:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82B6E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UJo92fA5
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b596569640so4345753a12.1
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 08:11:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794672666; cv=none;
        d=google.com; s=arc-20260327;
        b=gEwOKWXt2GydvQznzzSghJx74zXSmCPw8Ut24Ly8hisT3Mv151Rbs9kABbZQkj/AlU
         +t1QQjvXEMy6+XfXiKkU5Gld3yI32mh6DR9SfLmOQGPcabpOknRboQRdcRSiXb2nq+Ai
         NzTEdLx6WDMB3+sFpsQdhS8l3XQBuch9JV2+wUkpPIQy1+WTSk7JTNSxBe5JAGPpG4ZO
         TSqWVOe8snxGbI/ujf8lRo2khIqsAbUSUCdgJ8aJXJF2tCvTmNOKYD3elCIdrPCKVjtH
         KmtQwcEXaaTHspFG/KDaa3gucXQ0rP8262HquPqGVV3WRVlK49EmFi7RXZ3awtljLEge
         kBVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9VCgsa7js/Dncd9JGdHsguM5wSg77C7WbxZkLC6SAiQ=;
        fh=uFTzmL+JJuljKkzR20FK1ev6UacE6ozaP8Vc1DgVp54=;
        b=BObKmx9oahDBoQcHd/D60+bmTAUZI30tkfbegGKKMioj8uTr+5lNxAgZGrlJVFBCJw
         y4X2a9flemohGk3dn3V3NNkGgpVOlHtuigC8G+Dlld/y6YnEINM0htPODE6eQsxUWmWm
         8DYkIJQFeik0qc1Htq5ai1Bb9ZjD5HVmECUPAk+9F7ufkrY0KXiQj94XbiZrp6wf9lEE
         7T9M2HZSCeTvlyExGuon5UNkNml/8LaedKE7rb44P9AvdwO8R7EZ4YqAVO1Fj0V24cNV
         mY3gVbNWRsNQRU1wifsdGtgvbRTZSRtAayA252cCRr2WoqLTp4OZOu30Bwudnz7vggbu
         R93g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794672666; x=1795277466; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9VCgsa7js/Dncd9JGdHsguM5wSg77C7WbxZkLC6SAiQ=;
        b=UJo92fA5zNVmX0Xj0Ovl3VUre09S9+j+/LOCGkuvycOAPmMrKIXg30U5xUFefd96ka
         hjcvTMffX1ExS4vYOQS2wAsi5yVzy73gpuDQhyTCVX/M4+rxTkQ2ICjTFxNu4q7n7TTk
         OQct8zgMjDrLRCqwNZ8aY4Wr47QQGpQMt/1+beFcYGo+xJzpOhRSNymrUY6TlMkpFKHC
         B2yjVCaCuXeBlwtcl4PdfCEk5HJ28pUuRXo4STWOwjbLAJt/K6jOAMMdStpz0zPh1WlU
         k2mgbJ/YIYbdvxv7TnZlfg7U+NpYr9Er2uVIxWeI+u6lYFJW7f/kP4lMDmIdWTz3dfOa
         kuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794672666; x=1795277466;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9VCgsa7js/Dncd9JGdHsguM5wSg77C7WbxZkLC6SAiQ=;
        b=JPax23G47aS+BrP6WnwvIGDtTdGFR1swB1LgRB3d7p+E4uNP+ps04SICHHSobLXG7G
         waC2xeXWPQ0Oc3NFpsZqxZDTaOFMSPSfVD5FW5VeMQ/BsNIZpQMbcVZSOV1pTDe16lVY
         xB9I8DcfXpvjkrpWdELpmaQQOCO8hsv2XU6X+DnPzaw7jt5WT6L9A2VBVpJOPb3tlb7D
         JENC0v8yuHx6xhagsunyIIht8wZ72yNv02tOR8cJ99MFBmPWkr4O28lC0mkKhn30dKsQ
         ug/uOeS1GHEcCYlGfWvb6SYk0zOgsqyui7xrGiyXhJDO5vGpsSq2ihWqetGwFkaGpWbD
         qTDQ==
X-Forwarded-Encrypted: i=1; AL+hErEJCA3Sddlh8Wvv8ZcFIOB/c/A7k3ZTeEbqG+6XuhsLRnONSF3sfYD04Dl1ptZGlbyawko=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8M5jU5c4JeUUH9ahrn7cUor0KBo9mvuggJDt2an3vL+3dMp5P
	4O/IXcHL2ymfdZh2wtoREgNaDdprQg3+OsJVJqXskKZJkNH4SuhUHwRF3XSXeDMHuc9jwS58s2J
	h/7yW+u5hXHUReZRdQjq2QrlAeqNGxKQ=
X-Gm-Gg: AYBFou0mTaJnvZTgz13eMWDckPdNXPLEGhqa6l2PfffE6SBSYguGSF3o1rMhaUj6u5C
	x8wUcnSp+mPdOpONxNATYHUc0liIv2TSgVSFWwOcFziLBoVS1BMyl591rS2hKJ6xY33LwvQ0Nun
	EAatodZ9EZX2eM9jhIUhc5eu1cdxNFvmFNktFoXuL4+SC8/Lf1BUEXkbUJPYmClDnctVLLlozHL
	0POy4nU5ovlKcK/a0SiybvN3bQHjBxnpTH3DL3Pl4u/2t7/0yXTMzP/yo50EN6aR/1KIlKrb2Xn
	WMA/oz76jRLKsVQv+V1jsyrQ/UeGxy5fFbLHUcUT/Vb0zSzLXkEHY8qiFY7aXsiHi77ikmvPO8D
	ArNux789N5GYftQZVuVcxVRgkq9Mv0Wi/0kZ1
X-Received: by 2002:aa7:cc99:0:b0:6b3:d0a0:39c9 with SMTP id
 4fb4d7f45d1cf-6b7c0ba5102mr3544581a12.6.1794672665677; Sat, 14 Nov 2026
 08:11:05 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com> <25eec8d9676d4adf82570616ca88a2b38d20afa4.1793357550.git.gitgitgadget@gmail.com>
 <CALnO6CB+AP=osF8mjkGGHWZz8YX322UoSjE6DCfYZkZ0rXxVcg@mail.gmail.com>
In-Reply-To: <CALnO6CB+AP=osF8mjkGGHWZz8YX322UoSjE6DCfYZkZ0rXxVcg@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 14 Nov 2026 17:10:28 +0100
X-Gm-Features: AclHuK9d517HxEKz9os8g0b3YyI61oEvhu7Mwc54OsK_ULDIITOTB1y50A2eZ-o
Message-ID: <CAHwyqnWuQgBW=aDbGaCwm0mwCdDTQAZYBxJRZ18wwRC8Brbwrw@mail.gmail.com>
Subject: Re: [PATCH v13 6/6] remote: resolve @{push} through remote.<name>.fetchRefmap
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> Wouldn't the same problem happen if we applied the first 3 patches,
> then setup a repository's remote with a fetchRefmap and limited (or
> none) default fetch?  If so, that almost makes this seem like a bugfix
> for an earlier patch, and perhaps it belongs together? It also would
> then be better justified in those terms, I think.

That's an important point, and I will take a look at fixing this. Good
to have your keen eye here.


Harald
