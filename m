Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7972B9A9
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738403153; cv=none; b=arF8mzfDLIFunQJpY5NtSKGZwknsb+zXaOHqImiSBEkhweWrTmImwYGoQVnxgD/4xhXrlryw5kDYWgMCfjEwR1q1EeCAST1GArJl8aVbwkAp5Jpku7jNshU9P72PrcbbHQzgkad7LBG1y9M9JdTB5494XIsQ3b2LYVcZC8duas4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738403153; c=relaxed/simple;
	bh=XnBJUt0wdbGuq8NKvei4vwskS6ZVF/tDkLRiGVkY+40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYDVJdyJGH8DMrxDw/RZwXO0+8MgFG6H2IZ2YAnTzdZZ2JT5k3s1Z0JgtNskkiMcfkH+cfc5wKhru7EU525pC7MeP8VmYatFh5OEtxqw1bVECkc23ZWX45huTWGF/ScL6GrTqmeM6kX+YeYfodYxdv38B1AZuwwjjj6x2JazuEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKOWn3ka; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKOWn3ka"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so3839998a91.3
        for <git@vger.kernel.org>; Sat, 01 Feb 2025 01:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738403151; x=1739007951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x3Z+oGjDhEiX4guatF2Po5aerr3QcLZ0EVRDGU+uCws=;
        b=fKOWn3kake/LCQ0epnTrSYeqy82/3cWWmORgLbFwfIl5HAHShLxChq/Wl1JNMb59Ek
         bqrHfzM4BxfGomcecpChxHU3hlzn/31jrKHFyaEWjHLe6hNhqgQ3dYwChF0bo8TVlQKN
         Faz3SM1AGfFpDQKr1FB3wHLarywMZZUS+Mxr8Fy7G/BXw7hWdDMjWWIZWggpOFQL0z7/
         fGZ6R6TikQvwYa5SVokWvSeQuIHJAMR5yShNMiW6Q22YlZy5cR7IRYdciekPnYvjni85
         7LX9kd28sQVwZho/2bv/oEUzCeNyTxS84lo0ApL9e+XgWpaxh3A9hZKGUadDPPiKrTxx
         idlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738403151; x=1739007951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3Z+oGjDhEiX4guatF2Po5aerr3QcLZ0EVRDGU+uCws=;
        b=EYg0VEpOth3AJfNWc8Cv2Ba9Y9etGsY32sGLwlQ4BjpbwQsd6N0wP0zahx6aa3mEKf
         iReXozpsogf0Na6TY+t9IIrJUTCUA1AGpy4/jSyyucz60X/atsWArBdxvCWFmYfPZBhE
         L1vRnZb+dfrstQuWLW+JOHjlBPfy12FSK6qF8hy8Rpts8HcVOE42QheZpv1YwP7UxI+G
         YswOt4DyN6cd+5K5HhWekFfHaIqdovWPEnKF6CeZ5C8OzU3qqLo0a2r9F/n92FBE2TrJ
         VbhkyOxZ88LEtiXWM0rkKhHalITA5QocBc3+kV9+j//qMT620YcEuAhTeQAv5X3gqV8e
         ETCA==
X-Gm-Message-State: AOJu0YxztdvnCOMd2ydEhkRcO2j3z8Y7+gera7foGk2sQW8nI7vcXG2w
	8jgrx+n47lneIaV6tbKt1mbHn3KyLI2Wl8yUUCsakv3VKYXSpHIe
X-Gm-Gg: ASbGnctNMPu9Q/38PntzQkTuPJdi6aQRioIpCy+0nDRbyB4IbdEAm/nhPnF2ozhv2BQ
	jOdpFTq8scvmOA8Prul3knhPkilVziH4KijQniyDW3Cd3UghlAJcK3PQKswa72yxTYAfo2+Xp1a
	3z93OPjgWOyXGfcdHJTGQ+FMoWy+lECTksEfaE8voyTRO58X2KNJ83nZ7knaC+5u3VrzYtpQR6j
	JL3rXMKQ0i1uBiH0eIoVBXqM2vWOROPdDmovxSxFfGvoZk8Od85N1cjxL8azP3XQcGkPQ==
X-Google-Smtp-Source: AGHT+IE1LuW+Xr6i2iv6OBv8ybysxdRhzqKUDE77vUBVWCNRxhgEXHE/3urEvSRXNLgG2yjtZwk2Fw==
X-Received: by 2002:a17:90b:5445:b0:2ee:aa28:79aa with SMTP id 98e67ed59e1d1-2f83abc3161mr19831451a91.6.1738403150936;
        Sat, 01 Feb 2025 01:45:50 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f83bfdb81bsm7370161a91.49.2025.02.01.01.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 01:45:50 -0800 (PST)
Date: Sat, 1 Feb 2025 17:47:26 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 3/8] packed-backend: check whether the "packed-refs"
 is regular
Message-ID: <Z53triurDqskbRaA@ArchLinux>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
 <Z5r6-52eBgT4TUYG@ArchLinux>
 <xmqqplk4duuk.fsf@gitster.g>
 <Z5zWE1M4u3NrROI-@ArchLinux>
 <xmqqikpv9cq3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikpv9cq3.fsf@gitster.g>

On Fri, Jan 31, 2025 at 08:20:36AM -0800, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> >
> > As I have said in the previous comment, we cannot detect the error if
> > "HEAD" itself is corrupted. However, we will check the referent in the
> > later. So, we don't need to do this.
> 
> I still think you absolutely need to diagnose and tell the user
> about the broken HEAD.  With your "don't check HEAD because a
> repository with a broken HEAD is not a repository", a check run in
> such a place may find everything else in the repository perfectly
> fine, but because the user wanted "git refs verify" to tell them
> about breakages, you would want to somehow tell them about it.
> Either it is missing, malformed, whatever.

Yes, that's absolutely correct. However, I don't want to do this in
this series. Actually, there is no check for root ref. I will add checks
for root refs later.

Thanks,
Jialuo
