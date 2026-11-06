Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961017;
	b=4uGReAkURZLV8uXcR8AvN3YZJJ1rAXSe7IXnnYzrIBOu1+lVg5jDPbFML3fnBDT8TaGa
	 7LOtiRTXxBCKl7jlle/wxuIzytroBtdwmvhYF4UFAy4aM/5tWlco9CDWJ1wF3uIuU2Rgr
	 dG6dgTo/pLvLchEHriHskYcIlkE1tTHmbu1k7kPVXlVoesKpT+Q+NZ8B7nW+DJir+nITm
	 tAafgeU0i1hsxFM5jxOCiBSltiQnjG8wa/bmuX2BJbW6ryWTHXjrsXZ6LxJTfoewVRHJg
	 L+hU6DdOxlS9wbxa5Zq9JdNRj4L9FeKFuGJycOY9yu4DN0vBF+rOV30Ls/11jyOFS5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961017;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=HvR1o3Rt+O3njx1fkNQ+3xgc3oAGP4bE60fCSBpdZMA=;
	b=BgQikerbnnfwElByNQkp4f9rNWGvMM6uENKr3jM3p/OBEFMRp8kA7I77DFFh9XNYxl8P
	 EjJHhBQ1M5ys9sur1qBor07/Lt8SzazPpQ5plychzHAliPV0HADBvKfQMup4knhalv7X/
	 JqtkbAmF79spOLSbMPckCu1Kfl4fxqkTtp6TnGcv2u1S7CcPBVaoCFRyPEBObwmqEtj7R
	 eY4F1tk03zcIBMnZYfLfwdK2/7BzPrMEMuSmAHJBdEwD1Qi5fQXNipO76v5LxVqoU+qdb
	 IIoC+EN18L/Isc0JmsOM4iQJxwe9hx3JVnXZ5xU5Rt0w806klGM+RbfwZc5H5ZFEwmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=o6sQFukz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XoZ7r1s3;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22C6606A32E
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D22C6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=o6sQFukz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XoZ7r1s3
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1EE59EC0211
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 05:30:16 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 06 Nov 2026 05:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793961016;
	 x=1794047416; bh=HvR1o3Rt+O3njx1fkNQ+3xgc3oAGP4bE60fCSBpdZMA=; b=
	o6sQFukzQ8YXQOJVnld7WT8Ld+UJYzYibY7Xkwwu2gY/nYzMIFBExicV6a/gxWyc
	/ahtdOvF1uDmHsQ0C/4DLUbqHaEkyenDswK4peDPRXpLXKvvF074vezr+uHemRb7
	TZDTf88g8Cr8uFSRWSCJBm7+6ZnlvplZUO86Fsb6iuLGIz1RNIEddc4ohgH4wx3R
	034zDq3b0+DnUMKmDS4tXYCAcGdD9xiIuhhGWGL+2VGoR/jXwRkTF654qgekvDv7
	FH/0hR+42eUI/tg5EgsqCfuLUYHAkcOmdH6bpLxvw90GRhOMNRKG4lw+V/wTv9Ve
	68QxexRE6uxwUF0wfzOn6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793961016; x=
	1794047416; bh=HvR1o3Rt+O3njx1fkNQ+3xgc3oAGP4bE60fCSBpdZMA=; b=X
	oZ7r1s3X1EpCGLoQZO75AVujPoU4beiFaIfKsdT90p3vR55W3iss8z9x3czHCr9q
	/zAnmAvqniCNFcZrzqG+8TTavHQFHYQqP36irHw1Do+HU3tXDyUxwTGtMIu1vAbt
	FpnyxyI8fu27omgurLVUzucHKY28DT2m5Wdo52ezu7cwvJQq5JcUupCrXpJDU7Xl
	2kq+2CDO1knIaY6Uq63gu6/1re/1BJJuKi4snpA2D2ZaQH1jxhlNjaqipI1PBA4r
	LZS0VvR4wfCm1IhH5TsmIXo7F/6kj3c/6D7xRAPj+88KhpCHMJy1LWAJbcExhwej
	PuLmODIiC6EBwW8nbj6/w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793961016; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:F0e7SExdbo12PUFP0TIVhpuvqp+NVZc5PJeslqjCSDGOYq/
	UUaW0ag05F5lHkdYVLjHcEpj1/oZtQ/KSCh5Av0eSN+HhsEKJUwJeH3GPVUsRjgW
	HbtyFjTX7sqBY7PFSeGmYdS/BhHJ/SgUq32lN0Og7dCJaapVIXk0pU29WkeHXW6V
	omtzglN5F8IGaNvb82vtA/lDQhSIeJXVN79nwE/TZmaji0M4KWWnJcIXi6nEFW7o
	aAYbXackn5kN6WjAKvyJXlKM7ce1jMhzJONz0HqQP7KYPCpMdfHsHl201tyEpE6J
	iC+1OV4RQmWXlX6opDKR2vdFvPHz5LgGhnbE+0Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:OT0+/97uNtyUo+XQ2FGTet0X00LmPQMxzPBnCNuWC3I=:MXLekVNjwcXPKYBV9usnU55lC9cWjkUGXTD9CFfpNLc=;
X-ME-Sender: <xms:OKztatbnvgIJEkMQ9N7KTkc67nWCYX3XewJGuz9SQ0JqIeU5TRVT1A>
    <xme:OKztaqaZbtVqgq6Zwb9eUekLxz82krZxgRl-sPDBN1KAATbONd9acxq4M1PVwwvQc
    _-l5sxr2OXkPr6iCCvjbcajMWezAFXPoOanoxoVCszHabA0k0jHwUA>
X-ME-Received: <xmr:OKztatmFcwt3jSXpaOkz854jtzOfH5ssbh7CPsF56j8-JU9CC_3R53T0b4-G6E6GlQU2jg>
X-ME-Proxy-Cause: dmFkZTGAohKhTI20WoVqgI/VaFyawJHaD/3N4tsoMJr6M/rD0dE26f+p0+0Otw5132GQRn
    lHfMN6Vk1yMWEiArpti53C8RZ7GKYPVwdm8W1T9rrtKrcxk/cY9aDnr8SlaSK1nlAlS74O
    AEVHFUL0bARxAKdgeX8rA54iaDrp4WNqn5FPKIy9bLmizMl8shAoTP5GNMYz6d4igjjO5A
    ujhmdUa3H7AQnblMG9eMNm71pQJgeeSCHwxJP0XB3IbwzZADIWyOVR8dUVA/yvBdaCfSRj
    oxT0b03eE/bjFK+VKIYWBSt05yr5Dfg1jcUfEH9V4dPcD9nSQ+/u846RF8FwD6lyOQWjsT
    aV/cdbcM9XO6yeTQ3kb2rqhZGPfsz2KtxLj3ZYsLk6IUriGhh6pE04L7Oxl3PHm+ETA69N
    3pefFbgZYgUgteZQ2XRrE1IRGaXW4XO6Xiz1L26YAvvB6+K6/dmxbYJ/tXedfvEVqIh9Y4
    V+1aDVT94mJmW5S0QzHA490lhlvl3bU6MNcCLZMDWyWj9jqp5Kp3/GYh5KX/F6+33pqnG4
    kkk7fYpTGElGQfv8rrjfFtLyIk6OFrwTy5gEWG3aiFmtqltYN2Uv2aOQNFq9v+OYgKQAO3
    hZzRxXO9SrUw9XFctFprIX0CTfLO9P9oJm//E6RYeytmM6VqBIw6XMP0YW8A
X-ME-Proxy: <xmx:OKztamw8V2QXKDvw_4UdC2aKrCzUKSSzCMd64YA5AkMxEj-LpjU55A>
    <xmx:OKztarM_xF4sQB_-JRcb0I6OB0_LxOYB9D-5GorAJYZNVT8hHLEKiQ>
    <xmx:OKztaqTcZTsTpoPNqN0m96Mnqr5krPHcAuMipHhz112cv1sH7B_2SQ>
    <xmx:OKztapb8XknKL_GL60s1QLeCtIo3bLnr-UfExO3fF63FG7G0H4m_3w>
    <xmx:OKztan9dq20vv0OEQha_3ITeAC-jORoQGXh4DbQooJCYWxGx1z28YKgZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 05:30:15 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 74064737 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 10:30:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Nov 2026 11:30:03 +0100
Subject: [PATCH 3/7] ci: build optimized binaries with Meson
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
Message-Id: <20261106-pks-gitlab-ci-speedups-v1-3-1fa0374c7287@pks.im>
References: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
In-Reply-To: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
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
index 036d2f3c7f2..df82cd3a5df 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -189,7 +189,7 @@ build:msvc-meson:
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
2.56.0.500.g5d06dc02cd.dirty

