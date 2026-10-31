Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793467748;
	b=SmAz6kFe8eB6v1B9t1RmuF6NkonUK6QEFVr7aegUdXGp9GYekl/YOaW+0YkK2iXJn8qc
	 wqS9YGuRDRuktdpjWgVENTy48R+yLH6ho4XSqSafpjp8OkTRia3MP/5tVuBqLhsEBgxGK
	 hcn2Gniwd30IPntvNnchkOOSyGqsP6p7juV4ygXVgkfrJOU3SNRZDxyLsTRYlE2PfInwr
	 gKDK8sx34EAfnOc+H2lYQNkcth6f8BwQauHukHKoW4P4dqmKMoRXmAkOfVTyFv+2b1pZe
	 +I8u/Cn6swJBMFCJVD693meBuEY5UNaR8HrxRzlk3+k0fOWX0Q2hLvS1E+IpW3cZ2+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793467748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cLxTBawN83QcwH3Yp5VdgahTWGw4zS443iSmc3mVatk=;
	b=r++pCRrT/AS2mzUDTXhEz8okOxEJM6LYJYSCsf2G1wSaS6fCgHwSlh57Fh3LdU5vu4xY
	 H+2A+rhyw7S+0Wou1Lg25Gkb7QbGWZbgQbOASXPY9P6S14FwfHQA2fCyE+J8Q185mlmDd
	 KDdpDG0PEERrSxslSBvfT8ohzXVJOVTdrBFsiGIeqNHtEjNKb9YrLoZxdYz5FUTFJb0sy
	 CCkBLx6Dtw6Im/RcuNacuGPAareV2h4Wf+KJCD9ED31mtvU0mqDE2txXWbFO7B9qWu7tb
	 D2PoCd0d/3yVs437uhWVF0uqhaPpnkOK+c2TIzv2SvFsjCQaEnMbdlsxylvygqCuQuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hj7kZJsI;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8821606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 17:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8821606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hj7kZJsI
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15943c9c005so1263513c88.1
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 10:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793467747; x=1794072547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cLxTBawN83QcwH3Yp5VdgahTWGw4zS443iSmc3mVatk=;
        b=hj7kZJsI4hQIwJGDT6M5oWC+w9G6HOAMjPopIkkeGYjwEBTt5XfR3CBUhNbFEKfe1e
         boQZym5eTEWEgeI5QA3yWEFkWgcAJ4nyQsoZuVOt5rEpvg/MJ3fl4xv7/WN6ozB/cRT7
         VbEm4R5yUAyj+uOB56T8+OZpXHzBl0V8+gQLgXmOSLW+VqAf6amIqZ9l8jbSeU+WmHaC
         MjSmScu9kgCwrmNGLjhDP4e3xxFu5JZj3DtmkGVY9aKYkkF9MZsC3obIrKTcgtcrMwdU
         GydPUG0FcTABigkJvdNd7s0JR49R8wiAuUfDSs1pGZ5lWwE+kKpdVMK/ylVpCshjoiuq
         zZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793467747; x=1794072547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cLxTBawN83QcwH3Yp5VdgahTWGw4zS443iSmc3mVatk=;
        b=ae+j42SaM1ZdBoqVMe6Vgd9cIaqw2eg7PPAwIs+XO6ySRPIwWJQAL+PnxQlIlyCFZo
         /3yfie2zl9J7/qaJi7Qy9+Hmbuz5yH+c7gmdzuCLKT1umKncjZijNCORC3ju3j3fCKFi
         GuQ1AK8n/hyArkXnQYUa42GLXR19DtZAz+hEXsGWIoLsR+4h/TUJpu+kcerAXMpPXve5
         Bk6G9DqZV0jrQBJyu1AbFSnvSBN734LcrfDWJwmjKR79IWuPnbH1O2vNfO4iLeIx0GY+
         eTpPpystOGjBS5yVIO2uhw0HRkcamzWdyfc6Hbbf6m+nSZuzMhoZngtkHLFxBK5BvoO6
         sgZA==
X-Gm-Message-State: AFq9FYILZFw9by2DYEWWbi6wrFP4IbVN2/HY7PX2JJaH4m0rHmSC1J6C
	lV497l/w/mYVux6h6w7KgBhk79+2YI0v+TpMNWT2dnhk/mSQP5xv39nE
X-Gm-Gg: AYBFou1IuC4Uf7eW2hUBvrPX/yCJZtu/J2t7dKhITdZR5yUa/nZRhw5STYNX6gVvitV
	6HzRAuzIRCLhzryzjbV//pM7mf93XnC8y/DZtlYE212VI8tRITDxvCzLlqgjpBppxJYkokfVvba
	jIQT0ae+CmnKxmSzhMwyD8M9MG+GAsebTegHV7QP11SgE8NmBojyN2rbfP3MtaSFROcuqOREh1X
	T9m246OOk6PA7DwfaOY0jbPlWtuIfeWDiHI15OmJcT1FR2TY0j0aWbRWlDLzLd62hyZkAb3vdZP
	sljuzBpZzBssLkre4uJrsqyaFLWYWJ8aYxryJk7zyvkDr4Ifwp5M3e5Q6YmGW5gUlp8+SUQ52p4
	IrQLDGzUq6kBX15QHsKxiQkKh4chdwyd0DMN2+iyGA0kRfIU/PFpNvx5WJlDBp4lzlqLnDeKf9j
	NYmfES+UVR7oWPdoRgaO7yGD0o9lItq49DoTePoA5rjxTeGIpGJCrwqeyK/fMWjPiQToKtA2p3d
	Tb35C/NgREPOEp7IaDjHNdySuDuQDJ2TyAqhAsEMNvgABtHKM/aLgX/bE0W1dsNtW8BrDKdzOC5
	IuFilAR3V0IDJlHpBt1hP5zVmk2IZfvE+9emeK8MAdt+2bWLLaL9aQ==
X-Received: by 2002:a05:7022:e27:b0:14d:cb67:afc4 with SMTP id a92af1059eb24-1ac5e8e1e4bmr10937289c88.41.1793467746842;
        Sat, 31 Oct 2026 10:29:06 -0700 (PDT)
Received: from localhost.localdomain ([117.206.63.98])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b38ac58sm16845594c88.23.2026.10.31.10.29.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Oct 2026 10:29:06 -0700 (PDT)
From: Nakul V S <vsnakul@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	phillip.wood123@gmail.com,
	ps@pks.im,
	gitgitgadget@gmail.com,
	vsnakul@gmail.com
Subject: Re: [PATCH] sequencer: refuse to revert shallow boundary commits by default
Date: Sat, 31 Oct 2026 22:59:00 +0530
Message-ID: <20261031172900.69612-1-vsnakul@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <xmqqqzhina26.fsf@gitster.g>
References: <xmqqqzhina26.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Junio,

Thanks for the review, and for the question.

> The next natural question is where the modification should go if we
> want to make sure we protect these shallow boundaries not just from
> revert but also from "cherry-pick", "rebase", and possibly "commit
> --amend".  Is sequencer.c:do_pick_commit() the right place to cover
> all of them?

No, it isn't. When I wrote v1 I was only thinking about "revert",
since that is what the original thread was about. do_pick_commit() is
where every pick and revert ends up, so it looked like the easiest
place for a single check. I honestly didn't think about cherry-pick or
rebase at that point, or about how late that is for the user.

v2 moves it. The check now happens where each command builds its list
of commits, and they all share one helper. "rebase --apply" doesn't go
through the sequencer, so it gets a small check of its own before HEAD
is touched.

I've left "git commit --amend" alone for now. It is a different code
path, so I'd rather do it as a separate patch than make this one
bigger. Let me know if you'd prefer it in the same series.

v2 is here:
https://lore.kernel.org/git/pull.2273.v2.git.1793455522168.gitgitgadget@gmail.com

Thanks,
Nakul
