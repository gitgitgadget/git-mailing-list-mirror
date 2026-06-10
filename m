Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B039B2F7AC1
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088620; cv=pass; b=uBw3NmnkAnat9ACxfvLJ6nNQd/wwIOb8BEDG0KBqeviFv7Uejz7WjK5Cp54muSgLmL1bQCKNVdGz9FZOaoHbs4paYy/lBzgwtfFhPgH8UiruRVhpkoIeTC90vKrtUjJtHLbHrw4fojp6M5Su9VrqkLNYNbumcCjphAwfMJu8JF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088620; c=relaxed/simple;
	bh=uACO4GmWH3m9HolK31uXSmcgYqLD6YRLkEuBYfzHNTA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=InPBdr0pc5IHQzlbCzoUVUX3d61jS2kdtV7SNPL/Ty6WS1L++51DqTJ83S8I0WAM/D782WtK/keQp5TZM3w+WKZi9Okt7neQGaTCm+WOGNMczvih5bH5rdMIZ0OuwuaaYmG117xU06YAV7D9eQ571TorhT6Nec5rPhFqYt13jSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfhrxsI0; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfhrxsI0"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-59cfbfe64baso2372912e0c.2
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 03:50:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781088617; cv=none;
        d=google.com; s=arc-20240605;
        b=WIbetzjF8A78L3XccODlFcv1rdMA18O2byZBwpyZOot5IKeFzltzoereerpZAto0Xl
         MkfAmWcNU5rkpDN5Rl/gc5eB7lHZ9iCpj+otJFLXcnToLOAmuTm7CjUw7SRqtoXW8lwm
         z/DNBncPhSzCBkBLUPCYq3qViZaYR8hg/P46tcBvaW9wv3eDKp4MsGCRd6TCfLev5ugu
         TiRQB0BxztVbQPkN3VDWOLJK60UpKU2wHc+q47IBXDVp83Abp1/sDfVqi/OptyrKG4GA
         HO0mmojLekrRhQdv2AImlymnMy3a1JEPU8W5Nwp7thtRdXeWlxIVsAY6u+SN6W5zuWpY
         LSbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=FyG226joSnYh3+KJrAYD4wtAMUPEnahf5hcgSw+eY8g=;
        fh=Vskekxu6Igb/R78wkyr0owq/IrsrmeG9At1lS+oNkbw=;
        b=UZcOp+hJBKg2u9wlerlWoSMzMIwZZEWekLbnGs6UjHZY728gqqVAjMX/9oMQhX9yI8
         ze0/19P2jODJIbIN0uuIYnN2HyuJG+WDbkwCULOkBGTmunJPjcB2TH3TB7ex8E/dj5Rl
         IRys69WZR9sg4PJbI75qSqot3qrKhvomnrxyI9UW5+JxjAVRkubcM/Gsc7X6yr934TOZ
         EokN2eQT6eNV4ohMgXLROW1iiaXyHYB0UEbLLjQSQ1/G4vKDDQI4RV/chBj04Os2Igcx
         ku1ohwkUbxYtHHTEEj/uqqNYDlUucO/gEfaxZcobZublxvYno5dNWbnO+yYrkSJLyHBp
         1hRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781088617; x=1781693417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FyG226joSnYh3+KJrAYD4wtAMUPEnahf5hcgSw+eY8g=;
        b=XfhrxsI0YTQqiKTEkm1frCHDbIJQCtH5VtqGvgG1a0LRQkpRfZu3LMffoepTdUW1L8
         euuCuoFTLQppLmQKH93s6ZtFROucKiww6ke3TWeSLI38oTY6p/JAKVqSpzUVQ7o37An6
         DokwnF4L1z/yR9CWI+VVhNyAJUdxNrgmjkhhlu3Wu/hQJyi13P5L2sg6KJWesgjLyOV4
         aTzoUATvwmqPB7VTRMQEcS0ewuDMESagRMfeI/81FA+EU8fmxcxNhbkKs/WUnAaynJtW
         jYzjxRPi3/1XXDDb77VGrrvHN7nMSeu+ZIy4hBkB3IfaF40ic2PxKeDqA46de6Fj05qC
         z20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781088617; x=1781693417;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FyG226joSnYh3+KJrAYD4wtAMUPEnahf5hcgSw+eY8g=;
        b=gbtnkPDTPkhVwRo2O2ioer5yvpkxwdkV9R1+jbmLNUSDJzxl6I9YTjZRuO3Ioq6xKC
         hOa30yxLdYNWdw8kwDoOvmXHMsfVJuiG2mVovV2YU4CS0QB2rp+/VzmXKZ24mff6DL6D
         dLyjeNAuzgKcaM8m1yLxNuVwrwDEmSSQHh7VqYgeR0gPkB6Efe4M+T36qocbifGIjhDo
         M+XVP3lluAy0xmipYa4CzUwNDV7TkSfZ+PFvExA/od5MCWSRt8XRz0hhRpQtBmIg402g
         mjKfuTdeLWbjN2iMo27CeeacHW2EgcylsonWRJ4SDcbUnL9/TlcvrFFgknclnaL+ZExv
         aDFA==
X-Forwarded-Encrypted: i=1; AFNElJ/SDjL/e5Ij5dvJLylyRV5YBL5DNQs91Dc9WI4v3K1IERWMHReOz11kwkKWc53f64uJ/zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDUs4eTuYxSqLAeRlofBiRYGR+vsfvbYut7a1RwTvE4vcMr070
	rmr4nzp4Ga5kZhwDXWN0nlNch0qf/IztvUD1IwEy2AuMvLsfYjiPyYJx9M0FBzDfw0l1hiaUKPb
	q/FfhvOqcpMxP65O+WkuIINZF4bw/Pu8=
X-Gm-Gg: Acq92OFxZJF/6nVV5p0mqVPBa5J/BvNXHIJIt2n5Ud19u0+mz3szEta4uG9RQovPnNO
	3J5qZEvT6jHkgKxQDXsIISJqoXu3rxcljqK3VyOch048Rh5bp/ZF5bXxzYzXu1lwom1DjvTCQbn
	JtO/i0JcKz23plhW+0Q9E3LTeigYJo7zZMJwOn1shMzAUvm/qXCIRQUGQCF5weCH8xCo/T1BPkY
	jHanPiCgcuuDY9DW6f8Gw2AAHyobdWgL2HNuUz68aedDmU1mao4Q7/d70D4LT6zigsGRr/7i9RC
	IaZM0d3AUca+Hm/l0SOFtALLbF07WcLrMvqcn2sQFjn7FtRaI26+qkllvV0rcE+5j7/JZ15sRGa
	+2V+wU5yh
X-Received: by 2002:a05:6122:134f:b0:575:e9eb:d879 with SMTP id
 71dfb90a1353d-5ac48699ccdmr12658621e0c.0.1781088617529; Wed, 10 Jun 2026
 03:50:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jun 2026 06:50:16 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jun 2026 06:50:16 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260608-fix-git-branch-regression-v2-1-fd82075a8520@gmail.com>
References: <20260608-fix-git-branch-regression-v2-1-fd82075a8520@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Jun 2026 06:50:16 -0400
X-Gm-Features: AVVi8CdU-_HhJKovBOSu-UkEHNzAYxR_5_WuS6PUkE74KkXOfZoz39jhChHLgdc
Message-ID: <CAOLa=ZRHKNNymXGk31YgECjUmF9nZ8GsPUdQb7aKBH5DKMz7=w@mail.gmail.com>
Subject: Re: [PATCH v2] ref-filter: restore prefix-scoped iteration
To: Tamir Duberstein <tamird@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
	ZheNing Hu <adlternative@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000005ca8c50653e402ad"

--0000000000005ca8c50653e402ad
Content-Type: text/plain; charset="UTF-8"

Tamir Duberstein <tamird@gmail.com> writes:

> Commit dabecb9db2 (for-each-ref: introduce a '--start-after' option,
> 2025-07-15) changed single-kind branch, remote-tracking branch, and tag
> enumeration in do_filter_refs() from constructing an iterator with the
> namespace prefix to constructing an unscoped iterator and applying the
> prefix with ref_iterator_seek().
>
> Before that change, refs_for_each_fullref_in() passed the namespace
> prefix during iterator construction. That helper has since been
> replaced by refs_for_each_ref_ext().
>
> The files backend primes its loose-ref cache for the construction
> prefix before it opens packed refs. An empty construction prefix
> therefore reads every loose ref, and a later seek cannot undo that I/O.
> Consequently, git branch, git branch --remotes, and git tag scale with
> unrelated loose refs.
>

And this is the crux of the issue. Currently we do

- refs_ref_iterator_begin()
  - ref_iterator_seek()

And between the two `cache_ref_iterator_set_prefix()` is already called
which caches all the loose refs. This is the IO intensive operation this
patch tries to avoid.

I think it would be worthwhile to add this information in the commit
message.

>
> Patrick Steinhardt observed during review that iterator construction
> and seeking accepted similar strings but assigned them different state
> semantics. Junio C Hamano then pointed out that no current command can
> combine start_after with this single-kind path, but future branch or
> tag support would need to keep the namespace while moving the cursor.
>
> Keep the existing start_after path unchanged. The iterator API cannot
> currently seek to one string while retaining another as its prefix:
> an unflagged seek clears the prefix, while REF_ITERATOR_SEEK_SET_PREFIX
> replaces it with the seek string.
>
> For the commands affected by this regression, which do not set
> start_after, pass the namespace prefix during iterator construction so
> that loose refs are scoped before the packed-refs snapshot is opened.
> This fixes the current regression without deleting the ref-filter state
> discussed during review or changing its dormant behavior.
>
> Add REFFILES-gated performance cases with one branch, one
> remote-tracking branch, one tag, and 10,000 unrelated loose refs. The
> benchmarks were run with:
>
>     GIT_PERF_REPEAT_COUNT=5 GIT_PERF_MAKE_OPTS=-j8 \
>         t/perf/run a89346e34a . -- p6300-for-each-ref.sh
>
> The following are the best of five runs, with each run invoking the
> command ten times. Times are elapsed seconds with user and system CPU
> seconds in parentheses:
>
>                                   a89346e34a       this commit
>   branch                       2.74(0.13+2.56)   0.11(0.04+0.04)
>   branch --remotes             2.81(0.13+2.62)   0.12(0.04+0.04)
>   tag                          3.01(0.14+2.82)   0.11(0.04+0.04)
>
> Both revisions used the default -O2 build flags and a config.mak
> containing only "NO_REGEX = NeedsStartEnd". They were built with Apple
> clang 21.0.0 on macOS 26.5. The machine was a MacBook Pro (Mac16,6)
> with a 16-core Apple M4 Max (12 performance and four efficiency cores)
> and 128 GB RAM.
>
> Link: https://lore.kernel.org/git/aGZidwwlToWThkn8@pks.im/
> Link: https://lore.kernel.org/git/xmqqikjq7s16.fsf@gitster.g/
> Fixes: dabecb9db2b2 ("for-each-ref: introduce a '--start-after' option")
> Assisted-by: Codex gpt-5.5
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> The series is based on a89346e34a (maint) because the regression has
> been present in released versions since Git 2.51.0.
> ---
> Changes in v2:
> - Extract local variable `store`.
> - Link to v1: https://patch.msgid.link/20260605-fix-git-branch-regression-v1-1-02f40ad40929@gmail.com
> ---
>  ref-filter.c                 | 28 +++++++++++++++++++---------
>  t/perf/p6300-for-each-ref.sh | 39 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 57 insertions(+), 10 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 1da4c0e60d..5cbc007d64 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -3315,19 +3315,29 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, refs_for
>  		prefix = "refs/tags/";
>
>  	if (prefix) {
> -		struct ref_iterator *iter;
> +		struct ref_store *store = get_main_ref_store(the_repository);
>
> -		iter = refs_ref_iterator_begin(get_main_ref_store(the_repository),
> -					       "", NULL, 0, 0);
> +		if (filter->start_after) {
> +			struct ref_iterator *iter;
> +
> +			iter = refs_ref_iterator_begin(store, "", NULL, 0, 0);
>
> -		if (filter->start_after)
>  			ret = start_ref_iterator_after(iter, filter->start_after);
> -		else
> -			ret = ref_iterator_seek(iter, prefix,
> -						REF_ITERATOR_SEEK_SET_PREFIX);
> +			if (!ret)
> +				ret = do_for_each_ref_iterator(iter, fn,
> +							       cb_data);
> +		} else {
> +			/*
> +			 * Pass the prefix during construction because the files
> +			 * backend primes loose refs before a later seek can
> +			 * narrow the iterator.
> +			 */
> +			struct refs_for_each_ref_options opts = {
> +				.prefix = prefix,
> +			};
>
> -		if (!ret)
> -			ret = do_for_each_ref_iterator(iter, fn, cb_data);
> +			ret = refs_for_each_ref_ext(store, fn, cb_data, &opts);
> +		}

This would work, as now we separate out the regular path to use
`do_for_each_ref_iterator()` instead.

But this causes a bit of confusion, why do we need to use
`do_for_each_ref_iterator()` and why not simply provide the prefix to
`refs_ref_iterator_begin()`, like before?

On top of master, the below diff seems to fix the issue and works with
the benchmarks provided in this patch. (I haven't tested it with out
test suite though).

modified   ref-filter.c
@@ -3316,15 +3316,16 @@ static int do_filter_refs(struct ref_filter
*filter, unsigned int type, refs_for

 	if (prefix) {
 		struct ref_iterator *iter;
+		struct ref_store *store;

-		iter = refs_ref_iterator_begin(get_main_ref_store(the_repository),
-					       "", NULL, 0, 0);
+		store = get_main_ref_store(the_repository);

-		if (filter->start_after)
+		if (filter->start_after) {
+			iter = refs_ref_iterator_begin(store, "", NULL, 0, 0);
 			ret = start_ref_iterator_after(iter, filter->start_after);
-		else
-			ret = ref_iterator_seek(iter, prefix,
-						REF_ITERATOR_SEEK_SET_PREFIX);
+		} else {
+			iter = refs_ref_iterator_begin(store, prefix, NULL, 0, 0);
+		}

 		if (!ret)
 			ret = do_for_each_ref_iterator(iter, fn, cb_data);


I would say something like this would make more sense, since it still
keeps the current structure without introducing a new command.

>  	} else if (filter->kind & FILTER_REFS_REGULAR) {
>  		ret = for_each_fullref_in_pattern(filter, fn, cb_data);
>  	}
> diff --git a/t/perf/p6300-for-each-ref.sh b/t/perf/p6300-for-each-ref.sh
> index fa7289c752..ed9c1c6a19 100755
> --- a/t/perf/p6300-for-each-ref.sh
> +++ b/t/perf/p6300-for-each-ref.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>
> -test_description='performance of for-each-ref'
> +test_description='performance of ref-filter users'
>  . ./perf-lib.sh
>
>  test_perf_fresh_repo
> @@ -84,4 +84,41 @@ test_expect_success 'pack refs' '
>  '
>  run_tests "packed"
>
> +test_expect_success REFFILES 'setup many unrelated loose refs' '
> +	git init scoped &&
> +	test_commit -C scoped --no-tag base &&
> +	test_seq $ref_count_per_type |
> +		sed "s,.*,update refs/custom/unrelated_& HEAD," |
> +		git -C scoped update-ref --stdin &&
> +	git -C scoped update-ref refs/remotes/origin/main HEAD &&
> +	git -C scoped update-ref refs/tags/only HEAD
> +'
> +
> +test_perf "branch (many unrelated loose refs)" --prereq REFFILES "
> +	(
> +		cd scoped &&
> +		for i in \$(test_seq $test_iteration_count); do
> +			git branch --format='%(refname)' >/dev/null
> +		done
> +	)
> +"
> +
> +test_perf "branch --remotes (many unrelated loose refs)" --prereq REFFILES "
> +	(
> +		cd scoped &&
> +		for i in \$(test_seq $test_iteration_count); do
> +			git branch --remotes --format='%(refname)' >/dev/null
> +		done
> +	)
> +"
> +
> +test_perf "tag (many unrelated loose refs)" --prereq REFFILES "
> +	(
> +		cd scoped &&
> +		for i in \$(test_seq $test_iteration_count); do
> +			git tag --format='%(refname)' >/dev/null
> +		done
> +	)
> +"
> +
>  test_done
>
> ---
> base-commit: a89346e34a937f001e5d397ee62224e3e9852040
> change-id: 20260605-fix-git-branch-regression-9e4236f18091
>
> Best regards,
> --
> Tamir Duberstein <tamird@gmail.com>

Thanks for the patch, this is indeed a regression we must fix and the
benchmarks are a clear indication of it.

--0000000000005ca8c50653e402ad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9468da1884dcaba9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vcFFXWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL25DQy85ZEttWnBybldWR1h4RW0wZ2xESzE3Q3hiSgpRZmEvR1pEbjNl
b3lGVEQ2U0s4TXlaWlRiV2NjbnJIRTZtajdKUExGdnJ1L1pxbTBrQTNidkQ3cUIyTkY2Y3JiClVQ
Vi8vdW8yZmluWlErYXlNajlFNGlFNWhKNDMva0NCM0duUDR5ckxlVXE2d3R2b2lYRG5PanF5VkVo
RzcvOUIKd0FOK2k2SlRnaXk1ZkdKYjRoZWxYWk4wR2dDd1BLU1UzaFlKQkxrcWFsa0FuSTFHMGdw
RitZMktRUDEzbUhmWQpZRDIxSURZN3p1VnQ3TkVVSlhkNzQ0UnJkN0VuVXBuc295bHZZOENRR1h4
eEM0cGZXMnc1MEF1S2VIVEk1cktDClNscmhDeG5QRDNxMXFiV1V3QUtjR1liOWx6dE5JNG9CUzNQ
N0U1YllZM1k1OVF6a0JzZFg5T1pGcGRibm41cEQKT0toN25ORy9ucngzU1hpUWcvVEJ5N1Q5Yi9s
azBLSkwwSHJpeEZvNTluT2sxUG83QndRTWpjVkM4SXVZSmYyNgp2Vk1BZUdiTEFCa3Z0MzNvaHNB
Z2pVZnhNZzJTeURsRTNiZHFOakxNbnRKdnVzVDFjbTdlbWdDcVlSRlVXMkE0Ck0yUkdhbTJINmlH
MVpGdkNyQWtxSWU2Vmo5ZlhDbisrYXV1eTNyMD0KPVR4dFcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005ca8c50653e402ad--
