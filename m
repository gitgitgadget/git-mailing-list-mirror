Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A411CF8B
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741788190; cv=none; b=h3in7ocuGjsQ7TYhnn1EurEhyKCltf08uKRqxy/j58iJLLfQxqoE7nMx1n+Vg+Gztm9hao7PnxS7yE+Jh25Hpp0IWh5Bc5mlgc5mOyvrc7aMVf4X52i1vvUsT30onJEeNBK1PLsJUSFSXTfiuEUXy7CnOKTu5hFlmxFnstYh33M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741788190; c=relaxed/simple;
	bh=GDiyMhYbOgga5kiZRCWnjikzHwbjyRvBHSxc7QBorN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tl3nozV/ZpwrTcciuYhTFqWaqJ0zR6TKmatMVtlZhVIGrE1uPeyxu7kwMoQWQDzyPy4IGPOCm9ro++zIyXK9JTg66VfbECpVRIwEhvSojsRlBm2bHHDNHowCZX9V6/y56505ObUFl2TxkOCxJn6GyPfLbJSxK4GCYvt4IUyWg+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICurK7sR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICurK7sR"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2240b4de12bso39597415ad.2
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741788188; x=1742392988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p00HYftMxP6W9E3Q+5wk9QT37g2cMGhsOTTPsE1ppws=;
        b=ICurK7sRMqXaVhuYmQiYDVvBpmW6qFrObB5ryY+Vubf1pXONwo/Zhfpq68dyv1WCD/
         u8q/DjGnHovG2vfZglMcU1tMOl9gTx8mH6+mtOPwrf63hw/JntjHTlsRN5WQbljTA3LS
         FiqITg2jR6C0nZ8YA07OzHWM9PdPqg6SKydjNKAUcroV0SdPYCMRsN4QYivgPZsul8Lf
         T9FIj+YfzlbT1yJebhiT27VjlwU9eStyUJnsHlgr05nlNbhsHFI7oAXp3BRPcYxVJHfZ
         /u6W5ZKfb3O7HXTV/TcFbOgw9Mu/pbxlXg4xsJaLqruy1hrS9PRtvlEv7jhAWT4owjHg
         qoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741788188; x=1742392988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p00HYftMxP6W9E3Q+5wk9QT37g2cMGhsOTTPsE1ppws=;
        b=I72z1dY5Qw2aMNPhiyFZs2lm4j/46lBjY09l/IIlQeNv7RcrkTGw4btQ4COVz0T1eH
         rkOaZBosSSEDRkj/f99M4D1GVXoTfYpQEQSteYPQfuXUcfwAP6X+xQkvWRfEd7nlP4gT
         Xk+H6G6oNxQGY15gnzyulR3uYC5E4WV24mo5JwAFKRgnz0+g6ZxJsnhEEoXu17rg+m5c
         IHHR9yj2tjxLGxyUX3e08fH8VYAuvG0kHV6dEawhh17Ot+LwUH/vwCnp+hoY85FuTy41
         EV99ywBq20GD7yy9418GWAAPnyH6NkN2gpSX/s8DKzXRsubCFLkbuGJ9bhH4Rk3FtLBl
         U+ow==
X-Gm-Message-State: AOJu0YzWKgaV/2RSraarElaCDuUubBlS/wTXPjkHNRZNXv827TDtWj/l
	76L3WyWzQxccLsyxpxnLf/ExQam7auolSwA6PJDWI65Kbin+MKud
X-Gm-Gg: ASbGnct6UKkFbftG+8LEAibqGQD35SMfdU5Be2aqZCbVjAq/yrhdQ7VR1zqppOWzMRT
	VCJfi+GLtOZBfwcWz3p3r3OQI0T+dWfhDBeQHsYG40x9oXf0OpMpXQNoOQCksJx0rQ0YLHNhtlu
	zOpdihrEY56sHYTqU0HSC5bdQv3Y6W0tXTVycnA8MX04CqN4njIFZBufWAZOXuk2bqev9huicxd
	p7IZfjFd1RHi6AyRa3bgCsHAVr+25W6vXVaI9Xt9htNSkLCzWrFoB6Gtwk998TBbxvxRqqmouLx
	WvC49XEbxzf2DVhM4KmRe0+mGVBv5Bii29DNMSBoHf5AjdIT9pE=
X-Google-Smtp-Source: AGHT+IHnQ+dq637FqDZ7JqR/TdsLMNcCIBcjHJ98CHGy9x0mxpg2VV4qq+r6/nYzVAB9qk9SYEXc6w==
X-Received: by 2002:a17:902:ce83:b0:21f:c67:a68a with SMTP id d9443c01a7336-22428a890c3mr375002525ad.31.1741788188202;
        Wed, 12 Mar 2025 07:03:08 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3011823502esm1792971a91.14.2025.03.12.07.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 07:03:07 -0700 (PDT)
Date: Wed, 12 Mar 2025 22:03:18 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 00/16] refs: batch refname availability checks
Message-ID: <Z9GUJliUPpNPng7z@ArchLinux>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
 <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>

On Thu, Mar 06, 2025 at 04:08:31PM +0100, Patrick Steinhardt wrote:

> Changes in v3:
>   - Fix one case where we didn't skip ambiguity checks in
>     git-update-ref(1).
>   - Document better that only the prefix can change on reseeking
>     iterators. Other internal state will remain the same.
>   - Fix a memory leak in the ref-cache iterator.
>   - Don't ignore errors returned by `packed_ref_iterator_seek()`.
>   - Link to v2: https://lore.kernel.org/r/20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im
> 
> Changes in v4:
>   - A couple of clarifications in the commit message that disabled
>     ambiguity warnings.
>   - Link to v3: https://lore.kernel.org/r/20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im
> 
> Changes in v5:
>   - Improve a couple of commit messages.
>   - Align `GET_OID_*` flag values.
>   - Link to v4: https://lore.kernel.org/r/20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im
> 
> Thanks!
> 
> Patrick

I don't look at the range-diff, but review again in this version. I
mainly carefully look at patch 1-8 which I haven't looked in the
previous versions and left some comments.

Thanks,
Jialuo
