Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40781D63D1
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 00:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771203425; cv=pass; b=SVt/o6tAr0Mg6MdNuncO7H848uxK7mww7SraGrKCKKy5x9uKDpIHY8fWfFgPeCHdcbZccivkcl1nH4RgvFJqjU0RPPMIZSzv58ZgoPxq+PuHw9vaZg+X0SvnQxkMApK+l23m+16KaJOivo2BwiOCA2g6Rf2a813dp+hJ3oBKMGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771203425; c=relaxed/simple;
	bh=1QuaJdNTbt7s5i7SUvqz9lRQJH797I88UTOb6sux7ys=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=tRFs6xHLt11kzT4FKDj89Mf4q/5/OTmKrTYKA3x0oiGZ9rB6ks6wW/HmSrjAfJzxT4zIr+s1069TLFxEpvDORQ8KpkEf2LNgBsuLQMdPprvvYcQRdxFux/twlMBegpqJbO2YdxFLoZwtvCDJXsc+iIMOl2m9qGlDyx4g1G/OzNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3v8e0YN; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3v8e0YN"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-823081bb15fso1431865b3a.3
        for <git@vger.kernel.org>; Sun, 15 Feb 2026 16:57:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771203424; cv=none;
        d=google.com; s=arc-20240605;
        b=L7fshQRhzXwRu5I6hbpcSo4gk1RJaUTjcnMFSyDG0gFH50h5iofAjvA1LOLC5Nr8U9
         iPmbRbpQ734q2Onm2Y+M0v9S4etqSGH5lFTnJekazYNAOl7j7dL3fstZZ46I4F715Dje
         g5ezrPJiW3qufkUHru1qtYtfNWW6YqSooaFKyqeS1PNgGmU4MMHNSNRkboTIYoukj/3j
         N3tfOVeCkrqf46o5D/zbsWY6D7vFDpObsyRqlAjCSfj2m2DkhdKGJsa+QExYhXdrpXni
         gv+WiHHKktzC/PcOBdNdowK6wmM9LGBk5yhuBsSdYdLg0QUfczEGdb2t6o/EWNo8O36V
         Nhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=1QuaJdNTbt7s5i7SUvqz9lRQJH797I88UTOb6sux7ys=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=K0sevAii46WduBS7BDa+oo0z/Vl0UP6/q1iTy4XmdMLbqEpwRY8CnfRJkKLcvTnU6D
         68a+FL9d73MZRl0pDxHDu/tFZRJBHnLdJvNHso/MpwSZV3PTtMCVmJihJPSOQ7Ixv9n4
         yNUG+s7WWRdVWv6PvXFcr+R2LaKaCKDR9ghDEA5K06lYi983BqsQaJ74UNz5IKIYXxGI
         hf2EDASUnbm9irb8PfomiraTn4Jhr7tasumdPy10qyn+2M/zmnrpSdKZCOyAmfoWDwNN
         U/6g0jYWuxLZIzOdOll4iwWSRCn0marDazqeT1HbVht5Bbubm0kF3VCF6GpTVWsmVVt9
         awNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771203424; x=1771808224; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1QuaJdNTbt7s5i7SUvqz9lRQJH797I88UTOb6sux7ys=;
        b=N3v8e0YNwUhqVdD/yQQGadOUJqDesV4jDWh7x2dcbM3rD4aIUo76WylukQ2L99hTE6
         1el21hahfEyGz7d8rK3nhY8BXcIv4jia7+9mlnEpngZcSZN81woqII7h2zLUun5FFvvr
         yZ/pe4JEOmJRsB00EmlvdX6DfbkayYpQ/W1oCM5tep1MajixM0MzLdvTu/eMlKPt/cBJ
         9VHMVXB58duejz1DZFS0OcQVLCI2I04W/yeQ/cfDhlbp5JOqC8xVjKraT7d1qEHyHOUV
         pLWNnw/xoZOTI1LzFBz1V2jiDp2jQrLIe/1OvVYZahg/dwnaJ9fPShGi79awZRdM2tAK
         P9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771203424; x=1771808224;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1QuaJdNTbt7s5i7SUvqz9lRQJH797I88UTOb6sux7ys=;
        b=bJ9dfBTZTzARhybNzf/f1z91vfC0PJxmVSDZhdFNa2nfNDkPzOI0H5jOiQKPRZggdR
         jnLxuEBWy2cJL9jM+hIKIXdNzvFayMM1rRjEd+vKrjyKA81I5vBXH/9fl/t8+p7yRJfV
         r4rFDc9n2bF8k3BtGwP6yXWFhbFinRYpciHrWDRPclcy1tIELX4m8DOsTiHJUiOXu8SR
         xOT3NJ0OTUekQ9ITEM8+0hgLCGcpf8Vq53roTWqOI0+lbUXDvwvSM6Qji7ho/EG0fDTp
         T073KymLZds+wtxdyLHz1QjfBHSxbUrM4sblYsh0XHTn7t0xkq2AcmWyWND4YJ5Dxc9h
         g9wQ==
X-Gm-Message-State: AOJu0YzigqnDpEoXE6dxFomvquAFGdqUMBdQDHDtRnZe+4KERVy/Pjmx
	Uch24w6XWmsuvu6gY4PRNp7oUxgZKuCRVebOTiCoUWawJSttpgluqgyANXV+59Qe5JBfaegGSp6
	+P6f1GwJjGm31O+rCcy5cZH6+FrCuQFkKtIx7ELQN
X-Gm-Gg: AZuq6aLXEsfScMbJ2W0K5Y9Vq2kGqsIjJnSa5hQL7CcoQrgou18CBcYCfc+GP+5+uBU
	nhcuYJczeP+7uB6mKOCqTOSFMNGTvmU8OPwQ2k6KBXRDFfH9WnenNZl7FiiWuAQ9nNeVWL+h81l
	j8ngT2CyfZ8pg/+J9yLMX1rbP45u3NjKpN1/jePgrEW817IT/S8j2qtlQmdjxcOSlXxQXfeDgdJ
	jwRQkZs0M1SwVrmGCB3MO8LRGTSpaItd4iyJ2VLaXo22rR8uo/BjWtlo9Q+68bWb/NV0FA+/ZbN
	EXhMLmw/wgF40zpM
X-Received: by 2002:a05:6a21:748e:b0:38e:5655:2897 with SMTP id
 adf61e73a8af0-3948389a31bmr5444584637.22.1771203423609; Sun, 15 Feb 2026
 16:57:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pierre Houston <jpmhouston@gmail.com>
Date: Sun, 15 Feb 2026 16:56:52 -0800
X-Gm-Features: AaiRm50EXdT7N8XIkX0GQnEuuhqGfT2y80M-qPFgfcBXXTVMqAL5W1skYzC03Sk
Message-ID: <CAMh=C_0ravwVS6UsKKux8PTewd7Z=db4bgvisMXnPwKU-Kyytg@mail.gmail.com>
Subject: [feature request] stash diff usability
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I can't recall wanting to get, from the command line, the contents of
a stash as a diff in the past. I thought there was maybe an option to
`git stash show` , boy was I wrong: `git diff 'stash@{0}^'
'stash@{0}'`. This seems rather user hostile.

I see the request to get the "!" syntax working, this would be an
improvement, However, I'd like to see the command `git stash diff
[stashname]` to be a shorthand for the above, and of course defaulting
to the most recent stash.

My apologies if this matches an old, previously rejected suggestion.
Searching the mailing list exhaustively takes some skill I haven't
acquired.
