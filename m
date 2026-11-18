Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795044043;
	b=O0wYU7z9/vdK9eM7hsujw0RsYLWteZC+mbbrh5Q73miB4OgJjWoGumU9HzYy/qSYF2Zx
	 4QVQ2QORqX9/2DXGr2wt8jVbZO1QNABnOOt71DmKDypD9s34Bel4gOyIQw0XP1i+Bau6B
	 hAVcrCY++vk4HBwe4/jvZCi47+pyEAsBQ2/ecUzAhNRZdHX0RxK8kgvfB/lnk7UIM9cpv
	 k9ucrr3BedUIlRJb1/LHx3BNvsGJoQdLUhcR1jthkRxlfGXGxMGzX2cUClnUjz6R099Jc
	 JzYFraQsla6owZ4JzDG0u1mc/eRu1SmJub+X3cXn2DXwVDCMTYylbIxiFMMsYoIkDNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795044043;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NYSrEecVWtKxmimaZV9KF7UlQ79LMFRhn2MwGKLMNE8=;
	b=yoRN8B2As6e2vZBpRPzRU3KwLLBFdzXLcbYDGPQRxp1Z5Fw18yK3HAYSqgFgxfAXQgcD
	 /hiDvc3NUNnbXwssmMgSMjojBmRNLoh0Kjqj8kBzM9ia7g9XYobt/Yfz2D5/0gAIvKZlO
	 c1LM7BzeZrUY8EwSHBaJxxW4ptNhPL7XUrjBVMKkWZdQaE7PVqFp+gDQiwVzR1leIOveF
	 AUGW7l7dV7LmY0GUuRgUNtnWE+ngmlZ1xOM0AVq7QePeS/MgzPvvmG5URlXDMai2eZtqL
	 0DEmN78Yfk4TxfYXxZdwDBb+x3XDPgG9GBAyW514GwFaTfYia2IRysjeQRmlr4w9/gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=TNjbGq04;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="p9rPUFG/";
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB1D606A320
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 23:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AB1D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=TNjbGq04;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=p9rPUFG/
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6BA2FEC0895
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 18:20:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 18 Nov 2026 18:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795044041;
	 x=1795130441; bh=NYSrEecVWtKxmimaZV9KF7UlQ79LMFRhn2MwGKLMNE8=; b=
	TNjbGq04CMU4IP1bLXmfPNYv2K1UbecPYCtK51VdDVQuUb8p8aLtL1iiDrC4gcVr
	23GxV/DChFKN5SPYiUOp3Q5P8mYExq2U8qBam31Eps1UupBs9NvbvdBjjHaCitgO
	uYfjVVHpGHZLYPsZge7fr7iVjV0oznl2DL0FYhcAVSXi0aguMbjv9iS+w7KYAJB8
	OrjoP84/JJPa0IOm6Xbqf8DGfzwOsk/KuC23ifZGKbPd7tmBKQa3rOlPL+1oTuwo
	QdwzuGmiD5PFWkdRGWPomN2ixm1RuW4mXoeDu/V0Drj5IedyQ6lDgasAI23gOoXA
	QWjOam3lWsbsfCB+w1LmdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795044041; x=
	1795130441; bh=NYSrEecVWtKxmimaZV9KF7UlQ79LMFRhn2MwGKLMNE8=; b=p
	9rPUFG/1fd4mOsUPa3kiWYxOoPNA/DnkHKhyvG+q6S88E8Vnwuv6UvtS7mY6VM0J
	PMnxYWHve2l1PDZDUmDmVrOS5hsUN6O8Del0+6sS/tqR0B7IilKgI45X6NP31DAP
	X0hN7Zj/hmBgHl9mBSVupsMxlYTQND+UTT9hN9MSuC4SIkHwOambt1n9oyrnW1R1
	WPoog1xbZZEHKmlIHPCOqKLaqZDD8nJjTArDCKylXCUkUwIloPZBKtYLPBL8Ac1f
	9G5QBHWBc3/2sYECpyLYVENRZJQMgH+B1A+u1gp+k1uCBn/LDFm06fEIaG+bXVzb
	4q/dAKAABqNFzwhpgutWw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795044041; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:gdeel8nCUjNFrUEpHyLRcAVDsc9qYH8CQUdQ8pkjge9N2G2
	DrayVcyqv2yfNDvbcJn2fI1uD/r7zB2b+drVMLjOAVQK8WO6X22A/L8gVQk/S92o
	hEO/PzdHh+A9Gvg536TQbOF9v1VFG1SoymJeJqjn2LnLEbvcR8OYlSLdwuwRGiXZ
	F10aRvJ46j1jAcZg+YAgQ2DG4BuCRehpxw7aiohS7lvyKHSnLuyG6eDAhP+HXsyw
	9FW+9AqhaA9EwQIgqI7Btgd52qUyUPFgfSOCpbGPmpg1v1ybQ+IgnU7J3Tv+ZrsB
	BQUtGvy05B7YBp0z/7WiNn5C5HutCRA8pyMGwAw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:9TC2zHtYCNWjxojjmz/gN4a50Z+3bJ3SqicIee+FaL8=:Br7WwY1zucuO92v2iPLKGuq43Rz8FbDWJ3gtwIth/fQ=;
X-ME-Sender: <xms:yTL-avx_YVn8OM5bZx_plu-z2GSVRCakcGoULxueomPMuWn03UAGrA>
    <xme:yTL-apjqnSq_D8Dku114a11IirtXIB-rdvBVo1GVpgO0d9n8j-YHYKVRq6yRdaVXM
    0N5xI9VGUTlXmlGP2oQr97tXHIGvbp9gtB-iZVuGoaNd6jtqndHKNc>
X-ME-Received: <xmr:yTL-arlOZQVbefSrRq6J9N5x1sFDBnaB6kh1iD3k5edXZ0qBxFkCOwoRqd06wP9EuVK8sOuPZ6d6YmwWFp9TqdV1lUqulxbQByGg>
X-ME-Proxy-Cause: dmFkZTFJLLvUJxnsN1k6wjVbYmPYpVY/hl4ZJ8vUfoXQpPLZe4sT32PCMynp0kQfjzIydD
    OJdwXgDjaJC65RQI7v47B/XHtX00onTlDh8xFgusdpINolw0gC7yQmk3Nfa5P+O7XQC+tx
    1NK+IVyPKYJQfSyUFndTihbHqRc2VwWELFG2eORfIt7fwfY6i62wElyIE1OWWt8Rq5bKqx
    6Hn7AJvghsc8BDZ8es4HpCAWwz5F2HSbU6dqw3IAZrxm9X3v8/g/MsqJsSJ/wbIWDR65ia
    iOwGt4rme4scDGrLWR+QeQjC9YLPM7JTw6ZxRGMCpkSI1gLyEG6h2FTQ9BigvgvblkFbcs
    ddwKMMFW3Pl+5rB81AtDeh+/IpGFjuTpnNyeLNgeoNJfcYcKMHeky1qibkqkxbrnDd/cWv
    wjeUW/uW3XtJNcqJwNcbFt0LEvlqWxEv+MXboej2P8hcbSJOwFTy7H+6t9Rfz2zQhCrjX3
    fVDVxqDJrjfWn6Sy7viqS72NTgM/yWBg2aiM6v5NaM814a9+f46xui8pXKk10GJVmGuyYN
    cVHvfQFczMecB+o84xyyKO6Y5RGgKVhM0eHjoiD8HTAH8RAbUQDl40gMvFraSe6JvofFd8
    C1tuIDU0oMPce+7PFv7yZ2kKsh7OY+Ogv3FGTzzYvCuheoXNNFk0H9WD4Iqg
X-ME-Proxy: <xmx:yTL-avgoGOA1FDMsA30rpBnSVPvIZUjLFMD6lY-yvlEttodxvU-sRA>
    <xmx:yTL-av0VbTvzD5kc43bZ4Y3396ExO8C3FrEhoBzVrItb6Zzcalx8ww>
    <xmx:yTL-aoIKvUzF6a42Olmq6IR_8NDynJPtZOVp2563SLhy9OL659XyKA>
    <xmx:yTL-avygoGPVgEyg2vzT2vndBDv_yCT65MTBn-_9GkGlOh_aABkusA>
    <xmx:yTL-amPYc9bch_5zRISLMhSQEEI513cmTkiGoabZbi2N5qjpTvDiojRP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 18:20:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Noam Cohen via B4 Relay <devnull+noam.noam.me@kernel.org>
Cc: git@vger.kernel.org,  Teng Long <dyroneteng@gmail.com>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  Noam Cohen
 <noam@noam.me>
Subject: Re: [PATCH] ls-tree: do not quote %(path) with -z
In-Reply-To: <20261118-ls-tree-format-z-verbatim-path-v1-1-718987241861@noam.me>
	(Noam Cohen via's message of "Wed, 18 Nov 2026 23:04:37 +0000")
References: <20261118-ls-tree-format-z-verbatim-path-v1-1-718987241861@noam.me>
Date: Wed, 18 Nov 2026 15:20:39 -0800
Message-ID: <xmqqcxs120c8.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Noam Cohen via B4 Relay <devnull+noam.noam.me@kernel.org> writes:

> From: Noam Cohen <noam@noam.me>
>
> With -z, "git ls-tree" is documented to output the filename verbatim,
> but since 455923e0a1 (ls-tree: introduce "--format" option,
> 2022-03-23) the %(path) placeholder of a custom --format is always
> C-quoted.
>
> Output it verbatim when -z is given, like "git ls-files --format"
> already does.

ce74de931d (ls-files: introduce "--format" option, 2022-07-23) was
the one that added --format, and the documentation added by the
commit does talk about -z.  But curiously, it does not add any test
that exercises --format="%(path)" combined with -z.

The code change is trivially correct.

>  test_expect_success 'setup' '
> -	setup_basic_ls_tree_data
> +	setup_basic_ls_tree_data &&
> +	test_commit נעם
>  '

Do we have to really use characters outside US-ASCII?

> @@ -76,4 +77,10 @@ test_ls_tree_format \
>  	"--full-tree" \
>  	"--full-tree"
>  
> +test_expect_success 'ls-tree --format with -z does not quote paths' '
> +	printf "blob נעם.t\0" >expect &&
> +	git ls-tree -z --format="%(objecttype) %(path)" HEAD נעם.t >actual &&

OK, perhaps.
