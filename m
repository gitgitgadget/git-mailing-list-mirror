Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793131816;
	b=2+QQ3LZyPn0PBiGuuT+sUoZrQnRygsPZp00JRAEScNVNn64bkVKo+FEOzNCT9J1K04ck
	 kX9MWCTxgNxjrZPkSb7HkvT8KyEA9DcBD+tr+8JbASFPQ4DY2DbWeNxqtSx2J2ZvtnUIi
	 7RRwjx5yjkrezdPgmLHKFsVKFTzAmT5YlhOPLYW9klUaWCIRoovQuCB19Q0UA5dnp7nVK
	 AisHldJyw/QGLDHyY2qi5XKAp3p+YWACtWmdhwPqszRUrTQpFFhNw/KYGEn+IL551jyQ+
	 VIQ5WTKKd5Ez+G+PgRREi4pTq8L+xGISIEhnDR57CzWSV7C15GC6XdVRtC7JvArkYTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793131816;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=dpTK4aq/FWX9SP6hJp0zOOR3isZt72k/Ui1jVesfe88=;
	b=4bD0KQuGNMLho2vpUGCIQFCnhpHVbaqmUZLO2p0+VBCUgMlTreYgL3YXZtpIykfMPmZC
	 dMjtKPAqTgSa8XU1Ol2McBmQdATC0CAYJIo/g1uhGk3rRfSS+UZj6B+PMyZbb9lzu0omr
	 +TIgU2v1iZIHYUbHTAxQAseBq/OPH2jyLX2SAvQnlydaoMHXxyhLYDpl+/J4XCT3b5nG/
	 81694FzLHtMNXKBvQo65w/A0n5INrjCm9hxF+WQIhrhoqn7L+2S4htBqoTCQzborzHOZ8
	 NpdJknvWrfwJVd/VrsWMZx4yc2cMtcuECbxlufK3NKrazrXNghobqP0yjF7khZkDs3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=VuFmkR7L;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="HVKAN/6J";
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C467606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 20:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C467606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=VuFmkR7L;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=HVKAN/6J
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F1AF7A01B2
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 16:10:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 27 Oct 2026 16:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793131815; x=1793218215; bh=dpTK4aq/FW
	X9SP6hJp0zOOR3isZt72k/Ui1jVesfe88=; b=VuFmkR7L1Z+FaUVYd1cvfzVJXg
	5soTZAUF+0vlJNq9+iU4cKFctHC13+oNIdwzYpY3KvAkisYY4UvwxORCngtYGVR+
	jdKfycQPe/ybbQiFp0Nkt7rwuy/DOuRso58XqlGZMHSdw8NDdGsB+qFAhIvpzPZS
	wOum6BjIzQZjaDWVprf+4bKINpLdaKI6gfJFrheq59uFXXBFM6PVTOFDICmd3J8e
	fBh5lmQ8DMaClyA3mdKdaLpBGrZMxHUyPEdwR/4Y+c9HqPzoNmLV0uK0DhuT5cyB
	4edSc3J4p62uKhN0kqTUVI6hJqB28PG5DZ3dSPez9xLE5h0jILKdxe1t4f5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793131815; x=1793218215; bh=dpTK4aq/FWX9SP6hJp0zOOR3isZt72k/Ui1
	jVesfe88=; b=HVKAN/6JanV3U7piwP/d1ZOk9ZOhltGb5eApG0m0ilbSCglOvjq
	dpMLrp4D9RRvFDADbaxIl/1DxWd0UJKrbOHwMW1qOuPuaDCEeNaPHrs4bG2tlvPI
	l5Bph02M26WNLhxgdJXf47XNixnv2pQRcR1vnCjbUyAq0J811eBH40obuO017S3/
	0NXLnyl3+0WrAXH7uG4OhMmwIvfmlCtmLhsXXgskBHECVpHk2xicQWdx1VKXAqHv
	/B0SSVaQROY6GJojy+Y+Qmc0YSt+eKKVfMlixWR4AJ5WwBhgQml6GjITToottJ7L
	VQOskH7VzIqyb72Dsh6toSee211Q0xDrWYw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793131815; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:DA7nIcvJm/MaZiaK9MTqs+7FvxI77f9wkm6lDA0Msll13G0
	Y3F1X3WH/NQVU0gbmwam5Q4pJkenDGpsyIL2lZ7o7cRZNYHZLO+gWV/iZC1cBP/J
	4s/yG6YH62az/1VdOg+H/z3PHNhuaHNIC+y1dHukKeBLZ6sn8v9mz9LUK2F0rax3
	MZCrJwkJyqhEH78B0deAoOCDTXNkUmexWPdJeM53wY0GIWlbt06Qdxq9DsjucLpn
	/08AIatGCbz0US/kMFwU9qxGgkjOTpeWKk0U57OUKkTdBz5YcNoEx+YLuyG8sgcI
	olmf5DuGKvUxAALWeEV1mEnElZNgxZL7A8O36/g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Sasug2K3w0hx4Ej8qdjsvTbCR80QqdJWL3Yb1xX/WCI=:m+UN9+CuM5VnS0gms9Dte2+Q55Tf3tEtLR7620ijfEQ=;
X-ME-Sender: <xms:JgXhanEuu5eV-NyjbH3UmHWWtriRKxev_gT7tCnK5Vk6gGe60CbcBw>
    <xme:JgXharMyxa-IGWSqFrVfZYrPkBc4MvbKXlbcCEJzF5cRG1aSD6x8sxYP9BEPU_kmp
    A27AP7jHtqbcH__MrLjYi9t2mMgWehvPFOHZiZX-JIqka1f4ecAAv8>
X-ME-Received: <xmr:JgXhahf7mZwk3NwCEgzTtSu0mxnzJeT2TJn3JKj_CUxCN1AwtCWJ9LziriAmB0QFXJxUaIEJbnL4qtz38-NTETYO7fvhOBl0XUKR>
X-ME-Proxy-Cause: dmFkZTEnBuhKBY2tFhRsEG5DEmY88Ai1EWZXQQGBeUKnCbKP1VokL5qVqHzpXZc0JKSyEg
    VB9W6OHmy1O6IsF5CbBPkaVEmLljjraIG8V8puFGFPJfctWjxxWhoXs+OOrVi83XGaUh6D
    GCHJt9bLJ1IR727ZlsWEIytnWZ2Tewuoa5ez/IBl2gPvINIx83y3yRbyS77FheF0EM6J9K
    O7O3dNLVgLFi2ToVm6Ee1vpSkXq42oLzQSgWf46vy4AnLlxruE6NXQSXRNzsJv5AeBrZOD
    Qc2QClpcXx0Jg2mJRsJ680k2Sc/TLezzFTWlLv1YGm3xEjWiD6Lw5psGqM3yxe3Whc5ssg
    8hq5qs40CaULOolj38QsAxuMuO8vtk+4/2wyhrpFMvUKoZ4AizspbC5i+nQ98YdJFHrZDC
    eCb/NFL2L+OrDP35w3rI7rCU8TzYcpwSGxa/DvOQjFJ9bNOaqF8mWSzGLk4XlmbWLiyxFW
    emGR/arqNFgbSCJPYAwEQDeQosPm84b97jRhspEIA2oi2yDISG4GOGKJyfM2/zeqiiytfO
    a5MaNRzlTN+zrUfXfQ0ACUPN0RnEvFRmS3Qo9V/JCV1Usv47nHxEP1fKxYPZFayh1ogCxx
    vkx6ji3ogMx8nwO1stvDvuP0vk/LXWkpjxvVPTq2CJdlGvcSdff0q6h5uXEA
X-ME-Proxy: <xmx:JgXhagu9-_WFz5VKo-_7ijSw23P1XyWC2HL5YUgD51a2YsWhBjkQZA>
    <xmx:JgXhaqkcQe3agUlKGo5POnhvEP5k8NWkf0zoot5rP4v9YJp1tZYLZQ>
    <xmx:JgXhaqxjQYKn1B9QjUwsn5zrzO-Ukaom9-ufSmWN74VDN5xFOAoQrQ>
    <xmx:JgXhakNALZZG_G7vsksHxZVykuoSqZ_-zNyJgnfasYBoilxDKl16Xg>
    <xmx:JwXhatLKDBvnoBIeGM9_13ma_PEsUjIJkX4wQBuyU3AQj1xm_Q5gpSR0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 16:10:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Long 76 <long76.git@mail.ru>,  Matt Hunter
 <m@lfurio.us>
Subject: Re: [PATCH 2/3] sequencer: remove REBASE_HEAD at the end of a rebase
In-Reply-To: <ba13c74698d2af3bd2ababbf2ff1a9738a81d501.1793098652.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Tue, 27 Oct 2026 10:57:56 +0000")
References: <cover.1793098652.git.phillip.wood@dunelm.org.uk>
	<ba13c74698d2af3bd2ababbf2ff1a9738a81d501.1793098652.git.phillip.wood@dunelm.org.uk>
Date: Tue, 27 Oct 2026 13:10:13 -0700
Message-ID: <xmqqh5i6j462.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
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

Phillip Wood <phillip.wood123@gmail.com> writes:

> Several existing tests are extended to check that REBASE_HEAD is
> present when we stop for conflicts and is absent when the rebase
> finishes.

Good.

> diff --git a/sequencer.c b/sequencer.c
> index 2ac78e15b89..2d6a5f525c7 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1781,7 +1781,10 @@ static int do_commit(struct repository *r,
>  		if (is_rebase_i(opts) && oid)
>  			if (write_rebase_head(oid))
>  			    return -1;
> -		return run_git_commit(msg_file, reflog_action, opts, flags);
> +		res = run_git_commit(msg_file, reflog_action, opts, flags);
> +		if (!res && is_rebase_i(opts) && oid)
> +			refs_delete_ref(get_main_ref_store(r), "", "REBASE_HEAD",
> +					NULL, REF_NO_DEREF);
>  	}
>  
>  	return res;
> @@ -5178,6 +5181,8 @@ static int pick_commits(struct repository *r,
>  	unlink(rebase_path_amend());
>  	unlink(rebase_path_patch());
>  	unlink(git_path_merge_labels(r));
> +	refs_delete_ref(get_main_ref_store(r), "", "REBASE_HEAD", NULL,
> +			REF_NO_DEREF);
>  
>  	while (todo_list->current < todo_list->nr) {
>  		struct todo_item *item = todo_list->items + todo_list->current;
> @@ -5206,8 +5211,6 @@ static int pick_commits(struct repository *r,
>  			unlink(git_path_merge_head(r));
>  			refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
>  					NULL, REF_NO_DEREF);
> -			refs_delete_ref(get_main_ref_store(r), "", "REBASE_HEAD",
> -					NULL, REF_NO_DEREF);
>  
>  			if (item->command == TODO_BREAK) {
>  				if (!opts->verbose)

The patch is a bit dense (not a fault of the patch, but the blame
largely lies on the overly long functions involved with multi-level
callchain), but the idea is that the existing removal in the loop
inside pick_commits() may not trigger if the user resumes (via
"--continue" or "--skip") with an exhausted todo_list and that would
leave the REBASE_HEAD file behind, so we remove at the beginning of
pick_commits() before entering the loop, and also in do_commit(),
which is called deep inside the callchain from the loop to handle
one step, immediately before it returns on successful commit.

Which makes perfect sense.  The new tests seems to cover these cases
adequately, too.

Thanks.
