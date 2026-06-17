Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EEA3D9DCA
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691080; cv=none; b=TR23boA1+U5gimgFpw9ztqL/N4+UHoXDYLeVf57MjVYEE0mI75u45/B3I19F6TVeW9YthStBAGuXIAeelDv8cPJcrX00YuL3blNzFlMfwGWeCXvHgHJ+V6ctvdLKUv23TcE6EekOx5nTtX7EMRIrwXphYRLnoUPhm4zPe7BIh8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691080; c=relaxed/simple;
	bh=acYhllvuDbXQXTK/QPpaBp6cCU72JJZwIv2Gk5RgljQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=hcLIzGvSwjrpjVl0+3dHEPYhlfQvylMZb9kdZlQzoP+lMEF8L1GehE+xfnwicjwUlmjJj8MVr9sRMbx0SdxTzYThjg3rSsGbVq5TkiBNoUdW6Q3R6r/slQy5pQJ9bxw/eJ6FhN5tkV1zPdyS7CLTL/MDRJIAggwn1+UnsmK4IT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YD/cVZeN; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD/cVZeN"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e71dd64ea2so3253201a34.3
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 03:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781691076; x=1782295876; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p0TVfUE7kZfb8lDuy0pwSCfSGdrDZzBaQTmjAt7VUR0=;
        b=YD/cVZeNYQcu9yG9Akov/HQwJ3qrGmGB9KPSVFG/GOfG0AhCy2kULjsxHg15CRpOEm
         BzgX6V0rFcdFoQ0LLKlzFLj3y1n0QCVfzvFCfPpykk3ZK5qX+kYgzmqSYFXwz7IhdGJf
         eIFKl2byhHpJ7XusUBmtx4bDPb7SRfVKXzgVMIad0gAsTJKoqh8hLv5xQXbQNNuEcSg3
         U+lkPg7Lac5v6L+NtUb2zotLtU4+KoqoX1Ivi4lN040hoW9JpHHLqFQnkOiSjQbSWRIu
         XTlre9HWGMSIEEAW6m451Zug7qHYZXlWCoOM7kD3YBjlo2hh9x4ZnbzlYkv72hoVUGDP
         jRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781691076; x=1782295876;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0TVfUE7kZfb8lDuy0pwSCfSGdrDZzBaQTmjAt7VUR0=;
        b=AU0No3ok2Itjd4h+K+S9ge7RwPiFo1KcTCj2QeTkB5PwV4K4bysYAg+JK6IIT0Zlhv
         UaFrOQI4ChQ7C5IvK1sMEp8IKteEpIXulyEfVLBWmn5JDIiaSf7x7NSJXsZg/vUYqH7j
         uvUhefXi2urcoECk0F7loSIpWdWqlPofagFsMCjll5raKfnrN7aa4nBnCLb6y28ZXFtL
         Ew13ow0s7ccmxZ43ZDA+JEdPV24asxOE2qt65264DHwGZ/N42APCqpMfcob+z8CfCA93
         5iOwx91gN874ifIFk1aUSwBmQmF3SAAF6fyvwBXIF+OAjmyFckJZ+VQ9N/eet51ICgiR
         oVsA==
X-Gm-Message-State: AOJu0YzXHto7sxaC3THUikYnOXbxnMS9O8Iw28382/cPJh2+sNsi+dg0
	lJeyfO0PBbzxUDSPCg3/0LyeGckQmzwe0qyLaPXy+iBm5xK3iL7VvzjLCoAIjg==
X-Gm-Gg: Acq92OERbHQPsV5ckeMWSPrw37p44N7csaQYb0CsjnxJT+Fs0Qald8cbb/yKoeqx1TJ
	V+brEP35hOqJud12EHrcCNcxpDhUG2cw6rSCZCWk5kVOS1DXws3zf5/tpXlvkmss6DVBe2DABCW
	mXdf/st9KjGq7y6Il3P0OjfvFZx33MU19PxhrPZWZNlSzDQ6ntzrrVHocrwYwCV8VBweY8zT60+
	AZz4qZitEWvPxMrw8fO2GWSS6Gv6KBSreD1MvLvrZZEmda5bPEjAegD9Z+Oeyu7yugQ+D3CbfaM
	GAXjGhdXZr+RIKMm80cduSdoce2/m9BY6/o226OuPlNyQ+CNodO7Oq2JZ8xT/X2H+9QSK6DdUzE
	ecWekuDYGadSa3wG4EqkgUfX0oV4UMYCk059lqG5GYc7PqH/mF3cO7P7XYMShxWwkEb61t0HN1f
	a9edtX9u/af3H+CjShUk+eNh78cA==
X-Received: by 2002:a05:6830:2a17:b0:7e6:f083:1302 with SMTP id 46e09a7af769-7e90b37c71amr2686847a34.2.1781691076537;
        Wed, 17 Jun 2026 03:11:16 -0700 (PDT)
Received: from [127.0.0.1] ([135.119.38.33])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e907248dc7sm2909040a34.21.2026.06.17.03.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 03:11:15 -0700 (PDT)
Message-Id: <pull.2154.git.1781691074710.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Jun 2026 10:11:13 +0000
Subject: [PATCH] osxkeychain: fix build with Rust
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Without NO_RUST defined, the varint encoder/decoder lives in the
RUST_LIB, which needs to be linked. Symptom:

cc [... -o contrib/credential/osxkeychain/git-credential-osxkeychain [...]
Undefined symbols for architecture x86_64:
  "_decode_varint", referenced from:
      _read_untracked_extension in libgit.a[x86_64][63](dir.o)
      _read_untracked_extension in libgit.a[x86_64][63](dir.o)
      _read_one_dir in libgit.a[x86_64][63](dir.o)
      _read_one_dir in libgit.a[x86_64][63](dir.o)
      _load_cache_entry_block in libgit.a[x86_64][174](read-cache.o)
  "_encode_varint", referenced from:
      _write_untracked_extension in libgit.a[x86_64][63](dir.o)
      _write_untracked_extension in libgit.a[x86_64][63](dir.o)
      _write_untracked_extension in libgit.a[x86_64][63](dir.o)
      _write_one_dir in libgit.a[x86_64][63](dir.o)
      _write_one_dir in libgit.a[x86_64][63](dir.o)
      _do_write_index in libgit.a[x86_64][174](read-cache.o)
ld: symbol(s) not found for architecture x86_64

While it is curious why these functions are needed at all (osxkeychain
does not read or write the index), the compile error is a real problem.

Instead of trying to play games to add `GITLIBS` while filtering out
`common-main.o`, replace the `$(LIB_FILE) $(EXTLIBS)` construct with the
much shorter `$(LIBS)` construct that _already_ filters out
`common-main.o` and adds the Rust library when needed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    osxkeychain: fix build with Rust
    
    I ran into this when trying to build Microsoft Git v2.55.0-rc0. This
    seems to be similar in spirit to
    https://lore.kernel.org/git/pull.2288.git.git.1778001976709.gitgitgadget@gmail.com/
    but the latter seems not to have gained traction. This build failure is
    a hard regression in v2.55.0, though.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2154%2Fdscho%2Fosxkeychain-vs-rust-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2154/dscho/osxkeychain-vs-rust-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2154

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 0976a69b4c..1cec251f43 100644
--- a/Makefile
+++ b/Makefile
@@ -4074,7 +4074,7 @@ contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
 
 contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) GIT-LDFLAGS
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
-		$(filter %.o,$^) $(LIB_FILE) $(EXTLIBS) -framework Security -framework CoreFoundation
+		$(filter %.o,$^) $(LIBS) -framework Security -framework CoreFoundation
 
 contrib/credential/osxkeychain/git-credential-osxkeychain.o: contrib/credential/osxkeychain/git-credential-osxkeychain.c GIT-CFLAGS
 	$(QUIET_LINK)$(CC) -o $@ -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<

base-commit: 0fae78c9d55efe705877ea537fe42c59164ccd94
-- 
gitgitgadget
