Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792609876;
	b=qKkn/FojyuJ0GdBHqv+94qFKsOovpRf3OtC6Ao85+8cPg7VSlS3bNhfqVjVgt9X/fEhz
	 aQqIywE1antFEH9b4lqlu4sa5WLmnkUf9UmUCA3EWFIHV/euFSbbJNsOHuVZ431qJWEP8
	 ujW0kK9gRREb/4J9qm3IO8hm7lhjyFRPM4znYshcpAcpAFHj01PQu/tWlp0iES43zjnFf
	 Ulwjiaa374Og8CaCdThkuACynU3oy+Qo7HwR6I7PEm4CxOBV50qTulesyyOxy+SKsx24o
	 xDygAcD4kXXYCmtd/uq3nAFtawThOYtfz6oHunzLxjsOoFau8m/ZQ0V+M9E8LhJctlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609876;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=AhNRXTX2gmpxIMjTU1P44DAUyrBoDEvxlu+2kdnVowM=;
	b=o8X0J+uJMCMcGMiIZdI8bW4+ZfcV3PMWliEYCIjoQR5Jk6rOEOCsBHt9PhbjKfPssGmy
	 quf00ukhnLsxWGOc+bwn7NfhteKnQvEx1L3opp1iOD99GP+HZdZrndqgtXz0W4Lo42VK5
	 eN46ZByJBACtIAxWiO5QIDphheod5Y2zLB79v5d7U23zrneln6XhKWQhp0/Dg1w79AFdI
	 Rj3DCIcmQdjIWUPRYxEklhLnvjJBOBO/wBhaNccRhB5f2SxQg9mbSU5uZY1VHvHC8JSih
	 gfvx047ZnjyGsbBUb0e9tom1se09GkOTIGrp8TokmU4s5YOtDMN7OTJAzh+e9+3ozow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ip17ZLNE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=a3a6vH2W;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EB3606A31B
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 19:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0EB3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ip17ZLNE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=a3a6vH2W
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3FE267A00E2
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 15:11:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 21 Oct 2026 15:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792609874; x=1792696274; bh=AhNRXTX2gm
	pxIMjTU1P44DAUyrBoDEvxlu+2kdnVowM=; b=ip17ZLNEPPe/IQUuuJB3s2bhIr
	xRpSYYNafBfX8CiKa0Zpng+3hFturF1/BwJl86p/l5tUfyftZAO/cc15A6Q4B0jn
	5SbyJQxn1Pqtu7CKjRM0okUrPq86BVdxmkNryNV9/JN23UDC1p0RVELiNAlIek7w
	ehA4XFnqdL96HNd6h+scCaZimzyLJjlxQ07VAQqox8FeWHACeS8ZAUXGehRksUls
	xx3Od4tY2y9eeWrJcAzm0Ek3Eo7rF28p7eRO5D3EgqDYWEw8nMRpcF7ycqq2/eZ9
	Tm2tvDiMAbRU7FYOfIb+tTc1pSi1t6LPYGhBdSDLjZ/xKrBE7ydL3dSa0SOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792609874; x=1792696274; bh=AhNRXTX2gmpxIMjTU1P44DAUyrBoDEvxlu+
	2kdnVowM=; b=a3a6vH2WuzF7qniVLh/TuclhDVJgqud9P6NfgMSOBOe6Qbo4Bvg
	lUl/AdAfGiOlVnfHYJhtJkSjRMC+9so0y6YZtVE6MEKMJyr3rEd6oupJ8ddY8pi7
	PnvwjQPAgkTzQS+7TJPqd73zz8LzIWCLdGXeQ4kT6HPf+xMmbB4XU50eSjGE43/y
	W7LPmTQAArxDsakkjLO03UpNGS2nID9wYQ3e56KpMadiGjqA0LKbyNiU5MNdAypn
	G5+xDzuKKtYpSVrPKl2FUpJhJbVP4hrfUCeFNViJBlfX3DuMlcc2gfYQweQXbxA3
	Pq1yvtYRrmB6tjWM12a37qgKk4O3ejg7fBA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792609874; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:DHpyxv0aNao6dpwWNzVNJGwt1tvIS+2idx/d1kCRAmBy9Sf
	DJQt9iInW1sJlvYPcYFN+pluam8YG0iSfC4eg5cR4swTZhNKoHzvJGhDXMyxzx1B
	dhnANhvh4lotDrl8cfhxtQKiNFzhlFGZ2c3eW2El5hUuhdAY0E+DlCdlY+hDo+hR
	m+jYSPUetlPUhHGvQIjTCYAHxFl/nYjPGrLkJusPnzCce6kqpBhykumm7VJUW4v8
	pqpBO0IddGXuMASf4PrYLMrtDjbyYp2bbwDoVB6ocgDCd1Q+W//Un8Sh3OxTh97i
	eq1jBZVW3hMKOPr9JeVVZWoyAb8hX1RAXyuZYVA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:UpkDx4bkvjakH0m2eLQFcaO1JIyhOU2LAQ2WA1SsLso=:Pwr/EvckzQRi8VqIsQCTgCy+u57sLN4gW7AAHiYrHqg=;
X-ME-Sender: <xms:Ug7ZavzgKDjf2gYtCvXL48uOK9hsdpiDqkLbxRu9a-gTtfaXv573-A>
    <xme:Ug7ZavuNndzapx7uE4nreRHPPF4bcnZjmzrnuD7LRPOwUUJO87chyYtnJfiuuNBGi
    _OYhu1rjTwomVF_QNTGwxju6cAcNmruOLXAs1_EKgc9oV2eSqS0dQ>
X-ME-Received: <xmr:Ug7Zapxl9u0fgmuOocboM_oE9F-b64Sv237qdvjOrKBtUvv_awRFp8CI3k7sRpqAR661GZU8BeYj373-jimRlwpVna5-neMLT7NT>
X-ME-Proxy-Cause: dmFkZTEll5c5lZCIjYwRJN5EtV4EPxJSm0o5Nf9k9fTmArp5ztZNda4x77h2zndqKYa83W
    37HBL1p1qnJbSV+T5JdzPnzF4kav7Rgnw+k8yB3n05CEKxumCnCKjLH1kJbnXkL6YPLrK8
    7eimOHdELjhuGgEoj2PEeKuGg7Yr3YZQOAe6Cyvznww7MPqFaIVYmDqu4Hll0WUWLRCZec
    5G5pS19GLUm6bFJ94p2wGOV9XWLivIrmk9tKlgfmw5bAPA/qPTPgL8OiqqwnINGiQELhwq
    be09ZPChXvC104lXeEAEFsi26izXoi2l7U4uqyJVBRT1ArQQb/txXf9G6viedfTCzkr9lV
    xJbOwwbQMEKKnPuL8TdOC7eMHcJfPifw8vKneUac9/ijxy2HriFPnYmoRJo+CJWmKtUp88
    /ni44ASkpQMBNzI3DVf2n4iV1Xx/MIgc7/hZJFj4KQtzkF3a8IzYr7wdBsp6oikfhZZ/pJ
    UbunbsQ2BSRtG5G8TWRb6pMGpKN/OtvE8UYxiGlZU2m5dkslV0f3zZBeicVqTds2+XEL7W
    e5NUWRF0FNNtcqlBSRC784f+O5YP0XbTvxLlw1xyVXaXLFVxqSTKM0NR/EkgfegqBQYT+P
    9YOqgk+022iDmSebf2MEIjoeBNI4vXrgjbro0e7DDsx1euQLx0bsTBY8wgGQ
X-ME-Proxy: <xmx:Ug7ZaqA6eQvLlCRmiuUMBHtwpmCKXlSrAUJC9RJaZQXOqTuYAOFalA>
    <xmx:Ug7ZavfU-SfSNvGxYPPsyoFtyno6I2vg4Gtrxu6If0eEBC6Pwz835Q>
    <xmx:Ug7ZaskNcg5aZ4_hidhgR28zM87p-FxMGnEtJX9WRRhvdVoI-jBE6Q>
    <xmx:Ug7ZauF4DKFH8TUccgjojnf8dPBgh0jFq01ULbvyoQuAn10AgbtVnQ>
    <xmx:Ug7ZauUD34aXz1_VSyDnmJvLSTh1f5qChS3noS7L8-VD-7RU9WnT5BCh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 15:11:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Nakul V S via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Nakul V S
 <vsnakul@gmail.com>
Subject: Re: [PATCH] sequencer: refuse to revert shallow boundary commits by
 default
In-Reply-To: <7179f371-a709-476f-8e94-807d7b62ce6e@gmail.com> (Phillip Wood's
	message of "Wed, 21 Oct 2026 16:20:42 +0100")
References: <pull.2273.git.1792577381142.gitgitgadget@gmail.com>
	<7179f371-a709-476f-8e94-807d7b62ce6e@gmail.com>
Date: Wed, 21 Oct 2026 12:11:13 -0700
Message-ID: <xmqqqzhina26.fsf@gitster.g>
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

> Hi Nakul
>
> On 21/10/2026 11:09, Nakul V S via GitGitGadget wrote:
>> From: Nakul V S <vsnakul@gmail.com>
>> 
>> When a repository is cloned with --depth=1, Git records the boundary
>> commit in .git/shallow and rewrites its parent links via the graft
>> mechanism, making it appear as a root commit. Reverting such a commit
>> will therefore delete all tracked files, which is almost always
>> unintended by the user.
>> 
>> Add a check in do_pick_commit() that detects when the target commit is
>> a shallow boundary (nr_parent < 0 in the commit graft) and refuses the
>> operation by default. A new --allow-shallow-boundary flag is provided
>> for the rare cases where the user genuinely intends this behavior.
>
> Thanks for working on this, it is a useful and timely improvement as 
> there was some discussion about improving the behavior of git with 
> regard to shallow boundaries at the recent git merge conference. I 
> wonder if it would be better to refuse to cherry-pick and rebase a 
> shallow boundary commit as well. Do you know of a sensible use for 
> reverting a shallow boundary or is the new option added out of caution 
> in case someone wants it?

Very good point.

The next natural question is where the modification should go if we
want to make sure we protect these shallow boundaries not just from
revert but also from "cherry-pick", "rebase", and possibly "commit
--amend".  Is sequencer.c:do_pick_commit() the right place to cover
all of them?  If not, would it make sense to have a helper function
that different code paths to protect shallow boundaries from these
operations can call, and add the first call to that helper funcion
to the location this patch adds new code to?

Thanks.
