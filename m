Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793035588;
	b=gWFeiKFoC+1BFFDAcRYaTMBgNnTkwCtLBck4LvWk4Us57+COYqM7vLgnh578M4BoCnnT
	 5T6vL3OjZio8hVSn+4HOfTSt+umQKPMtsng1m9hG8dy4pv62QFc83+znTgwLSrR4ge7gs
	 q6GLxvzrSenWnyxTBzQWRdvHkNtz/XH2Eopw+1YxeWdlaS10BN0F6xIGFdnp7Tsdc6B6z
	 sInzOswSBewVp4XG5ErV9CDqRC2LpBzVDZyysHOswmGr5CpcLC5RLzaLNnR5wPfnoCfeB
	 tssMqYbB3vE3eDchWsD0PAistKv7prXim6Minz8PiOwoa6/jzvLtgM3YyblYesiWujQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035588;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=e1bmH3UyJv4auIab9/ENe0WZkDeXG2pg/y0tRpmcHfo=;
	b=DwtQV5YftbNQIXrxfBdCYS0KqmwpBdZE9v8fk2pWzk9ZSrSDMV3QWkAn//VPKIcla/Bu
	 5etEebZAhkMl47PXg5xBwWGANumZrsZy4ZlWzI9Kigb8xRzqDd4oIM/NiyMtgJlTOeppB
	 7jE1vwiSiKzkGnEQGXR0EEi7s6Oghh3qhHAZTKfDmM/JwdV1fOsZ17FYrrxHdplqV3Mmz
	 urf6vG4ImUGF6lTTNCFfgjrSOSfZSncjDSQbMiDsyCSXBcXXMEGxWSmGO1pPuakqMW+NS
	 UYSqqi19vKQ1SMDeun+FGyHGqxNizasZV38E/g49SfzFRBehN1Gxjz/aieryweK/b6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="hAL/xcPO";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=NYGa8nb7;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4BC606A325
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 17:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF4BC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=hAL/xcPO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=NYGa8nb7
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 45C991D003C7
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 13:26:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 26 Oct 2026 13:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793035586; x=1793121986; bh=e1bmH3UyJv
	4auIab9/ENe0WZkDeXG2pg/y0tRpmcHfo=; b=hAL/xcPOhm2BnqBwLo+TbmUxdC
	zZID5UPOUh9aIW2dzmd9cCl2KoQBIVK/omhBYSgJSCVMhLTscvA0RNQNrukuNNTX
	yrWXx1/mbhVv0WU56kJ2e087HzPU9JjElNe17BHAWjZjsv00A3Upex/zr5jjZEOH
	aFjbI07TTsRNonl6M9s+fG0MfBx6tc+Ioliz+NNGTaD+VTq4hMhrhmyYpJXPeOVS
	HsNSi+RabX52RCA8RsRx45QFrkv9EKXMEUHRRKK2hdjiuuHwd/j75oPzkRtpVX10
	mFsMlCxsQ+SlWEWugtWM64Xchzlur1eWQtBB6krTpFcV+N9fQGB2JQuueGkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793035586; x=1793121986; bh=e1bmH3UyJv4auIab9/ENe0WZkDeXG2pg/y0
	tRpmcHfo=; b=NYGa8nb7aNZBWdxdZBVKCxPUW92OdvjPif07iSc8EM4ABdHu1oc
	5vcxRGvSqEhX4z4/mDun/Mm39wfNI0WmmkCmVNkq2Ff0IPfUliJdwDWty0soYQ3v
	RDBkXxiedHnYXsR0WmzxRnZs6yDL20/djlorE4m943iubgvw6yEFn7d2muHo8Q82
	e88kcymQLnrfhcoIJUSVob3xgIB8wq/hd3/qKuyCzqDS7n6vBgd193rGmaUR74wg
	YE+/vCFyWgOEQbBRsZKKd9ri8T0s6sy41G7dBMeIT5mO8c3DEihMVIER2uc9rXwn
	bbg95wIJOYmwjjabD1bPAdhKAIaleFCjXjg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793035586; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:cSsA2OgVbQg7iwzy73bAcDqydAsZi0hQugrrnNF1Eb/FP1p
	jnpl3tZPq5nf+40wtbn3PECSQnEQoa5TJ745QDuLtSLAwc4pA4lDZLKzPfCQ23Rc
	CT0PNO7yIbuN+Qkzl1bqUn5greiAKwY6ALw6glcFF7QQQJ+MTmYgFvRigIR0fs1k
	U9CMk8m1OIpBT+d1KuF1BL3IsFvdOVNvoQKT/VVgew+IB/j7ie1n3NY6L8DcStqA
	LIoeSz/T+4xCHj+RPktvnJfsQil6mM5ZTkzCA/M964UfEIbpRnpixltn0qNXxn7Q
	K8nUCMGfZCS312XXQgUA8vdVhZGe83mB+LO3j6A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:oe5iG4ZSJJQqUkxQ8pDZlW0jn0torZjChOxSbmx+mrs=:e1bmH3UyJv4auIab9/ENe0WZkDeXG2pg/y0tRpmcHfo=;
X-ME-Sender: <xms:Qo3fap03RIfnGFg8M7YZbYTBe5efkRIdePcDjr7-gptwUVOSjbyGlg>
    <xme:Qo3fanF87a-Zozwle1v-NXmvXaJMf3pTfoVeiUTELypHvD8oeLK07xJAUUNDAn64C
    5pyX_lLm6Cg_NfD1MWi0UyigRyfkf3dqzDetUsMsSplP6RAYXb9_xo>
X-ME-Received: <xmr:Qo3fau6PAWoV9FkRUrEpaCwl6BgL94zs5ee95WdnnxH2pXH9vidLktTeJJ9uqkKqNdyKS7LhXaFSa96em5JwuQw_Pldh1LL4dkWn>
X-ME-Proxy-Cause: dmFkZTEiypluUDsoVUFy2n16ZelMQgvDhEFzheBMlL47M7+EjrXK45GwsbxfMg3Lmso5yl
    /KATraJCBbX+IVmQ3q1KXLx/w6Xo+U2/3518Lb3e0xFapeFptgStnvFS2+SjRx9TPc6Mrw
    ajE0wF4nHGHOLjHjtUnnwzSjttAvPCOpWBKse03S3pAot2Y19UhCU+1C0LSMMMqZxkrtR4
    YoomkvH7xMsl8cKJN9FG9Yre3pcKe1gZDZWYgf4ATJC8NTYTp0GjdtdgtqJMWbLkUsl5dk
    Mgh8YBGtnrChgSGB0rzXx/KcrwfzDwnY+Gy9KittFDQYcvD9ElARBgq8VvkH+SWnH2MUVA
    lBr6HZ1U/UHR0sTgKmJLJTvE9fS5n4EjzHUulBouJB0Q/tBR50kkhd+S+epIwDS/cIRBEg
    eIYcVt9THylVbavteKAfX0IdMbGc7xJQvJ49ANNK87yPUVCcduAweCshg4bSsHBnbOjFcC
    5MgNJfn/5Q11TKGUOxBDF/Gxc1P6rMdiQkN+tsO4DFv7Be0W9UugulvrivM0UpkFp6ehBC
    zRZTNf9TCAMnwCGyiVqAQNe9sNrxj7A+53kRp8kIpWJurJmhLupX0Xh/MexOdahYu13ALQ
    PKZ66mcOqpUZy+D1kOsC/QJrotdrbXU0ikWRMZ9JIYG8Ijz2qMLn8RIIVqVQ
X-ME-Proxy: <xmx:Qo3falsqgnYwBzN9l-UkwRKuSYnohpvpyoO2PFxTKXxrUbiV2AoGmg>
    <xmx:Qo3fan4AnwraoxudacCsHErtbOYMlsINUh9F5wqxYbPAJlPaniUD3Q>
    <xmx:Qo3faoW34mYUq75X1tx-DtAz5wCOONDgDZ9y7NW5eSb-0Cg5C-yeLw>
    <xmx:Qo3fah-18Iu-3S2enV_gHmIPd578rxa73J_2cPZsftRI59IJQoNlRA>
    <xmx:Qo3fajqqpKArT-nHSmRmA3WbQXkuDYA_Rsh32TIcivY5TAXoXEg9oiAb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 13:26:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: [PATCH 0/3] send-pack: avoid resending unchanged objects after
 rebasing
In-Reply-To: <pull.2281.git.1793029565.gitgitgadget@gmail.com> (Marc Strapetz
	via GitGitGadget's message of "Mon, 26 Oct 2026 15:46:02 +0000")
References: <pull.2281.git.1793029565.gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 10:26:24 -0700
Message-ID: <xmqq1p9cs79b.fsf@gitster.g>
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

"Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com> writes:

> A common feature-branch workflow is to push a branch, rebase it onto an
> updated upstream, and force-push the rewritten commits. Large blobs added or
> changed on the feature branch may survive the rebase unchanged. Although the
> receiver already has those blobs through the old branch tip, Git can pack
> and send them again. This can turn a small history rewrite into a large
> upload.

This sounds like the exact problem push negotiation was designed to
address.
