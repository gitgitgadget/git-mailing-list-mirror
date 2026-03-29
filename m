Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431CE31CA4E
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774798651; cv=none; b=GUHQJwdtrzb3uA5lv44W85REJJ+i0/pOlo7mU4YSrMs33oMI/kMqhMM2pUZV5iwmGtDsrNPa9fXazf3b2ODHAZH3MfUrbjzdyqMmNeeEYbPM3TtxRk2OmTJ4Qb1XS/oFQmc+UheKds2aYfQ6dt+Ys+CnmaRS7+hMZNdJaHl2Jm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774798651; c=relaxed/simple;
	bh=owgRtXUSakKISoqSR/NEIjW3yZGGAiZiOxkcTKbXOu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQxpRmi4ObnjmVvSZEu922ho4H1yryBfZwD0A2HOaKllXwpsbjCZmjzNgkl+dZqbygttdJRvOdiWcg7U6TpJkFpBXAMzPJwAh4Ylyq5p/iZyx6dUgSRU2NPQ+1Pho34KopHY4WiiSTeETc6h9PPs9VBudX3NuRE7tUcpPfHQkME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juxPDnHE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juxPDnHE"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d96be7ee4so252925a91.0
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774798649; x=1775403449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2I7X0P3DI7fadOka+YVqnAjOHD/NIS5TL3Y1NC2c6/c=;
        b=juxPDnHEeIxEw86rNyvlLSZ5WSBPCtqQfvCAAlIgTTB3uIZP49lu2wHRAYqDLjCdEb
         ISLDNKUxC/Ke/XYAXoZ1OaS8X3g8iycLJI+fRenh1phhOHcOkaFf10dnQen8PU4ggCjC
         06431R5XueB+fMNFamGImotPvRWEwXnT2MNXnankjAoDqAVL7gMlrArF4YeFU2OaQ8p9
         Lj601tE4C7Tt8S1Hf2VUVCT+ilKYstoa1J7UVyygfOVQAKRgQiTc3q4MI95J2OeUO9WP
         xxP3N5GBy2EKWoXVeMrcqOCHPzgZ1kTeohTq9cNho6BHmj6CoNOPgA/aGX9Kk/yIvzNU
         5SqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774798649; x=1775403449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2I7X0P3DI7fadOka+YVqnAjOHD/NIS5TL3Y1NC2c6/c=;
        b=WZm3Lj5mMJj3AbPQLmWRA9gsgn9Emd5E1A0zXw4b9innPzMQUdt6uFEby4b+k6en6L
         CSzlWtD0AZPVty9X1fZzB1md8i40rXYHykttOWhEZDxek5h5RHVq9bUqy8RrUb1i6jH3
         bqQ9/899zFABTPa4OnnJTU4n0GLMzuWu7psl09ay3bPQm5T8rBZJlBgMmKDo8wgZ3LXt
         9QECn02Iln/kkkHHMakw6HTwXlGWP9A40CWLk0AdKihy3RKYAmpnmacAGn28zQoNDQlH
         Y2CPE6jImzIGSViWeD6PLCKZOUfVVpqb60AUmEtYKIsKwphgRqY0qWNnMXem2NgfY7Wt
         YOFw==
X-Gm-Message-State: AOJu0YzLZNEiVGFsJb0Veyn7fOF1HGaFWwsPfn/Gh4Fb6iyn40M5DF3U
	Q3NeyuZz03lMfRSGm/XOMYHOge7dC8v0O4BdcPNFmSBurs+pHtnLs8p1
X-Gm-Gg: ATEYQzw1IbFusOZZPUYGXaG9OhnWpNv0cdKOeIqK7Lmjawe6x2N3++WIKNgRqne70M1
	yTzUNTkC8yUO3oHrdrdyTDjNB5qDdrDngRkaL9cZSjLX1K3mf5PbdndJqW8RkW37JN2O4sEgeEo
	fyBc+Sh5UojEQercXxTbjgsWVuvNclDjlF+7+RaY3tWUj5QsTrK+IKprFgkq1obme2/qjgWHMKM
	TbcwNhiSVQD0FLwA/MmKAmTqgd3HKC17lCk37Ktx4m//38UpGBAD5eMCV3ZwstjnrX9OxQX/fAD
	fGDpDpLadTGpaS/D9lSX0swDy0jR30/MZQwzWPa0uQl6cfVv6XcgHjBgY6IfzhihBYnLXkzfjSm
	roozm0o2Tmys0YuZOzkyvv9wpYcRGO4mHgwQdlCdMeAJ1mNpeIk5uIXsMILIczCH95OvkHICtgO
	5bIcRvz5TkwXbksx2mAogUqoYZ+O6VP0XJs442lVSvJTGEDttiMRi7kdZqHpC/ro75vb+XuMdiB
	JeqEbkjNQo=
X-Received: by 2002:a17:90b:558e:b0:35d:a87b:ef68 with SMTP id 98e67ed59e1d1-35da87c00b9mr395253a91.1.1774798649520;
        Sun, 29 Mar 2026 08:37:29 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d94d057bbsm4616463a91.1.2026.03.29.08.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 08:37:29 -0700 (PDT)
Message-ID: <8dc0961c-cdc9-4ffa-997c-1120dc26e0e2@gmail.com>
Date: Sun, 29 Mar 2026 23:37:25 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] refs: make branchname helpers repository aware
Content-Language: en-US
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
References: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260328141146.1095115-2-shreyanshpaliwalcmsmn@gmail.com>
 <c3f032e4-d50b-4e35-846f-5f5da95f82a6@gmail.com>
 <CAPYXD64H654k0RoKDiU91dsj0Fr9mf+f46Vfe54K+zueMzh+0A@mail.gmail.com>
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <CAPYXD64H654k0RoKDiU91dsj0Fr9mf+f46Vfe54K+zueMzh+0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 3/29/26 17:55, Shreyansh Paliwal wrote:

> 
> Thanks for pointing this out. Apparently it didn't raise any errors in the
> build or test suite. Will send a reroll.

Oh, then that’s likely because the static libraries have some kind of 
on-demand
linking mechanism or something. Interesting.
  > I hadn’t considered this as it is outside my scope of this patch series.
> While the change makes sense, I am not very sure whether it could cause
> any behavioral change or not.
> Thanks.

That's certainly true, I also think it’s better not to make drastic 
changes. ;)

Regards, Yuchen

