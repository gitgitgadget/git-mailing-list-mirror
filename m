Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADB63C552E
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226789; cv=pass; b=nf6waa3aaEvNdCdyJLZpVZB+xBfzrVr3sip+t8sr/QcSIyrtD1jsit7gPu/JpsWLGeE1sPgn+xoUSrGk/2UTDENH3pfQjllV7zYfO9u3DxbdJTaQOZWAfku0TM8O+Wn6ywa1EqSqQYc7mIZU2FZbjouALJ9JRx/BtCJrg8qZEZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226789; c=relaxed/simple;
	bh=IRxy3tJAL9gWxjlBppjZ6p9aUZbIc/cRePNy3g036Ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=d4oru8p45w5UPpIs/oeD90jiJWouU1dBbXnDDHMRmHBw2/vo3jadL0ZCRtSGiOJY90gs1jugo/3mwQ5gT551BaTuBPIP+kknIb/zLgP4ObjLAX1Na/dnGJdblUoRVAvmekXrApxDpOzmZpNc/4mi2xe2Adgx7sOEa/slSq8TBLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVbpM9Me; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVbpM9Me"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64ad8435f46so14067943d50.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 03:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773226787; cv=none;
        d=google.com; s=arc-20240605;
        b=dGNhoplU/YpjC0deqTithRFOngrHyqR5J5YYOPa+T9oYVeQan51YXZKmg2IS0HLS8Q
         1/gnJCGZ61iSyZfTLiMP0pHsLYA90dSCQTMrtbsEZgi7Ativ7tOdN/F16wSE8bdlX6Hv
         rsL2l5lUgVHnVsxPlNSlrDZXJchMTGzWE6ch9b+zeHl3zQEnlN/WbiPuqMEKiJ46D4kB
         jiy0cDEe+NTILvFCdLvjg3uxf+eZhs9+kpSjrCZN+jH9Qho0kq4GxYXiCeKBiOvCr/u8
         YD2MgaJGOJO2HtIjJ0WS/yJsHVmRColQYFAKYG9RGeYAPXGi6NywpJH2bKNqO1mMJvYf
         fFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jecj1iGmlH/K/SN79nuoUQ14DPLH2fG1Dug8DL+PH2U=;
        fh=tEqxrRpDzi30Smfngwt0DpbMVN7fSkopalTjnX/15Sc=;
        b=TR2IbvU4OE98dZ5zx5MevSGTDmE+P8lee85sLPfW8d4itunmI/MWZVA7toFdEBU+wU
         55Cv06CWxtRLejdaIhiYx/b7OzCgTjl+QLOtsdAYj+sttGtte18uj3UsRonvSI+FzVAv
         mwqn5+cFJl68eCpQVVLlrXZLFYEOUld4SAhKGNc8m9ZHVQEyIcCPG6r8AsHMLOc63u2Q
         n+z4twvaCT4es0dmYpvy6rtNmV15oWVi8qVmGEaCvYGKxC5kkmHu70AT6REXQBehpWNx
         /v0zerLX1lAqvTrkO0pdcckGrx6bR8SfxS6nwU7TLkk8kh6uS8cEHQBgZOrez7ab8P/d
         MVqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773226787; x=1773831587; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jecj1iGmlH/K/SN79nuoUQ14DPLH2fG1Dug8DL+PH2U=;
        b=hVbpM9MezPyR3Ua5XuBnISLZg3O0w3JlErawqiEdFn5zUXBzMlaWvCfXpU1CY8LeB9
         iI+o1Bi2n6qIm8RxWldkLoMEq1PEM3iL5aiyD4VE2AnOOnl5GSTOxJ+50gi2jeBGoop6
         NvClJwjvRZbPo82DxPZf4xj8a8iTVi08NDtzKPBH/Y84RC1wyJk4i0hu8wYf9eAxinqK
         cHTfNcmqacF7hmSAiLEz0ONW86PZUaExXTq3Unsu3baPdS1GnUT2TCRu5tCZwt5FLHHT
         PcdA/YE2eMvArrQLX2JoYIYrtZAdX9e/uD/CUCyVexQmII6JZE7EJDa163K1fae7LhYX
         YkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773226787; x=1773831587;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jecj1iGmlH/K/SN79nuoUQ14DPLH2fG1Dug8DL+PH2U=;
        b=CDYtIcO8n7CaQpDYDST17DSTYBFEChuYCJ1CHYuwN5yHqHjiSYUNJ+9r0LfCAwTg/P
         cI9Jpv9wfdJCZxxvY/mmfaluldFEvqdy50pL73xqXBRtMIxZavjzXZqCXxwURFJApu8L
         aaCFaoauia5jjWQdepERI/GYOrov/eRjQyiAYTTb14WM7TB8/h+eio4PQyERs6g1lj+T
         Pz1ohoxZt8VdDQLuQbGrmUgnHTtf6mVw8Mf9KbMGuRbZiiN5xtGVhyEIy5MCVJY4WcOu
         bLzQqluy1EgAF2dpULVazIyxXHYs90wXxSRZKDrz0oY2XCU8xEBy7NSRXAPPDK0q7Iva
         89lw==
X-Gm-Message-State: AOJu0YweFq7/9S0MkKElPODsfpyTkFvYCTUEDJnt1ZTOYtT9ki7icPX6
	M/YxPCmnPRAA0BvmvUxIpwnCjLFBFWSyUqJo0CuLwHUEoXsVZUpR3UvMGfjFsJ3Lvt37Ec9xTcJ
	l7/RJ5/7jsJJQkbCaE421kJpVmkl5qVKD2TNZ5CM=
X-Gm-Gg: ATEYQzwxt1hdVOELdwPghcDFY9c1APwanvx1utNKGgl4jn7spNB+gp0KTv/fsAxVmdU
	S6ZxqZd+Ez7jqtAfFMazpROU6+KRT6iZO9LfplB7EsBHBK0fpttJepTDh8n2nLnvD3IaEK/QtUS
	sQWZS2ux92jdNaFkthA9KToNvZdgmKSTSxmGfn2Tgi/XA1ooNG5oHd157bthcBsIi/l82rBeANJ
	rviweDy8HB7tGHmmMN1BmRwCKsfOhEDi7+UirtpHg5Y5sS/0fLcG10GVbSdUHIUnejUEJZzSVRP
	yY1Yia2Qfzl+nU8JxdEIfXR+TF4JaQnuMZxGmBLKUJsxbwCKqvi01QmUjs4D8jp11mi7+6FaPvi
	mL+vSpZ5ZDaCImnLMUyBttWI=
X-Received: by 2002:a05:690e:249c:b0:64c:eab2:e4a6 with SMTP id
 956f58d0204a3-64d656a4677mr1144296d50.13.1773226787192; Wed, 11 Mar 2026
 03:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309150935.578465-1-pabloosabaterr@gmail.com> <20260309230134.758107-1-pabloosabaterr@gmail.com>
In-Reply-To: <20260309230134.758107-1-pabloosabaterr@gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Wed, 11 Mar 2026 11:59:31 +0100
X-Gm-Features: AaiRm52tVp0FEoEP4jXJZsZWyfutUHWuhl1cEFydIOhVu36dWxkNuW7URlKWBrE
Message-ID: <CAN5EUNTNu5NYgeJ0OQSS25Ld_kJqtEEPGcXrg_EcyRdCkr5ORw@mail.gmail.com>
Subject: Re: [GSoC PATCH v3] t9200: replace test -f/-d with modern path helpers
To: git@vger.kernel.org, christian.couder@gmail.com, 
	karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding project mentors to CC.

Thanks.

El mar, 10 mar 2026 a las 0:01, Pablo Sabater
(<pabloosabaterr@gmail.com>) escribi=C3=B3:
>
> Replace old style 'test -f' and 'test -d' with helpers
> 'test_path_is_file' and 'test_path_is_dir' respectively,
> which make debugging a failing test easier by loudly
> reporting what expectation was not met.
>
> The instances were found with:
>
>         git grep "test -[efd]" t/
>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  t/t9200-git-cvsexportcommit.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit=
.sh
> index a44eabf0d8..4507e8e6db 100755
> --- a/t/t9200-git-cvsexportcommit.sh
> +++ b/t/t9200-git-cvsexportcommit.sh
> @@ -31,7 +31,7 @@ export CVSROOT CVSWORK GIT_DIR
>  rm -rf "$CVSROOT" "$CVSWORK"
>
>  cvs init &&
> -test -d "$CVSROOT" &&
> +test_path_is_dir "$CVSROOT" &&
>  cvs -Q co -d "$CVSWORK" . &&
>  echo >empty &&
>  git add empty &&
> @@ -303,7 +303,7 @@ test_expect_success 're-commit a removed filename whi=
ch remains in CVS attic' '
>         git commit -m "Added attic_gremlin" &&
>         git cvsexportcommit -w "$CVSWORK" -c HEAD &&
>         (cd "$CVSWORK" && cvs -Q update -d) &&
> -       test -f "$CVSWORK/attic_gremlin"
> +       test_path_is_file "$CVSWORK/attic_gremlin"
>  '
>
>  # the state of the CVS sandbox may be indeterminate for ' space'
> --
> 2.43.0
>
