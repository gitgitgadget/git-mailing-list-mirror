Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5B92EB1D
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 02:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742006967; cv=none; b=JMCwkB+dWyLWNX5ZIkxh53g9SGBVTurhEg1ElwXNrEkN4pbkYMFfGNE0BolYlhG3Uoq1VlFtIF21AVnt4mvjrwaK1P9IfK30Q/BcH8rHeL7NsQpTZQmMpHL4JYuochp/PdnSbzFLiy/cwPKmIkwgzO66N4Rf1ElGASu2MRh72q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742006967; c=relaxed/simple;
	bh=KvF01dtF3oZ/0pobUDsIDKjviipmr+w+MGGJXosAE6g=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=qS0917zWhxVaMj/vmxfRKPFRn7Flm8iqJ+WSHJslbzjwZGNay/rQBveo/gYSJp9n23PYrnP9sxCcXVHSVNMoUC9Uyf+QRoWHSVQaY1jmBTxZgKy9ZjhtWkxUKzfQrfkrMmFRQOVgzI9TyeX+uKHZSJcFVOuNxucWlEH+pfNrKzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=e3uSIylY; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="e3uSIylY"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id tHXbtGMnpvxWAtHXcteQBc; Sat, 15 Mar 2025 02:46:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1742006785; bh=DJs/JzRwdfOkJXRGUokp2YjiiT943LHGoUp1/dyBrvc=;
	h=Date:To:Cc:From:Subject;
	b=e3uSIylY9iGVDxcoQDwj1txWC9ZYk+hqhSf9bjI5oD/tXAtlL35FlHwzDD/QfdikT
	 cFkh5hx3x9+DEloupesdawfvJUjZIGSpznRqK+RnopMev8ZvxPpO0AioU8UsKrrlkI
	 MI6HofbUUfHUygytp3eJuWCJvIxf9Hryb2ATkYnrXDc3VQzyHlVCcxAJJCnLwHzwqK
	 gwCeggVgcef3vwO36lj5IrGeKaj/zS1sN0kUnGPmf2lsp+RWFI4h6TJzCl7CJ6Pwft
	 yctIqN2RSz70/fvQPKmfgTJ4yxAXMZjbxvvRDyoE6rHj24CVJPymCZezEu4xRuxs1O
	 zqm8EEkl85KSA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=QbDFvdbv c=1 sm=1 tr=0 ts=67d4ea01
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=jTtcdIhh7rpG9tgoBZEA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <d230e5a7-1b3d-4cf9-b30e-69471d1fbe9a@ramsayjones.plus.com>
Date: Sat, 15 Mar 2025 02:46:23 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Adam Dinwoodie <git@dinwoodie.org>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 01/12] meson.build: remove -DCURL_DISABLE_TYPECHECK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFTmjkE+vjkko/3G9Xj9EWkk/eHbScavDe01Vk+wAZBOaOHYRGHPp7yCJrX4uKtOxmSU8KsZtOZvGAeaw6kJsIyw2v2Yud0pXN7Ky5frr67SsBCpaOqg
 A+VmZ4BPrr92m6IDErYoAeWp4e35IfHRH2TZfeWcVP6mdignj/E4ClmQaREiMVBIyaMwXM58/+zu/aAUJWJKliwqztOsDI08nr8=


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
