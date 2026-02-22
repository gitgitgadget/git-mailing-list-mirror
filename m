Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9B735972
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 05:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771737215; cv=none; b=ihKpskC0Kwk+Z3nwUA76z9L3blHUOrzRHYP16k7MxpJEQ6cb+1SvD2xlfzsieh40dZe+zInQbEXrInbtdWnmRXI/vmi6jC261EWzIGJFOA9k9NLLerb251ftnra8C7TMyj+J0zj2MIbVsS0/89jJIQAJHkOwmRCv7dpu5rF7gRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771737215; c=relaxed/simple;
	bh=HZJfb1yuRegG13j2qwt+NDiY5A9XnG6+/QPqmpzEuro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMAxgCaY9+YpWuCrcHT7lzgVs8aNEmFZHfxzGUP4O8OPbyGod4t/VJAkwmolPBkkWZUAbpy5DbwF2KznmAuSM0LhDOmEZ81oys657sOr6qoJc2JtLxk4OXUg7fw98o0RlqZeOtadfL0CTtEn10SXE2zYuQObE+Px1uQ4mqt7lVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKg1c2Fq; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKg1c2Fq"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d4c85307b2so2001376a34.0
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 21:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771737213; x=1772342013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8/e/94a7HrEg4FZNPTelGNLdcYsioOz2PpwKK/vQ9d8=;
        b=QKg1c2FqgIBykzMsmlgoJG0r8XV1lkVKhFvVOz6uS0oIKM8FE+eQVIm9h15y/h5xbV
         PhU4ISjEuj7WBGKirdXSAmUrkCpzecCs4sSzhOBR982AgzCxiGY0lSJs3JQOmQUP2Qr5
         lP5e4NYblMsNfeN+2FdbR6vZK6KZ6GRXxmx31jh0x7+iqJj4e1SKmIqC8JPrTeRrjX2B
         mOnRNbLccM34WHJpjUlLtmoKwZODQoGfA5nxNd+fqqRsusy5X0FacGrUD0eiBo8fKCyB
         6c+nZ8SB02qe+jrRj/TP1hax0RKiUTQFxEan1Q/0Y3l2U1ZILuJSp0CWO2MRzo+IFfbL
         7HBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771737213; x=1772342013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/e/94a7HrEg4FZNPTelGNLdcYsioOz2PpwKK/vQ9d8=;
        b=UbsO3wruVilgU+906JhOTwScCJvzj4IkYBZL772VpJ7zBUjY88u9o3saDdRpz0ryW3
         AVU2VWUnmX7kLK/vjCgfL6IProGcjNkAjTCLk+im/lUgi+MhXWMsL27Ba2yMZYVB7bDK
         1Ng6eQtBQoKhW/vnGukKsj/v4QdTnUH4kHZpvaI+1WvFFk7x3hUFBnnv3S3VYNbwO1Kr
         xwjwIOMS1/dowoc7wnib16JmGF0gRFuVFiQH1HpEeczZXBjRc8wfJXZkU+pSXpzO0pJs
         rrbyl2jSyIuLkidLaFKz58lKQ8a+qlZGplyg5iG6hzhYk3/x+efqjH/b12/nvYbUuL5t
         RMFw==
X-Gm-Message-State: AOJu0YyWJZE5jeZwbtTKcWBj2Ud6ALghhWErotVQF6+7swdEBiAJizc7
	EsY3EPVUg1btx6rNpIhctqh8Vfl8BI0KkPtXMgwKdpPzRDlPVcu/BMNd
X-Gm-Gg: AZuq6aLNPAxOmvZeaLnlUHBZx3HsNhcaKaEfCvzP8pLH9Iyl+5FY2YFplkIHq94ytHJ
	Ijf3oGhrU9UBmUP5VQ4lz+hbrAqRAy6OnZ1Zo+BSONgHS6Nwb1V2r/CXh3U9uR0M68t2rdmN64O
	7kt1NpXYb4ZyfSxFbEIFLxMPHpWJo8idQtcqpoJRK/XXA0SRnRu9pgQRgQGBlglyFy+pStxVEwE
	gcETzhCP6rO689MNYtdJozcDmJzvAf0kC16naRoK/SpThl6uzDuJhpRfUUVqN8KD7iILVYE4cVK
	u2R7YhHaREP4V66F+RA7fC+N0GNgMcMlcgSOPlAEHK8swUn0IVtPAYshCMbpD2w5isQv882Vs7j
	KQTpMBxwW3lt7cE2GZcP9UadGzDjV5u62cNMi4NR+qy3/AJUqp7rbktGLptnooV8kufNE7QWlIl
	GjwHKsG7I1OgE+GCao
X-Received: by 2002:a05:6830:82cd:b0:7c7:6cf2:b77 with SMTP id 46e09a7af769-7d52bfaf3f8mr2297392a34.32.1771737213082;
        Sat, 21 Feb 2026 21:13:33 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d04de97sm3886695a34.21.2026.02.21.21.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 21:13:32 -0800 (PST)
Date: Sat, 21 Feb 2026 23:13:31 -0600
From: Justin Tobler <jltobler@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, ayu.chandekar@gmail.com, 
	siddharthasthana31@gmail.com, lucasseikioshiro@gmail.com
Subject: Re: [GSoC] repo: remove unused header
Message-ID: <aZqPXRHOHU3EjfvH@denethor>
References: <20260222004036.47744-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222004036.47744-1-jayatheerthkulkarni2005@gmail.com>

On 26/02/22 06:10AM, K Jayatheerth wrote:
> The "hex.h" header is included in "builtin/repo.c", but none of the
> functions or macros it provides are used in this file.
> 
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
> 
> As instructed in the Getting Started section of SoC 2026 Ideas page in repo project
> This comes as a micro patch.
> 
>  builtin/repo.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 0ea045abc1..63d21df4c2 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -2,7 +2,6 @@
>  
>  #include "builtin.h"
>  #include "environment.h"
> -#include "hex.h"

This include is indeed unused. I am currently working on a series [1]
that will use this header again. I can of course just re-add it in that
series as well though.

Thanks,
-Justin

[1]: <20260203221758.1164434-1-jltobler@gmail.com>

