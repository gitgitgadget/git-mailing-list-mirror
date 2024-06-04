Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7713B145335
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499826; cv=none; b=oP5e4FaJiq8Mu12lZHfswZZizBxZI4h9kj/xMXvJO20voJNIep9gpo8z/Ue92LDRBqo9Qn7Ddjr0hBxL5lrGNe89Kq25XsmzQXvUiU08YSBm24fZbxvhRR+4TPsaAp/136jEZrr2mSzhjvJR3mFegyLZ+fXJj/Aztd/gfqZvNdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499826; c=relaxed/simple;
	bh=rJ+b6tmWUyWgcjq9huj+TPOLCfs/QXqiSBt+o2Swlok=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKuly6l+nrfd7ALiYAtrZROL9rpihqF58iA/ulsN19sulgnBsvgvKz2KzvOLXqD9r1FewkeIi6cewOFGG2yktbd1hW9kOaAYj1bTykFrJrG7Jgygz79EDmGTmCkqkzqEuWochAaSGSQwOLq7cmt2pDXUa+cUKAM+Ff9DfGX2PnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+Fv35xh; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+Fv35xh"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ba6859fb57so259567eaf.2
        for <git@vger.kernel.org>; Tue, 04 Jun 2024 04:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717499824; x=1718104624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c+PVw0Y6u3M11G3h/rA/w36Vln2Kh3NNWoonurWdOuU=;
        b=S+Fv35xhrfdGkt3DhGx4ndWaJisq/jcqlRkvYT1tvALn6Z/xYJZ4zJ9dquXQhhikVu
         EL1wpW4F8zY9ndHRHbj2hvX83WfEJbMPNVLaSwgPjDwP793hzC9AOMj52R0HKMT5fXrR
         SvtfQpPztDVW9zzjb4d8cHTevFqNas2t4zekHa3dTHlrtaSBtPhKCpNwjTcwLa6KnOkC
         kA1sX8x9k5QB8hGUzUCcVIiQIqu2nG+mkr7kZNY2B+PCdrYYX9lFete+IENsA7YzzXJ2
         csqcozBlvUYNr4rMKdb9o1PKxte1ESIQpXmhne6ztK1fe1EjIEpbWLqUi6/j2CUxcnY9
         hdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717499824; x=1718104624;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c+PVw0Y6u3M11G3h/rA/w36Vln2Kh3NNWoonurWdOuU=;
        b=rf9y8Kin0FlpGvIE9XfNj1rrl7TLf0zu97d90juGPV8sPnMRpEGV5wBUnS2zgoknUr
         U+dVkQyv1L4E6PG68Pr2yTWcsfmMVsfD/5o7gs/blkcnj705Anpxr+hDJCszjxRGLHYh
         0AfFvlJZyiDZ9tTlc8GYhUQZ2J5K2we7hUWKs9TbSnWFbz6t53P+MK5wUu826hZn+I5z
         bPdWsoHlBvESOqZtkNdGFe9lx0e8eG3CgwalBYYIpyW001U3mp/gBBRj8bWzYYeqX6LC
         mnuLdPn9a9z5TA1AB03RbH2AMJga4Oa1u3zBs685Pcq8oK4d0n0GE61dnPwTmEIdGVM2
         7IEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtNSFE0UpO7mYdh3VmXYvUXyY2RPtuZPqcY0QB1hv+uGCp6TznH9GlJE9pwS8RQvZl1Qnn8LdkHmcl5tY52BAAuGFd
X-Gm-Message-State: AOJu0YwEjzh2dCZHArd/sLDoesnxUYzdaL0JwC6a7SY90Fvg3oyZ/muk
	VLO4jOkhgowi6C4gJLpRyWp6yterpqwWmNkETKXX/3ZJcHtdsPecs/ESGeXdrId9SU77X4rE8FY
	B/bGhbkOh0NRx5yrw7ci8NkEZ/28=
X-Google-Smtp-Source: AGHT+IEwSwSdG2dHDKKOoT1Bx6NeV0xyhG6yJP9/BC/PfM3yLHS2CMz4GR97/zcf0WaXGozGHrbuRqDiBi6UauD2pGo=
X-Received: by 2002:a05:6871:739d:b0:24c:b2c0:5bc9 with SMTP id
 586e51a60fabf-2508b7e3e97mr12699393fac.13.1717499824366; Tue, 04 Jun 2024
 04:17:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Jun 2024 04:17:03 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <f9d9420cf93025595e00aa4287bc0cc1a1c067ab.1717402363.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im> <cover.1717402363.git.ps@pks.im> <f9d9420cf93025595e00aa4287bc0cc1a1c067ab.1717402363.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 4 Jun 2024 04:17:03 -0700
Message-ID: <CAOLa=ZRoX0Yic+ge34kAbC2p6kOAfypEkuLzmFp5Y2+iAQQpjg@mail.gmail.com>
Subject: Re: [PATCH v4 10/12] refs: implement removal of ref storages
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000ef05a9061a0e96c2"

--000000000000ef05a9061a0e96c2
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index bffed9257f..e555be4671 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1,6 +1,7 @@
>  #include "../git-compat-util.h"
>  #include "../abspath.h"
>  #include "../chdir-notify.h"
> +#include "../dir.h"
>  #include "../environment.h"
>  #include "../gettext.h"
>  #include "../hash.h"
> @@ -343,6 +344,56 @@ static int reftable_be_create_on_disk(struct ref_store *ref_store,
>  	return 0;
>  }
>
> +static int reftable_be_remove_on_disk(struct ref_store *ref_store,
> +				      struct strbuf *err)
> +{
> +	struct reftable_ref_store *refs =
> +		reftable_be_downcast(ref_store, REF_STORE_WRITE, "remove");
> +	struct strbuf sb = STRBUF_INIT;
> +	int ret = 0;
> +
> +	/*
> +	 * Release the ref store such that all stacks are closed. This is
> +	 * required so that the "tables.list" file is not open anymore, which
> +	 * would otherwise make it impossible to remove the file on Windows.
> +	 */
> +	reftable_be_release(ref_store);
> +
> +	strbuf_addf(&sb, "%s/reftable", refs->base.gitdir);
> +	if (remove_dir_recursively(&sb, 0) < 0) {
> +		strbuf_addf(err, "could not delete reftables: %s",
> +			    strerror(errno));
> +		ret = -1;
> +	}
> +	strbuf_reset(&sb);
> +
> +	strbuf_addf(&sb, "%s/HEAD", refs->base.gitdir);
> +	if (unlink(sb.buf) < 0) {
> +		strbuf_addf(err, "could not delete stub HEAD: %s",
> +			    strerror(errno));
> +		ret = -1;
> +	}
> +	strbuf_reset(&sb);
> +
> +	strbuf_addf(&sb, "%s/refs/heads", refs->base.gitdir);
> +	if (unlink(sb.buf) < 0) {
> +		strbuf_addf(err, "could not delete stub heads: %s",
> +			    strerror(errno));
> +		ret = -1;
> +	}
> +	strbuf_reset(&sb);
> +
> +	strbuf_addf(&sb, "%s/refs", refs->base.gitdir);
> +	if (rmdir(sb.buf) < 0) {
> +		strbuf_addf(err, "could not delete stub heads: %s",

Nit: Wouldn't it be nicer to be able to differentiate this from the
previous case? Both have the same error message.

Otherwise this patch looks good, since we use unlink(2), that handles
symrefs which are symbolic links too.

--000000000000ef05a9061a0e96c2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7261fccd9ed9cf8d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aZTk2MFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNG4wQy80bmhXYlBIZWYyT095cEpVaXBYYXdPenNqTwpnMlkzcWlvZU5w
aGlmamMwd09IRklZZXdYYjQvR3BJMkJKNVpIQ1d4ZmMvczM0MjVKQ2hnQVAybFB0bHNrVFdOCkFP
SzhkTE1ia3NYWjNDZVpVYldmcThkOS8xV1pYcjNjVC8vdnhQYWNuK1ZxZ2FBTXBjV3ZwK0hhZjFK
amU2cEIKYUJBejl3TDRTYUZySjdwS3pralZ0aUdpYmRybk13TGRGbHk4Q2wxbnh0WlFqTzZyb1BH
enpmWXhsdlR6Z01BdwpHaEdjRVJQY0tOZFlNVm1RTGFpb1ZmdUYvRm00dXloeENJL0s3ZGhxS2hQ
MjlhZUxWQlVva2RnWmkzRDVBVGtSCkhrUzJ1S1NpVkF2YkFKVTZ1ZWEydi9PZFBqak4zTlRWODZv
UHlqamg1a1NpTmJ6NFlJNWtYZU9yeFRQWnQzaUMKbno2T2JyNFplcjBVcFhJQ3FrL0d5UUxaYXhC
MkU0cENqczBTeHpabXhHUHZKTEdVUzM5bnVrYzM0N1ZmYlBYVwowSDF3ajgwY2hNOEpOUFoxRytv
YnFVYmlsYTNZdElIUkEzbDdESk1HWmRQanFFOUpRamNhd0NnSFJoSkpyaGxzClZrMVJ3RzhTZE5R
emNaaGFhd1FCZnE0VWZuOTN6eFBPS2hveldOYz0KPXh3eHIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ef05a9061a0e96c2--
