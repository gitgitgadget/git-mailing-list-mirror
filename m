Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBAD4086B
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 07:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462662; cv=none; b=RdCtQZjvsckMNfEicg9icyF4Yq8ksj9j1Irxofp1MqiTWrtejphgys7jw6YCCsfs8Wr8PtLpBKz0yfaXyGbfRLkBr69sY29eGyXtMsPeGz5iYpQv86fSNgDYqddeUrSbqTcelow6cNGBbCT238c9DdQZS7J7n6WrmLQx09/gUok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462662; c=relaxed/simple;
	bh=D55yOs2XeKa7Tj92nOzoeSpIL5yMCAfvdPr8BrON66s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6aWPhs19nQGJGEeMJZ8mdeX8nnUEMbZjtWYcRJLxdJMHQnzAk8BPFUTG+89E7jdd1tMyMi00Cgxyvh4xnGJZOAiwJ9XpuAhlm539Wt/t4lITe7LBpdiGOTGbX7cG2yy4ZQhOTUquQPB35/PSuEH549CniWRngS7pV7mkb8O6GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDn6pJGI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDn6pJGI"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e3f17c6491so44305905ad.2
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 00:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714462660; x=1715067460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D55yOs2XeKa7Tj92nOzoeSpIL5yMCAfvdPr8BrON66s=;
        b=YDn6pJGIdH9MA8FQApdX+3VzJI7ohY+SLuIG05RRus8SW0H1Otf4dQ+hHqv+jjeTAV
         i+WC0BtT3U6j7c4KD+jca+ulYoeYiAu82Kz5lk0OaXRLrUxv1oXkKWaPonERBPlvwqS9
         mgVqPqxNVsJilzmWjSF+6QLx8fUWYLsnNV23VohpIedKZHHhvBN5m+aY1T2SQ5uD5Gku
         sh9ujH7nfvT2Ofvsr6JS3l1FwVo1oWJwSoPu2YBVhQv5bOSQIg1FTpC4sSzr6dpvJ6CY
         RKllwkl+ntRExYTNmDlHyfD47raNnzFzuLq7MWpRn3FjpRmATr3GegqYOueeDIQR5Iss
         +0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714462660; x=1715067460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D55yOs2XeKa7Tj92nOzoeSpIL5yMCAfvdPr8BrON66s=;
        b=bRk8YFrglHytlBqa2xS98LAImU3sdKB1Mnk4sHxR1Ci5jgftggHc8k5UaYMMYWRtYs
         hk1fznWcoERmyZKCP16ZK8LGvl7yy+RrPv5Mt3ZWqzzz829Zv1IocL2BFAKgavrRZ3V9
         rYZZkEl8v/wvQs8N3NL8ecKWnpYEmC3aSGbcNROt91nX4y/0nQIinbRYCNPaYZIyvHL6
         28RywwgjWdjdXUcxfn2AoTXoBCuBc5VSqlF3zPOuy5gIIVWKRXFVrX7oqXYbBtCy5R9Z
         yMHMOpT7qCPhe30e3C/80VLsGNLN9AEqXrzqE2V/KjzhckF0iqL1VeVff0g3uj0HKzQJ
         OWHQ==
X-Gm-Message-State: AOJu0YwmGBRE2feOiXiE0l0Nt1Zekx/+QePYLng8y7Phx3AX94d+FnvE
	DpSQ+GIkAKr1+/YZr6lbLS0n0pldCPanfGZpqLTmJ+kberffV6d52qIjkh/QI38=
X-Google-Smtp-Source: AGHT+IHZwzhYFBlspR5djbcyRNYg7sGUDxEVOHndKL5Lzz+JRhMg0iLEwqIAU16aK5lkgqjnJFSv1Q==
X-Received: by 2002:a17:903:1c7:b0:1e8:2c8d:b74a with SMTP id e7-20020a17090301c700b001e82c8db74amr16238631plh.10.1714462660238;
        Tue, 30 Apr 2024 00:37:40 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id kj12-20020a17090306cc00b001e558d0f00esm21753833plb.82.2024.04.30.00.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 00:37:39 -0700 (PDT)
Date: Tue, 30 Apr 2024 13:07:36 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Matheus Afonso Martins Moreira via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Matheus Moreira <matheus.a.m.moreira@gmail.com>, 
	Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
Subject: Re: [PATCH 12/13] Documentation: describe the url-parse builtin
Message-ID: <55mpyq542lyaxc7zmgyxzsbugwhzy7p4j5plbmnrbapfuncved@6macxutkszws>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
 <abda074aeef2ffb20d2156b5f24f47745b6f3134.1714343461.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abda074aeef2ffb20d2156b5f24f47745b6f3134.1714343461.git.gitgitgadget@gmail.com>

On Sun, 28 Apr 2024, Matheus Afonso Martins Moreira via GitGitGadget <gitgitgadget@gmail.com> wrote:
> +* Print the path:
> ++
> +------------
> +$ git url-parse --component path https://example.com/user/repo
> +/usr/repo

s/usr/user/

Thanks.
