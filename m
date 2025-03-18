Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385F6F9DA
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 22:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335609; cv=none; b=XgODIXxZzdeOj7TbGuLpg0JYLMbhFH42r2vEYKvnARDgpA7najYkPf9jsCzHFcye/fpPhbSUz7/HJZOwWr2uReerWr1ABasV1j/4zN5/5VOWoDwIxtcW0jB8DSPmC6/7cFpwb+LafEoFOJNc/+ZjaTtrWzppETrQSt6zz/3TxNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335609; c=relaxed/simple;
	bh=C1N7kWdthmwT3eQx3S8AkmAPEPABFFsYnv4q9I+Y248=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3CCZzn+WiDLjusuPpblVHLYwkijKT4s/SkGm2H2xVpIWJa0V4LHE/fZy1EglLYi0835gzYxnXcukkLQ+hs87pG3gNsIBrxgcbm5I71QdTmAQXUajDwa/vPNgMrx3HssEhyYQLYhQxiB4ktcdav3bfU5ZHzgN3S7Ji+fe8H3wns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8fa1f99a6so3026376d6.3
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 15:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742335605; x=1742940405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsxIFq1AqtNrA/chjKM7XVga5nsYwdDumAFJlONWsk4=;
        b=G6v2q/8dRaahURH64KY9sFFiwWwkhQYS/Jz3JAODv5scPEDQ95iqwNsGAqvBFXKm4F
         SCqqIQ2t7AterW5HarQqw8g7P5esH8tNT4L1Ir/XEIeeJA6O8ds+oK4X78ywrjOpQMQo
         wARM5NOVHbbTlpyFsj0NwtfmOiWKjDdHoPrqCrzRqbPndf5ElXihYEWs34BLkb+NjxDo
         NR36ajc+uPNoHE77mbh4UB5+TVosRHm+w7rVgYQNUto1Vg4879H/bB8LI3IBBmSdapdy
         6VXzvWWVwleSI5Ys3DuuXgpX71H5yhC2LRvpSl5BkkH2wdHBpf1HsCcVUGzdm7FUgjjG
         uCfA==
X-Forwarded-Encrypted: i=1; AJvYcCWgUgGbKPdo50SeQrtdvpmErBgjR7InmJMjlN+U/k6xXhkuaGhhL+znUgYLkSfT/HioJic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVma1Yr78wlAFA4t7PCdhA5qg6ypKwrFpBSR3fpC41KCfo3zHR
	Y3roWCj9nTxJ9+pLO76WGGeBlJgV0v53L4wLcoCae1MTaNu5H4vWJ1I9/wE2OoeZa9/Nj6+JRmn
	ufWIOCiK10GBSME6L5FwUSQIVDIQ=
X-Gm-Gg: ASbGncsteoYH5edVSTac9OPpY40KcAGvuKBrtKq37JbqBfqeCAicTQ5MzISaqq1IMPZ
	p+1mIV1fVN8YPoJBIDmnv+Yh0uYiXj1g/sTkD1hlmf5KUCcypvfbe1iBG9AEiqRgApUKEDrRvJD
	DOwsyXieOS4i+83UPqFAuOWgyG//L8H3TaCdUkgW5guxrXLRr8wBvMP/r7DLWlO08cjRegWQ==
X-Google-Smtp-Source: AGHT+IE8sKFFGn99QYiJS5+TwPrLpHV33i7lA74spE4WguRHDiSwZ6aRxQSmBP2Q4PhhtWWQ6CRttOvBFo7yFITUsaw=
X-Received: by 2002:a05:6214:3012:b0:6c3:5dbd:449c with SMTP id
 6a1803df08f44-6eb29279e56mr3480636d6.1.1742335605015; Tue, 18 Mar 2025
 15:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308090358.25429-1-contact@aynp.dev> <20250318131033.48691-1-contact@aynp.dev>
In-Reply-To: <20250318131033.48691-1-contact@aynp.dev>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 18 Mar 2025 18:06:33 -0400
X-Gm-Features: AQ5f1JrJYxU3V_Z5coog3qNxMacs7TyeUiLNoz_oKA2pWGzyqhYYflL_cpFscdQ
Message-ID: <CAPig+cSnhjmni5FQhrWxfbtxkZq_sbHZp5CNAGHEQCaET5=iAg@mail.gmail.com>
Subject: Re: [GSoC PATCH v2] Use `test_path_*` helper functions instead of
 `test -[efd]`.
To: Aryan Pathania <contact@aynp.dev>
Cc: ps@pks.im, gitster@pobox.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your GSoC microproject submission. See comments below...

On Tue, Mar 18, 2025 at 9:11=E2=80=AFAM Aryan Pathania <contact@aynp.dev> w=
rote:
> Use `test_path_*` helper functions instead of `test -[efd]`

According to Documentation/SubmittingPatches, you'd probably instead
want to compose the commit message summary line something like this:

    t9400: use test_path_*` functions to improve diagnostic output

> Change testcase `gitcvs.enabled =3D false` to check for missing path
> instead of a missing file. The change is justified as new assertion is
> stronger.

The description seems somehow outdated since this particular change is
being made to more than just that one test, isn't it?

Rather than describing the new assertion as "stronger", it might make
more sense to state that it is more semantically in line with what is
actually being tested (i.e. that the directory/path should not exist
when, as expected, the command fails).

> All other testcases remain equivalent.

Okay, but...

> @@ -296,8 +296,8 @@ test_expect_success 'gitcvs.ext.dbname' '
>         test_cmp cvswork cvswork2 &&
> -       test -f "$SERVERDIR/gitcvs1.ext.main.sqlite" &&
> -       test ! -f "$SERVERDIR/gitcvs2.ext.main.sqlite" &&
> +       test_path_is_file "$SERVERDIR/gitcvs1.ext.main.sqlite" &&
> +       test_path_is_missing "$SERVERDIR/gitcvs2.ext.main.sqlite" &&

... although `test_path_is_file` is a faithful replacement for `test
-f`, it could be argued that `test_path_exists` would be a
semantically better choice, especially given the use of
`test_path_is_missing` for the sibling case.

The same comment applies to one or two other changes in this patch.
