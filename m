Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2D3CFF4C
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932685; cv=pass; b=YdAsygtWuvMAgWa8mU+bZAOcIWFNLgbEor0SP7tlFA2vjiCIWobJiZv08v7NZt+JNQwn5lV1n9yw4LXOf35RZbwX51HiDM6/6SI5qpit1HV0ZpwG5cdIGt5qfnvIc4idcwpFlBRWQ+Bpd8Ac0TqqIwgHdqZ+/ePu/U2QZBxyfmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932685; c=relaxed/simple;
	bh=AZb3nt/ikqqAhkj9uHIk2cJWyRl9ICcbwndO6At2bZA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=e2LM2EQiB8OzUECWzdAE50A4XpQfUaWUYSOc0nmp2C2EGej1m9Dh2aGz2Q6vdbdOSTDSuQXOTvVuKhZ/Ued+NGb50YW95OrK4Bie2THyR/2mlqGS8c6jKNM6DUlc1GHx0PYMmS7P699QWzq/EZn5SAgEChUF6pzA+TEcYrsSCWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YD7erUH1; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD7erUH1"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5b22b023e1dso879218e0c.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 08:31:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780932683; cv=none;
        d=google.com; s=arc-20240605;
        b=jjgao35ezbswwuGY3kLAytWDHgsb+X0sKhe1QHEIX3ePfGrWFLNqDDc5WdjQ7KZaM1
         kyWVTZ0VnPEq2MZJLb7V5SMMo/GnHrMoQdo5SSv6tA8CNRXGMWx/hSBe9KUfE2u3RPic
         fl2C2P0h3zawWZuIHXoWxloSlAOA/TpAHZeLA94p5+WUtiSg1KPgx74S5HPts+WOlqfi
         0J4dPmxFvcSR2VIajKTSd3dqfviaQij2XasazoaNXWvD3V50aJuU4npdXeakIUTZZ1kZ
         +HO8It/P1j2QePNFl86MsHbmBlb1fGMuPmpD0pS0qEe9aUWoR9wX7J687JYL6DfwRe0I
         6o+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=U+OA1d+vLymH6mQhxdoW3haHlXXsKD2cp+AokUm6uk8=;
        fh=zrFdScivYUA1CUYWQ1bQcnFVHKjWJbFxQ6iWuhLZ62k=;
        b=RtrxvL4JC4KqE2G0il0ouGK/5AlE5s2naGG3upGVvROxW8WUn/e/ulVsomMRMurnMd
         ensKiXFKNnTi8D4Cp2z+30duqAKJesfZs0gQqV3ag19pVSNJl1wJ9lq0J9hw+NpfrAjh
         pufmIy9AFpvXJFTb7XzkjBxJDP2HzpnoKcPnltNJfLyFjkRmBvx3R25xohYLLw/mfYWi
         jMER40luaMtP5r2sGrcLJvLOLxDJJRc5uQVc+1fpqj7/c6/BaF9SBHQQzT+3IR2dvRe1
         qOjzNxH06za2kN+pGhi8sAvCyt25pYy+EqU2b+Ujj/sS1SyrOWnsvRvacqUjmCIToodu
         Ipqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780932683; x=1781537483; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+OA1d+vLymH6mQhxdoW3haHlXXsKD2cp+AokUm6uk8=;
        b=YD7erUH1z64DYZ0DwEUVkSXKS6axgT/+9r8cxSNb7k8nD/ybsWt0JkHeQZPVaeF3Ml
         enOExvL+cZ5NhYZYdAdvnv+Qy+u5PmZybkCm6P5jNQZFA8Ga7PfDCHLYjA1+7OR6oKUV
         1aFYsLvSGivti5VxnXRKqDLZ1feO5FXYusDqNbszykrQ3DqgM0FnuuXPCcetpFz+32uE
         2JpCMqDNpPBmNeGxR6njrQjZMU0JMG5+AgKsbbnOmDosiBFkCZdcGjO/QZTGyOwQWJ6U
         HHAyjjeoPXcPjnLTU8rs+afiS9GbbsEOa8stdBwHfqrLf01BlYv6ixMKWyWNCjbtM1u6
         nyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780932683; x=1781537483;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+OA1d+vLymH6mQhxdoW3haHlXXsKD2cp+AokUm6uk8=;
        b=MdbZMRJvvG3qSjja7YJrP32Lp6TAv7Y5VfemOOWzXMcc1BnzoAIDmlVnKps5FEYAOX
         PBr0exNF0fl8RA79vYjoIjhwb3utc6x7CVHkMVGy95rvBCwFnjyUyJtIEJIZIYfaWLc4
         uac0L5PROUt6X1fgMRmcJEa4Bp3WmAJ95oChuX97z9dMVMROCupaEaxOMmMJWOuJgBCF
         eKyDzavNdaVwBxFEXxWGXQUyoyFexgfS789BHFmuurWd+R+bPZ34Nxmop+K36XhpJfC+
         DCzQrzWrGnr4XCo3+ZevRPyJ/y8Ccfx2X2PZdoKHE/hUm4mDd+gc4Pjhk5L9ieWCqiMu
         0CDg==
X-Forwarded-Encrypted: i=1; AFNElJ+rWn/fzyxCWvFqM1K0elnF2eEL8EJwqfw5u3E//KIQcw2wiJOmhHsat1t665EtMPqlCoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVUX1o0j7J1oeK1R1WDedwEMq4X2AoZ6YtqmtKOYLlpQYxIC5f
	ZKANkotVCpS91Hx1u/VF2cyibGsC8vUvnQfWy++L7Fg2kMcNmCA/wRHNVvCgLt0W/HZbhVWsg1H
	eFnvEMCq4uppmvCiYMkLM4eyNpsua+hLWdw==
X-Gm-Gg: Acq92OGg0HlVYDXjIZEI2uPPQMApROvY6J+LidmQxlXOr4rNyGHr2pgQQyV/97jEZy7
	/o1cGDcZCg2dwOlPh+3Z/r8Q8JArxINxOuxeIgHt2wPsR//i5T6GIxllmk6+5kaiqpp+F+D4O1k
	+G2tvB7lp4jBgYNjg4GG8w189sFj9VqHb4N0Raj5nZEvMYqOn5d0Og4sX2/SHEDWVG/VU5ZDHFM
	T81rMWmlecLbN3d4tlwoE7tK7OBsJWDcsxwJwsrZi0TzWrSAGhJFaQT0cBVhTD099HuiSx0sl3l
	uExeHB+dwTEaygvNOvRJSrhRfyhyDg/P+I0/nihWWNgz8PtzKrF7oZ+veA1Rc0bJd8lJMVTjnRL
	QOfXhbRvX
X-Received: by 2002:a05:6122:6e0e:b0:575:2072:54d1 with SMTP id
 71dfb90a1353d-5ac50ccc252mr7899799e0c.8.1780932683476; Mon, 08 Jun 2026
 08:31:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 08:31:22 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 08:31:22 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260604-pks-odb-source-packed-v1-5-2e7ab31b4b5c@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im> <20260604-pks-odb-source-packed-v1-5-2e7ab31b4b5c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 8 Jun 2026 08:31:22 -0700
X-Gm-Features: AVVi8CfdWEnz-nQduUIQ2SZ_1kztqo3Y4YKyaBOeHQU2lmtbEZhNuZmbYS20Sok
Message-ID: <CAOLa=ZTJf2x8AJ-oOOO5j3mSMbd2uTttoVCnSikNq37F_mKT=A@mail.gmail.com>
Subject: Re: [PATCH 05/16] odb/source-packed: wire up `close()` callback
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f7ed970653bfb36c"

--000000000000f7ed970653bfb36c
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Wire up a new `close()` callback for the packed source and call it from
> the "files" source via the generic `odb_source_close()` interface.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-files.c  |  2 +-
>  odb/source-packed.c | 16 ++++++++++++++++
>  packfile.c          | 12 ------------
>  packfile.h          |  6 ------
>  4 files changed, 17 insertions(+), 19 deletions(-)
>
> diff --git a/odb/source-files.c b/odb/source-files.c
> index 3608808e7c..9b0fa9ccdc 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -38,7 +38,7 @@ static void odb_source_files_close(struct odb_source *source)
>  {
>  	struct odb_source_files *files = odb_source_files_downcast(source);
>  	odb_source_close(&files->loose->base);
> -	packfile_store_close(files->packed);
> +	odb_source_close(&files->packed->base);
>  }
>
>  static void odb_source_files_reprepare(struct odb_source *source)
> diff --git a/odb/source-packed.c b/odb/source-packed.c
> index f81a990cbd..74805be1dd 100644
> --- a/odb/source-packed.c
> +++ b/odb/source-packed.c
> @@ -1,6 +1,7 @@
>  #include "git-compat-util.h"
>  #include "abspath.h"
>  #include "chdir-notify.h"
> +#include "midx.h"
>  #include "odb/source-packed.h"
>  #include "packfile.h"
>
> @@ -16,6 +17,20 @@ static void odb_source_packed_reparent(const char *name UNUSED,
>  	packed->base.path = path;
>  }
>
> +static void odb_source_packed_close(struct odb_source *source)
> +{
> +	struct odb_source_packed *packed = odb_source_packed_downcast(source);
> +
> +	for (struct packfile_list_entry *e = packed->packs.head; e; e = e->next) {
> +		if (e->pack->do_not_close)
> +			BUG("want to close pack marked 'do-not-close'");
> +		close_pack(e->pack);
> +	}
> +	if (packed->midx)
> +		close_midx(packed->midx);
> +	packed->midx = NULL;
> +}
> +
>

Most of my ODB understandings is coming from reviewing your patches. But
I really like how we can map the current workings to the ODB interface.

>  static void odb_source_packed_free(struct odb_source *source)
>  {
>  	struct odb_source_packed *packed = odb_source_packed_downcast(source);
> @@ -42,6 +57,7 @@ struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
>  	strmap_init(&packed->packs_by_path);
>
>  	packed->base.free = odb_source_packed_free;
> +	packed->base.close = odb_source_packed_close;
>

This is what I mean :)

[snip]

--000000000000f7ed970653bfb36c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 19f60c5f7f5697f0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vbTRFZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meS9aREFDVjE2L3FYaE9ybG9HMW1VL3RnY3FPUkx4ZwpNQlFOWmc3VzZ3
cTBlZmhLVGJjb2JQSHp3MlBEcGpwMFRIN1hQNWUxdjArQlRCVG1OR2lIb1JWSkdCQXFSbzFjClFt
T0hJWGMxTmJUaEFFTXFVenNDRlUrc0hmdlQrVi9wQjRDYk81OGxLemhKYjNQcG9Pck9oVDRYV3FF
dlVrU2kKaVUzS013VzdrMzhqOVE4RXZDeGtHMUpWZWxOaXZuWFNqQm01TWEzbTBQMGRVeVVVSjlr
NndPbldWMHNjTHQ5VQp5Wm5lSmtOc3hNak1sdkhDZVMyUmxkVS8xN08zMGxONHhpd3JiK05vOHNz
OHBKZ0JTNXhmenJDR1ZEa2RQam4wClRReFdsR0ZBaGNlVjhoZ3Z3QmlOVmJNUkNXdGRCbzRaSVdU
dVpYZmJEVHNyUnZySUNUR0F4cmZnM05FdjFGcXEKNDZJUE9LN2pNalc0NURGazV0Z2ZPRG0zQTBC
QW5sOVdDOCtsL2J1WjR4Ty9CV2VyWUdyc3B4MFlKR050TlBZRgpXdEpKRzJ4YjIzZzhJOWREOVJY
UHVzalIvT0EyK0tqdjZZdWY0UWpRajBqR3M4OUxKNis0YXJOWVJmeFYrTEtKCjl0VkVPOFNrZUps
QjVOSFo4bzRaQXA0cE9GdnRHOVBSbnlBMm92dz0KPVJ5SVMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f7ed970653bfb36c--
