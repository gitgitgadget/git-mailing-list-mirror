Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A252B397689
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566605; cv=pass; b=dVkburbiiiQcz7xTLDWHl8qoj+b/b6R881iLLrlf9DrRrt/GewEm4RyFcCuwDpeG/yR8dGeiJUaOIl59ZRZhmTtfBr2FltQQkzIK8v+7jf+GVejWBKJ0M993ZRg5CL5j4B6hJz6oN3gqsVZvNJeGi5dY1KyryUhiRcbaVX3epvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566605; c=relaxed/simple;
	bh=T5HHi5kU0LpgM2ipseB9XmWFRTLZ9l0aKlbA2MTcRTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0WprUav9pf56mAcYVEs5/Nx0v/Zz/t5MR6gM0+i6qY2Jpj3ZgEAu6bQpPuUx/TUjI5GW4KtEuPiA/VWVyi43nFp3+qjr50GavbgxA/1JC0aHYFO9afmTkAFM6c5LBmTLnt/e7RIcpr5Ee639hwVEUxQ3B34zoFk6wdbVjUTbL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIqkYCSK; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIqkYCSK"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-455ca262ccbso34429fac.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 13:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786566599; cv=none;
        d=google.com; s=arc-20260327;
        b=CETlTIIdAtFRngniKSAl30FsVFzmKLMn9fSnMJBAjXO+bJs5SyyDGK6K5hjwm8RGrV
         x6ixM4MdM3nDG6hS3C7HGdwoPeTeXl2eor4htfdiVkECBs1v2CC/ilZ6WV5NhkiO1LRx
         o1jrd+ZAUEf10jxh8JF2RX/D2wk6PHbRYqKGALlLzcgki9xPxTA7q15Snk2g3AXibovh
         9p66se9ULF5J7y1/CIIXnanTqg+rvCfi14lGHJ4dP/1pyU3lrxtXHhfXpC6I7r08geWO
         JgiHidMT/WpO5/97CAYatFeX9qvpcrYFcdGX0zjjQvp7K+bKkNVAiwz82DaQM3EckdSP
         GSwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0JcyTKnO/KJxlEXVYdRSUWFTObY8LDbXRlG1Lop/nac=;
        fh=dzZik3sWO5Hm7VdeOg6TogxYFNxNltXRHvX8714ZSR8=;
        b=gG9CvWoAKS17bDQUXyG36tYHDK5hjmhOgqBSxKfsp9wpflc0iv5bGyi7JGoAmEXtPQ
         LAeXgKtSIg3g5p6kpOQRhxJFVVmWEG8dEbnnJAfsARFVdw9sBxyQ13u1CL8qT6EeQIUW
         VFw2gWgxSCegSjQXbcqbxrZdjynzR4bRyw/iP3iKP05wYIHGrr05xn/njeEYh1Km91mX
         grkQgwiW03ZtA56kmbJoemlnqBt3YivP5P/XGFKG91781acs571t7igkvJ3othGfXGoo
         PEWoSGiuoXw+0FiG8szB/lSzKplpUocgSHenmMW0QEJ5P2XK77FoICuvcnBe0zZbD8ZB
         PeGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786566599; x=1787171399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0JcyTKnO/KJxlEXVYdRSUWFTObY8LDbXRlG1Lop/nac=;
        b=DIqkYCSKARCqW6YbYHgaK25+M7LQ55UYdgOMwbdrj3WFok0JV6YzU6+BLX6WDV5JaL
         sTpjcav6ko9N2NCRdWTM4/bROGICELyenicW7+6lXR0nX4091jEalAk/LPKEaJvUeikY
         convAlCrMUiGI428pZwBTXevWkJ9Am2K/qNaja8duurzI7WRfdXWXVgVBbr12ewkR2NM
         EKR7bFVSrWrRVMVfsV68WD3qLR/u/Ihh4YeVcR0bQ69MYmEPhKyKOFnabavruz/3pGkO
         Qa3rH8NNjFdDtz9clC3/AQ3LU3qLVsfFNgJxgEAkhfIzTiftls/zdaCbnDdsIaxKzX//
         Fbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786566599; x=1787171399;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0JcyTKnO/KJxlEXVYdRSUWFTObY8LDbXRlG1Lop/nac=;
        b=LN1q0zk6W1Lry2NlYb92T07CfiPjRA8YyulpdyoERTrwAMb4JhN7GdaicR772GFnqw
         bRoa1ckWbegMBZsBosbBlB42LI1rXW1l8VgaCTmID9gsc6N4cWO81T+IqwZzBNRvzcVV
         SvVSN8AD7k1wq2oOlqCHlPLqZnlcGi1epIPyqY+HkWzB8PQIEqgscVcu3UTGO3JNcV3B
         cyZd22zRb12MtG1E9O7f+Qqapaab01o8flStvfkDqD8mWP6GbpgVFNXysLixwEbu4ZoG
         oBJheQJFFlFTWvVC7QblsgBBarWcvaNaxsnF4AN05ixOyui+faVHXCdqgX2NS8XOgPNq
         0zAA==
X-Gm-Message-State: AOJu0Yy9lGFwz+ynPmQcy5XQwiTWOmlqTV1C1n+BjPqJR5RoDGsEzTpi
	YJUsMyOZgjEELX6VUq+5bRsQDVdaxjSZgdK6A8HZxxAVKitkBPez6rAsg7FFEJP6x0tJ1xEFiqJ
	a0vUd9a+kMCnDoio5Rg/pSmOY1DFr+h8PEg==
X-Gm-Gg: AR+sD11bnVSS5c6wK/xzGlCf4ZEB8H5DMCN+KpErYdpAyB8wMQVVGYZcWUQFI3cKk/X
	XyWfWhbZ5c3+FUCeMn6Z45gWgCxUIy7wBSfvWCbmxlTpNxiafzqkXN1x0JyWxcPIWqQAqzzbUYm
	eHWT/G0iHImySDqK0L+pv8cNhzmwy3EeMaIh7FvXTS2U3jINwt0I5CUGOmwsTJlPdx+PqdaRsG3
	4dLoDSW8d3QEb/hKCmV1y4fEU54DVsecmTImRfmoERlJupkTiJd0OG+4GKUp59/yN1X4FGXn4K8
	H8fmWmoSEgfsEwiDSPvnvzArGM4vpn4Xdcnmu4YJN2nMGRfYHfQdardr9UOF8QBOZ2TMbpelv2p
	vSjWwdgz3SGVzN0JBsqmX78++BQI+lKb9QzBojCDWZnxdZwgrU8g0jzYOxnXhP3k=
X-Received: by 2002:a05:6820:f010:b0:6ae:a950:9fb4 with SMTP id
 006d021491bc7-6b0c461db5amr942631eaf.33.1786566598650; Wed, 12 Aug 2026
 13:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804100355.1299498-1-christian.couder@gmail.com> <20260811083314.2023489-1-christian.couder@gmail.com>
In-Reply-To: <20260811083314.2023489-1-christian.couder@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 12 Aug 2026 13:29:47 -0700
X-Gm-Features: AUfX_mz9YImzBudfiHqjglfJrQkxZtVMteaK2Ba8myoxw5RyQ6cHAiDvZb_4uqo
Message-ID: <CABPp-BH4MmEL5vZv7ZoUufT8quk4vCq==Ef_XAfxjj9U-WBsEw@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] fast-import: standardize usage string and SYNOPSIS
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 1:33=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Changes since v2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Thanks to Elijah for reviewing v2 and Junio for reviewing v1.
>
> The series has been rebased on top of recent master at 010afd3166 (The
> 12th batch, 2026-08-07).
>
>   - Patch 2/12 now describes `PARSE_OPT_LASTARG_DEFAULT` the way Elijah
>     suggested, which matches what "parse-options.h" says, and mentions
>     that it should not be combined with `PARSE_OPT_OPTARG`.
>
>   - Patch 7/12 now wraps the function signatures that grew too long
>     when they gained a 'struct fast_import_state *state' argument, with
>     one parameter per line. Patches 8/12 and 12/12 have been adjusted
>     accordingly, as they touch two of these signatures again.
>
>   - Patch 11/12 now also lists two other behavior changes that Elijah
>     spotted: value-taking options accept the space-separated
>     `--opt value` form, and a bare or trailing `--` is now accepted.
>
>   - Patch 11/12 also documents, both in a NEEDSWORK code comment and
>     in "Documentation/git-fast-import.adoc", the third behavior change
>     Elijah spotted about `--allow-unsafe-features`: as the early scan
>     for that option only matches its exact spelling and stops at the
>     first non-option argument, it disagrees with parse_options() for
>     command lines like `--allow-unsafe` or
>     `--depth 5 --allow-unsafe-features`. This errs on the safe side,
>     as unsafe `feature` commands from the stream are refused in that
>     case.
>
>     I plan to work on a follow-up series that will improve on this by
>     teaching the early scan about the options that take a value. It
>     looks like the parse-options API could provide some helpers for
>     this, which might benefit other commands like `git` itself (see
>     handle_options() in "git.c") that need to look at some options
>     before the actual option parsing.

Thanks, this version addresses all my feedback on the previous round,
and I spotted no new issues introduced.  Looks good to me.
