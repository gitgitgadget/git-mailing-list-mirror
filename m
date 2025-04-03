Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711B62512ED
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743699930; cv=none; b=G/rYK+VOW3fxixsgjJLofGn2NcY+Kkt8pcaMDV+YovWxuClwfxro07L9y8p9yUyKC4EYp8sF6sMdYuNc4vLoItt4da/AYBbymbRt9GEqRREeNwd0otXsexr5S+2HHzmvLRs9Ns/TrOE7MZA+/88qLE+zTqJt205fNs3uUMfG5Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743699930; c=relaxed/simple;
	bh=EVx7oKYtsszoPfRjELLPHP+GUZKXY7DIbv5oaxd+MYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXZ8yKPh1Ln3FBDCQtvY/PsisLOixSBOaSWTvrZYhiB9RZkNzuRBEhqgb7+ZZKbIlEpOCXqygGxOjvb1FrGLpsKA1vg5RyboMw1XY/MlhaCz1mYs3JNpq0TdvLekZRq90SLPtS9ABnJGaOGi2C+J732Nr6yHC04rhGpZ4Mf0DcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ed0d921c6aso1603526d6.1
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 10:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743699927; x=1744304727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6Wx8F7SkpcIQz8APGUiDjshPzt01WFK0P5WY6q1BE4=;
        b=m0CtotGS6fqGMI7LH8NlAtgb7CR905FwWHypK+Ey2MHuOwlPZjnIuOjMX9cXAa6F7X
         QxTDWoxrZ/RZ9NjlE1qi5zytaLrE9m2BvTqJ7w3aTaU1pJsZWNRORrzUX56fPdKQCvK3
         DffR0h8nGd8Ki3reAg2g3jCCkQfjGwOcp0kbbUcDNcDfXi9YxIYN4gxGFrL+Dn0H5DyP
         xw7Z/M0ud6durEuH9wfzUGAxu7teNet0oPA59Q2xe0oBy1/QODGO/cXjUuh3otnDPtfQ
         49kND0NzdnX5H4s0Enu/XUYyUxe9l8sycNoGMwC1SOheCwGK30/XcViQIxEI3ElIwn8k
         S/gA==
X-Gm-Message-State: AOJu0Yy7+eyQdcfhd2qytbj2TT/T7apowNwhLI9Z0uTs079pN4evw4AQ
	etQOtMxR3hhLvYVfJ4Gs7j99dKM7pAw/bDBQMJMH03wtPYXLb87lePXOmiHKz5C1PZOjiSenCY0
	87h1ePIZh6bf2jaJzKA4+orP5C9fbx6ur
X-Gm-Gg: ASbGncuKJhziZ+UGinxKiPzdh8thezRmeSaOC6j/ovO1DyojhD5XOBDZR3EyY6tjeS5
	KkDWjaGpoc2RDpLVylOMvSaHMTN3562gWRVjNozttH+zoxXYEnMKEZkH1iY0wBZn6LaHqgry71U
	KLfI0rbmkRhGu502QK7Lr3zt3OTnSDJRA5gPvkuoqsk1X2+9B1zG6zAPPdTV4+ucJCHBSh
X-Google-Smtp-Source: AGHT+IEOZWlZjuOj6MFNXRH6g+28yFk6F0ZfU0VBR18jCPfKacvkbJH0aUF2Yv7XqTlIP+Kyr3Bv0siHj2hOFavtlSM=
X-Received: by 2002:a05:6214:c41:b0:6d8:e6be:50fc with SMTP id
 6a1803df08f44-6eef849c07bmr52490856d6.6.1743699927301; Thu, 03 Apr 2025
 10:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403144852.19153-1-sn03.general@gmail.com>
In-Reply-To: <20250403144852.19153-1-sn03.general@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 3 Apr 2025 13:05:16 -0400
X-Gm-Features: ATxdqUGtC0UH5_0S_N0D-L71Cl0cixtjeIK3c_2WCG6xxqFYvfTyP2WB4OuE9wQ
Message-ID: <CAPig+cT1dQL+MfUctyw=9O5Wd2yUqA40pXSgsRHKfNf=6vxQ7w@mail.gmail.com>
Subject: Re: [PATCH] t7422: remove extraneous argument to printf
To: Subhaditya Nath <sn03.general@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 10:52=E2=80=AFAM Subhaditya Nath <sn03.general@gmail=
.com> wrote:
> The POSIX man page of printf(1) mentions -
> > If the format operand contains no conversion specifications and
> > argument operands are present, the results are unspecified.
>
> In practice, this means some printf implementations throw an error
> when provided with extra operands, thereby causing the test to fail
> erroneously. This commit fixes that issue.

Thanks, this makes sense.

> Signed-off-by: Subhaditya Nath <sn03.general@gmail.com>
> ---
> diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
> @@ -180,7 +180,7 @@ test_expect_success !MINGW 'git submodule status --re=
cursive propagates SIGPIPE'
>                 COMMIT=3D$(git rev-parse HEAD) &&
>                 for i in $(test_seq 2000)
>                 do
> -                       printf "[submodule \"sm-$i\"]\npath =3D recursive=
-submodule-path-$i\n" "$i" ||
> +                       printf "[submodule \"sm-$i\"]\npath =3D recursive=
-submodule-path-$i\n" ||
>                         return 1
>                 done >gitmodules &&
>                 BLOB=3D$(git hash-object -w --stdin <gitmodules) &&

This change is obviously correct.

This was added by 65f586132b (t7422: fix flaky test caused by buffered
stdout, 2025-01-10) which also added a similar loop just below this
one:

    for i in $(test_seq 2000)
    do
        printf "160000 commit $COMMIT\trecursive-submodule-path-%d\n" "$i" =
||
        return 1
    done >>tree &&

in which the loop variable is interpolated indirectly via `%d` rather
than directly via `$i`. I suspect that the author's intention was to
use `%d` for both loops. Thus, for the sake of consistency and to
match the author's original intent, it may make more sense to retain
the argument to printf and instead employ `%d`.
