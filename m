Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15109349CCD
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522762; cv=pass; b=FT2EruGMsq4F74nq2CFSenrq2s/NrDOIZik3bc1E6h7AX/IKjUD5UTZ6TTGFgrrr90XAXEoFC+HDVKNQAzUz4HTQZspuJtlfJEymOw/EHyLayENfgMTQPmlQDcv03hSi4vzfjRTqyn9W4GcdwzqpZu9MAL1Z89SBMEhJsG2bvFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522762; c=relaxed/simple;
	bh=oi8wU3dmMA+frVTSjZffEeq1A8vtmQpdbnojj9jh9Us=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=NCabfo3hIBoVKoAIXWSp3C/6Bjq8WB1ICCucB3fYs2EwjTtjzW2qKvgUt1rVGKG1L+rjdRllA6BJD7CY2SlWEQt5M30hgQuxgSZE0J5jvu1DfL4YHBhA3pW064LibreuLXRPAioVjOtvPszD9Ai1/IqSaLYOpc3x9IK/wdIAxrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMGxZzx+; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMGxZzx+"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e041ea211so739491a91.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 01:19:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786522760; cv=none;
        d=google.com; s=arc-20260327;
        b=f1RtKnXgXVm+WEL4jyb8yvO2Xe9FlyM6RiBTYtmfE4DH74xqS51LCs9fUJ4v+6mHKb
         ZizrZ3ZO1jHQ62hV4FN1VgVRGf+vKzCDpnY7X8SPVtNaYHtuzBoLcy+XCf1wt1IC7zb4
         QshXkNfqstnVa4JUgx3+I36CtKiGg7Pk0Q4nqcw4fxhxfSdg3W8PKs61jHf03Ht40a8N
         4OG1HEo+TgpNRYwJpIVdVdHssBVz1MZ7+2io+c2aV4nhihgjXAuUEOSZatdzIEMzsRbE
         9T8lDexxfBn8DLWe22qjcCF4ib2PhMq5mlSH37/ul4tnxXuNrcqWJ5EWjPh/qUDHLGQr
         qtVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=FMlJtkurH9IchKhAFA8C0I8BcF6Xz3cYLL/kh81Bxds=;
        fh=wzn7o0g4bnORV09fHSbe/n/YsYf5ejYOoCPiETCVV4k=;
        b=HtfJLbWvKPrN+ZINzQlrSTCLpRfjwjVzyriZZOa7n+8P50OZUblPsSV2kepcGzIT35
         6F5OE3gXrFjcfbOXmEnRSGvyEmU6pa+wDdD+P84e9XUyq9jGKUjl4+45KA+TP8/BH6yH
         u+p5+Z2D2YbvM2cwxi6k6p7wwte4ckbV1P99V7hXci4YVny6ZwoakzacWYBpE7TqpnPV
         5KHlA6yfsdsurNgE9EzefcoCGJeT5Dd7rduoSlMD+1imfx8WkK5BhSaFZ1GZ26V8GbN/
         OqAJg00/r2UrPf6BAhG3akUQGK4MwZLZ+94wAA6Maq37EKYiWgmwfQX+3HdmnC9nfITp
         9K+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786522760; x=1787127560; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FMlJtkurH9IchKhAFA8C0I8BcF6Xz3cYLL/kh81Bxds=;
        b=cMGxZzx+oE1/z0CKDZWHT0ka92aRCPhaJXmgL5L+pTXjcqi3ouizz4sxMgujT8K8Am
         fSB9C53xR8T+N63GiJu8PEMn6FMk3UPIGTJfq06LR+yT97jx0nSBlxpGrmWTZfromDvL
         zoameru9hh5MU6YAP8Bo5qJk5zhTb5RSla0R2GiqDVAVjaqO/PEM9xw3ikABljBB1p9A
         G3JXLvccmGGkDSYskDHM9NgjvTeWwPbe0rw/2mKhOSzjahWwks0rx1n0lURmd2Rd28Y4
         reUEfqLHLgeO+IK8kGnj8ybBiuQeIPCXbbjgJ8yamFx0A0b5e4GaBPlFrrcA3gFxGoHT
         Yjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786522760; x=1787127560;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FMlJtkurH9IchKhAFA8C0I8BcF6Xz3cYLL/kh81Bxds=;
        b=qQk2ShO2ReiSNJBkDYk69YTYIqqgvyCVpVp/VfM4TkjHHZX+f+ElUe7beWdBJF8o0N
         mW+AmvB6lYbxRAX8/gyqzrHLrbfu5I46yO/SH7kab1TcINcKCk1cqhpv0aVp3ahxFvp3
         g0LRqtr+kUNqr4RH0aOrHZMPBqukX/1nSUWMwm7eTxmQktGH/NyQvXFFTMDtDDnJinrA
         xAhqS8dZMV67Xo0Tebqs7Lk6YyfNggbH+WwhxU3M3eEV349LEr7ksRk2cHXk6Ag28LGD
         rb0/3sOAFzIdu1YOQKxSv/K9+rYBjD4ok95CRFiQedmeyZoZCy0cP+PR0HZ1j/5VvMGU
         zzTA==
X-Forwarded-Encrypted: i=1; AHgh+RopL/DCHp++gFOer09zw5YBQIpV/k248yUrkmswgs5YU3u4kpJZPyNVTQhexkXQhIg/oXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPLfIvI+9p8lp5pRbUFgPfmfHdgtdx7KOPGZweqTe8TEjWj3Qb
	m5Z1M0QnUw4ZGcGiUtHPUwXATYeCbN06SuAPfUeJUy5d9ePIgdunasJcQ7FhEJ46NP/C9B10vqL
	GyuF5uy5zD93S1RSrn0PV13p7J3lWnGuq4tDH
X-Gm-Gg: AR+sD10upYObI9O6rDlbDXa/RtNWlUMLu+uHQlYkhj0EKrBA5SueIzjIfCnHnmukmx2
	4fZ7nKWt7hnM9Mu1Z274+O0JZBJSZ4DZAR7QN3z3jKBeQSCTWqtJGI4+WaS9zWZQ9vkK3KTXsDx
	6Yq3Bl0Xt7qa265l2ZNrQ9qTQFUMsyauad12k732W4IeeOLwSjM2VMXENJ/kq4rj/O/GamCH7km
	gMhjmqofYxL/m13NfXR36y2SJsyLyrtXnUeeLsF41uO2uVpd3zYCNTWuY1mpNAM7QMwRsRiuODs
	QYJCR2npVJ0iBcVZPQu29P/Y/oE0js+Xae3a3DRvq7B1rf4Nm1fhz9XUZ0PVW+0WzMPHkxuQNUZ
	h5N3ZNqMjtPRFTiFMpkBNdDxw/NvIRL30Rgc=
X-Received: by 2002:a17:90b:4406:b0:37f:fb1d:63fa with SMTP id
 98e67ed59e1d1-39301663a8fmr3071801a91.15.1786522760370; Wed, 12 Aug 2026
 01:19:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Aug 2026 01:19:18 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Aug 2026 01:19:18 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260807-pks-t7900-fix-flaky-test-v1-1-08d0ea0fbbc5@pks.im>
References: <20260807-pks-t7900-fix-flaky-test-v1-0-08d0ea0fbbc5@pks.im> <20260807-pks-t7900-fix-flaky-test-v1-1-08d0ea0fbbc5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Aug 2026 01:19:18 -0700
X-Gm-Features: AUfX_mwUsYyOAGHn76iey-2KI2YAe30dl_8uYKqcyzW1V-NRCkHo6HBn0JezgSU
Message-ID: <CAOLa=ZTVZh0_S+J57GVx-KHUr4hMyNFHQMrtjyNF5Q+Og7BiZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] t7900: adapt some tests to use a throwaway repository
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008402c50658d53e92"

--0000000000008402c50658d53e92
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

--0000000000008402c50658d53e92
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: cd32a7c688cb2518_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wOExJUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meDRkQy80M29JVy9JRlQ4eXBxZzgxclpXTXZ5UUpINwpzTy9ibDlvOENF
UDNUZkRLVDBZckpBVXZaaVF4WVhmZ0VYQ2gzQndreVZqdm1tY2FsZkhWV3JZNHN2UHFJS3VaCkU1
U1pxaDZkT2xuZllCeThabVoyUGJLampHNUFicTN0Qk1SZWx1bStkTTBLK2JETEgrNHZDbkJsQ1hS
V2JCQUMKMFNLbFp2SXQ0ckNReFZwWjV3ZGI4OVE2LzdwT1BaaTN1eVN2emFmSzJrOGs4ZTU4RnpB
Qjd2Vmp4R29MbHcvVApoNTV4WDl6em5tR2IrYmRpaEVMbXhIYk1QMzFEOTd4UnN3RkpWRnFIQ1ha
dWNzWFFvWlJ0Q2RacHR6YWQ1Z1lGCmZScm9uanljcVAwb3pzU1dlTnV3OEZoQ3hVVnYrKzBycHRI
cVdnc3Q4anllYkhUUTh1MXFiWFlzTnBTVTRGWTgKakJBdStxcTJLU1JjNTBXcXFoUldGOVpDM1Mx
Ujc4QTJ2dzJrNk1DUHFFQnNmVVBBWTNVdG5Kd3FIS2ptdHVNUwphNFQ4M29ScUdLdHR0Y0lPR29w
SnEvcnJOd0xtS1VUSy9qYnB4Y0pybjlZaG5UNWRZMWkxUmIwTElFZ3JyN1F6ClhrQ3l1QTJsM1Ev
R0tidGpUQzZHUnhWekxqd05Sd2F2bTlFeW1GMD0KPXZLbEIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008402c50658d53e92--
