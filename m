Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247BE2DC76A
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781258302; cv=pass; b=bGq1zBQfpZcpavSzqfw0ZktAL5LlemDBbads7vlSaNKGV+kV58O1dy9+Ykl1u5zlZfSGXJ54mPTYDDFUrYptSd63GW5icbi4hAt4Em3QlXi4r7fl7fErvpAQETIip3bcp0eDpcaL8byRgFAd5OjX7FqEjif2lsGshyrHdeXaaK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781258302; c=relaxed/simple;
	bh=AguRNv2nu0SN7RwdzGS4VmtLwP8QLHhPY+/q1Ctpt+g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=LNeLbzYWW84LqBT47tsEtmId6AiHwqK77dClNNhzPOIHv/eKrPxNpV1toWvxNRQoFjMAUfASGo/QjQZIsDklot4qEMvnD0OEPU5WSkfhKCnwictpv5toY88/ny2CUlP6E0WQ0m3/enHisApaiWgox3/D2rL9IzGuypkZ3MPCd3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNtj4qa6; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNtj4qa6"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-6efdb57d98fso158909137.3
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 02:58:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781258300; cv=none;
        d=google.com; s=arc-20240605;
        b=GztEUi5ez7blPg5w2taKeO/gwGmMXv06QXy0XBRtK2KPnC1AIEgYbRr6eovledXaZ0
         HmmVuII62W3oMJ8Kcv9j1ZAYfQNAtIQWVeY3pD1cXFcn1OifIDCZSgHqZWbPik36JYV5
         aOLQklCeX0xtrN7aKFbzX5IJoxjSdgVklaM4iQhDSl8RK/7VKRn3vCaDUJfkJrvQhnAa
         lOaVxIx/fU6rtzD5n84ndVQ/3B7r27c+OHi+2xj4SDMu8w7KR/tQmC4pgDjlFfjdBdpO
         rBeTpkTyOITPj+ehPSgqTEUa5VSqUYHgko4VeDMo3Kej4P7G0YFvCoBTXjgAsJFxzqkw
         W9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=uDLiSNveFmqrWb4MlH7BfJPZq1rPCEtlnB0yM05IihM=;
        fh=kMW/7xbUi8VZNqM7dTqXjuCm7FQjm2K1Ai4kvURfyEs=;
        b=DFGw+Yi9nk2zyt3Xsr8EAr9bH6kCuVUsb8SgPDPUsSn1vIUxYWzWWU/5yLyhQ2eq4b
         QxiUKwSThpE5SiYFy2sSSXxa7I/BQl8Rf8u4xyC1nSDdoslXCkXi/sRcZfTNK9VaOJFc
         coNGj4LOXqPH35QeGgm0KZ+m5OBnoThrXflEj2/9itiq7icil5Obb57EqLbhXwStZTZQ
         JoGA4zKYplZ+ty/AxUxpYeOs+bTz/YnkgsoDezAFJvCuTs05mgL5EgZ9X5znDse773fM
         oFOH6LdKqH8G2ks1GcJsdoCrCU+YHLc7v3mg/ZwNg0xXhM3RL73VSHskwWkuFCoQnMDC
         Xl8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781258300; x=1781863100; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uDLiSNveFmqrWb4MlH7BfJPZq1rPCEtlnB0yM05IihM=;
        b=hNtj4qa6Eph/ep+IDTaPkDztDiIdYPcPhTpxDvZg1PM0baEGd6EKVtQXG+exrvF8GP
         XnJfpyo09XkvlWf8Djhs7mo6MbPRwygBuXyQgObJfzY9Bnp0D07db5v6ASdPGhvYv+Iz
         PFMz8/C4oPm1MPfFSBIpzqBL/isBMCwofUTuCA+54azGZ9VDWjg2V5pOM292QBublaMb
         58nyOjAOTHYCTJ4Ey2YIndHRrok+wlhw7rIYoDPZcsyzsjMxKuRR5fzEbe3XwBCQISjh
         XCSVnVEm9SK6nS2MClDtCBoxi9SXDcHTYwu8UoD4slolEoULKRLW+3FVgLKLSxANToym
         K1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781258300; x=1781863100;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDLiSNveFmqrWb4MlH7BfJPZq1rPCEtlnB0yM05IihM=;
        b=jLP27tbd/4p+86lRA02ZFMANkbnHG4MKK+f2sdXFHmBzUiQfHmDoJOph17xVCryaBP
         jYuD4Fj+/YI4VKwU7nDJXQOVDTtpsBl7xbsPgfaKGl2Alpw51OL7W99C1b/005hXIah2
         HCP+QQ4Q+mxbK/8NtK3nTI0hWJQa5oPXFBXiGFWYzQJpJz8HrZ6uMdb0FyGlmQ2nJVEZ
         zYJbitfZEBJVXAiagJ/oD8x95afQzzAsSy2QID3/r0tuHlsPxL68I7jnNXJAksbUBzkg
         GGoDcbiMUNQkdZhmwqq9nFF98btQ9DmYi///rWuhTmRb6LoaYZE5ZImlL/bEL+EdWriw
         t2oQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Ca9imTQia4qm8toL0YLSe0btxXqMTOJnMsOj+E/NaNnGxHMlW8XjnrSqNsOG8K7k0Pr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXAmVk1VaQ6ltDrSW3KGiZBKxJKuOBMD7dSQtldDmTtrJry9Hs
	imi4pwekhsQqZb+FneCKpD8SImS4Z2mKqboKSnndraINYbkJtiTQaeFh+k66HlR+oK7yN6wKZr3
	n+C6EK6ufDQFtcOOgSOzrDzifuyPYH2A=
X-Gm-Gg: Acq92OHB10UczW6Am/J8W4fJN+5J1tAkbyBKJwPxahRgvfylG1vdWUFgJlyyZJfeCLI
	LFwIXXKVT7fnpZbx2Un6nNn4Od1n/zwcKNUWy5li01jTlXVX1gDMmaO21jhXns0LMa9W9S3DB8a
	saEIoBKXmon2TZxGgWZw2jio4V2ifzR5mccWZrnZMrWe8eeZy+g2FxR7aROeMVUhXxtR/uh00Q9
	L7jS2egbBpHx2NN52/tSKZsFiyP3TG/Hn+xB3gZXVlYcBj44XvU3KnzMRlSv1Wm3qAJoXNUo4r+
	cts/GI2S83AGd3L1TFrVE41HKxhcDzSGc/D/V9D3GoQATGpr/5dMxbEBdmLbD2KGy1oPAqno
X-Received: by 2002:a05:6102:3e8d:b0:631:28c1:154c with SMTP id
 ada2fe7eead31-71e88b0a5b2mr677287137.9.1781258299821; Fri, 12 Jun 2026
 02:58:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 12 Jun 2026 02:58:19 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 12 Jun 2026 02:58:19 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-9-56c864b01c43@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
 <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-9-56c864b01c43@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 12 Jun 2026 02:58:19 -0700
X-Gm-Features: AVVi8CcNlHXpSL0uyCnQOttMWO1t0422mC05uKMshhXzgfmSspSOpM8mej-8umw
Message-ID: <CAOLa=ZR60bhH4z9ZoKTCn97QzautcihxPbTZ=_e0raMTjzajZQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] refs: always use absolute paths for reference stores
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000036febe06540b84be"

--00000000000036febe06540b84be
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Both the "files" and "reftable" backends use
> `refs_compute_filesystem_location()` to figure out the location of both
> the git and common directories. Depending on how the function is called
> we may or may not return an absolute path.
>
> There isn't really a good reason to use relative paths though. Quite on
> the contrary, because we sometimes use relative paths we are forced to
> register for chdir(3p) notifications via `chdir_notify_reparent()`.
>

With the previous changes added, we register via
`chdir_notify_register()`

> Adapt the function to always return absolute paths. This results in a
> user-visible change in behaviour where we now unconditionally print
> absolute paths in error messages. But arguably, that change in behaviour
> is acceptable and may even be good in cases where a Git command may end
> up accessing references across multiple different repositories.
>
> Furthermore, drop the calls to `chdir_notify_reparent()`, which aren't
> required anymore now that the paths are always absolute.
>

Same here, should be `chdir_notify_register()`

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c                      | 11 ++++++++---
>  refs/files-backend.c        | 22 ----------------------
>  refs/packed-backend.c       | 18 +-----------------
>  refs/reftable-backend.c     | 17 -----------------
>  t/pack-refs-tests.sh        |  6 +++---
>  t/t0600-reffiles-backend.sh |  4 ++--
>  t/t1423-ref-backend.sh      |  9 ++++++---
>  t/t5510-fetch.sh            |  2 +-
>  8 files changed, 21 insertions(+), 68 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 4912510590..8679677bf7 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3579,15 +3579,16 @@ void refs_compute_filesystem_location(const char *gitdir, const char *payload,
>  		 * worktree path, as the 'gitdir' here is already the worktree
>  		 * path and is different from 'commondir' denoted by 'ref_common_dir'.
>  		 */
> +		strbuf_reset(refdir);
>  		strbuf_addstr(refdir, gitdir);
> -		return;
> +		goto out;
>  	}
>
>  	if (!is_absolute_path(payload)) {
>  		strbuf_addf(ref_common_dir, "/%s", payload);
> -		strbuf_realpath(ref_common_dir, ref_common_dir->buf, 1);
>  	} else {
> -		strbuf_realpath(ref_common_dir, payload, 1);
> +		strbuf_reset(ref_common_dir);
> +		strbuf_addstr(ref_common_dir, payload);
>  	}
>
>  	strbuf_addbuf(refdir, ref_common_dir);
> @@ -3598,4 +3599,8 @@ void refs_compute_filesystem_location(const char *gitdir, const char *payload,
>  			BUG("worktree path does not contain slash");
>  		strbuf_addf(refdir, "/worktrees/%s", wt_id + 1);
>  	}
> +
> +out:
> +	strbuf_realpath(ref_common_dir, ref_common_dir->buf, 1);
> +	strbuf_realpath(refdir, refdir->buf, 1);
>  }
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 296981584b..762f392e67 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -21,7 +21,6 @@
>  #include "../lockfile.h"
>  #include "../path.h"
>  #include "../dir.h"
> -#include "../chdir-notify.h"
>  #include "../setup.h"
>  #include "../worktree.h"
>  #include "../wrapper.h"
> @@ -100,23 +99,6 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
>  	}
>  }
>
> -static void files_ref_store_reparent(const char *name UNUSED,
> -				     const char *old_cwd,
> -				     const char *new_cwd,
> -				     void *payload)
> -{
> -	struct files_ref_store *refs = payload;
> -	char *tmp;
> -
> -	tmp = reparent_relative_path(old_cwd, new_cwd, refs->base.gitdir);
> -	free(refs->base.gitdir);
> -	refs->base.gitdir = tmp;
> -
> -	tmp = reparent_relative_path(old_cwd, new_cwd, refs->gitcommondir);
> -	free(refs->gitcommondir);
> -	refs->gitcommondir = tmp;
> -}
> -
>  /*
>   * Create a new submodule ref cache and add it to the internal
>   * set of caches.
> @@ -145,10 +127,7 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
>
>  	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);
>
> -	chdir_notify_register(NULL, files_ref_store_reparent, refs);
> -
>  	strbuf_release(&refdir);
> -
>  	return ref_store;
>  }
>
> @@ -197,7 +176,6 @@ static void files_ref_store_release(struct ref_store *ref_store)
>  	free(refs->gitcommondir);
>  	ref_store_release(refs->packed_ref_store);
>  	free(refs->packed_ref_store);
> -	chdir_notify_unregister(NULL, files_ref_store_reparent, refs);
>  }
>
>  static void files_reflog_path(struct files_ref_store *refs,
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 499cb55dfa..89e41a35a3 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -13,7 +13,6 @@
>  #include "packed-backend.h"
>  #include "../iterator.h"
>  #include "../lockfile.h"
> -#include "../chdir-notify.h"
>  #include "../statinfo.h"
>  #include "../worktree.h"
>  #include "../wrapper.h"
> @@ -211,19 +210,6 @@ static size_t snapshot_hexsz(const struct snapshot *snapshot)
>  	return snapshot->refs->base.repo->hash_algo->hexsz;
>  }
>
> -static void packed_ref_store_reparent(const char *name UNUSED,
> -				      const char *old_cwd,
> -				      const char *new_cwd,
> -				      void *payload)
> -{
> -	struct packed_ref_store *refs = payload;
> -	char *tmp;
> -
> -	tmp = reparent_relative_path(old_cwd, new_cwd, refs->path);
> -	free(refs->path);
> -	refs->path = tmp;
> -}
> -
>  /*
>   * Since packed-refs is only stored in the common dir, don't parse the
>   * payload and rely on the files-backend to set 'gitdir' correctly.
> @@ -239,10 +225,9 @@ struct ref_store *packed_ref_store_init(struct repository *repo,
>
>  	base_ref_store_init(ref_store, repo, gitdir, &refs_be_packed);
>  	refs->store_flags = opts->access_flags;
> -
>  	strbuf_addf(&sb, "%s/packed-refs", gitdir);
>  	refs->path = strbuf_detach(&sb, NULL);
> -	chdir_notify_register(NULL, packed_ref_store_reparent, refs);
> +
>  	return ref_store;
>  }
>
> @@ -287,7 +272,6 @@ static void packed_ref_store_release(struct ref_store *ref_store)
>  	clear_snapshot(refs);
>  	rollback_lock_file(&refs->lock);
>  	delete_tempfile(&refs->tempfile);
> -	chdir_notify_unregister(NULL, packed_ref_store_reparent, refs);
>  	free(refs->path);
>  }
>
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 8c93070677..8cc1dbbbdd 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -2,7 +2,6 @@
>
>  #include "../git-compat-util.h"
>  #include "../abspath.h"
> -#include "../chdir-notify.h"
>  #include "../config.h"
>  #include "../dir.h"
>  #include "../environment.h"
> @@ -365,19 +364,6 @@ static int reftable_be_config(const char *var, const char *value,
>  	return 0;
>  }
>
> -static void reftable_be_reparent(const char *name UNUSED,
> -				 const char *old_cwd,
> -				 const char *new_cwd,
> -				 void *payload)
> -{
> -	struct reftable_ref_store *refs = payload;
> -	char *tmp;
> -
> -	tmp = reparent_relative_path(old_cwd, new_cwd, refs->base.gitdir);
> -	free(refs->base.gitdir);
> -	refs->base.gitdir = tmp;
> -}
> -
>  static struct ref_store *reftable_be_init(struct repository *repo,
>  					  const char *payload,
>  					  const char *gitdir,
> @@ -460,8 +446,6 @@ static struct ref_store *reftable_be_init(struct repository *repo,
>  			goto done;
>  	}
>
> -	chdir_notify_register(NULL, reftable_be_reparent, refs);
> -
>  done:
>  	assert(refs->err != REFTABLE_API_ERROR);
>  	strbuf_release(&ref_common_dir);
> @@ -487,7 +471,6 @@ static void reftable_be_release(struct ref_store *ref_store)
>  		free(be);
>  	}
>  	strmap_clear(&refs->worktree_backends, 0);
> -	chdir_notify_unregister(NULL, reftable_be_reparent, refs);
>  }
>
>  static int reftable_be_create_on_disk(struct ref_store *ref_store,
>

The changes look good to me.

[snip]

--00000000000036febe06540b84be
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5af87062a9f3a20e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vcjJEZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOG54Qy85dk5aSnRCZFg5UFB3NEMzeFdTSHEzak9ncgpDSDBqUURrOWlX
cU9EcDdGMys4ZkV2YzFmM3Z1NDlQWWt2QXhiMTFGNmF2MVhtcVRTazMvTTQ1SWZubEJqUkJHCkxG
ZFNRTlJrMW4wSFdPWXF2M0I4Q0pmRjdmQmhrVlRKRCtKZ1J4T2NRdEN2a0xjTHVPaFY5ZnY0TUln
NHUrdysKUUJZejVuS1BNSUlXRnY5YzBURktJYVcyWkZaWlRTdEFQUDc5bm1DUDB3dzNoKzBVdnlP
WFhUM0RtdTJITm9TTgpZUHBwby9kT1JYdXpOMFUvMUEydkNEK05XUmtZdk9rMWlyOGJNeTlaT2xH
anBtdzJVVzlsanFLMkNSb2xJaGJrCkFoVTBONkVHVXRUdllUck9OV0lqM09Ea0crb3dJb3RPbVc5
UThBRlVlL0pwS25MREFXUzJwbHZzenRncUdjYlAKcXhsZzZZZVh5TVN5R2ErbVJkbkJkNGZhWXRU
bXp0a2N0OXRlZUJJMzErRmU1eE9TT2dzcjkvS0pHNDBsS1M4RgoxZTIvYXMvSWpmRU02RzhGWTlF
cXVsREtqWWVYSFpCWFNLeERwWU5NR0N4OUlrUUpkbnV0b1ladk5XTTZnU080CmloTlZJZkRUZmJQ
ZGhZMzA0alFMVHN3ZmNRVUN1Rkh4VGJOMExxMD0KPWdQdzcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000036febe06540b84be--
