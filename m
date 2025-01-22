Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA980212B0F
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547564; cv=none; b=beATQ9S0POYu2umtWyBcEq/ZycuUKKd/d1s2VwWVIj+DTJpPpjodP9+Xz1+6wYTIIuBOpexP4Erayacls6Ja2prl0o5jmd5kPZ8ZfX1aBhct8ZGfLKMuZ52RzdPsWxK8aAZlWv/Kf5AP5+WBhvzuKFzYA93DYShXS8/ibvkNrzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547564; c=relaxed/simple;
	bh=h8/qP/smFk3ntSh1yJUNQD2MhZW+BtOaSjKXjcZrYvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LcNZth5+GK/CGz63M5AhA+m7Eg9LI1ROQolhDvvDgJfclEk5ecFFRj7J5PqWYYhvC1fQYaDvp8ajB6AP7lFt83n+hRUgaUMuDjf/mXbUFjIIJKuG4XM9rKXF8fkc8vQ6vxH0lqXHBFETXH2xN/kyFEgsWVRstJQ+Nir33sdZZLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JjXcTEBu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A1EDw+Nl; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JjXcTEBu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A1EDw+Nl"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4EF0D1140093;
	Wed, 22 Jan 2025 07:06:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 22 Jan 2025 07:06:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737547562;
	 x=1737633962; bh=r2mq0WnjDXC93wE6KxVmJ/vjseMvebLzVAW/TFGnpLg=; b=
	JjXcTEBu8fsioXX04+oxP5soEHbNGP30KGCUgh6B7Hd0Buyyv9vTEjThuIRfwz2z
	IarG3clu4UQw4tByXQY4Kq2SaUsV2E6zpFPTm/zivbceN8nxx5WKmZ1ot0WGhmNp
	/AsXj5m5M2jAxLjPcQqFq5SEePLYl8fly5gg5lqPt/fjAGNmtXHihPs6yWWTDIet
	xslU0UXWVByyRfCm9Lk7xmwdrC04iNMPoYX1O98aw9eNGICUtri2QxlTJQEYC4+T
	7m+0kgwKclgnPpuiT92Ku5toio5SP1Smb+M+6SiZ3KaiUc0hbzLcimB8th1OBuUh
	ZFXjMX7ZbF39tHTSQ+lexQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737547562; x=
	1737633962; bh=r2mq0WnjDXC93wE6KxVmJ/vjseMvebLzVAW/TFGnpLg=; b=A
	1EDw+Nlfu2ISp1XH70++sb4U9tksD82455RRaVwfcaRVY+X/gqRDR1eX/aUlunFR
	vUJGAMn84aaLfG3xg43Oj45+ZD64eEGEqvUQKUqs0E9GKq1sh7XC6PyOVCUAb4lF
	wMqJxryKmT4YX1ucK4lzAZX4T6dxaZ6VBGn2ZJFYsaca5mFolby0MsK/TeuJfs6l
	ho2/yHnMb4dAHf94uvD7MP9CgvkXyBLEVg2S3MAmfJsSd1Sy2Vg+BEIUgBI3ailp
	UFlrxpU4ELT4staAKPBGIquZpu243zTe2q/DK7rMhMY5IPcyYM5d8EKuShFaDBtM
	NPnnC6xb8zgamGBLUkLaQ==
X-ME-Sender: <xms:Kt-QZ0viCBng80HhLUHayv3wajDW-js8_irIe7BMk3G7qWZnmWNXwA>
    <xme:Kt-QZxfYMZPGVJxlgWX5KoY_PNXtlxO4LCWBVKJRdPw7w0DV7YRpmzj8JPptazU67
    j7CYYnTnJGS4LImVQ>
X-ME-Received: <xmr:Kt-QZ_wD8pIxJfk8V2qUafAyEvo5ItCOtnbAkAbh2hX08Irwf7cVI8yaNx-C5dkerhd_aKCFe5Ub-VLjxSaXY9GKOg9wrwemoUSosX1NGCdI9XU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrghrth
    iisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepvghvrghnrdhmrghrthhinhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Kt-QZ3OG03lr9zSxDFjNcwf5xZnyoTxhSi6X6wEtpYtfVCPT3zoiRA>
    <xmx:Kt-QZ09VI9KPqn-xzFbguzOntT9RVVBC8hd0TAdwfmf278xxWFDRLw>
    <xmx:Kt-QZ_Xoat9CQQswRhH0cSLIqbqSpqwsABv4KSzPEfC4xZXhx0MZJQ>
    <xmx:Kt-QZ9ffStg_16AWtM5B1847LXIgIQ0ZZ0gaOJlaoiJesVpfpxImFA>
    <xmx:Kt-QZ0xwb8LA5EXzanJLEfjDtkiHwps4MvAWz6CkKO6V_nV7BPOX_4Tu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 07:06:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 78fa226e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 12:05:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Jan 2025 13:05:52 +0100
Subject: [PATCH v3 09/11] meson: fix compilation with Visual Studio
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-b4-pks-meson-additions-v3-9-5a51eb5d3dcd@pks.im>
References: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
In-Reply-To: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

The Visual Studio compiler defaults to C89 unless explicitly asked to
use a different version of the C standard. We don't specify any C
standard at all though in our Meson build, and consequently compiling
Git fails:

    ...\git\git-compat-util.h(14): fatal error C1189: #error:  "Required C99 support is in a test phase.  Please see git-compat-util.h for more details."

Fix the issue by specifying the project's C standard. Funny enough,
specifying C99 does not work because apparently, `__STDC_VERSION__` is
not getting defined in that version at all. Instead, we have to specify
C11 as the project's C standard, which is also done in our CMake build
instructions.

We don't want to generally enforce C11 though, as our requiremets only
state that a C99 compiler is required. In fact, we don't even require
plain C99, but rather the GNU variant thereof.

Meson allows us to handle this case rather easily by specifying
"gnu99,c11", which will cause it to fall back to C11 in case GNU C99 is
unsupported. This feature has only been introduced with Meson 1.3.0
though, and we support 0.61.0 and newer. In case we use such an oldish
version though we fall back to requiring GNU99 unconditionally. This
means that Windows essentially requires Meson 1.3.0 and newer when using
Visual Studio, but I doubt that this is ever going to be a real problem.

Tested-by: M Hickford <mirth.hickford@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/meson.build b/meson.build
index 22dcd4aeee..af7ca042b9 100644
--- a/meson.build
+++ b/meson.build
@@ -178,6 +178,14 @@ project('git', 'c',
     capture: true,
     check: true,
   ).stdout().strip() : 'unknown',
+  default_options: [
+    # Git requires C99 with GNU extensions, which of course isn't supported by
+    # MSVC. Funny enough, C99 doesn't work with MSVC either, as it has only
+    # learned to define __STDC_VERSION__ with C11 and later. We thus require
+    # GNU C99 and fall back to C11. Meson only learned to handle the fallback
+    # with version 1.3.0, so on older versions we use GNU C99 unconditionally.
+    'c_std=' + (meson.version().version_compare('>=1.3.0') ? 'gnu99,c11' : 'gnu99'),
+  ],
 )
 
 fs = import('fs')

-- 
2.48.1.321.gbf1f004a4a.dirty

