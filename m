Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882E83DDAED
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791559898; cv=none; b=CkaRVR+zfZaj+bYlRCDyVRsacknGDFB0WxE/5a3D4d51hpmLtf4hsi6HJusd9JLw/nZJ41YZagjK37o5PghZrcNrYz2qz/hewLlx/yWkWjaanGTwK2P2EcKp2Zi6+tNinZPih1+Kj7Sfdpb7Cf09Qykh38U1uo8/2InuRr+vl04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791559898; c=relaxed/simple;
	bh=t7RFIPrhqwl3S2stKg11rEzyWJpqFWY5HhKZWVvrzwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ga7grmnAvmtYuVjh1iJ5YYZ1uhHjRxH/RP7CqQNIi2RtQrNzUJ49j/XhKneav3YzAdi4p8HDTmOghzrXuWognVDmfwiAe7I9pu65ZCNE7dP6sNuWoPULyb9siNaoeVQ/mFP1zrfvjB6Zv5U8gvv98NvYbQSi12jgooz4RqGYXgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pWhTKq1N; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWhTKq1N"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2e5f8fe879so691608266b.3
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791559895; x=1792164695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sQj680DjbFsmWGpBdTtN0Chv/hiSpRxRZVJWak1V88o=;
        b=pWhTKq1N2luGv96hW+yZv8vPHZz3rk7q9xF0uUPUZESdCW152PqFNu5p1EMSiiQvKW
         xECGjuVmGGdEn6ENvh3tWqyv1Rho2A/x0GnyE5X3q7MW4jBEjf8ELS9ZXvroFY8QTVXj
         oOacd21Ny5j1P484nofu1veJfeunW14BrLYroXuWaIWP3zRMlMOOtcKurM4ItnExJyRD
         OqxWaS/n0cmYtD0FK7hgFK+c3R9PAomVpn61aK0a+vz2E1fRAyzgPix7JFaUIFoQURm7
         93/kkGgxPNzq53lvnRhHHbeky0AubCHEIxsIZoYcv3r+urPIriqNxpm2/rOYcqSxDHu+
         u6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791559895; x=1792164695;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sQj680DjbFsmWGpBdTtN0Chv/hiSpRxRZVJWak1V88o=;
        b=0taoJ5sztIuQK1CoTqskkutxt7DPrV2QVLgbBJ6xL+C5Xwa7XRKiawsnKexnGWpxwU
         rRGrflUMJzx/QooZ7R0EpyY5Biw+FL3L/0QURG1t2nSpOrsUkLvY3JDMzOLBLPqwXZEc
         F1IFhqnVvtDNVS+vazdLtuzJtnU4ufqIXeblGRV8cr9wiDssMzhdchMvX5RqTMy6/tPb
         KuRkyBK9sXvNKFdweHUJ43CUDTMP6I9+BRn2PnjfOzf4mHg1ilSAd93u/dmSDMC4sHG+
         y9kRpzUp6lkLY7Gz06DQA4UHZIrPINa5RFZ0gt6jpxW90aOiuDTBHXcOTfEz5joh80Id
         AeGQ==
X-Gm-Message-State: AFq9FYKdiHOk8yd09cUhXw7dqHrLj+M3fi8JsZWZ/YZuWnwxyKXfp2V1
	MTHP0mvb/Gpmg+sxq8cp1uHqgj8DtRYN35Vn3svGOezIjv2YSKxqsz13bzs1Cw==
X-Gm-Gg: AYBFou0Uqs8d0G1a/EFKaAFVgL9jx73oQ0v3CHVyd4QjXzFPrxLWxsFqedBz01jNe0j
	wQScqUEZOYDNjJP6ArhkPabvTy+zMyVF+dnwEK/qF4nEsI2s4Nz8ipQ6VYWpobeLBWZmicVW9dr
	wf6n7J3+Hp+Dlx6GFtBFf98ggTWDPJY05SFiTjJ0qaWAxokkbYcTvqHwyCX/ZxoqKBQBaVrLOeq
	i1GSjTTl3pTZUvdYJnMrJ/Xgu4+ouYa28Eyb53bSDlsfv95P1BSzNormZAWPWDchZLYW1koL1Yp
	ljH75FCOOyLJn7XAeQ/C6Muua9o4wzMpOppcAs9XwHK2sVAnYa8b0cH9CcsR/MTgO7lOYpkCWH/
	RvoFyxtzir6XtMklDPQW5hx07RKmcCdyzkwj14omiBWJ6Pj79cM+2F5HiVjxUSMUDjRzrTohvy7
	68+QX4ywqkKqQJKHeh0MMK3IU52yuZmiI6MwjZh7I1JvX1Qx7KWqMBB57MP1lkBDLun/i7QpVe7
	MX5fAkzU+TLf2xxOLkFZPjE3jzYa/s1+W9CHIiCWXYx/M0jMxIV4EG7EBs=
X-Received: by 2002:a17:907:3f8c:b0:c26:19de:9ad5 with SMTP id a640c23a62f3a-c31aa0e3b01mr239079366b.45.1791559894457;
        Fri, 09 Oct 2026 08:31:34 -0700 (PDT)
Received: from localhost (20014C4D24C2FD001884BD3C82CA168F.dsl.pool.telekom.hu. [2001:4c4d:24c2:fd00:1884:bd3c:82ca:168f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9762a4asm115413266b.2.2026.10.09.08.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 08:31:34 -0700 (PDT)
Date: Fri, 9 Oct 2026 17:31:32 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v2 5/8] ci: rename linux-TEST-vars job
Message-ID: <askI1DGldZx8ElIN@szeder.dev>
References: <20261009-pks-ci-housekeeping-v2-0-6863d58ef691@pks.im>
 <20261009-pks-ci-housekeeping-v2-5-6863d58ef691@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261009-pks-ci-housekeeping-v2-5-6863d58ef691@pks.im>

On Fri, Oct 09, 2026 at 01:32:02PM +0200, Patrick Steinhardt wrote:
> The "linux-TEST-vars" job exercises Git with a bunch of non-default
> options enabled. The name of that job makes you want to cry though due
> to the weird upper-casing

Yeah, it's an eyesore indeed.

> and because it doesn't really tell you what it
> even intends to do.

It intends to set a bunch of GIT_TEST_* variables, and since it has
test vars in its name, I'd say that it does a decent job at conveying
its intentions.

> Rename the job to "linux-exotic" instead.

Seeing "linux-exotic", I would think of a job running tests on an
exotic Linux distro, or on an exotic platform...  but it wouldn't
occur to me that it intends to set a bunch of GIT_TEST_* variables,
simply because there is nothing in its name to indicate that.

I think this patch makes things worse.

