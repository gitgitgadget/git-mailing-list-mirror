Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D57286881
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787938073; cv=pass; b=ljAHAkHsLPZleLec59y21lSXZiMvCfKTKNEYSiPSdngPJWbQBd3iUKcSSxdKPlLv6oDrxdu6BlXZqqfVgjecJotMBrMBZ5PFscTUbnW3Th5xh/w7OGY6QDpk0eC/96r80yQolAFaVQsGROZq1Jj4CpXnvW2shepqFJVo99fhlB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787938073; c=relaxed/simple;
	bh=47xdcCFhYHmfUNmP5+Iv83xD5XjVmWPtwzER8qsOI2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jw1RLIzouHBlMOS63b9ZKnoRG7ghGItHV8+ncEyDIxLrxUJPAJmATPocd/KExVaY5IRXemsdIceru/c2CGKzhfOxZ/FF41yT6VDHUw8iuVg8hG1smePN2aQ0Q77NhkHuWBjnE4CnizhqlkM/qG78dfkxU0/DyoWFNWKUkbRynHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBFZtwRx; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBFZtwRx"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4678d3e490bso2010904fac.1
        for <git@vger.kernel.org>; Fri, 28 Aug 2026 10:27:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787938070; cv=none;
        d=google.com; s=arc-20260327;
        b=LikewHq3SdrnmXS2OjZWY1EqtfC1i7IXspyNXeuPAnC7xA/RAFlhP3EtBrbLDCTj6a
         OUlJ5GAsEmHTD7TTv0NljlZZ+QyaD381s8ePYpabOa8MPGiJH5jBMf4qi+jiAeTiMk9s
         +y5GZz5z7a4chYBwKllMsNTQiedTgEbXvrzqM3mg23wki4OcJ2esFqrLA78TGRwbUr3C
         Iy5aqGtdgzJ3y3g2+rdaU1tOprjFTcFK824pNmx9T8IgJoqQD0YPddYhkKBcLIjIaBSl
         Gpx5ZAeCvLMSP+GbQzSiIBmtoTEe4/704AsDm6PrH4cZlDbmIOsIjQUw492QKZg4g8XR
         LL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z6aaQk+tVC2JDMHseGLoHu5BNV0xojvS9pn3rywns50=;
        fh=LPrDpOBqLx6qT70YJs+UVENM3dISXSLn7kfLjIXoTdE=;
        b=aXfmnyh9nSvPoWNpvOw5f+f35zRVaDWs7EGPHpLtSg0u2Ke16+1QgB6oPD0lqiGGYO
         7tCrcyw7MwOSCuW7CPxQtpjjRi7k1xS6isyFlLHutBI/z9NoXaJB4mczB3ENaMZS+1vk
         GWpBWSW8qcovxBPr9Dbnw+oGWAQu9M4e5LplLcVcHYq7k0JpKskdwbv+Ing1TnqHi+O4
         gEifDzZjhBcyAV/RvDRSXKRIX/W7RMeMgbdN/FA7XCJYsjkFfOe2IPMFHwOh7SFipxRu
         dSLjIHep8ffwbvbx3J0g8scc7SrXVl5ksuIozauTyTJrJnu8IDKioyDBX7tUXayot7sz
         QWdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787938070; x=1788542870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z6aaQk+tVC2JDMHseGLoHu5BNV0xojvS9pn3rywns50=;
        b=QBFZtwRxd64oRXSa5a8nPUfTqw0z5ZgJoQDRz8BZSHIpNDmV6aSvh8d0hAtmtmF/f8
         cAZPfg2QSzfh23Py0m9OiUsRrPoj/ztWOcNBmayjfSapo9mjhQDXRLnyFM8e9aoDjx8h
         Qfgdg7rzuFr/wC+95Tsq4cKmJ/jyZMpF1n9X4uVLYS2kppT8vXLz+szv3tS2gCbD7LTf
         GyLepnU6ajRBK+KxrHVrAUGa170KSdt2kN/WzXCdXHcODUXW0Sr/+7h66UTZsUZe/YAi
         NbhEHFt98qWdaFjTmBr8X94huPW6AvB/8IzySZOUDS6Bd0YAcRZu/dGc3/F0n6fiu1T4
         Fhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787938070; x=1788542870;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z6aaQk+tVC2JDMHseGLoHu5BNV0xojvS9pn3rywns50=;
        b=OwFy0nMHwsEc3jyYxHsAf4YoxDqq3sf5TYpd4HY8b735buhMOV5pv4ulr8OnjdllBT
         txkEH43nrYLJhGx3vxqwJ3CZShxOEjFkA9u9rPqt1HgUAKPhAEdQRbIs+GxL5BB1vV0o
         L7WRb+XDONd4ZWrqSdI5kjG3z7pqV2c8HW2SU8maLzrJH2p4qp9fGDelcpgKQnvsR0tL
         yWELTO3A6cggzBFHDKlWFV3kSmttszb+VjqBg6YHLwQz1DAQkcC2zTGqrDEz5AWYaWPY
         PXMNinTTTsvsUCWiV1359wjSOOvMPj9kN1xFSx6oYLJskHo+fqNFiRZeB44g/m7Z+jvT
         aX+A==
X-Forwarded-Encrypted: i=1; AHgh+RpgthsYirIbKf8Ks/ietk8oo+FARyMiwxECZNrWuAz2ykwOx3MpS8Q5TJLr5jA6E+V14n0=@vger.kernel.org
X-Gm-Message-State: AFuF++kVjBFsxZyXFFj9dncdYIxDJZwpBpV0Njpk62WrWLcWFzhRD5R7
	OTFcxMaLx7vlH9BgSFW1tg2QrhiwWOeczfp31uqcK0W7w+FGMLLjl+33aNV+g8oCav/mzQIT/s0
	djrJrUCOYHE7RJ1dDl20WN04pGSF/wOs=
X-Gm-Gg: AR+sD13Jcz2bRUo15Yra9OMLuEsOw1p6yKfb9WRfCoFNaQlV+gfv2Y8BqLH1Fvf4xX8
	tGSX3amX2OWjT8bQq3JH9667q260s0GCe1xXPBgiua0Er4shLZPBQfehc1LSG6K23QiOfpJfiwU
	x/aU+VWYWD83nAzV9w9t44dah1LqRkfk5nxQADjNBKK2vE1shGYvtjICaddB43oABndEMoH7vIj
	LWU+mzPPr4B5z5CxzuZCoFmpWdItgty4Pd+J1SVLqPtb3qDeU8wlOGcRBN6bxmdo7SmwtL7BASg
	ki8pmpvkf0PlP2Cq1pIGaEB7y3HCBYvvQ6fpnoodM+HyyM2TWFPyja1rmkBE7SodB2wN5E/z33Y
	+gvT9wkQM4qk8J+b8uK+BMZRiL9gDyXZE9Gtm7rBTi2A5v2LlmF0ASQfzKtaJ
X-Received: by 2002:a05:6808:d46:b0:4b3:7baa:f944 with SMTP id
 5614622812f47-4b37c6e4dbdmr12938268b6e.2.1787938070605; Fri, 28 Aug 2026
 10:27:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
 <pull.2389.v3.git.git.1787903085.gitgitgadget@gmail.com> <7e198a20fa47f0d5b2c50ffc7046bdfc792b62af.1787903085.git.gitgitgadget@gmail.com>
 <xmqq7bla6ymz.fsf@gitster.g>
In-Reply-To: <xmqq7bla6ymz.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 28 Aug 2026 10:27:38 -0700
X-Gm-Features: AcwNN1Ux1rG8upjePblINzcMBEf6YwGbqNAvXOXLqj80Tl3f1U8BaUCD9IGz4L8
Message-ID: <CABPp-BG0AmOgfT1CrS+hTo8sRBd4J1gT0_KN8TRBHSFo86hMvw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] commit: clarify FROM_REBASE_PICK and
 is_from_rebase() names
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 8:41=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Commit 430b75f7209c (commit: give correct advice for empty commit durin=
g
> > a rebase, 2019-12-06) introduced a FROM_REBASE_PICK enum value and an
> > is_from_rebase() function.  Those names failed to convey that they were
> > specifically about hitting a commit that becomes empty when rebasing.
> > Clarify their names now.
>
> Becomes empty is different from picking an empty commit, right.  I
> am not sure if "is_from_rebase_empty()" conveys the difference and
> more importantly, I am afraid it hints the latter.  I have a feeling
> that EMPTY_REBASE (instead of REBASE_EMPTY) may match what we want
> to express slightly better, but not by a large margin to make a
> difference.  Perhaps Phillip has a better idea?

or maybe FROM_REBASE_NOW_EMPTY and is_from_rebase_now_empty() ?

>
> > While at it, change `whence =3D=3D FROM_REBASE_EMPTY` to use
> > `is_from_rebase_empty(whence)`.
>
> Very much appreciated.
