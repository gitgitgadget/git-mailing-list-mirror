Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BDD35976
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736169939; cv=none; b=c0D+bVtb0baQH/TnUcJRSGy2rfn83E0KeYaweOHUv6Hhi10qF1QYWlnLjPzFCW3NUT8/s0E+ZjYX2pL/Il/nrNW+W4Wsj6dOqKIQSZMwPhEl2T1yIWlaU0qQCjXoFeY0E7lXpyLecYkr34DlOltY7MBK4aX/1jaXPVd2fBnnfYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736169939; c=relaxed/simple;
	bh=ODDaYFfrVGWR1IlAY89hQ8YVs9TC1JoNdXGOuYb4xGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEVDy/PRdnyfpobD4/xj1aBJ0q4F0PQyiZooT8IJeZasdVnwjJqYrWutxtJgl+vpjzh73d7h/jPP9LjMuPFTREijCsGGi4oeicQGyV4NPxBaYVv2+BLOQs7wVBw67Wjt5h8q0XOXO+MBBUvUk3tNcGYQa7oYses6x7J4hIvuV2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izHm7UU3; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izHm7UU3"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso28636642a12.0
        for <git@vger.kernel.org>; Mon, 06 Jan 2025 05:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736169936; x=1736774736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L71xsNRxRpawB89r9h+s0KuxU6GzPi1xNzZA9DPDhZU=;
        b=izHm7UU3/T1GdpKvfAQ4pZ+mBuerjlTkCZSIsOhWMhlxo5sLa5zlOJVZKKYdcwP+kZ
         UBkd7IMvISmz9DDFbWErp2gZTHXYtnXxj9pIfI7xXQof/RLjbVZKDRG56g84+E4rnBZe
         QAB6YIiMs5vuG30wvCTXo+oikUrNjRD6FUGM4Zeq6JkEy/GfQme5tEkmW1SbFDeboMmj
         dx94kzFqBhnCp7EY2x4VEFUvAomLTaYWMF/Co4vY7+t4RIFABqFkGsu8dwtMGoJa8lf7
         52Fvvi3bc77EghDAnxwxn9eh54jXeIzYt+Yvk5i7HP4aYgUDB2RrFzzPUnGb9o4cxYbo
         pPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736169936; x=1736774736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L71xsNRxRpawB89r9h+s0KuxU6GzPi1xNzZA9DPDhZU=;
        b=Ty58viM/VZsntnZCprWylXzoZ9op+HuYvLE86sM60h7P92oT/kQG4oNhDMekA96IvG
         FuV9nN3WguYiF9jwTSKsWIU5okhCIF7Vd/g+e9pTi4ckOxMNqDedLoO2p+woL+6haoLK
         s0njAqmrk5+y8faoNhXjNQlM+zfQ1+XjpSd/cAYtDjA+RYsCTt5js3GMUJyb8sTZvecL
         r5abBVY3ofeVPJ8dx+6KffoMCVmfPJH5oYZdJ6KHVqRAkJlfMExVvqrdwLnUK6cslf5a
         aUm2RuNLBbhIdzuajsDl4xL0kmkJMdtl9eokvBTSSXKBuR2B48ebDsmgNzHjcJEpkcMC
         XRPQ==
X-Gm-Message-State: AOJu0YyeEir1PeR//jBKA5lnIMu1gVU87apkdd/1Ir8LEKkaRYsmNNs9
	iFnG5a+UN2O/FDwe42LxCPmdc9skwa/DWA1JE5UfPTrBHDph/zHAtfoCX1TRho0hoi31M/ELPb7
	SR82TqL3YHk9CA5LxfXjW7Gf0fsvvjgPV
X-Gm-Gg: ASbGncuOgCo41JiEiBXxRGY0UBo0EZKo98t4Xb+bLRdVIPUbPqSCTn+QydJEK/Bo97n
	eGNiB00h3E+vMIo2cMO7OVWhK6PoLmeunzvd1sn9W
X-Google-Smtp-Source: AGHT+IF1w/18LejCWuG7b/sIbCX2Fm1rUyY/4f9ht/0RVmG9mD0gmyIGtSO979qZi8fNe67Ngdyyi74/ZMdgjfn11SA=
X-Received: by 2002:a05:6402:5211:b0:5d1:2440:9ad3 with SMTP id
 4fb4d7f45d1cf-5d81de5d42fmr58392277a12.30.1736169935716; Mon, 06 Jan 2025
 05:25:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
 <20250106-pks-remote-branches-deprecation-v2-2-2ce87c053536@pks.im>
In-Reply-To: <20250106-pks-remote-branches-deprecation-v2-2-2ce87c053536@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 6 Jan 2025 14:25:23 +0100
X-Gm-Features: AbW1kvZ4j3L2Nu6MdHJqzvaTxCzyicP8dDDuz5VDLBZoSNQ4ruuSSYoLF3Ao4aY
Message-ID: <CAP8UFD1ALC2f9iQady35MCdm18V3u9+b0iRhgx2Zd_UTeCY8vA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] ci: merge linux-gcc-default into linux-gcc
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 8:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> The "linux-gcc-default" job is mostly doing the same as the "linux-gcc"
> job, except for a couple of minor differences:
>
>   - We use an explicit GCC version instead of the default version
>     provided by the distribution. We have other jobs that test with
>     "gcc-8", making this distinction pointless.
>
>   - We don't set up the Python version explicitly, and instead use the
>     default Python version. Python 2 has been end-of-life for quite a
>     while now though, making this distinction less interesting.
>
>   - We set up the default branch name to be "main" in "linux-gcc". We
>     have other testcases that don't and also some that explicitly use
>     "master".
>
> So overall, the job does not add much to our test coverage. Merge it
> into our "linux-gcc" job to reduce our test matrix a bit.

I understand that the subject uses "merge" as the space is limited
there, but it might be better to be a bit more explicit here about
what the patch is doing, which is:

  - making the "linux-gcc" job use the default version of gcc provided
by the distribution (which is ubuntu-20.04) instead of "gcc-8",
  - removing the "linux-gcc-default" job.


> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  .github/workflows/main.yml | 4 ----
>  .gitlab-ci.yml             | 4 ----
>  ci/lib.sh                  | 5 -----
>  3 files changed, 13 deletions(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 808ddc19b8a799abc414c6d6ba078a6e5be6bdfb..32d35d2257812f02121b20c3c=
ae342d626481553 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -271,7 +271,6 @@ jobs:
>              pool: ubuntu-latest
>            - jobname: linux-gcc
>              cc: gcc
> -            cc_package: gcc-8
>              pool: ubuntu-20.04

So linux-gcc uses ubuntu-20.04...

>            - jobname: linux-TEST-vars
>              cc: gcc
> @@ -286,9 +285,6 @@ jobs:
>            - jobname: osx-gcc
>              cc: gcc-13
>              pool: macos-13
> -          - jobname: linux-gcc-default
> -            cc: gcc
> -            pool: ubuntu-latest

...while linux-gcc-default uses ubuntu-latest.

This is not a big issue but I didn't see that mentioned in the
differences between the two jobs listed in the commit message.
