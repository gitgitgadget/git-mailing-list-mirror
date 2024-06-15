Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D4179F5
	for <git@vger.kernel.org>; Sat, 15 Jun 2024 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718484678; cv=none; b=UmHaFIpQes2hFrKvtS4qpwVWf2ed/lgW7eTA3KfuHJQk8lHBpTXW8X68cRMY2S/jZZWZDIVDv4dDu5FGPLI/p18qn75tXg1Tlo7/dWTIVJOGK0GzysOYCV14GH5eK8xeZ2TaNqBu2hg25511kdAGRuEuu/igaTQQWVXpjr+Dgbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718484678; c=relaxed/simple;
	bh=35U8bwjg0qEo/VYGUhJgOZDlEwhb689s4WiD/hJR9II=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8Ky0Y+FoHQ/gwKlfCaMUpKOYYHsOJy7+MY0Dep5u4csvtB/IE1rM0cH/RZxdmO1Eyd2mW49IZE2kndJISevLvWtvRPq8sndp4mfyMOxLUp3Oh9a1KRixDRfKYwTs/E2BHxUATN9lWR7VYar+C8OXLCTA44XXnv83JBLIrdLac0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TutgE7bl; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TutgE7bl"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2547e1c7bbeso1671364fac.2
        for <git@vger.kernel.org>; Sat, 15 Jun 2024 13:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718484676; x=1719089476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1XI/E6xbSxx3yz9/wr6PIa9q1XclNzuEnTT2eeoVkY=;
        b=TutgE7blAB46kNatQs6df15qG6QrBouqDTWveZw1ZXJkweiEqGLzNC7lcZiGDoLM4S
         yAMglrZni2sSoiBu9mfKkICELJxpbJ6IayhbrTjxjpha1+lCM32+sFSFECByC+F4wwyF
         QNkt52q4O7yAVkDzcPyqreN4W2eujewVrwyZFXvAHV1dqSmOqySE5zCATAsBCJRvKqx5
         sztpt86Tzy5Bzzhln30xFRr2oCO7um6ywWQ0KR1s9fc8L4a0bPd5NXJXtFbzMaA/B2lr
         ZKG6j4dd0uohvf0BHWXbNWrUf6DN/vFH3MuQsl9n/UbjNu497m3K/BEDgrlTBRMKkQVk
         XMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718484676; x=1719089476;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1XI/E6xbSxx3yz9/wr6PIa9q1XclNzuEnTT2eeoVkY=;
        b=MF0Bj9QLQe4LfBjAPTU04nKxAJiRgRIsF8EpN3EkBr1XwPTrJF/DlRHdsjpqE4YK7s
         yTlFPfqCggBhrDgZwFO5pON2q0fiRhbVqPdzEGvykWXu5rATeb6s5uQj2lxdG+LTQQXR
         rHxI72Gvt6D+wMQo5trjnQUvzuwpuXJbt00XT6b1IhDkOmyloICWsUR3f1yBOn+d/nL+
         sYGgE/oUdML78jt+cIxlC3sgYHbziznNSMAJubxZkxa+h+0j9AG/zRLxfTfjmkeK0qKB
         EJHrgiYjaL/RrqG8Np0//voUwDByVOLBVo27cV8lM6npoA2i0nGA7eby/nfIKeER99Cw
         0mlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxrdSWIGFdiKMhJep01cY1IEJpDUypGwFR1nV5JrQ/nDh2nh9tzsAOZ0C0lKU9769oEmf46y5Y9ub2GvCNbbVd3ypE
X-Gm-Message-State: AOJu0Yxhl9tl8Yb6bdtxEcyi6KSlUGHB+0UFwTRYvtEknfLaQ0v4tWfX
	KbtA8fzg0XYvRpsFuZYUm6TRZej4KTBihWgcUtVCGK3dT6nJyLkJVXJjRuPhApX78egVQsYvMLv
	ERkt3ChR0BUuhObjlP6L7eNZEgTI=
X-Google-Smtp-Source: AGHT+IEQO72KQn34CK7LAvio8eHAMDGrWp+/EPfMvyV6uuqzsZtj11tcFkwSR9ckeAapVLSpViUTTBHe86jDawVrPto=
X-Received: by 2002:a05:6871:3a1f:b0:254:a153:e9f1 with SMTP id
 586e51a60fabf-2584297b988mr6756636fac.27.1718484675731; Sat, 15 Jun 2024
 13:51:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 15 Jun 2024 16:51:14 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240612085349.710785-6-shejialuo@gmail.com>
References: <20240530122753.1114818-1-shejialuo@gmail.com> <20240612085349.710785-1-shejialuo@gmail.com>
 <20240612085349.710785-6-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 15 Jun 2024 16:51:14 -0400
Message-ID: <CAOLa=ZQ5msKTHwDou2RmCrUCdfDuYdFwJQx3Q9gK6aAJvGw-pg@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 5/7] files-backend: add unified interface for
 refs scanning
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: multipart/mixed; boundary="000000000000a641cf061af3e4fe"

--000000000000a641cf061af3e4fe
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> For refs and reflogs, we need to scan its corresponding directories to
> check every regular file or symbolic link which shares the same pattern.
> Introduce a unified interface for scanning directories for
> files-backend.
>

Here we talk about reflogs, but we only add a iterator for
"$GIT_DIR/refs". Should we add something for reflogs too?

> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  refs/files-backend.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index e965345ad8..b26cfb8ba6 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -4,6 +4,7 @@
>  #include "../gettext.h"
>  #include "../hash.h"
>  #include "../hex.h"
> +#include "../fsck.h"
>  #include "../refs.h"
>  #include "refs-internal.h"
>  #include "ref-cache.h"
> @@ -3402,6 +3403,78 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
>  	return ret;
>  }
>
> +/*
> + * For refs and reflogs, they share a unified interface when scanning
> + * the whole directory. This function is used as the callback for each
> + * regular file or symlink in the directory.
> + */
> +typedef int (*files_fsck_refs_fn)(struct fsck_refs_options *o,
> +				  const char *gitdir,
> +				  const char *refs_check_dir,
> +				  struct dir_iterator *iter);
> +
> +static int files_fsck_refs_dir(struct ref_store *ref_store,
> +			       struct fsck_refs_options *o,
> +			       const char *refs_check_dir,
> +			       files_fsck_refs_fn *fsck_refs_fns)
> +{
> +	const char *gitdir = ref_store->gitdir;
> +	struct strbuf sb = STRBUF_INIT;
> +	struct dir_iterator *iter;
> +	int iter_status;
> +	int ret = 0;
> +
> +	strbuf_addf(&sb, "%s/%s", gitdir, refs_check_dir);
> +
> +	iter = dir_iterator_begin(sb.buf, 0);
> +
> +	if (!iter) {
> +		ret = error_errno("cannot open directory %s", sb.buf);
> +		goto out;
> +	}
> +
> +	while ((iter_status = dir_iterator_advance(iter)) == ITER_OK) {
> +		if (S_ISDIR(iter->st.st_mode)) {
> +			continue;
> +		} else if (S_ISREG(iter->st.st_mode) ||
> +			   S_ISLNK(iter->st.st_mode)) {
> +			if (o->verbose)
> +				fprintf_ln(stderr, "Checking %s/%s",
> +					   refs_check_dir, iter->relative_path);
> +			for (size_t i = 0; fsck_refs_fns[i]; i++) {
> +				if (fsck_refs_fns[i](o, gitdir, refs_check_dir, iter))
> +					ret = -1;
> +			}
> +		} else {
> +			ret = error(_("unexpected file type for '%s'"),
> +				    iter->basename);
> +		}
> +	}
> +
> +	if (iter_status != ITER_DONE)
> +		ret = error(_("failed to iterate over '%s'"), sb.buf);
> +
> +out:
> +	strbuf_release(&sb);
> +	return ret;
> +}
> +
> +static int files_fsck_refs(struct ref_store *ref_store,
> +			   struct fsck_refs_options *o)
> +{
> +	int ret;
> +	files_fsck_refs_fn fsck_refs_fns[]= {
> +		NULL
> +	};
> +
> +	if (o->verbose)
> +		fprintf_ln(stderr, "Checking references consistency");
> +
> +	ret = files_fsck_refs_dir(ref_store, o, "refs", fsck_refs_fns);
> +
> +	return ret;
> +}

I'm not fully sure why this needs to be separate from `files_fsck`. Is
that because we plan to also introduce `files_fsck_reflogs`?

> +
>  static int files_fsck(struct ref_store *ref_store,
>  		      struct fsck_refs_options *o)
>  {
> @@ -3410,6 +3483,8 @@ static int files_fsck(struct ref_store *ref_store,
>  		files_downcast(ref_store, REF_STORE_READ, "fsck");
>
>  	ret = refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
> +	ret = files_fsck_refs(ref_store, o);
> +
>  	return ret;
>  }
>
> --
> 2.45.2

--000000000000a641cf061af3e4fe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b23e589c8eab2997_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1adC9zRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMDhGQy9vQzFlNVpHWjd5ZUQzb096Nm9KbmpHMXNMcgpURVhodXphK3hy
MTJ2SzNnK1VRaTl4UTFhc01NZnlaYVA3VDczblV1ZUhSWGFTRE9vaCtGVGRVSDg2TUxqNDJoCnhj
Y2N1SlJtVGVxbExKMC9Va3NYUHNBbE5Dcm5OY2JEVzJkVk03NXFCWTZoRFB4MExFUnl3OTBBbkZV
VG5zdGsKWm93aTFrcUJKcVJ3NHJoVzhQOVJLSnljeHFxRmVETitwWEJYc2R6YVFsYnBpcmJBWlQz
S3p0dmJPQ1R2eUxYUQowb2lDeDE1V2hIMUtwczRReWpUNHBmYmdHVXhHczA2YnczWFZrSVFNMWlm
Um83QzA1eC9HWDNKODV2ZzV6cng4CmhtYjVlUDMwbkRkWjlKdTZBTHpqaTJRQUtMSk04RVFlTlNq
YUFCcytDeUdEU2k2b0RyQTRLdVRxcUloTTVNaCsKS0VNVXJBWnMxVXgxdHZTcEo5eWFncVhZai85
MzNCOE9iNFhra0RIaDVHTGZJOWt3WmRBSWRoZk1nblRuZytkdAoxNlYxUmRnNDNYVVlrNkpCOG55
V211aC9BRGpOd1g3bUlJY2JEWTBPOUhONXJhU1F6YkMxcmJnbko3TFhYMHZZCjZCZFlESGVEb0hV
SlNKdSttVk9XZG9jeStzTFBsNU9sWFpUZm1xaz0KPTh6NUcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a641cf061af3e4fe--
