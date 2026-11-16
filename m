Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816101;
	b=4+V/ufYgYjOwHlLK9MEl60URambaxEy8NkV5brxdW4mgf/g6Q9L+AVKYN6QfSNcrjspl
	 hWtqnV3Srsxez0R+Nf7JZjRk2OljXjR/XNd0fKpBLM2rDs6XzAXEI+rk58Wh3I7pZ1wjX
	 6rfqWVSd/a3gDuKXRE5NPF1Yf5eHNJVnQ8DhtJEwoPfmuCaNB/3hUR6VsJH6gwjOWCk7e
	 iV5Abx1y5mZa38pE5NSDohMKdHqGK8BT452fucrYLX/1Y/gCBotC4wQy6+Q/3Abpn6J8B
	 5x2/o4Kjt/cQ+Avw8Mp1z32Iw6/j2cLOA4eZFrmRz/CMReRptqYTTM5ew1WRKXF9YNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816101;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer;
	bh=rXW7m6XU2FdqoCMQlyvXpWywaKc2EbRweS3xhKR9nA8=;
	b=Hgxd8CFZGNQX6FWCboagmVX6CEH1/bOgwEPAxgP2JWBPVxkvhfZ1i7uFUYza6JvBwxv7
	 AX8Slv1iC/pBIUo3M/zSNF2nfLoEvZWhK581ex56zIymIik2p5r487KCuZw9Y1PQRDjUx
	 xwNX+I5Vbbb9jYtZbaSt5hd9RC9G83SL7Wc3KiBrSht+YNDT43k1D0OC5b4Xq8RlLn7Td
	 fjGPfzn8q8WSEeHhweOAwPDFZrw40QS4rmz0nhZrOjKOWqg7CvGfpQSbssyEjJYmv5SCN
	 khwo5zgh2KnVfLxcrkMdhdAmv0wegoECb7cdJayey1GYptCVsjl3sKGeBF1M35nXPkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=wt79fyKR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1qc2UMLr;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49951606A31C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49951606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=wt79fyKR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1qc2UMLr
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 46BEE1D000AB
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 03:01:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 16 Nov 2026 03:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794816100;
	 x=1794902500; bh=rXW7m6XU2FdqoCMQlyvXpWywaKc2EbRweS3xhKR9nA8=; b=
	wt79fyKR3oyKsBtuouDYd1BtxJsaTxnvaLlwCe5X57g+kWeJhypDQMoy1Oyf5uHr
	zSCQfK9p3X6hKuQprw+bh+a/zKIhL++M53RkX1c68hj2UgcJcWh0k6UOwbmuAt/h
	FVMbtc6paUaE+osbUaheGcFRS9RMV3clhdztrRWCj5FYSv/hVj95LrK546Pww6Dd
	lXi1B9ghkoU4k537jUc+Qg8LA+hE93B6qi2JtyMuYVbSDcilsPkOEoE2UMtX9L29
	pNJcqQirFzs/RugQVJS+nd9Urru3/Qkzys0LmPbJx/RvTtTUZdgpJ0DAnCvmWBgH
	xC56sWB3UWpn3kIgyWoI8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794816100; x=
	1794902500; bh=rXW7m6XU2FdqoCMQlyvXpWywaKc2EbRweS3xhKR9nA8=; b=1
	qc2UMLrI3oDbKfxrc6AxkQLrE+bFfy/aafRNSjsN/LK2BF7izVN2lOMwOBmjD4M5
	hJ4ic73gtdn+T60d4mfXszWoPCtyxr8mTRZnTR+xvITeApkR49xX5TzFwVsmgStW
	OcyScKhoTuxUSxpll1kWeCyf3XA9duA0/jIb9kNwyIp/QQgMVecrxu49TnFatyZO
	u/z7SUd3VJ7X+rk0cIPHJJkrKPyzLR9nZhxAn/slVSvZ7ceB9RomFyc9Jq224n53
	gNovxznrSPkHcFWbrrZRxLGjcYKHHxW55pehgJH4vp3Yq62l/O5gaFk/KnRej0kI
	dJ3yeaomWvPX2PABHq2YA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794816100; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:OUeK7kEuCwmhD+nnvJZ+43iNu9btNXvVO3PBXtgGZj7dKN3
	2V72ZnbYTGIvMxPru60hwtSrmpoUBko+F9ZozQ39EL3+qGlrGc6388YPn7/zAI60
	Gk+Fj9AKMuoKgXm/JaX+KUh+cvrfuX3+v/2IQ2wLZCS3IhJP9qbgGX/BNQmbnDCG
	A+lTzzI3g4viz5ZN0dSeG5zNz03saDHHzY8GhnP32oRsLQ1SOjpQGeHlnJhvIJBZ
	PiexbVrL1c/r9VQ4F6GHT4VjhyX7HRm0arJH7FBPs4UEiRlx9kEm9aV/Xj8aS0oe
	pMk5oc/jmo5GfcLRdAetespOmrRluAB3rGtAJgw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+0BCneSskl12FFpw0dlw6QYZYDv9nPY9aoOqTpjPCgg=:QwfkPDA4lqfo7i14Z9G7oqzuGdvjVcpGsel0tEZlA2A=;
X-ME-Sender: <xms:ZLj6arD-8KuqDs_sNmrXWDS6sSLiSMyVxl2IKVI353nCUR7ZThj6_w>
    <xme:ZLj6angwQv0YXgDavOWTnY1vk2x-k8VaSbs2tIfx1KNOFqnYKV6u2swXxHgSsGUJU
    CVR2Jawc_nnz9qWAbG2w7JHqfmTrb7iG1SHpLwMumP1rYOGZI9liJc>
X-ME-Received: <xmr:ZLj6akNpoz_7SOjZp1ZSdhsOaa_EctJ1vGKFpQqwFBvrJDp5FVAwfJx3sEyjfSAV2TzyTT0>
X-ME-Proxy-Cause: dmFkZTFDL2QkCTiXF8kpsrvRJI3W8vBGP4IFGwbZaCfDnkcvul3i/uwM8kN5ffxkGmzyfs
    x+H0KM/YoxSHjqH1rnFQ9IKDvog+M06nrXusFcCYN1hwvk4qoyYjNSYlzTLm95u0yi4FYW
    IezFfKxpM9XQjEcgRvT0e+qTcEg6ZEwzAns8RwyggOjLs7wu3GtBbDxChfhe9+KmnwuLd3
    j56uajiPlJE1ux7CSXIVL8aefkzeJ35WV8lB9R47osSySIA736s/7tllhF+kKyuxWPdiAK
    95kMzzWEDU8HlC/P2XVnTd9mbI2XGdJjLgKpOGSlFHJJBT4Z4n/S/mmD1Rb4yNe082kXPG
    +YcR6OcmhMdzRRIPZy2toq9tSE5FrCy0vVx9iLBTfPFSbeOOtAHxoTTiOHRotupdiyUwNS
    icAf7DkgG3mNfbl6FwaYHdvCovxmR3s6iHO89o5ebvmfv7/btEFey3CxbqrKhgtsgzck8N
    WF+rmRljDllGVP07Up+qTLefYcKj0TIU2M9aETexUIRpBo0aCM5wqujab89iHKbu/Np4Jf
    7C3DdrKuVbrDQM4L96AR353Zv+Up+o1iK4tZeS6q6NtZDT82nJ9oy9pKVgmUODuTf3ZSlv
    aemEaNUPzBGuhtnyWwOxnHcYJof4jRYyvlnU97tLzZa+tngzmK4qq7OKy4cw
X-ME-Proxy: <xmx:ZLj6ao5MxDRIDWViM1cihfj8QNGJufafTTCgMpWg9NAYAz3XhyrDow>
    <xmx:ZLj6ai2qCnXicsMsPp5Q6jInvbD5bjlQW-DyVCsIDBMJEX-MIDSVpw>
    <xmx:ZLj6apbOgu9qCKoCqvfsBtjjM3C7GIzg5ojP4QNatXBXcnF11ZaJzQ>
    <xmx:ZLj6aqBsKeJV_6euWD39d5r-hkw4bTU_C-txsnGELH4Jrgx76nGCHA>
    <xmx:ZLj6aiRmHYaML2i-ZTQsV_eis9Xiw4Z8VNwxiQ5sxjE_FoyDtzW4d69R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 03:01:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c1d740c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Nov 2026 08:01:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/2] builtin/repo: improve counting of objects
Date: Mon, 16 Nov 2026 09:01:33 +0100
Message-Id: <20261116-pks-repo-count-objects-speedup-v2-0-9c8be218eaff@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOQQ6CMBBFr2Jm7Rg6oKgr72FYtDCVaqRNB4iGc
 HcLxrWze8n//80EwtGxwHkzQeTRifNdAtpuoG51d2N0TWKgjA4qHYaHYOTgsfZD16M3d657QQn
 MzRBwT0dtrCLWlEMaCZGte62Ca/VlGdbOsrokWie9j+/1g1EtuZ8s/ycbFWZYGl1YOnFZWHNJh
 Z17QjXP8wckKA7P2wAAAA==
X-Change-ID: 20261111-pks-repo-count-objects-speedup-528abf12ea23
In-Reply-To: <20261113-pks-repo-count-objects-speedup-v1-0-7ba4f29e74fb@pks.im>
References: <20261113-pks-repo-count-objects-speedup-v1-0-7ba4f29e74fb@pks.im>
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>
X-Mailer: b4 0.15.2

Hi,

I was recently using `git repo structure` in a very large repository and
was eventually greeted with an OOM. So I had a bit of a look and found a
way to improve the memory footprint and speed it up a bit.

The repository still doesn't produce results. As it turns out, walking
33 billion tree entries takes a while, and everything rev-list based
that walks trees is kinda broken in there. Oh, well, a problem for
another day.

Changes in v2:
  - Reword a comment to point out that parsing the commit should in
    theory not be required.
  - Link to v1: https://patch.msgid.link/20261113-pks-repo-count-objects-speedup-v1-0-7ba4f29e74fb@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (2):
      builtin/repo: only parse objects as needed
      builtin/repo: don't fully parse trees

 builtin/repo.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

Range-diff versus v1:

1:  a7a1c1a8041 ! 1:  2780e491ead builtin/repo: only parse objects as needed
    @@ builtin/repo.c: static int count_objects(const char *path UNUSED, struct oid_arr
      		case OBJ_COMMIT:
     -			commit = object_as_type(obj, OBJ_COMMIT, 0);
     +			/*
    -+			 * Commits have already been parsed by the revision
    -+			 * walk, so there is no need to read their contents
    -+			 * again.
    ++			 * Commits should already have been parsed by the
    ++			 * revision walk, so in theory we do not need to read
    ++			 * their contents again.
     +			 */
     +			commit = lookup_commit(data->odb->repo, &oids->oid[i]);
     +			if (!commit || repo_parse_commit(data->odb->repo, commit))
2:  d9fd2366b84 = 2:  aa32dcb2961 builtin/repo: don't fully parse trees

---
base-commit: 1891de46f79dc444a47db1c87bd0c8c76b5463f2
change-id: 20261111-pks-repo-count-objects-speedup-528abf12ea23

