Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793277484;
	b=n9CU1561NPb4wOTJ3c3EuHoa/1k+nGxGFvdmWgPvJvX+FX0+EGudydT9CSg1etobIqpC
	 4F+pkPeu/cRYtOoJrx4as/aW9pJD7oLv1euR+wfcUoLgC4UHh0Or/6i7TP2/QVjLf0ZYV
	 fCY1vY7jG+W9IeecB/egnFT74uw40S8z8oTqrtBXu/DclHbiTrnrBzHGIALAMjLv+Wh+W
	 mA8IXhL3NKuMYhR4cGHXZXg74xHhmscbReTigTGwLeCzr7mxvLkOSwbaiTbSsePH5ZNGI
	 fx+NHfsDZvBV8R3OhHRJfSIZIxxbLpprolVsxAhFyopnUEmhHalo3ydqARiOZd3koYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277484;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1b6YEb2uMWYXoYTlyzkDK59ujSXMwQKh4QUVBp6GjJI=;
	b=3qtxZn5UAyOajDg0XFS5retVFdLDha8tPZf/MiAkHvCjEd34njmD6lgWwwvGhtYb0CTs
	 Xj+E6jtYBum7cSqKz5prPMys1tCIptLxMjbAz3heqKm7Cf2ROZTJXzzmbSIz76VIQhSWt
	 QmFgWan6EIg9qbxDjyI7tS+99JlkhT5tArLaK1lxNXZodMfYL3ctb+qeZEW5Icz/7yAmQ
	 Mml70IIYItFzrnnuvWoIj7q2gsMq9H2UzSBgC57QXjJVy47nKVFkbTSKlaSUOJ6bRwdA4
	 IXHBWkIhl/yuTave97Rc6FZ7dTpGEjAKbnHA1avZa5l9VfZNI13kuIl2kdgR/+yaCpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=i2ypiRtO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="GJlkEdf/";
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5C3606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 12:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E5C3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=i2ypiRtO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GJlkEdf/
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id CC3C11D00136
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 08:38:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 29 Oct 2026 08:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793277483; x=1793363883; bh=1b6YEb2uMW
	YXoYTlyzkDK59ujSXMwQKh4QUVBp6GjJI=; b=i2ypiRtOEcME+9PGAAFfPyQO59
	IFuplj0/6qqcSDj6d3Rrm4DWb4CyEfPczZ51dYdgjzAnvfqFVLareB3H2Eyv0DCD
	OKyWkH5XRn/oLm9CDUzIMLd/g74jqSTM16Td179x9UH6SeVB5bX/sRcNfX2GFBUc
	LcoKxmliUkBofJexIBQOGSb4RQ+B+g0BpOwFWux4MK1EvL3odXaS2vUEzb0Uqgba
	N9+KRNK/+nRPiEWw2k83/y/yKyWbvyMXLJVBIbxJ3rvIB58Jy2cybH/Juixkdc0t
	EpL9FXU9gH4NvfyMp8oPDn47PEnl20r3JtOqJaq1mHOkYeX31p6dw3TuPfEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793277483; x=1793363883; bh=1b6YEb2uMWYXoYTlyzkDK59ujSXMwQKh4QU
	VBp6GjJI=; b=GJlkEdf//BlX0/q65gF7P05EsKZTaGQp63GjBwtM3Juf7Y7LZxp
	bAt3W1zN3qS61ywwo+yaBCn0KmXzcQLrS+9VZrIkGNvLrsd1GBlf7GLYp92lbmXB
	Wj3P3y2FFC3bq72hs498wq9LywBvcpDE/ijmDGwoU2BYyhbqhRR9Zv7oUWcQz4JX
	NI6Pb5yOlqrHdM1OVzd9wUzl5SpFVEWE6llnQLooHd5k8coK3k1al4xnwsu1+0mu
	3FiRAiJRfHVizdD6mA4rXvmczZ4qUPA5vx1Ko5akYyfLBbUTTPZaPftnuJha4nym
	NjdYyNtAyT0Kv+2RwjEj/oDvAgxKr/vz8qg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793277483; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RUBVHu97iJAsLcoOTX6J4tkbmlOee65N52+ldUHJbcP3wl9
	NawhQT3GOl7g5EcJmFJXwjvhk6ebpu3eYr7HOqC3nm/xQpaLvmSAzpX06hNm7fuX
	jeq3LdyZKUiKSGbUBeyufjh3eIfuIIpTyt9b8pYeSAOwg7mSE9Bmj505TrpcVKT4
	MSAduMnpfsDYLkia0UGd4giWjhlAzte0gevMdAOnWR9LoDg5ZJ/38zyVFzpnLs0F
	Q0QMPfsGYAOys5D2so8zp+rpIauc5iiDTAVcthNIf0ni2lvt5PsTLtVqTrun0ngR
	1n3+TOuxy1LyPEVJNIo6a1v5Ye3Vm/LreSXvCOw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:GcLGWRi30Iv5XDoETrQ1QmSS6bAlZ6x1JX6Otn9yprs=:g1B7Nus9UTgTpwRspXjsGQkMwAdz6tmoOoVoSRIZ5zo=;
X-ME-Sender: <xms:Kz7jauiUAFBv0nrLHmdffgtE2z5r7iBszFdDmB-vLPMrWDUgyAc4Ug>
    <xme:Kz7jalB2e-RUUtrNcEb-Z018r2GG3vzeD4Onc-tdtSs7bDikLD7M3WZxSO416WYhy
    Q_1c4_Gl2X1AFucbgY5lHiIPjOofwt9-zAk5o5KYxeAhrO9b39x0gg>
X-ME-Received: <xmr:Kz7jajs25tpOd43t-e3qcZSLZ7Y2Rcl7K9WC2xesT1qOWLSK8H2FaQ>
X-ME-Proxy-Cause: dmFkZTGPFsiypZBDzdcqFo3X3tPH6lHJk+Z1i+9Sa8cjKogymG0cAd/ZO7dEvWL2AxFrIM
    3iN692TkQDXzQYq40ZUFXXujeiI5VgYc2CHIhTGMCtwyWjP331gEcAPHmcHC1aZRF2h9RP
    q8K+3rkqqk5lZ9GK3cNWML/oDAdCmxrILVp1LZoikl7TETrgHCrK8tvZEYfw/8RkbgilMY
    dR5OC+eLZf46YAjWLpgbm6lv/5lOehiDHgruwlV3CVVxyenBEeRy3l26mStb6BGWSSBDGm
    orr0qqaHvw9NKajSgLM2OYDnJWDRIZPStfibSQOrhUiFq2wsGdXuw966UuNeVvfSuriOpj
    627usx/RRS3a7g5AYSu7qCQ7GwpU26bv2B0Nyf/cTW8zpvvWIH/e9/Lq2G/xC8sX1J3Vpr
    42N7kE8i5AzuJf4ZfXGEfNcJ5wkyQXqYSYD2F4GouYQPtuFFsMmeLnNw8k0hVMNdHK7j9L
    CsqwEZjLJN3HW9N7JfSHEvT7EeM3Q9kI6hrNAM1UuV44d6A4CoWFlMJ9Ys+Rcklp6mU+wN
    +dkXHoXvpRse1+Wq/4SFnj+2nkSHeKUzQionsr2K352abCaVAG2XXGT2wTMUG7Bxw3STBk
    BVvAj0mtMr4a0ChIDFVkM7l5YiDBMYe0BRspxQ7wyTtEs8Cx0z7CKXsBTshA
X-ME-Proxy: <xmx:Kz7jaiZi_FhQyY7ZoAtwxbc5rnZ_lX6LNXcF9TyEHdIUYLDjqQDelg>
    <xmx:Kz7jauVrcvy7NnFEkNu5g80zlPvvharaIfkQJluQDaCKNxLYKreR8g>
    <xmx:Kz7jau6ZW_QVMRadA4VlAXb0hne5VZq3jaLPdEBYdTNdmTgii4J2aQ>
    <xmx:Kz7jahgRSX45KJU74ogKkPvjF_kQNtNrMbZvIH7QOwLdtJdIwkTjiQ>
    <xmx:Kz7jah43Cu2duwHIbkaJixHK0PTgfgZyZWykBMdk1ht91H01wo47ONXh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 08:38:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 52106319 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 12:38:01 +0000 (UTC)
Date: Thu, 29 Oct 2026 13:37:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2026, #10)
Message-ID: <auM-JvB3IS8I5Yka@pks.im>
References: <xmqqo6cd5hnt.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6cd5hnt.fsf@gitster.g>

On Wed, Oct 28, 2026 at 08:07:02PM -0700, Junio C Hamano wrote:
> * pw/allow-compound-literals (2026-10-26) 1 commit
> * hk/test-t1467-refs-rename (2026-10-28) 1 commit
> * hn/ci-fail-on-missing-deps (2026-10-27) 2 commits
> * lb/reflog-expire-dry-run-fix (2026-10-23) 1 commit
> * oa/diffcore-rename-no-the-repository (2026-10-24) 1 commit
> * sm/prune-packed-libification (2026-10-27) 1 commit
> * ks/unit-tests-ignore-long-tests (2026-10-26) 2 commits
> * mh/init-show-abspath (2026-10-27) 1 commit
> * dk/stash-completion-updates (2026-10-23) 5 commits
> * je/doc-merge-conflicts (2026-10-26) 6 commits

All of these topics topics marked as "Will merge to next?" look good to
me.

> * oa/bundle-uri-drop-the-repository (2026-10-28) 1 commit
>  - bundle-uri: use the passed repository for refs and tracing
> 
>  Functions 'unbundle_from_file()' and 'fetch_bundle_uri()' have been
>  updated to use their passed-in repository context instead of relying
>  on the global 'the_repository'.
> 
>  Will merge to 'next'?
>  cf. <CAOLa=ZQK_ZjCj5G+rk2Cz+-hQ054uJW6Eq4NEofQLHx0jnnfWQ@mail.gmail.com>
>  cf. <xmqqcxstbx4v.fsf@gitster.g>
>  source: <20261028093455.76247-1-okhuomonajayi54@gmail.com>

The patch itself looks good, but I left a comment there that we can
trivially get rid of the remaining two uses of `the_repository`, as
well. And if so we could drop `USE_THE_REPOSITORY_VARIABLE` altogether.

> * sp/t0001-avoid-pipe (2026-10-22) 1 commit
>  - t0001: avoid pipes in test scripts
> 
>  The test script 't0001-init' has been updated to avoid piping the
>  output of 'git version' directly into 'sed', ensuring command failures
>  are properly caught.
> 
>  Needs review.
>  cf. <xmqqbj8lhcng.fsf@gitster.g>
>  source: <pull.2260.v3.git.1792732388827.gitgitgadget@gmail.com>

Mostly there, but there's a formatting error in the commit message. You
could fix that up manually, but seeing that this is in the context of
Outreachy I think it's better to let the contributor fix this. Also
because this issue was present in v2 already.

> * sj/oss-fuzz-commit-graph-gitdir (2026-10-24) 1 commit
>  - oss-fuzz: set a gitdir in the commit-graph fuzzer
> 
>  The commit-graph fuzzer has been updated to supply a placeholder
>  '.gitdir' to the repository. This prevents early failures when
>  prepare_repo_settings() is called, allowing the fuzzer to proceed and
>  test optional chunks such as generation data and Bloom filters.
> 
>  Needs review.
>  source: <CAOJ8FdeyJp4ZOfp99DBSp4brWzngdqzrkSY36ByEh=4UPw28Mg@mail.gmail.com>

I had a look, looks good to me.

> * ps/odb-object-storage-extension (2026-10-26) 7 commits
>  - builtin/submodule: propagate "--object-storage-format="
>  - builtin/clone: introduce "--object-storage-format="
>  - builtin/init: introduce handling of object storage format
>  - builtin: expose the object storage format
>  - setup: allow overriding object storage format via environment
>  - setup: introduce object storage extension
>  - loose: drop unused `repo_write_loose_object_map()`
>  - Merge branch 'ps/setup-enforce-repo-passed-to-create-repository-has-no-state' into ps/odb-object-storage-extension
>  - Merge branch 'ps/odb-files-alternates' into ps/odb-object-storage-extension
> 
>  The object storage format has been made configurable via the
>  'extensions.objectStorage' configuration variable, allowing users
>  to specify the storage backend and an optional payload, mirroring
>  the design of 'extensions.refStorage'.
> 
>  Expecting a reroll?
>  cf. <auHc9TeCfrCurKTM@pks.im>
>  cf. <CAOLa=ZRWktyBmeeiMbPqnX_OkizqPA2mmGrnTABW7Pkk7DcKpA@mail.gmail.com>
>  source: <20261027-b4-pks-odb-extension-v4-0-5d28ca0ea1dc@pks.im>

The only change I've got queued is this one:

2:  81f6d2b09e3 ! 2:  0f85938a5d2 setup: introduce object storage extension
    @@ Commit message
             allows you to configure a different location for the ".git/objects"
             directory.
     
    -    Making the location of the "files" backend configurable is not he most
    +    Making the location of the "files" backend configurable is not the most
         thrilling feature of this new extension. But it gives us a couple of
         advantages:

I can send out a new version to fix this, but maybe this is something
you could fix up locally? Whatever works best for you.

> * ps/gitlab-ci-whitespace-job-shallow-clone-fix (2026-10-16) 1 commit
>  - gitlab-ci: fix "check" jobs with large merge requests
> 
>  The GitLab CI configuration has been updated to disable shallow clones
>  for the 'check-whitespace' and 'check-style' jobs by setting
>  'GIT_DEPTH' to 0, preventing them from failing on large merge requests
>  that exceed the default shallow clone depth.
> 
>  Needs review.
>  cf. <CAOLa=ZTwyGnWFa4U=8UDzEUuyhQ7jT555FCh-CBp_wos9rJG9w@mail.gmail.com>
>  source: <20261016-pks-ci-optional-whitespace-job-v1-1-f5693fbae1a5@pks.im>

Karthik approved this, CI is happy and the fix is somewhat trivial. I'd
hope that we can merge this soon-ish to fix our CI.

> * kn/fetch-tag-backfill-batch-fix (2026-10-28) 3 commits
>  - t5510: cover upstream info update on fetch failure
>  - fetch: advertise fetched refs when backfilling tags
>  - transport: add `transport_options_release()`
> 
>  The tag backfilling negotiation in 'git fetch' has been updated to
>  explicitly include the in-flight fetched tips as 'haves', preventing
>  the server from resending objects when batched reference updates are
>  used.
> 
>  Will merge to 'next'?
>  cf. <auHfmzP3aXyonp3C@pks.im>
>  source: <20261028-799-shallow-fetch-with-tags-v5-0-7c43cc9ae810@gmail.com>

I expect another tiny reroll, but that should probably be the last one.

> * ps/repo-ref-storage-format-fix (2026-10-05) 1 commit
>  - builtin/repo: rename "references.format" to "references.storageFormat"
> 
>  The output of 'git repo info' has been updated to use
>  'references.storageFormat' instead of 'references.format' for
>  consistency with recent ref-storage-format terminology updates.
> 
>  Needs review.
>  cf. <CAOLa=ZTNNY_XuixqZ96TK0zFfDpWvxSupxVGOnH1VGXK4KF_0w@mail.gmail.com>
>  source: <20261005-pks-repo-ref-storage-format-v1-1-819a181572a9@pks.im>

I've got two positive reviews, so maybe this is ready to go?

cf. <CAOLa=ZTNNY_XuixqZ96TK0zFfDpWvxSupxVGOnH1VGXK4KF_0w@mail.gmail.com>
cf. <as61Dh7ui54gdzGV@denethor>

> * mc/refs-rename-transaction (2026-10-08) 4 commits
>  . refs: remove backend-specific copy and rename callbacks
>  . refs: run copy and rename through ordinary transactions
>  . refs: support replacing reflogs in a transaction
>  . refs: distinguish internal transactions from logical updates
> 
>  Both reference rename and copy operations have been refactored to use
>  the generic reference transaction API, ensuring that hooks observe the
>  updates as unified logical operations rather than piece-meal internal
>  deletions and additions.
> 
>  Waiting for response.  Breaks 'seen' when merged.
>  cf. <asdsIjNEUOpaAnX5@pks.im>
>  cf. <ash-bs4-WmGuLyCl@pks.im>
>  cf. <asmFLjno-vuuN1ZS@fruit.crustytoothpaste.net>
>  source: <cover.1791452597.git.maciej.ciemborowicz@gmail.com>

I think this topic should be evicted for now. I don't think that the
result is sensible, and it was way too AI-heavy without the author
having a clear understanding of what they are doing.

Thanks!

Patrick
