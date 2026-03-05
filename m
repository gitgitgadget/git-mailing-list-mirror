Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B42383C85
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707512; cv=pass; b=RUiIa/g4hk3XRYkgupUfI8jma+ZpDYUtSW4eH5nq4HNEqCKLbe6aF3bExCdDGuzR6WmTpqHx/nKVvwntsaSCJ5P+uLEn4+2Yia+dRnDnk5kXygoxGJQi/IVhKIonIWWAZL0h32kd6yAvornTIxMHA2ql0KmRCYoYGFnx/6e6gNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707512; c=relaxed/simple;
	bh=8xHjuFsFRiTynu+1bt12mo8dIWdLjeza2jMc+SXvqJI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=hzywFx05r0bmLiwV/awOqEESRJXBUOiM7s11PV11TFXYphN5bYZgIwu5GKwe43nONe52CVtEm70BmYLEbnb7/iHDEg6zJLt5TKxXCmDtbgbKY+kNNEV6qVc0WtECFbnrZ6IXBK3zGUhlEQFAEhiOTbbRXCjNKQhPiMt4E6DWU7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrvNGAXk; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrvNGAXk"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-94acf9ce1b7so5266219241.2
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 02:45:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772707509; cv=none;
        d=google.com; s=arc-20240605;
        b=iLt6p3TMWN561Dt3YqvxkB38kFTzSEZO+RSmDzfQbM/i7zvDuoO10bjEpKVMPRclys
         Xpg7h2ttGzylGjXw83qB5KsBgHyhXDDhf8avW7fE9M7IZCcfyDhrbV4lS4QBgrpcwUxG
         0vFcorME19KrpYGCDRfxjSRsTs/SWsfndAE3WuOzt+UwSyfnT2iqbS5AeW5rAcG8ScBs
         WfPTdC71SfYSb7QMz6LD98lp4EWggs3Ar+Wq/c4rmN4xBRZz3zrjVduGgleqj75k5yXA
         DWH0iixajn7fNmlnUphJkD93PFDPpQCyo44ILwvR93/ROA3hDyKuob9Nnf/759Zm8097
         aCyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=uToOWgFRur6vkIVMHqnYp/CKXQlzq/O3HL6Zc7vfBOg=;
        fh=NyAnyyt3FvpcYHt5AF7htPTmXiKQ9hzC0RbFAKNXuVU=;
        b=WOCK4ehsPIjjBXlWJwN2Lk3NQ2iaxQw6sShAmakDPkiCiLe0pzWGJJp4XDLc6Qdakg
         L1ME+OvABbtax9nlzGR5XqBeOh2E2Z+8aL6mAOGn7xRumn+GeW1rid3kYY7+LJ1CY3mz
         IGGOsoeNWshFsr9AsAbvKIjYNjtajQxxXaWsHvuby8W2YGDaYZnt/9xT9YwHfbPvwPrE
         +LD0KEhSFoL9V/22niLDBc03Lg7qNQf5J6Pqy0D8zjrEuCAEbmq5a2zivf4uk0Tbi4S5
         OiuBpFhNEYT8qT/cM1cSEeUgZSDG7U2bRA1xqrBoHSaCjznW0O6PrEfkUMM08IhndSfJ
         Hf4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772707509; x=1773312309; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uToOWgFRur6vkIVMHqnYp/CKXQlzq/O3HL6Zc7vfBOg=;
        b=QrvNGAXkROzDkHamNg55FvhweT/Uqk+pXsqeQGqqPhwB2RdxVmzL+J5yTITYwO52nh
         HdOnvngwV92vtW63gGF3oReDxtVixctAJoeBPpfKQkHLZKqfWHpePUhP+54m0nev88O0
         sWn/TDHBT9Hv/FWulHTtkjop9I/NP8nHu1Aj6FUHNWAdj6XnYqDhrLVaSgfQj+opSpj7
         +h1pSqpy0N2wPdK3kqUn6tNMxeL1U2UIGuPQFlKE8kxn7LAwE0xq8w3pCr+5hYo7Sp0D
         dVBm+a4CGrsGsAGvZigqS5SLQt8j2Wbkkbg4TkGwTEm/inm0NtnWPQAM5URrBdNND6B/
         JVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772707509; x=1773312309;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uToOWgFRur6vkIVMHqnYp/CKXQlzq/O3HL6Zc7vfBOg=;
        b=RbllBit3Lgv9xGkh9hYIHV0ISe/Luz7CulNm1bKTRjxUMfht7CJuo+87MCj/KiDkvX
         7jw/7nrKhJi5EraNubgsZbIRsBwT060HyoMHqPjamFeRpGR5pMdAignRBiN17S9UvPB2
         2mluf1VRpfJ73Y5kAkT53iJOwxtsGp8uwSmoyZTCLyL+Op3EcAv7JoLwrxXBAbUFIXR9
         YriQqco6QomsOsvK/spvo1UEEeqG3v/Nq/vasBsjDpKbFVB70XdTkn9gskRFdMAJQN+A
         OpKs7yvf/X2leSlUYR3HRBXpSfDCc1E88QG28BCXB752ritSnTGnDV2JPi1OCVQxFSHJ
         7JuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnKT24MPpyAHekwahZDlbdE89/TraIlrrIVP5Jd5l6FnWuYDFguGSNn9qt/d5e3F0HlsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo2/drNzKNZ9RZb8LBZLn1Q0FOA36mk9uPftDeLzIdVwe6VObM
	zLUYYQzhkSWaAzt4VovP9nYx+BIqM8SVhJVp6Xydk9/a0yV9TSqlh5nxWsJ6Lr7JBmpMfmx3wox
	I1wrO1U/ytok4bxi5H81CVhGb98fIN45bTzdR
X-Gm-Gg: ATEYQzyyVWWWx2EAS/YjZ8a540pqAOl4bDev/iRq6wFL4HS7n+w0ArL5BywhOwfn6mu
	Tug1OZKNjaK0Yzf9eH7sdZNJ5LakImeHrjWNGNrBWLcjY2uinuwF41j87L9Hnc4RlB52EeLUfcf
	XZRfwhAf+LRFGaPa8aPBI0sAcvxDsNYp2ft/d65tzpAm2SpY2/b1YxdrJHGOFXTGIwmdZrO8C0o
	wwXvhKVHPzmGBufdF8dSO0S585JqXzCQQq+QyD7jjQJfwLTtnGKSmJiLpFQWGrmM5xG84uC37xa
	9ikjTDgoJWZXw5o+s4kKfrMI3gIed9ptU+aerCe4
X-Received: by 2002:a05:6102:26d1:b0:5ee:a8c4:18d4 with SMTP id
 ada2fe7eead31-5ffab04169amr2583982137.35.1772707509562; Thu, 05 Mar 2026
 02:45:09 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Mar 2026 10:45:07 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Mar 2026 10:45:07 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-3-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im> <20260223-b4-pks-odb-source-pluggable-v1-3-253bac1db598@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 5 Mar 2026 10:45:07 +0000
X-Gm-Features: AaiRm51Z4vPzBi2JFTAMSxpySQ15Fy18B9W3fPBYIqZ_70UfN2uBwBj_E3dxRLs
Message-ID: <CAOLa=ZSY8WE_BiWF0TZpV1-bf6p3z8zV4F_o4xo-V1ZC5ZiQLA@mail.gmail.com>
Subject: Re: [PATCH 03/17] odb: embed base source in the "files" backend
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000006607ea064c44a16e"

--0000000000006607ea064c44a16e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The "files" backend is implemented as a pointer in the `struct
> odb_source`. This contradicts our typical pattern for pluggable backends
> like we use it for example in the ref store or for object database
> streams, where we typically embed the generic base structure in the
> specialized implementation. This pattern has a couple of small benefits:
>
>   - We avoid an extra allocation.
>

Because currently we allocate `obd_source` and also its `files` variable
independently. With the change, the `odb_source_files` will embed the
`obd_source` and be allocated together in one call. Makes sense.

>   - We hide implementation details in the generic structure.
>
>   - We can easily downcast from a generic backend to the specialized
>     structure and vice versa because the offsets are known at compile
>     time.
>
>   - It becomes trivial to identify locations where we depend on backend
>     specific logic because the cast needs to be explicit.
>

Indeed, also makes it easier to move generic logic out of individual
backends into the generic layer.

> Refactor our "files" object database source to do the same and embed the
> `struct odb_source` in the `struct odb_source_files`.
>
> There are still a bunch of sites in our code base where we do have to
> access internals of the "files" backend. The intent is that those will
> go away over time, but this will certainly take a while. Meanwhile,
> provide a `odb_source_files_downcast()` function that can convert a
> generic source into a "files" source.
>
> As we only have a single source the downcast succeeds unconditionally
> for now. Eventually though the intent is to make the cast `BUG()` in
> case the caller requests to downcast a non-"files" backend to a "files"
> backend.
>

Do we also plan to add read/write permissions check within the downcast
logic? Similar to the refs DB? Doesn't have to be in this patch, just
curious if that is something we plan to include.

> diff --git a/odb/source.c b/odb/source.c
> index 9d7fd19f45..d8b2176a94 100644
> --- a/odb/source.c
> +++ b/odb/source.c
> @@ -1,5 +1,6 @@
>  #include "git-compat-util.h"
>  #include "object-file.h"
> +#include "odb/source-files.h"
>  #include "odb/source.h"
>  #include "packfile.h"
>
> @@ -7,20 +8,31 @@ struct odb_source *odb_source_new(struct object_database *odb,
>  				  const char *path,
>  				  bool local)
>  {
> -	struct odb_source *source;
> +	return &odb_source_files_new(odb, path, local)->base;
> +}
>

Since we only have one source right now (files), we directly call the
internals of that source, I guess once we add more this would be more
modular.

> -	CALLOC_ARRAY(source, 1);
> +void odb_source_init(struct odb_source *source,
> +		     struct object_database *odb,
> +		     const char *path,
> +		     bool local)
> +{
>  	source->odb = odb;
>  	source->local = local;
>  	source->path = xstrdup(path);
> -	source->files = odb_source_files_new(source);
> -
> -	return source;
>  }
>
>  void odb_source_free(struct odb_source *source)
>  {
> +	struct odb_source_files *files;
> +	if (!source)
> +		return;
> +	files = odb_source_files_downcast(source);
> +	odb_source_files_free(files);
> +}
> +
> +void odb_source_release(struct odb_source *source)
> +{
> +	if (!source)
> +		return;
>  	free(source->path);
> -	odb_source_files_free(source->files);
> -	free(source);
>  }

The patch looks good.

--0000000000006607ea064c44a16e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e25dcefbdf0db56e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tcFhyRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNCtRQy80cTU4T0g2RmluZjlCTjZTVmN3MnRUMlJVSQpiRUIwUExkMHhU
ajFlRDZXK1lCRUJTWEcrK1JDaTdrR1FlRWtyQ2gwaVkxNUdrTW5QSGRNME1zTVhTV3BRYWI2Ckxh
dlV6cWhOZmppc0lkSTdFa3lpYlJZQ0liQUUrVTJYQ25MbE5iQnNzTDBWRG8wYUxDVEZ0YmlsVmVV
dktZVGQKS3lZRlkvUW9MZ1V2Ykc1RTJQYTVnRlJESDJJd0ZleUhuUUJBQkhTTGx1am12UnlqMFRk
d2lvbnBIZEhvNC9McApzVC93SFhneThNdFdPM3ZZS2xVeFRIQ09wK0hld3dLMll0KzY4eDArdUFZ
QXJ0N1FERDcrTno1SUhoMWpBR0F1CjFJTC8vL3ovYUkwRms2cWl0OUpzRGk2TjFYUldGRmY0U0tJ
REN5bkd1MlJsVDhpcXBMRGVHUlc5ZHh6SHI0MVUKMWxLbHR0UUVtUjdMUkVObTZpRmJZT3NhcjlO
TFFxVUpNQmk2NjIrY0o4UVROWEJRNmNONW1iYVV0WjduOG4vcgpmejhBbklBcS9KdVU2U3dlUTdZ
ZGhObk5Wczg0d01sN3JBeTdBY3dORVk3c0ZTeXM3NkFUVDZUSzNjb2RyMngvCkhUUFozakYwck1I
K09sYlIyZjd0TVg4c3BGZko5NkdPLzZFM1Znbz0KPXo0MXMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006607ea064c44a16e--
