Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394091;
	b=ufX2sNstYfqoo9FMrNMg4WaVbe86uIuB1b9nIClEVT3KoAicTTjVashSpuoe0cYdOA8w
	 XDbDffzwkIGV2PXK5N4AhKANUpGBHANkFGOFBzyNgygrJe8JiCJK+Z2BRyH44UY3Dw0Hz
	 EZTJIwzSdttpHCCITX6mHsyYMnYqjQRK8D3enGs7MrlFm7akMo4gULanfolhYUNiV1qVa
	 Eyt0BrIMSxrtfz+tDqwcz9TYx5ItaiiEy4zzsN0ypBkPcKfTSuypfj2yBRXjM+j7ogAzz
	 RC7+ehnYJwYdwmG93o1e0agcznRTYPghQUkINnMo3ewxaMQ0EV3tqA4Uyxi/fk4cjLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394091;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=zwbPteLq67AmqAX55qCHUk/xL67nVGvx8S2LNwdWlCo=;
	b=BrbVyJnfmOhKBzSs72eIOgtvVytSs5GSb4515MRaouhafxedOMUnvlPO5YCfUqONHj2u
	 ditd+iKtLYnDn48THdSN5aSSbg2NIh6k0DtMjakYVsQex1F5ztnm0r4HD0jcIAMGvVMl0
	 M69qjNAeU6ZEcmdGV4HmfepQAEjcTHxMDrBfkVKUaDZZQYlF5AbjF3WslnDxioWW+odUf
	 YE7Sk1nv/NyooPV8ophEhb3ZvfK96CPykERJeVgdWx9OH3IIA9Fwncsf8muzwNgbgC0Bf
	 z7KARVdc+acvxCczOIJOFajdYVcawETguXsq41BycyjIife+P104V0c2F/ukZE8H58A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Taz5qox3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=HQvbc8JW;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A49606A32A
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 10:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02A49606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Taz5qox3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=HQvbc8JW
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D69FEC088A
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 05:48:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 05:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794394090;
	 x=1794480490; bh=zwbPteLq67AmqAX55qCHUk/xL67nVGvx8S2LNwdWlCo=; b=
	Taz5qox3woADYgvpiSWKu7xowxHtWFoozavz8ft8zohN6sP01+62+06FOptZ2li+
	Ac3WCBSbZi6U6CpOlY4Zdn1k9pZMczFRn1YmVClhmBjakqGqpLPaIyjl6b4sO2rO
	3Mdokaf9qg/vsc55+Bsq9iPx4Hl8ShEinNmKw+WJpuTTsG/0PdbsXm+gpstxAdH4
	yBXJw+gSmOyUXFSwveogi1Qifi/hNwLGTns/EIdCtePn3gwSHFJXnEEeAiTdtLaO
	L9iXZET12zobF1uY48RtjTIRrdWRHBSrhyWjW80zP876+62bZN4TOn6teSOXa8dO
	3RTetCdJph/6BcIiHHkPKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794394090; x=
	1794480490; bh=zwbPteLq67AmqAX55qCHUk/xL67nVGvx8S2LNwdWlCo=; b=H
	Qvbc8JWJzyoJWg1YtP7QF/rddmiZyUdBIhpmYyO9JyIrXwQIu0jjfalAPBy5iy04
	oKabYlsZom02KjkrR64z22OT+mHxSTqSEHOq+eoOvTphD4feT0XJASiPMJJAamCQ
	+GWNc/arswfxaeEZ8hBjFQYR7i3z12NGgIcdHDxo3Df4xbFzV+FEYMNRHytpxP88
	iO55Iku+gTODVfnTf/DSRbzcfAr9Av8TsW9TMjMtbhkrXMfzpJZomJgaI1Je/MDu
	0tdY0ZMzm8aGDfNnMh0qcWdHfR2xswqzGhVgM6J2jycuK0gm0W10tlCk7Hp9vs0e
	330U5Sn5veQeGwW4R1H/g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794394090; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:wJpoTJnjyLT0MzA+Nj0KXDEMzbDrczeXiQxyftOLtx00PYA
	A+ANr+66F21q9rIc8Cd7FKMo0BqIbAA/Js1V2Ilj5FaCZnwqdRfaO5YeeLWfv/Ij
	Fcs3ZQC1NK2kBWhCRoFmAwzlXv4Bra7HZahbuLSY/RrgZGs8TraXaVRfD7fjG5uE
	y1/k4lLMokggoXQdk7njMjptRQstCPJ4DecwHZUgivgjoJ1iRVk/9LwhjVq7BiY5
	HjsRuZl8JMmx5sRTkDHJBg0zDak3tbWYo57Or0EEOnccvtBrYcCxtDVBN9hi3/lg
	INgqkA3kxyFHHZpH5LG4trB0oa258AEKTBYLKHg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:a0WCDy5Y5FMIiZKd6KM7gD3QH+LMJee+Q3vhPZqyGW4=:GPvCORn62Gv7bTKs50mRbLlJLBiIdwMLrRgAAxabCFg=;
X-ME-Sender: <xms:6kf0at6CEYnCD3Vp8mtu_f4E8uQV3fRiqzGHKg6LhUDjxVYK_LcGNQ>
    <xme:6kf0ah7t3qPmjqpUODMpvlXw5BDXbk44zwMuJ1GKgiS313VzySRQ2wEyMPj9yLXX1
    dNsJJ_CtFYvjacIBwoFqmCp9aBj0He506Yy03bphk0OMfuzYzvuZe0>
X-ME-Received: <xmr:6kf0apf3hRj12_gBYMYic988zwuyVXex8v9qzoSeOw3gZeq_atkBLNpCzrpqSx7f47vmKg>
X-ME-Proxy-Cause: dmFkZTF68gyuBnIeQdRwGHfH7RpIlBB8u9KW7pV3fOGC/OlYIHC/es/K1KGMlODmxVcYNN
    GcBPQs7w3Y96F0FmpqZnu4iQb4d4EpGTBCZXw7DiRDog/gQMeooaoeiW/rahAnDOA50GUb
    c4dB14xxYQkQBdSkZ9hjjF5SnZQiniIU+NLLiwFEAgUQn4fzO4lce5M4wUPVZoO4pDq27i
    jGd15xQCLdEN/tbUSivRW8Pi5kI7yyUpOYt6zWSIhNvjWLMuDwfacf+lDI/awuiTbTbZm7
    0Vo56/7kHJh2z0p0DOTgWIM0kwI3CjQPY7ZkNFI7u3pDe4mOu42s71W4yeK21amwK8V5T2
    SwdHzrPJh4mGxbm8BOW95nZZbfEMu5DbQWklSi/lXHCu4MVNmzGUs70lUZhDXwGB0qlwGx
    /tN74GXawJ8Qs7Ch0qYrx0Ykmzegs0MNQL66/yPc3TGviDGkr5Y2f5eQYucROLYmDLeCbT
    Esrjeafmh6YMJsjWphf1JMLZwaRjr+57HNnf6CXRRFELA2PSUIX6ijEs0Npdnz843qFdqF
    PU9fbDj+vqZdSLBUWjB5ivLTkZjZ4NFvrT1Gq3hbwwRx5+3/FUGejQZ7Qa2mpVL61BpFkK
    vUhoNI5Gj/DKVS+45vr12dqES266mN5EOiDWNxwegW+Je+zTwSujqymTi46A
X-ME-Proxy: <xmx:6kf0alAj0NdhAVPZjJz3gBmI8w2tBwD9BIH1tUYbx8S0oNmBXyV3zA>
    <xmx:6kf0as8eWn6rQb-9Q8JhlLGPNzzhnRCXjrVQB5FHBbP7-AvgVIrq9w>
    <xmx:6kf0agJmd_tMlWIBJbrHcVSYWxAtUH6kC0h_dQnO23Ro_RddcE_kFg>
    <xmx:6kf0alhOP6Ukz5htwUJJ8bNCs_pndx2vr29d6BDHTYtDyda1r4rdUg>
    <xmx:6kf0aoyaBE0MJTTm4JFHXGqbC0l4-xnIOc9Ia8GSSxgMJeKpA7X0O_P7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 05:48:09 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bf7c7e78 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 10:48:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Nov 2026 11:47:54 +0100
Subject: [PATCH v3 3/7] ci: build optimized binaries with Meson
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
Message-Id: <20261111-pks-gitlab-ci-speedups-v3-3-d1e34117ee2e@pks.im>
References: <20261111-pks-gitlab-ci-speedups-v3-0-d1e34117ee2e@pks.im>
In-Reply-To: <20261111-pks-gitlab-ci-speedups-v3-0-d1e34117ee2e@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: b4 0.15.2

When taking a look at our CI jobs one will quickly notice that across
the Linux-based jobs, the "fedora-breaking-changes-meson" job is running
significantly longer than any of the other jobs. While most Linux jobs
only run around 15 minutes, that particular job runs roughly twice as
long.

The root cause of this is a combination of two different things:

  - The job uses Meson to compile Git, and Meson by default uses the
    "debug" build type that translates into "-O0". Our Makefile in
    contrast to that uses "-g -O2" by default.

  - The job enables breaking changes and thus runs with SHA256 by
    default with the "block" backend, which benefits heavily from
    compiler optimizations. For example, hashing a 500MB blob with
    SHA256 takes 9.6 seconds with "-O0", whereas it takes only 1.5
    seconds with "-O2". The SHA1 code path only slows down from 0.9
    seconds to 2.1 seconds with "-O0".

Of course, compiling without optimizations also has an impact on all the
other jobs, but the Fedora job is by far the most impacted one.

Speed up executing the tests by using the "debugoptimized" build type
instead. This reduces the runtime of "fedora-breaking-changes-meson"
from 2100 to 1000 seconds. Other Linux- and macOS-based jobs benefit as
well, but they only speed up by around ~10%.

On Windows though this is a bit more muddy, as the build step gets
almost two minutes slower, whereas tests only run ~10% faster. Combined
though the total run time is roughly the same before and after this
change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml            | 2 +-
 ci/run-build-and-tests.sh | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3631393a8cc..449fed1b392 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -182,7 +182,7 @@ build:msvc-meson:
   extends: .msvc-meson
   stage: build
   script:
-    - meson setup build --vsenv -Dperl=disabled -Dbackend_max_links=1 -Dcredential_helpers=wincred -Dtest_output_directory="$TEST_OUTPUT_DIRECTORY"
+    - meson setup build --vsenv --buildtype=debugoptimized -Dperl=disabled -Dbackend_max_links=1 -Dcredential_helpers=wincred -Dtest_output_directory="$TEST_OUTPUT_DIRECTORY"
     - meson compile -C build
   artifacts:
     paths:
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 68b91e31439..fd8136af342 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -55,6 +55,7 @@ case "$jobname" in
 		--fatal-meson-warnings \
 		--warnlevel 2 --werror \
 		--wrap-mode nofallback \
+		--buildtype=debugoptimized \
 		-Dfuzzers=true \
 		-Dtest_output_directory="${TEST_OUTPUT_DIRECTORY:-$(pwd)/t}" \
 		$MESONFLAGS

-- 
2.56.0.611.g1030f0b940.dirty

