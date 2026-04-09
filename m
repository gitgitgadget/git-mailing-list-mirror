Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AF23C943B
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735709; cv=pass; b=P4TgMvek37ebYIiM/zt5ZvQ2KB9oOW6g8T4epSRF93unE/uWY60WcxFv64D9wNqgsB89urJn+xvSEdc+zpbQYQZ3BQ49kgCUoKiP62dW015L7tyEmtC+0l9SIRl7BJcnh8TuClHfCkm84A7Bp5tySjZ/1mzWTsFzFbv4g8IU4gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735709; c=relaxed/simple;
	bh=GiXb84QxWwrc+cuMuxMIwjwFjfbWbYuY1eB0wZlNxrQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=PZEDQJ3Ajae7hZbj2AOsFznfzYVTXRkoIokVFwt0D4319o1Qjsq/t0g/pOIdsEV0GhKf6elVL1fpEOselejHlsMaAxxuM+tc+ReHGXB6C+oIaxbklMVngrC6Ko/XQyfO9dQ33u20LtCwW90qEE6Jz0kzfj5MIeeJ8M5W1WAFPmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p1YDhGnG; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1YDhGnG"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-95464866f51so147984241.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 04:55:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775735707; cv=none;
        d=google.com; s=arc-20240605;
        b=huFxPsxhW3gWf42uH5GquFppdVI+eMSx0+ZUKA//42rgq9TswOPKGPTe3kj/alNJ64
         EsYfumI4VgbDxywMGzFJfJDhJE1ZZZe9A6tWZ7z1y58/MklC87I4ZX8r2xZGdMMLwL8E
         c/sd8x74SzhQSVR/4mV3iok+6AHmc/tErsFy9HTz1U0vyfi93BtH1/1vFaJLMl4wrWOF
         iOpkc/oriy9rizZsDh6QNZKNIlTgnBpnuM0W2FCGrjZTFNVHFoWNpKAmKQJ6+jvjjsbi
         6L9H/4iDTWtThybJIA8nX56A7ZsvYjWYmJSvuf0WlJ7Bz/HKuTuLtBK7ElJVOgcAetcb
         4Kbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=0DqoA5U48UVxGhKDtJrt06ntpbfJHNsXLPOR2OBqwoM=;
        fh=KfdwMgwNOZRyBX33LM6mhiZHuBHlQwQwZbP5Snjpzj4=;
        b=AWc/2w28c/Twgyea9tN9PSMrg6HPTGPHu18qf6ym8PF7fncfKSVNsZ91EV0r9M169C
         veVkTCbapakC9FSl3L8ttJq6I+6fT6gqTSbq1IEaUHqAsZ3OExqbf03rWbGEukqZhPO2
         NvlWYEypHm+bnXh1Gbsno/CqrZODMgvGQ+HTiXyGhM13XOFznxB9Fc6E7hHhQQaZ0Fh5
         6cIen0OSlNqQAl3tb+4FCtWLbhmqQ3CM3xEJiBbl6tX4RsOSxpz5ffMtg2Ky8lyJyNAC
         xgIkqZsCpne86u8KALxKMX//Z5gjxLkxPIUCndPC9iC7vsFTtpc9aBzkjDLkLKeRdGxR
         4ziw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775735707; x=1776340507; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0DqoA5U48UVxGhKDtJrt06ntpbfJHNsXLPOR2OBqwoM=;
        b=p1YDhGnGUigW4InllD2CIxhE0TbQaAnyjAoq+T7oYH3Ncp3C5QX9HSVzi9O7XZqDvt
         +6hmrnBFKlc5TG8ZTD2svzYJA3Mu3kGdLYL9o1K8qWhzJRUqUqZ9kVsTddr4qXhN3pnI
         s2Yc/iRdhWWrT5+VabJp0rrFCCxkzKADJ61kICba0WBgKHpFu/sWuwOyc36kU3v2A6I7
         8DnovnTj6bUz8B7lHAGc48/G+3E8KfhOsptzXzwd4EEjwTQubdDE1LdyRzzy/bH/gMyo
         8skErRCoNxTwNJibymrbixwjc2Yb6qbR4zVV6Zk56gIlDl4AHmqXSg8u2KMoOkv8hQQs
         hpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775735707; x=1776340507;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0DqoA5U48UVxGhKDtJrt06ntpbfJHNsXLPOR2OBqwoM=;
        b=NRTqr5tCD1zpLfYORkprLUj3XyW149vVdt7gmmocr8yczDsfLtfGqBq14nOO1RkwJx
         WvPZFGWDjZ74Z5jv5OfY5XuH4i23I4AoPi3kIvGohQKqKZutqjhdUofb5p8of7PJs0c+
         b4o3qn32qnPjxZskRS+9xEU05xPtSmU9J/JGBJ2yYqaPhAT7Gpu298QTVV8zcFQSPVAx
         STLYJqptGjI2s5onrEy4qWuv4s3QyL8aqwr3ELrpNDe+LXxuMO5cnOblLipKcV9nmpQ8
         vYqomdnPA2VtWiUuQr1N9JkHHTQEZLzBFgoEZe8c51KZyfU5+/9Nkh0gkr83Qu3GXtAI
         Y9ig==
X-Forwarded-Encrypted: i=1; AJvYcCXATEps6wa9s8JTxg4ujY8PfnZBZRyJp8ZoeNGJ08bpVfR8HqXgclJDben0htwQV0vl3XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXzz6bC6EmePWdmKLHP7XbGeX+XVwFm6bKmTlJ8rOGGLLSUjSK
	T3iVE+/JGENJnEmCo8+NVXi+s8QbJjbKxzL8b2EQKJum/tHl3wEQgh6eaVqV9mcoRWBQ0jH+o01
	iRMePT52ohdLiogagr1X+DXncxB103mH6rQ==
X-Gm-Gg: AeBDietZu8SI7w6Uw0WJsRfk66qOmYjQKAycRe2sQvpFeYNZbRFmykXIyr+tum0CSvo
	hL6nmPIMdAKzegkcNuyxk+BPe/Tqt4l21LWJcXhO77JxKj56e3/ierJ3KZt+bg1M2HG+ZuFsfmU
	ctJq2VmW5RpGga9vshINxyjnNz5wOQa/Hp/kfDN/fLup+ppIYwAMx/MxwC5AsRvi+ZgNo7rRbi2
	aad6uHioIgPdO/baZSsqIW/+dZyxnqXVwt8rXOiKzOp7s4qlSijIzLlTsmQmEVRJzMAqPa5WdVK
	1et64i82OsXtFK2gTjj5DqWBGjWvrhzdxaBqd6HY
X-Received: by 2002:a05:6102:f9f:b0:608:6c7b:4554 with SMTP id
 ada2fe7eead31-6086c7b6424mr1464512137.16.1775735707231; Thu, 09 Apr 2026
 04:55:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 07:55:05 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 07:55:05 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-2-0d2e822837aa@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im> <20260330-pks-setup-wo-the-repository-v1-2-0d2e822837aa@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 Apr 2026 07:55:05 -0400
X-Gm-Features: AQROBzC2DQAUfM5soz5O7UpGrBBpQiH0qDI2pZmhpvanaPeM8wVGxJ8H4gjmVgQ
Message-ID: <CAOLa=ZT=OZ3ymxef=mRo_EJeNvisJoR9o=T9Ab59acw9ui2LXg@mail.gmail.com>
Subject: Re: [PATCH 02/18] setup: stop using `the_repository` in `is_inside_worktree()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000b9e93064f05b096"

--0000000000000b9e93064f05b096
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The function `is_inside_worktree()` verifies whether or not the current
> working directory is located inside the worktree of `the_repository`.
> This is done by taking the worktree path and verifying that it's a
> prefix of the current working directory.
>
> This information is cached so that we don't have to re-do this change
> multiple times. Furthermore, we proactively set the value in multiple
> locations so that we don't even have to perform the check when we have
> discovered the repository.
>
> While we could simply move the caching variable into the repository, the
> current layout doesn't really feel sensible in the first place:
>
>   - It can easily lead to false positives or negatives if at any point
>     in time we may switch the current working directory.
>
>   - We don't call the function in a hot loop, and neither is it overly
>     expensive to compute.
>
> Drop the caching infrastructure and instead compute the property ad-hoc
> via an injected repository.
>

I was thinking we could cache the variable as 'static' within the
function, but that too would have the staleness issue and require
invalidation. So this looks sensible.

> Note that there is one small gotcha: we sometimes may end up with
> relative directory paths, and if so `is_inside_dir()` might fail. This
> wasn't an issue before because of how we proactively set the cached
> value during repository discovery. Now that we stop doing that it
> becomes a problem though, but it is worked around by resolving the
> repository directory via `realpath()`.
>

Ah!

[snip]

> -int is_inside_work_tree(void)
> +int is_inside_work_tree(struct repository *repo)
>  {
> -	if (inside_work_tree < 0)
> -		inside_work_tree = is_inside_dir(repo_get_work_tree(the_repository));
> -	return inside_work_tree;
> +	static struct strbuf buf = STRBUF_INIT;
> +	const char *worktree = repo_get_work_tree(repo);
> +	if (!worktree)
> +		return 0;
> +	return is_inside_dir(strbuf_realpath(&buf, worktree, 1));
>  }

We statically allocate the buf to avoid reallocation. Okay.

[snip]

--0000000000000b9e93064f05b096
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 61840bad567559a5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uWGs1Z1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN2N2REFDT2V5dU9aTEZKV1pVTVBmUHl0a2tJY05kMgo3a044ZXozTDEw
SzlmVUhpK2llZVFudWFKNThtT3BBaklNbDVQdjYza2h1L1NmaFdUMTdCblBJRkphK0k0bm4yCmpJ
ZVZTcE5uOXVGc3VHTkhZd3VxVHdaQkhpbXVuTU00eHlDbTQ4SnVHeHp2OFFsWGN1Sy9qcEpHdlAx
MWk2WFAKa1pudldCa20zTitjOUVlWE5hMGdhSWlzS21rSHFSOU9IU0FpQmRBZmtxTzZUSjBLVzgw
aUhkemhNWEJCM01MaQpGWnRuT3hCTUdmUXN6OEVMbi8xUWlpWC9PTnNtNWRuOE1FZXFkVkFEZS9l
MWhoeXRjOGF1RGgvWHNXdndQWmp0CkxaOStFZ0dLK3RZTzNDMldObFppWHpXOGxLckpCS0crT2Zs
Z0c3V2hKL1ExQi85RnB0aFoyU2tHcFp2WlRiV0wKRVlwUVhUZHR3Wm9LNUpTRWhNbWF5NEN6b2Z5
Ym9JZHR6aEplUnNRV0NLeVRVWExLRnJJdmdzUUJ2c2VsbDBRLwpQOC9sY1o1UGlFSU9KUzIwZzN2
Z0pDSUtRVy9BWkF6amVmSlpYeExFd0dlS3J2ZWgwRTg3eldxY0RPNVZaQ2tsCmVKRHQ2RUFnYjVJ
QUtkY0poRjZkN1dTMFo5cWtISGlYOWl2emdoST0KPWh6NVAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000b9e93064f05b096--
