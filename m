Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257256;
	b=3njjcsv0VpXXgQpZe6o7hKlUC1dVUrC6CtORsRA7/lGrz/NHMJSnWRvZI1ZoknEWnqbc
	 RzSc5Qso5rZghSQ9gsBeedMmn8bHk1AkQZxrKMjWMjk+WCt7x2lu34CeLVhpiN0930lT5
	 /xmW9T+NesxQGW+uxA+Sj+Oi0VnI5annf6vkXr0RW/1EJ0DlA7ROVQI2S7xdilULLbC6O
	 OMGAZzSs/NPFp2RPIzxhT50WVjNSieCPaiiQeirUamwBH1A7RBkvBJImZIiZY+FKgOzxH
	 kye+3eL4uoihf9ZZn83FLdIX4CfPp8t5gn8IfF1RXgpj79HKJ327oXKfFFB+IOguBQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=KS0IeKciKKhANOBsCC5ou7q0UIbGngunARr5vC5Jtbg=;
	b=TT5J7HFZgN2VQmfL2AC+zgRNiScwgNUj3evLJbJrJ8O84PiZXQM/p6fHreK++yJfYdyg
	 5Ofh38EvPgHegDmM8OltHOmESRopsYBQ0jQZyup2K+bKlR0Cy9atcGFlI1m8pl+D4YAOq
	 OAcmZIwUyito1WUcY4ZMISUNnIYqoxZ/SjjBuclVRmcLgnAXCF4x/P6x18+XN4vHiex3q
	 XQk+iD2o5VIbY12tx+YMmBpHSaNJR/ZK9876F0MBd+YT/HhY8DYllB47wdl/GNNKuF5sw
	 bOwrZMgU7umwsooQKLlS1p3nSHYL/VtqtfHP6SvcoFgUvtZs+PcVudk4x+F6RB3M+vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="B0BW7HG/";
	arc=none smtp.remote-ip=209.85.222.46
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5201606A338
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 20:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5201606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B0BW7HG/
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-980c4258105so693778241.2
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 12:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794257255; x=1794862055; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KS0IeKciKKhANOBsCC5ou7q0UIbGngunARr5vC5Jtbg=;
        b=B0BW7HG/pSYnhi8YnHpjvyWsMYPpn2cMiHUM2Td4nnEzzx7aow+84+2RSbNVP4EBxR
         WhjL+nVtbOzzokI2vLDrvIXe0zagTlLbgKs1c9wphoUrUMspuXHpkJdeqqVfCa1+R89n
         WQii7WXZ/5L7PjRVT9rBM+SEyYTlnMMQDPZJ14PjVhxNpDyrsOjqLejms6o20ukw2lbj
         tzWUd2To6gLA+QpTukhcZVoZNVdw2t1FIZAUHjkNYgDgUd8q2seRoyOVirChTRgd0UhW
         LfrnYIqwOg6UFK3BrRlcNKOK+kObhRXCMxTOuSFLo4Imhh+h/0LX7eCfGycuzp2a9riJ
         jA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794257255; x=1794862055;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KS0IeKciKKhANOBsCC5ou7q0UIbGngunARr5vC5Jtbg=;
        b=rxyPycWOGWg06wd/ZhXPkViAXNTO/028RtFZbOivuQ3OalVPWe4m+BG4+A6kR760L9
         svg20ld+EGOf8ixY4aP/xzWRuax2jlHOFkYlry/7c/ggKfCIHu0vFXD0JNSOFCvjAP8r
         Wz67+r9xhFMwUXVTIBp77CPcmoY7bsTp0oWbXS3TrtO73YUF162haIBNhiu3F05lo/5M
         bbFSV6VCTM3b6acOIXz1wdRGa5g6T2kf1/Ia6NJ8vI3d/IRJtPnMBt0/zRRAY4CLshug
         bPTkts6jkCqrdsWFr7pNbXaa9tOs4AFktHNh8KDPR7k8D1ZMzM2MPrCMiaDXFXC9/AGn
         yPhg==
X-Forwarded-Encrypted: i=1; AL+hErHCHbtzEHC2IisBlX6+pLu+nfoRMDVTJpB2Fb9OeAzd6J6H8EN0q0p0xG0zPg7TILmMHP4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jrnChbDObwUwHsVzOXCvQY4COMBxwmu/x7BaZeCJODy+Yr5Uz
	WcRFPb7GNhiOsApUyPJuUVSFnyGk18c4Lzyqkcf8Gqn/vFqMOzI1plc7
X-Gm-Gg: AYBFou3dAQgAN5iavFnKFc/aIicwp8pmDMqjaLluF6lKX6IZ8zThYzfVox18iVkdTuD
	j39h6qMzrSoIAeNyxYY54gtIJDZwBRie6Yw08rLOfWccrCSFeU/tv4ZtPMfN50U1Py3oUBOrGif
	t6sxozZ3vtV/tWdX+0ExmBDpcjQXNcizno+Fnpg/8o6DkEdFYFxdv6ptLZqvIe5b5Aeptcj7MV9
	mTrNqrSsgUOKkN8B/1JpoNb5noLO6sVkykanwCJzou9Ton3MloYwucXSkMrCosA+a++vnc0teNM
	03v07bQ3WFYwZjbKeFZm1Qxy2GJi6auMJJBTPvMydIuAJOAKNGbNiNTIPg63Ygrn5hbdjP7aNU9
	yMK2XmnxsiMvocBIFELPtVXuFnekcZDsuzEJnEYCFhbWJJIr7kG8hGNEiB9Hv+IUq7b+pv4415z
	NOy51s6aEVwbehniN9c855FON2LdPBaZjVlXinSS3MwSZ26gAuwdpiPclebsN0IgGLpf4LAlbQ5
	1o6urs9OmVrWsawKJHTJLQBCpQ1/ZXSFo56XmXEKQUhErixnZ+hzF1BJY4qL1lfEopt+JkncKrs
	oDfQZBPLiSdO3bt+UTOW5xlVvwsbllbCTKdOIjwo23rqqKdbwpuZlkjlZaLRgwh4DS9epsfxKMZ
	/qntoO/yKdGK+n8yCCTVJ/WhmMFxCBlCvbbdyx0Cx521qgXDqVznpTjJaDcn+j7PRRLmQnZf9nX
	daS7ve8AfJvutoebytjFSWPYXxy367NQkTftGsZw+QOuQIDSNEUgDckg==
X-Received: by 2002:a67:e7cc:0:b0:7a5:391c:37ac with SMTP id ada2fe7eead31-7d301bf1b08mr209270137.10.1794257254695;
        Mon, 09 Nov 2026 12:47:34 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c2003b37csm552047241.6.2026.11.09.12.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 12:47:34 -0800 (PST)
Message-ID: <fefa2680-695c-41db-9975-7e972590b969@gmail.com>
Date: Mon, 9 Nov 2026 15:47:33 -0500
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fsmonitor: check the untracked cache after a trivial
 response
To: Ilia via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Ilia <ki.stfu@gmail.com>
References: <pull.2247.git.1791127155614.gitgitgadget@gmail.com>
 <pull.2247.v2.git.1794251653636.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2247.v2.git.1794251653636.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/9/2026 2:14 PM, Ilia via GitGitGadget wrote:
>     Changes since v1:
>     
>      * the whole untracked cache is dropped if !worktree
>      * removed the comments as per nits

Thanks for these improvements. The v2 patch LGTM.

>      * rebased against ToT

Generally, you shouldn't do this as the maintainer will apply
your patch in the same spot and handle most merge conflicts
via rerere, but rebasing interrupts that. The main exception
is when you rebase onto a specific topic or with regards to a
large refactor that merged recently.

Thanks,
-Stolee

