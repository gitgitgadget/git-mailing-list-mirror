Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705869;
	b=onM+y+IUhYRYtXuMJHfqke1PS1oindaTvZzPZlv30ZFSFewHWp0/WWHpU2LrPe5e3463
	 WOdHpxlAX1s42C1njFEwV2SJtbWMgahrY3Xcrs+0Yj1cfqHzqF3ki5rcSk5QF9mAw1A1K
	 TWJ3Vrdl5Fe9oV89w9gfdkJHdFXJEPutYeDjgtKlCLDa9mThEDSNBHunMC132oh1RzlQh
	 QaXQhArhH5NdL8N4c7Mw3VWsE34AeRqdAiemeg0aSlMK1KAEek2/KUxK3wOD8YZOqMLI5
	 LpwNwBZ+e6UChcPGYbQVdgwJSU5SBAUL+tUFIr4O6YlcWeEksbfPZMfyJKUDpKD3g/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705869;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=u+47wqnW/+GCzfXP/PleYmJJIe6pU/DGBPXkD3lT2/c=;
	b=Xg9FaRwETCwKLy68Er2lucPbtXkJOvgSqYvdNN6PPO3JCETf4rUrpF30b3ff3OqIpuVL
	 CAPH3iPJT+pW0DuHDGvZ+Hf9778CbLypjjCYdEFMGwgxA3F+P9nqG1qDpytpw0KFp3Wlv
	 wsFCwu7YZEKTp9rZOU5wodRwkFQ/XiI0qyYZ9sFm2u9qX7HwaOAcSzGPnTUoq7XCn2FMC
	 lgzFMchBru9qSxJ1SgN8mUTcoZPEMLPG1VEGY7KkeTfaDDHmam31gAMtKJn2NWHj4zssE
	 YEg13U6hPnYQzkT0KqBRMKriP7t5sYPuGM5xKTzz9pnXKW7gNZT0AwQ5CCPapQBovZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=DK7571L2;
	arc=none smtp.remote-ip=91.218.175.23
Received: from mta0.migadu.com (out-23.mta0.migadu.com [91.218.175.23])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF17606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 15:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DF17606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=DK7571L2
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EBBSUvW9R/WLVIRk5hUzM0BGf9SmmFaQDWhR51L6bgM=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795705866; v=1; x=1796310666;
 b=DK7571L2V0MBc1DbcOIvncuHWlutgOw2fBBjDz5TtVae9T3cXrb86FxcdVmo4mNOdB+yrZsn
 6/bzhvT2EcxiEpA4QvPgNGdee4xom7lrCY0z3EWcNrLznraMnZlnxiZpmZ5mZgpb9vCwZr8wdNZ
 4ubh5JovcYXtiXCnSuEZ6KEw=
X-Envelope-To: git@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id fb53149992ad3d0e;
	Thu, 26 Nov 2026 15:11:06 +0000
X-Mizu-Trace-ID: fb53149992ad3d0e
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 5/6] packfile: maintain process-wide limits globally
In-Reply-To: <20261120-pks-packfile-global-statistics-v1-5-19beb83b145f@pks.im>
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
 <20261120-pks-packfile-global-statistics-v1-5-19beb83b145f@pks.im>
Date: Thu, 26 Nov 2026 16:11:02 +0100
Message-ID: <877bhzsk55.fsf@dev.null.iotcl.com.invalid>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Our packfile subsystem has two limits that are supposed to apply
> globally across all open packfiles:
>
>   - `pack_max_fds` is the maximum number of open file descriptors for
>     packfiles. When we exceed that limit, we close least-recently-used
>     packs until we're below it again.
>
>   - "core.packedGitLimit" is the maximum number of packfile data that
>     may be mapped into memory. When we exceed that limit, we close the
>     least-recently-used windows into our packfiles.
>
> Those limits are supposed to be process-wide, so even across multiple
> repositories. But our current implementation will only consider
> packfiles from a given repository or object database, which may not even
> have any packfiles open when the logic kicks in. Furthermore, the logic
> assumes that we're using the "files" backend and thus unconditionally
> downcasts the object database's backend to it.
>
> Introduce a global list of all packfiles. This list is completely
> independent of the owning repository or object database, and it is
> agnostic of the actual object database backend that's in use. Use it to
> maintain the above two limits.

Isn't it a list of "all **open** packfiles"? I find the variable name
`all_packfiles` a bit confusing.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  packfile.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
>
> diff --git a/packfile.c b/packfile.c
> index 077b0395a79..0d5647c74c8 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -35,6 +35,7 @@ char *odb_pack_name(struct repository *r, struct strbuf *buf,
>  	return buf->buf;
>  }
>  
> +static struct packfile_list all_packfiles;
>  static unsigned int pack_used_ctr;
>  static unsigned int pack_open_fds;
>  static unsigned int pack_max_fds;
> @@ -195,6 +196,7 @@ static struct packed_git *packfile_new(struct repository *r, int extra)
>  	memset(p, 0, sizeof(*p));
>  	p->pack_fd = -1;
>  	p->repo = r;
> +	packfile_list_append(&all_packfiles, p, 1);
>  	return p;
>  }
>  
> @@ -243,17 +245,14 @@ static void scan_windows(struct packed_git *p,
>  	}
>  }
>  
> -static int unuse_one_window(struct object_database *odb)
> +static int unuse_one_window(void)

I agree with Junio this signature is better, but now it requires people
to look at the code to understand it unuses the least-recent-used
window. Would it make sense to rename these to `unuse_one_lru_window()`,
and `close_one_lru_pack()`?

>  {
> -	struct odb_source_files *files = odb_source_files_downcast(odb->source);
>  	struct packfile_list_entry *e;
>  	struct packed_git *lru_p = NULL;
>  	struct pack_window *lru_w = NULL, *lru_l = NULL;
>  
> -	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
> -		for (e = dir->packed->packs.head; e; e = e->next)
> -			scan_windows(e->pack, &lru_p, &lru_w, &lru_l);
> -	}
> +	for (e = all_packfiles.head; e; e = e->next)
> +		scan_windows(e->pack, &lru_p, &lru_w, &lru_l);
>  
>  	if (lru_p) {
>  		munmap(lru_w->base, lru_w->len);
> @@ -407,20 +406,17 @@ static void find_lru_pack(struct packed_git *p, struct packed_git **lru_p, struc
>  	*accept_windows_inuse = has_windows_inuse;
>  }
>  
> -static int close_one_pack(struct repository *r)
> +static int close_one_pack(void)
>  {
> -	struct odb_source_files *files = odb_source_files_downcast(r->objects->source);
>  	struct packfile_list_entry *e;
>  	struct packed_git *lru_p = NULL;
>  	struct pack_window *mru_w = NULL;
>  	int accept_windows_inuse = 1;
>  
> -	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
> -		for (e = dir->packed->packs.head; e; e = e->next) {
> -			if (e->pack->pack_fd == -1)
> -				continue;
> -			find_lru_pack(e->pack, &lru_p, &mru_w, &accept_windows_inuse);
> -		}
> +	for (e = all_packfiles.head; e; e = e->next) {
> +		if (e->pack->pack_fd == -1)
> +			continue;
> +		find_lru_pack(e->pack, &lru_p, &mru_w, &accept_windows_inuse);
>  	}
>  
>  	if (lru_p)
> @@ -505,7 +501,7 @@ static int packfile_open_pack(struct packed_git *p)
>  			pack_max_fds = 1;
>  	}
>  
> -	while (pack_max_fds <= pack_open_fds && close_one_pack(p->repo))
> +	while (pack_max_fds <= pack_open_fds && close_one_pack())
>  		; /* nothing */
>  
>  	p->pack_fd = git_open(p->pack_name);
> @@ -649,7 +645,7 @@ unsigned char *use_pack(struct packed_git *p,
>  			pack_mapped += win->len;
>  
>  			while (settings->packed_git_limit < pack_mapped &&
> -			       unuse_one_window(p->repo->objects))
> +			       unuse_one_window())
>  				; /* nothing */
>  			win->base = xmmap_gently(NULL, win->len,
>  				PROT_READ, MAP_PRIVATE,
> @@ -754,6 +750,7 @@ struct packed_git *packfile_from_idx(struct repository *r, const char *path,
>  
>  void packfile_free(struct packed_git *p)
>  {
> +	packfile_list_remove(&all_packfiles, p);
>  	packfile_close(p);
>  	free(p);
>  }
>
> -- 
> 2.56.1.831.g720f3f5937.dirty
>

-- 
Laters,
Toon
