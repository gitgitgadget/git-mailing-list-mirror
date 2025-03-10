Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7317225410
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600005; cv=none; b=VExVi55N4XvZlRx0h8IKq7Yzpy0GUlKbnDQC5FCdXGrhtbJQayM0/n4awZURluEl3GvY7bP2NRnq5LnM6fzYm2r8NF2vP8knBXYFvKBaP36DO+V0fEGQyG+TWoM7+hQ8uPI04+auGYjbvdrcC+qJiZAzx/Qm4Ef57tuY2X7VfLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600005; c=relaxed/simple;
	bh=YQEDl9uKZAk+3MaG24MQlc9ZTwYlf4ZUS4EfY6ETPjE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=YX2yZe3SWebIxWuSjfUDFrkaK1ZOcuPnEoscw1INMTuT1112u5qSEQFjMTkHCw8tkFXngpzw0tvF92TcLze85oPHDBdGorYasMfl57A4AxE56V6YwT05CB/g44QVgetvSqGIfcuqw04nbKHL27OiV/tcKXhz6mNeHtTL3PtQ+M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uc2dygHT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uc2dygHT"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-224341bbc1dso39027215ad.3
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 02:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741600003; x=1742204803; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sh4IBdzzZb0y//lhl/Cank6u0KB+JotzYw+IsbspWcU=;
        b=Uc2dygHT/ckEva3w8wbu7VevWj60WQwnZB+lhMblSlYjUuoWBeh7gDULt6DJ2/33Ts
         ee7SXRVVqWRsF/AREn/bRcHaGH2yMRA4aIBwzEgAnkEcODVmICL1vioW9mey6sqPmAa8
         yWzPqV8TmVTkvA5elDzZ2PN2M/gi45MyQpVv9JP9Ql8LW9UjT8EnhbTslfWgj1BMKDIp
         CZ1Vj7qgPx2DnFMn0n+cpfWJbzv86i9olVA3vuBHCcSt6zupagHElZebDq9d3epRPu8f
         zJ88qUNHpjLiemtlYCwUooRNjgPjk1o7WKmjjU4Y3nF9t/RJNmTziOBwy1hKol31Gux2
         pnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741600003; x=1742204803;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sh4IBdzzZb0y//lhl/Cank6u0KB+JotzYw+IsbspWcU=;
        b=E6mDAHCJEdwK8QYlm65xq3zkFSJxlDjApVGSvl6uymhipWznk18PRnUPMI7TYj53jz
         mdT9wCzPIOB5zBh2zV7lObKwlXGMK+LGlfG4PO+vwoKQiTkw5cMEzIAVCdFhmEW6vQ1H
         q5MXF/miZCg/8YVlyEaX3+5LIHaGOjuRu2kTvmLNIK1Dl9JTZZ3dXXAUJm754EvaETSP
         YL5w/K1gr7vdc4w2tXim21TjIZgKSN91waKsM6z77FVlFkiBkefvOtYjW9YJmNi5v7vf
         HhumPohYKfELJqTRv2xALNTn1VHYCAxPwOfEnBg1XL6ABRGHCW1N4PAk8Evi0p8lHxRS
         pfrA==
X-Gm-Message-State: AOJu0Yz9VypSu3TAKlaUF444Hj6fh/NUXaSs4GmXmkYU+GWjTMyKMN6E
	jkr5l6Oj717vSyK8aPcQYD+d+C5XN8fmAFkPYg5CErIA/bqj7jnUMG9jAQ==
X-Gm-Gg: ASbGncv+zKQCFSgVsadYU4BhqMG840tauhlTwF/TcIblf/X7XO63MDlA9g/oZEk4BHi
	0vdESgi8l4AMEKOSc3laBO1mazWCrLz65Tn54e75xwCXiiBpjPfLYBqTM7dMi+o+ETe3Y2l9G9V
	lVH6CNcGXoYTtWYO0djoJn9YaQXXB5XiIrhOvh8VpCohuLonGHNmUkLh9knTGQQK9kvTlelx7/U
	oOZkls17PsOSwV3YU+hNgxZMdiSDOvE72bM2mReUNC4R18K+PMClbHUkDhfa51dKGAk4axJAub0
	bsPw5AbDG1PCvV85VfSoSn4O7MAnPDLogIMQW1gvgekf79w+uw==
X-Google-Smtp-Source: AGHT+IG3fqBhHj97Mkn1Ci8qCyjMBMGro71zsZuY7PkFKJirk4omhMDRTyt27kqvXEstPB7mL8vN3A==
X-Received: by 2002:a05:6a21:4613:b0:1f5:67c2:e3f4 with SMTP id adf61e73a8af0-1f567c2e5ebmr11052982637.30.1741600002726;
        Mon, 10 Mar 2025 02:46:42 -0700 (PDT)
Received: from [10.61.111.37] ([103.21.124.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7369d4b978asm7532481b3a.28.2025.03.10.02.46.41
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 02:46:42 -0700 (PDT)
Message-ID: <ff10a962-57c6-4603-a739-f4e068886820@gmail.com>
Date: Mon, 10 Mar 2025 15:16:46 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Arnav Bhate <bhatearnav@gmail.com>
Subject: [GSoC] Introduction and Microproject
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello everyone,

I'm Arnav Bhate, currently in my second year of undergrad and a first-time GSoC
applicant. I've been interested in contributing to the open source community
for a while now, but never had the confidence to participate before. I'm using
GSoC as an opportunity to start contributing, and I will continue after as
well.

I've decided to do the 'Fix Sign Comparison Warnings in Git's Codebase'
microproject, and I already have a patch for decorate.c ready, which I will
send soon. Since, it is a rather small file, there was not much to fix and I
will work on more files.

As it is my first time collaborating through such a workflow, or on a project
of such scale, I hope you will provide your guidance and tell me if I make
mistakes.
-- 
Regards,
Arnav Bhate
(He/Him)

