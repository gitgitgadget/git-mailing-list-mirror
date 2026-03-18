Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A726633EB10
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851505; cv=pass; b=GOA8XmW26RyrvKt8f82wmjCx1By6aj0wz3MmdzCbMUNRFvGhOYHzHexwBvwCf9WN9oazz6wtnZKs+YuBOb41DyrsnSjldCaBv7wRtCFwkRyvIrBXLlwVOIoA4Uqs9dBM4/49cORd75srJrClVNL1FOQnZPcH+KiU4A+FR3Idmh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851505; c=relaxed/simple;
	bh=DSA+ziyBiSCEr5MNCkFDkVubgssDyMVODqYMjABhkLI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=bRn6iWRWU81e7iqNX1jOoBgA2mX1Ju1TA5dZm2FuGVHTKnkpch8/+9c8hTGwJpHShNkbiEumYG/20em3btv1KQwVQlIgVk2KfaYfxHbu1MyNMt2bmNWR7/TwNl7ZrJ7F0/AUJrpjg8shXnq5UCgmSCdunSFzpjRPKMmEeczyJN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuB78tq6; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuB78tq6"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48539d21b76so321065e9.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 09:31:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773851499; cv=none;
        d=google.com; s=arc-20240605;
        b=Oac2YEuz1Fqht1e8KzLOJYxkhVujFWd3gWrhs4nhSncsNENYN0lt0zRbSBFdBTpQvY
         1xL8LKUEMA6aQX0My8IfdrhNpHdWFZFBYGw9OZmaBNvQxiG4AnGborI4rNkpekz2zS4+
         pHjgR5y0d4R+mTYJnq4g3myzCu72VrqLuWa01UtbDR7G4wNejwmUgD7r1BSwI5FB4C8j
         TaUHr+yAEJnSBEcQ2Z8pN3PLErafYCs26x4PEz1RoGXTSlC6ILge56SwU/JO6iWAxKFK
         xB76BZaijQFh2ebtTJe/t1VmOnB8xglmYCgSK1fFHp0zJfgh+DscWyQzKrhd2h4YsI+B
         Z6vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=DSA+ziyBiSCEr5MNCkFDkVubgssDyMVODqYMjABhkLI=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=HM42yqlNKH1AaQS73PIWf13JOABpLT0o9PLVww6bZK+gOrK0Vf4pVF8sB5qIpbPK/s
         /eEfXRg5tCRtRsDRV49+H941tRT6fZb/TE17lQj5Akj/CjaA0FQ+yrI9lRkEbf0dhAZ4
         vF5JcwU/pB2FEdQQzGOGno6FfjAcTjxZ+30B/SZcC8mBd8MDNaOaIt0BcKa555E6KWCA
         F8yYBGWwFDUZ99ViIpwq776hEM28yI+pvuRA1bx0kw3MYSE7Pm8oBZb0OtLnbY6StX7e
         671xqULgmhB0wR2yUEDmj8Bqr/c7X6HILAYUoeWhKrlELHk1xDcLVewzPkg6BYywDiXF
         /Afg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773851499; x=1774456299; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DSA+ziyBiSCEr5MNCkFDkVubgssDyMVODqYMjABhkLI=;
        b=VuB78tq6gvdahW5Y3YoPfElYl3aHhgOsEuVg5MT0Qhppe5o3ip4gqOXsSuSc/p0tXc
         dZHiHub7cC03ZjkZ7NRQXMt+5HfA+GtX5B0xEwrLzc5TrjtV3RHk+mOTpq5W04haqtBr
         nCHvycLW97XJavHmrdSbR3PDRcIRZjYCE5fQVCxBtAbPG53bEahC2lj4kOkRs0FmBi69
         aFGADiAqVqzI0l9fwM9NxLyxUmPc6qQosImclyeyvvHHtyQnFFEO5h6OGxx1ekGqlABM
         oBq60HtAHdoUaek4/vMcMX22ZfNSx9Qj/LF0XjhowqYsLsfCIYa75PgLV6p8q0N5fzxW
         jS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773851499; x=1774456299;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSA+ziyBiSCEr5MNCkFDkVubgssDyMVODqYMjABhkLI=;
        b=cRWLfoGAVj2NFa3I2KL7hySn2KjQ6ALUvEnmg8Nx/23tXD2cvp4QfjycZp76NoYQC6
         lLmPwP5KuHok6VHGmoN/e633Rk+g96rjuqk2qdIdBoT7aUNopVxpPExQZ+sUYn5e8Xgw
         BGF32LrCcRMwHcpAXDK1gdPCL8Ocbz3/5NT0T0c86I6A1UjKiLe3qfDPYdLBnuB4MS+G
         QWcflTKssB1AVRShA9CZRIYeXcYLvZincqJEiIx5PcAd2Ld8dA8nnV+pKfKSGsGnxJ+p
         J5hRgQcLmVZElcL2uI4uhnlpw+Kx/Su4dKVMIzZfuS3OLlLZcHESSZsLfqWi38A3m/Q7
         gTwg==
X-Gm-Message-State: AOJu0Yz43P20L+LufqQfZjGPUVi+f7ZOBrXTRBXgMA2mFagalyzLgoNZ
	ioB+4tRkRNR1JHburAvEkj9biWMQNg1A1ikRE0I7eg+VrwVsfYHb/lYIj1cXivwOgKt3X8e8D6a
	BhqWj92TRSPOjbjakg6DUTs9VQjTVXQZ4smVY
X-Gm-Gg: ATEYQzzopLgfA+DULjvdR26DTEm7UKiqom2EqftF8YP9OMg1dYDfBPbHuBQnsKNWoy3
	TUjJEbhpc2i8ZnRWr2RM7Zx7zhNIdKWTBOxEMptS3TS4N1x8Ofbex2lx00XgakdQC1E+2soN9eC
	F/Qd1bBPFP4X0SfEDesSO2z7NZfXm/tUtFBKCIy/LvfSnHjNRV/MPVeIXCS2F0W0bRy6MgaFw2S
	In6q7oc6sJFTCXgsuB+TfpNlvOy3O2yIjUtrAShbQYllz+0v1hNHgSk6X7cr3Xbz0eKBYpmyu5V
	eWZhxE/NbSi4NjYP
X-Received: by 2002:a05:600c:4f08:b0:485:3c7f:527e with SMTP id
 5b1f17b1804b1-486f44299a8mr67414385e9.15.1773851499366; Wed, 18 Mar 2026
 09:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aditya Indora <adityabnw07@gmail.com>
Date: Wed, 18 Mar 2026 22:01:27 +0530
X-Gm-Features: AaiRm50IXh8SzrFs_MJgSCwPYdN4QhrtzWh1MLxYPVzny9bD5aVUk4apMxqg_rw
Message-ID: <CAP6n+1WC=DUodcESf1aTn0THXDBZWkxCKwJ0PyHinyrFghivCw@mail.gmail.com>
Subject: [GSoC] Introduction - Aditya
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

My name is Aditya. I am a student interested in applying to
the Git project for GSoC 2026. I know C and have been
exploring the Git codebase.

I have cloned the repository, built it from source, and read
the General Application and Microproject Information pages.

I am working on the "Modernize Test Path Checking" microproject,
specifically replacing '! test -f' with 'test_path_is_missing'
in t2107-update-index-basic.sh. I will send the patch shortly.

He/him.

Thanks,
Aditya
