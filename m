Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869F31799F
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781969607; cv=pass; b=Wg6UjSLnHdS1HoNdRfWIdX5gnYr/tAZGXvS566crMxF8zEvf/Sr9b+npJxRfkwxEONRZ7euAaldmVm1iD3Bm58ZccgOwKr9n9Nc0rcpgAEoMupmrratSR9yxYXKLW8uscg+Wt4cmT0YZNxYqvILM22yENAcVWUy0KK0/JxQQLLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781969607; c=relaxed/simple;
	bh=n84FmOYEfWWHQRhjFv/7tzu0vv7bcH0odA6JPzxMHOg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UK23t6sgje4iuoFruijCwj3gSfEIZRT3O8/6wHSd7KVgL/N4XGC+Idcw4z7LMI7GPGkaE1Gs3NwyMyPv8AwKZlnwdEgdD5DM510GVmyaVZFPfSTE3Jp45dcGbGa+3qclyO4XoceWVyAme5LYCNVA+wQ6XsoZC0M9jPzBAsDJ0J0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrAlew8q; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrAlew8q"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-48b991960f2so109853b6e.1
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 08:33:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781969605; cv=none;
        d=google.com; s=arc-20240605;
        b=Dfyj9W+cqpHP7NGb1CkOGCcIiLqqZXigTT/1hzDK41IfgVk8Jlm743JXzL8qztrFP2
         r+OM2oxx/1LR1W8K2W3TlqtpjaeOX/5uUY81ULPqopSsUfYUFR3eN5s/klPpkggT9i3c
         IAk/SDrQ7iGQEfhGDEk+Y9SaH8F4hXESWfp06IKoQVoiInwWsup2mST1BNwofVHNmdlt
         EdnMzUZKDRflfEZFDz6o+XUKDiFTsPP2djp58GA+OsFoYxXg/EpWitJxJmL1uJw+LqbC
         7fHzvGqaSuXpvPkA0jJtH+K6AI1/EV7dq6PHXlqISUFSFT7a6TOsGpSmXAVZ1AIlq05Q
         9gZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xSWmX1bhHmzkxm6/L8LLp8cnwG9wP4sAWPJ97aXv3z8=;
        fh=4ryOG4wBbIqKixWzeKd5dc717SQGdNJth+KYU2DAukY=;
        b=PXPyDLkQ/6cakP/B6fAlIUV3NLadocLv67VLZHGpVZbOTh7KhFH/YC3fGwmquXPhzF
         u60QL00yuzzlNZNtU2ZiEd6Zp+DGR5/kdHPoUu0+y2uEnPZLoVkv9y6mI+vluSEHpZ9Y
         iUi6OwbfATbK4ds8xrQnLElx9sgmIDF0R+/lfMWfEgXi6/FxIbeF692NK3jqsW/MDnHf
         zQSjIG1htfgUAja1MwhedHqUGKfE5FJFisVv7kJ5NzIEMrB+x+R9RqXiap6y/oOomoql
         QwsRJvh89fchM28KvYCSfvNlDdtd887uJcyGVWGOfLnpmdNWZyW1Lmfr2Fo902NJElzd
         aZvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781969605; x=1782574405; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xSWmX1bhHmzkxm6/L8LLp8cnwG9wP4sAWPJ97aXv3z8=;
        b=QrAlew8q9/izty5By40x0BzMv96gcO4lD9e+0Mclu9H3nbJZ2jKl0fvK24kbXrJobV
         nBcbRBcV81Lwl76LIUMOlnpbMaNRldZ4dIY7naGJPx6tIdxABP4YvzNP+tXwEllBH3Yb
         f4qcaj+YxuZehq+c0dYw/lsnb7tTyfEhTO/CoFTqy6jm2Pqq67y5JZ1opu4G+itWXvjL
         lYR10dOC6GSf8YwX99htXt3qrGoZJo0uPycqtaF6TWvesuCSYUHdMI1s14ZNj2hJ5h6Q
         /h7vo0z/mBHyrf99383SM5lymdDD6/ITj6iQuUoGVfUH86GG/FfcBJwqC3HkWeV/nhfe
         kMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781969605; x=1782574405;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSWmX1bhHmzkxm6/L8LLp8cnwG9wP4sAWPJ97aXv3z8=;
        b=UJ3ZxLk2AT26HzTV6iYyDINoA6vi7iKLJ8Kd3IaF/6Pnf6Vo9lqQQkp8IvqWFyd2US
         jMiFyW//+VM9RS0wo+dq83oNb3+KEwUDG18Tswodd2NU7BtgaomTMu9JuVZ5bmqPP10H
         4e3hrioSlO5j92ybUEKc+I3rdIlH8pAAWEmyyBlgkY2on12NwEfUrgMYn1tc/2D2+jqN
         mUJDBIrq5gQvxxvdwaOkI6QberWMGdOW2B1BwiKTaUbJJLD0UhjLWZIlmAhHwFA4zRQN
         BGGVHyneguMu8kKpFqPZU227bngY1nGTO5m+se2bDrsNiLTLyy1pUQBYc2knxWXm6Uyl
         RMUw==
X-Gm-Message-State: AOJu0Yztr3t6CDWIHwwCssuIrw0LJ+VjjgtHorw+rd4OsSpifNCs02Tw
	iMlpI+KfZRCHI8bt7jAy2FUxcSh46JCewd864y83+tQSvMtwG7n2yU5/jm8Vq2FCcd5H/9gJIHP
	9RK+6kgWcHSa+tlC9STg8RU9zfuIiIJGeuc8+woM=
X-Gm-Gg: AfdE7ck37NzbqQHEj26ywZ/hJWWhWXQqMmYq4pXYYrsyXu7EhvN0gyyvLlJQoYmPrVs
	LHBRPZNh4gIAvAgWb6Ys2x3Q1oMI8zUSc+IxjKQLybARHToH3BGehxqYyn9ENvs1ALKhAcwXeKW
	jMljxutYoNKEOur9FD6PWMFSSmrD3DSN0VW5XwHUqa2blSAWZav6roYwnzhouwuv4m2JrTUpkIf
	6Fw/B5zTi97Zsa9Fx7z72LU197soXQ/oHbKftBuVL7tTx7UX8js66iXVA2cN9PtEK+Lau+o9FrE
	ePZCQdpslpFpNGkG5II0AMUN9muyK7qGSqztGDLdck1zvlRMmMGHUFfpGDnjJGgVrB7mM623Pri
	BkibN/MOndhw1SN4=
X-Received: by 2002:a05:6808:5296:b0:487:57d9:9d1c with SMTP id
 5614622812f47-4896aa727d4mr6772999b6e.14.1781969605437; Sat, 20 Jun 2026
 08:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sat, 20 Jun 2026 08:33:13 -0700
X-Gm-Features: AVVi8Cer0dHvxv-mb6ZlZcgZ85W2Gtf0v54faRshqxgrr87fBIomnNG2j5C9ssU
Message-ID: <CAC2Qwm+9sh=ks1fuux415JGdDJ38Jq6eZrSH7-qzQxYCoy+Aug@mail.gmail.com>
Subject: Re: [RFH] Why do osx CI jobs so unreliable?
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:
> So I strongly suspect that it most be one of the t555* tests.
> [...]
> Maybe this is something that's specific to GitHub's environment...

I think you're right it's t5551/t5559. The runs Junio linked:

  osx-clang     cancelled  360min
  osx-gcc       cancelled  360min
  osx-reftable  success     35min
  osx-meson     success     61min

All four run the same t5551/t5559 under EXPENSIVE. The two that
finished differ in just two ways, which look like the levers:
osx-reftable generates the 100k-ref advertisement in ~24ms vs ~1.2s
for loose refs on macOS (so much less time mid-response), and
osx-meson runs tests at nproc while the prove jobs hardcode --jobs=10
on a 3-core runner (over recent master/next the prove jobs hang ~40%,
meson ~10%).

When it is wedged the whole chain sits at 0% CPU. upload-pack is
blocked in write() on the ls-refs advertisement, curl blocked in
select(). So it looks like an HTTP/2 flow-control stall on the
response side. The same stall resets itself after ~60-85s on my Linux
box and on a bare-metal Mac, but not on the GitHub runner; I haven't
pinned down why yet.

On the chance those two levers are the fix, a branch off master:

  https://github.com/mmontalbo/git/tree/mm/macos-ci-hang-fix

  - pack the refs in t5551's enormous-ref-negotiation test (doesn't
    change what it checks on the wire, just avoids re-reading 100k loose
    files to advertise them, like reftable already does)
  - use the core count for $JOBS on the GitHub macOS path, matching the
    GitLab branch in the same ci/lib.sh and what meson does

I ran the two macOS jobs under EXPENSIVE about eight times with these
and they all finished in ~30-44min instead of hanging. Happy to send
out a patch if it's helpful.
