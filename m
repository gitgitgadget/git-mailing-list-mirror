Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551246;
	b=zskTQJvpGARYFGLb0kGaKAAnWDsUj12l/6sQUi9xx/ONaIQSTvli98x3Taw+TzwLBgSP
	 muRP64lvOZXxTg+64NJ8wOECug5OqidJ9EuKon+C4bnqo4aGzznDAe/EuRYXiUoN4W8Nd
	 5utHFsAxSAN17jf9Vi9NXhKfZlg9Ph/AViwPb6uZv3Xhi11aCh93BlDBW+8qWuEkH3vnT
	 dj4DvEfwQzpO008mjRY3vICXxOHFZIxtISHdcZOhbeWu5CcSN6g81GN3HY9h7UbFDKrjP
	 6T3aF7ChL4o/UxIXVN92ClPomINgxM9DcJWMr4pOEelYbks4aInEsZ/Ds0dSk2fqqsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551246;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=lbZAAHllXRpm2g7ahA/Rq2hIGXDw4XMOrq9J9j+Vf+8=;
	b=qbm0AEFNHLFQMwixfURHF2A+4Sivi6C1Yk4f/oSx8ctFxsh6CKTNe7vmtz6Dx2apRqkS
	 5IwlO7MbDZRsFu4sWMEDhAbbYzIjPwMp2GSjK9ZGSjc++XmXeGYlpsFEx/UWJH1sgm9FO
	 EVbHx+nFUpdBqwMBxPTeR43FNBsL/JZmsgahTswA7RDNEbCMCyv8LL4qGWOQV7MRUV9Ox
	 MzoyGAOOJSx1faLrFdteTc1z+BGTB4rkHNj20vvh/FLkq/NXHmYtG4I2t5O9mfJZk21Cd
	 HqJc+rm68RJDyRxSP/8BZPXRso+9skrBYsrMQ7zjFW2XWQ+j/mkx2j/cWj/0yq9jcIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=KjB0zT0+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dF1NyjLX;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2168606A335
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 20:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2168606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=KjB0zT0+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dF1NyjLX
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C52C9140005F
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 15:14:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 24 Nov 2026 15:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795551244; x=1795637644; bh=lbZAAHllXR
	pm2g7ahA/Rq2hIGXDw4XMOrq9J9j+Vf+8=; b=KjB0zT0+9+roGP8ggl8eWV4Gp7
	WUsqqWFZD+U/+ZczX8i6M9kZoDKa6g2tUz1mVnSgxAfNIeIHGya1I8p/Y7H3juO+
	PshBhxLkDzorfwQPjGaqpb+cDTvhQpJkApxpg9rCyh+shQnvlqvYdYfGRu66SJQ0
	qJ05UIFFZ7MIWwDyOmMt8oWOAVANvu6MN6HpIjFI8kovSh4lHLit56dkHonvi8/o
	5AGmBDOvjmOjAHI0ChJyZpcslMyyqF0UgkNEABZP+7z6dnouGK2bvwmwUOTk8zDC
	82nlfohqWetKMkAEuCrOL+1KXXRmXirAXD5xkpdZFQoUUnav62ah9pWcu48Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795551244; x=1795637644; bh=lbZAAHllXRpm2g7ahA/Rq2hIGXDw4XMOrq9
	J9j+Vf+8=; b=dF1NyjLXQsII7jlmT9PiO/GY7GHZ2bz1k3sH1BTOKY9PFpj6LdU
	Ol4heu+Nnop2vff7E03s+vF7Vi9VqfFMaWgALvu+n5rpUaAmv9Sk51GfVe578s4E
	/LtVqOuSWaA1os86oTv6cAZ6M8Cv8sZTlobY0MU1e56T81DDvZBOGgL0ukmJZPhi
	thFlsk5V0EBGm5HxmFdbg/vanaaQKntDBziNHqQ1ZWYh+0mX11Nt8IeB4WBNAl9k
	qzZbsIYHGCJEtGVB1CnpprJBtMDLb2JmtKfBfYUaRBV981mnQGoqT0LJlYjP+wXZ
	J2zELHvYV0EdJikbeGsBGgcBBLQ6twsmVgA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795551244; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:S42y0j1xwFNIMvCfgTMhUa+wV0KDkRXtiEm324bvCPxghwY
	ns2nHIF6RJBOhMrYktpHZSVq6G8MuwVWnvlEC5Kfh5IPIwC2XAIsa9mRUDiOySpu
	mVqMYwrR2zehGJlkasfEByfDoVV74Tf9qk5KiO0kwdThclgBfdTvcfKkj3Ao98UT
	lMFmTDJeAcB+knASAjyLfKAzQxIREiuMudf9kl2oYWwD9kDKg1YaWaKSKmYd9kdM
	Y/kNspHinwbb/CeM9OKjQqLtJzJ6NCOnRISD/tYuObDvFj4Ztda9gOlYjNlfxk83
	mwN823Aoc8qTkcmp+Y9RJwMg/qGPGJufjOQFIWQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:sZuHq+mLADzl8nzrE3wXfM06V01kTzMTIwDiTJcARLw=:PBtEv1RfC9jXjhoJIkVd8I6ZijlrEIZFIZZcYB6shis=;
X-ME-Sender: <xms:DPAFawcJwnfLO6S4bWa6hi9pXsOhfSPnjsyJn-c8kYdEr6VdWL__5g>
    <xme:DPAFa5PiXBlHEJ3Ch8zeYtNijra4TBLB-UhLcYW9dWJHMYVch6NGj9Qzh71X8Ufah
    vqLTPSN90d4ygPQfEHZf04ZCvkXhHpZll9mGDVkxaUXRBDJAm-c>
X-ME-Received: <xmr:DPAFa2iYigcabyqK7YYpKwkhKVkzlDOj13tAJCkg2N1jCdY4uaGjRGPrwv8A6w4SvYSKmdqV38H7La_aRXfhMqUPpzPGybxiHQIRXjU>
X-ME-Proxy-Cause: dmFkZTFPdiWTJZV/sj7JKGzIQNLSgkPOystvDiylYkcvahV7pKEmFQFwOpiLrV97IK5z6z
    JKBKBjdjnEsxRsC/XSoke7E9/GWf1U1K65+mZs4ITRNQ0ZUmW4UBhrgayGTgqysjD4EkRT
    SuZXCylqFJ+4L03UUCnNgA2gWjeO2XvgLJbXA/Hf0E5CafVH+mkVQ6PYHaGPbK9Cdgkg0y
    +7JheMqcSKczgfYbp07tZkPX0bRJX50a0oO6OYTNS/rTxPnKYgD0bBkgypcRfgVqa6zBf+
    V26tvj8m4Qr0hV/Qmy7qQCtcguZgT5nnBpxMhFnufJb8wnD9cEUP+re7JTOvlk2rUkwCTC
    j2hlP5S9x+DGx9RuPDbbL0IbOZw9jSb8iHZZZmTdNST7QLDYSs1dJDptAA91l2/tiNkFxz
    IaypbWeWjqpTzwXRK/cc+WGb9flLM7fqMdy3YrcijtbnrOOOP9ltCye528Uj/zl8c3DLrq
    YdpTk/4L81adBTTTcI62FFkZJf6wbMSqHrK8slckDRhuEzSefZU7/vHhtf6mUd96GFcKcv
    F6Nsl7nrp6V5BRif50/p4on8+S+0eiB3StrqmmuD+um8WS3xqOorJAWC+7CSiBzNyTFISE
    9Ue76Ci68COh1ORgvQnvASbClOfxBEsjTq5PsGDxHiGMLmo0Sf9cV3o+q+QA
X-ME-Proxy: <xmx:DPAFa01i8EPKqLwJvIWB0RNK04RPuGiP2zDTsTMEUM-E3zf96golAg>
    <xmx:DPAFa4g-6PffsRcS9rZT6LiFusEA6ZE6QrrKFnpO4xiP1OPtXwFSyw>
    <xmx:DPAFa8cdBxoVNQgBvWM7RiTPTAqgcuGFqvUd-JPdTwI_03Nh9HLg8A>
    <xmx:DPAFazmLJweVOcdYtnyqCH4DPdkz47e87y7CT4DLvYIVZ-LTvWLubg>
    <xmx:DPAFa1eSR5UqE1YdbVn5a2zW8kmookvXA-HB0_2CLWA4zlRyAObnhYRP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 15:14:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v2 2/3] submodule: store settings in worktree config
 when enabled
In-Reply-To: <e816484923b0adb741aec4a36eb5b126ba02a31f.1795273853.git.gitgitgadget@gmail.com>
	(Yoichi NAKAYAMA via GitGitGadget's message of "Sat, 21 Nov 2026
	15:10:52 +0000")
References: <pull.2306.git.1794484985.gitgitgadget@gmail.com>
	<pull.2306.v2.git.1795273853.gitgitgadget@gmail.com>
	<e816484923b0adb741aec4a36eb5b126ba02a31f.1795273853.git.gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 12:14:02 -0800
Message-ID: <xmqqmrqyoulx.fsf@gitster.g>
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

"Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	/* Set active flag for the submodule being initialized */
>  	if (!is_submodule_active(the_repository, path)) {
>  		strbuf_addf(&sb, "submodule.%s.active", sub->name);
> -		repo_config_set_gently(the_repository, sb.buf, "true");
> +		repo_config_set_worktree_gently(the_repository, sb.buf, "true");
>  		strbuf_reset(&sb);
>  	}

Mental note.  The is_submodule_active() function is designed to take
the path of the submodule, and not the name of the submodule.  That
is why we use path and not 'sub->name' here.

A submodule's name may not necessarily match its path (e.g., you may
add a submodule 'sub' when it was at the path 'sub' and its name and
path may be identical, but then you can move 'sub' to 'mod/sub' and
now its path is 'mod/sub' while the name is still 'sub' to preserve
its identity across such a rename in the superproject).  We need to
be careful which one is used by which API functions.

> @@ -1673,17 +1668,31 @@ static void deinit_submodule(const char *path, const char *prefix,
> ...
> +		if (the_repository->repository_format_worktree_config) {
> +			char *key = xstrfmt("submodule.%s.active", sub->name);
> +
> +			repo_config_clear(the_repository);
> +			if (is_submodule_active(the_repository, sub->name))
> +				repo_config_set_worktree_gently(the_repository,
> +								key, "false");

This call to is_submodule_active() using 'sub->name' would break when
the name and path of the submodule are different.

It would also be worth covering a submodule whose name differs from its
path in t/t2405-worktree-submodule.sh.

> @@ -386,6 +389,26 @@ static void copy_filtered_worktree_config(const char *worktree_git_dir)
>  			error(_("failed to unset '%s' in '%s'"),
>  				"core.worktree", to_file);
>  
> +		/* unset "submodule.*.gitdir" */
> +		for (i = 0; i < cs.list.nr; i++) {
> +			const char *var = cs.list.items[i].e->key;
> +			const char *subsection, *key;
> +			size_t subsection_len;
> +
> +			if (!parse_config_key(var, "submodule",
> +					      &subsection, &subsection_len, &key) &&
> +			    subsection && !strcmp(key, "gitdir"))
> +				string_list_insert(&keys, var);
> +		}
> +		for_each_string_list_item(item, &keys) {
> +			if (repo_config_set_in_file_gently(the_repository,
> +							   to_file, item->string,
> +							   NULL, NULL))
> +				error(_("failed to unset '%s' in '%s'"),
> +				      item->string, to_file);
> +		}

This code is trying to copy the worktree config, but this removal would
not work if the file happens to have duplicate 'submodule.<name>.gitdir'
entries.  Perhaps use repo_config_set_multivar_in_file_gently() with
CONFIG_FLAGS_MULTI_REPLACE as you want to unset all of these?

Do we need to say something about how various 'submodule.<name>.*'
entries this patch touches interact with 'extensions.worktreeConfig' in
the documentation, perhaps in Documentation/config/submodule.adoc or
somewhere around there?

Thanks.
