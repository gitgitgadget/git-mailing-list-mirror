Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63106397E82
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773146105; cv=pass; b=PC2DS64fPST8jXYb6fZPbx4N1bbda8ZkbbykZDYCJ4LwD/Xj0K1xs76TOgqInHrC4rYj6ShfS9vvnnoXmQ0caQJ7ZchGecxj990qG/aMoqkGvHTh6TwGisj+V79OtU02RSqL4uUceR8zAwLcgTB2nB0w2OROv0Pu14umrdulfNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773146105; c=relaxed/simple;
	bh=l9D/33boRmy6Dwf7Bl3WB3tdUpmCER2AZXaOJy82blA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMOdhFuDMvmTIMg99cUgx98lz0Cnazx+Y0wgeyO3vxxp0k+WyFI/bv54jpox1D4UZv8/qrLZHc23IVox5wnF1g23pNSrbPAjhjUE90WUC4KagruXh/w92eiJrzlJ8aPrygnsYB/tCuFs6+xKU9gLD0wCjQb1m/zcMecgOZVJmjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/tqVt5P; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/tqVt5P"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5ffca37e8cdso3024299137.2
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 05:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773146103; cv=none;
        d=google.com; s=arc-20240605;
        b=NJBLhezwTtr+YDTOE8v2gcAyqs2Ka1kQwbpisRNG+G3UwxmUX6PzbilrDi9FistQ+v
         uJDkCB9LljVSEYdyPLjg1ReiZ21XAFDnJrXaZSbqHOWWl3W+6c/29zmkZjktWFOFv/7y
         aD/wpTEz83kgh/HZYhBZnprOdPPXb0DcMh9yrJUWuzT5HgYOLeCBhWRzXJT1menPwc3t
         /2PsyDD01LJkth746OUrAdrT1Of6VRdbrBCyGdsC/wfz+TsZODTgE2YY1NQ8tRRe3qd5
         jD5dPOCFLAnUX7MfWGpD+Un2ekZ9jimmOFSePRLg16HWVa2eUoN79wLgboRFYIQdFv02
         ys1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=y1v4OrQ3xD6zxWeLfT3wp6JfxZqssvPJ514ts2fk/WY=;
        fh=dMlx1G9Tbn8/FKsKaRMrcrS/ucwCNJvYdFPXbKm7eR0=;
        b=cMNOC9WsyQiT+wzxQqK+wrZN2afFaEh2ETsB6wrXTl5lQ2mApwT7Pm1LvB17nBVn9Z
         He79/TZPAaO746rQxdZQGEYpkaDBRyX3MGD2wSFdzHzYtDSLZfS+tq3iJtUakmGkvH23
         EAaxidCnMwxMGPv0opbpjrtSJZjJwMF/Oo+XwgUDWYL4JT8zdzvFjsRNb6Ym8kGTtgyv
         kEhpmWHH6/ceIN9+8bIXc/N9d/7BPbHYXQCI8je07QkZE7mAIVLig71mDTrE890Hz7tP
         K3oTLRuv063ko5xo0spoxZRSuYp5CwW4qJAyAqhF6TMMUXPv9tsnL1KoArbeLWwiru4P
         zJoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773146103; x=1773750903; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=y1v4OrQ3xD6zxWeLfT3wp6JfxZqssvPJ514ts2fk/WY=;
        b=W/tqVt5Pji26LLkVcZn5y6nzOR4efRp4WqPeAY7UpFDecWK0W1kijC3Wq10zBFXCcY
         zLEX+REceQhyGqOuu/deqF9JjZI246MrbtzLcNggy4i6V50JLARILFdCw9UzBsmUA/6k
         WXikDQLpNgs87xt3lbIT4iFDK60DgfH1eexvZXu10vlX7weJDjyUwOrkyY2qPs8E1Qr8
         TKAX2Q+qDdf+Zyk/VF/GF81cSRre6UbUjkEkqNckC4KAJn3e2Brn+mpmw2swC67/QJVT
         Reb5wFGdcVjyAMGCFAoN+/bq+qzBhTGLyVHZVNsvTvnPHZ3Hn7Z8sb2uqUxRj0eGDUGH
         saUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773146103; x=1773750903;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1v4OrQ3xD6zxWeLfT3wp6JfxZqssvPJ514ts2fk/WY=;
        b=umlHKVYmNl5dXLQSYIWJzcOjHNB2EQCRGgrLR8jztU/2x9ZpkYlfKDwAQhZNgHMbrL
         Tm24dyikA86pNS+H/383saNdC+NxSPP3zjL3Nnt/+RA4gVHFsjXq5a1rqRmwjDbp05BM
         8CMAhUFkC8Or0eASaPWk97hrdhnVRR6ZpK4HZvwgyEd235m8H9yxsvGmljM7icf7Ya9b
         dxsulrT9vB8+PcjFnczvD4B+WJONeZj7CxgEhTL8srfgsexyghVUUmUZp55gNIltme79
         Hlk2+FFUgQX/K3gDkaVdY6IRlq0JYGBcEpBbA5S5C542NhHLqjwPMAccLmdDreB8wLOp
         Ao9w==
X-Forwarded-Encrypted: i=1; AJvYcCVG77RywQA9vEaXhuhE9Pk83T1XQ2iiXjoyB8auXns7i/V4Jj2C+4gj9UFA7Tda4Nuh150=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFhQ8LtwqR0TU5HzadzBSxXVO/6LAZtBJ4eWI7YpXGZGHZzuSe
	3Y4aWeoECRLSZcr5ybt+l6YRlEBnGVNDpvdaoxkSdPvYUlqbYdJx5qiStXWNSFK5YaOz/gx/akM
	djpLPKTrlAedCB2W0eW1Fxl1kNL83Fq/p8X/+
X-Gm-Gg: ATEYQzykIi0tdQ1ffzzxB+iYY4S4eu5QxmyGfOJC+1qebZdpo/Ofohm3/bULEn4RVcB
	af5OwMmg44QOVtSVu/9TnhCZBLIzSbtL8zY4JB11a170cPSYSDrtqgrtzOCm8hL2VqvPMDT3spa
	oTcHM6RWEqaFT1TO31pCWzkhOH73RYHCXivIFRIVU8Nhz165CefgOhCc7zgGLRckxz//G4t5KGK
	kjBSbBr2ROAu+Tlqz7ftDGMtlGYOZfpe2eU2fEq3pAzRqtZp8k/65wKi45jg0gNKNLWAoLZu4uK
	OiS7ducZyjw/TRvKCy9w+YkiX/xLzkiLC0QTxMp2Wg==
X-Received: by 2002:a05:6102:b0d:b0:5ee:a76a:8513 with SMTP id
 ada2fe7eead31-5ffe6217b99mr7329853137.33.1773146103214; Tue, 10 Mar 2026
 05:35:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Mar 2026 05:35:02 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Mar 2026 05:35:02 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <86e5c9f7-cd99-4c4f-a852-f3b1ada53722@app.fastmail.com>
References: <86e5c9f7-cd99-4c4f-a852-f3b1ada53722@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Mar 2026 05:35:02 -0700
X-Gm-Features: AaiRm52iJ0Q9UVGDQKU2vW6Y4Etxt6xCVmj93IH2ew1qxIWKynQ5DzgV3SJ_FNY
Message-ID: <CAOLa=ZTTjvSv04QPtHiUEvDfJMfKYks=5PscZxH15SLkBmoCDg@mail.gmail.com>
Subject: Re: [PATCH] merge-file: fix BUG when --object-id is used in a worktree
To: Mathias Rav <m@git.strova.dk>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, John Cai <johncai86@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="0000000000009e1435064caabf50"

--0000000000009e1435064caabf50
Content-Type: text/plain; charset="UTF-8"

"Mathias Rav" <m@git.strova.dk> writes:

> The `--object-id` option was added in commit e1068f0ad4
> ("merge-file: add an option to process object IDs", 2023-11-01)
> together with a call to setup_git_directory() to avoid crashing
> when run outside a repository.
>
> However, the call to setup_git_directory() is redundant when run inside
> a repository, as merge-file runs with RUN_SETUP_GENTLY, so the
> repository has already been set up. The redundant call is harmless when
> worktrees are not used, but when run inside a worktree, the
> repo_set_gitdir() function ends up being called twice.
>
> Calling repo_set_gitdir() used to be silently accepted, but commit
> 2816b748e5 ("odb: handle changing a repository's commondir", 2025-11-19)
> changed this to a BUG in repository.c with the error message:
> "cannot reinitialize an already-initialized object directory".
>
> Guard the call to setup_git_directory() behind a repo pointer check,
> to ensure that we continue to give the correct "not a git repo" error
> whilst avoiding the BUG when running inside a worktree.
>

Well explained. Additionally you may want to clarify that you're talking
about a linked worktree. Since the dir initialized by 'git-init(1)' or
'git-clone(1)' is also a worktree (AKA main worktree).

> Signed-off-by: Mathias Rav <m@git.strova.dk>
> ---
>  builtin/merge-file.c  | 4 ++--
>  t/t6403-merge-file.sh | 9 +++++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/merge-file.c b/builtin/merge-file.c
> index 46775d0c79..a8768c6e0c 100644
> --- a/builtin/merge-file.c
> +++ b/builtin/merge-file.c
> @@ -60,7 +60,7 @@ static int diff_algorithm_cb(const struct option *opt,
>  int cmd_merge_file(int argc,
>  		   const char **argv,
>  		   const char *prefix,
> -		   struct repository *repo UNUSED)
> +		   struct repository *repo)
>  {
>  	const char *names[3] = { 0 };
>  	mmfile_t mmfs[3] = { 0 };
> @@ -110,7 +110,7 @@ int cmd_merge_file(int argc,
>  			return error_errno("failed to redirect stderr to /dev/null");
>  	}
>
> -	if (object_id)
> +	if (object_id && !repo)
>  		setup_git_directory();
>

Nit: but would be nice to also add a comment here.

>  	for (i = 0; i < 3; i++) {
> diff --git a/t/t6403-merge-file.sh b/t/t6403-merge-file.sh
> index 06ab4d7aed..60cc43775f 100755
> --- a/t/t6403-merge-file.sh
> +++ b/t/t6403-merge-file.sh
> @@ -506,6 +506,15 @@ test_expect_success '--object-id fails without repository' '
>  	grep "not a git repository" err
>  '
>
> +test_expect_success 'run inside worktree with --object-id' '
> +	empty="$(test_oid empty_blob)" &&
> +	git worktree add work &&
> +	(cd work && git merge-file --object-id $empty $empty $empty) >actual &&
> +	git worktree remove work &&
> +	git merge-file --object-id $empty $empty $empty >expected &&
> +	test_cmp actual expected
> +'
> +
>  test_expect_success 'merging C files with "myers" diff algorithm creates some spurious conflicts' '
>  	cat >expect.c <<-\EOF &&
>  	int g(size_t u)
> --
> 2.53.0

Looks good otherwise.

- Karthik

--0000000000009e1435064caabf50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ad58357bbad9dbd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1td0QvQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNnIyREFDTm96UVR4QWdtUWNsRW9iam1iTFBIWllnUAo0Q0krSVh0aUth
YlVXYnRnMXJDT3BGelRCU2ZxbE52MFBTWHdZQ2s1UGgzZUt6azF0aEZhTTM1Tlg2cFJLR2VVCmdK
SXhhUEZjM0EwRmFqY1pzVEt2R0ZVb3J6MlZTVm82Z1dmR0thaEdqVXBWL2dONkxCK21PaHJLSWt6
VTVNS0QKaEI0MFd1WWZhOEZ5NVFKaUw2WHk4ZGdMZ0NLWCtab2wrTjRtVlpLdGVCeVZpVlBhMkR0
RzdYcGZaMjlab2s2Sgpqb2FnKzltZW9qK0F0aU5mcUdGRHgzYjQ2RC94czcwTExUdlNXUnNoZGhI
WllyZ0VEbUJja0VoVWJEd3hrVXAzClFMcDI1S0NvVU1sU2Nuc000WE1kVjVET085VWNWM29oQWVs
V29UQ0l6bkZJRW9IVjFGdjc2cVpISXhEM3h2bUoKMlJ3eWJldkxUUHlldEhnOTYrWGQ5SnNEK0FU
ZnRpc296QkJWakJmSkIxR1dKRHpiRHdYcHk3Q051MktGM1dNdApGK1BNV2UrTmx4TzBZT2FwYVRP
TWw5NS9wZUlzYkxHNUplWWVTTURXbjBjZzA3VHBtTjdUZVVCQWJmTDFwaGJiCis0V1ltUVhJYjlU
QjVaNjRSZk9McVN2UWl1Y0FFQXVkSUxRcG1ncz0KPXlkWEUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009e1435064caabf50--
