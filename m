Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B14451076
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 21:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774993750; cv=none; b=fPpX9mgoG2XyhSl1LFLIEnFZHki/jrLh3x6gxgzqzcWjN8dfiSMSqpkmy2kwtRTUzjUv0cXr9qnj89Tv/GKU+WIz2mJH/4Xzvd3p81sy0zniDg1HjChkIg0pMPBS9HT7guVWalSkjCtRR++iRq/LPYi3AY35kCI0VSB/M2JOEq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774993750; c=relaxed/simple;
	bh=e7px/C041Fx6P9K5aylk1xWT9HYQ+i015op4dPDvE7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPshCPNazEU1agJNRIOrea9IxMkSsvHV6hFliIa19cFC94zVDY5KyRT/DipCurdaNUqL0Dl2PlHcv9zuYRZkeThbImvd5Q42kD2H0pKN3pYWeHTXBa5AC5gJL9ytkCo0I+EQ8YMq9A7WJa0sAMVxsqLTOCU9aZdT34y1zeE+eg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=EPJNiWsj; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="EPJNiWsj"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50babbce85fso53533811cf.2
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 14:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774993748; x=1775598548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e7px/C041Fx6P9K5aylk1xWT9HYQ+i015op4dPDvE7c=;
        b=EPJNiWsjCLizZMT1eHMuWSxHchUCWAdpLWIFP2MQKu7i7Q8O8k1Fp97ADg7nKZ3xeq
         9IMgS3YKfQAtZ6+feTl6gB5xaR18yxo8O2F+I98AyEm8z0t7uu2Jt3nvzStpYrm1A3kY
         XoTnbILjb+mGoMicWpJ+QmoxCGcbJp04MdLKF1/PUVOarL8RoFQNAJv9+g8GZswNqX1U
         jvxtbTnRDMquNHNw5ydpzYEo1m6kGcrxN1a22JngqgTBP5gMI8asGk5GS1PD66IU6NPl
         rJQNYr07vEGjEZVZNfbeF0QqQkp3WRKu4uhV0Tt2BeWcjpHuGS9p9Ve3KL0FrKVpbm+D
         UI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774993748; x=1775598548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7px/C041Fx6P9K5aylk1xWT9HYQ+i015op4dPDvE7c=;
        b=ClPQRRg6AgRzYtz8xC0lZMe+Eq9bLuuGXhgdFlR3EYbterYWVweFBte1Fw4CNQOBD6
         FfWBlhDSlv7L/GXF4xW60j6PC/zR4+vd5oV3O6X6X2ll3s6bU3GVRX9u5FwGYJ7UC8yX
         EaLycy5u4RtFOA3ZpdtHK56zeu48yZEcCQyHuxENLNnH3rYB/Fm+7ocGrubzaDyJRXDQ
         YCR+8b0yzd2u84/b3JkBjIlxVVjxC5bOoDnxA3d8kbYQSIwUp4OtX+7GDaKQPr8KoHaS
         85+dTcm/sLA3ftReOL7N7wUWWo6l+2NO/Lc3sw+CVsWF12tF+Nu6Pf3+1AKiBV25Osh2
         xhrA==
X-Gm-Message-State: AOJu0YytozG6Niw3qKkK+nOZ6xf73NWhxbqybbwxJ1kF1o9MhLGBb5gV
	3Ii0wwrKOt3MC/4YB8gc8YqL0QTPurUOvlh+qJib2IIofrNkQ+vFpsgA3ecKb/uOH6w=
X-Gm-Gg: ATEYQzxUg9sd7mQipz1U5qnuuePtmuuzQ+vBKGKLWJQVX/Z0p0YfzIGY0T/Bs1DQmMT
	6+uTJYfJSt3UEhMdFJR49b58SufymqICl/Xysd5Of7TjELpqBsdZS3gBPYkPzcqWR8z9C9sYWTt
	K9wPQQgrR5/iIl6Th6YDhgm+H/+6qYUy1DAx5tGyqR2VtFjfGaqxPIC2JNcHSY69PWQ5OWPstN6
	k8BikEgsU/dYCs9GlS4O7+TWf7eTegu04Vxr0tUGeoked1X4CLD1fm8epJzxs3YTp2xZHIv5acT
	TOFN/vghnayERWWZXHu3CAo8NHk0L883DhIBV+iQNN+Pv9YJwYKxodXTzzNC+OKeD1V3hfXMCp3
	asXr2OvHi/8BRUR13koVOZaRYiADBLi7UMVrMnOzzOKIt/8yf8B8gOCJQJNVkJ/l6l0fZ66u5J+
	CKskLGIrAEQTiIoLkSI5HlKPSXIXefRPdtNTlysi+T6kT9xj8KdMPqAk8XRAp64dRSc6mOP2W3X
	9SX28D7FiaMR154GrngbPyFkfLggg==
X-Received: by 2002:ac8:5dd3:0:b0:509:14e2:89fb with SMTP id d75a77b69052e-50d3bb5d5b7mr18983581cf.7.1774993748308;
        Tue, 31 Mar 2026 14:49:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2c9c93asm117120921cf.7.2026.03.31.14.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:49:07 -0700 (PDT)
Date: Tue, 31 Mar 2026 17:49:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 02/16] midx: use `string_list` for retained MIDX files
Message-ID: <acxBUkHDolY9VCnR@nand.local>
References: <cover.1774820449.git.me@ttaylorr.com>
 <1391552dfc6624374bed89b25d1892d9b9d080f9.1774820449.git.me@ttaylorr.com>
 <20260330223849.GB41843@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330223849.GB41843@coredump.intra.peff.net>

On Mon, Mar 30, 2026 at 06:38:49PM -0400, Jeff King wrote:
> Since AFAICT we only care about set inclusion, I probably would have
> used a strset instead, but for the numbers we are talking about it is
> unlikely to matter much either way.

Yeah, a strset makes more sense here. I adjusted it locally to use that
over a string_list. Thanks!

Thanks,
Taylor
