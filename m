Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533391EFFB7
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 00:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771979013; cv=none; b=HhRvBA5mRFTxnEguDuN1VDA1sLOUtEYcCbp19KSnwXUuUmER9f+TYxLsRYxT3uCLljv9VG0SPwf+B3/kwpvOZAt3845hjOAvqUUeATBtEGbMbnF65D2epzjMyBlUYwUy/LN8/A7eE1zla1TAUFieaDakxY/BmLWY6J02J57cOx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771979013; c=relaxed/simple;
	bh=HNmFeSq5yPwDoFyt6BG5wXau6nGG3M8Aa/E42ZZ3pA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZI2rXFJtA1RI0Ca2P/9W9LZ9etqUHSOwstCU7fUA2DBjtpUHPc7pTjcswDFeLRYocywvhXjnMkE5mGR8uSx2OmVoiqCrICiBQV+r/Ukmo5KrFTa3wmHKe/UFbAd1CItvq0GXFa69W/NT2UbxWY124FdqYxl8f4v0+L/YM+r1Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ICNe3j8+; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ICNe3j8+"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb4136d865so751756685a.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 16:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771979011; x=1772583811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HNmFeSq5yPwDoFyt6BG5wXau6nGG3M8Aa/E42ZZ3pA4=;
        b=ICNe3j8+IK5YCxEsqIBYDsaE6ocafTSW2zzrZud+q/XYm18xEJnON8uk9XBcDvHeC3
         M/WlOtF8RFqqXsqUdjHjXq3k+e0JHvFa7IVbzgFQjywtQ4/u6m/WdZxjVtaPZFrTySoY
         l4CU6BZcy1/U5Ld93KpbtTaFd0w+w+87UQGqSnet6RtNtwQQX3YdZTyaO0WpRJTADzuX
         A98fwBoxyjEMCKzqqpQScsw9BOOPNevqn4lHBUjGocK/807LPjHQnvP1gaSIxSGKUJFX
         xLT3yoPKmHITN116x7lGJqqswGZs75rdGLUvauMBN3LbwqzRFBTXFuKWEFh36YQlafQO
         hRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771979011; x=1772583811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNmFeSq5yPwDoFyt6BG5wXau6nGG3M8Aa/E42ZZ3pA4=;
        b=o0pvRjPUN1z6qe4wu+27+zJHnS5gyUPULEWUPefc8aIq4KNhzOuywVbN8m2kFWHJUb
         k+wccVKKd7XRr3h8si/38Kq8GJEdllXoVwFQcqr4Jb5dWsAb5JClkARhjpr/I9UIGq1A
         zF/Cq6oSE2oG8x/hKpF783GEMZySepLXRpBChgrA7hlAFdZoVuWnK7jQgeFxAm1Qh40W
         YBEQekF2iGmwMpzLlGY/XSUx1MH2TeMMdyWqNM2J73GLgsDpfFqRRA+l6TaL8tMUn+Mo
         hQKucioALoJUyvQjyiJuy9VaJPmPylPRe+I15J0AR5rud733cWQ1gAquxne9m0YzpY6w
         wKxw==
X-Gm-Message-State: AOJu0YxFg6Iv7A3Uy2IJOIt1Ji5QAAXEQ1BGv7nDj6S76XfEFL44Zt80
	GL7reAk0xedxwm1Ylxxsx5ydOmt0En055bojJ7Dk1zxMjN1ah0vMy9/AWLjAMpmYZ3d2W1WCgwP
	dcW6s36noNQ==
X-Gm-Gg: ATEYQzy+vpLsuU01DHZtnkQVoBGfU7slEEGYQe62qNYTF+0IHhQpyGcHGnvTGsavh74
	ZVzR+XUePfoNitcbMJwYAMN/XORhlI8Ed3RJaTbd+men894/KHzSqvQYEd/PSHXegYYLdKfzECz
	mzpo5vHyQbYgqOFn0Gs+ANwlu+ewoz9IP7IBsvUCFsEbfmYgt+eTS6uR38S87LBoA8ZU0LO83Ii
	qgpLmmvhkoeJOoeA0l2XdtfNqEVntNyTGxcTMIDhHBL2Sp63/jo23rp3T9wvX2HOUyo8j/KN1Ud
	tjz0F22i/VIjYgN8kF+he2AexR5MZSnud+HNSUa8NGB3OXYYaAhWK0WHTY9Zo+izFzYQf+m3ciG
	cOvVI7vZrCDb8L4Xhrn9jN3KpPU/GQAa+MPbFzYbV0xY3ht5JhnlKaVkfSef1ZgGwLWdoDpdwFg
	6XwaqZpEoX71bkPGZHYHzENmMyGeNQ3q5RuX8TiBSqhq0hSiY7a1NUsQwG2tgUS4iYgNUlW5oxF
	zhIfmCrfORvfDAzzDQOQ2dXn5xwWw==
X-Received: by 2002:a05:620a:2a07:b0:8cb:4059:a90d with SMTP id af79cd13be357-8cbb5871379mr70874785a.38.1771979011090;
        Tue, 24 Feb 2026 16:23:31 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0eb32dsm1265367085a.31.2026.02.24.16.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 16:23:30 -0800 (PST)
Date: Tue, 24 Feb 2026 19:23:28 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 06/14] repack: track the ODB source via existing_packs
Message-ID: <aZ5BANxASSKHdqBu@nand.local>
References: <cover.1771978829.git.me@ttaylorr.com>
 <df37959d2933d84ec61b9ba570c87f9e5213c735.1771978829.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df37959d2933d84ec61b9ba570c87f9e5213c735.1771978829.git.me@ttaylorr.com>

On Tue, Feb 24, 2026 at 07:20:46PM -0500, Taylor Blau wrote:
> Store the ODB source in the `existing_packs` struct and use that in
> place of the raw `repo->objects->sources` access within `cmd_repack()`.

I have no idea why my scripts sent this patch twice, but there are two
copies of [06/14], which are identical. I'll make sure to just send one
of these in the non-RFC version of this series ;-).

Thanks,
Taylor
