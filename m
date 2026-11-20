Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795210658;
	b=MM+OUfifAN/0Q6brSN7rLfIwRvXlg50uvfq6dekZiHGJndMCRy2W2P4xykGaWFBAVXO+
	 BHbVUCPOI1EZ0v2tTCqen4DFBfQeJ+4QTgFBnQ8A8PDpPPank3jP0k4pNYpwJg/lR20ZB
	 rkQex2ds7B8j/d3bRaHfqz7KpNP9dPxMUFcpYHDiSUJecRRQVAcBv8ZqtH62a5b2b4LsP
	 UwvkXMFWk99vMVpZNlJVfEDpO+Rcbn04ZtLvo1aMjdVOcvL5TVsYAss0oBOT4GuYGWTj9
	 0SzUNLBQjtcaarG0S9eMiNRsQ+lx/s7AfEdWW+WuQvC5WyGDiX9PUGLRdtqThD5lC1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=6jeAFoUi9Skc1CRe7MrmrxxcLRwhvJswG+uGCOhXgoE=;
	b=5PiptqcK+0CVoc6l7NG4KVQbN8MhChLNfjL2JBoUOi4VmnAL8W7X8264qsu7fjOZN/vT
	 cbppparvqnNonz8NgAQA51x4GlNhKtVcNSs23oOzoUfgmaiXy2Uig/V7VElczkiva6nI/
	 o9o2NSXHdZ0FojvdWagtEOWsCWGmxIPbsziBYr4trV94iKc0VlxG8otXfHz9QjEEMb3jk
	 p46chsPpDC+jXQofd46QWQttvkjlN4prdOqOTUOBoh5Cv6agSIUm8EeElyoaPZMw+q6d2
	 CVtz5NniDNpLLznMODPRdtp3AAcIQKcHLF4DaOE+N0jnYkZkcw1pU4bRS0Ezz6hkG4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hm62UBZW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF23606A686
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 21:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CF23606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hm62UBZW
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-483d290f398so838649fac.2
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 13:37:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795210657; cv=none;
        d=google.com; s=arc-20260327;
        b=sGu53pTckXuxcYZqrKRXpzl6oCeOC7A1y8MBAv4Qjn+imBjFpfES4ZQbzSRGLytw6K
         8MwuDmQ/JWhFXsz8Z0jFUkxsZjw3oTSGdqYYMHungsLf/qTo6xrFFDTKKCMAU8JPAyCn
         4MrxmWg+maE2LqAiZ3eBR/MyGpdfut5Blo+FivvHYDrQDP69iuv7VIZda5ux554Zf3GO
         LmK9ATY1KhWMukGEJanlx2In0EXRXL9LJmX6XUTY70bN1/1m3ybyIArBAaBG5Y6zdF0J
         wQedsdNPOI1WjjJ9GyDhYXyRReHZp91IXSJqefvtvRPiQWrNplhhnMz7ROU4OVN6dv5H
         8++g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6jeAFoUi9Skc1CRe7MrmrxxcLRwhvJswG+uGCOhXgoE=;
        fh=Xr0hC+TY2YJbd7PvDyGM5UqVu2l9XP2hLy0TdRHzNcA=;
        b=hAbYfUUJtJ12CYw7XgkCVd21Xfvd86b29RyxA6B/fYM40Mt25n6n3NPeU3nI4XbacO
         0rM0WuFG2eP5Qy7Hq3obEMkUPTT8Lfhoa7awUmxeQv1LH/FzeI4Kq44NxKg8LHpItjK7
         XPhXZP/Nkj0S7uSJ1NAxEc0XXPKL63m+kKyHt7DJPOgDfjFbKqQ9FSNhyt/O/tcRoAoY
         ZEtuZDVdFpqy8XAhk8aB4o9j8m/2dNiG9mzHd9QCkvDaDnFhwV/Kb5BH/3VLP7hZYr8V
         qMNGLKeglauwqR00ytQv/rv2/x2jVeska16gA7BTEl+W9bRkJ+n1rnuO+MngFSQgBRHA
         poIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795210657; x=1795815457; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6jeAFoUi9Skc1CRe7MrmrxxcLRwhvJswG+uGCOhXgoE=;
        b=hm62UBZWilZu1ENnYTvNOcqjqSsh/AtG9uPxnxtsUX3LKZ7zMH4MsmRELqwNKzwbfs
         47aWatuscNRnFKoxV1vhbic8hDoP4No+S9fN81rahBy3sVxQXkdvfQNnXDvfGKu0rYqy
         HI1X/HDzGGzCUUdZGtWkzuSnKwS6+ruWIZE4lFAOVomHoi0kX9Pi3sevo3ZJDPd+bfGH
         Gz0JzJS4XuxeVC856F1CJOCeDt8szUZ0vf5KYOotL1nliOoHIxGW+1X5TDuIVQSjaZKU
         iwFG45wQwkznC+ot/jhy2DztBHYEk5Ic8na0bOYG2+K6+C8NbvcUcNx5mRBZTIDTZj2V
         Zdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795210657; x=1795815457;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6jeAFoUi9Skc1CRe7MrmrxxcLRwhvJswG+uGCOhXgoE=;
        b=ejepDvEj+Zkz841VnnncE9ZhMu9KqmjMMvL+p9622R2GysXmzRYzxKE8V1yxV93LGo
         nP8RirJ22wnOEQlaSxFvjSWra26E41MdN3RMW83EWbZwUCcd4FVPERnMI/IcXQ0DYZPy
         usKIWfCNs40Xjl+xbLLi/UPHpWKADD8jDpHvGJRHqGuuEUcxcsLvYlN3qiY4EkvMPmzk
         ZQUunyv5pnd6GqdWZ5d26FbuRZfXiW7I9yeVqhtznsWmsVLinThcPeRx7rWIaQ8UJ0gJ
         7vvlf0otZaS5hrzfVMyCySws9XLXyADfPqxdHBmWAqVWxXdSwvIgWJI4rtTaOzNY5zZm
         s/3g==
X-Gm-Message-State: APuU4Z9hafvM4k63XKeuuMA6Xn+P0UPeGmGNsH1YyugOkiKI6NyPtXFu
	lUoZk9Jup4q2tUZDjcGS0JLNZccToHe4jN1F4tONYSc4KBuQ9PN2cDFEuVEXZvxySIOoHiFz44c
	EuXOUaPQEFoLERPVOFJIXw08GnyJu3zQ=
X-Gm-Gg: AZFdTZerglTGdcmyAogk0XQzeKLBnUUqGDAe86+tMwx6ztyk4uXEpsgUBw+Q1zBgMYV
	8SQCJjO8ppwb7VgHTAzH7vss7WUrCwKTh29ue2OkVKyqq8UMkL05pcnsIxDPC4jCRIeCJc2jNki
	HOvHUYwrSf/d1bzd9wob0bMJhe5ehIFbBCo6S1H39PtCzcbYEHI2tpn9D4S3SMjcJ0jTN1FeO6U
	nyqVcsFjnuP4apo8yMaNFyzZqUPKcWOKEVHdXszJv+pQXBwh2MvANoyfu3QZCXW+0ghl23yw6N7
	GkYRtRItTLH/9PQL5sT1GpcVCshVxlXHnVKICidm1++0t5Zczpuf763FgKhwutGYpaB8+gfUcC0
	bt4/oUAWEpRM3KWALAZfqZE2VLVgsEm8juPyzoFD/VzLeDdSGHccLlFxrk5SDnAJrpzba/YTuPj
	RtfQC1b4DF6xsU+wiMoEe9D7eoD6O7O8PrrczstwDtGT0NSS8B8vif
X-Received: by 2002:a05:6870:f621:b0:4ad:9182:beb1 with SMTP id
 586e51a60fabf-4bc7d6652f5mr4477965fac.7.1795210652410; Fri, 20 Nov 2026
 13:37:32 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117174353.1158905-5-christian.couder@gmail.com>
 <20261117174353.1158905-8-christian.couder@gmail.com> <CAKrRMNqMRkkb9+n+11p04YDhn6p39uoc_Upc9voYhZZoLyPXBA@mail.gmail.com>
 <CAP8UFD3Yw0kshhQrz_5_PKCBpenSHc1qNTEh2bvz5HkSQ1NYPQ@mail.gmail.com>
In-Reply-To: <CAP8UFD3Yw0kshhQrz_5_PKCBpenSHc1qNTEh2bvz5HkSQ1NYPQ@mail.gmail.com>
From: Tanga Joris <tangajoris@gmail.com>
Date: Sat, 21 Nov 2026 00:36:53 +0300
X-Gm-Features: Aa3M54p9I3DhIoJGlP3V21KEEz80Nfuf1NfoMBdPEcIuwJIWuQgqZ-gXf1uIbv0
Message-ID: <CAKrRMNouFnMx_mGWmFARbB8=KfY=M37N-HdrgHhh4OuTepMs3A@mail.gmail.com>
Subject: Re: [PATCH 3/3] xdiff: drop LONG_MAX check on merge result size
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im, 
	kaartic.sivaraam@gmail.com, peff@peff.net, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"

You're welcome Christian :)
