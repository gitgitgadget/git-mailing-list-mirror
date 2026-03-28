Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357662F4A18
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774716866; cv=none; b=KjMfE243zoBnt8K0twAluxGvRWDKm62pphXMOR/MZUdN6XFbYjFOyNFLkaf4AS/vBQvgzTLgTrwgkWqqGKIwrMfNX0xeiVUFPAzeHE/VohvoF7joFky+HMwf91hSpDwCH1BT9P6obHX6eooptjIjUGjkQlfmoXG/mYIt6DJImog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774716866; c=relaxed/simple;
	bh=QHMfJy11axABHaMuSA78Bh7Gik2joUvevM1UK+K1U+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GISi2GSHxqfrCptzRtBXO8fJk5iPxS+2QuECUaNIYybemuzsdDlpA6koHgxDHZuP6jOqB7ZsGFL3y84AyCFIb67MZ6T1Uzp9EQtbyY6M4IeLykK57knRPz1LtgvCLT0/X4y9gTO1HcSjgokToXIXTl0vh84HM7YuBjXJNhu62rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCipHoKG; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCipHoKG"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35d99c906d5so83434a91.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 09:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774716864; x=1775321664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vc6itmwos8PR8cxK6ohTq3P9LEEGNePCMonw3cvrvYo=;
        b=fCipHoKGR4QUrrPNhEdukQqmJfHLMdfo6+dn8mAQqCFnxy8s7dakLAVDDVE8g5P5sV
         tZbFTNeNc3YqcBXwNm5XXFZ91KlBslEbOSyNKaMmHN1aAt8DXXHudnbe9vsicTGVkd8S
         m4IYBZMg7kOPAjVYNdGZWdexE6To/pG11nUNXp3rVGy9I9yLdpjsNa0GejYDNlUK9bhv
         yrCMhnAxw9Z8Mb9gqiFQBKsMEhfW5Grih/oE7QzW4yg/mnl1UiF7UHn5sbUbw+kuibhk
         adNxG7QXTirFSSO2PAb9nJEe9HmTGF183JfUjIgZyH13yXvjX/Hj1fmgWNJveiEx19Pl
         JTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774716864; x=1775321664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vc6itmwos8PR8cxK6ohTq3P9LEEGNePCMonw3cvrvYo=;
        b=ejmzDLUYfzf6/a1VTpV+MSu4tgwXVqZMi7Bl5hOfOujIqF3Gb9iFHuJxsNmJd7cjH0
         w706xrsv9B/CmIjks/qrq/7SAR/3Ky1/BHK+JLYb8TxKxX5L5r8Ty3Z8BrQNBqBTe8s7
         CCH/Pc25CvSmgjsovkDMZWMTbeVQzdMXvxp5Vidc7SYLlhyedAxxnm+bF6fBgnXyZihC
         2YUBNfwojWp8MiKsTUxzdWyjZkFZ6G6WilCZjrH4k5WTmhXPmaTDNvkSTz8dCkFBIB9g
         vtbV3cMmQMJ8E1AEdxqruVJWiCRxzi1mdVhMRle8RwokSUX7OB2Ws7VmGUd0AycRtVIu
         VblQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLe2d4jjBhUJH2F3f46zYTyQEvX3IAOeMY9wVGteOGA28ZcSxkjhAMpLp4P29MuxV1sRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAbpE/zu4WYhlmb/LmZAd3Bl41I74WyU20z2LcQJC48K4lBX9H
	ajKzKUgmJYvGyNBbaXLFKE5oNZweSo+NbRcR88A969qE/PCHKvCisIVj0ofIYETMnbupYg==
X-Gm-Gg: ATEYQzyhM7HiWs3D7/ZWWMoHi+qC3btTngBvNxQMtMa5uNuJ7yGVw2M3LCvUg2jdWhe
	E60exzuQxD/6UY/LguO7R7m+ccFs1ajKtLhP0zo72k2BvX9Wajt49bcRJxInDtgoyEJm7eWVhzB
	xHCHQPAmJSPk5WvewNfEyP1JDfjhLw0QS+ZjB9XcwIBodXWIUSNbqvHdoB1vs3i/HV/ongcHbHq
	IWIfmJZztvySgFN+HvLV3n88XYtYMaLchBav0+vpdUKz6vZPNyjUudHMkqBQLe7vnJCVpI+MATr
	yJnSXFeNXkyx55lDbYrzRul2wzIFPKdaXKxSNqpSeWrhz620vo3jgpqNc2XSELNQnzUM1fs0hun
	FWbq5yu8bXDterbyL8/VK8U0Z0jXZJmFDdnF7RSFpQEQJTa+Pf81JrtNgjj4qyqTjN/MGYAZXVd
	nie/LZd4gQfE6JhNz5q+X6g6KACBnhk344ez85/vIb36nFE8VnZsvmPaqrPO8Oo2OSJxC/gbbVf
	LVoaTKkQPc=
X-Received: by 2002:a05:6a20:72a2:b0:398:a440:e3a8 with SMTP id adf61e73a8af0-39c871c2b39mr4448591637.0.1774716864208;
        Sat, 28 Mar 2026 09:54:24 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76916bd67dsm2092444a12.3.2026.03.28.09.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 09:54:23 -0700 (PDT)
Message-ID: <c3f032e4-d50b-4e35-846f-5f5da95f82a6@gmail.com>
Date: Sun, 29 Mar 2026 00:54:20 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] refs: make branchname helpers repository aware
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
References: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260328141146.1095115-2-shreyanshpaliwalcmsmn@gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <20260328141146.1095115-2-shreyanshpaliwalcmsmn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Shreyansh,

On 3/28/26 22:09, Shreyansh Paliwal wrote:


> @@ -5,6 +5,7 @@
>   #include "refs.h"
>   #include "setup.h"
>   #include "strbuf.h"
> +#include "repository.c"

I'm surprised that it doesn't cause any errors. Or maybe you haven't 
build it yet?


---


> -int check_branch_ref(struct strbuf *sb, const char *name)
> +int check_branch_ref(struct repository *repo, struct strbuf *sb, const char *name)
>   {
>   	if (startup_info->have_repository)
> -		copy_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
> +		copy_branchname(repo, sb, name, INTERPRET_BRANCH_LOCAL);
>   	else
>   		strbuf_addstr(sb, name);
>   

startup_info itself is a global variable, isn't it?

I think a more appropriate approach is something like:

	if (repo && repo->gitdir)
		copy_branchname(repo, sb, name, INTERPRET_BRANCH_LOCAL);

I dunno, just a thought.


---


Regards, Yuchen

