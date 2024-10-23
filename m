Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA32154BE0
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729714824; cv=none; b=tMObdqe8n5rBJfIOZhHVhuuitrsiBdJaMRdrUX+lkEyT/qBslkr7g2GcVTSZUWhdPVHQ+0OPVUxoYpaw42iADmWz0QAsTdof9NMsZzShyZATuUqAdrACslL3ACcQibHEh4JcZA46HeBoKif48rAfAFna1ZG9GdIChHbvnCDJR/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729714824; c=relaxed/simple;
	bh=MQ3wc9sjdz8z9/iwp1YpHT08l8+TQvAvNzB2UFmDCvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPJ2zneJmVb6wl2y40FJ57bek5G4UJ5c8ZF5jItoCGSkJn83fxk+bZjW9oxk11A5DOncO1114HjfrMqWd+Oj+BGEWGjFdaKIQzutT9rmuxQ8L5cQ/qspmzcX7gXebBnRUh7fOggXBsXUvv/P8jZBSKs7VfOmZCOy/CHzaeP5+vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=kCcxVPH/; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kCcxVPH/"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e5ef7527deso2052367b3.0
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 13:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729714822; x=1730319622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zt6bVdm4oS/hmHyacpyBh7YCCvBTRjOPH0q+pQ/YmX4=;
        b=kCcxVPH/PgoND+S7tKODNlvzUyJM2AziKCBszVjLoWy9ngJ/ffEP+OVhuALa+kCzkZ
         sJnkBhKvb7JzSDUnaUMWrWR2AsN39eo1y05uZVOLaciFW6kI/Dl/75ChbIpVq5rGEpNG
         2xwIZX9hKxWwh2rAeLBsU1BqujKnZClpf80WefjRm9F9ekW+HnFpNL4jTaekPb3UwWeR
         XpkJQNeD40E7eotsP9iHdezvWrYBBaspi/TARp9gZhp1NwqEO9Ndjly7MY8NkZOlzBlw
         kkENbFIko13aBjoy/g6z0438g91yjIFyp+gQrTBOFpOBzTQk5Hx3ZpPaixooaN1dWGsn
         SJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729714822; x=1730319622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zt6bVdm4oS/hmHyacpyBh7YCCvBTRjOPH0q+pQ/YmX4=;
        b=PK6BKrl7GnNEQ2yxhnxXcGg6rr+Buxgsl7zUX/SOM9X8eV5nNgtbyHfNIyYyZUyJqd
         8lZXeFTj/Cg1iGYpvTvVpLmQ0GU3GpcCwDs2VbuWr+MMYEhJ85VV+QGPOq8EtomvclUc
         aIXiVH8KTSJC4Byv5Sa1bqSqPrmO5rgn/bJQTxjR0kcexu0F3ulg39dwFELFtpG/mR7E
         Zy+J8S0sFi8NxHa/sekhjB64RLcQSHgz2Tbg7Bun6tR84HBFGAD+XPSLWu0Z0e3k39CQ
         5paHf3T8urUuYEmS7OVAgcYGyQFg6ts2f33Pb2abajipoEfddNjniSLQN1Nsb+cJwpmD
         wQ/Q==
X-Gm-Message-State: AOJu0YxHZCPaCpz1DqojNkTmYczlejp2T7fQi57Oow6suXfLfiDsJZfW
	sulDcJxpEO/dYP3Rd91brPG+IngikeZsz/tCdgQqFerhuJW7PTUWGkGdhLL7KYM=
X-Google-Smtp-Source: AGHT+IFMLEy2aua3XgduJWtQ3pdPyWOLbu5mEhrUrZ4swdqaKeTG9D1ObGVAPx+tDOULisDnHKBBfQ==
X-Received: by 2002:a05:690c:d89:b0:6e7:f6f7:38f5 with SMTP id 00721157ae682-6e7f6f75fbfmr36949697b3.0.1729714822062;
        Wed, 23 Oct 2024 13:20:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5a4d22fsm16754947b3.43.2024.10.23.13.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:20:21 -0700 (PDT)
Date: Wed, 23 Oct 2024 16:20:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Teng Long <dyroneteng@gmail.com>
Subject: Re: [RFC PATCH] notes: add prepend command
Message-ID: <ZxlahJygsRFcxDev@nand.local>
References: <20241023201430.986389-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023201430.986389-1-bence@ferdinandy.com>

On Wed, Oct 23, 2024 at 10:14:24PM +0200, Bence Ferdinandy wrote:
> When a note is detailing commit history, it makes sense to keep the
> latest change on top, but unlike adding things at the bottom with
> "git notes append" this can only be done manually. Add a
>
>     git notes prepend
>
> command, which works exactly like the append command, except that it
> inserts the text before the current contents of the note instead of
> after.

Hmmm. I am not sure that I see the widespread need for such a tool. If
this is specific to your use-case, I think a custom script and
`$GIT_EDITOR` would do the trick.

Thanks,
Taylor
