Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961C32E7394
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400010; cv=none; b=lBFMqqIOx4UGJhJPcJKuOEP9jmLVKk9ar55Jt4EeDdWZ0vBg3QzvKx+UrqvUkYjh+cUAulmXEWTdm8Td+WEJHuJkJRyuMdMBb82SUNMYbEsbjKAcO53qtTbQkzfEGqQNDnFghOR2LdRcYDgkILDmJS90gpTUE0g9frTpQCeL/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400010; c=relaxed/simple;
	bh=7R6gty1HXboUEi3vuQq5f7Cxi/LnM0gQAINQDqGrgdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+tJKS71sqM8aiXWH2gx/jFsz4xgi9cd59+6lBIYECYI3Cc9QB8YXLxNX9V5d+IbfO/yQGf1zAK6Rw1bmtr48fV++voW0OP2LDDWe5BCS4wxvIUcoz3zuRYKT5q+Q7zBj5fd71hPp91b+h9jbWt8+IdWTb5Mxsv/pUIS6P9Tq5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwAU+GFT; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwAU+GFT"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-662dc387b7aso2674187d50.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 08:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782400009; x=1783004809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fFc1upYjakvJI1kXBxUXTYb/MbTvZL2VFZR0V0z5sDI=;
        b=LwAU+GFT0WukiesUh9pa+ygRloEzuYKTA7ixaXRPgAEaX1+G9eSnfJq1xwVqXptkkD
         0aeMI7iAiZsV6mirQz388aj62wAzxuyKgUcP11xYv5VfPLM+lYWCjcwAy7/kh601Cya3
         7Oz/JM6k/mUEBqaPfH4yIYoVoNuEcwmD52woKlPUxoeMgv0LK6HStLdEtK+EKQqWXfEj
         AjqYsMinAD+L3x1U8+33B/HR1z8zX3xYfq/mWTdE8fL5mXIPqmrQlpP7GB6Wd9PIjKFm
         kilJp7nBOtTj/7JL6n1H8y4pKZda8S2CR0oczhcbk+UsihVBV0vkh5Y2+2M0BarluQyl
         1V/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782400009; x=1783004809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFc1upYjakvJI1kXBxUXTYb/MbTvZL2VFZR0V0z5sDI=;
        b=JVTZJ8ROd2uD4sVxx7P6j7mEcLLYGwjkXXcMWv5u1lMARze21PCG3rt9MczZBkETAY
         veCu0OHDwrh2Wcc/evwt0gRAcKwMRysc0eD4V2/TLl26q60z2v/qmMe+dpJ7IT6iJBsh
         tFJcHlu1EemchgHFWAlFiaXsaQH9Vdnd1M6zXj4MVuJQDARPd+g09d0k3QVgTO3Axpvt
         MOCuV35zv3diFTCfKP2YkcHxByw9Yq+uLuUZCKLPTnVGXd8Vt7mulL+P6sDMNzKnvU2i
         7puLVVP+P/gsmeGwzPHVY/+ixJV+fce5VbQxhd7vgTotzv996pvVTxTqprZlBJ1C+A5g
         oesg==
X-Gm-Message-State: AOJu0YyA9KwEYqA0FCmwcZlVPppP3/GK23ZYarWhSsEXgGHRh0vwUbAM
	z7s/kxKunlNkmvp3ecR4ZmuB3djclna6xO9X9N5+98HMOB0FNGcLO92ZNZEeXA==
X-Gm-Gg: AfdE7cly+YY6dJhsHWySi22dVaJGdHYPLnaySJC2PtWDd936cOnPkBqAc90NPAaBzPO
	MgVot/y0kzZQkaWDjjc+p6LRoKzrNZ6Z2vGIoP13BX6dJz/b76cjHUVpMITQKHldM8f9prV4utH
	uxkjuKWCYxwC5O1/IEilv+VuNa2bD2sc5WTZ8TSR7jA8LZ4c7BTO0sFre+b9orFpplH7Hndm+Ke
	TmXQxo8dQqX7JZVT9pKDuCuF6Wa8ecMvJ1RqEAJuEUWfJEWwkJtQaJ0Ug7f4Z9QVBnu7eEhvcjw
	jErXgpo3Kcuo2nI6PM0jEou+wIJwl658et9k+vLVQzC5UxMIJCl3I1JjE8+0xxeclN+FYbAeiOd
	7Zj0GCO6hT1O4TSYLy0Nv7pErmzfK1NCY6ymqMJkp5KKl8/TGEAvaWNoOVdwcxh7biRem90vYyF
	amMnsO6g==
X-Received: by 2002:a05:690c:c4d0:b0:809:ae5:1d2f with SMTP id 00721157ae682-80a67f00cbfmr26300447b3.9.1782400008522;
        Thu, 25 Jun 2026 08:06:48 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-806f94bc67fsm34538547b3.27.2026.06.25.08.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 08:06:48 -0700 (PDT)
Date: Thu, 25 Jun 2026 10:06:47 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 00/11] refs: fix "onbranch" conditions
Message-ID: <aj1DuUzusBUqmF_C@denethor>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
 <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>

On 26/06/25 11:19AM, Patrick Steinhardt wrote:
> Changes in v6:
>   - Drop redundant condition when setting the default for
>     "core.logallrefupdates".
>   - Leave breakcrumb for why we lazy-load write options for the "files"
>     backend.
>   - Fix commit message typo.

Thanks. This version of the series looks good to me.

-Justin
