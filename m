Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243B734DB66
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838063; cv=pass; b=SCwOHB1SNaJpOTE5CwZDhpBmozMEB2b6rJR6b7miuQJzdqwBOoJHmdx6lv0dCNfyO0gIpdZS07+oxhDarFe0Np65AsO6OyKmzwxmPljCJ069quVXBWojnqEcO4pIuvUkwibPc8CSouaKbXNc3lw1C/Ux5YHp8inOiNGxffBrook=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838063; c=relaxed/simple;
	bh=oh0prsEeVP/8RU9H9U4bYZtuh2PHjbjCjhqdRqvMnsM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=U+tNgTjJx6KNi4pr/h4dHVJYGLSS71HWqFG8QzrqfQvaj3hVigD1WqeVJEiSoINdZT3O2kXxQyLWtZowLXWMmLwPei5R8jO9D/9fLdxeXgU43WyoBErhPn3dJ6IfR8Okj9opDc8EUuyesgGextZPfaxXglXirtiYnMmgu6DnNXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edqIJFAg; arc=pass smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edqIJFAg"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56706fd623fso2876667e0c.3
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 01:14:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771838061; cv=none;
        d=google.com; s=arc-20240605;
        b=GmlFpG47I2SNe9SmMNF8HAzEhe5mWQBoupkG2vii/ut2qoV4g9i+HUxTVPEpsJT4pd
         QSiRo55wfCc13OiJ9xMh5LuHNJ/5+iRPXyCFEzyC2C/5z3ckSeN0Q0gQRA9i2nrjZ4M5
         WWCOc/RskkNHTBfD6AC0DPRickhxu3FGkJiOZHjOnwxyg+tLuJ4o8pKEtGwbqWLVw7WQ
         RLqSAQQnrOw2zuOX4Xk4L+C4jj25EhvcXjcqiWOfJwOh1mggAmXANDj/46AQKaWGz3lY
         cqZWQLRF7+AgVC2nlw/Rvxp64b0nYp0RO0qXnEKDa03054pVFENaf+9nG0vP1RzffRzp
         +N1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=Fi6VEoLrYJfYF4Q/uBubFQNUyeFpJr3Ih7DP+kU/hGE=;
        fh=TNfLVDec+pXW2k1qsY2jVTLFEImSdyRtIH3MCQw9rqE=;
        b=GV90LvHo+wKErEqiU1LlosLKg2jMGw88fQhPLx88yMPfSa2Sw76QlZ5hKiGbJAW7nW
         +97gsXKJ5cAgZRIVGGd98kMtZ1tJ+5PseYX4y9t7td/xiytfHP86mSsp+o4eiuEoD+Vt
         QEw0LBf26W+zu1aa4W1cSGIzGNx32Wh9p6fYH9o8K2IvDNerhGX9Nd6ht/BBqJa/Jirq
         PagXGAJjCSFw7SmoPicyaebal3ztn3pm91UBjUXmOVqfyeRhQIorPQBP91Kqh6VdL1OM
         rBcMIjnqC8SHVFxN2hQnC+nZ5LfkL9jLM5tOiz6qaCNNCs4DRFede07itME7HmYScSeZ
         g//w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771838061; x=1772442861; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fi6VEoLrYJfYF4Q/uBubFQNUyeFpJr3Ih7DP+kU/hGE=;
        b=edqIJFAgeJZsrpXeRfK4ICBwMIFuL/zroFtd6aWzX+5FqgHniDO7ip4dfDY8ifbT8j
         B0sj+0oiSYwr+POX+Ib69wj5emPYVSgG+Xv3UkYw2aEAiQ0m8ky+WgeSJ+BjQkaC9mmJ
         H8v/S39XwjBSWP4i+ORpP4TaXjXAVx2fJeTwFTtaKCvZPwKmOE+uLnuxyoe/RwaXGlEi
         ATaDJQyf7jQheGHnTUxSGIByfLZzJbXs/etjBKIhHWk+qbeE5L6jEhI3KMLofqdF2/AN
         Ayz0gsikN4OaU2PNitglq8jNUT8sk6AO4bMLAlVgwlTW4w5UO4XnN9uZU+PSZHaL9eng
         sQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771838061; x=1772442861;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fi6VEoLrYJfYF4Q/uBubFQNUyeFpJr3Ih7DP+kU/hGE=;
        b=ZZc1gzb4CcFSlwzM80ZwaptQ/emBVShH39CuDH9h7+yVxe8tDM555NFtQlxgRo7Bqo
         rzXCsa+qdLguNVUEzWgoND6Ggj+9bzLGGoggZByQ0JSUZawVTuKA+9c0+iOu7suAE2eb
         Nt7o5wKUJPNWZNFKWoyPcqpUnp+9HPsjisdQ54C/Dnp6konmIFNT3KpE0lW/55vUiCVq
         bRgSi5fpT3KSxe7rAc+BO5B9KCBlaZ4Yyjf1tBsuHN+MZTFyktdXsV5IuN9VYHOd40Y0
         FGQ+qJbcsiVrqnPIDTHpXiO1T9PcCEc5AAg7Hux077BgCgcs2v5hMDvwmh068E3LdrA5
         Y/sw==
X-Forwarded-Encrypted: i=1; AJvYcCV+rrXjGLN7o1vN4HFifLdnTmlmhkv2jDuEmSOrnQF+Ie6FpEUMrVGWWOknUPw9y+VDLn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzA+73tqmHvDm0E4/p+xbvPJYqrEDwOdnmDFMJMa+EZqfe6XGD
	0wNJE6KaoX+gkiy/P9MnA4q2coFipn1qcR8aiLGr6Flb9OkZG0nSdofeuRVzH8gm/8YZzvUcWbY
	pB7nBeVE5eu24qnPHb+njfyGylmTsxGKCXSVU
X-Gm-Gg: AZuq6aLDRz1HcZO7I4vK0u7x9Nrrn3UJSDRsYubfAOF/VGQExPiERbQR3xsEShmgrIw
	7PKv6Il25xsXkWGzIOARrkRz+AX6fuW4TTgg5c0YshYYEOe10ER1aZdj2M0U76bNjmZtAZ0CzD8
	hu8pbTtyG4PjoaJgNgWwONsiSQZDdRx/JicpCqdFGODYJx19Bgp9/9yaP4yF69YL1KEIc/miUWq
	LlA01WZGEc1o1QVXjW6GRU9OT3m7kezAvfUuVuqHBTlWNLoFQ4dWdcYwoHLzUTKMoT0r7B/ijj8
	bIH5H+4OZ2q6bHBn1t7ziNCAjBQR8nIU+43OUEHo
X-Received: by 2002:a05:6102:3f0e:b0:5f7:2413:903d with SMTP id
 ada2fe7eead31-5feb2ee4a9bmr2849591137.15.1771838061101; Mon, 23 Feb 2026
 01:14:21 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 04:14:20 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 04:14:20 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Feb 2026 04:14:20 -0500
X-Gm-Features: AaiRm533hJagOAotMu5GzAkRphNPwy7XaNqACt2a6NCiP-21FFNV0yDCnkMFSJI
Message-ID: <CAOLa=ZT6a8wdMgznVr7+ou3mhYKDT_AC3M0s4FCZ-Orjxf+6eQ@mail.gmail.com>
Subject: Re: [PATCH 00/17] refs: unify `refs_for_each_*()` functions
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003b718f064b7a32ba"

--0000000000003b718f064b7a32ba
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> we currently have 14 different `refs_for_each_*()` functions, with each
> of them doing slightly different things. This makes for a confusing API
> surface, and because the API is not built for extension we have to add a
> new function every now and then to handle another esoteric edge case
> that will ultimately only have at most a handful of callers.
>
> This design isn't really sensible in my opinion, and this patch series
> aims to fix that. Instead of having a dozen different functions, it
> introduces a new `refs_for_each_ref_ext()` function that simply takes an
> options structure as input. From thereon, callers can mix and match the
> parameters that they care about.
>
> The patch series is structured like this:
>
>   - Patches 1 to 5 introduce some preliminary cleanups.
>
>   - Patches 6 to 9 introduce `refs_for_each_ref_ext()` and move
>     more functionality into it. This also fixes a performance bug that
>     we have in one of the implementations.
>
>   - Patch 10 adds some more verification for options that would have
>     caught the bugs in ps/for-each-ref-in-fixes.
>
>   - The remaining patches drop 7 out of 14 functions and replace them
>     with `refs_for_each_ref_ext()`. It results in a bit of churn, so
>     while I think this churn is worth it, I consider these patches to be
>     optional.
>
> The patch series is built on top of 73fd77805f (The 5th batch,
> 2026-02-17) with ps/for-each-ref-in-fixes at 6375a00ef1 (bisect:
> simplify string_list memory handling, 2026-02-19) merged into it.
>
> Thanks!
>
> Patrick
>

I'm really happy with the patches, I have some small nits/questions, but
it looks good otherwise.

Thanks,
Karthik

[snip]

--0000000000003b718f064b7a32ba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2def97df8429d7f3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tY0dtb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMjdHQy85U3Y2MTFCb3BzNWlmZEZZdnJiNmljckxOegpCR0VZVHB2V1k5
STJ5NGxCRjBrN2JGeFNEY29uYnQ3ZUFUNXlPM3N6L09OdEhyUmcyY0JmbitmTmhHbWVTaEUvCml6
TmNnYmtKdStVSk5XdGpnRGtTM2s2OEZJMzArcGFTQXdRMDJJcWdVWmpLNTBrdEIxK2xya2RFdWsx
WHkzcVoKc1BCNFIrdmx3aVVvK0dLby9FaWpuU09YYlMrVlREb1dRN2hSeThJYzN4YnE1MGpLMjJl
c1FXcGVWdUE4UFhleAplb1VFai9QMVNLOXE5Zlg2d0JiRFhCd29KcU1ZcU9rdXA5ZndhZXA0SVZP
dW1zNmpOU0lFbG9SeHE0ZGw4NnUvCmNLYllsZHNLRHllcjVwM3hJZFZOU2hxNS82S2NPc3V3K3Zs
NjcwaTl2OGN1NEtJLzBubmhIcVNBbnA2U2NLZ3YKMlVoSDVPc1BSdXUrZCtENGE0MG1RTzFYMm8r
UG1QeU1ueVROVlQ2ZXdjcDI5NW9XcUdiQjZRcXBGa0M2Y29BUgphb01Ub2pRZm9EcXhaRWJjbHlQ
WloveWVEWnpRRnpvdStLRWRxNnRvaFBFLzNndC9KQ1dHbGl6aTBXajVYSmE2ClB6T0YzaUdOWTda
YTVwQWtWWXJBS25RdkYzdlpQYnZFandPWDlFVT0KPTkwRlMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003b718f064b7a32ba--
