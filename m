Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794958154;
	b=moco+E48oM+AVdcVd/Wn43qVeeDPMXPPsg2xY35JXJcM/hryRszfX86kB41GpQR4Salw
	 g5gIN9Rr9slFtxgdEhyoxcX62h/36hYel8mkc6jXhE3yEzZcbEIy6Ajd8kJi0zLHRVtz8
	 /CP1eKHRoVDYipkUQ3+RkFczOLsitty79AN7RgvrfE7WK3MjDn3n1wWzdHznKLFb6D/gq
	 sHjSwPKY50/jfB6wf1g4V9qkJjehxF1EKyiwOlHezn5FmBKXKEMlJXv32NMKL14KlIUBv
	 hrR7DrHgoQEsW3guLuUmbXKmyHwvElJUG/3WIPPBQNwAJYzUvGo5s6pxmbUS7XSyhxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958154;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=VDCvthr7iE18HIiybD7f3k/bkZlpvOqEccmvfA9UdJE=;
	b=KgKotA0HbXcj+mVENamCo0kXG7bMpf+BOxoLiTDAeudIdJQWmpzd94B0pbsdTIFRuxKZ
	 R3gg0kMCiKOqX07k1RIKpoUeZ9nqLYwSW3kQEdum0fLJVCXrQDA4nc+v32+OuUHj6f//z
	 a3g/K48yVXS4VaZtBrX7qbdUB13JT0KqZ++yFpLQV6eSqMaKpAafheefptAPFmaOyhfN+
	 dIWski7y4kmQAn3lKVcKrqYGEyVA8JGZvXlc7ezkrk7N/z/E1rgA0482X9OjIeF2OrB5X
	 mhHN1BR+YeAdawtgT/gGP4MZXcKBeqdHqx7F96+8ZqozTTAkSj7gnMPu7piRmssRgyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=PoHBuKEB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tNkgwcst;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE5F606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 23:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CE5F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=PoHBuKEB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tNkgwcst
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E29B1D002A1
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 18:29:13 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 17 Nov 2026 18:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794958152; x=1795044552; bh=VDCvthr7iE
	18HIiybD7f3k/bkZlpvOqEccmvfA9UdJE=; b=PoHBuKEBTmfmMmIpSmvPNAVE1V
	ZiPQnLR4Vs/Ca2EiwEl3sJxEFjhNWBaQjtmMnCtG1zrJOFwdMiqNFcwp6HI3J6qs
	EglKvnwv3XFTjgjFtVXBNjZBnlv2pCZplW77gcR9JgPxfC1M7/n9cSfGHMrULm0u
	E8ABfcnZJgI2uLlQjeVPM6CSBVyxgQtyeJ9dVyLeq/wTNWPcGynodqXIxKZLVn2H
	hnG/Lm8iV4hddAzNOOTq1yDaA9zhr6DZVWWnzpj6E6OIMZsvgoZMvdJpfaNg971u
	wQHr6M3cCcUZ/1yhJr7d0Wv9WtcgaDyIc/PsbkVQbTs7BKPkf88h6q5CnU4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794958152; x=1795044552; bh=VDCvthr7iE18HIiybD7f3k/bkZlpvOqEccm
	vfA9UdJE=; b=tNkgwcsty52dRitioRvpK9aGlOkQLBXuQCeoQMp+ynXP1VVOGoa
	oog7KKI+FDR0wuEvKWF017zbH5Jk3soSBHcI5OtlhA57VLPoRPpewG1i3ZJsasQp
	U5Osdb7IaN4vBw5Th3dQSPYTEaa9hlALAK3XvNGGPmUOs/X58vdHAIM+KeHnbHrY
	HvT77A3hsw7je0Ez8ub+JR369iWUsPzx4mcoJKRPEVFud6pup3w6PlnqZwtf3D8f
	wEIuV5ZbLb3jHnJcKJAFNmzkC1TzeFq+bcuXLHm7x9UjxHkjtkCVjTF7bNM1zzJB
	2T/amRe35GfHHnfBdxbJirEzm5u+nZ4jSAw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794958152; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UmtHYTZxN+nmwOCNdMEcyS+qrwXIUpY3+ujlRui/WlpoWE9
	plVB4vh/CSV9zsqtVvGddko4Tced4wppYIVpSFclLUVYTWMzTyoD4kT8fENM3i5E
	/S79qWrGOzdu/JKY4geK39YBIK1VKyL4riJZg4zl+0FAVx3N9KqzJDY2cgjqnFnP
	RJZ4VwafsPvIUJTFOt5TMTLa6hDDixvA8NSLcihw2nXvBr2i9cUpqmHkJCup/11V
	LOr8HrUsJgzd1hv8YcjvHmCHHah+WQoIV5aIgSRGcM4i4Tad/5uVbRh9LJjecTqT
	JfOu9ZvvTnKaDNpGznrN6ooubAAicTt2IbOI3mQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:7rqF+J5bmvpZN7ywc+ioe+1A3ap9uBbVrGW4lS6QSXE=:VDCvthr7iE18HIiybD7f3k/bkZlpvOqEccmvfA9UdJE=;
X-ME-Sender: <xms:SOP8as0BNgCXFFUdlJuILADS8K_5y0fTsV4X9oA-wR-doFUhc7Ar5g>
    <xme:SOP8at_YxSY8LpZT4dEaJSgCG-zZ_SLjLnb66xfpDz5915KEct4Tl3suJW844ViLe
    gJLEJM9ALWoyTDFynMxS-FhQ4ruBEh_8rah764tl5IIU94z6o4EEPQ>
X-ME-Received: <xmr:SOP8atNDvDVRdu03wYZtu0v6jT5mYhB22kbCcjdIMulT2qiHzqmjeNHZXhX8LxmMYTZuPaQDUVoaaahFfZdeb4269srYOX17Z6sA>
X-ME-Proxy-Cause: dmFkZTGaWkgpfLJRkGhRrL0S5KpjmwUsceGTPgDijd+Sik98/aUx/foU/iwKHSSIbZc1SV
    SULI29LkhX6DtQxrzDE9R1T+9BA5C+SP+M4VOIkTKyZVM0LFJA347Setc7nvFT4FJec6hd
    0HSo1AUF+CZ9rpu5vB5SqpOvkGoyNwCk6HZ35vIBc1z7rwLMdpzq+SnH90ucqGjrzPb55f
    ZssU0IZ6DuJO+EIyhB8p3mGWl05MZhel5HQnN2bkO6sn4oc0TOlaBcbjHxr1EG9nxs5g6Y
    DIb9v7D+PIKhRpnzBxZ/MhG5RguTfEnkPJgluB319YUuBwi9qsvHSliQiZkRlDJ220D4sf
    wgFr+JzWb6dYOsjLFmLLv9HErDsWZC+e8fOLR5hYUZvHeTJIy2NF7xmuP41jU2qnmb2svD
    94yXjOYhVtxZ7Ah/87nUzFQvprHenJ9Tt06QWaEgWgo/qLmiifzX7W6/TNcrfp/zoK7LZ9
    W4089b5Ul7FIgckFCbZztKFYRJ2rk0FIhay106BNvUSP7Dc1mEjk1094Ov7RYGISlLWyNs
    9hpvyWyhGfjwIn5gvmTP9HrUNKdimhlqXbYnkONnVKG6r8EBYrTOrwUuGiRevv7CLeeZEd
    kdQTU9atonNn5GYfO2YBkinOGJVxMHlDa1fybVLDrW7u11jicPh3qtGjYaTQ
X-ME-Proxy: <xmx:SOP8ahedPQyd_ER2oq0JMZ3mdzi_1-mUR3MizHW3c_atPT_pIdFqPg>
    <xmx:SOP8asVJqIlbg4s891A4-qaC2G1JG41pHBl2CeZgyrP73KFSc13Iug>
    <xmx:SOP8apjAhqrIkKfF52gX3AaJnx9GGA9ZtRejQHMrLRtKj6tE_JKmSg>
    <xmx:SOP8ar_YwV6fTSfZK46XxnQ7HjScAjic-Af_sUnzWKmdy0l-OeaNEA>
    <xmx:SOP8aguiI8j0tY1AyX1y7g8ckPepu14N8Q7Hcjo7FHe-MQ13m8J2EawH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 18:29:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>,  git@vger.kernel.org,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] status: reword message for a missing upstream branch
In-Reply-To: <CAHwyqnXmOFTYLM6Am54SGE7Za9wiVS+0uJQhZfxeomS18COLvg@mail.gmail.com>
	(Harald Nordgren's message of "Tue, 17 Nov 2026 23:03:13 +0100")
References: <20261019175722.5223-1-gitter.spiros@gmail.com>
	<20261021072137.258934-1-gitter.spiros@gmail.com>
	<20261030090545.9744-1-gitter.spiros@gmail.com>
	<20261117212756.716005-1-gitter.spiros@gmail.com>
	<CAHwyqnXmOFTYLM6Am54SGE7Za9wiVS+0uJQhZfxeomS18COLvg@mail.gmail.com>
Date: Tue, 17 Nov 2026 15:29:11 -0800
Message-ID: <xmqqy0ar9gvs.fsf@gitster.g>
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

Harald Nordgren <haraldnordgren@gmail.com> writes:

> v2 looks good to me.

This and another single liner "The idea makes sense to me!" you sent
to the RFC are both nice encouragements, but does not help assessing
the goodness of the patch because it is hard to tell for those
watching from the sidelines how deeply the "reviewer" actually read
the code, understood the issues, before coming up with the verdict.

Giving a positive review is much harder than pointing out issues in
a patch, but we should aim to become better at it.

Thanks.

