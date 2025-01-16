Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DD81D5CE0
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737019047; cv=none; b=B9/Dq956bDI02Few9keCb88ZW+mFaK3L7iW8gsPtKMRs8n6z9OoZjE381xO34UCjYfPwe//t8KJK/cWxSfuUcaKWsh7Jc+pPO7fXZdGV8B+RFRcE6Ga9I4Dw0pqz34WsXYjDg3DtycZJFS88f9/QMUMNQmpnXv0PxQc+8tAVdPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737019047; c=relaxed/simple;
	bh=qQkpGLqkHX/I72hlZOnoPvqU/16AcM0CdT8XC/Y3uuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r2DayB9I24IwhT8/4zasR2zJqHD49IP6kE/PeguLvcHxY12PXZpFMzJZOrPK3UNHLCvQZaTi2XYU/Dea6fTKjS/+EgW4oHgZTutzJn+l+i7avEXRdW3lwq73/olzBp46dzjqN3//0HtjnLxclWlsOP+pCUS5ZPMwfSqsyuaeaYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H9LV5W7o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hUOwk+lS; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H9LV5W7o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hUOwk+lS"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id CE5011140113;
	Thu, 16 Jan 2025 04:17:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 16 Jan 2025 04:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737019044;
	 x=1737105444; bh=6lKpjSyhoqC27wG2Um1223BPm9jmWKzVimHofBia4co=; b=
	H9LV5W7otE7HpLNb9qJ51/GhcyjdULNW/WXzZb2KQbkW68hsj30szb40YeD+B22o
	UJvDslYMwwubKexu23Iwc4Dzmq0d6QyGQTJ2jKb2AK91iRVV2RgjJhHbrBdCv1WN
	PbE96/ssMOUa9eZ7jKqVicuiiUkJmxKgNDkl6he95M2tX3yqEt8hrJLZHPAvv+Ry
	Fc74Nc2uQMTglVVX/cGuMWfHD83v/4Nyarmxdz8DgPM8QXDD0jdJeL2eY3iXrfut
	GnGvqgF4XKe0SSaAsuLXvBxJsEy5OkoIE5NjLo7VdAjLKZ0WrXhFKxNVySWIxrEG
	MK0W6iyAGAUoRji4CAj13A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737019044; x=
	1737105444; bh=6lKpjSyhoqC27wG2Um1223BPm9jmWKzVimHofBia4co=; b=h
	UOwk+lSgJa1bt+hZskAITneW+tYxr76PIw4VXok62sr6mQaS3z14oab46nZFXNhV
	TAahoz/5LP03Zn3WAE15R/BaoWMLg9xg/YXy6z3TzgTQgSjF7uEkUJPXOzo8Q/D5
	EgBlWpgjR2PTX5mMv2Q6nzJRsNcPg2m6eN1Epms01wiA4k5Bx+5YRoaRChA4p7gi
	smbeGx1ApfanGACIsngWJufIb/5oFOUntR3yY9vLmnwAChfXXCffQOepE4iq/0vb
	Fwvppk3/b5vKAuGGrXUNC/486LK60bwXbFtmT6nbXlbts0h9sfHVQ30fELLHZGhS
	p6UBqxtpQmAX61m8NKyAg==
X-ME-Sender: <xms:pM6IZ7brEP4cplNTvn6v-unH6f48kDuqIJJPHeHI-8BO2Rh8Sx9MtA>
    <xme:pM6IZ6b8t8iBM90rOoMH21emtIQ99uPOFlGLiXgYh5toheJt9cKqf4HbAYbekjrRs
    IfUhwq_nobch2gF2w>
X-ME-Received: <xmr:pM6IZ98OvJeTAyD64lUfC4rYhDkBDN0OGIm2ULCuqZQY_6B3RHNhDi239tbNp3aDICX_3QeIovcOFcHEgHKouNYh-O8OmlTDOZcvMlgaMQm7nW5qlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:pM6IZxob5uyzxhwZRHPYPYtsaala0xlr6whmpPytOY3T5CRlicZ1Ew>
    <xmx:pM6IZ2qqjl6UEnCzRv8o5lDiaznYOJUqKoHQYDiEzMbM5ed44Bu15A>
    <xmx:pM6IZ3RnePZFCtVWATJBIW7GlUezgTc7iVDJbBJd_UAkx-Y2aSj-ug>
    <xmx:pM6IZ-rVw4c_32fq1vfkVkKjK7QYLBUePByd847Qhblbey4aDwLHRQ>
    <xmx:pM6IZ5XHMnOXYQ2DoCXVMwgVs65Ei95TLwZxvDQ2oKtM0_mLGvrZl1l->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 04:17:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 41fcdfd1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 09:17:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jan 2025 10:17:15 +0100
Subject: [PATCH v3 02/10] git-compat-util: drop `z_const` define
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-b4-pks-compat-drop-uncompress2-v3-2-f2af1f5c4a06@pks.im>
References: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
In-Reply-To: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Before including <zlib.h> we explicitly define `z_const` to an empty
value. This has the effect that the `z_const` macro in "zconf.h" itself
will remain empty instead of being defined as `const`, which effectively
adapts a couple of APIs so that their parameters are not marked as being
constants.

It is dubious though whether this is something we actually want: not
marking a parameter as a constant doesn't make it any less constant than
it was. The define was added via 07564773c2 (compat: auto-detect if zlib
has uncompress2(), 2022-01-24), where it was seemingly carried over from
our internal compatibility shim for `uncompress2()` that was removed in
the preceding commit. The commit message doesn't mention why we carry
over the define and make it public, either, and I cannot think of any
reason for why we would want to have it.

Drop the define.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-compat-util.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index d50f487c00..c4b4b372b4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1537,7 +1537,6 @@ int cmd_main(int, const char **);
 int common_exit(const char *file, int line, int code);
 #define exit(code) exit(common_exit(__FILE__, __LINE__, (code)))
 
-#define z_const
 #include <zlib.h>
 
 /*

-- 
2.48.0.257.gd3603152ad.dirty

