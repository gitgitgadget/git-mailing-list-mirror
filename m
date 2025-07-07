Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570621F4190
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751895554; cv=none; b=emMYbdVjnAHJ9nfNd8f9uH7u6E/eN43/oYbwtScXeeOl7Vsw8K7FdVn1+fHXGqwxp4dNbk8yobhQ6yO+cXeGEvFIPhwrkIJz/NycLCrC+VT4YfoCqVV/RZW043BZl7Md2FgdA1BtZ2RMJKEM0pOeVzVay7sqxywJRqUId4I6a8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751895554; c=relaxed/simple;
	bh=l+yDg/NTazGKx7RQJY4hggfZNlP6QiTX0DavTJz8ySA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UVXSrqhTtrIBjcKQPYPUgnYusXbUaooE26zFM6RRl8hX9OBt8/ZoDPxDiGRCNLGyJh155MrdgkJeTq0w5ONyCda6OPnh9/LJ7aMJRtdQEd2ZznucYrc3zDiHFkbvUUNqYVBpnGloOErAyBjE4JUEikh5CmMWCdFUwD31/qW240c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbhCDBKN; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbhCDBKN"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74b54cead6cso1921016b3a.1
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 06:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751895551; x=1752500351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bn2R3TIeHhy3DxhRUtYZDxbmNVIEse4hB0M6oMc3dFw=;
        b=fbhCDBKN1ZXpPqInHQHV+GMjgmZ/3ptx1TDCtY+s7C8v1mImgMgbBONtELnMSJExfK
         C6s1oUsbLUy3K57jIfzxIQ8Xu1Kif5Qz5rpc0Zl9jZ4ty0Hfmil/rXBFLUeOqcXJYDVB
         a1e3yRsMfRBCBMqrxeu7ZMHCj5+Mc2GBeEAgRjYFjFVvIYCTMTo9Rs+6JrsSJYoKUHvA
         Vrpldv+sSQYJIeNzlBwnLeMotbof8rKPdSs55Pc+Gk03LWOxmJL6a6Hw3VJyXxM8VkwY
         ltB/Jlbpuucn7jT/5006nXvSUbJOYSAT6UuztYMlSM4+7A0DcMIG0jrHVCVniFvEd/4/
         J1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751895551; x=1752500351;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bn2R3TIeHhy3DxhRUtYZDxbmNVIEse4hB0M6oMc3dFw=;
        b=bv6yHRP9+zR7iY5PHUB2Q1PY5F35VGkmq4IERgSFA0wjbw3fxIUvIAsxfTRyCTsxL9
         PA26GNL77XITOScJuxq6u9CUILJRL52cx9DxwqR0PKgbm/kjd1Vx4e8WlxLZxks4A6YB
         FBSmXiGAbg87M/HerJ0FcC9vpDHE5VyF0WRCTlg3ttrQ4vbdGCteEzqIQww9kvqV5ybS
         KPRYGOWsNM/KlPRo+UubaVYrUzY2Nwk9+D7LOvSeezpK4Cv9flSUgUaXazEtfZgvJXRM
         jPEvG43I1QyBHgN+579ABct9gG7J1+Nwxt2Ec1QXWUH1UAzIcsYpmwxOSfYRHYGi1rqo
         BeIw==
X-Gm-Message-State: AOJu0YwVjTEyayc8APtm6KIskgDVGHrEMM0TfVFWMlt1NrNJuK5/2jj+
	2uu1lthLUz/l3YFjpgSg0UarptRP99TLK2U3T9Wl6ulVhkVFpzCIN7R9
X-Gm-Gg: ASbGncugYP28/fvbgJqbbhqP51lBsAmQGcVR0eODvlYWhfKklX7qrNbF4XdNYmkiKxR
	eOFDqnVNaenW4NQRXXFrn/lB0querR7eoS6ZM0h97QGPFGjuFM5Ah3k6Ti51JtCoWPrha7+fB2Z
	jUZY49S9oiZXi5P6ifZWFXxYJbrwgR0tULlplaWhWwK1LRDpdlXhvIt2WCLAfg3pWIUNO37BCkC
	q4BRE4wwLFNC0kSQTv3LK6xhNp5ITDqRz9GucD6bKfDEYOee4s9NOHHLPlVfC9z8qzKk5HW2E9k
	qdV2OrrDR0Exc3PVTK4aJCfkwJwyCl6YQZbK8Blu5RGFxGVm3Pe96Pd9IbL64vSUZ6YZXkWMMCu
	99G9AOQffIk8pNpAHDpxmCoV41Xs=
X-Google-Smtp-Source: AGHT+IHQGIGqElNF7OHKu4Et9FqjAqK/YQV3BLrcsAA+M9/spqm7s47NJMjUd6f8zL7LGux5yQR4bg==
X-Received: by 2002:a05:6a20:e613:b0:1f5:9208:3ad6 with SMTP id adf61e73a8af0-225ba1569cdmr21808583637.41.1751895551481;
        Mon, 07 Jul 2025 06:39:11 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b38f55c6490sm8175572a12.74.2025.07.07.06.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 06:39:11 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  brad@comstyle.com,  collin.funk1@gmail.com,
  pclouds@gmail.com,  ps@pks.im
Subject: Re: [PATCH v4] builtin/gc: correct total_ram calculation with
 HAVE_BSD_SYSCTL
In-Reply-To: <20250703080111.64276-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
	=?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 3 Jul 2025 01:01:11 -0700")
References: <20250702202118.48742-1-carenas@gmail.com>
	<20250703080111.64276-1-carenas@gmail.com>
Date: Mon, 07 Jul 2025 06:39:10 -0700
Message-ID: <xmqq8ql06ry9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

>  #elif defined(HAVE_BSD_SYSCTL) && (defined(HW_MEMSIZE) || defined(HW_PHYSMEM) || defined(HW_PHYSMEM64))
> -	int64_t physical_memory;
> +	uint64_t physical_memory = 0;
>  	int mib[2];
>  	size_t length;
>  
> @@ -529,9 +529,18 @@ static uint64_t total_ram(void)
>  # else
>  	mib[1] = HW_PHYSMEM;
>  # endif
> -	length = sizeof(int64_t);
> -	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0))
> +	length = sizeof(physical_memory);
> +	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0)) {
> +# ifndef __LITTLE_ENDIAN__
> +		if (length == 4) {
> +			unsigned mem;

Don't we guarantee that uint32_t is always available?  If not, we
should and use that type instead of "unsigned", I think.

Also I do not quite see the point of limiting this fallback to
little-endian architectures.  It wouldn't be called from any
performance critical codepaths, would it?

Thanks.

> +			if (!sysctl(mib, 2, &mem, &length, NULL, 0))
> +				physical_memory = mem;
> +		}
> +# endif
>  		return physical_memory;
> +	}
>  #elif defined(GIT_WINDOWS_NATIVE)
>  	MEMORYSTATUSEX memInfo;
