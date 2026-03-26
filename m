Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A497D3947AF
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519333; cv=pass; b=SghITVNDwZDbchAtWSS+NzqsEmtGVdUAy0+9QTAXvb/ajhopmvp09ZVAU1kCIaSSYgNkhPwjuFv9AqOI5mmxbdTLimARnBLWtzhrNHdGyLJOje74uS/D55oZNO8/fidUtdtep+2mo9uMEXKEFDvFCLPSKAA8hGOJwrCwCF0bjHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519333; c=relaxed/simple;
	bh=G3Iiqk9hCPUOD0Pat84CoTI4WAgC2fhNpRIJfpl5x9A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ck3nHBf1idtpD3bHZRNdvKig8TAnebN1iciea1ZnX80e+CAtZy5GJzhpEaPqnYOIAw9hhU1VsNX6qsWSKaPqNbdkOcEw0lFtCacBrmD+jRlCjbIUlGXYp4GRn+kFdcp1rP8MVw7PMJmywgw3h/Urv2wPJ5nzGrE2G9gL06mqoIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoGE/N1R; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoGE/N1R"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-60327793ec9so210606137.2
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 03:02:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774519330; cv=none;
        d=google.com; s=arc-20240605;
        b=A4IG7QQx1g6skCMz4vt07NC3tsMEL0+YX/KmELedgQ1nuw/rJCnr4cR3JZSlBdCZB7
         NWNegArlo7kBsFi8iU5N1a/HLWNUpi9zMH7uIC+s4r9Xx0EseCQUa7pS53jNGzUJwd8y
         ZShgw4K9wfy4tv15PYBgLKpCdAjjTkkGMhZOYJDPQY5pFVlhWhRlBS6KtpEccPBO6v1h
         FgE4gywCv7SFIU4kY/KckK73lc/+kF80xwSU7B74QQFaAn4j1Z37DTtMuxhte4XltCs5
         0NWOL0bAg+9hOFJ/5BhGzQbP9aVx25VjBdifZOhiBnJJUhcyuM40kkh8JBrgRdj+K2ZR
         6LDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Td17pdXgMHn0eVCXlSDCqhMymsdea+qnmaw46++9NKk=;
        fh=mygHlcu5fTGYor/PWMMofjmQSrjJC5yQ9YFvNRi1OTU=;
        b=VCd8Q/QKoz+Z9+xYxwofx2ozgoPwezH8qsjzQ3K3Pssfv2TVtovrFjHJsoEyAIHW0J
         hGXwqx3u4BBQIkfAal91yICa926FSy36fq6WgB3oDIpU+X4BtQdMObjbCd8dD/RKxtuf
         XaxTA6IQNpyJgUvaENNkruXGItUbov9DSIIROkCvMqWE1vJZfFmDaXkuzFzDWI9FtVKT
         GuLr85sxy83oM1TQjfvxwRfeyLTgTFgfN3Su8U7WLMSIpJ1puDTqgdf2JFXWrDX0s5uM
         RKyjIyh1eaEenyA90/gnid3ZsJi+VCxAgXpHbdYbH4mGDWwBdyMrhQgnZU8+Flwju6RH
         2S1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774519330; x=1775124130; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Td17pdXgMHn0eVCXlSDCqhMymsdea+qnmaw46++9NKk=;
        b=NoGE/N1RQ4hTcIxEXj3aCchx2UofJlT8roj63xgY7PJTWO3YGlNbUMZNIUs0/Y/urT
         R14O2pk5dgVGWTVSRve5xPJ8xg1RWROF4ZHNgrsGqDL0zTVfMmDEaC2yTBYFyRPQlJKF
         k4LfceJULGIOwG4J3mqzPpQltp2VWhpYwIPiBIv+k/2tt+S3bZMNabosvavnyGJdnHrQ
         yFicCmSgoAhDpbmraeUwzrguQ05coulna5ozNhFDoUwl8bTFia9y/byk6m+2dqYWOAIb
         z1Jj9jsOCtZT0NV4PhKR/9jp1US+IWVgZrb0yDas7gCVPKTsSApW5dlE+3oUq3JnuEq5
         xdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774519330; x=1775124130;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Td17pdXgMHn0eVCXlSDCqhMymsdea+qnmaw46++9NKk=;
        b=AYeKqRkG2xsNEVox6MP7nss3ZhYs3A/0J2Yf7PVFUFmkuTtcqGr3xDmmb9+3qeaNii
         cRfprqBXJNeaY46r5H2jH3LcGTg7iKL7liGxA9qSR0fshQhRwqgYIGy/7yeAI9HL+pmV
         mVqIuLy+D5l3QNsniy7Zwcj63mnDMD+HGxAJwu5JxiiQJ58QVma9O/CzmlAn6pULXtcT
         xsfTnuBArILLWbsQVXv/0smstF/tf7m7wL58qLwA9cP1ApgnDfMBBzfvTJ4GIl93Spty
         tDljH4JVmfmut7ywmMfsUH0DhHPMfAgqi2bORjzBHmj55gfWDRJg6faKN2ZE0UyVBV0E
         Epbw==
X-Forwarded-Encrypted: i=1; AJvYcCURI0ovlncfLcrylKgqtCbvowa8WmRsYFxNaHjxGozdRclLlXA0nrWHenep/xJweoZ8VYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg7tlnSQJ24V/QgB7xN5aIDDat8jaQD1uqwWaOcl7HUl23ApGH
	CDiRLKtm3zhuTChWjZ5iTNsrgJjcE7zvMIyB5Vu9xsiz9xTaXZ7YgA5qRqsxXVXPAoRiGI7Pmta
	D/45dxNPRaQcJCx/v+1FJqZOF6v2sNFRT9w==
X-Gm-Gg: ATEYQzyrYxX2AKrTNhlUBpXUjVYc5uBWe3RyOo9K+iipt+Qb+K4ustq7IWW+wjKN+zt
	zS4qOISJvpHUJ7RcoZVLoMTNCLC4uGmgBG5TghWmz8XgDhRAXwefvv/u80xOXnotaEoB8/GyLdZ
	cY+PNX6KwV+sh6ODJ+B+6rmGMsoQaohssLopRlwf6miZnRdSP9w95P/UIA4j6HxWeNLVZmlz0Qx
	XzEInKQmHabPtslSRzzYXe4CB+ER8U5j91PH983x5tUtz3AMqnlRvs56JvPpv+UrzVyM/VRqvqX
	d5remdssNUjRoBW85j6cGH28d7SSMkvfw0CzZw7ekQ==
X-Received: by 2002:a05:6102:5f02:b0:602:9977:a501 with SMTP id
 ada2fe7eead31-6037901980bmr2804575137.1.1774519330432; Thu, 26 Mar 2026
 03:02:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Mar 2026 03:02:08 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Mar 2026 03:02:08 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260324-pks-commit-graph-overflow-v2-1-843568cf8780@pks.im>
References: <20260317-pks-commit-graph-overflow-v1-1-e6bee22cd826@pks.im> <20260324-pks-commit-graph-overflow-v2-1-843568cf8780@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 Mar 2026 03:02:08 -0700
X-Gm-Features: AQROBzCBrqjkyU5nqBBZLDGcl2wcq11kHdsAQDRXnJut_87jxeQoYp2s2vnIDJ0
Message-ID: <CAOLa=ZRhLxBV+2ab8_yiENd_mYRZM3W5X-3_5xqnkoxPk+XCRA@mail.gmail.com>
Subject: Re: [PATCH v2] commit-graph: fix writing generations with dates
 exceeding 34 bits
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Derrick Stolee <stolee@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000005684aa064dea7a6c"

--0000000000005684aa064dea7a6c
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The `timestamp_t` type is declared as `uintmax_t` and thus typically has
> 64 bits of precision. Usually, the full precision of such dates is not
> required: it would be comforting to know that Git is still around in
> millions of years, but all in all the chance is rather low.
>
> We abuse this fact in the commit-graph: instead of storing the full 64
> bits of precision, committer dates only store 34 bits. This is still
> plenty of headroom, as it means that we can represent dates until year
> 2514. Commits which are dated beyond that year will simply get a date
> whose remaining bits are masked.
>

Okay so the structure in the commit graph is:

base + 8  => generation number (30 bits) + date high (2 bits)
base + 12 => date low (30 bits)

date = date_high << 32 | date_low;

This can be seen in `write_graph_chunk_data()`, so makes sense.

> The result of this is somewhat curious: the committer date will be
> different depending on whether a commit gets parsed via the commit-graph
> or via the object database. This isn't really too much of an issue in
> general though, as we don't typically use the date parsed from the
> commit-graph in user-facing output.
>
> But with 024b4c9697 (commit: make `repo_parse_commit_no_graph()` more
> robust, 2026-02-16) it started to become a problem when writing the
> commit-graph itself. This commit changed `repo_parse_commit_no_graph()`
> so that we re-parse the commit via the object database in case it was
> already parsed beforehand via the commit-graph.
>
> The consequence is that we may now act with two different commit dates
> at different stages:
>
>   - Initially, we use the 34-bit precision timestamp when writing the
>     chunk generation data. We thus correctly compute the offsets
>     relative to the on-disk timestamp here.
>
>   - Later, when writing the overflow data, we may end up with the
>     full-precision timestamp. When the date is larger than 34 bits the
>     result of this is an underflow when computing the offset.
>
> This causes a mismatch in the number of generation data overflow records
> we want to write, and that ultimately causes Git to die.
>
> Introduce a new helper function that computes the generation offset for
> a commit while correctly masking the date to 34 bits. This makes the
> previously-implicit assumptions about the commit date precision explicit
> and thus hopefully less fragile going forward.
>
> Adapt sites that compute the offset to use the function.
>

Well explained.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
>
> this fixes a regression recently introduced by myself in 024b4c9697
> (commit: make `repo_parse_commit_no_graph()` more robust, 2026-02-16).
> The regression was found by GitLab's tests suite, see [1].
>
> Changes in v2:
>   - Account for platforms where `timestamp_t` has 32 bit precision. This
>     matches logic in `write_graph_chunk_data()`, where we also depend on
>     the size of the commit timestamps.
>   - Link to v1: https://lore.kernel.org/r/20260317-pks-commit-graph-overflow-v1-1-e6bee22cd826@pks.im
>
> Thanks!
>
> Patrick
>
> [1]: https://gitlab.com/gitlab-org/gitlab/-/jobs/13522328632
> ---
>  commit-graph.c          | 37 ++++++++++++++++++++++++++++++++++---
>  t/t5318-commit-graph.sh | 20 ++++++++++++++++++++
>  2 files changed, 54 insertions(+), 3 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index f8e24145a5..cb514bfb60 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1319,6 +1319,37 @@ static int write_graph_chunk_data(struct hashfile *f,
>  	return 0;
>  }
>
> +/*
> + * Compute the generation offset between the commit date and its generation.
> + * This is what's ultimately stored as generation number in the commit graph.
> + *
> + * Note that the computation of the commit date is more involved than you might
> + * think. Instead of using the full commit date, we're in fact masking bits so
> + * that only the 34 lowest bits are considered. This results from the fact that
> + * commit graphs themselves only ever store 34 bits of the commit date
> + * themselves.
> + *
> + * This means that if we have a commit date that exceeds 34 bits we'll end up
> + * in situations where depending on whether the commit has been parsed from the
> + * object database or the commit graph we'll have different dates, where the
> + * ones parsed from the object database would have full 64 bit precision.
> + *
> + * But ultimately, we only ever want the offset to be relative to what we
> + * actually end up storing on disk, and hence we have to mask all the other
> + * bits.
> + */
> +static timestamp_t compute_generation_offset(struct commit *c)
> +{
> +	timestamp_t masked_date;
> +
> +	if (sizeof(timestamp_t) > 4)
> +		masked_date = c->date & (((timestamp_t) 1 << 34) - 1);
> +	else
> +		masked_date = c->date;
> +
> +	return commit_graph_data_at(c)->generation - masked_date;
> +}
> +

Looks good.

>  static int write_graph_chunk_generation_data(struct hashfile *f,
>  					     void *data)
>  {
> @@ -1329,7 +1360,7 @@ static int write_graph_chunk_generation_data(struct hashfile *f,
>  		struct commit *c = ctx->commits.items[i];
>  		timestamp_t offset;
>  		repo_parse_commit(ctx->r, c);
> -		offset = commit_graph_data_at(c)->generation - c->date;
> +		offset = compute_generation_offset(c);
>  		display_progress(ctx->progress, ++ctx->progress_cnt);
>
>  		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX) {
> @@ -1350,7 +1381,7 @@ static int write_graph_chunk_generation_data_overflow(struct hashfile *f,
>  	int i;
>  	for (i = 0; i < ctx->commits.nr; i++) {
>  		struct commit *c = ctx->commits.items[i];
> -		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
> +		timestamp_t offset = compute_generation_offset(c);
>  		display_progress(ctx->progress, ++ctx->progress_cnt);
>
>  		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX) {
> @@ -1741,7 +1772,7 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>
>  	for (i = 0; i < ctx->commits.nr; i++) {
>  		struct commit *c = ctx->commits.items[i];
> -		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
> +		timestamp_t offset = compute_generation_offset(c);
>  		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX)
>  			ctx->num_generation_data_overflows++;
>  	}
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 98c6910963..1c40f904f8 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -417,6 +417,26 @@ test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'lower layers have overflow ch
>  	test_cmp full/.git/objects/info/commit-graph commit-graph-upgraded
>  '
>
> +test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'overflow chunk when replacing commit-graph' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		cat >commit <<-EOF &&
> +		tree $(test_oid empty_tree)
> +		author Example <committer@example.com> 9223372036854775 +0000
> +		committer Example <committer@example.com> 9223372036854775 +0000
> +
> +		Weird commit date
> +		EOF
> +		commit_id=$(git hash-object -t commit -w commit) &&
> +		git reset --hard "$commit_id" &&
> +		git commit-graph write --reachable &&
> +		git commit-graph write --reachable --split=replace &&
> +		git log
> +	)
> +'

So we first write the commit graph once and then rewrite it. The second
write must recompute the overflow chunk. Then we run 'git log' to
exercise the commit graph.

Looks good!

> +
>  # the verify tests below expect the commit-graph to contain
>  # exactly the commits reachable from the commits/8 branch.
>  # If the file changes the set of commits in the list, then the
>
> ---
> base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
> change-id: 20260317-pks-commit-graph-overflow-09c3fb6e259a

--0000000000005684aa064dea7a6c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d7c402ca930ff4d8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uRkJCWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMVU5Qy85SmRRaGRibzErVFFINWxwZzJYZHJjTHk4Ywpoc01SdEhURnhS
UGFxRS9nUXRlem8xY1JMNWFCVWdqbGd4THNrbC84SFl1MW1Jd3UxRUVJa29DWTFLU1hNcUFXCjgw
L0RHRWVndisvRmh1TmJyNG1YMzhtK2Z2Y3g5SXVJV0orZXFETHpYSk9LNW9Ta0wzYXlkdThOaEVj
Ulg4eHQKQytkNVI1L3lyWUgzSWtWRjIrQXZQODRCTlc3N01KVkZFMGhIUUg2MHRWZmVYYmdnVXRw
ejJobG9NR0RDa0hoVgpQQ05nNjNDTVFicGpNdThGcWQ4WW1FaHFxZFJxVG5oWTdCLzJidTVmd0hX
aXhkc0dVbGNHb3J0ZU43dzhMOVdwCjE5RTYrcjdqS0YyY3ZPcjZ2dlVDczNrZ2RkZVlRK2V0YTJF
aFRMbjZ5aUFyeVErSk1RRzdCa3pCT0VHYTJ2azcKcmZ3YXZ5Y2xGSlJOTzBBS1VtNnpPbi84OGdj
Uzg0VmlEbW1RbFZpc0JSQ3N1MHR4MFVialNRRWdwRUhJZ00vQwpwM1FaMXYyWit6ZFB4dGludnNa
dUh6bzc5Znh2bkdBaGhxeFR5bnFmSXJuU3pIMlBKZ3g1N1ZHYzBqQ1gyTENLCkpqU1lJTkJxd2tP
MXc2UEo0V2FROHNoczFoRjlWUVRsUElCait5WT0KPTI1bksKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005684aa064dea7a6c--
