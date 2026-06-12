Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC537F006
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255911; cv=pass; b=Fp2ZJtAZy3GTdPEp4gaiLsWSAhlYtLZj1aXStHnLfJnKACMTPBNMbVJWrlY3U4tlx7OpROobFg0yStA+SVCZCptYCgwvoehUEtsM51/XEuUcTVAiMh7yv09mgjzXCNNFnbP5MltYMUL6So48EU/PRVYJAnNQqX9+Jsr9qcHHD1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255911; c=relaxed/simple;
	bh=+bq+vcpCNf8aBi8N10i9BVMKiebSYAE5nDdOss7FbmY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=FKxUam06qZETzda9p/phfRaaSmKyEXjo3Uf+aKAATZccDMhVHmiqT7OQFuaDS5yuXXK49F2Sjhy0OlF++V5vHwkEVJVxATt02HSRLkM5wmRhzZH7GDZ/ItUh9su1UiKvw/3fCY0EgpkwHzx0ExoiAxuqjR5EmVt9mi9q0P4dy7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wco97eSY; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wco97eSY"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-6cfdcc79789so250159137.3
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 02:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781255909; cv=none;
        d=google.com; s=arc-20240605;
        b=l3PCAxYzWRIWltjQYsQKiyJ2EK51LIzW38o9OiFzJZ/lpfEgQHek/KHFMywVWif4+0
         F3Q86Y1obVtGq6z18Es0aPKfWPZlq1V8TkK0tpbX85HW2Kkun9UTb6+NKGRiDNrkCyXU
         bKPxAwhrPt8SCYaV6PwdP4af50+gRQp49XTzChzztdqbUGSCEsSHqALOmC2pJqFqz/+V
         1MyZQZz+Nsxq5bjlH8xiIJvrR3rR3pVT97NspY2+5AufOG3/aqSU74VwNNlljVZjLvA6
         Hs7HL3BkOEuaQOjR3bxNiTbIKj2xFP7fDIhW3TNTuo32pqW6eH5piuEXujVo1CLu6iyK
         yq/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=a9WqXhdpgHQIktpJqlai1i02CgGWtC4Vewxmlkkdlb8=;
        fh=MDNbH2iqZQCsTRQazQUFmc8ZYWuUztrEncePooUD0/E=;
        b=Fpp0YE6iuxdNcuU55jEN1JIlM6Vr2KR0Y4qr3KtKUpVOysZPFdudBIqxFiWDOYfZBM
         mimGZsKl1bY3pgb3pizKdh6yq6Ulbe7hejlJIMbtKWqzcCdVcsc1DsZtpAihG7gHVDZK
         NBi1V1dZwMf/8llODGl8SGYDFykNFwRqRhv9XEKQiIwr80nnlKW0k81mUaTxEgkPE3pH
         veJRUBS6/3fWP1VlUSTVhyPimkvz74gDB/tSq7CxySq+xO82E+MGeYez5elm2FKbRClq
         z/GbsYSvSH24YdX/g6EnnRnz9KuAeFh8j6+X3PXaCTZqaRKz3CGffNYDDW9knPCBGtAX
         R/KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781255909; x=1781860709; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a9WqXhdpgHQIktpJqlai1i02CgGWtC4Vewxmlkkdlb8=;
        b=Wco97eSYlxgG6RBdG5BHiomxUnEMklc6Gz2sHiY/pMkyuhRvEu1R5Zmel1tS3bw2mL
         QOQv+Z5jKxDpJS8PVMLCDDvOusFHnwd4zZvYbrs7BrzdPr5OKn+pQeDh7b5VyiXxR2z0
         q/5hw2hnyFOlaSsgYCLd3MLDKoImkau1S/9RM442FPwtf1T6S9AlUPrE0VbzGhTSiWfH
         af4GkVwcRLlNxdIkzrDY/5U2XS3tFJ6hokB8mu+clfqra781dGvyf/yhbgwxdFwcrtUL
         RlFQr0xYaeNPI1BDJswV8oG8TGXfU7656r86c7dk0/ENoMVUy64+M+b9di1YlC5dneUD
         PEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781255909; x=1781860709;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9WqXhdpgHQIktpJqlai1i02CgGWtC4Vewxmlkkdlb8=;
        b=S56uqRHyAFM2THX1nwGR7cag3MXEXgT/p/dZ3YhqFF7XY4ziIXlLObKev7Hp551Auv
         /ifi8qgVpm8xiwNaW2OvyYvWD9A1Fmtp9bj95pgCkt9KgIBKubIxIY8mfS8HjzqAukUd
         WvOPNEQFX0uPQuUbi5Hf6dhnte8h46sis1W3LT9E3LNk7avq4bjBm/WXfyJuhgp6EEfv
         NtKj1UNmWPDNFy/H9O5OjVTzuGEQa0uwE2Wf0edMoiY8tlafvKDn5U3SKubhqQLsj+6Z
         YZYLGMfMO45aeFYJFUc50WPjUekQ2y+fCf7iWpa6k1K+sHYGNHJecAjRE4EphJ0gsgds
         wA1g==
X-Forwarded-Encrypted: i=1; AFNElJ+OZzoDMqJYPMDpQnRmIT++y/4aSX042HXzDmovaqMByimUv+mFe3naSwdE6+vS0mB1reE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwssV8yaSGHmhoJH6PrewfMc5oOu+m/U85S7bk0AvgjvAp8gkz6
	05xOywDPJ+ZRioIhM40q3ymZ0l/t8MAABmVYHFSIqpDR1Hu6SRbVPInoFARhwOJTyaTdUGg83Qu
	MEmgwnN0AH9BPRFXku/+ysdz2aqVDTb6z+w==
X-Gm-Gg: Acq92OEU23MG+HrWoBQS4Nan6Kl0qq10Ybg+IuGxX9TGrj+xJ6QKh2ZJ7/GhVd1vDRD
	uVx0oO4KM4Itwqs0LtFcMXsHRggr3M/WiUnOObCRgHBLg8NyRbY7qbk3chwv7cd4b/O5u+iQHrg
	Z8botyPeFUYarkgRQobsAzoJsNqxT1NHDCxpIg8PAhEj2ttMYGRySA5ev1pzBcZbwSiFKclNyIC
	qiXHzD8O/ZbUQr3XSBl2Xmv08zSSqCin70YcnB5nlemMK1rpsPgcBG31zie08K41sTO6goz3pDf
	YlmXTSct9joJcCiVVzvuZTJtTGJgRq62LScZMilhu5Ytal/4NUiMeVkNhBEAQ2pyEAg2ETS5Gw=
	=
X-Received: by 2002:a05:6102:580c:b0:6c5:d55d:c090 with SMTP id
 ada2fe7eead31-71e88ac3b35mr653221137.3.1781255909299; Fri, 12 Jun 2026
 02:18:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 12 Jun 2026 02:18:28 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 12 Jun 2026 02:18:28 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-4-56c864b01c43@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
 <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-4-56c864b01c43@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 12 Jun 2026 02:18:28 -0700
X-Gm-Features: AVVi8Cev9GLRo0tumSSCX1mr6gW1u78nc-EcYryIEmAf2pCVqL5gQ47xypLwzXQ
Message-ID: <CAOLa=ZS_0b9o2YucgA6Se_Mq4nLo1Luow7adTLAifbkF9jpUrA@mail.gmail.com>
Subject: Re: [PATCH 4/9] refs: unregister reference stores from "chdir_notify"
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ba712c06540af570"

--000000000000ba712c06540af570
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When creating reference stores we register them with the "chdir_notify"
> subsystem. This is required because some of the paths we track may be
> relative paths, so we have to reparent them in case the current working
> directory changes.
>
> But while we register the reference stores, we never unregister them.
> This can have multiple outcomes:
>
>   - For a repository's main reference database we essentially keep the
>     pointer alive. We never free that database, either, and our leak
>     checker doesn't notice because it's still registered.
>
>   - For submodule and worktree reference databases we do eventually free
>     them in `repo_clear()`, so we may keep pointers to free'd memory
>     registered. We never notice though as we don't tend to chdir around
>     in the middle of the process.
>

So `ref_store_release()` is what is called to release a ref_store. So
in the former's case, we never release the ref_store even if the
repository is closed, wow.

> We never noticed either of these symptoms, but they are obviously bad.
>
> Partially fix those issues by unregistering the reference stores when
> releasing them. The leak of the main reference database will be fixed in
> a subsequent commit.
>
> Note that this requires us to use `chdir_notify_register()` instead of
> `chdir_notify_parent()`, as there is no infrastructure to unregister the

Shouldn't this be s/chdir_notify_parent/chdir_notify_reparent ?

> latter. It ultimately doesn't matter much though: in a subsequent commit
> we'll drop this infrastructure completely. We merely require this step
> here so that we can fix the memory leaks ahead of time.

Right, we can't unregister when using `chdir_notify_reparent()` because
it internally calls `chdir_notify_register()` with a private cb
function, and we need to supply the callback function during
un-registering. Makes sense.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/files-backend.c    | 22 +++++++++++++++++++---
>  refs/packed-backend.c   | 16 +++++++++++++++-
>  refs/reftable-backend.c | 16 +++++++++++++++-
>  3 files changed, 49 insertions(+), 5 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index a4c7858787..296981584b 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -100,6 +100,23 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
>  	}
>  }
>
> +static void files_ref_store_reparent(const char *name UNUSED,
> +				     const char *old_cwd,
> +				     const char *new_cwd,
> +				     void *payload)
> +{
> +	struct files_ref_store *refs = payload;
> +	char *tmp;
> +
> +	tmp = reparent_relative_path(old_cwd, new_cwd, refs->base.gitdir);
> +	free(refs->base.gitdir);
> +	refs->base.gitdir = tmp;
> +
> +	tmp = reparent_relative_path(old_cwd, new_cwd, refs->gitcommondir);
> +	free(refs->gitcommondir);
> +	refs->gitcommondir = tmp;
> +}
> +

Looks similar to `void reparent_cb()` but for both the directories.

>  /*
>   * Create a new submodule ref cache and add it to the internal
>   * set of caches.
> @@ -128,9 +145,7 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
>
>  	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);
>
> -	chdir_notify_reparent("files-backend $GIT_DIR", &refs->base.gitdir);
> -	chdir_notify_reparent("files-backend $GIT_COMMONDIR",
> -			      &refs->gitcommondir);
> +	chdir_notify_register(NULL, files_ref_store_reparent, refs);
>
>  	strbuf_release(&refdir);
>
> @@ -182,6 +197,7 @@ static void files_ref_store_release(struct ref_store *ref_store)
>  	free(refs->gitcommondir);
>  	ref_store_release(refs->packed_ref_store);
>  	free(refs->packed_ref_store);
> +	chdir_notify_unregister(NULL, files_ref_store_reparent, refs);
>  }
>
>  static void files_reflog_path(struct files_ref_store *refs,
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 0acde48c45..499cb55dfa 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -211,6 +211,19 @@ static size_t snapshot_hexsz(const struct snapshot *snapshot)
>  	return snapshot->refs->base.repo->hash_algo->hexsz;
>  }
>
> +static void packed_ref_store_reparent(const char *name UNUSED,
> +				      const char *old_cwd,
> +				      const char *new_cwd,
> +				      void *payload)
> +{
> +	struct packed_ref_store *refs = payload;
> +	char *tmp;
> +
> +	tmp = reparent_relative_path(old_cwd, new_cwd, refs->path);
> +	free(refs->path);
> +	refs->path = tmp;
> +}
> +
>  /*
>   * Since packed-refs is only stored in the common dir, don't parse the
>   * payload and rely on the files-backend to set 'gitdir' correctly.
> @@ -229,7 +242,7 @@ struct ref_store *packed_ref_store_init(struct repository *repo,
>
>  	strbuf_addf(&sb, "%s/packed-refs", gitdir);
>  	refs->path = strbuf_detach(&sb, NULL);
> -	chdir_notify_reparent("packed-refs", &refs->path);
> +	chdir_notify_register(NULL, packed_ref_store_reparent, refs);
>  	return ref_store;
>  }
>
> @@ -274,6 +287,7 @@ static void packed_ref_store_release(struct ref_store *ref_store)
>  	clear_snapshot(refs);
>  	rollback_lock_file(&refs->lock);
>  	delete_tempfile(&refs->tempfile);
> +	chdir_notify_unregister(NULL, packed_ref_store_reparent, refs);
>  	free(refs->path);
>  }
>
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 4ae22922de..8c93070677 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -365,6 +365,19 @@ static int reftable_be_config(const char *var, const char *value,
>  	return 0;
>  }
>
> +static void reftable_be_reparent(const char *name UNUSED,
> +				 const char *old_cwd,
> +				 const char *new_cwd,
> +				 void *payload)
> +{
> +	struct reftable_ref_store *refs = payload;
> +	char *tmp;
> +
> +	tmp = reparent_relative_path(old_cwd, new_cwd, refs->base.gitdir);
> +	free(refs->base.gitdir);
> +	refs->base.gitdir = tmp;
> +}
> +
>  static struct ref_store *reftable_be_init(struct repository *repo,
>  					  const char *payload,
>  					  const char *gitdir,
> @@ -447,7 +460,7 @@ static struct ref_store *reftable_be_init(struct repository *repo,
>  			goto done;
>  	}
>
> -	chdir_notify_reparent("reftables-backend $GIT_DIR", &refs->base.gitdir);
> +	chdir_notify_register(NULL, reftable_be_reparent, refs);
>
>  done:
>  	assert(refs->err != REFTABLE_API_ERROR);
> @@ -474,6 +487,7 @@ static void reftable_be_release(struct ref_store *ref_store)
>  		free(be);
>  	}
>  	strmap_clear(&refs->worktree_backends, 0);
> +	chdir_notify_unregister(NULL, reftable_be_reparent, refs);
>  }
>
>  static int reftable_be_create_on_disk(struct ref_store *ref_store,
>
> --
> 2.54.0.1189.g8c84645362.dirty

The changes here look good.

--000000000000ba712c06540af570
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c9eca0d7f73e8245_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEpCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vcnp1TVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOWNoQy9qZVdDY2lTRjYvNnhKa3JEM1dyZm1IWEJUQwpSeW4vZUZINTNv
b0NyWVlkdnNUbmloM3dNSHRFOXJoTUVMZnBMeGppckJyOEQzUTJVc05ITmo1S1ZtSldacUJQCkE3
WFJ2RXVpL2lKcVlUZjJiazZMREFhRnc5THR6T0JlSllTbjM1ajBPVVBsN044QjJYNnNyeDJEbHd0
NTRVbTMKVW9BRElnTWVCNjJ2dWVVd3dQUWVVQ0ZnWWFnZkFDbkdFeW5SWmJiMlE4SUpJRGtGUVAz
b3BNcGsycG5PUk9ycQpxYkJOZG9iRHdVUS9WNy9lU2RFanFDNVBYbnU0LzdoSWlOZGVQL1FyUkZH
bFE3VTI0Z0lIb3pJQWJYRktxeUt3Ck5lblpYMEpINGZqZmlad0lJYlJRbTB4OUNodEczVXNZM3c3
bmhQQlJZZjBTamo2TzV4UkRqYzlvdmJ1cDJGZXUKRU9ld0Ruai9IWlhsbEQyejRwZVlwaTJFTUo1
dE9Ycmx1bVUvTjZYZERVMlZLb0lHdXMwVk9OR25vcGtnM0g5QQpDYi85RWtlMG14WWZudE9mU29X
N2JLZXdkTFFKM3NkUkNhUGNaR2VyT1E1MHBmT0RHcVVNaVZGUnJkNWFHTi9YCkl0L1Q5OTAxZk5k
TjRGeXRaai80UkErOTNwM0FPQmthSS9USWZnPT0KPUpERlYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ba712c06540af570--
