Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312541;
	b=ShzBNkTErIFQbHG6flgH4okmaeE7MiPMNL7Y1K7R/AyY6+fAQvEeuOk84316Vd7YQ/bJ
	 KxND+jxVssDoTVqqJ1a/AKOUkzEq7sbZD1YAemB0hp/z79xdHk5vJL+jJBUVct6ICs+7r
	 IBTnD+0Z9p/Cl0vODEVqb7Qi+0otMa6DLbFfdSh2+B+R+oOgakCNs5MHW9rM1r7fcDWlp
	 y1iaX4VqV8RKSkPBcR0bddyNLW44GFieBmT/11gCFRslHMiu+VoUHuR+WdXEW4E2+4bwq
	 FvbKYqzQPWXlBK/u4WtfjTdu3h/yZRf+YApaOy4YT/ucVf0/GFZzpPocIsxzErOcmEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312541;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=5HRKbWjhB6QMRjYv0So1tWQ0SFakITJhdyyW6STkRsY=;
	b=x/um58kxVm6Qqe55Sf0jECZLl+GO1gHj8jOV0vlKNK2Oez4fsOc2YvUpkZQ4I93e/W/S
	 DeOLYmYUPnqaHwkTtWFVTrReBuvkUb4Jqrf8C7HHgiY+/LVa899sjIj3gIHAxN3smEb36
	 S+CVMMsoCsA4q2NKTfDlGX74x8Bk0yibcLhRxcvrOgOQlaxdnILuicqycm1k5ueWI61AH
	 fdyuCHm6xdpVOuLrWlPRHuRn4f/LSzmx3cVaXHpKWpP3PKKOgbj6Sd7ZQv+mom3LNlgC4
	 s/fuI4SKsNOBSRMXkLPaMZNpsrTYk7sk1dB2SL7ehHIfA2dgsxwXOihNpM2IXnSaMZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=C9xVL01s;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hDUAGsKc;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21694606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 22:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21694606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=C9xVL01s;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hDUAGsKc
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F44D7A00E9
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 18:22:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 29 Oct 2026 18:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793312540; x=1793398940; bh=5HRKbWjhB6
	QMRjYv0So1tWQ0SFakITJhdyyW6STkRsY=; b=C9xVL01suO1RrSOnTlCVUoGwlV
	iPTphPdteEUNdwN9+srolKRZSAyfixXhnsCIO3IjgZp95CXaOBVm33DF91zayN9t
	nMLUhJfyvSo1Lt1g8ORO1bR4mn0QgyvpJUfyk/WfU2I64CSL8OtXotEbUQEwDM76
	bhwDMLismT22BGoSrOG2SjkNAsA8U3JquRcpkcjyHfIHly6C4ga418a8XKmnnUQh
	EDvCus2ECSh60whNZybjunQV5THwF9m4sxeEa9kADaOJF0b/nJ58U45VrfmCn97A
	VeDzzS2rglvJ9km7kjqtGDk2uClGTfjqlcGJs28MgjOQ56ND2iVYlhWxrkVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793312540; x=1793398940; bh=5HRKbWjhB6QMRjYv0So1tWQ0SFakITJhdyy
	W6STkRsY=; b=hDUAGsKclvhTi0xxyVbUhOAuvfWWkSlypVofAFCpiD+f6zwIkvv
	pt1cFXx0UPACVwig9Ef8D2PP8t/8NViGpJJMAbhjnDBTjPE4N+TGztAjgr2LF5Wl
	NuPlU8++VIPwVmHTPjH+qntqNqqJ58VZxTyLrS+AUp5y5h4TH9fhWNy3qbe7mgam
	AgdUTjfbm9XeAn1Y3S1ayH3CedGFraUgbYw2rySH9e7Q3sVf9DBWTCxBH5NNxTEi
	UJ8PKDxApjlr47Y34Emz1ym4Th6xmZHbWFts7NHQ/3/V2vsjvUTNBcrDaBYYjrDp
	1UqgLKuBlhhRK09xXe/cbaGmL+FSH87+XCQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793312540; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ksCQvZdjKRf4owmWoCLqhp+KiB+KtCa8ZTJFWYIpApqr0nJ
	NZowmQm6njDw28PkT+ym28myJ6GMS9JFvTYmCKRCVlOiayYQxHMIeNspcMWb8bj2
	BOhiL9v3L8PPzbxu6+HYfpZ4xa1lkmrchIrc9vtw/lAGk1lmWu/Pg0/l8BmKNDEC
	Y6l4HnG54XL/0cTtnbOHugcYYVMILR6+th7rmKMQfyaTK+A0vSN0Dp5CBzDMxEa/
	PgcTdL33/UQGs0/aNtUlF68oIWfADOP6NyatAqZp5sg0vFh6Y1LfYetshTMPWGUK
	pV/7gB7VX0hdj6QtUlXj6wc99uq+YKhle3ZvMow==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ZGbS6WPxBEdZ08M/EDLUJLyDHlHUWvrE9EgIIW97wF8=:pg99NWVWzcnQSr/+2FD5v6jOPcyppwT6x8BsS6MD/7Y=;
X-ME-Sender: <xms:HMfjavhSzEjVvsy0EzKBG4SFb2bb_r4WgS5RU0m3uH5YhBcWahowaw>
    <xme:HMfjajcb_M8VPwXr1Y5qfaTLFVjhCQ5WSxBgONFe_eIKEEHNxfIYmuWbr6Mwx8SJm
    8mNW7A-ScXsrDj2EEesz6j4hZXlB_QXfXkWp2Ck3bXw5jPfSemmK60>
X-ME-Received: <xmr:HMfjascI_QurhvdQjqc_MQOEZQy-t_vGQqnm66HnIrz4420G8xu_GVGOFHzPbxUYrSLcs13eTOheBQRtNgHWYNBw5e9zf7UTz9-9>
X-ME-Proxy-Cause: dmFkZTF482+fiNh4PTttnboPClvLqbsrJAixXrNYri57/S8QOJbRq6yp7dcgLHxNaAeonx
    IVDe0Ve/CX+KGAe7NWfONdArrfs88XkStcU4o/PW0rVDNhpE+dg7MV5nKsG+MBybYiCOQ4
    kZZax9kT9uHwNymH2waRjqVfY2+mj6mHG4TgTCvQdFwaLzTdZd1P/kpyT5appEHAiCNaFJ
    ZLLHWPuuuqfxrsP7vYY9gCtSxD3MiESmGCFnLUy/p2YKgvmxke1VLDJ+CvUCmUJCS1GcJN
    pOY8gpLkbMfaZUvx/IW6UO2uKnod3fH86u5vhU17k40ALAmknglZBlvpuJ5QS/djAa+EJT
    A5I+kt6RcQFZKJ90c6AvL088/b/mz6xuFTSrN80WceYactW5jTdz2FCXl3QWBYSa8mYXPt
    eRvFD5OXV55EdHAb3CHUQE93g3NNnLIAQT2PIsuogA/STGoPs1i+dl00KeF6hVvaIhMwSm
    TEppG7DzfJ6LnFznYWXlcoLMHJGm2syOvNESomhYYn28cRb95tQVqX408UqAzQul0y0rRq
    vLuPwkT4xvXmetSrLgCGvTKpe5uKLVAvZOt0k3UhBPfiLotWHaSH7csluZ9t4kftlDsBvk
    /kuYDAntEi+omtIX2eClZjbjGsLQzKH4jZN0F9SnS74IjiK43/L3Vrl0n12A
X-ME-Proxy: <xmx:HMfjal8K3gIyqaInavCJ8ubCWcqhHH9f2WzjBy4SgblQ-VfIXKX0ww>
    <xmx:HMfjaglA0RE3c02QdmDMW9Wb5jnWaRmHhn_xAelIxWvvORiYr2_6og>
    <xmx:HMfjav_afXYnwuyLQVJnGnQDmccN67_w_nL3YNxXMnm0sX3inCyPug>
    <xmx:HMfjamliPvkE7He6f63-V_WGCXwwC8Z_TdzoANYFpjv2-q4WBWMRlA>
    <xmx:HMfjarlwULziy-OzallA2wGrPOvWsUCykuqIUqfcOxvBKglaGlyUN2Vy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 18:22:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2026, #10)
In-Reply-To: <auM-JvB3IS8I5Yka@pks.im> (Patrick Steinhardt's message of "Thu,
	29 Oct 2026 13:37:58 +0100")
References: <xmqqo6cd5hnt.fsf@gitster.g> <auM-JvB3IS8I5Yka@pks.im>
Date: Thu, 29 Oct 2026 15:22:18 -0700
Message-ID: <xmqqecd8ywo5.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

>> * oa/bundle-uri-drop-the-repository (2026-10-28) 1 commit
>...
>>  source: <20261028093455.76247-1-okhuomonajayi54@gmail.com>
>
> The patch itself looks good, but I left a comment there that we can
> trivially get rid of the remaining two uses of `the_repository`, as
> well. And if so we could drop `USE_THE_REPOSITORY_VARIABLE` altogether.

Yup, I saw the updated one, and I agree it is sensible to go fill
the last tiny gap.

>> * sp/t0001-avoid-pipe (2026-10-22) 1 commit
>>  - t0001: avoid pipes in test scripts
>...
> Mostly there, but there's a formatting error in the commit message. You
> could fix that up manually, but seeing that this is in the context of
> Outreachy I think it's better to let the contributor fix this. Also
> because this issue was present in v2 already.

Yes.  I think v4 got rid of the empty line in the middle of the
sentence.

>> * sj/oss-fuzz-commit-graph-gitdir (2026-10-24) 1 commit
>>  - oss-fuzz: set a gitdir in the commit-graph fuzzer
>...
> I had a look, looks good to me.

Thanks.

>> * ps/odb-object-storage-extension (2026-10-26) 7 commits
> ...
> The only change I've got queued is this one:
>
> 2:  81f6d2b09e3 ! 2:  0f85938a5d2 setup: introduce object storage extension
>     @@ Commit message
>              allows you to configure a different location for the ".git/objects"
>              directory.
>      
>     -    Making the location of the "files" backend configurable is not he most
>     +    Making the location of the "files" backend configurable is not the most
>          thrilling feature of this new extension. But it gives us a couple of
>          advantages:
>
> I can send out a new version to fix this, but maybe this is something
> you could fix up locally? Whatever works best for you.

Amended locally.  Thanks.

>> * ps/gitlab-ci-whitespace-job-shallow-clone-fix (2026-10-16) 1 commit
>>  - gitlab-ci: fix "check" jobs with large merge requests
>> ...
>>  Needs review.
>>  cf. <CAOLa=ZTwyGnWFa4U=8UDzEUuyhQ7jT555FCh-CBp_wos9rJG9w@mail.gmail.com>
>>  source: <20261016-pks-ci-optional-whitespace-job-v1-1-f5693fbae1a5@pks.im>
>
> Karthik approved this, CI is happy and the fix is somewhat trivial. I'd
> hope that we can merge this soon-ish to fix our CI.

Yeah, the CAOLa= message is indeed the one that is happy with this
change.  Will mark for 'next'.

>> * kn/fetch-tag-backfill-batch-fix (2026-10-28) 3 commits
>> ...
> I expect another tiny reroll, but that should probably be the last one.

Replaced with the updated one, and noted your <auNReY6zQ5x7tlbV@pks.im>.

>> * ps/repo-ref-storage-format-fix (2026-10-05) 1 commit
>...
> I've got two positive reviews, so maybe this is ready to go?
>
> cf. <CAOLa=ZTNNY_XuixqZ96TK0zFfDpWvxSupxVGOnH1VGXK4KF_0w@mail.gmail.com>
> cf. <as61Dh7ui54gdzGV@denethor>

Indeed.

>> * mc/refs-rename-transaction (2026-10-08) 4 commits
>> ...
> I think this topic should be evicted for now. I don't think that the
> result is sensible, and it was way too AI-heavy without the author
> having a clear understanding of what they are doing.

OK, let's.
