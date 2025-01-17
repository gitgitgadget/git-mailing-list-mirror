Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54321A83F1
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 21:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737148644; cv=none; b=g5c18t7i41azHmktev6+/ujzS3YJO+rN6THNBRuXTdo2h0qRb6bRSK0FOlnwZhTJycq6+l3jHwS9kyNs8miHEtTAlE55C2cnDkNYjrkmARfAvf4hUp0BD7/Nt3WE6IkYMbSW0hahX9WCxOQ9iI3kIsHcW+XLi5aZteZORvKxsFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737148644; c=relaxed/simple;
	bh=2tifbRn0XGhOtCLi6MLmkkS4mgtxl6/R5PfnxE9/YBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6ZsWp3YBhye4NEYMxn0iLzA48hH+FfyR3E0QtVTt/mw0G3JT2DDanRXkYdJrHXEm/potPBr6F+YiDPm/vJyZW+EXoq4v4Z5qGzqF6pfxayblsMR5m6kPRg6od5b8k8J/CuE4bX1kPnPYP2pd7FlZp63vzZhRXeUiHQL2XDhI5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=WGeNRRtn; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="WGeNRRtn"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e461015fbd4so3986000276.2
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 13:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737148641; x=1737753441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2tifbRn0XGhOtCLi6MLmkkS4mgtxl6/R5PfnxE9/YBc=;
        b=WGeNRRtnN+1m2F+Xujk6sdSjuV+ZzXKtwki9L+45OgSdFcmWivZmOtccNXVP63iPp8
         jFe3sWnCXpgWuoFRyaqSV8b+53Zz7Ap4W57Df5iq0yXuEfYK48gZjMfobu6U68OcmRNO
         n/v4oNMMU4ZYNWv1B8DeW7qXl1VubIpGtDVYun7QfsPV9RQzbJL9zXdwoe6sUaeypj9C
         w1niYutc1swbJlSzaZYOA7Q4p0K9HxLkot0LWGr37AjoPXhRPZ0r2E2gd/3VEy93yIIt
         zpd0fNv4MpFcybZlQrcmbbqQycNeZtbHeZryem6CRK7VZ91GwsnPUzTthFd8EE3fm/K/
         w8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737148641; x=1737753441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tifbRn0XGhOtCLi6MLmkkS4mgtxl6/R5PfnxE9/YBc=;
        b=Mys8UA8hJ3DC3mVRJ228hx++Jb0Isbnb6fL4Gr1HwKKCCBbJJbGb1l42cV1AiRDDR9
         gwdQXj0qnwZ+yNV9v5c4TOqm03oOdFmiFfHYpppDRcUkyiY6eavoJmagbCEDSbI1xBDK
         1JuKxdv4Xjpe9Al8udQkOJ4AFBN5TTIOx6mWMk4vtg/XTuJjfiMTGTxZ90DoA1W7U1ft
         6nXQE4DCL12H9mkqF8TDCDbMF5ah3+oc/u9IbcQT4lwh/qM8Urt2psYazBIe9xXA7iJ5
         F6DAYiHhcPr27c7lRrCVWR0HsOU12JqFmXYrNrbZSieJcRJ0owXv0LAJPrTlQE6nNKW+
         Xrkg==
X-Gm-Message-State: AOJu0YzenyWKyiMPiDyQbVHKqioSWiW1cb+kCZ+A9Tgqj+HTLmzeU8tQ
	ojb5/aPuZ4r4/stRhC7JCK0VbQljQw+Y7XC6AhDL1LUrmizafAVMs3rYAWvP+HY=
X-Gm-Gg: ASbGncvlc9w4r5wDLeHGIZ7qTmLIVWIF43kYsmcoOy1x43cba4okhMPQJOYNN7cjenh
	yRNBIU+l350yw7hF1htZINr8EM/ZSVsihCeVRvVYQJobYLHYtQLOtQIOchweQy2rsm8VsM8WhGY
	Eiy23zrsV15rG5IQQaurqPzqwj54xxHzEwA6PhTReoH10SKkzus8gxZwh5DoaTb80Qxr6bxRM8R
	JR/4Y9il50gwY7q6O0oDtcex6p8wLGHP5pgXhJjvRjJBEYDl02PJA0bIA2Ax6YhPP+Rqu8bSGhP
	KonYqsSk7mmPhymSqAsDGtBJlVXr
X-Google-Smtp-Source: AGHT+IHbokZg3pEsqnSa9eqPFmbYCpOx3kk+LW+R0jC2Jv28A4TgP4LGKHm5lHeX01U/jD9TPrWYrA==
X-Received: by 2002:a05:690c:6b13:b0:6ef:48ac:9d21 with SMTP id 00721157ae682-6f6eb9046ebmr39317547b3.24.1737148641212;
        Fri, 17 Jan 2025 13:17:21 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e66f0de2sm5724737b3.101.2025.01.17.13.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 13:17:20 -0800 (PST)
Date: Fri, 17 Jan 2025 16:17:14 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/8] csum-file: store the hash algorithm as a struct
 field
Message-ID: <Z4rI2r/voKHzu6Xh@nand.local>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1736363652.git.me@ttaylorr.com>
 <99cc44895b57cc75fc8f447000817b3595368e4c.1736363652.git.me@ttaylorr.com>
 <Z4jyH4yIXuD0vuqQ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z4jyH4yIXuD0vuqQ@pks.im>

On Thu, Jan 16, 2025 at 12:48:58PM +0100, Patrick Steinhardt wrote:
> On Wed, Jan 08, 2025 at 02:14:35PM -0500, Taylor Blau wrote:
> > Throughout the hashfile API, we rely on a reference to 'the_hash_algo',
> > and call its _usnafe function variants directly.
>
> s/usnafe/unsafe/

Oops. Thanks for spotting!

> > Prepare for a future change where we may use a different 'git_hash_algo'
> > pointer (instead of just relying on 'the_hash_algo' throughout) by
> > making the 'git_hash_algo' pointer a member of the 'hashfile' structure
> > itself.
>
> Makes sense, and it's also a good step for libification. I wonder: does
> it mean that we can also get rid of `USE_THE_REPOSITORY_VARIABLE`, or do
> we still depend on it in this file? The answer is yes, as we only reduce
> the sites where we use `the_hash_algo`, but don't remove it altogether.
> That would require the caller to provide the hash algo to us.

Yeah, I agree that we're not quite there yet, but likewise that this
patch is a step in that direction.

Thanks,
Taylor
