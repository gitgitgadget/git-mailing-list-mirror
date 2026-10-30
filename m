Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355720;
	b=d9TGHitHoklSo3+0cjlCNbIjO5jDy4TnjxvOJI3W44fI9iYY0MvTVsfiq3tWli6HxQhL
	 EC73orbom/pTZWsO0K9T0XEN6bY5fAIJbz2HsD4iySNcW/QChajcpdoqu140s1eH48od0
	 eu4DLzMMwap6ZeSTNAyPNgbvEFwGaRSDOXXDtAtpODqcVXvOzY+xnKvOiAVb8bSCSjIR0
	 clL9jDrNWE13dacznJDwEJFtUbgyao8JZjHJkX9o2X14vLAvAoa4Rebg9s8elTM5xTVgP
	 ndfS642tqsUoh1CF4oh7wVd+ZQUdXjxn7Pk34k4+8f+MmYXvkyxPSTZYnQaFObHJWjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355720;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=xOJwRQ1V+RAr/vlzHQ/BG0lXcO8GbzHmowgBDFimiU8=;
	b=OThaaYjZ6e6x97HEpMvlOanh51tAxB/dv11wO6j6iLLgDkeZOBJk/grxQVcu+EU9UaS1
	 Mxfe4mHaXW2NJYk3aVbYVGZ2EUF8M7M18dk9hAmtb4C8ld6I35m3hvkvvWTtiMyunq69d
	 mFn2QcdUBSj9Il2NldRErBuxL9yU6T3+ASewUa9aZCOmWn4hJ0CzVxc2dQkzCZitFsPNX
	 jPExNsN3F4croniejpuVkG/Aic8+dsua0PSIiIz7qepiSZwwUQsdBTzgsqTSIozIzctdd
	 WUB9q0DhMoZasvfBxF6EAxNhtFywvbCEZ0jeBccHeUMGPgj1JrN4bUVtJkDABN52EhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=E8Ulr47S;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=av8SO8Dy;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2D2606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F2D2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=E8Ulr47S;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=av8SO8Dy
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D31E37A00F4
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 06:21:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 30 Oct 2026 06:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793355718;
	 x=1793442118; bh=xOJwRQ1V+RAr/vlzHQ/BG0lXcO8GbzHmowgBDFimiU8=; b=
	E8Ulr47SFAKQ9XCJJi0bpNwflN34c2CxcrVI4EQ5NXQYWZ2DJBoQp6qGwijVu7do
	3qm9AxHjfzbnOvk01THUN/CoaBRz/3euOllqJjK1MGyQHwkhEWHyJAZM1VRhs34g
	rG5IuLbVUGqnsWWmVjsuUWuhFUOsG9fTRrsRBw5qquFmFbfPZTs/WHahX3L9yzTA
	0+0fivFwB7Fp7VlYR/CbzL6mOecMtfJnOR3r6LMI+OeU9Yzo+3Jgtqe3n8HbMLBX
	ZTpcGgDBjXHIt3TGAAnv6GGjg9SnwOV3j6vNAbtiPUFuHssERyebR6/YQnshJCKw
	Cn+vpDyny6/JaN2aq1XW8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793355718; x=
	1793442118; bh=xOJwRQ1V+RAr/vlzHQ/BG0lXcO8GbzHmowgBDFimiU8=; b=a
	v8SO8Dy/3YtfiX/O4p2MXcMQ0G2WCj8n30I4I0H4+9CMkHlMBcSI4WsGsvLfNKeW
	WyTtgw4zJDizI1jSnmoIEyvCf62wdKQvPimPv+X79fxm+6Jq+1jszEkPBfhyZfnU
	sFnuzXbX8oA6fL720WkE+nenf99U3TVsG3FmN/jdd/jW5bVwJPg9dn6vVjSAzbC/
	k01QY1HJczbg18OAQMIh3FtnH0FZPbPXQnjmcb5qoxcZ8JaR5UBVF/qI9+Pzu6ow
	Aga5bfOAWXifAOoebjKf7Wsp5iPYQDOUB3kDO2tAqrhOeSfUmVwC1Sl9UW5w6FKU
	X3tsuol9vqvg6+5KBj1mQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793355718; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:rDOiAQupjNK2xzqFYtiTLZOhkuVJxPlKYuqVCRd5vN7tify
	VzmBq2q1rjHNXK/HvFesUvW5no/4jbwe7K5bJAOWf5REsPZEogJNUcX9hMRLXyLq
	mV9sMg1t+40tOZLnTEbm78eOIQ0tYqgk8lVU2BRZ9r3Bc0e9vIwkAxjxr87WU+y3
	gRANUseF76ELUzsL/jHClZdiYG0Bjs6WGsfiQidJUX/FpGyWomGKIEVeL93VCZ31
	gWu21VeNgYhMBpqTmfWEn2PLXmHd2RgoDVynqpNcj3VIURA2FubnUxFf12SJ/MPU
	Y5A+6FTxSG+yT2TFf2eUr+s7KoyRjLkeD/uOWGw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Jgfd/s54Hn5nVTmqne+n1/U0XCDSN/Vt7iZc023Cku4=:z+7aIGHMdK2yOG6FubZlomqGcbz4CnppwBu0fFD+FrU=;
X-ME-Sender: <xms:xm_kais8KV07LUuftI_zal8_Zwl5y4DzcobN3PPNbuTUQPEj8OK29Q>
    <xme:xm_katff1FCi0-ZxXwmzNxSDuXjyFrzpJy3V7hNlf2mSfrZGzjg8QHTQtWzaXiWLz
    Uq81zSTSNmCPg6c9aJk4LSQJc8iCiYDebxYH1RD2ZR71RQxmQH3Sg>
X-ME-Received: <xmr:xm_karZuO6w5Pqk7bM5iTPUVCyTg0t8PtmhW71wujbsB-nHkuH_ITxUh32fsHhbaXbQ62g>
X-ME-Proxy-Cause: dmFkZTE5DZFNz4dJlzhS+5nPFBPgibdHSgNM2fRPkCMWD1wjIyf+Y/6ffcd0dUnTGV2WsH
    jx1i1mZz7ZDicoi5CA0FwpapLN4Tc0C94tjKz22+HmDW8wErM1M68ZSanzjC/r/LRu73mv
    mTCAqncabcSeLFONNaVM6PJyd/py0Q1z0cANZrfgsIXPGVVxepzc6k8Xr61Z8uTE0ewgNw
    6M18A45NSNh6S7xZ1DAmvZOrboVv17uj8+oDU4EB86/eHyoyNCV7PaKI4Z2o1vFhd1ZDwI
    GsK8vBUjF6T/nGNQdPIPB7qe8yLWaw8pCI1zrkgIKBcI8emdc+gvubVe1EplTgThf71ill
    HmkLQNkq0ux+DwXuDN8L17muAOnSsB1wo6Nif3wQS/98Weng/hEolpDzFUHczfhSE9Jwxf
    mcjM//VOZvDxo0PGKenLLXyKPYgGK+wVKfEpHQ9mCazZ1LAGOuPXNJ3mvft7i6P2Oe2HDz
    D0M6ulhwPcfh0TtZr+rcG0fm0krRLkEYM3S6bk/EZWQyMkMXyHwBiM3Y8W31IfxEq7EeR2
    S7gv7MhOaWuryV9Ld15rZYhcKVSlF454pLtnsg6oLKZuVwG03JZB7gP39v9A0qgI2iHtOe
    fVVAJ9cnCfW7Om/NFVApGXvjCkqKjkViO1WUGakmMJGlfEvl3K9CLeCq7PFA
X-ME-Proxy: <xmx:xm_kaoXwZ8Zng7dFjw1_p0MAQH_b3SA-qtnVyMrcr7nPXutyEdW9Og>
    <xmx:xm_kalhku9aOHK_CG0CfKXcZ_KntoJK40denYypPD7wmC70XFzwEqw>
    <xmx:xm_kauW0qDh9C6YIkUICgO4mJXzaUe1i9SqOFULJY08xPZaoTRr03w>
    <xmx:xm_kakN2C-cBzAamdf8PW40atmlR85tP7qeR6RbMfLGEgA67Sq6gJw>
    <xmx:xm_katfBWp7l6YfhPkfODcrJ5sjcIZ-0ZCl8b7mowiZ3DyJyRcyoLw78>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 06:21:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c41b0a9e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Oct 2026 10:21:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 Oct 2026 11:21:48 +0100
Subject: [PATCH 2/3] builtin/grep: read sparse directory trees via
 passed-in repository
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
Message-Id: <20261030-pks-grep-recurse-submodule-v1-2-d4eb5c87d8fb@pks.im>
References: <20261030-pks-grep-recurse-submodule-v1-0-d4eb5c87d8fb@pks.im>
In-Reply-To: <20261030-pks-grep-recurse-submodule-v1-0-d4eb5c87d8fb@pks.im>
To: git@vger.kernel.org
Cc: Root <rootminus0x1@gmail.com>
X-Mailer: b4 0.15.2

When iterating through the index in `grep_cache()` we may encounter
sparse directory entries. In that case we read the tree object they
point to so that we can recurse into it via `grep_tree()`. We do so via
`the_repository` though, even though `grep_cache()` may be called for a
submodule via `grep_submodule()`.

This issue is similar to the one fixed in the preceding commit, where
`grep_tree()` didn't use the correct repository. But in this case here
the issue cannot be triggered as we call `repo_read_gitmodules()` on the
submodule repository, and that function will cause us to read its index.
But because we only ever set `command_requires_full_index` for the
top-level repository we will convert the submodule's index into a full
index, and consequently we will never see sparse directory entries. This
is also documented as such in a NEEDSWORK comment in `grep_submodule()`.

Regardless of that the code is still wrong, and it may very easily turn
into a bug once we start to handle sparse indices for submodules. Adapt
it to use the correct repository to preempt such a future bug.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 22fb365eeac..cb518d8155e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -560,7 +560,7 @@ static int grep_cache(struct grep_opt *opt,
 			void *data;
 			size_t size;
 
-			data = odb_read_object(the_repository->objects, &ce->oid,
+			data = odb_read_object(repo->objects, &ce->oid,
 					       &type, &size);
 			if (!data)
 				die(_("unable to read tree %s"), oid_to_hex(&ce->oid));

-- 
2.56.0.341.g393f52fd96.dirty

