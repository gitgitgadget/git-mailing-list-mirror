Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD7B26ACA
	for <git@vger.kernel.org>; Thu, 16 May 2024 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871017; cv=none; b=CD84WBVxVgiVBZcWf2evgKKaLfWnFOPID6EfhwpbCnQ+9jNcj/l90dV5msTh4wMrTBXkFyU4DmTegbxXGMDGPMF8Nthp2TipgmUDVVi5Whx48hmVnYwQsm3N5hzasIP9EqSF03I3Yp1HmSPwtwd7DQZjSD3KR2aigMyUr4oOgzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871017; c=relaxed/simple;
	bh=yTUtXpl/77ArFzsQA06tLm7v4hn+LoYwpCxc1VsRV+8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=NibU/5SkVxMES6Vgf1ZkBhFU7rqRLdDb4WXivPvf0RAkqXfan0rtYpQiW6SJZJ71GPOiJjk/u3wUg6G2suHZVNH/Ak6y8L4Qgj7W7FZIyy+kUzuVEtGDMtFCOzDvKmD7qcbtSl0pSajDGfESlVV0Cp/vS8VgbKiN+ZplE3Wh+rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWR/XY+g; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWR/XY+g"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b277e17e15so187430eaf.2
        for <git@vger.kernel.org>; Thu, 16 May 2024 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715871015; x=1716475815; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Z3vUORAX0CUkeYuPKn13DMBu7hB4BDiKsu5nJ0fOd8=;
        b=MWR/XY+gIWmUklecOOObjNmlCGfmb+b+lFQY/aox5xheN8rtM/3ZB2VdW+jTw4Afju
         cT6mzt1ZNb2EVcCv9yhaAZdvV65yJN2xlP65ResU4CGipnksP4PVtiTRuyV3kCmWOni4
         NMHZRCXWYY2eEsv2EZifBDpYm3DgBYQyKlUuF2ByCLfmSWviEylyVOpn8a8OvlV5phNw
         VbRmrWuGU9ng7yLB3GC/EY39gE5vrfdHHgHP6w0TivsskqtDjZatkKLqoBGrtAkwBgT9
         cOSTwVZIrumLYIw5ypnKCdCUb3xcQE7s2Hp5FIlmguqVjWrQnMbpkZh2AVS1loYX6bxU
         NkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715871015; x=1716475815;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Z3vUORAX0CUkeYuPKn13DMBu7hB4BDiKsu5nJ0fOd8=;
        b=A/n0pKeUqxwh+gkDGixX1ATa+3AnWD2d7raJ94pT48BeeC1f2RJAs/eCv8E8r2qzPo
         9XDNN/udV8EdrBHYc/rKr0Or5SCaiHmrCLtaaVQogHshocVots0ou1k0T1HO0bS9FS1F
         UZhQ0zXNKp/izoUdEHgTlDvQ9kx2YmB+Z6lPN5gXrUkLQ2BaAb9GY65dzQVT3kji/DeR
         AMnWeh/RVZJkv2i8HQ6hwFbM2e5X0jNkBWkm7mPq0yzeejUEVSyXZL3/rgu5FEcS4/z5
         Wn6Q97pdxvmYBDhqQq6HeTAs7jWE5vpggmRdUVsdZ2xgG6nnyaEVCOUdtoPiNFQdciJ5
         ruoA==
X-Forwarded-Encrypted: i=1; AJvYcCUUVp7L5L/Cbuj2sSv1GBvFOS2nDQIfe5LbYoTCCCEWRqVlJEU4kY4tBeZxHA4IR1VFZEAQEM6uLukOGoNGM/S0LlKI
X-Gm-Message-State: AOJu0YwvtsP9Fq/ZfYVaIdDbyc8MmLPm9G3BBrXehijCGrJs1JeaSF4Q
	XA/I63cS1GylbyGJ9KHi4qy04v+1JafGbCPvGiiLinUna0p+RY2vbnlyqM0UOnHemDpNgFliXxr
	udV2INpYRXif3zyo1DnF/D4Vs0aBnvw==
X-Google-Smtp-Source: AGHT+IFCeoSADOyqVcbOPU1GqiBqVMIVGVb0Kb8PyMjiOnDbE66w5no5fNjxOlxWOBW6MpTFZeuYOqjgthXYErUvnX4=
X-Received: by 2002:a05:6870:f716:b0:245:4e2d:5d8e with SMTP id
 586e51a60fabf-2454e2d5eebmr1509330fac.6.1715871015240; Thu, 16 May 2024
 07:50:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 May 2024 10:50:14 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <360d03474635e36a80a3b720bf0f86ac272c618e.1715836916.git.ps@pks.im>
References: <cover.1715836916.git.ps@pks.im> <360d03474635e36a80a3b720bf0f86ac272c618e.1715836916.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 May 2024 10:50:14 -0400
Message-ID: <CAOLa=ZR9ztsfo=j_4Vyj_YfKwGO2a7uCi+ykfYGFu5UHHq6xqQ@mail.gmail.com>
Subject: Re: [PATCH 01/16] refs: adjust names for `init` and `init_db` callbacks
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000058259d0618935a47"

--00000000000058259d0618935a47
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The names of the functions that implement the the `init` and `init_db`

s/the//

> callbacks in the "files" and "packed" backends do not match the names of
> the callbacks, which is inconsistent. Rename them so that they match,
> which makes it easier to discover their respective implementations.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/files-backend.c  | 10 +++++-----
>  refs/packed-backend.c | 16 ++++++++--------
>  refs/packed-backend.h |  6 +++---
>  3 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index a098d14ea0..2c9d5e0747 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -89,9 +89,9 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
>   * Create a new submodule ref cache and add it to the internal
>   * set of caches.
>   */
> -static struct ref_store *files_ref_store_create(struct repository *repo,
> -						const char *gitdir,
> -						unsigned int flags)
> +static struct ref_store *files_ref_store_init(struct repository *repo,
> +					      const char *gitdir,
> +					      unsigned int flags)
>  {
>  	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
>  	struct ref_store *ref_store = (struct ref_store *)refs;
> @@ -102,7 +102,7 @@ static struct ref_store *files_ref_store_create(struct repository *repo,
>  	get_common_dir_noenv(&sb, gitdir);
>  	refs->gitcommondir = strbuf_detach(&sb, NULL);
>  	refs->packed_ref_store =
> -		packed_ref_store_create(repo, refs->gitcommondir, flags);
> +		packed_ref_store_init(repo, refs->gitcommondir, flags);
>
>  	chdir_notify_reparent("files-backend $GIT_DIR", &refs->base.gitdir);
>  	chdir_notify_reparent("files-backend $GIT_COMMONDIR",
> @@ -3283,7 +3283,7 @@ static int files_init_db(struct ref_store *ref_store,
>
>  struct ref_storage_be refs_be_files = {
>  	.name = "files",
> -	.init = files_ref_store_create,
> +	.init = files_ref_store_init,
>  	.init_db = files_init_db,
>  	.transaction_prepare = files_transaction_prepare,
>  	.transaction_finish = files_transaction_finish,
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 4e826c05ff..a3c5a75073 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -200,9 +200,9 @@ static int release_snapshot(struct snapshot *snapshot)
>  	}
>  }
>
> -struct ref_store *packed_ref_store_create(struct repository *repo,
> -					  const char *gitdir,
> -					  unsigned int store_flags)
> +struct ref_store *packed_ref_store_init(struct repository *repo,
> +					const char *gitdir,
> +					unsigned int store_flags)
>  {
>  	struct packed_ref_store *refs = xcalloc(1, sizeof(*refs));
>  	struct ref_store *ref_store = (struct ref_store *)refs;
> @@ -1244,9 +1244,9 @@ int packed_refs_is_locked(struct ref_store *ref_store)
>  static const char PACKED_REFS_HEADER[] =
>  	"# pack-refs with: peeled fully-peeled sorted \n";
>
> -static int packed_init_db(struct ref_store *ref_store UNUSED,
> -			  int flags UNUSED,
> -			  struct strbuf *err UNUSED)
> +static int packed_ref_store_init_db(struct ref_store *ref_store UNUSED,
> +				    int flags UNUSED,
> +				    struct strbuf *err UNUSED)
>  {
>  	/* Nothing to do. */
>  	return 0;
> @@ -1706,8 +1706,8 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
>
>  struct ref_storage_be refs_be_packed = {
>  	.name = "packed",
> -	.init = packed_ref_store_create,
> -	.init_db = packed_init_db,
> +	.init = packed_ref_store_init,
> +	.init_db = packed_ref_store_init_db,
>  	.transaction_prepare = packed_transaction_prepare,
>  	.transaction_finish = packed_transaction_finish,
>  	.transaction_abort = packed_transaction_abort,
> diff --git a/refs/packed-backend.h b/refs/packed-backend.h
> index 9dd8a344c3..09437ad13b 100644
> --- a/refs/packed-backend.h
> +++ b/refs/packed-backend.h
> @@ -13,9 +13,9 @@ struct ref_transaction;
>   * even among packed refs.
>   */
>
> -struct ref_store *packed_ref_store_create(struct repository *repo,
> -					  const char *gitdir,
> -					  unsigned int store_flags);
> +struct ref_store *packed_ref_store_init(struct repository *repo,
> +					const char *gitdir,
> +					unsigned int store_flags);
>
>  /*
>   * Lock the packed-refs file for writing. Flags is passed to
> --
> 2.45.1.190.g19fe900cfc.dirty

The rest of this patch looks good.

--00000000000058259d0618935a47
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: aa9ab8ea09d15f80_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aR0hTTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN3hEQy85N1NjK2xhbEswNURUa3lUbEdyTXZ2Q3FCLwoxNzU3RmR4OEcv
ZWhGUkhZQVluYVFDRmQwN2h6TkVrYWJUTlN1a0xQbnlpVWZlellMUnB6MDB6RFFqQ1FsZThQCjFJ
bEV3MlZjNlg2aS9tZ1lXODdoKzBDRThCdGY5ckQwN21tbkRzM2JWSFU2ckdWbktrTjJpWm1XY3pq
WkVCOE0KUmtsVlBRZml6aWI0RkJOZ2UrazhuOG10Q21FTHhubnlRZVlkN2F6MHhOVVpWbVA4c1RY
dWpOVXlQRXBkcDVkcQp5QU5ZUFNHZVBXZDZNd3NZWWZ4WFZadGJ0OUdFVm9YbVB1ZXpJQmxmb1Fk
ZUZRd1o2YkNyQnM4WVRWY2dpeUIxCnB4NlRWbGhvVW04WVF3SjY1U0hYanRIQ0VJTHZQNkcybEpn
Mld6NDZiNUpIRGg1TGVsaWhWSmRlZzBOWm5uS3IKemlZZEorR3RFUUw1KzFTcDBmVDNrRnBwWitU
TG5URmVXU0p2OUN4blNITTB0MitGempJazFLcFpsNG5BVkxzcAo4SngzcG80ajFjb1VUelo2TEhT
Yi9SdXBwSGRDOTdpOG5kWXVyRURNMnVsYyttMDluZGljOGtsbW1CdGVaRHVRCk5vekRSWEFCejEy
M1FhZmgyaFJPcERpdFhGK3NVc3orVXNvbDFIYz0KPTFBQVUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000058259d0618935a47--
