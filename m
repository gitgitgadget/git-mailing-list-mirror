Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516D833937F
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784744438; cv=none; b=LLYyciXqdTUV2DyUa3af9ychiGDe+wqFkiFuUNp+z7boaBUN9/ChVxkNaPbdg4VgLWYCIZCn0w3uD3rXvsSFPz8MRIk7rVOYMMUHM838hNUku8HxtpKYAc9XfDGZOB7LIUMWuQwHC6w4YyVgQyD+zRS7Oe/jdN5sRtTqPAwGH5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784744438; c=relaxed/simple;
	bh=/5z7vYW7zpBWyI4cMsQSjrL6b15x5V8z2KBSIxLFQfk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=AH7iYP6MyUh0B9qSz1u0PZEAPnjWwI+T+cKVw3biJPfImc6/kC5ZHcKJX+1xXUpIfadbpocdEZkJ6Pz1B6f5x0bSVh9wYJMCQ5KBfzifiCY9877WI8GNCowq1N4cULL/r4Zq5AO72CUymXODPVTC4anuVER2qAXkPGQUlue+eZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WV919Pwo; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV919Pwo"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92b21f65b60so597738185a.1
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 11:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784744436; x=1785349236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FmqVblrB/xgtlRG3saB6lb5YiI/Dkxs+iX3FCgpdnXE=;
        b=WV919Pwo669cMKulqscsdmtS1md8IBP2FfS+pUK1nb1KqTRUSllVqGzv3jCBfcsQsI
         M8j18NzWnbzI4GxljcDDtaRfGjY2YZNj7QxFr4a1xPjqZq1zTdIBq4KqHOVjcCRF/tVt
         hZbje9GYKAW5p3StCQxVBny4ltEXUDd6JVvSwwitFgSY6AoRHcyZeLc4b9IS2V5GMjKU
         u8ntcvlIbHvABpaI7i40wHmAIcgrMyjM0NttFZMQXJBO7PdtyNmG4RWnXf0Yzb+7M1TJ
         Un3kw/etLgAO0ApzJUCr7ad9s1D6vBNdzmQ6vhDYqxJcXKg/T5h5UDK8g5hhJq26LRoO
         bNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784744436; x=1785349236;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FmqVblrB/xgtlRG3saB6lb5YiI/Dkxs+iX3FCgpdnXE=;
        b=POA0qx23NikEMKE4k0IueeT50eFX9DnaP7n/hXCyOaeLbyzYzm3kLLvU3qMAWtKsZZ
         SGk3Az98e76SrjHQIBPnlF8rwWr6fiuxyH/x0JJbOkW83bY8NlUVjPjRWuN/qJCTkvHW
         0or3I+GJ7f7BqGpEfiMUqyhzmHL95n2kztu9OzBgtVWLmc41LCXGTSJSQZXLMQ91EVbe
         8habz9SVdW8brA5IMiTawgMlz/ugMDDCUTBQAgeagXe9E7aa6Y1ZFLRSTZikAEWJykIa
         WaiuHaJ8kgqWR78EtsqxwGZMUSxKcmG7ihE2C2aJ1qmSjfHQAjQdxR74iZwX6UVOsIbw
         rWGg==
X-Gm-Message-State: AOJu0Yzhg+hiDJ1Mj9hHJ9CN3vBmXap8PdjVLZskNe1r7FeOStTZ/cia
	KekFUGMyN9fwCl0FAx6o1Tn+cchocVdVnk0QwgH76QF7wM/C/KiXJOf8dvgmHg==
X-Gm-Gg: AR+sD13USzJ7q6Y7DUMBdc6B+QF00ave8Eq5rJ5nNgeesU3D2187BMqZTR6ekXB5uAh
	fmKW97BL+h/zE0ufbz7+PlT4SGR1+fhQoW8xSijzXTJ6Av6pjyEHCi8njgtoypX+zqCCplHU/V4
	vfGf2K3dVN9zip1DkjxMgBXDetsVwVMyZONTMpEq46u+SlV9Gey3C7VJXL44KzBPI4PLFsJgZ42
	DwPFQRTWTdD1434MhL19P/VWQDNBNR41FD5s0o20nZuS8kIQqh/thDtcvVSO351nARsaqH0xqc4
	apic8fp95pUkAvXxrpJ4s/jnwkhsk95ZmOPtqpCEgdLgy6GQWqwZ/IJmQ945WI0T1jC8bfniCK9
	ZDQR//zVsTJlkHmaUZPyRBJQIIEbk/pBP6m507+5EjydmqxSRHB+vIq9+8IABcSv6cj+kXxkLk0
	kBXBHYADF9YLd9iduigxrKMeXT9UhUPoSuMRb4r/D3+jtlJiiV
X-Received: by 2002:a05:620a:a2c6:10b0:92b:67e6:4b79 with SMTP id af79cd13be357-930f2ffddc2mr421690485a.35.1784744435982;
        Wed, 22 Jul 2026 11:20:35 -0700 (PDT)
Received: from [0.0.0.0] (162-239-92-34.lightspeed.bcvloh.sbcglobal.net. [162.239.92.34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a8af5esm220589785a.41.2026.07.22.11.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 11:20:35 -0700 (PDT)
Message-ID: <cb2bf72a-9bd0-48a7-9e51-2d67f0a9cac4@gmail.com>
Date: Wed, 22 Jul 2026 14:20:34 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Kyle Marek <psppsn96@gmail.com>
Subject: submodule path with symlinks
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I've just hit this change in behavior introduced ~2 years ago, where 
submodule paths are no longer allowed to contain symlinks [1].

This change has broken a practice that I have used repeatedly over the 
years, where several worktrees share the same copy of their submodules. 
It has been very useful for project organization, but no longer works on 
updated systems for "security" reasons. Please, I understand the risks 
associated with symlinks, I do not want to be "protected from myself", 
and I do not want to re-architect affected projects.

I see there is even a TODO comment about exactly this issue [2]:

 > TODO: allow exempting it via `safe.submodule.path` or something

I'm surprised to see that this change went through without an 
accompanying commit to allowing exceptions or allowing the user accept 
the risks associated with symlinks.

Is there interest in implementing the TODO? Will you accept a patch for 
this?

Thank you,
Kyle Marek

[1]: https://git.kernel.org/pub/scm/git/git.git/commit/?id=e8d0608944486019ea0e1ed2ed29776811a565c2

[2]: https://git.kernel.org/pub/scm/git/git.git/tree/builtin/submodule--helper.c?id=e8d0608944486019ea0e1ed2ed29776811a565c2#n2679

