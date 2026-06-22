Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C3D18AE2
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782152164; cv=none; b=f4+ho0x6+hthrU+714b+MTcLxCafNDpEvc7fcN7NUXmTnxaw0HoZI52NuudKi2Ag7krWqEg2U8QNyw6wWkkKA9WqMJW2JkOtPKL6ncn+hLaRIb+O47Z5ZZ5S86Ydd6kxbmK5yAPPNvLFJ8zvxfqvnCLzLqPE4vXcFsghWYH6BS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782152164; c=relaxed/simple;
	bh=OJw+UrZe0pQewATbveS9OChkzmtkHe/VpUp3fI9ly4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWOsOwHSE35W/BmV79t7mb4NoY8oipa0s1IquM/3+l1wpQStssbAuPmgfHiMk00+JHa5rxLf6yzdhUT67oJE9lkwtG+J7bovP+TKJIbq0Wqep8pyjFAGncdR5PghVITWy6GuyAA0cE+3PeIh0zS6ITX69F0zyZwqHbm9SxSpfeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNUmmoiL; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNUmmoiL"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-91563abd6a9so243816885a.3
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 11:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782152162; x=1782756962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OJw+UrZe0pQewATbveS9OChkzmtkHe/VpUp3fI9ly4M=;
        b=KNUmmoiLfdje/3FEvweG9tYvx26Or+w08RCqBUnbd/4jANxqBTnX/bZVGUIf9DBFz1
         1HGYupriK6LMMTbaqPlbc5aKB1jb2h7tClc+ineECzbtamKPlWHF7SCX6r+vLYJp50Se
         9JIyUKgByLgWttKwOJTI30TuEdHfOY6UvzDQ8l+y1y2ZOaPeHFUUNVisldHc3KSvN52N
         kvZWTzdQLIw71jRkiRDc1SZHzT6ooPF4QNSq6NiHunzPQfI41cIzGWjnD+ITrQiqZbw0
         0pyuqgrsV6CznfAYW5NNoXeChrDCCDKyVOKkmav11Jbu2u84pLz+0FKzoPuN9dI2n5Gf
         9qXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782152162; x=1782756962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJw+UrZe0pQewATbveS9OChkzmtkHe/VpUp3fI9ly4M=;
        b=Wn9L2x8PqPwKf2TaMlzam9oeW8zqM5BmbtMs3oUw2b1/eua6jSjn/2ZeJFctYQgpqs
         krWbSf2GrtShuvn1YBbpg5Nn0uyjpIU4MHovLnj/aoCBPbrq/EzNf0QPwtxrOaXZnw6C
         OzSUglye2fsQMLN/m+HxHbVBhFSovNQ8/MTsKR5fHOEneeuqON20+HzrN2Xhcf+6hfFD
         UmxsQcrUtM7M5VxUHzL/6bpJw0wBf9Viw0CtCgelbkkQGcaIx3GF/WgZmDBsCwk2piys
         r1IdcgDqK5ZDE+QJL+dEcQ3pH3w+okSHKQ9Q9XVNIGATU5Ur26FSPOCr6Yb0oFL5Zk+3
         Rstw==
X-Forwarded-Encrypted: i=1; AFNElJ/YVjUeqkwj0VBIWI7HBoImkMq+os/wLeUMgEQRMr01bQwEmDk/sk1BFvPfYRzlQ9b7KYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/gAYkb8Zf9Loe0VzcrRtp69AJ6giUu2HTLj0QtIYq/UdV5jH/
	Cc7E9kj4o5oogn1IgGnwdHxnjZ7HLSNHVrhuJJxZOsTIF6e/qEUD1V4/
X-Gm-Gg: AfdE7cl+lW5huhrlJDF2/CA1IBgaqH95mi9/uXxULuUELCS9K3I/TZB7j2XbhYeWFOa
	59uKUR+WVXT4EdFTnqnVKBa5qwVDB+AocB3oPatex6KCX+Di01dAUUMbgguXBMpDrFDhLiO9joD
	VMl7fyn91IX+MooAmMFBXC53M687lIXDJ/sAiMVCNy8Cdmvi8f1vLTg44Z+Ut3UsmQkrV9mLS62
	EwaFuzki/+0Z/pXGYl/gC1X16n5N0A/9gpM8R9q5WPz3O3IzsteCPkxeAkhsvGKrdvMFbJCooBT
	0VHK1R8KY8bRifTYkyGASSWHswrlo5sH1wauYfgFQ/NgZeBAsIMuTvYlPn6z2+eusOGWjbBxuVR
	nLl9p6AJNk1+vBmznCaMiF7H5fhkPy3ZfbW3PUr60J4Cwwq3JXtvbqg26VQ3cMS7h71YmK57oZx
	vLpdcHgCyProtQBiUd69+ibGMPCjvg9R592VqTy0tLHph+FKyR8HVOVMZ4DQ==
X-Received: by 2002:a05:620a:c45:b0:915:8055:3f7b with SMTP id af79cd13be357-9208d3f2fb7mr2291682085a.46.1782152161856;
        Mon, 22 Jun 2026 11:16:01 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926000c31b4sm43777985a.23.2026.06.22.11.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 11:16:01 -0700 (PDT)
Message-ID: <f971ace1-5e4c-43e9-a435-56bd76fdc1c9@gmail.com>
Date: Mon, 22 Jun 2026 14:16:00 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC 5/6] t6099, t6600: add side-exhaustion regression
 tests
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Kristofer Karlsson <krka@spotify.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <faf5bc98ede79965e23bfe1535127d6f52221680.1781951820.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <faf5bc98ede79965e23bfe1535127d6f52221680.1781951820.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/2026 6:36 AM, Kristofer Karlsson via GitGitGadget wrote:
> Add t6099 to test the case where multiple merge-base candidates exist
> and one is an ancestor of another. This exercises the side-exhaustion
> optimization in paint_down_to_common together with the
> remove_redundant safety net in get_merge_bases_many_0.

Same as the previous patch: I'd like to see these before the code
change. And if we trace a count of commits walked, we'd be able to
see the number change in this specific case.

Thanks,
-Stolee

