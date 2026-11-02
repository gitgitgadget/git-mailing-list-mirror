Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628901;
	b=rc9iyPuwsuPucbfhcwT2sCQ1OU3Q7n67dlCHZL8pkXFIlEnAO2JIPiFEszzYSmbbU+/u
	 F1GZVoHne7REf9rdzMNCOR3kPIWjCfnEjFQ2fOHBigXvsfH714alX2WTIrd4Rp2WWL532
	 qzPB+jwZ7l86NUSgsjFXI85a5F6v8nQsOFxWlBHQa5cTaVYa9D7M4k2bZub1OFz1R51lp
	 hdfS8KeJ5mKn6JejFbAsfzSTs9LLbVZ+wfjP8YoSOGeLls+hs//jReXxITZDriG33VT2r
	 jnflL3IGIPv8Irqm3NcR0pN0ciVthTL0VcYEE1rDzVtpOIsUioWAhBwMWUkoorrGocQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628901;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=IGv3cIWTIDUsLw/5Ke59qnRTl7O2IP1ZZrrB3PPk0gs=;
	b=3I1xdWiT8uLHetUrX1SX1mFhevQKuwpZtvABs+VZB5MbIiPpYrHvXixhDX5T6dnSKvjB
	 aYFo1V5ZQ2kHgoNCfC3Uvwim/ggnKcbDbCTcsn7w9HcPobazJX6yDHE2DJCKIJxplRY8n
	 3sB7cuQRQ6lf12pKx4BMTfIp11DU9H8nxA3ibgdiPJ8HqMYDRg1hw26O7wlFQhGnz6XHH
	 sxOqa5w8RcBAMKtlHTxrhZvY9v9LJIrJrBF3pLEEONNEIOFdSfqD4tmDiuAcZgeps3IMf
	 ROzRF1ShY/tYx7N/R8XMyENWQVluJsFwvDhgj4fH3mHphKtoNgDK/KJYYJX5Wv2YIPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gDMktBqe;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2590606B5CF
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 14:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2590606B5CF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gDMktBqe
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a4dc547987so15907445e9.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 06:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793628899; x=1794233699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IGv3cIWTIDUsLw/5Ke59qnRTl7O2IP1ZZrrB3PPk0gs=;
        b=gDMktBqe3vPt2KslcGx8eovpi72FJqXOFjYRbpRyb1psJLggsgO4H1wCHwT1etSfSo
         KEFSg6AUs3bWp1jJ9gc8siBZ1WjP2P/FwJi24u5K4GF6ZbqrkY3AgWsL1OR7VaHcZThh
         klXRMsZbJ01B46yPqGV68mAXeY4Dswq0q1w5EZdQ4aZqsLBsuxroQR6/xGPy9ILkJRPp
         iUgI3wGBFMVG1QlGvTYPsjLJ4hxx5gjcc+PxFcBtDzWQT76tV1TMvVFNexAQ7LH1GbIx
         hxC5eA21qHUa8u666VW828ewnwOPCdreAsNB1NKn0r0EIDpGkO41xvc6tLPMLI1PHdNS
         5IXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793628899; x=1794233699;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IGv3cIWTIDUsLw/5Ke59qnRTl7O2IP1ZZrrB3PPk0gs=;
        b=GjuXbKMYIte8RkCQK/rw7LZzEcImiSEYdl6Vs9ebq75N0Vf52x7w9v21/dHB+SLuUR
         Gpzq0Y5L69JvfGROS/J+Z6V6dmMa2LgJW82VKdHKHqstHWEFe9uDeSZS+kpNWv8/VOFU
         KYf9w43F6+7MgxQfpC7EY+w4D8sNyz8Lg+1A2ndr69xnTviOS713GffwpWRU/YUK2r+a
         NWxsmKlnZ2nFjlsJh77sNRUfFzZDJBkqIjGDKTTtAAgYvfVH1N1oRpuyDXgCd/k/hDC6
         3ODy8WuJplLfpQyh/OhHse7MyB1c+Y57VK0dKODyY3fpzjasLmiAqk8PuGfD+PjX8C7O
         yRLg==
X-Forwarded-Encrypted: i=1; AKwUvBwjj4GLuh6PeWRgmkESnvIpx58mSalg6DK+05PG6QuF8yuYDQZoFvglfXAjre79kRWqZkE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwLCXKqgLuJ8BzFdu/LaTlTfS1I3feJyUF3vF0PztJxle34IJg
	cFUYrMgfeNxfppjd6hghBDHXPK3Zu9nb//xB4GVeD60ziQ8DjfPiiMjz
X-Gm-Gg: AYBFou0JqEmMAhC46GumlbD5advntDVkY8Ck4BH06j5owQnU4c9YTdW5v119oA+ilQP
	FYJN97mUi2dfJNSKo9dPdSM/IMp24pHVeo7mEhl9v5FbDEMBD8UWQObwPa7s9g6IyDElGpa0Rgc
	JSHT2z44oIGx+2sWCBYUckohBirDld9LJ23/AoVySC88c1qfRmrGAfTmlAZaNAhv2sBmJVMrkyL
	sWvyarWEsRYONsgiMxdYdXN+RMHjNQeo5HO27jSENpWvE+2+XAzsVj28pJV8BUcZPXuK8fQ9wZZ
	Y4Syjw2y1EfulOGZAqf+eQ5DYCyvzoRyHUgeUTzSGjOhdlvHFqVwVUoXcl7CETEbsWhAAFgvtIg
	CEYFd1NkRdgDI4tc81Vi/BostO2MGO9Pgr/LBSwJLPdQ+A8ovbuvqeFW+Mi0DbVkdPGTBPRb0+Z
	bRZstjdEPMc0c4jbExnis6sc4k1QyfmkIdShRPCuBoeO1qmvhEVH7/Rds6WrJYy++/1r6T2YMxB
	RgWr6vFc9tQXKcTWAmPHJHy/+2RsVgoVzdD6wcuoRJ0qM5YyxKgT4Jy9NJgXxN7NjR0+BX+zph4
	IQlaiOE3C5t2egvL8cee5dD5nhCl4jsw7WfrJ5sU6/IK9sargISZzaWeP+JhHSvOi58TwRToQ3K
	CgfL0Sw==
X-Received: by 2002:a05:600c:5397:b0:4a4:4d57:8462 with SMTP id 5b1f17b1804b1-4ac18b7e65bmr232045055e9.24.1793628898963;
        Mon, 02 Nov 2026 06:14:58 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac0b4df257sm163673415e9.4.2026.11.02.06.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 06:14:58 -0800 (PST)
Message-ID: <845be1de-8d12-41c9-996d-038886bde4cf@gmail.com>
Date: Mon, 2 Nov 2026 14:14:57 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] stash: reuse prepared state when creating stash
To: jasmeet.bhatia.us@gmail.com, git@vger.kernel.org
Cc: Deveshi Dwivedi <deveshigurgaon@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Leon Michalak <leonmichalak6@gmail.com>
References: <20261031200107.285168-1-jasmeet.bhatia.us@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20261031200107.285168-1-jasmeet.bhatia.us@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jasmeet

On 31/10/2026 20:01, jasmeet.bhatia.us@gmail.com wrote:
> From: "Jasmeet (Jazz) Bhatia" <jasmeet.bhatia.us@gmail.com>
> 
> do_push_stash() already preloads and refreshes the index and calls
> check_changes() before invoking do_create_stash(). However, Git then
> repeats this same index preparation and change detection, including
> rebuilding the list of untracked files when requested, which is
> duplicate work.

Good observation

> Instead, avoid this duplicate work by passing the already prepared
> untracked file list to do_create_stash(). When the list is provided,
> reuse it and skip the redundant index preload, refresh, and
> check_changes() call.

I've got some patches in "seen" [1] that take a slightly different 
approach and keep the call to check_changes() in do_create_stash() and 
remove it from create_stash() and do_push_stash() instead. That series 
also removes a number of unnecessary calls to preload_index(). If you 
have time to post a review that would be really helpful.

Thanks

Phillip

[1] The patches are at 
https://lore.kernel.org/git/cover.1792767794.git.phillip.wood@dunelm.org.uk/ 
and are merged into seen as branch 'pw/stash-change-check-only-once'


> This maintains the existing behavior of "git stash create", which
> invokes do_create_stash() without prepared state and thus continues
> to perform its own index preparation and change detection.
> 
> Testing this using the p3904 stash performance tests shows a decent
> performance boost.
> 
>      stash -p, no fsmonitor
>      0.12(0.11+0.17) -> 0.10(0.10+0.18)  -16.7%
> 
>      stash -p, builtin fsmonitor
>      0.11(0.10+0.02) -> 0.09(0.08+0.01)  -18.2%
> 
> Testing this on the Linux kernel on my system, "git stash push"
> improved from 254 ms to about 239 ms, which is about 6%.
> 
> Signed-off-by: Jasmeet (Jazz) Bhatia <jasmeet.bhatia.us@gmail.com>
> ---
>   builtin/stash.c | 25 +++++++++++++++----------
>   1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/builtin/stash.c b/builtin/stash.c
> index e1a3a76bd0..58eb782597 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1459,7 +1459,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
>   			   int include_untracked, int patch_mode,
>   			   struct interactive_options *interactive_opts,
>   			   int only_staged, struct stash_info *info, struct strbuf *patch,
> -			   int quiet)
> +			   int quiet, struct strbuf *prepared_untracked_files)
>   {
>   	int ret = 0;
>   	int flags = 0;
> @@ -1473,14 +1473,17 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
>   	struct strbuf msg = STRBUF_INIT;
>   	struct strbuf commit_tree_label = STRBUF_INIT;
>   	struct strbuf untracked_files = STRBUF_INIT;
> +	struct strbuf *untracked_files_p = prepared_untracked_files ? prepared_untracked_files : &untracked_files;
>   
>   	prepare_fallback_ident("git stash", "git@stash");
>   
> -	repo_read_index_preload(the_repository, NULL, 0);
> -	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
> -					 NULL, NULL, NULL) < 0) {
> -		ret = error(_("could not write index"));
> -		goto done;
> +	if (!prepared_untracked_files) {
> +		repo_read_index_preload(the_repository, NULL, 0);
> +		if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
> +						 NULL, NULL, NULL) < 0) {
> +			ret = error(_("could not write index"));
> +			goto done;
> +		}
>   	}
>   
>   	if (repo_get_oid(the_repository, "HEAD", &info->b_commit)) {
> @@ -1493,7 +1496,8 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
>   		head_commit = lookup_commit(the_repository, &info->b_commit);
>   	}
>   
> -	if (!check_changes(ps, include_untracked, &untracked_files)) {
> +	if (!prepared_untracked_files &&
> +	    !check_changes(ps, include_untracked, untracked_files_p)) {
>   		ret = 1;
>   		goto done;
>   	}
> @@ -1529,7 +1533,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
>   	parents = NULL;
>   
>   	if (include_untracked) {
> -		if (save_untracked_files(info, &msg, &untracked_files)) {
> +		if (save_untracked_files(info, &msg, untracked_files_p)) {
>   			if (!quiet)
>   				fprintf_ln(stderr, _("Cannot save "
>   						     "the untracked files"));
> @@ -1615,7 +1619,7 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
>   		return 0;
>   
>   	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
> -			      NULL, 0);
> +			      NULL, 0, NULL);
>   	if (!ret)
>   		printf_ln("%s", oid_to_hex(&info.w_commit));
>   
> @@ -1698,7 +1702,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>   	if (stash_msg)
>   		strbuf_addstr(&stash_msg_buf, stash_msg);
>   	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
> -			    interactive_opts, only_staged, &info, &patch, quiet)) {
> +			    interactive_opts, only_staged, &info, &patch, quiet,
> +			    &untracked_files)) {
>   		ret = -1;
>   		goto done;
>   	}

