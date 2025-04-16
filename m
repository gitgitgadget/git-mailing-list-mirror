Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BF2241679
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 23:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744845558; cv=none; b=Fnf3eDUN+CarrbO1ujbN28PqqCNRb5u07gjZ+2W2QdUz+g/Us5s0W3bA10sTtsHnTMy5d94hnuHwcZ2iN7sUO1mKFMdWyTTXFfaVa9J7J3ugyb9vXZDyQGo8TI/8ppsZh3Waho6vj2pCfm6yWjh5w+e1dmPxI9CvCTxj/bZ/FAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744845558; c=relaxed/simple;
	bh=f0adEdphm6D1w5sI1UDtvwg1RNgImY2wgWCLVqXF8x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5KHpC0gxMF0+8OxdsLt4QQQNhdAKCTH0V2xahFSwgZCNse65+/pqQsh4R06viZYdBGiFocGk/VpLIaxkWPhAKxVIF0MtR2rq4brhKVqmzVOt08tATTijTgpR03vJQOfZnGCNxOILdJGlMqju5KSko55yNu2nJxExD3xIckIOgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=GGdJ7CSO; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="GGdJ7CSO"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 5C1quLy9hjZe55C2Fu8KP8; Thu, 17 Apr 2025 00:19:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744845555; bh=6BLxwGhSTMyZVlMf52Y5aa7oCWJkI1NpAoiBUH1U3GY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GGdJ7CSOsQv2JCkY21KSgC6I1KwzoYXKeHWkLxNKFgsA9LM8sLl9cuFXPChTze000
	 munGA341sec43nOR0iA/VAU2Yl8k83ayv+xUly8EowrdgznrwsUAEM40bxF6cAMf5w
	 Oeg+zOBecduUzjXMr3Kyz75uazDiQn9+Lg3cXk4lCVwGCbbu2a9DdAfKLhXX5dCSMF
	 kX/VuVvqe9bOGCX7UE2J5VI7+AVGxd0OZaptOEuMcNcMNcgdZc7Xo/6NhIkeGKk1OU
	 Rh4RG7aoFlRPQKca/+4cFRttYDuHN6A1sBxFHL6/NQ0WOvj5rPAKRKUcCuxOqFfNKZ
	 VoOi9X4gPxj0A==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UuDANPwB c=1 sm=1 tr=0 ts=68003af3
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=jTtcdIhh7rpG9tgoBZEA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 01/13] meson.build: remove -DCURL_DISABLE_TYPECHECK
Date: Thu, 17 Apr 2025 00:18:22 +0100
Message-ID: <20250416231835.2492562-2-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
References: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCkIDeVaHQH+ElRfKakhANtsj/jqof5Y7NluH3xX8TfyuUMvjYifuftdQZQie/UMlRC5qvRsXQIbxs3C+Ex6puNDa977P3/HwwHqZWsAynXLqKFfvtdn
 ogVlblcdz/gif79vsJR1LP+Yckqoxs8JcEKzeT6qxsJ7hSLoqL6VwQ41uSGlwzRJ5UYr7TrLud/zn/nChXGXhN9CGFdKGdiDVUU=

Commit 9371322a60 ("sparse: suppress some \"using sizeof on a function\"
warnings", 2013-10-06) used target-specific variable assignments to add
-DCURL_DISABLE_TYPECHECK to SPARSE_FLAGS for each of the files affected
by the "typecheck-gcc.h" warnings. (http-push.c, http.c, http-walker.c
and remote-curl.c).

These warnings are only issued by sparse, and not by gcc, so we do not
want to disable the 'type checking' for non-sparse targets. The meson
build does not provide any sparse targets, so there is no need to use
the CURL_DISABLE_TYPECHECK preprocessor flag with the c compiler.

In order to re-enable the curl 'type checking' in the meson build, remove
the assignment of -DCURL_DISABLE_TYPECHECK to libgit_c_args.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/meson.build b/meson.build
index efe2871c9d..88a29fd043 100644
--- a/meson.build
+++ b/meson.build
@@ -966,7 +966,6 @@ if curl.found()
   # Most executables don't have to link against libcurl, but we still need its
   # include directories so that we can resolve LIBCURL_VERSION in "help.c".
   libgit_dependencies += curl.partial_dependency(includes: true)
-  libgit_c_args += '-DCURL_DISABLE_TYPECHECK'
   build_options_config.set('NO_CURL', '')
 else
   libgit_c_args += '-DNO_CURL'
-- 
2.49.0

