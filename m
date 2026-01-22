Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6A8318BA6
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 00:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769043552; cv=none; b=gwcCm0dTSyb46DhbOpWvVmdN3irIjRsqYkVPiCPbtoPEV2/og9kqxVVXWD7REL7/jvuolZkFMY4RIssqJSJWvGFeO32nairl8jGQTE4XeNrZrInCn9kybxBoYIq4KPcsuJH6AYkJHIXW4FEf1+9Bk/4k4fPpYFwgiK3D3WgAl2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769043552; c=relaxed/simple;
	bh=DRJaqCVCa3VvDJJZUesRpVji2W/m8qfA33mluMMKaRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMC001l0TFQcC1KLejFC/05ag6XNcrtR8Ybk4NZp8wQ/sLGPZ1MvXSHZ+TNOajP7VDeAE+Hp8kjHxRLBrmo3HdK0zQ5FLkL9ypTJAY43twHWFd/sRcDsybDuWCy+fjpxVmX2fhemFyI/Rqe7OgdHPu2QFm+ZYH5dETPkLcOrUTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaAj/TzF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaAj/TzF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47d63594f7eso3547105e9.0
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 16:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769043548; x=1769648348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0sa3EA7LmUK5q48tLhQD+1UAY0PuCR2/3PbtkUXDa8A=;
        b=EaAj/TzFtbjzIHF7SFE/wEnJxKvzcqgQ3lDX9dJpaPSh+IL5vGHAdh89KPu+OreKMV
         MxyLdIA5Y/iTDj+kAKYfmB+zCv0jkZzhyfVLd+D55s2wm6/3Xayk1ej3IwgyPaVUOYIt
         TVgh8bhN5mwkK1Bzelul7AdjRcuHk4EKuublKGQWt3RKxvXE1foWKfDsFpPBA2DPmeGC
         xNm1rzN3kTl+ZGMFYXC2U5nNn8LZUJBEKG5FqP3Go29lIvw+cf0obKW3f9Zu6rXkkG9q
         L44zXQmNbO0trxNxihKdeywcJTnsMvFNnXb7HTBhr5KnWaRzQb8PlwAAjU1LegkIpSCD
         6rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769043548; x=1769648348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sa3EA7LmUK5q48tLhQD+1UAY0PuCR2/3PbtkUXDa8A=;
        b=kJzeL4/b/ecXHU5yPc/3gYQpflswexQuu7J4ccm5m8NxlYg97X/LpldRMw8vpIc9yX
         an1GCbykVXsiMnkN7ym3nyKTviXGq/ieB5GCGBCs7TMEIj1Mh66WSKmftx8UVwlMuDR3
         UGxawyPm4NplwNHOgvZdtsfIqCBConBilzh1STBYoDvV4HjG45AbjpILyWfz/2IyvhoL
         cUNvL6s0J0wjStoCv1HOFVrtKoZxcR5LuYGqOhzPtKB+W1qQGR0+jU28MGAGS8df5t53
         0vnt/LAP5UUKazEIv4ebwopxbVvb4Uirwz5xOZtk2eZeDSeArqscxZTlRK3+r/yH0A1q
         ZOMA==
X-Gm-Message-State: AOJu0Ywjz4lEXRjo/bfCrpVRE45x4pv+o9mqX+Bz5SWuYZJNULTBiEna
	yeZXRLtvs39Vh/z4el0BbSePL8e3rQl+HOpmYdXaJTLUN2x8N9iymsvi8C42/0J1
X-Gm-Gg: AZuq6aIHuOVOqofKAKv+KbYEFVKrk/VIFojp55XCo9jodjA6nMcZTuOFhghHcAWVLlo
	h1B47Jwd5fDA0yXcCJTi1j9IZCZfoEUMlm6MysGXkR1AajKT+Z6HRxg2cGbOQ9XMeTfSForSi6i
	Yg6YDQO0dHAGgdbe2bHRh1Rm50noQ7UutTYPgaOa7JNQt9FhsjelDXaQyt1gWWWjRDQR2etHGGj
	vHS/qgxeI+LgyeP4KIqPl9l3lFMAWO3k7nAFyhxTL3Mf4VCiiNEtQmHKQcycyKB+MwyhQj4AL02
	HE2QBhtf5HZ/H7ETwhMSJsly+Z1rTXZJwJqV15hw2C9Z6gm8+/8vBTX3IXoGOkpLFyiYdIggbLU
	jlLXQWOVavaKBVwrBoB54Eqjr49T6FZG2/njM++yK1zimRmXxnsXZ7OtGfRCpSfGr1IYljwv4dL
	N3Jz3JCjmwKW9FXyWem0dT
X-Received: by 2002:a05:600c:35d2:b0:47e:f481:24b7 with SMTP id 5b1f17b1804b1-4801e33a871mr348526955e9.17.1769043548364;
        Wed, 21 Jan 2026 16:59:08 -0800 (PST)
Received: from lorenzo-VM ([84.33.162.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48042c38063sm35325165e9.12.2026.01.21.16.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 16:59:07 -0800 (PST)
Date: Thu, 22 Jan 2026 01:59:06 +0100
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2026, #07)
Message-ID: <aXF2WtWh5RV3wGgk@lorenzo-VM>
References: <xmqq5x8uu6yk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5x8uu6yk.fsf@gitster.g>

Hey Junio

> * lp/diff-stat-utf8-display-width-fix (2026-01-15) 2 commits
>  - t4073: add test for diffstat paths length when containing UTF-8 chars
>  - diff: improve scaling of filenames in diffstat to handle UTF-8 chars
> 
>  The computation of column width made by "git diff --stat" was
>  confused when pathnames contain non-ASCII characters.
> 
>  Will merge to 'next'?
>  source: <cover.1768520441.git.lorenzo.pegorari2002@gmail.com>

I would say yes, if you agree. The patch seems fine to me, and I
wouldn't change it in any way.

Also, thank you so much for your guidance and for dealing with my many
mistakes. Now I feel much more comfortable working with a mailing list,
so the number of my mistakes should decrease sharply (I hope :-)).

Lorenzo
