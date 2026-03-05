Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C10E21D5AF
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772706006; cv=pass; b=kXUxqgUGXfgrXmqt5SmVSQeUP5btIOcqZtohErPte/z1EdtOsdfFMh7vjkGiCYJ/uZ5VcHLCq+6LSqwF/jhMrHI7cPYWkMHf11cvOvsWA4huNBkxKiERuE0rKAuZ/JxA/CE5RCMDXE/VkAVCgXiFSvJQGx5EqyCyHtIsxFefsWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772706006; c=relaxed/simple;
	bh=rb24HAYVNq8NZJhUdCDYq8ALib+WRSJeAGzMGdgVFoI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=hPs6UZpFfUzWhHFUXDZE3i03rVYEispI9ZETf1kKF66q1vs7MflrvLdrBbkVXxl3t/B2EPeg7AtWtQ+QgZ8eI8x8PwHUlDtLUdJqw17cb/PuLZP26A7fqxR0Bc15JclTzJ1Mf6tIYPiLmPc8xiJc5vkusXb4gnwgEqDR/NExwsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwNljvVz; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwNljvVz"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-94de6081c1cso4761933241.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 02:20:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772706004; cv=none;
        d=google.com; s=arc-20240605;
        b=PRHtzLT/UQShdHJkTtdPcO2g7APdo/izKs5A05Jf6JVzGbC5VJ7ZF43K8bTi5+DkXv
         4OHRl+lHCVw36lk62szsXwdb0K03SVpHDO0zO9kkQsDERuQPMXx6wwx51boT33ZYx5X6
         7Jw1FBr52IBq5sj8qgTt27M+CB2OYjzx1XY147TnxMqo2czyrdijFEqSbKqGSJBeBKP0
         qbjXsgOlzG+IZ44RboI7baTy564OEtxM9I7PvL9omJHKkQyMBUmGCotTzRxAxZtAF/VO
         v9UwFZG0PciBX5i6XHH0o/eA99CFzNIvqTsuQqAebLeRCE50nbvAdYuLN853sOlvJtCP
         F0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=SmEkiel4GKWaVhDSqfTp4e/C6ttz2M94OdtRU3RVfxA=;
        fh=Lk6ykeLRv+U6LvpB1eoO6SPKhT4pK5+IuNvzm8t1Qp4=;
        b=TwnqApGogl32ymmtTffeoNjBEN/fBsi6yxQju9hg0GXT82KCNqNAWSNYryE6nl0ins
         i+oxN1+NvVaieJsujtv6l3Ud/KgC6Vy1P9JKo4IUEkDD/O2vEk/hYqDY9LdkKKs4MSFN
         jVEraJo5l5OoxJps1umXDrEjVXwNomK9mspJoOa2qpVUTOBVlbO2d9/3tS3qpTHGX1Eh
         thSlHfLI2zPf8eXuVw6m7XwMntM/EJMIUTESSUgDky52QOVJLc1Mrr/FRym3DN6sHgdY
         N+TukY9pYuwtsLBVT2mQVDRGWnY9Xwcr0+pg4Q4wd9BSntrDbt4qZnS2F5gFwfe2XO3C
         QPLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772706004; x=1773310804; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmEkiel4GKWaVhDSqfTp4e/C6ttz2M94OdtRU3RVfxA=;
        b=iwNljvVzegh8ejf3Couc+HDTe7ifqoaMkv4wWD0hzM84oLWAvW9/hjCUuflmJLGYiT
         mlLjSV025MVi2NYifTfNIbqgsmFYkglnhly24/fivI431i9ysAxOC3lai0T4sGYiykZS
         5i+arTY6Z+Y+45hM6+gemC93m5RBAn0b5cTfo8PxkJeQmYORCVbtu4NA/5+5g45NgXx5
         Je1jasrVitbW2DuCRTicmg4kRFg5tIwX9NbmichOz+hcqF1Ogvv9AGqmDcM4bPKv+Orm
         s63U/TvDH8mwQMrD6x5Pv/aTz+D+aW0Ol5W4aaFi0wcxse1KSrFFuZ+TqMmF5CNzOhop
         u9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772706004; x=1773310804;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmEkiel4GKWaVhDSqfTp4e/C6ttz2M94OdtRU3RVfxA=;
        b=FlLYmNn4u012q5zflLGED0RueCnlsx0t0TmisY09CcidmDec/6+S6VsOZr4H7JgBKi
         urMN+EGd5Q5pqMcssoBY/2kwlIxOTJEjPF4ntye3TvS4GwlPnBNOpkxZtkD83uhb2Fye
         5XDBJ7TMUsTiIhdcjnHFR6aLhfjU8SQQJfm3D8a7wWIiX60R5rD8ZiFY8AmWvOyxfTEI
         eTppZ9WFtVGbc4zUZQM6bqSCyqOIeBkOxplk/AadQZZgtqNdTHdSYslaOC+OxNkqmwqD
         Acr7CAgwZLvFvjezaPmtJ56Ko81gl7tR2A5qAk/7/80z0ZLUeGkW1/Ypi4nlWzrY4S40
         t2uw==
X-Forwarded-Encrypted: i=1; AJvYcCUoXg44sbgLaxVNF/xHZmwDBfkwDclv5Qg0FVDj1mPcO+rB2D1uNzw/Eka7Ej7ahIzwibA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+pHayazJn0+VSFojbHWw4AtdBv1vxPDjuV+M/rHe/OdkrVMPe
	Z5Yq8JdNna5aGnjQRHSoAK0MsVHuprzJhnX3vaR9Ir4EQdWIgbVspsXBY8RbnxiLFenN5J3IyTW
	EE0teu3FN4F8poqqUNgCn7RWw8rha9T+Kb4oJ
X-Gm-Gg: ATEYQzxMeCedw0RADijMZ1VaB5CHEfe+V1ELCSWyrqyHXGn5RoOSKwuBapcGqklTo3G
	sY0xRiAqjjE3cJKA3Fn0VKmwct/a0MQ8rKeP/FQh6bzE2kdZvrdpoogbCVwo1MkUzzSaZwn2msN
	RblDEXCm24nLeqWZEbWmtT5cidK9EEdViSdLGCKAtXHr13EPmguxWueCjWTmnKDgA//ZQgEOYnD
	MRRYB06ft68y6K56x6JXx4hpDa8zT4DZ5xvcrdK1bT+/Hdb/X39ckf1BEjWUJJOGYsbClwwXPBE
	rKpWNmU5FGU//tY/PNtBNoJx7ZOnRhk/8lMgeeE7Kg==
X-Received: by 2002:a05:6102:5490:b0:5ff:1d91:a4bc with SMTP id
 ada2fe7eead31-5ffaad8cb2amr2607276137.18.1772706004155; Thu, 05 Mar 2026
 02:20:04 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Mar 2026 10:20:02 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Mar 2026 10:20:02 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-2-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im> <20260223-b4-pks-odb-source-pluggable-v1-2-253bac1db598@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 5 Mar 2026 10:20:02 +0000
X-Gm-Features: AaiRm52p2GoLXAHbWi8YivgX5Tex-cv_UeKmBqNi5x8X7PY64NK4rnlllB-aq_A
Message-ID: <CAOLa=ZSz=5KJvWLavfGdi3g_ETdOpBi+iYXM15p6N3dnyLX6Og@mail.gmail.com>
Subject: Re: [PATCH 02/17] odb: introduce "files" source
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ab5c31064c444794"

--000000000000ab5c31064c444794
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Introduce a new "files" object database source. This source encapsulates
> access to both loose object files and the packfile store, similar to how
> the "files" backend for refs encapsulates access to loose refs and the
> packed-refs file.
>
> Note that for now the "files" source is still a direct member of a
> `struct odb_source`. This architecture will be reversed in the next
> commit so that the files source contains a `struct odb_source`.
>

Okay, so peeking ahead, we will follow the same format as in the refs
DB, but this is an intermediate step in that direction.


> diff --git a/odb/source-files.c b/odb/source-files.c
> new file mode 100644
> index 0000000000..cbdaa6850f
> --- /dev/null
> +++ b/odb/source-files.c
> @@ -0,0 +1,23 @@
> +#include "git-compat-util.h"
> +#include "object-file.h"
> +#include "odb/source-files.h"
> +#include "packfile.h"
> +
> +void odb_source_files_free(struct odb_source_files *files)
> +{
> +	if (!files)
> +		return;
> +	odb_source_loose_free(files->loose);
> +	packfile_store_free(files->packed);
> +	free(files);
> +}
> +
> +struct odb_source_files *odb_source_files_new(struct odb_source *source)
> +{
> +	struct odb_source_files *files;
> +	CALLOC_ARRAY(files, 1);
> +	files->source = source;
> +	files->loose = odb_source_loose_new(source);
> +	files->packed = packfile_store_new(source);

Instead of defining `loose` and `packed` as part of the `obd_source`, we
move it specifically to the `obd_source->files`.

> +	return files;
> +}

The rest of the patch is just variable swapping, makes sense!

--000000000000ab5c31064c444794
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1538f5805763637c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tcFdORVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOWxYQy80dGxtL2ZUaVFrUWp0WmJFR0YvbysvTHJZLwp0MlFNd2RVb1ps
N0YwWTRoT0VQM2l4WWlPYUhaUENFOG1obmtYRmMwbjdMUG03VkhLYmpNVWtJVEl6dXdyaFprCkk3
ODQ2VENpNWhTVGFnSUlaUThiSkxlMGp3MHgybnVtMVJNUVhNUlhpM09QYnJsN1dJR2daaHhwTmcv
Mm1RTFQKa0p0YW1NNDl0TFlsTFRWeWtKMjNPNFA1Szkva0o1eHpzWjJPVHN5RTg2RHh2L1pHUmlC
VExTdmVNRHlocEpwSwpJQ1BvTFQvTys5dmU4NW9iMGdsTjRRbmtIYlpYMWRmckZjU3pmcTlsMlI0
ZnBBcUsrOHVVOUFrRmtoYWNTeUVqClo4SlY3MUVRRUtFc2d0ZVptS2xaMFRIUFBVUmRYbUJKZVhz
RjVxWnJydVNiT0VIOWxQelJ0OG0xU1JZTG41cUkKTTgzMEMvSmw1QWJwby9icmFsdzBXc2pOZmRO
UHlGTUhqU1h2MUhiVkpxckRGNHVpbFl3WXFoa1RZZmdVMU40cwpXQ3dMSUwyYWlDdmdqbzB1NWxk
c3o3ZWo1N2FEclV4TWVTT2VVK3BnSzJMbkpFdXIrZ2V6bFJiNndNVnBFL1ZXCi9LSjZVWVBxYldJ
OEpnb1RIZlFoTVJ6RnhsbmthTmtCQlhhNC9TZz0KPXFJQVcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ab5c31064c444794--
