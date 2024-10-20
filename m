Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDDC539A
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 00:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729385700; cv=none; b=kqUSlhuckZKur9VWfR2xwf8btvriKUpiOdbi0VvrdwSPMf/ETwiAKZdlfCbpEulfb9jP0vNkZiy4vy2wxlmCWdgzP9mqedUpE6HHNCK3KS8e67VuUCw/wZUmqntDI6Jz85x1YshcVe+BTadDoTqyrpJ7G74+D6Ry1mu98ixJz3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729385700; c=relaxed/simple;
	bh=ZDIEmLLr2xgwFppEPuXciC5BU3TlJa0E0FSfF2hkC54=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=kD1aKt2xPADKSY9IjHvm3s8d4Y5gpTgNz/uVCMzFlmGh/GfMmcjjgXrcAQ70Xb7V8L7rZpEotAPzeViT4JURUZJOsbhAHW6c5KYmgqO0XzNY+v/VGHeuCh86tDyma8qkz5pz2rjs4azRSpak9HsdjmfBF0CuRSNrDxijsWe6B00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=Hpz0UfkC; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Hpz0UfkC"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 2KDXt3Vkyx2dS2KDYt0Gzf; Sun, 20 Oct 2024 01:54:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1729385689; bh=/hatd6ZtkCwFgk28TRlZpE3ngbcHvQ51uFVnOz5zMzw=;
	h=Date:To:Cc:From:Subject;
	b=Hpz0UfkC94i5HbeIcWi/SZ7RhBT5u2vYycq4TsY9v+tHOv8PytBC/YWKVVirnnCJM
	 R3OiV9zPFfJBnJnKLrpfuIOJM5VAkNDMVo2q40CWh16Yh9yk9Ldo5+aDfPTv9Cgppc
	 O7HtaSuAq+lvj4/mwPK2Q59bHBZaXfVV31WQX3yasHRiXcUtSiQ6jobBfqdFa7t3Il
	 QxqUnM9PB/Jh5GUvH1ZF6ODrWdeWPowhrKvHOHSq/z4OyePCXa6+rY5g9Z7aybJJcL
	 Y8q3flAcQaTWvMobpmHuX1aboRSwgH++423nnjhfuwr/TNAljwHYB0pohG+peX/bpg
	 fSSVPNZjohjGg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=GMarEfNK c=1 sm=1 tr=0 ts=671454d9
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=v6-bqVf9BjhajyIGLyMA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <12325bcd-fc3b-4d2a-9ec5-20fa2b50297b@ramsayjones.plus.com>
Date: Sun, 20 Oct 2024 01:54:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Cc: GIT Mailing-list <git@vger.kernel.org>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] meson: fix meson build on 'seen' branch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFPerl5E3tSoz8uFzqmDbIeMLOqGs7giXk2wazWimU3nLVqgIzH8MO73dGjWZ1+TlHXiD3Ly6LLXFPoKXJSF2VMiGpKKA5vqvGcvkFnARNpQU+YyygGU
 KDygGF7s3QYTaWUrr4rCgeFCJN21srm+ez6JSNlCAS8KcoK8MIoN1tiwFCehbKsC5EXMgb/53AzHBMKmn+sk7QcASafZazcASIE=


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Taylor, Patrick,

I tested the v3 patches on the base mentioned in the cover letter
without issues. In the interim, I noticed that the v3 patches had
been queued on the 'seen' branch. I tested with make, as usual, then
with meson (on Linux). This patch was required to fix the meson build
(just in case you weren't already aware, although I suspect you are!).

ATB,
Ramsay Jones

 meson.build          | 3 +++
 t/helper/meson.build | 1 +
 2 files changed, 4 insertions(+)

diff --git a/meson.build b/meson.build
index 7c7a59d7fb..c057039ec0 100644
--- a/meson.build
+++ b/meson.build
@@ -65,6 +65,8 @@ libgit_sources = [
   'commit-graph.c',
   'commit-reach.c',
   'commit.c',
+  'common-exit.c',
+  'common-init.c',
   'compat/nonblock.c',
   'compat/obstack.c',
   'compat/terminal.c',
@@ -178,6 +180,7 @@ libgit_sources = [
   'patch-delta.c',
   'patch-ids.c',
   'path.c',
+  'path-walk.c',
   'pathspec.c',
   'pkt-line.c',
   'preload-index.c',
diff --git a/t/helper/meson.build b/t/helper/meson.build
index 5e83884246..f502d1aaa3 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -40,6 +40,7 @@ test_tool_sources = [
   'test-parse-pathspec-file.c',
   'test-partial-clone.c',
   'test-path-utils.c',
+  'test-path-walk.c',
   'test-pcre2-config.c',
   'test-pkt-line.c',
   'test-proc-receive.c',
-- 
2.47.0
