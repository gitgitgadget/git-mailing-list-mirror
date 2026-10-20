Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508885;
	b=0mcCuGhgjldPECLspFrRTTiqCYAtz7J+reUcxzgMGBsBjnIcZvk6M78TAf9/hgZkDjKm
	 FaOx/LRA05ppCTvMezlOHal9E5O+Ge8ZYkWqlqH13c9SdZSUVrtXuQ1Bhf7Ah+7wwLLtI
	 grfa2dxafbRZu9P42J9dDtiQW8TsKdSnJyfPd0QNrEeFqdYplwzAYLwXd7EP972bEgc+E
	 nl4PfmvFCaM7Pg0h9CUG5QTwC8Q9zJ192E00MxEexRVjXEJVRBUCh+pJ7orXtHE8diON1
	 Yj06FR4E+WTsbuzSVFButm/fz+J/2peg3QL1Vf9XxNQLoWQfH7KOXCs7bDQOUFFM0CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508885;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=hv4YXpRBiFrf6Vg1IlKWeqcoUuw62FAd6fMh/QUgQHo=;
	b=RsY53PZuF/rAJx+QYxd6h/nbgk09sP8tOEJT0tsaEPHCSIqStHXVHFfxBgVPq9D6PUgN
	 uXfRh3UHBHKDyoSj499W+zh5CUxRCikgdn6cyRkX3hr03h/fSkArrFom44aLk12I0JhK7
	 pnWP55EuA/Ebh3k+ZW8QkoJS3L11KesoK2ev1sezuJnKVS+BRiZ8MQrrh54yTu1agcWUz
	 OEjoP16HRjgy/6hcJ8D9ruXmF7CIK0ZNz4tEx3WL3d+SiGZvJwYsenbXxLKjkrYSEuomX
	 BF0UboUb55spes/OThr25whNw1aiXC048fs/5AAZeaj4CFlQ0peziMR2J46GbSpJRHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=EabnNh6A;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=v5BofXMY;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C58606A31E
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0C58606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=EabnNh6A;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=v5BofXMY
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C06601400122
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 11:08:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 20 Oct 2026 11:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792508883; x=1792595283; bh=hv4YXpRBiF
	rf6Vg1IlKWeqcoUuw62FAd6fMh/QUgQHo=; b=EabnNh6Ajtd9CCfWSG6MTKcsJf
	lAG5ZbdbwuBFC1SI6hv4Q/NYDM/np5BUBCQ7uBHBxX0wxP2/Nht8lSfuY6jIn9dx
	W487d4SY+8i5uoxQCVFrIEa+X4QjHLcFtyrZhC18gEDjw+NQ+iuKUdAsytL2nN9v
	ID2BweRt3ybk42ubIfBK3vqPNnbtb82/Pk78CRxMJa9r/mBmV8eoN/nrDI5R0pDY
	8NpvTm0QePPeSqH60EJ/9V9N64bxqWuBCVMSx2e1YDzJl/NpJSiHLaYCJZhnCvjP
	cpzxy5+ZJnZONKR5Ru+/BoNtbqazVMTiZz4zmv9EpZIUIFVuQiH9LPEqqbFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792508883; x=1792595283; bh=hv4YXpRBiFrf6Vg1IlKWeqcoUuw62FAd6fM
	h/QUgQHo=; b=v5BofXMYub7CY5NI8aX+7yaEu9aHR9xtr6WSprWkdJ5uuEgkLX7
	xSI05aW1FSaeVljrTAfZ0IHTd4zp9Rd+v2I7U4IIA/EFxKDAp+UucCC7TzpPOmqy
	RwDq5QKAbdoLbvnLKzVbdL/2ykJhNVIyBpR6GLe+lLbyjgNDA8Xj6dt6BTBdVMnR
	r+UqL0m5YfodAgpHMUMOAv3f8c9OnkCuDsHAkgOEgB7xHT0URyuNV9jRH4pnqvf7
	GdHpYRu3nchCl/tZiu+1jtAGG2mtj3bew1McC/DiNer4dqR9PMIlJUNNOm0w5KHF
	S3gZlt1XWlKoiARkKBxKly6C5ih+57weZ2g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792508883; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:dtCSeCOHEj4zwT6ed+h6ECZmlYjbzi1o6HRthXyRcScekpF
	KT1CXkRtM/tqF75klyc9DE1gVUDMJZfE/XPMWGYYyxcdYoY+dBas64+nJnxSsyeB
	2omKBYWqkGLTT0GcgbY94/vr3pPUmqHCu5ZDDNj42C2YB/WU2ZZW79FAOWs6CoNV
	lh578Y2MF2iNFjdhb49ODP/WFdn6asrEoW3T87UhdTe+EOkddo7hBGb+ZyLkA/ve
	GDSdgPw/OGDvB08A1ZuMAGAaeBuJwVP1kNqJgIrHcLUstus9Bx6kK6RfcErWmNMk
	g6TQgluntbMvaXGwybKWntK2kH5dZl5NLOIJxvg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ou90buBlHXuJBqIJSNLiKLmJ2emKxBLmGRF7opo2ukQ=:Owlq9inSSZDB9QE8WYycUrAVCsv4UQcH5QvJvVGlvnk=;
X-ME-Sender: <xms:04PXajMl2PczC8tckqxmytuyb68VZzvSpQjUnxYxRKe2NbdyciCljA>
    <xme:04PXak2PpFiDkV7VYkvccajSqvO3lLKDkP9pP8hTFE0ioosD_j6yo76EhTnJcpx9N
    1mL7a1lO1UUmENUsl0zYmxi4_UOwHtXDcvGXNBdVPMzKi33--gnC68>
X-ME-Received: <xmr:04PXaqnE3hpN4Z45wth6_6sGMuVnNRhu0628pZGmlomqlIYimhzbYyAIQwKsxlFHi5wfClf9qoj5_clOcWiOo1_Odh_wnlNzNDh0>
X-ME-Proxy-Cause: dmFkZTFqiLgXAi8htiMWj7PsgUxRY6tvwEmDy78jvla5aQOkhFW7D+tRU3zbEJskshHBfv
    DA152DX/Rf54VYuARHxqNJRTdN7IgVBzMar6hAACKxPCTAzHmcEKraqf8YcMPiJkUs1/9j
    peJI1no2R/OvBZMl462Z0dBxeNPuNsulSOr3xipV5zGpGrY92CLdh1WYEdxdpUCiLFc44X
    6N8H7UxVB+DRK9HODNNV2bxehDRcYhWPy+85AevhdYMKljQSI4gJVXLST543Ftme+CRzOO
    E5sW7uO/jv04mXynRdQZfDDmbkHZD+sbgsHYsPR2qT2OkwDyA+lghImZ7tVkeibwipiLi9
    FPJILiAmfuTwBy7oG1z9/P5+SPikXGri4O9pLg8eXR3FOeZduah6CogWriSW6FOrZmBqEP
    QVc7VEamBEU/mhS5D9XX7bC3g1u3mImD5nFOrZGu51BRHs09EFOzpBg4cIASYNvlU8d4dl
    WloKGSPj9pVtkOMJgitzu8XqBkBqA6feC/h3Sxg7G2lvrmSqjaiHgGP6FY1to2jjPjwVXb
    qk31xp4NhzLyANb0V7iJeB4tVIb/Bld69QMlHj3Ick/HkByyMnDQFg6vlnRYMJYUHQYzdX
    6gGaEU9/7sHDRkTuwvI3cG5IxTfiOT01hVS1MEgtVqK4qk+ImV6skcGE2fMQ
X-ME-Proxy: <xmx:04PXajW89vQEOulLoEtVcGseRJwmZChQvqsaz_j1PRrnVsg7vJQPsg>
    <xmx:04PXaot9F6ZcNHnUtsY3U_53LcYsCoMb--pwbirUX3RUykSKUE25rg>
    <xmx:04PXauav6xzieoTYcE419Gt91seYVikPHvh7k8Sh-EhpDABgpUYrDQ>
    <xmx:04PXavXQowIM5pFPZQWaZwYyUYMOf79bcRyNx0qu264CC-9yyDMcuQ>
    <xmx:04PXalwyh32FQCIN6OR-_obR8BxobG5kUo0eFU6OmeA4p1wuZDxoQljl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 11:08:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: m@suozzo.co,  Matthew Suozzo via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] reftable/record: bound an object record's offset count
 by its length
In-Reply-To: <atcKOhm0Kd5XryAg@pks.im> (Patrick Steinhardt's message of "Tue,
	20 Oct 2026 08:29:14 +0200")
References: <pull.2255.git.1791989883899.gitgitgadget@gmail.com>
	<atXK0ska_v2rFn8W@pks.im>
	<41edbeff828fcb4a2f3bc903802b14e3aa66f46b@suozzo.co>
	<atcKOhm0Kd5XryAg@pks.im>
Date: Tue, 20 Oct 2026 08:08:01 -0700
Message-ID: <xmqqqzhkxve6.fsf@gitster.g>
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

> It's hard to say. With AI-generated commit messages you very often have
> the feeling that you end up understanding everything and nothing. It
> just feels off in a way that is hard to describe, and consequently it's
> also hard to say what exactly needs changing.
>
> My typical suggestion is to not use AI to write your commit message at
> all and instead write it yourself. Commit messages have always been the
> place where you can demonstrate that you understand what you are doing
> as part of the patch by properly explaining it in a way that another
> human being understands it. And I think that role is becoming even more
> important now: in a world where we cannot trust that the contributor has
> the slightest understanding of what they are contributing, they need to
> go the extra mile to prove it to us by having a well-written explanation
> thereof.
>
> I know that this is putting more of a burden on contributors, and I'm
> not a fan of that. But I think it's becoming abundantly clear that AI
> does not really give open communities much of a choice, at least not if
> they want to keep standards high.

Putting more burden on the user is fine, and the AI output, when
used correctly, can be not so bad.

Having said that, the real problem is that nobody seems to guide
generative AI machinery well enough to make intelligible output.  In
order for a user to guide the machinery well enough, they must know
what they want to discuss, and the output would be different from
what a clueless and hands-off "here is a bug report from somewhere I
saw, I do not understand the system well enough, solve it and
describe the solution" prompt would result in.

Writing the first draft manually and having a machine check and
correct typos and grammar is not a bad practice, as you remain in
control of the overall structure and contents of the final result.

Going in the other direction?  If you are not familiar with the area
and are easily fooled by intelligent-sounding nonsense uttered by
generative AI, correcting such nonsense into a usable shape would be
difficult, and would make those on the receiving end who have to
read it miserable.

By the way, I cannot help but wonder what happened to the AI policy
discussion that the contributors' summit promised we would have
soon.  Who is organizing it?
