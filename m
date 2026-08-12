Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3A43AE6E9
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522758; cv=pass; b=nAgkRbAqHqhYo5/H+lBuyG5QYNLOlTTCohgV+P4eNsWLVLyUY7+0PoitoVl6rLFzyz4EdwvGQP91Uvd3qzlW0u21jM+ncfCLnXgyU7v4jKxaUNgVTufYj/lpqq9VSnFu4XppUjqKAXBQL3KkhPdRwemIRYgNtT8iFla1BVJjgJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522758; c=relaxed/simple;
	bh=dmczBZWb2DyeTQm2eP+RRv8fHV0PBy3IEDGiGmklvjU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=e2uOitIbgDRhcmGhD1rDrnt2/sU7pDyoVnaQA4HSn1FSkHK7C5Lsj/kUaoBeuVrvZBmG22rAsvkTS1BwM3qugeUiUn1shwQAW4UwhM94XixSasalUZ19GDIYvysYNAbZbFRlpzmf4JfSxa7j/7Y+dieo10LZXW/wXEZxg4w5bss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YreWE8od; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YreWE8od"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so847333a91.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 01:19:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786522757; cv=none;
        d=google.com; s=arc-20260327;
        b=imdKDag2X4LxkpJJwKFIL72NFeNlqu6osIvD6kBqnuovGU5VcdFilyUc4q2+5dcZ9d
         Kz345HKUt1iypxuHI3jXmJgAH/T5zIwBVAAIZLxqNc3atztSoTSL0rD4tUMHxJmUXJNF
         jbUsI8Ef3+ZGQhjGD3dVX+d8xl1cCqKgEHG6x1XORZJpGePRfaKJsSzdJ1/8oNR+imbJ
         WB3JzsfwT5X6WjyG1W7Yk+E/hj+YR1AmR+5KbAsTQCnr4iKnOM/l6YBLjq54SATHHV6H
         C6oncqM6cmUHelJuLlyOTvzS4GQJZlKStuI3D0o7aA2kZBkfr0DLAiufLAD7bLr4hGan
         Su1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=jp8KYXtopeT3aW1oJG9xVMguOBpvV4kbwBu6LhDQtIg=;
        fh=+5tT1aKk+CtzdL1zo27lJJY3q12LN1OD5yGaqIVXtBE=;
        b=Qd2ZkFiailmzvnbAQ+Yqbi2q+SesAvTPEz3vklD6PPJIpB07oJtLbWRD6ewavlC/Su
         OK+QaLSIPk7JdhOiCYoe3tMgJ/34GFemBgc1e00T6reLrpskA0Ikscr4rNKZ/sNPeXxy
         ISQ2bET3HsngnsXYjJTnGngsLPjWtCBrpU2oKW5f1fDtI1tDSr8CkWR0HJk1j+pOS3pI
         cJFYpJWcs2Jb9p+IvPja6/NFU80YrdoDPRzv72cpDDwj9k41aAEk0/qLxUAiK2hK1EK9
         WQJLEAnufYQlWwOMYE/uVItU6//4LZkfXz4aLXbR/kMmPLra4nqytZU41eMsmN54KrtE
         fS3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786522757; x=1787127557; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jp8KYXtopeT3aW1oJG9xVMguOBpvV4kbwBu6LhDQtIg=;
        b=YreWE8odK+XBXGIPYuMXXJZk1jHpNwULO3EuV1AMz9xEttaRXRLkvHpVGQHwc69yL9
         iSr5iz9KvI5wKpE9xRD/0nz8yAJwS23ZTD5MqW/UyHWZ1y1Hcynqy8kEExsRTJ/GdR8t
         ktZQf+Nk5kf94KZ9PovcdM2PsqbeBCGEXWnb4wNSIgumn3YFfZFFAVl7UoVkunho5EPC
         Li4nN3NiBJkHM4HqhlEXugZiI06ZAcSlL0UyZsqnATQ6w1/p4/s3ZDzaDNwtFwb5OPfF
         gHumM5leLuwJE86cSCogbvTR0T8+1PVyb6RGFrIVkLweXRZ8wl09fUGaU9n2qCxFd0Z/
         NS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786522757; x=1787127557;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jp8KYXtopeT3aW1oJG9xVMguOBpvV4kbwBu6LhDQtIg=;
        b=pnUaDz9qI/aPDgsPU0ktKWbq0uKEmlpgKmqc7cY9tbk+Of8l0SQ817nR2HYZdxRTnc
         ohAm54oyedkjleVsEegafz10J/MYBOQTU2MMqzm+X04qHp+Qp9PwjkH19VueTMVTs5ND
         xamxamsrXiuuAQKXLQxqCanKO52NdgJPxkK0ZnUM6vLiKIkBOw8FGPkki72LWSX5MUOB
         fgfj8H3A8lTMP24+AzC/h8Q2XgOgXoogcos4uecQx7/JiLGaA/Y6ZKs9R0QtDGeWttUd
         Hx1XcQij0EfKV8H23Bdn9v37KH8afNSyYm6Fxx07lEzZYJ/iGbuMr/mPrHaLjk7wGa8Q
         L3Jg==
X-Forwarded-Encrypted: i=1; AHgh+RqNRbJ78uFVH+BxX8m01eGDQcjh9v+UQtYST7CDu5wtdGEPZsYhLhHPA8fYE/Lv2wAuaVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YygT5trTOKz57cvcu3N8xUF7q+TF7OFqUnwRLpAnsFsFPjCO5Jx
	yLErQDVH22sxJRYqhgIcU1IveU09uqXkmvn3AzHBSTzAZxHFDkjLTbnggDLDfQuGM+Dlu9hdNe/
	AT6/CJbDThI/MBFuILiPaPvAcY+94jFk2zV2i
X-Gm-Gg: AR+sD108W1Hmug2025Nvp0QZI87uBDcqIHAldqVffg7+0cjjkn/hT6snorzy/0WShvy
	WzrSOER+YsC3E3B4VIWV62Gncs8kFNOpeAqqdYDxFYi9VQC8Aa7/mggnVOWnAf3oEtp5Q0Cn2RO
	sH6hhb9dDC7Wg8xsGAcxyeqX4qXwKJTJ3NfZXL6VJZ7dlJHHUWFkk5nv/4HGGWEivUrVa9tQ3pv
	ai1eS28+8/Vc7g8he/nIuv6JV1XjHl5mKijcRpXHThmDLn/6IGIWXZbbKy/CaibpAmU8cHh16xv
	Hl1p2LiZMLa9lOzYeZAk8uEdsOJx4Ac2LdxcFh55obamQzV8pOeiBZluJ8Ki9PK5IYybmUmoGhP
	Fsi1+HgPLg7XnlOj/RYU3AZVct+IbuQUToMDCND/IjLoGug==
X-Received: by 2002:a17:90b:1f83:b0:38e:59c2:cbc5 with SMTP id
 98e67ed59e1d1-39301678a03mr3532239a91.18.1786522756644; Wed, 12 Aug 2026
 01:19:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Aug 2026 01:19:13 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Aug 2026 01:19:13 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260807-pks-t7900-fix-flaky-test-v1-1-08d0ea0fbbc5@pks.im>
References: <20260807-pks-t7900-fix-flaky-test-v1-0-08d0ea0fbbc5@pks.im> <20260807-pks-t7900-fix-flaky-test-v1-1-08d0ea0fbbc5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Aug 2026 01:19:13 -0700
X-Gm-Features: AUfX_mznpmT2-bThfO0epAknSMoPGzcDGtma4pOMMMsBDfEjmP3aysF1BbR9fyw
Message-ID: <CAOLa=ZTAV=JqOvE0xkE4zmHMm=xx40_3g42ob9RDBRXmw3u6_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] t7900: adapt some tests to use a throwaway repository
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004b19d10658d53e61"

--0000000000004b19d10658d53e61
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Many of the tests in t7900 operate inside the main trash repository
> that's set up by default by our test suite. This is overall quite
> fragile as we're exercising repository maintenance in those tests, and
> maintenance is of course intricately tied towards the on-disk state of a
> repository. Consequently, the tests can easily impact one another.
>
> Furthermore, in the next commit we'll have to modify the environment in
> a handful of those tests. As tests don't run in a subshell, doing so
> would impact all subsequent tests by default, as well.
>
> Adapt exactly those tests to use a throwaway repository. This makes the
> tests more neatly self-contained and allows us to trivially modify the
> environment in the next commit.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t7900-maintenance.sh | 70 +++++++++++++++++++++++++++++++-------------------
>  1 file changed, 43 insertions(+), 27 deletions(-)
>
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 4238569b68..6735a9e082 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -67,41 +67,57 @@ test_expect_success 'run [--auto|--quiet] with gc strategy' '
>  '
>
>  test_expect_success 'maintenance.auto config option' '
> -	GIT_TRACE2_EVENT="$(pwd)/default" git commit --quiet --allow-empty -m 1 &&
> -	test_subcommand git maintenance run --auto --quiet --detach <default &&
> -	GIT_TRACE2_EVENT="$(pwd)/true" \
> -		git -c maintenance.auto=true \
> -		commit --quiet --allow-empty -m 2 &&
> -	test_subcommand git maintenance run --auto --quiet --detach <true &&
> -	GIT_TRACE2_EVENT="$(pwd)/false" \
> -		git -c maintenance.auto=false \
> -		commit --quiet --allow-empty -m 3 &&
> -	test_subcommand ! git maintenance run --auto --quiet --detach <false
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		GIT_TRACE2_EVENT="$(pwd)/default" git commit --quiet --allow-empty -m 1 &&
> +		test_subcommand git maintenance run --auto --quiet --detach <default &&
> +		GIT_TRACE2_EVENT="$(pwd)/true" \
> +			git -c maintenance.auto=true \
> +			commit --quiet --allow-empty -m 2 &&
> +		test_subcommand git maintenance run --auto --quiet --detach <true &&
> +		GIT_TRACE2_EVENT="$(pwd)/false" \
> +			git -c maintenance.auto=false \
> +			commit --quiet --allow-empty -m 3 &&
> +		test_subcommand ! git maintenance run --auto --quiet --detach <false
> +	)
>  '
>
>  test_expect_success 'gc.auto config option' '
> -	GIT_TRACE2_EVENT="$(pwd)/default" git commit --quiet --allow-empty -m 1 &&
> -	test_subcommand git maintenance run --auto --quiet --detach <default &&
> -	GIT_TRACE2_EVENT="$(pwd)/true" \
> -		git -c gc.auto=1 commit --quiet --allow-empty -m 2 &&
> -	test_subcommand git maintenance run --auto --quiet --detach <true &&
> -	GIT_TRACE2_EVENT="$(pwd)/false" \
> -		git -c gc.auto=0 commit --quiet --allow-empty -m 3 &&
> -	test_subcommand ! git maintenance run --auto --quiet --detach <false
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		GIT_TRACE2_EVENT="$(pwd)/default" git commit --quiet --allow-empty -m 1 &&
> +		test_subcommand git maintenance run --auto --quiet --detach <default &&
> +		GIT_TRACE2_EVENT="$(pwd)/true" \
> +			git -c gc.auto=1 commit --quiet --allow-empty -m 2 &&
> +		test_subcommand git maintenance run --auto --quiet --detach <true &&
> +		GIT_TRACE2_EVENT="$(pwd)/false" \
> +			git -c gc.auto=0 commit --quiet --allow-empty -m 3 &&
> +		test_subcommand ! git maintenance run --auto --quiet --detach <false
> +	)
>  '
>
>  test_expect_success 'maintenance.auto overrides gc.auto' '
> -	test_when_finished "rm -f trace" &&
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
>
> -	test_config maintenance.auto false &&
> -	test_config gc.auto 1 &&
> -	GIT_TRACE2_EVENT="$(pwd)/trace" git commit --quiet --allow-empty -m 1 &&
> -	test_subcommand ! git maintenance run --auto --quiet --detach <trace &&
> +		git config set maintenance.auto false &&
> +		git config set gc.auto 1 &&

So we change from using `test_config` to `git config`, I assume this is
because earlier since we used a shared folder, we had to undo any config
changes made. Now that's no longer needed. Nit: This is okay, but
would've been nicer to call out.

> +		GIT_TRACE2_EVENT="$(pwd)/trace" git commit --quiet --allow-empty -m 1 &&
> +		test_subcommand ! git maintenance run --auto --quiet --detach <trace &&
>
> -	test_config maintenance.auto true &&
> -	test_config gc.auto 0 &&
> -	GIT_TRACE2_EVENT="$(pwd)/trace" git commit --quiet --allow-empty -m 1 &&
> -	test_subcommand git maintenance run --auto --quiet --detach <trace
> +		git config set maintenance.auto true &&
> +		git config set gc.auto 0 &&
> +		GIT_TRACE2_EVENT="$(pwd)/trace" git commit --quiet --allow-empty -m 1 &&
> +		test_subcommand git maintenance run --auto --quiet --detach <trace
> +	)
>  '
>
>  for cfg in maintenance.autoDetach gc.autoDetach
>
> --
> 2.55.0.679.g6767b8d81c.dirty

The rest looks as expected.

--0000000000004b19d10658d53e61
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2363bc2db6ee79f5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wOEt3QVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK1luQy85QjF4aTFtLzVvQS9JQzhwQXhac1ZFSUoxWQpIOXltMUQ2czJu
MEYwbktJWG1mcmZXaUdrcldHYWZKaGN5RTRBTnQ4MXZLcEprVUZvSDliZTVqeE9hS3FCbGF3Clpj
bHU5NmlDTW1xNjR5b3F6d21TaHJEK2NtNndwQnlhR0QxWmVOSkRuZmZSdWFnQk5kK0NhakZGWFVs
YzUxTHcKRkRaTWR6b0ovaXRSMkxBRHl0Uk1nQ2dHVVJzNi9Dc2prWXFOM1VmcFNjYjR1a2s5UDlQ
NmFFcDRSbFhPK0hocQpTM0J6Ri9tSFpXa3hvaGF5aTlnRVZkVzE0UG4zVnhzSllJek81cHgzaG8x
Y3pUcm5tdHJ5MzhIRUJJMnpySTBPCm5IL1lzMTJTcHJOSVVmT0hhcWhLRmtnWFpnWFdwdlplbDFk
ZndEeExKUlpiS0YzNE80NWo5UkwwK0Q1T01URDkKcGNvMHBEbGk4bTVrZXZ3Slc3eHZiV1M5Y3Jt
amFJUjUyN3JzdHNBRENPUmxGclZQQXNGRU5MQ1VsNXFlTVNlMQovM2VXK3psQjBPb1pjRHZmeU1v
MlNqamlJeDVkcFRsSDRBdVdoY3JIUTRZdjV5eFAyWmc5MWQySXJkYWovNHFHCnlBbEVlZzltWXZu
d3NtTzBDNmpwRG5NdXdyS1VnRUpRcGFtbWxvdz0KPXN0UGEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004b19d10658d53e61--
