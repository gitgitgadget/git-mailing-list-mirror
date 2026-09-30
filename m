Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C9546C850
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 11:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766388; cv=pass; b=dyAObXx4v10DzRCuBj5a8GgFbBZKsYxdL4TPKnWkSjzYwtAnQrrbz3btYzP4WPoXP5a+SoUOs0WdTDHbYyfgFowgsCRUUCwgiEXmbV4oSexeRh2bPqZ2fhSoo9xv/l0z7NWVGW0g9GeRoKeYGN0JyXmCmYMDO1pVKf14zfm5Dt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766388; c=relaxed/simple;
	bh=qbWxu38qG9vr2w3YnpOxBewULmwEtuZAGiI2iTwaFvQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRC8XQhUOeJEkBqCg5FoHf/aLXHxRiud5h+yfcRK3T4iUo/9btaz4R9hg8xe6hsf84f9HmeoKwCT+Qqmx1Br3jCwPzr57hwxg0ctHvJAm0/SKbQ27Rq2gArWWn/WqUuODwIn1H5j4Nadm3CHf318O5RMczvNCAlgoCcL0LnrvLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4YDa0N4; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4YDa0N4"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-989e5cbcb12so117236241.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 04:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790766379; cv=none;
        d=google.com; s=arc-20260327;
        b=lRoq099cNMdXUE5uRVf4YAuBCeVRKlvDiBh7VeBRJfcmVBYal3jGUHngO7jep21o7I
         I7kuzd5SamGVRjJ7TY5wBbsthnFGSIiW6cN5AtKf2KFdzdKb9Ns9NOeC5/OHnI3+qP8r
         WKnaVZ3udVb77v/vdsthX2syJn8uno1iSchYMmD8ZLvteI+4ZrHP0j2SSnFBH0s6styy
         CUY91+UARQbGKe6KzQL/aQajtXnQlV/dEudwZOlddVsWXpiSb3EP5exVNVZZUCdCZFZG
         EInY2qDV+h0gR/NlnHIDilutToROuwYwP7n5D9e9g1MIGpLXLxXX49oe5MLLb3SgIAk8
         67ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=gvJ3gvL9mkHLHEenBRppNmbuci4GAgqEoeCmuENaYyk=;
        fh=KLIo73DoAJYJFJm5BWJBUeAgtdZLXSTUHY/Cejme7tg=;
        b=XPzaihRB0MC+RbUb/X6gqm+fAQI8A1iob2s3AMmNmeE7ZTL/G9E1OKnQdOJ6ckh13h
         7n+Mgz1y8MP2bAKgYZ/IVClSkQgj5gTW91gIMNQ8NhP4SukLC+56IPSRE4PFmouwimIw
         PYkunRE1E8vslraC7AlgE05YnR4XgVMhFldydBpt4P623rkCHfMebdQxgg4Xrt51vMRu
         lkhAVHBrAPPQZgJ+THRq/+HiV9yl52B3jiD4Hsr8zDMHp6uk+S9FxS2P8eo2FOMTAXSm
         4P8Da23LvyYvmEDGqMm8v/9zSzkk8N86mS4N4FLMQRHhQcFhokXjea55GOYV83gDsw41
         gXwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790766379; x=1791371179; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gvJ3gvL9mkHLHEenBRppNmbuci4GAgqEoeCmuENaYyk=;
        b=V4YDa0N4vtu36+nDpMSESFIsODz5eG9pls4yFucuQlYV32FIoyQ3pySQFWhT/BigFK
         O3i98zURFgyX5v5xP+q8zLUtl5ujZxASELeBVFux+B/HHnf08+YT62mPXMpSm+IAafCH
         Vou0HxjWcaV0FjLRd1rBpTMRQHo2xiABnQOwMREs7yFNTBz89E/ym87J6LV2qInYJ97E
         DwAEEiVCok/Wro9pnR/KNLtw0CReNGbrsWbMZxIpUNG4i2yviURG5EPEgUZ3Di+baxfV
         graesE9TF5LI2myRRSbJ4t4z9qTdAK3ZZANH4MGlPn+oXVexI2qxgE1sTlJ6Y/wspPeb
         FL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790766379; x=1791371179;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gvJ3gvL9mkHLHEenBRppNmbuci4GAgqEoeCmuENaYyk=;
        b=EouUl0DNKI+OICkTuwyhV1676kq8ZwOjLQRi2dKxRx99BTF4S/CN/gUaE0x1S1YTlQ
         c0dxbyfqTRyfCgqm/EwiYBYNZwvgtr3edN0HNhgE2X9GGBwaD8EqoJwlP4+65oAgKCim
         TdGRpY7XDbyb03YbH318RXC5nQK8fl8UbG0wkgU6YxPXg8XHVsLBErc32qtGzeZjmUmZ
         fl1fChGniHh7nS4MhsyxxRy+74REdME78/sIbqadQ6hYnH4Mj7Ut5LPIJxyWpj3MYtLF
         cVFt9W+JM0CkZuYTu0NUcjJOCGVERdo0ERBulu1d1FF2g2UOB6VrTATnIBebElym1H+z
         TwZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzsYDKzngSXEBOKFQIL5qXgGcACv8lUdp1SEm4XYzNZJs0eg6klDlJdVqCVYmwT0U+vLQQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIeP8Ij0HgTgiLw3zLJfzDKgf1CT3afh2707tHVA2UKu26m/blL
	2TIzARADag7iVcIJQAKUjVwP1bQi+ciNHKVvq3AHRHLowJqZASPHVuLYEb0T+6xrp+N0vVSwsxw
	NJd1GsPXNYcaQW6UoSckIBmAWay9aRlw=
X-Gm-Gg: AYBFou0YYzbBEmyvfPYFiAgWR5HpJvRUnBjeuU7PvH0gaNUO/323YVmdafNhIqHtfD4
	1uASDls+7OEnwAujnmS6TWDxRXEGxQyrGlEpgrwHGaosDG7KPUF7OOgxg5qUh2jvXgw2N6AOz2M
	ILcKwo5iujHvpKqsnMEQkRxrkUs6t6x5fTQhPWU3ifOUd7UBHM2CVA1v+wxRJgt+WFch2dk5cUO
	wrRI213wSFBbKFzsv+a1Gi4/F6TFTL1XhMck+RXmVdAQGAfHsI1Wr4/6URp1UPSNI/XOu0j8yIx
	KydGVlJLqRfMIqEL2cQr2khjUsj8Oycs5TTyE9vHXq6AuEDV+umyG6BFHg2Hocz4S+qPNeQp7tO
	pUO7g9BksOULo7d4cYEjiTWXuN0o3pYCB1XGEfNxVURqVMg==
X-Received: by 2002:a67:f503:0:b0:7bf:8ec:4996 with SMTP id
 ada2fe7eead31-7bf08ec5738mr95010137.20.1790766378863; Wed, 30 Sep 2026
 04:06:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Sep 2026 04:06:10 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Sep 2026 04:06:10 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260930-backfill-dryrun-v1-4-1128f247ee01@gmail.com>
References: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com> <20260930-backfill-dryrun-v1-4-1128f247ee01@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 30 Sep 2026 04:06:10 -0700
X-Gm-Features: AclHuK_uKxGjcy8XWJAEgGrxzFE_ISifXnR55gXnBzxqOETEAmBkKIPdD8Z29gc
Message-ID: <CAOLa=ZR2Ka+5o8HxgZtnO98oH6vo6B_HmjVekYT8hC3HTMq-QQ@mail.gmail.com>
Subject: Re: [PATCH RFC 4/5] backfill: add --dry-run option
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000e37178065cb14925"

--000000000000e37178065cb14925
Content-Type: text/plain; charset="UTF-8"

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> Users have no way to know how many blobs git backfill is going to
> download before running it.
>
> Add a new --dry-run option to the backfill command. The objects are
> walked as usual, but instead of fetching each batch of missing blobs
> they are only counted, and the total is printed at the end.
>
> A subsequent commit will also print their size when the server supports
> the object-info capability.
>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  Documentation/git-backfill.adoc |  6 +++++-
>  builtin/backfill.c              | 37 +++++++++++++++++++++++++++++++++----
>  t/t5620-backfill.sh             | 26 ++++++++++++++++++++++++++
>  3 files changed, 64 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-backfill.adoc b/Documentation/git-backfill.adoc
> index 82d6a1969d..08f19fea17 100644
> --- a/Documentation/git-backfill.adoc
> +++ b/Documentation/git-backfill.adoc
> @@ -9,7 +9,7 @@ git-backfill - Download missing objects in a partial clone
>  SYNOPSIS
>  --------
>  [synopsis]
> -git backfill [--min-batch-size=<n>] [--[no-]sparse] [--[no-]include-edges] [<revision-range>]
> +git backfill [--min-batch-size=<n>] [--[no-]sparse] [--[no-]include-edges] [--dry-run] [<revision-range>]
>
>  DESCRIPTION
>  -----------
> @@ -70,6 +70,10 @@ OPTIONS
>  	--onto TARGET A..B`, where A..B normally excludes A but you need
>  	the blobs from A as well.  `--include-edges` is the default.
>
> +`--dry-run`::
> +	Do not download any objects. Instead, print the number of
> +	missing blobs that would be downloaded.
> +
>  `<revision-range>`::
>  	Backfill only blobs reachable from commits in the specified
>  	revision range.  When no _<revision-range>_ is specified, it
> diff --git a/builtin/backfill.c b/builtin/backfill.c
> index e71e0f4742..6019112966 100644
> --- a/builtin/backfill.c
> +++ b/builtin/backfill.c
> @@ -26,7 +26,7 @@
>  #include "path-walk.h"
>
>  static const char * const builtin_backfill_usage[] = {
> -	N_("git backfill [--min-batch-size=<n>] [--[no-]sparse] [--[no-]include-edges] [<revision-range>]"),
> +	N_("git backfill [--min-batch-size=<n>] [--[no-]sparse] [--[no-]include-edges] [--dry-run] [<revision-range>]"),
>  	NULL
>  };
>
> @@ -36,6 +36,8 @@ struct backfill_context {
>  	size_t min_batch_size;
>  	int sparse;
>  	int include_edges;
> +	int dry_run;

Nit: This could be a bool, since `OPT__DRY_RUN` uses `OPT_BOOL` internally.

> +	size_t total_batch_nr;


>  	struct rev_info revs;
>  };
>
> @@ -58,6 +60,15 @@ static void download_batch(struct backfill_context *ctx)
>  	odb_reprepare(ctx->repo->objects);
>  }
>
> +static void dry_run_batch(struct backfill_context *ctx)
> +{

While it is used during dry_run, probably makes more sense to rename it
to `count_batch()` since that's what it does.

> +	if (!ctx->current_batch.nr)
> +		return;
> +
> +	ctx->total_batch_nr += ctx->current_batch.nr;
> +	oid_array_clear(&ctx->current_batch);
> +}
> +
>  static int fill_missing_blobs(const char *path UNUSED,
>  			      struct oid_array *list,
>  			      enum object_type type,
> @@ -73,8 +84,12 @@ static int fill_missing_blobs(const char *path UNUSED,
>  			oid_array_append(&ctx->current_batch, &list->oid[i]);
>  	}
>
> -	if (ctx->current_batch.nr >= ctx->min_batch_size)
> -		download_batch(ctx);
> +	if (ctx->current_batch.nr >= ctx->min_batch_size) {
> +		if (ctx->dry_run)
> +			dry_run_batch(ctx);
> +		else
> +			download_batch(ctx);
> +	}
>
>  	return 0;
>  }
> @@ -131,10 +146,23 @@ static int do_backfill(struct backfill_context *ctx)
>
>  	ret = walk_objects_by_path(&info);
>
> +	if (ret)
> +		goto end;
> +
>  	/* Download the objects that did not fill a batch. */
> -	if (!ret)
> +	if (!ctx->dry_run) {
>  		download_batch(ctx);
> +		goto end;
> +	}
> +
> +	dry_run_batch(ctx);
> +
> +	printf(Q_("After backfill, %" PRIuMAX " blob would be fetched.\n",
> +		  "After backfill, %" PRIuMAX " blobs would be fetched.\n",
> +		  (unsigned long)ctx->total_batch_nr),
> +	       (uintmax_t)ctx->total_batch_nr);
>

Nit: Okay so we have a goto inside the first if(...), which skips this
section. I would have found it easier to read if it was

if (dry_run)
   count()
else
   download()

> +end:
>  	path_walk_info_clear(&info);
>  	return ret;
>  }
> @@ -157,6 +185,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
>  			 N_("Restrict the missing objects to the current sparse-checkout")),
>  		OPT_BOOL(0, "include-edges", &ctx.include_edges,
>  			 N_("Include blobs from boundary commits in the backfill")),
> +		OPT__DRY_RUN(&ctx.dry_run, N_("Preview the number of blobs to be fetched")),
>  		OPT_END(),
>  	};
>  	struct repo_config_values *cfg = repo_config_values(the_repository);
> diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
> index 7462280470..e76fa6081b 100755
> --- a/t/t5620-backfill.sh
> +++ b/t/t5620-backfill.sh
> @@ -141,6 +141,32 @@ test_expect_success 'do partial clone 2, backfill min batch size' '
>  	test_line_count = 0 revs2
>  '
>
> +test_expect_success '--dry-run reports missing blobs without fetching them' '
> +	test_when_finished "rm -rf backfill-dry-run dry-trace" &&
> +	git clone --no-checkout --filter=blob:none \
> +		--single-branch --branch=main \
> +		"file://$(pwd)/srv.bare" backfill-dry-run &&
> +
> +	GIT_TRACE2_EVENT="$(pwd)/dry-trace" git \
> +		-C backfill-dry-run backfill --dry-run >out &&
> +
> +	test_grep "48 blobs would be fetched" out &&
> +	test_grep ! fetch_count dry-trace &&
> +	git -C backfill-dry-run rev-list --quiet --objects --missing=print HEAD >missing &&
> +	test_line_count = 48 missing
> +'
> +
> +test_expect_success '--dry-run with no missing blobs' '
> +	test_when_finished rm -rf backfill-dry-run &&
> +	git clone --no-checkout --filter=blob:none \
> +		--single-branch --branch=main \
> +		"file://$(pwd)/srv.bare" backfill-dry-run &&
> +	git -C backfill-dry-run backfill &&
> +
> +	git -C backfill-dry-run backfill --dry-run >out &&
> +	test_grep "0 blobs would be fetched" out
> +'
> +
>  test_expect_success 'backfill --sparse without sparse-checkout fails' '
>  	git init not-sparse &&
>  	test_must_fail git -C not-sparse backfill --sparse 2>err &&
>
> --
> 2.54.0

--000000000000e37178065cb14925
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e88585bb78238ac9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xODdTRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNkRyQy8wZXZRR1RjOWR1cSsyNm9EU1pnUXkwaFlBaAoyK1g5RldJNnMx
TFZaaSs0Tm9yei9Kc1h3aDM3bUdJNmg3Y1A3bUN0WVNKV1lLc2o1c2JMdldGQ0F2THBtZlRYCnhR
eStKemhnemV1cVpzUUVtV0hudEwyZ2FpWFdhNTRiZEhaS2VCcGpiNzNmOUF1ejJ6UUV4WkdlQjJM
bjRrYVUKdzdOK3QyemRMUHI0djFxWk9GREpKZzMrMFV0Rmk1NWsrWmFWLzkvR2xkZHozOVNHbE94
UUZvU1pJUzFyKzI2QgpFY2E3Q25kTUdRUEVib0VrTHpyam5DZFRGK1pvOVR6YlpOUXoxQzRvcDIr
UExUbDJQYkRNR1l5TTRjRlVOMG00Ck9hRzdiMzgxR3BXWmdTTGM0NDh5NVlVRkk1U2k0RWJzT3A3
aWp5OUUwKytkV3ZNS0lvbmhHN3pPNFVEOC9jMXUKS3JGVk4zNFh2Z2VkYmNZTHNSbDhOWDZEUlF3
SEZGbXpSQ1p3U3Q0YjRlUU81YXdKSWk3TFBhbEtzMERtcGFYYwpqQWFsNFVmUVBJSHhuU0xtNFZq
dTRTb2x5QWRwU2VyUlhuUTRTWjVqQlRWSHJaTkF3OVRTZkNsdjlrNE5uZlRxCkh4R2xCZXFYUjNh
eTZibW9HczN2OStGeDJ5VGQ4akNLakQwNjV3bz0KPXA2YUIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e37178065cb14925--
