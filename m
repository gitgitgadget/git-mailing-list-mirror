Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792553824;
	b=4G9qHlQDoQ2Tb/dfzdYqWlhEMuso2ks6Y8E5Ns++mmVIS/1D4a8xJGec3tlzP86w99uA
	 2jr6jOym3vaSvYlXBuP7JNCyKAY/OgxMi7XuClMVx4zPABwBSg19vEXU5ENp2SZR2+Qp0
	 znMbFIFMRZtKtAL7/L9yBm7WnM2VwXvf7BQcC9OemwQgicfH9dyWdyrkSsUZFSs7Ax5Ql
	 Fwx32Asi2LHWlW1qek/qlQfXBsYydqgjuInXD+JTULMnuNoIs+bz6ic9J9DkSNfj5nfEe
	 uAITOYQfMvr3u+ABcwUdJkyJ74SoXAMK85cqAe5go0nt7ummcUw0jzYrBUa6A8ZwWGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792553824;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=a4p5YcRTbFd6iBBTtlGAwcMrnGh8sXFrl6i0flXolr0=;
	b=SxeV5zxWeg739MW7QHuL1cL0ZcgmbHL+adnbousVkHNNN5RfdhvnScuAn0bgfFykTgjR
	 VZdrsJsZkfBNIQX+Hb3QbZtDFEGgNWk7bepiwi259XyuhunN/7rzkcakb2u2eT/0II3Cs
	 Tqfho9VRI5j25+i2nKmRp8JWUekugmHnC28Ro5PHx9Iqm2bZNUtjsSDhm/VFEMf+ec6KW
	 xfqYW9YbU2FrWC+/yWkWJ34JFLrddTF8ILu3uye+lLROuF8U53wTOIyoeCvBb04pbUhEd
	 YTsP+RPh1CFur9k03oMAgBauOnJfm5qjENECJ2UrSlM1GPKRqeU7FJXYYCdq5YbFI5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ANtxSwjZ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=JrOKYJSC;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D64606A31B
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 03:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2D64606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ANtxSwjZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=JrOKYJSC
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D6E80EC00A0
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 23:37:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 20 Oct 2026 23:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792553822; x=1792640222; bh=a4p5YcRTbF
	d6iBBTtlGAwcMrnGh8sXFrl6i0flXolr0=; b=ANtxSwjZM4hcnyWBw+1fg/8EG5
	G/zDcHs81hW6ZjwA+2EPolx85+NKkGhJAurcqHMKlZA/aLprVxBadDVSsVQP56ln
	sJYKcs9EkmoBjuaSZasQAnmaegn19ffdWvY/QJEocQxrWGLrqCbZrIB9O4MkTy8U
	C5MerGxQ9/SXAYIM5WtiiOErtXH4vlsqSKsKmajqsQNgodFRwoBh07MseB5UloRC
	qtR9R2EKQmHmPIRfC2c1p3VbSJuFei1Xxqqsfm6RYuL+uJCTcBtVKtHZu9R/y8E8
	jpDIMVRxl0m3tnykY64fmOaeemoWJgQtIJhWecAHfTrT1jpvMfgYo31l23lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792553822; x=1792640222; bh=a4p5YcRTbFd6iBBTtlGAwcMrnGh8sXFrl6i
	0flXolr0=; b=JrOKYJSCUKirIsY23W/pSO5vndLCPU898NggZIbaDpLUnSKqxx/
	NrirvCtJ4NzHgdTwwSIDpIELmi8pp0bgT1YMkry+fRO2SeduwUmtmkC1BhdKZrE2
	ED1jjK3qi9Z6MW/DXzWuRorov2cEz4LlpQsa4AfZB05CZJZYcMrQvmO4VqI1l4IP
	si7x9/r/iFl7qBnmYtQ8rp5T6+shqDyjMAZT3uuFDsi8blESOqyb2PvbJngGCHee
	BGNKYSVo++dIblFGMvFgGvQfaK64elOl1ghIKeHsgyz0KdJh9j5QklXl31WSFniB
	zgyx8Sa+TVl6BiAD8W5tbMorw7a2/X8ALyA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792553822; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:cQHTUVZQz5yO9N4DHGolFh70coxlv+324X0tSlpbcACG8h8
	r1pPCjND7MAwUHStY5kCfhsJPf5NMOcesr518ocnrer5/pth4b41YaXW4ZhQr8Z+
	gqTAKAg1zplglizc2qnrd8MbI1xt4IOpxNOrzk100xNpjG3hzNgUuD9if4j8Wzee
	fm3Daz85a5FXhye/gIbuKkCs0lA2EQ+BPvBSXNXXGj+2LWEhp1CH3uf3cF+27UqZ
	RdUoYe2MNMeSmyIjGIRDuCpfyxctQAcL/ibLy9mE5FrkpbFtXwQ2psanj6i9T67B
	Piqx79XiauRz88QCcDwc/lZqajhIUpn7Pj+xj9A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:IEYl5Az6f4stJ+NTqxbPbn/FnSC4eDyoIo/1O4Ppblw=:5tf7VVX8r2T2pEGM/KJgLEPY8iXwl8sFoyqu7zMIUSQ=;
X-ME-Sender: <xms:XjPYar1Ns7VwkzjmR8ALgz0I9Rz8dc7IHcpWd-c8LYoJG8dP83RzVg>
    <xme:XjPYagGH_92qVz2WjXK4uBZfTtrkhsV800hYl8zLrP1QvuGcVeKZWpqXmj3eLdVoX
    tEa9XOBEmrRke2rR7QOAcdRRWzq7OqrqaTDqb7aPNx2-OEMUtxk3v8>
X-ME-Received: <xmr:XjPYaphXTKAAgaZcOC_L44Zz3QyjKLXDlwsf4T-78Op4aXoqyJ7LNk9jZm8-jPi0MET8hrGO1fHiRV9dvUPnJuolM6NiujBL0LoD>
X-ME-Proxy-Cause: dmFkZTEoMajsdGkLGZ2sed6cZfLqxslnEHN9GYbwh2+vyHhVMKLEcM6HHiCHPcQnNgh/BD
    ZpwuSBeq3okv8DBsNVJmltz6enzeg91AeofCrl7tXRpdNOOe5BSSO5Ufs/u4GC9uQqJlxT
    q50MluvSbwA8xO9z3nTQM2TjRpQO6+O+uPr0oVEifjLrSOdyH2lxU1l2ZUrdjt9JCULfyZ
    hrr0viSFT7Bsd8t/OsCIeT8r9o9AeKgPG7a/wFWTLuoM85k55Q5xzGlMhVJXfJ+nuuPZVG
    NCLai0IjBVAElgg6CGmQNWh7g1NulgLKKHXbwSLYC45nJCF1/RrgjUKslyqH49AlOF+pQo
    3VcqWGKxCbXQz+BjhJ4xT9u+6OpRueUv1xz5eE+jViExweYPzmgwr9vF9LAfI4oZwX5pTe
    5me+Vz9Rme7JJp0jgAU0tZXoHFZviJ6HkLG4sbqqk3tSsXH/MybamQEvQgxGlT3Kc6XjPs
    1MKn4I6A72x5BQDjqJgmcj8jxokwz6Sv6yiNlLFUQzrlf1tS47aU6oAWHHsAJeZrGh+S49
    HelfGy7wPf3aedpAsZ1AeUTEmbSeyoFP1m7f9HYK7mhXC/ash7nOK3iaMIHsTkISQAxVmn
    NySgv8I0RPsn7RJ1qCbCsBuPD6I8HdL8zBcJtfMAnEQ6Geq+hs8aZou+CgUg
X-ME-Proxy: <xmx:XjPYar8kLo-HU4FPq4wtftItBHnAi0SMUSVz3PLtTbfUsBz5WJqFZw>
    <xmx:XjPYagq9g9c91m00GvcASftXpSoiOjqB3aHYqX5j9A1neuGVjR5sPw>
    <xmx:XjPYaq9kvq3iIMbDDxZo1SR1tPWQn6NEhGrSx3SfJi6hxqcZVDzf_g>
    <xmx:XjPYakXLbnfTQXSk7gWqFGzPDeoXrm7-Y_Rz6oWl2S5MTvZzs2lJfg>
    <xmx:XjPYanP-ulFHfeGz26aa-EBd2rzLAMMWOBkthg_D2BxPTNB7H9kcbj_R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 23:37:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v5] github-ci: update macos jobs to macos-15
In-Reply-To: <xmqqfqy5clgz.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	16 Oct 2026 15:46:36 -0700")
References: <xmqqfqy5clgz.fsf@gitster.g>
Date: Tue, 20 Oct 2026 20:37:00 -0700
Message-ID: <xmqqa4o7sp0j.fsf@gitster.g>
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

GitHub from <no-reply@github.com> address keeps sending

  Subject: [Action Required] macOS 14 hosted runner image is closing down

and suggests to update to either macos-latest (macos-26) or
macos-15.  Use macos-15 for two of the four osx-* jobs, and
macos-26 for the other two jobs.  Use explicit version number
"26" instead of "latest" so that we can more easily tell the
differences and similarities between github-ci and gitlab-ci
and compare their outcome on the same commit when needed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .github/workflows/main.yml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index b229739be8..f37834326f 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -349,16 +349,16 @@ jobs:
         vector:
           - jobname: osx-clang
             cc: clang
-            pool: macos-14
+            pool: macos-15
           - jobname: osx-reftable
             cc: clang
-            pool: macos-14
+            pool: macos-26
           - jobname: osx-gcc
             cc: gcc-13
-            pool: macos-14
+            pool: macos-26
           - jobname: osx-meson
             cc: clang
-            pool: macos-14
+            pool: macos-15
     env:
       CC: ${{matrix.vector.cc}}
       CC_PACKAGE: ${{matrix.vector.cc_package}}
-- 
2.56.0-321-ga7e4057184

