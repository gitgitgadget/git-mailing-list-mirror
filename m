Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709818;
	b=Tfo0r9J2/k9qtbsS+QNjWIj3so1ZLoKBvEfCKoq3glK71d7UHD/veqxMBcNPws/Ady3M
	 S3duREySlZA6lxO7wx8W0YbNgGlLdXA61AIMAWWFlZaTCZubuyFYOCJuzzwUJv8PytZUv
	 EoiIlw0qhu64tpYeJNBxfTlwEi7xahWq//nWTMaQl2rbQJAUxn3NKBkIAkRB3LstL8lqf
	 Os+RkSKaRfLWVlOvvta6AWxc3lrUGbvT9mB0XMWQjjZMmrWGtZgp4oj5TdAubmiNNuDtn
	 cLimnkpFRaoIOWMWTGerUdmxGvZ+1xucVvpKBQy7nrrJJI4yVTcmwwOpLBurqOOpoVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709818;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=vfd7SHU4eCEAn8iCrEDJCA3sIHEL3daypsdISeAfb8k=;
	b=lswtdyzyO4zIkp9EgT6O6p2zjm0is8qnz2CaC6sFhgfCmKoxYbPD2MMwZQHGGN1TiIKj
	 IK8+O7iylV1TcL9Uggw7tHs0FrINXSf7bM8OOHKNUK6r3b/LxWfPVXvPruafNgavmqKRx
	 Cdg3sVKOeLQOj+lTISZwCBWui3i8G4v9tWttmvMv/n2cUFc2iWD/rEQrokthLUTLi2Umu
	 ER1g3qyw59Fc/IHTjy2CedVPaAlWVCuL0PcTjCzLnjo5szeXP3cKNHCDpm0jXDUY8AyK0
	 3SDRw17NpiH9K9pWuG3OtTNezVuffJaYCyUnu5skgH1ixQWXb3mwY0rAtVwLb0ymm0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="HD/f87lC";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=m78B6HzY;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B54606A329
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 12:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23B54606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=HD/f87lC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=m78B6HzY
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6CE4C7A0156
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 07:43:37 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 03 Nov 2026 07:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793709817;
	 x=1793796217; bh=vfd7SHU4eCEAn8iCrEDJCA3sIHEL3daypsdISeAfb8k=; b=
	HD/f87lCAwI/T4a1Ua30c3AKOLDC1DTK03aqzlFP+HzfjcBhCe9bMZF39TuWH5SB
	sBYOjaDZ9sIXFFm8R1XJpK2PCwY4/olCuSczr76vlIewEOPofncqEJsTNJVXrg9a
	Qs2+xjLWivErka+AVBEdqqRiCXaYVavbeJqtXGPc3++Ou0QsvZqPW5UhyxTE84By
	slEYu2LMj1atE2ItUAU4YXZhEIaoavLasHEeaJKpGU/4Kpj5Qzyk5Qdphb3Xz5K3
	78dZeHTlz83wPFRafCIz2vxPJp5AKD2Lp6yMrFSiK/mleYP81x3yMEY2aGD/gSQY
	CA8SdbGHLfPPJepM7xR+yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793709817; x=
	1793796217; bh=vfd7SHU4eCEAn8iCrEDJCA3sIHEL3daypsdISeAfb8k=; b=m
	78B6HzYgImHxALWX4Q1l0zCjUUTBuydnVeQk5DA4X9gO9f+0qb1CR4L9Lj2Oe47T
	Qjrl70PGD6N1z8DqMSZAtWFddCuWnZLaTOS1kX7vEQo6OwhEehv7vJyhfZW6QYM8
	IpFGwKCOL9V+b4pXFuQoGgJ8oQ8wo6quxAYCGoAMKeHBktZlcvwu/WDYixIA11wN
	Ga4Wy6zb1r8nVNsWbOhlq8MiV54P4/83FXhZgZ8DqkFbdwGRq2No9za/NB3Sv7eQ
	Z3Dgv6MVFYt24MGfESYN0B88UKr7JH4ujBOaKoYWoHi5BDP3jkRKyQkdNTBJFn9x
	LMBIkcG/D9h47ReraQk9Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793709817; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:DepQR5YfFM91rgT8megtxej9apVei/gheo4eIMrxstACR6g
	jhlsUhKGMB7wcyd55fMO6k5ntRKenkpGMExP5lx85xneWV9iWQj9yJWQKeRHapQk
	2Nz7z5MK/JVzHsoeolXxEZKCBo2Rx4yuOJ0RW9SH1egtDMfpbhSxfwErbUQXbMlv
	2q8eibM8xKqJnDfOdfUP46c6LJrXMhLbBg9qtBPRTrbQtEOugGKPqOkcOed3lfEt
	5/KtdSziG+Y/lcS21uUXUJHoKxDbS2QIMZW/NUj8xFh2apWHKetlQh75W3bjUAh4
	2l105ZD0Fqvjgz1sQdONa/0B8TOCppFTEibnPng==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:oQzOT0gjUeeV+mIA+dQE0aJsHkvjxwElJgpJvX14Yt0=:kMFgjmZ3U5PsEYgJpqPuieu6zBPnXiSJco8v0Tu1m5g=;
X-ME-Sender: <xms:-dbpao06bX3j3NT7YIyvnwhqL6pZFabEHXuOhlHnkaPyEaeeUsYsfA>
    <xme:-dbpaqiT6ntt37nUdJd-d1lhIBZepRsj6OblBIBC9Bd4MChRFhIsRdBBp39UXbSS8
    n8nTd7s3DJ2h5FP2Y0sKrFzWfKImO4AwTKHphtICrEvRIT-kLEQt8E>
X-ME-Received: <xmr:-dbpauTW54b2EQk6E1B3oitVMrkk60cOJ6nyXTJGiGPbqSWV5X8v_w>
X-ME-Proxy-Cause: dmFkZTFonDrjhljSOXUY+e28dCuUV6QvDMs0WwDAfJ8GzY5J+sLyD7XT4BijQy+jmXNKNg
    ZSlDDDybfRhKl69MgAUvQbKdC+aIPrNZzN+738q+BVy3LFz8EjRdEYriDG/XMS1f99i2wP
    RZbapjqmO7nU5yDdOj8psZPN58zHgvb2e/rNyBbL8AnI5UGHA5xUhbzo5kHw720NBArXgO
    u6uQlw3AfvO8Ysg81Reg6KzuAKwQfomN1i0Vj2Bg/J8iKh32bUgV4uJzOPJskUMY2q921u
    LMhsXGaO6a8q0r2/9xUZca4MVkX6Y90OcwqlGfpF+d5ykLy70AeUXHP0XqcPmXYHMzP9jW
    VRDarnYcRTyaqmJyMVFjcc+MRYu+o/Zb1aoMLNLe0Py+NxDku93P3v26QsaYQTzsUVt8Yq
    GFysYj9mID4OQe0vlIbv9FnWPZzWCCegnBSIY7KXcLQUxVm3ieSPVZ5Pelc/RZL7B+xtQF
    nLUdBgc1E6NPKyhqViNV65wHaaXxneuE+OTjZkowT0Cb0H+SKvZFfJvgyjvp2DvppWBtXj
    eir24DVOb1x/ikYmcdRUoOhCV8xXxKam9NWLN6uVzrWWuz8eKe7KzQJfTESf+Gh/8tMbSe
    1R42wEWsd3NEPZGvbXss9OuInYpZVK5zuOiQ/P12Da5HPuNszGWtt46T8/kw
X-ME-Proxy: <xmx:-dbparjawXYHs2LsjbaaFrgSkVW5SVRuyFaKZPzea4YgnyQBXFRnRA>
    <xmx:-dbpau7rDFctWs8O2ASZL8NRLGPq8awNDG_lUHRJ1ikHJfDDYPxWKQ>
    <xmx:-dbpaoDJcZrEZsnadnGOZ3_TjfkhZVgBJ1H-4I6picTJQLkHjkMkMw>
    <xmx:-dbpalbVTi1Xzdywb7mtj8AsuGwt5kxz9fdUjro38lV9cVq0f3sIng>
    <xmx:-dbpauhfDjkIWkvQKoilQRRzpNk7STRzOf3Ljlx-_CHne3bysA3C_hRc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 07:43:36 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ca37402b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 12:43:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Nov 2026 13:43:21 +0100
Subject: [PATCH v2 2/3] builtin/grep: read sparse directory trees via
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
Message-Id: <20261103-pks-grep-recurse-submodule-v2-2-b00e3b3dc865@pks.im>
References: <20261103-pks-grep-recurse-submodule-v2-0-b00e3b3dc865@pks.im>
In-Reply-To: <20261103-pks-grep-recurse-submodule-v2-0-b00e3b3dc865@pks.im>
To: git@vger.kernel.org
Cc: Root <rootminus0x1@gmail.com>, Toon Claes <toon@iotcl.com>
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
2.56.0.500.g5d06dc02cd.dirty

