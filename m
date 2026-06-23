Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F883D45CF
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215210; cv=pass; b=kvpwwO2hdJhMBLpZWG/SnMMVdya4hosJkCpVKTA2yVN8wE/QfKXRhSnZerp0KrfVq8U7eqg4117bE9jZcnrN4TdJXfJPVCA0Zc1MtbU2HNLj4QdXxcVhRG4AXzweTxYxiSkLpaiNzmfy/qwYLiSP4OGa+tfii1NUggzIFql1Y2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215210; c=relaxed/simple;
	bh=ycKkR6wRwIHrQoiGQ+UiMoj/PXXL8wEDqDgH+dD2LJ8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PJg5khx+rWZHTw9kPgBrUxfvNObmDYOpcyztEozFFbqp3lB3jV6UYhpc8g5vexMcXmRAFFxm3NJZQceniSS24NvkulKCrmms2I6yS5LHzsXglIaSn5AxWlBi+A/sLOkLt30wueQM7BhxxpNtDjwKhNLrkH1T9KF0nNjRtVS9hWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmY5OtPI; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmY5OtPI"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-845438a46d4so3036248b3a.3
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 04:46:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782215209; cv=none;
        d=google.com; s=arc-20240605;
        b=hqngcblSRsNRHH8RP6x20QqdxrBQkTjQ7zHQSM8o6jC7GNmnZCpcSDpqsTuq8KWtv+
         9KRX47W57sVyz6yhHSX0NQJynxOglbFynJeyp6GIN3CQqTL2VUXcruO3JzmmmxpBvmFX
         fqtMXsoLnns/7HKo7sS6UgKD7XoBcJkSytr/P+UbYLFKIhPqCd9HP6SXhE80lqhKKiO8
         4Lhv52pp9nXMvHdZV54M9dtMByRmNBvDxBCWhVdZskQWxdq6OoIjWNxGTQ/2/TXJkkHA
         n+PvHv8CWUw40KcPJW0t4Yb95X8mEByhNmPCEnO/dTHjMoMGFPUfQpfs56TP48T6p0Uy
         ECoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=ycKkR6wRwIHrQoiGQ+UiMoj/PXXL8wEDqDgH+dD2LJ8=;
        fh=mJp7zD/aNhugTOnrL8dQ02PHrLAVRLvBineKoPiKXAA=;
        b=hpzcKpHujCr7ndG25FP4To1WiSH3vuHEpXz7EsSiDjEoe4A5/vOPzIIoKPL2rTrLpu
         rPg0531gMHLvouQW0QcKMn3XtYS3CMklXekpnFDbaN6rIwaKlhvrU9p1Eow+622jlSy1
         vEmZIjqvcD+8YrxaBaqd7MpkOlQFpvuY405ketd0vgX2iT12++lEEHPUTWiJesf1lH3K
         oUXJz8tzedAaP1jCN0lajIc2X834S1EK4/sJBeLELj1o7D5nK3BQDsii0P2uuRjR9YtU
         aYoetD/CCPzJSZsgu77iL+22cdfW3pLK93rEVc5rVw1sRZrdIU2CjEQnUy5yE6PjWZUl
         hqbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782215209; x=1782820009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ycKkR6wRwIHrQoiGQ+UiMoj/PXXL8wEDqDgH+dD2LJ8=;
        b=ZmY5OtPI5sLObK/dWz9CkHGcdW2clBPkowW0aLU+067zi8zqeHptQ/WLENjcGX0VN4
         MUh7qMLlFr9INu8n22fBom0XW2KvmLIRFuqkpS4mdzo5kiq7PaRHVMetXHRW78ZUjQKA
         sIifIkY3t0sL+/caLk6Q5q3ULbQew2+qcZziaPv27K3wgLu6GyJ57fYhadfpRoNOqJgK
         NB2woL2O+XEkOjoeoK2BZ+Yx+8Kk98Iy3z5VZxl2qI7qap8dDKswFdJycgSZ3G29pCPm
         rn6q5q9dD17DThYS31aJP7D6IYbNv/JrZ3k7o9Gs+dRMfpG6rugjNhK/pYZgbCgc9dXc
         wLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782215209; x=1782820009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycKkR6wRwIHrQoiGQ+UiMoj/PXXL8wEDqDgH+dD2LJ8=;
        b=HcNIIG/Q2o3FVahXVA9qfyPFZxC7ryaXBhGPf+K8m6wiahuaZbfhFZmG0r5NhZ7xan
         0ssBy5ufCMfIjLVihg5hXNnhyPK75/RpxjAXUnV0jtKjlS+3JmWvlaWHirzCMvB2FIMd
         F4wHlUhan96cTsRroJtrC0bJT9EWrhcnNh2wYfIhf99kuziiO+8P3XrtSttmvVPLQ6GO
         sH/oU9j6JJmFb03HfFmTG/oaxE1tqjTLr5T94pSua3v9r86Cagp0upYKhUWbY7Z9tuPo
         h0pGdfvyPiVMGO6vqorUQljBQ6maRJT9fPsCE4rXhmA1tBgIOAc1X8xsHUSWdN8Ep8Xx
         dVVw==
X-Gm-Message-State: AOJu0YzqQTQVpELw80JWAaGe3KwyAyEbef53OW5FMBsZY3AHojCfRyLH
	JggHEtRgBZEx46mC0Pzj6VFGAJi80rrc0psIQnA6u030ydr1a+rMtOZRdVSIPm4KsT7da1eLjAj
	go4aYyI0X/cBJsJPxUkSMH0P+8apTUxkcuTOX
X-Gm-Gg: AfdE7ckMhz5eLkul0e36qVRVI6uFQAVEIjgO1MeZWJ1ULiCtFSFkSapIjPnv7jhy6+C
	dR3GmW5nJ/h/JpuEGgj4NF/Y0o4Pp6EbUB84VF2umg0B4lCH08tBZhJDo1AxfV6zrnOFuV1o9QZ
	Lje6xFFRhlgGqavdYia1f8FBO4mnKMHqkq77OOJmQBdptuVrAzQDfeDeOGV0r+0467Etoz/fFCH
	pvG5NlBYdf/Kqxdt29hnrVlvyN35voMpgahT53OnH4zduAeyn3qav626Gwm+90GXhZ/epwsCkId
	gPORNXza9CCRoPVm42oDDksA3bXFOpEexzh1wkKsCDwvITNtfsonA2q2ERmssF+/SeYqa6m21CU
	PDQYmSuShhRCSGCpe
X-Received: by 2002:a05:6a00:22c5:b0:82f:38df:681c with SMTP id
 d2e1a72fcca58-8459704a890mr2521877b3a.6.1782215208807; Tue, 23 Jun 2026
 04:46:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Tue, 23 Jun 2026 17:16:11 +0530
X-Gm-Features: AVVi8Ccfcw8_p8xFkGjyKt0-Qw3adYip6DO-jTQ1d43dFTPvHGcEr2pKJi2md1k
Message-ID: <CAGWgyh_WJ2mAgbJ2agp9UQm8iyR=eq0xWjdYT59CC9fZTnAbzA@mail.gmail.com>
Subject: [GSoC Blog] Week 3&4 : Improve Disk Space Recovery for Partial Clones
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

My latest blog post, covering weeks 3 and 4, is now live:
https://siddharth.shrimali.info/#post/6

I have combined both weeks into a single post.
Why such a consolidation?
You=E2=80=99ll have to dive into the blog to know ;)

Please feel free to review my work and share your feedback.
Always open to discussions! :)

Regards,
Siddharth Shrimali
