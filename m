Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AADD34405F
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771443246; cv=none; b=uaRs5SZODauMlQedgU9wPo47mKzp6LQUKW1uI3SK4KF4qFFXgMht4cTQBann81vBzmhiIE8O+/ecpp+sJKKs0/1OJbil6aAtpCZI+hdw+rpwAlpQQ0yEirXF8DZhwJaPqbvqr3xQjgDBRA28dtmbPM8dLw5wa1zs+T1en6nPvWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771443246; c=relaxed/simple;
	bh=qnpMx3rU3USlZNSSs69/qvVD1I/PagiXiGFKlg+Ub7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9sgDg7QZ4esFW6OWPnyLYQ9A629CPd94/lAMwPEx+/k/lLesrfZCATZQOown9HyafGx/9T4AnAus0zU7nNfYBswjTLhyT+h0GcnUajtJT6t3kU9ygVt4W78jMxLsxqqB/2OvJ9qbud5Jw5P74foXVqT5Rc5qYJ5LwE7FkMSNA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZfXAuB/; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZfXAuB/"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6799774d0fcso124454eaf.3
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 11:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771443244; x=1772048044; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9ibBUEgI+re+mEXEs0ZY7vvkDvgW1Q+QV/jW8MBLaSA=;
        b=MZfXAuB/Snrw7dQVJMImIOdifFBoPJ5eyGqjaYzEzgQBU0iYUtGaQ/Mbr7zqQMbiRz
         FLEZJ0X9jKqdOM0+e1qa2H6xZdEtyU+AocykM5Th9jNY7dixCewzqpOWNjwCttd/+54N
         HJAFL88CBlfhLLKQ9AaZSR/EEoaMHseOLBfq1Qg7fbLzl+nWA0RWVBcwUCiKZ20Kz+N3
         EQ7bH8PKINs/s1PMzQAdw5tkF4A+cn46gV2ZPy8JrZIfW4KvPpF8kWbb3ckkZwRihoOV
         9V4Z08Y6HB/OXOeD/FCxDQNsjSChVz1+TVAUF2A8R16Y4C3taA5hRc31xuxLqYvR87zK
         FzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771443244; x=1772048044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ibBUEgI+re+mEXEs0ZY7vvkDvgW1Q+QV/jW8MBLaSA=;
        b=J10N5Ac9/jSfLs91Yy2U7LQnuXYos2hWPbQKuwtPNCQD9FEXs9tqlnh4WxtFCRCSXZ
         fnrZjzdgRfpUjrlNQPd3ny5SRVFf39LUDSnhNTVa7M2hgl7/lSdO5deXiFYJ+rm8jxCu
         rrfi9+rd7Lo1Lwh8obwpgxkHP1ofc5nxWO40QXxU4JFPKeqGiqQeHPgLW4P+CGHfYAdO
         rH8RnTiQ8JYFG6RMe4AENVfSdnymvZ0D2HaPJerKrllENgRHeEHVGo3GIk0WW6obRv1X
         Fyd4NRnvyjPm3UN0ekMvOcQu0ehxjjASp0ZLcPY2PxkbxcV8J1aA1d0LZ4teuL00ayb7
         dyig==
X-Gm-Message-State: AOJu0YyK6Q9QngkMWbFZ1dbjKWbmZy7qyJnIpg7jGcxry+PrqRweWF9d
	f84PW4uy+hGqmrW6WDhAYN8kiJuVNE0plDVDj+ChtGYgZUB2aD4TS1Fx
X-Gm-Gg: AZuq6aIRtcyWCrLqwvsfGvDVH98lAaeYdbrjyE0KIm1e/8SfbxmrsQYqdhKC+NDqtF+
	HOHnXyMAgnPYv6brFPYwtVGxv3+L9h9Q5H2xCV10cNnoz/ZG7a+xIUlNuShN2HEwKGbFy/rL3qo
	LNDYOg+9p0NafOmeT1mktUVSQh6Ym0wt2Yl4j6CRzTfN5th7p5WMG4Dpf5yglJ72qSh4TJs1pN/
	TDMvkec7HG5X8ak5XIOaR0/aOZuxn4V3uFRa5NuaS+LposnMiuP9JR4rpemqsHpioGZwf+uhTKw
	qvmZWhpUSTePbh1KcTiVzg7KblQKxTC6xGzWaQKEQlmD7AcIfA2TxbVyNFfwFD9cvG6pfH1IuS2
	XMKYM4+9NFqajMLZzGjfJey+v8PhfCTZclhDKIRRR0nhhDT5UF/mRMuOjETRvehCsVzyDIXh2eD
	dZOUlj25spkEH/JURM
X-Received: by 2002:a05:6820:2106:b0:65e:f7e6:438c with SMTP id 006d021491bc7-679a71eb1b8mr1817545eaf.36.1771443244050;
        Wed, 18 Feb 2026 11:34:04 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-674758eb709sm13315154eaf.12.2026.02.18.11.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 11:34:03 -0800 (PST)
Date: Wed, 18 Feb 2026 13:34:01 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Matt Smiley <msmiley@gitlab.com>
Subject: Re: [PATCH 3/3] commit: use commit graph in
 `lookup_commit_reference_gently()`
Message-ID: <aZYS73lGbt7Gt8uS@denethor>
References: <20260216-b4-pks-receive-pack-optimize-shallow-v1-0-e98886daff2b@pks.im>
 <20260216-b4-pks-receive-pack-optimize-shallow-v1-3-e98886daff2b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260216-b4-pks-receive-pack-optimize-shallow-v1-3-e98886daff2b@pks.im>

On 26/02/16 04:38PM, Patrick Steinhardt wrote:
> In the preceding commit we refactored `lookup_commit_reference_gently()`
> so that it doesn't parse non-commit objects anymore. This has led to a
> speedup when git-receive-pack(1) accepts a shallow push into a repo
> with lots of refs that point to blobs or trees.
> 
> But while this case is now faster, we still have the issue that
> accepting pushes with lots of "normal" refs that point to commits are
> still slow. This is mostly because we look up the commits via the object
> database, and that is rather costly.
> 
> Adapt the code to use `repo_parse_commit_gently()` instead of
> `parse_object()` to parse the resulting commit object. This function
> knows to use the commit-graph to fill in the object, which is way more
> cost efficient.

Makes sense.

> This leads to another significant speedup when accepting shallow pushes.
> The following benchmark pushes a single objects from a shallow clone
> into a repository with 600,000 references that all point to commits:
> 
>   Benchmark 1: git-receive-pack (rev = HEAD~)
>     Time (mean ± σ):      9.179 s ±  0.031 s    [User: 8.858 s, System: 0.528 s]
>     Range (min … max):    9.154 s …  9.213 s    3 runs
> 
>   Benchmark 2: git-receive-pack (rev = HEAD)
>     Time (mean ± σ):      2.337 s ±  0.032 s    [User: 2.331 s, System: 0.234 s]
>     Range (min … max):    2.308 s …  2.371 s    3 runs
> 
>   Summary
>     git-receive-pack . </tmp/input (rev = HEAD) ran
>       3.93 ± 0.05 times faster than git-receive-pack (rev = HEAD~)
> 
> Also, this again leads to a significant reduction in memory allocations.
> Before this change:
> 
>   HEAP SUMMARY:
>       in use at exit: 17,524,978 bytes in 22,393 blocks
>     total heap usage: 33,313 allocs, 10,920 frees, 407,774,251 bytes allocated
> 
> And after this change:
> 
>   HEAP SUMMARY:
>       in use at exit: 11,534,036 bytes in 12,406 blocks
>     total heap usage: 13,284 allocs, 878 frees, 15,521,451 bytes allocated

Very nice :)

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  commit.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/commit.c b/commit.c
> index b7c4ec2eb5..014f74822c 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -45,7 +45,7 @@ struct commit *lookup_commit_reference_gently(struct repository *r,
>  {
>  	const struct object_id *maybe_peeled;
>  	struct object_id peeled_oid;
> -	struct object *object;
> +	struct commit *commit;
>  	enum object_type type;
>  
>  	switch (peel_object_ext(r, oid, &peeled_oid, 0, &type)) {
> @@ -67,11 +67,11 @@ struct commit *lookup_commit_reference_gently(struct repository *r,
>  		return NULL;
>  	}
>  
> -	object = parse_object(r, maybe_peeled);
> -	if (!object)
> +	commit = lookup_commit(r, maybe_peeled);
> +	if (!commit || repo_parse_commit_gently(r, commit, quiet) < 0)
>  		return NULL;

Now it is possible to use the commit-graph to parse the commit.

>  
> -	return object_as_type(object, OBJ_COMMIT, quiet);
> +	return commit;
>  }
>  
>  struct commit *lookup_commit_reference(struct repository *r, const struct object_id *oid)

Thanks Patrick. This looks good to me.

-Justin
