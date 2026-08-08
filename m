Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAB51AA1D5
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786174031; cv=pass; b=sW0yrowP+7X9VyMbXp0obXtGK9gPpjdud79svfXGaJhtVcdVC2/4nUsXzv7O9Flxc3OMjcH3ctv+WgIcqiwnw5XeVM6sVqwA9vm7fMDEbYHjUVrdxATm+gBRhAkilVr6dooWX+acGTjYiG4zK7VFYJp+zBkh2l5ZJAwy9tJXG1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786174031; c=relaxed/simple;
	bh=zyR9TpZrW/9Oy+0WLwBOUbBndLeBbExgBZJ2Ym5r8gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pO2UkwVqkGuBAGoGyxAeqo5kluFpREc34PyxgT9hBVCeciX/PM7vxH4m3MB97q8Cai3R205w5INXD9DlLuJboyYolYWYz7jXCymFb12vUEnGTf3B/mfFa7bUi5h/wqSTlqanNhZiA1LjzbxCb8KNw9blqrCTz0OHzetfRC8bWzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRNBwVag; arc=pass smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRNBwVag"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-49c38a4f110so191262b6e.1
        for <git@vger.kernel.org>; Sat, 08 Aug 2026 00:27:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786174029; cv=none;
        d=google.com; s=arc-20260327;
        b=ZdjioL71FE75+cCqc2uewp/4NpYZULX0n2KcgaoFDB9YCuLvXUumdhLafF1+ezjvS0
         GjU7mG+a0QAZhwClYfNRzsmb/BwBY/hnuQqGBGqwIY8+v68m4/c/H7Ab037+xwOQQbGJ
         0vQ7zsFWShoiNOg+Z3Zqc8c3tYvMBXyYYq9ek52ThHd24SVz3iH6xFqPv/bZrp4VDHNo
         dhg3UfVLUwjgCe6BlA4jdjvLgcsGOrIcknSp2/FWKxknpD4Hw158Sli94FZDZah6043F
         ypsdV/HCcCx3ooEpPXcYvshq1HRE9BfVnPiGTNWTOFU4Y226q5xJKsynuLPcGTippL4h
         utcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WLTh/E9GWn0SdhR6/vfIIZ+AKhFMJmv9AXfCWD8JcZg=;
        fh=dzZik3sWO5Hm7VdeOg6TogxYFNxNltXRHvX8714ZSR8=;
        b=RI2sFu6e+SxGPVdER3X9T7fKVmsIXSlO4RPTMBt8rWWfpyXrmsGQDoPx6QAOEkah7U
         BVxVaBgOpXzrS6kD0TfhyJRDz8UxZ1kNRrywyT4M8GtBmIJ994qmZwe7uYtjUUYmC32u
         oyRY4Ppjd64ypj8IGRGwo/xPYxBL5tZ0qhIm8clmtekigy1qtldqtxX66Udadd1PLrtr
         Q7lILdphclROh3+R25lc7ogoHI85IJY9iNiuIQZI3fUNwd4upVrDMv1qA0AuDP6tcN/S
         Vme4ow+HQTiwcBqfwnfqsAxBoIJMRkmuqhToRqdtn9pCulrHqV8mKz4atuZ5g/Sumken
         AHCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786174029; x=1786778829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WLTh/E9GWn0SdhR6/vfIIZ+AKhFMJmv9AXfCWD8JcZg=;
        b=eRNBwVagEbA+vbWz5/izGzXl10/OiBdq68hc/UsHI7DmjKiJz7pMyY42F0R3NT18Kq
         LSiJ4LDP8QK/Ld1VtbxvIy+a1pNZfdlrD1LXRiABOufo3SFtyet4jRAK4RqFpmaj7THP
         d3+GmpmFsf09ywyD5BpUJ5+ZXx5/cMko7EPZytsp3V9CAI2rPn4BbmUMyhgk6QIlI9l2
         EFqAtA+nsh0wnKKz43nQcQX7Yv76XUV0PQYEmmV4RLRXYhz8NM1lafJpVMliF+B5nd46
         DFxl6S8GNCsTNcVuiQzEssRR/nNoxfEiVF8syGikxorievhIvH+wdE4bDZFspffv9BQb
         6xOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786174029; x=1786778829;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WLTh/E9GWn0SdhR6/vfIIZ+AKhFMJmv9AXfCWD8JcZg=;
        b=JIcj3QU9pgdNPxig+Q/yaGHMY8vjjzIsrTyhUtVsrpCZR4hRRtd6jIlyw52aJQdRup
         mE4Zd1cpv3FPspdcQvSjWMaPZn2PBB/nRGP0ZQQ7kb5Pof2zfa3bS+VXm0ygJV8ppOh2
         js4fGEWxwsjoDBBBal/rvZWOGjhszKUfgv/Wf8EQfwXWjzEZGYQluZMwwjgRva31uCAC
         3BxbwdCFRZdD3csDsavUz5S3aQIihzsDrVXcHIYmcoGYz2hJZLXATHRtz74QoV145yOe
         5E+K6MftvDALRb6J5ygh2jqBw4Q2wcWMKbds6tHtVk86VteGb2HtVOXGXcJpivm8QMr1
         Hkrw==
X-Gm-Message-State: AOJu0YxE+saw7b7KS4VoLZfPtNDdcunWPMOXm8SXOPdiih3oSP2aaGcw
	W+Ggl0mDlQUnNNcm8woOgSbBJqCtoogZnRHgINpGz8UGPiZhA6YqplpW4PNyNUEFiOigcYIhqD2
	vRj5hHajdJxg3NSmylMVta2tMrAw9zaI=
X-Gm-Gg: AR+sD11a3E7zb/YrGZNVOUusPUxrYMh6LXWPXeYiQQLnmta0OmzEMVUUnRfoidXwZxw
	gv04f/jqDlldfLIZ15bJNKGdyOs8Sea7Wr33Hh1WQPk5im/kN3JPg7ZIMW1vMnON1MWpF3RVgBb
	9eFk75cIIVwYC5Sev+Bk70/tFEeHfhgZE/bR3or+KwxJsrnUw1UHthYRAPWy5jCX0JCI7/tr8xT
	O/XZh/hpY9WAIM5VqkDkbzJn4/cRQqO5jWMYroGhWYJ6LJ5uv/Kw5Q73bzZmMY0uLmN7wkd8/Zx
	U1h9u+v7Btkle61yz+AMEPtSumGJIE6Fm2fYvzZA8rw2lxZd95n9lUMkG4nXDos0llOdD/AZLiG
	3AQEMa/1muDBTTIIM/3eWn66BaZihOujrZmHynT3Q4LKABRcw8VnTDx0BjV1Me4g=
X-Received: by 2002:a05:6808:4f68:b0:4a4:c623:4c0b with SMTP id
 5614622812f47-4b1a0bcbee4mr5399043b6e.4.1786174029103; Sat, 08 Aug 2026
 00:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716165517.433849-1-christian.couder@gmail.com> <20260804100355.1299498-1-christian.couder@gmail.com>
In-Reply-To: <20260804100355.1299498-1-christian.couder@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 8 Aug 2026 00:26:56 -0700
X-Gm-Features: AUfX_mxOVMIk_mks8DiiF2BCwUBdXKFva9lKUdjvPwsA7_LgaT4ZmdYE26BIYto
Message-ID: <CABPp-BE_gVtCF+Y0AAyXSXnJ2hUK0pJiWqEhkD8kVc4S8-y7kQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] fast-import: standardize usage string and SYNOPSIS
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 3:04=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> The goal of this series is to improve on `git fast-import`'s usage
> string as it is obsolete in many ways.
>
> As it appeared that a good way to reach that goal was to make
> `git fast-import` use the parse-options API, this series also achieves
> this secondary goal.
>
> Along the way it modernizes "builtin/fast-import.c" mostly by using
> `struct option`, by starting to remove global variables and libify
> that command, and by introducing a new `OPT_HIDDEN_GROUP` macro.
>
> There are still many global variables left, so it's left to future
> work to finish on that direction.
>
> Anyway the usage string is standardized and consistent with the
> SYNOPSIS in the docs, so that the command can be removed from
> "t/t0450/adoc-help-mismatches".
>
> Using the parse-options API also enabled some code standardization and
> simplification.

Thanks for doing the cleanup.  I read through the series and I'm
pretty happy with it; I only found a few minor things to comment on in
three of the patches.
