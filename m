Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.215
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702580;
	b=w0MwlJFp6U4VSL4tOQqyAd6iMQW9SVGXubegNdyFIL+8QabXan7cIWeWyfIWrjCCymwr
	 bG9kfrBqFKFBk+Ce/ZDHRHCbJHTKAriXZdRGBXp2S4eV7mazDaxOPlbeTCcuWhlkX+i/p
	 Rc26QqM0qkms16n3rVHZFxtIDnx2wabJxRLG7AiECir0L5mxhYjd0H99wEjy+WFZNgR2P
	 fkcpsgC+Dia4DO4zlALyymH/Kg89/1jeaFPAR5+wLEg7ImGlo66PDtMuxExf78X8LiY+v
	 9Sh0aEu00jTtYl10Lm5T9roUjeB2KTZ9mY9miuGnXfoporXisSh63SPO40sdzch+isg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702580;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=sug4WGXmISAq0gHVh+UblT4RbQoRYOXNVt6EKgg805I=;
	b=m+ZqoAbOKl6E8BdnbLyqJxzk5p70H8MWnS6M+dMGxsENmJxnUYTStk83XN0CUCSTDNR1
	 GxCE20oX7AMzjI6wzLSUhLCLpjIM0tkLuOCoNpjRdfMXijpbAffHTqT2MzaM/lr/ta1DH
	 ymg/qxNysbMdEghbYgXFqxOJKIk5fJzp4El32XfCMPcqpRXzIIBY7/Dht95rVea3IPyGZ
	 VkHuMV3WMyShqQSGoMXXrDKF6GZhGhwxobM34BvyNjfiPzApSffMQvRLzHXQEZHLmvrRw
	 ncFMvY0mM04ygdRoYuL1Zr0Qtonr6S9vsgoO1TZbgommM0UxjsDGg+SukDANmli9DrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=S36Tkvnw;
	arc=none smtp.remote-ip=91.218.175.215
Received: from mta0.migadu.com (out-215.mta0.migadu.com [91.218.175.215])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DB3606A31E
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 14:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5DB3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=S36Tkvnw
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kH/Powf0yV8SD1e8mQZsFErXGcP25IxKJBq0+ApciIg=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795702577; v=1; x=1796307377;
 b=S36TkvnwbvdiFnJJvp6nJUbPvX/Mb15yN+8fHMadrB1Sgqag6PQ0vysepG1pLXiws9piq8GC
 ebpixqu+E9ip20TfARzXdH7K0LzdD5a5iKTWkIPN6ASm+9k6As/WD2m6QU3ltCocPe9nQnWbMwV
 TIqcDGjv1epKfXzrNz/9T5HE=
X-Envelope-To: git@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 4292350bc29699b2;
	Thu, 26 Nov 2026 14:16:17 +0000
X-Mizu-Trace-ID: 4292350bc29699b2
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 3/6] packfile: inline `open_packed_git_1()`
In-Reply-To: <20261120-pks-packfile-global-statistics-v1-3-19beb83b145f@pks.im>
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
 <20261120-pks-packfile-global-statistics-v1-3-19beb83b145f@pks.im>
Date: Thu, 26 Nov 2026 15:16:14 +0100
Message-ID: <87bj7bsmoh.fsf@dev.null.iotcl.com.invalid>
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

> The function `open_packed_git()` is responsible for opening a packfile.
> The majority of work is not performed by it though, but instead by its
> `_1()` sibling. But this sibling really only exists because we thought
> it too hard to handle errors properly and close the packfile's file

Is this missing an "'s" after the "it"?

> descriptor on an error path. So `_1()` doesn't handle those, and instead
> defers to its only caller to close the file descriptor in the error path
> again.
>
> Fix this design smell by introducing a common exit path that knows to
> close the file descriptor on error. This allows us to inline the call to
> `open_packed_git_1()`.
>
> While at it, rename the function to `packfile_open_pack()` to match
> modern best practices. Besides that, it also gives the caller a better
> idea of _what_ is being opened, as we also have functions that open
> other files that belong to a packfile.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  packfile.c | 115 +++++++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 70 insertions(+), 45 deletions(-)
>
> diff --git a/packfile.c b/packfile.c
> index 95a97c302c7..9b03258311f 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -480,11 +480,7 @@ const char *pack_basename(struct packed_git *p)
>  	return ret;
>  }
>  
> -/*
> - * Do not call this directly as this leaks p->pack_fd on error return;
> - * call open_packed_git() instead.
> - */
> -static int open_packed_git_1(struct packed_git *p)
> +static int packfile_open_pack(struct packed_git *p)
>  {
>  	struct stat st;
>  	struct pack_header hdr;
> @@ -492,9 +488,12 @@ static int open_packed_git_1(struct packed_git *p)
>  	unsigned char *idx_hash;
>  	ssize_t read_result;
>  	const unsigned hashsz = p->repo->hash_algo->rawsz;
> +	int ret;
>  
> -	if (packfile_open_index(p))
> -		return error("packfile %s index unavailable", p->pack_name);
> +	if (packfile_open_index(p)) {
> +		ret = error("packfile %s index unavailable", p->pack_name);

Not sure if it should be part of this series, but should we make the
messages localizable?

> +		goto out;
> +	}
>  
>  	if (!pack_max_fds) {
>  		unsigned int max_fds = get_max_fd_limit();
> @@ -510,55 +509,81 @@ static int open_packed_git_1(struct packed_git *p)
>  		; /* nothing */
>  
>  	p->pack_fd = git_open(p->pack_name);
> -	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
> -		return -1;
> +	if (p->pack_fd < 0 || fstat(p->pack_fd, &st)) {
> +		ret = -1;
> +		goto out;
> +	}
>  	pack_open_fds++;
>  
>  	/* If we created the struct before we had the pack we lack size. */
>  	if (!p->pack_size) {
> -		if (!S_ISREG(st.st_mode))
> -			return error("packfile %s not a regular file", p->pack_name);
> +		if (!S_ISREG(st.st_mode)) {
> +			ret = error("packfile %s not a regular file", p->pack_name);
> +			goto out;
> +		}
> +
>  		p->pack_size = st.st_size;
> -	} else if (p->pack_size != st.st_size)
> -		return error("packfile %s size changed", p->pack_name);
> +	} else if (p->pack_size != st.st_size) {
> +		ret = error("packfile %s size changed", p->pack_name);
> +		goto out;
> +	}
>  
>  	/* Verify we recognize this pack file format. */
>  	read_result = read_in_full(p->pack_fd, &hdr, sizeof(hdr));
> -	if (read_result < 0)
> -		return error_errno("error reading from %s", p->pack_name);
> -	if (read_result != sizeof(hdr))
> -		return error("file %s is far too short to be a packfile", p->pack_name);
> -	if (hdr.hdr_signature != htonl(PACK_SIGNATURE))
> -		return error("file %s is not a GIT packfile", p->pack_name);
> -	if (!pack_version_ok(hdr.hdr_version))
> -		return error("packfile %s is version %"PRIu32" and not"
> -			" supported (try upgrading GIT to a newer version)",
> -			p->pack_name, ntohl(hdr.hdr_version));
> +	if (read_result < 0) {
> +		ret = error_errno("error reading from %s", p->pack_name);
> +		goto out;
> +	}
> +
> +	if (read_result != sizeof(hdr)) {
> +		ret = error("file %s is far too short to be a packfile", p->pack_name);
> +		goto out;
> +	}
> +
> +	if (hdr.hdr_signature != htonl(PACK_SIGNATURE)) {
> +		ret = error("file %s is not a GIT packfile", p->pack_name);

I'm surprised "Git" is spelled out in caps here.

-- 
Laters,
Toon
