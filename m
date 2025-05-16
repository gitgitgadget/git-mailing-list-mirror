Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B97221273
	for <git@vger.kernel.org>; Fri, 16 May 2025 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747429075; cv=none; b=JghgU1mjFEnFcDbGbhM/zhIDo6Gp/hORDf4ovCiojgV63lKpPXQFtf6fcsFZoFaK6+Y1n007o12ST5F+jJVNDea7Viht3eJmVb+xNCgTFw8sazuqsE7XSK0BZVKTF5+poZzGBvvKgCYpUxVm4ikk3q1CvOFTZ7FGNLgTaLUuDIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747429075; c=relaxed/simple;
	bh=pEYH4unRX/pb7WyKYiFQIMqzQrI0SU4KWMqdxsp+6kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blJ/eh1wZc4L//7X6/+0BeeOeHvHfCTj9oliLZXq8bGFFgE8lhbv4O01UvVVlSEC7lmfy8bgRcitvibSQir/dDAFVCBOlPyl5ren03QfU4/e+nZ5wFdkN2g+VhefHaLID3nYEO3BENUJ0v2qy/fu/MDjEOt+XKyb3vmE/tNYnas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=egQila3l; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="egQila3l"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-231f37e114eso16985ad.1
        for <git@vger.kernel.org>; Fri, 16 May 2025 13:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747429073; x=1748033873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQHxku8AGm2gl8CsR1f1suWDNIwnrbpTkYSiCElaiPc=;
        b=egQila3lTnwTl89LZ+fqoX3Of5rCGh0U0GbV/8T69xwA1tw0vRBwyWfdQLvW28lCkW
         Shfpovae/PvK74pyuZvTrmFT70Jgax2VxgUxmPjgBwo0FmQmab/epem41uaU9bwze3Mk
         Fe9Mx5v4EE1NOu9co6lUQ/9iEhCcQETty/nvRnnTntBBvyD25opmFArYlUP2QJReTs5d
         jQZsHoidYeRxsREX0odDv2MU5icyDCEnE0N1VR/K9ZYDRlJJmzmfhrmbDU8BeZ8avyTP
         1UWvnCRDgcL60MPLNKujsMB9InlflZX2nGgQRbm+MWJvG+kmv+N28LMmYelKAdErUtb5
         r21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747429073; x=1748033873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQHxku8AGm2gl8CsR1f1suWDNIwnrbpTkYSiCElaiPc=;
        b=FIGb+ayMgcxZhYFrsPrpkN36cNpJMbG8kZSddoV8W5nFySZdWCJINvIKJOErQtYZj+
         2QU4Wtz2sk1lu5jltfqCZfaVtAK7RVoDIoJkcZ1SUXeA3nSVndRU5r0KSOggD7fk/HvS
         KHy268/yyngdxiPp/Sdctwf2hsG/U8OBObdO/rVjo1Y8sWp/RD5axObFFym7jnDd3dhP
         5NGvPXGK8sk+1NTS4NIHCZvtjGa6iui2V9AuRj0itm095qLHwGIIwFiV5m+V8BO3FS5g
         D/Dw9zUWBrkGM+qKg54osYGScePan3JjzeZ0nwcd+Qhm8weY4i+fE2Lkrb+1uQy3LghG
         sslA==
X-Gm-Message-State: AOJu0Yw7kTIqRoS0yfVm2ntxNFiIsCt5cQJDpB3WdHU0Q438B93Vs7+g
	jP/F47YWwgv4TOP/w/YsgXcgr/3mo4bH6BRLhYhxn5ZzCYLthkC7w9Ts8OdHQxcAOg==
X-Gm-Gg: ASbGncsiQC2Sw9LQZpbvFoUGS9ImAAFyjwlZtOFWh5I1ADyDdJHspj1UhxCIQqtgrQB
	69EGP1cGh93fcLfv9A9qznwHQeT5g8oHPvOrNa6LRoVjxRFyVZ6jsTCkX5l+3daqQ2dpTAeKsTs
	SklNZ7HY7MAlNzZM1l4Iqb9JzGqu+B/IHjoNGQV5vXWsk/W4sl9lOT/9gG1MFKAZVec+MMjnlyJ
	xXfa8j6yT5FCAXDB1eY/dQ+0xUTIw7gDFA+1P1JNjFa/8QZJHq+H44A6o1qy4LJr8H0k3mlo1f2
	j9ltSxi+Mz/EWvLQr6HCIrBoe0o7Qsi6nQNl5DTZB9vvD7MSO230Fj7LEkA=
X-Google-Smtp-Source: AGHT+IHj9iYWRoQtWwuYKBNTfLRYWFvEqmB7FZHbq2YIiFE3/+AB8U0BVnJBLYTGpQRvsfB3pGAG0g==
X-Received: by 2002:a17:903:11d1:b0:231:e85f:feb with SMTP id d9443c01a7336-23203ed27b5mr132995ad.1.1747429072460;
        Fri, 16 May 2025 13:57:52 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:8ff7:6c9:7fc9:b9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a982b86esm1928834b3a.115.2025.05.16.13.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 13:57:51 -0700 (PDT)
Date: Fri, 16 May 2025 13:57:46 -0700
From: Emily Shaffer <nasamuffin@google.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 1/3] docs: remove unused mentoring mailing list
 reference
Message-ID: <aCemyqUnLBZc4gyy@google.com>
References: <aCeAIqwvEVOdrsMg@google.com>
 <20250516185516.52311-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516185516.52311-1-jayatheerthkulkarni2005@gmail.com>

On Sat, May 17, 2025 at 12:25:14AM +0530, K Jayatheerth wrote:
> 
> The git-mentoring group is being removed because new contributors
> now approach the main mailing list directly and
> almost always receive responses.
> To reflect current practices and avoid confusion,
> references to the unused mentoring list have been removed.
> 
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  Documentation/MyFirstContribution.adoc | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index ca1d688c9b..ef190d8748 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -40,14 +40,6 @@ the list by sending an email to <git+subscribe@vger.kernel.org>
>  The https://lore.kernel.org/git[archive] of this mailing list is
>  available to view in a browser.
>  
> -==== https://groups.google.com/forum/#!forum/git-mentoring[git-mentoring@googlegroups.com]
> -
> -This mailing list is targeted to new contributors and was created as a place to
> -post questions and receive answers outside of the public eye of the main list.
> -Veteran contributors who are especially interested in helping mentor newcomers
> -are present on the list. In order to avoid search indexers, group membership is
> -required to view messages; anyone can join and no approval is required.
> -
>  ==== https://web.libera.chat/#git-devel[#git-devel] on Libera Chat
>  
>  This IRC channel is for conversations between Git contributors. If someone is
> -- 
> 2.49.GIT

The contents of the series now look good to me, I have no problem with
them being merged as is.

By the way, when I look at your history on the mailing list I think this
is your first multi-patch series; I think when preparing v2 you forgot to
include --cover-letter in your arguments to `git format-patch`. On this
list it's more typical to always include a cover letter with multipatch
series, which you did with your initial version but forgot on this one.
:)

I'll leave it up to Junio whether this is acceptable to merge as-is or
whether he needs a cover letter, but all of v2 LGTM.

 - Emily

> 
> 
