Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596363;
	b=gsIhtHajOBDK3VW8hd3ir0C2r4EMvmMvr+iTtHzoIOcLMWDq8WkI3q6I8HjXXGZ+60Sr
	 1uca1z1/PuDSRgDPY3WKMpkYrliKbOU6jeoP8T2l0gWXMOczMsle+RudIlnyGYTnOwP4/
	 hc42Utf2Yp7a051Q22A/CF4Cmr+UP1nr8hIrJTcHqznz8G93zlhYI6AzK4kTxN2dVqYmv
	 VmWLlYRXeq/0tQ2CC7ml9aIOPUfRCXf2FVwaU3+FMOJQZfmpMptlVMinxz8bOjDteU59c
	 nUB+VNInsl67gz2bPmoyH23wrTIdGWqG3OGAzbjWQkglrnIY3739GGukq+FCr/NqHwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596363;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=rKFgSxulwEhPKulBFsqEjVG7MSz6iXycv1XaADi1JxE=;
	b=rSf18+8byecNljUWplSqUHN12bqbPhM7idtEM7EjPA3TBo89nOr9cJVLv7oMPIdbsJKv
	 G2PWTuvDiV1o9HpFjfcg13XXF4n5OmUW9CUvJV3JRntQ/UAmnr2ev6sm7GFYTRKM2/I8W
	 p5Dw63EB5+iCdBXezBO/OKIhriR6SQ3xIPnKdSKqiaLwc1WH5CNpiT07V/XG9zKGxzutY
	 MHjUqku8sJSb+oI0CzlFrXJIesnY9DXtC4tMpi5bHpkZ+Mu54hqRXpFtdYJrj25J1Xvjh
	 Ryp6JU3hrudazS9Bt800VTjLnkBx5V9o3NPNER60sbnUVnk62vtoVA6a61K9G+hp16Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="DnFX/6gK";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lXntC1Rp;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CFA606B2D8
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 18:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93CFA606B2D8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=DnFX/6gK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lXntC1Rp
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id EB3D31D00170
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 13:59:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 13 Nov 2026 13:59:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794596361; x=1794682761; bh=rKFgSxulwE
	hPKulBFsqEjVG7MSz6iXycv1XaADi1JxE=; b=DnFX/6gK+F/7adyJJQYQ1Al/5C
	cpFeX8FbtKYUSBuW+7EQ3F03BsHCiTDXxgqcLIVJTtC5ky1VPAbH/5bTz+XKQJlz
	RbTYqvkMF/5ow9a91dTs8xhnI9bQ/1eSS/INoU9/FQoYMSK0BwJQJ+y8l1SQ5prt
	2+XiyYCrgjUfdNo788qZgEc1tOv009IHNFH16znwTmuiYKlmNKLFh7NDSP7lGfPM
	UWDuU75nWaSKdQsYhlODu0nstz6BzAC5ZVOCLZXN+rsa+ge4Sg/gIi/5wJCm7LjF
	p4E3Svx3inVHVZ/mf/L+1iiR+Iwst2qIMTUTPQN5aCGH5jQ97SKsqlmdWHRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794596361; x=1794682761; bh=rKFgSxulwEhPKulBFsqEjVG7MSz6iXycv1X
	aADi1JxE=; b=lXntC1Rpi6vodXIrCT1P1XKnh8Cda/jgkfJRYvdih+oJtgion3z
	NEtwIVXvI/eYS8SokeyAiy0S5MpT5mXXluyJ+kGRT2RGdCa9QnRxB8QEJbjkkPzC
	p46dXJULRgCcw4EuRJb5ZG3MNGj0X7SQf8OSzpREtI3oI/seSpLj+GCL892qakyH
	+p55Mf1KHqzE3dUvYJFrCKogHwHLUsInbLkzXu3E+EMBUTaZvFYVxaTAIi+gLgxW
	Dc1SLxOhvCanqTx5UJDO6Thcs3ihCzjWmueR1QWQ7s+jxdlI+z6fus6kwK+sXkGa
	KxVAzPVj/8TGh58lCtpXvWCc98vTqm64mqg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794596361; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:PH1owc/cNqx1sLJnG3zTbiULmpnr32TzIgp2itqWuHA0kFD
	C9JBOSaZadpCbQ05Uo//mbsZcQMLhAYrhJdLjU+AxGNhs67woxKV81d5J6VA4llO
	vSEASKiWu2rtT9hfn5z+LC8tKNR1bjNNh6hBzsv3Ufly+2cNZbhuLMzqmHa8WjN7
	7dFzxcFo8XVPp5AMrCmrCX3WMk0NofRuq+b+ocWTkBd7bxJzlNFd6Ic1nzB6Xpcl
	CglbpygWSHOvWK+TECB8Y+FRxWOmnnYZDefKDQsAq1Kg6FKL0E5hKgkkNtbkbCPh
	CG/1Qf2/7NMqqCWF7MBhSnDx4hQ8tizUBuzXs/Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:51KEIIhhUgGL5T5QHmTHUCbooFuDMxCwJ9wtguS93Tg=:IvMj4hSBQljSI1LcwoiOCCmvnhPzmmAqQ2zThd2LZns=;
X-ME-Sender: <xms:CV73al264vbQTCEa6aC4my8tqS3Ier-eT5OIgxZFc2FT7DlLhiVIcg>
    <xme:CV73arLiHdT-AHRUvnsX9-d-3UVWlnRz1l4VD6W1UA-O96KliuoQzb-8kHZ8ybNDV
    7N_r2fD4Mq8sCRD484zqWfkqaVmRjxhBUox0d8zUNU8Pn9CB2b5_Q>
X-ME-Received: <xmr:CV73asEvChbcbdNuv1kfvkk94o6l01qEloDzAK08V9MPuVNGwUA-NzKkFKLo3N7nrXa9sTBx8zIvLjv-vIQbe5ytZzzUlHIOUuvQ>
X-ME-Proxy-Cause: dmFkZTF2U7OrN8IMwzCkMULbIVEO/j2QFYthvrxoRhGM7PgENt/20pHa8heopdPeDxf6cx
    9yW4khaNPlKRDCj81TV3VZgV4GfOlZ7aTrmFOUlygsmyjInPVIzhQ9BOfyR4R2pn1h05UG
    BUIcem76SCeSBovTf24Om+k8bTGnFgKVzCyoJOcvFr01gcYF9bwPN0huFjkU/6VPjrTAV/
    blf2OkJI2bFwKBJHhRW7IHG32Nw4tjb/0Wg/RHjj49OTM4Tg6V1wxe0X+wL00zPPMw/NPA
    kMPS/j4HRpO1zRSkBj1zRTU9UTcyMlgGrPtGYemfZQ2kBAWED/ldN9OIbZFNy+G3u5sCt2
    RMQHMRy78FvpuKgNlZe3pMIEc9A3atDoEbrWYUEqy7iS3vRb1PfXQHvgydP9BnTegc5oLv
    oYN8Ju0dpzaFW1MwTBL0ANA8QAI4IL+gAfURqF8bUJM57lbtdd5TTGFGHnkluyhQOJPRBO
    RECgqYd6P13ML5gu/pVGINm8URbdMxav+nDUoIeiK7xnCUAaGqYZHQ1O788Ny6YRYT6xaz
    G4ReUVGZXKKRJE4FHQya7bNzIoYxmUupXNfDcOKt/90cMET/S4uM8ZP411UXLx+blAR55q
    b02ThVIRAM6ZE8BCvOw799F7XmPeki0f8UkNAanq2TVtQCF+LA/hwCahKkSw
X-ME-Proxy: <xmx:CV73avXYEmL0C3I5Y_bwFxCPwwVlTzHk483YChkFqNJ2oeI5RpihLw>
    <xmx:CV73aswMDVGHzhC2_9U9-Ie9C_PJSVadOlntR7kATIGDa-_I0VqfPQ>
    <xmx:CV73asS41dBgSDKM7w-UGNBnbG3Vkv_XXR6BPXXCn8ZzCg0l0PkaRA>
    <xmx:CV73aggUc763m20f0SmmIrWqJsxbbySLFPWuZKh4Aas93NvNdxVxLQ>
    <xmx:CV73alJKTCq7jTVz6OkGfnf7-n7zNxhljKzuWkGbkcZta5C-Wd0Uosy0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 13:59:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jasper Mayone <me@jaspermayone.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  sunshine@sunshineco.com,  kristofferhaugsbakk@fastmail.com,
  ben.knoble@gmail.com,  haraldnordgren@gmail.com
Subject: Re: [PATCH v5 2/5] doc: for-each-ref: say how to read
 %(worktreepath) safely
In-Reply-To: <20261111152811.99986-3-me@jaspermayone.com> (Jasper Mayone's
	message of "Wed, 11 Nov 2026 10:28:07 -0500")
References: <20261102182930.3511-1-me@jaspermayone.com>
	<20261111152811.99986-1-me@jaspermayone.com>
	<20261111152811.99986-3-me@jaspermayone.com>
Date: Fri, 13 Nov 2026 10:59:20 -0800
Message-ID: <xmqqqzgoblrr.fsf@gitster.g>
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

Jasper Mayone <me@jaspermayone.com> writes:

> The path that %(worktreepath) gives can contain a newline, which
> breaks a script that reads one record per line. Say how to avoid
> that: use a quoting option, or end the atom with %00 and look for the
> NUL before the LF that ends the record.

Is this the only item that can emit an arbitrary sequence of bytes
(other than NUL in the middle)?  %(contents:body) can have multiple
lines for obvious reasons but we do not talk about quoting at all.

I am not saying I do not want to see this added.  I am wondering if
there is a more central place we can describe the choices fully
(including "use --shell or %00") and sprinkle short pointers from
%(worktreepath) and other places.

> Also say that only one worktree is shown when a branch is checked out
> in more than one worktree.

OK.  When a user wants to clean it up, for-each-ref would not be the
tool to use ("git worktree list" is), so this may be good enough.
If somebody has specific needs, they can add %(worktreepath:all) or
something to fill the gap.

Assuming that we will leave the "shouldn't we have a single quoting
help that is referred to from places?" question out, this step looks
good to me.

> +	otherwise. If the ref is checked out in more than one worktree,
> +	only one of them is shown. The path can contain a newline, so
> +	use one of the quoting options such as `--shell`, or follow
> +	`%(worktreepath)` with `%00` and parse the output by looking for
> +	the `NUL` after the path and then for the `LF` that ends each
> +	record.
>  
>  `ahead-behind:<commit-ish>`::
>  	Two integers, separated by a space, demonstrating the number of
