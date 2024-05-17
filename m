Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D6417597
	for <git@vger.kernel.org>; Fri, 17 May 2024 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715931417; cv=none; b=rn8jXBMrOOmir/hiGj9CGNRq0Q3DJNAnlomVo5TyVt5JNwUNBixzE46JFhVuOYk/CeSLmcs6YdjFrqPbeYdw20vFAFm4AqyUoSJ7JvMY99fote4zOreHVAZfxEP5h+F7GeR80tixOoZIqG64jFw3ElTtOeZ+qOcbyKkspYnVxmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715931417; c=relaxed/simple;
	bh=nSCDkLQPQr9cFXwvM+T4IZ9dh27HyqX6V3ZljfebiT8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVIDROUUtdlGwvgxKjlo/Qi1KpL7P+m2vPb4c8e68WaAAqCTafimpVfT0wK3r6oXzsN8/P2sfaZ4sSi11EutU6/2EPsc+JKlAfxYA8PHjdtxSAd5+o1P8et0herx4QAnoOFfh7L4B2uY9fquKdaVj6KqA144r9dyRuzm/HXre64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALtVC8CJ; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALtVC8CJ"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-240d0a89bb0so149029fac.0
        for <git@vger.kernel.org>; Fri, 17 May 2024 00:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715931414; x=1716536214; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wp9JKWYH09KowBkenRXNBjRmFcfYL9G4pnCGDQInq64=;
        b=ALtVC8CJW8HbZ4LtMpt2hqUx5OXos/Pn9sdhcbW+PCu+aUo09zRYHV2S1jIcWDJh4p
         X+ieur0WOytnCqAEr/eC1mB4eLvBrtV3NHRHymkEtbRV9VWm92E3eXMc8rWQ8Jpm5Z/p
         rkVsXegoqRGRhxbayayfO8kBf7ENsi/YsXucXy6mOeViNs+Gb+TrsYkFexYPJ7tUJmzw
         V3JLFZL/zLn5gozWA6ZckwQ5Xn6XVb1ICchGRAxHUfXhMdOAW4y4XK7B2VSF0y/7Jz+B
         8oak1dCZI+XFqEZ9WSH3vzVQUAsgXjLHCe8nXU498R7M23obJHJa7qLg4UaXIgF6yjws
         pp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715931414; x=1716536214;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wp9JKWYH09KowBkenRXNBjRmFcfYL9G4pnCGDQInq64=;
        b=ZA7CQUGN4k9bKpS0aO43xSYDyIybFI8bpL+BsXYl5Pi8ibuUb/XTXaT6OywC0+M3q0
         IgBoEYH0TJn981SJZ4qAujcc/W+sxX0dYC8VGNZ/IR2SPsJn53jcP0jR1THA9sjgZH39
         +4P69dGeZp59Uv/DpI7qGC4i4jHwDFQGh2VCyb9X9XbNjdC3u8xVWZbmYWh+7M76bmIK
         NE0iVYfBxOIP/0OUbZ1BAnAEaVIDsXuPBhtjJOQa88abd+hF8xJXW6RHYP3qRp6niG4V
         5nNCmTramF3JKj/Cxs1n/rcu8WOdFjv76mDWK15xTCwAK/0945vDHw0qgw+Jq0EWedUf
         gZRg==
X-Forwarded-Encrypted: i=1; AJvYcCXvDtz95AhTYg6YI7+9WHnjq4xF3X0SuwHC1r19ae6D+lf0iVov4JXshYZQmgy4Vfj+s7Wjx4ii4r3SfpxYsN7aSzZi
X-Gm-Message-State: AOJu0Yx5c/NHNhZ1QCaSlq1S9bF1vsc3NrOKuyIVqJPhmVGQYHTBdokz
	ey8HFBG+OBDjGt9yEqMSw52YrNblJBXwULSYa/NWLeIf4SJefl+bYUKwyhtfRQtH4i3wupNV93S
	HoYiKNQSP26p0gjU/hbkWvY6aKkI=
X-Google-Smtp-Source: AGHT+IHOTE/qx+79JLfg6+36AlA6bFsQGXVqeaoI6CA5bJ25Xp55WN3tO+70gRcp7qU0391YHkv3Z9KbpwSORsCynnY=
X-Received: by 2002:a05:6871:3794:b0:239:71c2:b2b5 with SMTP id
 586e51a60fabf-24171a03b13mr9826627fac.14.1715931414336; Fri, 17 May 2024
 00:36:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 May 2024 07:36:53 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <pull.1730.git.1715742069966.gitgitgadget@gmail.com>
References: <pull.1730.git.1715742069966.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 17 May 2024 07:36:53 +0000
Message-ID: <CAOLa=ZT=x6bmnvJO2KtbJvVOvt=4LH1RgU1NMJYpTgW2XXfGVg@mail.gmail.com>
Subject: Re: [PATCH] bundle-uri: refresh packed_git if unbundle succeed
To: blanet via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: blanet <bupt_xingxin@163.com>, Xing Xin <xingxin.xx@bytedance.com>
Content-Type: multipart/mixed; boundary="000000000000693a610618a16ace"

--000000000000693a610618a16ace
Content-Type: text/plain; charset="UTF-8"

"blanet via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Xing Xin <xingxin.xx@bytedance.com>>
> When using the bundle-uri mechanism with a bundle list containing
> multiple interrelated bundles, we encountered a bug where tips from
> downloaded bundles were not being discovered, resulting in rather slow
> clones. This was particularly problematic when employing the heuristic
> `creationTokens`.
>
> And this is easy to reproduce. Suppose we have a repository with a
> single branch `main` pointing to commit `A`, firstly we create a base
> bundle with
>
>   git bundle create base.bundle main
>
> Then let's add a new commit `B` on top of `A`, so that an incremental
> bundle for `main` can be created with
>
>   git bundle create incr.bundle A..main
>
> Now we can generate a bundle list with the following content:
>
>   [bundle]
>       version = 1
>       mode = all
>       heuristic = creationToken
>
>   [bundle "base"]
>       uri = base.bundle
>       creationToken = 1
>
>   [bundle "incr"]
>       uri = incr.bundle
>       creationToken = 2
>
> A fresh clone with the bundle list above would give the expected
> `refs/bundles/main` pointing at `B` in new repository, in other words we
> already had everything locally from the bundles, but git would still
> download everything from server as if we got nothing.
>
> So why the `refs/bundles/main` is not discovered? After some digging I
> found that:
>
> 1. when unbundling a downloaded bundle, a `verify_bundle` is called to

s/a//

>    check its prerequisites if any. The verify procedure would find oids
>    so `packed_git` is initialized.
>

So the flow is:
1. `fetch_bundle_list` fetches all the bundles advertised via
`download_bundle_list` to local files.
2. It then calls `unbundle_all_bundles` to unbundle all the bundles.
3. Each bundle is then unbundled using `unbundle_from_file`.
4. Here, we first read the bundle header to get all the prerequisites
for the bundle, this is done in `read_bundle_header`.
5. Then we call `unbundle`, which calls `verify_bundle` to ensure that
the repository does indeed contain the prerequisites mentioned in the
bundle. Then it creates the index from the bundle file.

So because the objects are being checked, the `prepare_packed_git`
function is eventually called, which means that the
`raw_object_store->packed_git` data gets filled in and
`packed_git_initialized` is set.

This means consecutive calls to `prepare_packed_git` doesn't
re-initiate `raw_object_store->packed_git` since
`packed_git_initialized` already is set.

So your explanation makes sense, as a _nit_ I would perhaps add the part
about why consecutive calls to `prepare_packed_git` are ineffective.

> 2. after unbundled all bundles, we would enter `do_fetch_pack_v2`,

s/unbundled/unbundling

>    during which `mark_complete_and_common_ref` and `mark_tips` would
>    find oids with `OBJECT_INFO_QUICK` flag set, so no new packs would be
>    enlisted if `packed_git` has already initialized in 1.
> Back to the example above, when unbunding `incr.bundle`, `base.pack` is
> enlisted to `packed_git` bacause of the prerequisites to verify. Then we
> can not find `B` for negotiation at a latter time bacause `B` exists in
> `incr.pack` which is not enlisted in `packed_git`.
>
> This commit fixes this by adding a `reprepare_packed_git` call for every
> successfully unbundled bundle, which ensures to enlist all generated
> packs from bundle uri. And a set of negotiation related tests are added.
>

The solution makes sense.

> Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
> ---
>     bundle-uri: refresh packed_git if unbundle succeed
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1730%2Fblanet%2Fxx%2Fbundle-uri-bug-using-bundle-list-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1730/blanet/xx/bundle-uri-bug-using-bundle-list-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1730
>
>  bundle-uri.c                |   3 +
>  t/t5558-clone-bundle-uri.sh | 129 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 132 insertions(+)
>
> diff --git a/bundle-uri.c b/bundle-uri.c
> index ca32050a78f..2b9d36cfd8e 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -7,6 +7,7 @@
>  #include "refs.h"
>  #include "run-command.h"
>  #include "hashmap.h"
> +#include "packfile.h"
>  #include "pkt-line.h"
>  #include "config.h"
>  #include "remote.h"
> @@ -376,6 +377,8 @@ static int unbundle_from_file(struct repository *r, const char *file)
>  			       VERIFY_BUNDLE_QUIET)))
>  		return 1;
>
> +	reprepare_packed_git(r);
> +
>

Would it make sense to move this to `bundle.c:unbundle()`, since that is
also where the idx is created?

[snip]

--000000000000693a610618a16ace
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 33786abfcbc6b16f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aSENSTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMnRSQy85QUNnc1B2ell0WW8zK245bXhCSWRwZk1mVgpqY0xzYzBYTFAx
M1FzcXVqTE5jRHVsbThtZHNBWWJQZjRJdW83OHlmMHl6QmNiSzdzNGFRVTJMczVvSk9kZ0tiClNX
b2NuRnRLK3h4YjRzNVd3Rk5RNkFIb2RGZTVNR1hTZ3pydW1LRFZyQWM5VnlvVHkxUy92dHMxSXZl
dWxBbTQKbW55aXY5WjVEQnV6azNnVXNMTEZ6ODY3cVJReWdDUEtNOU04R0xvNytPNHhSektxSllv
TVV2OTNKOE5jc0E0Sgo0ODgwT3JmRGhWcmlscjhTcUFCRDNzUUpkS3ppUnNkK2pLc0dhcThyRlR5
OS9BNUViSDRRd0hweWRJQ0l3Y2FTCnF3L2I4Mllrc3FtWEdqa0pHVWtTZGdtZ2FzaFFHVmJHSk1F
YzR4SGYyeFFlbDNUVjhXV1pVczVEcFUzL3E3R2oKWVBWSUN5Uk85T2lsWHQra0podjdXYTBsVTUv
bG52aURMQWsrYlBLZldTU1N4NUx0clpJT1oveUN1dEFuQ1VBegpDVERBM1pwNW80dU94RWU4RU1z
MzN6VGpCVG5KenFmbCt4eXhlNGpsN3RZemczVW9SZUdtVHVJZWhyNVZVN2w4CkwvdVhFNS84ZXYy
R2lKVFhtUWZYSnZ0Ulo1UTFWcG1Mb0srS3RiYz0KPTZOTTMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000693a610618a16ace--
