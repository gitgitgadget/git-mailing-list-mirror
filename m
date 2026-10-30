Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793377543;
	b=1Be601KwMxTVWM7DVrWJNP0r9WK3CvTWbYWBBS14Z/AAlXdf1bg9m1cVUcLprwxjnS1c
	 zepmwKhp8PCdBuMzSdpqGZxxHz1e8OU0b+t2gicDJI7tjksxfKNCaXVpOaSJrEDh97a5c
	 4UOocgTTircICpiK4huIOzACNomjkz6lca0BL2j5jqEkLViA6CIOhF8i3n/8JhzMyK/r4
	 ehqpepRtcGdK9E5I8wXRqeD5JGFvzelNFYIF23ieM7OK3+373fhwf44q6CrMwVPTbIM5i
	 2XZSdVBrm//3354A1n3KICcIPf/54lqRQ3fVneWYN0Rs7PyfzuEKx2RyfSFOiXmXYZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377543;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=xY8wjIGpJwUm7Q7EB/OiTHrTr51IwvmWl8JsnP9t8N8=;
	b=gIMA/0jyJJn818MAU8tc2HiRxN4sswtzimwSOUleaFN4E1QeKsy3r7FRicZGM79kCDGh
	 iNsyCjcnNK2I15j+61pPk1f86Dcei78lf2TBy6w00tpRcwBUxemHbcwN1v7ma5JpSp27V
	 eQY6G0ZaoC88aYDJLYdFrbBSnT+Tzfe7yj3E+vRzmlo5R/+fT6foW8YTPigQsI6yxWEfA
	 RuusdgPYMQRqBG5dZBLfmoijc3hFOSYidOJ1RvBbaCMHa8x9ycyzu3iCGt8Jz8CRT0JiZ
	 A7RoYgBCwNwBd9XWbcYdfHBGKmuD3za2paSeBsGwZKSOsht+GrDqlRVeCuF/HG+VR6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=2cHJlg99;
	arc=none smtp.remote-ip=95.215.58.4
Received: from mta1.migadu.com (out-4.mta1.migadu.com [95.215.58.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A08606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 16:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0A08606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=2cHJlg99
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KwUDtwcSIC86jAWGicummk9u6zsafoBq1YpXM33CQ1E=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793377536; v=1; x=1793982336;
 b=2cHJlg99fUQW/x2gUNtge26zQ9BT2SeBU2xhHYsSsbnPhtnWjnPVptcoySGutbBe06auwAkN
 VztPXc92DgYoclAPkD7TntXR87/mF6sGKsfiTfFd8f3GDlQ88D7E92BfNZVgXNpbz5sMHJLZZbv
 WWEMOg9zN0NVpw0epDK3AXM4=
X-Envelope-To: git@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 8e22eefbc3d9a16d;
	Fri, 30 Oct 2026 16:25:20 +0000
X-Mizu-Trace-ID: 8e22eefbc3d9a16d
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Root <rootminus0x1@gmail.com>
Subject: Re: [PATCH 1/3] builtin/grep: read submodule trees via their
 repository
In-Reply-To: <20261030-pks-grep-recurse-submodule-v1-1-d4eb5c87d8fb@pks.im>
References: <20261030-pks-grep-recurse-submodule-v1-0-d4eb5c87d8fb@pks.im>
 <20261030-pks-grep-recurse-submodule-v1-1-d4eb5c87d8fb@pks.im>
Date: Fri, 30 Oct 2026 17:25:11 +0100
Message-ID: <87fqxnyx3s.fsf@dev.null.iotcl.com.invalid>
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

> The function `grep_tree()` searches for a specific string recursively in
> a tree. It can recurse in two different ways:
>
>   - It may either see a subtree, in which case it recurses into itself.
>
>   - Or it may see a submodule, and in that case it recurses via
>     `grep_submodule()` which then again calls `grep_tree()`.
>
> In the latter case we continue grepping in the submodule repository's
> object graph. Historically this used to work by linking that submodule's
> object directory into the main object database. But in 93cd344e34f
> (builtin/grep: stop registering submodule ODB as source, 2026-09-11) we
> stopped doing that and instead expect to read submodule objects via the
> submodule repository.
>
> This logic is broken though: while we indeed know to read blobs via the
> submodule's object database, we didn't adapt trees in the same way. The
> result is that Git fails to read the object:
>
>     $ git grep --recurse-submodules -e hello HEAD
>     fatal: unable to read tree (935cff11a11f8734cf4e0d40955d1e0e5c12038e)
>
> This went unnoticed because our tests only cover submodules that contain
> files at the top level.

Should we mention this is a regression in 2.56?

> Fix this by reading nested trees via `opt->repo`, which is set to the
> submodule's repository via `grep_submodule()`.
>
> Reported-by: Root <rootminus0x1@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/grep.c                     |  2 +-
>  t/t7814-grep-recurse-submodules.sh | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index b045f8a488d..22fb365eeac 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -653,7 +653,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>  			void *data;
>  			size_t size;
>  
> -			data = odb_read_object(the_repository->objects,
> +			data = odb_read_object(repo->objects,

Derp... What simple (in hindsight) fix.

>  					       &entry.oid, &type, &size);
>  			if (!data)
>  				die(_("unable to read tree (%s)"),
> diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
> index 3d149d34c15..f51c5181805 100755
> --- a/t/t7814-grep-recurse-submodules.sh
> +++ b/t/t7814-grep-recurse-submodules.sh
> @@ -631,4 +631,27 @@ test_expect_success 'check scope of core.useReplaceRefs' '
>  	git -C base grep --cached --recurse-submodules C
>  '
>  
> +test_expect_success 'grep --recurse-submodules with tree-ish and nested directory' '
> +	rm -rf sub super &&

Small nit, shall we use test_when_finished here?

> +	git init sub &&
> +	mkdir sub/dir &&
> +	echo hello >sub/top &&
> +	echo hello >sub/dir/nested &&
> +	git -C sub add top dir/nested &&
> +	git -C sub commit --message "sub" &&
> +
> +	test_config_global protocol.file.allow always &&
> +	git init super &&
> +	git -C super submodule add "$(pwd)/sub" sub &&
> +	git -C super commit --message "super" &&
> +
> +	cat >expect <<-\EOF &&
> +	HEAD:sub/dir/nested:hello
> +	HEAD:sub/top:hello
> +	EOF
> +	git -C super grep --recurse-submodules -e hello HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done

Verified the test fails without the fix above.

All changes look good.

> -- 
> 2.56.0.341.g393f52fd96.dirty

The other two patches make sense to me as well. Seems worthwhile to
include them even if they aren't directly covered with a test.

-- 
Laters,
Toon
