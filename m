Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792662436;
	b=eGEK8uqo97PxH1NB5bNkpm6xqJ70EJfs9bYnyVexZvzLm6j8M7pmb4XYTmQH9Lb3LHy+
	 oa14+0a87blyM9qJtSx1pc7TFNUQBz9+YdH4YReb2bi79DLyFSavhhpkUeO4efpFUjmbr
	 LHfWAWAOdSnuRXEeyYyOrCNuNPiNvys0zrFeie2iTizjd/1NX73VZiJYUD+iftN4dyBgW
	 qbWJJlndwFxI5m/CIhn8VvKHySm6ThqoyvbYc1JggDjtBXpacHsYurvbDfQq/4n8ydDRL
	 dEZI5eENWFP3PVPLctow+SM4XI2Etf4/eCzFmEpkc5RyHIfA15gk1P80MQJxt83KguQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=9q11YqtnuZai/AUgbMmLnVNwWFeyd5o7rtmYPoLdPVI=;
	b=zUjYNgZYwGC5bkHzQnFukjrsRJ7dgrpMTpLkQsOErFmsfkA8M27EJiBAl4GMJGx1XV0Y
	 cF15+130rlW8SS0xyQ9Ts2Q0MF3FnXb4xMt90sozt2aultBb7QaDb/hsd5dAF8AOerXQw
	 L7HO/cegM9ipFjS0THZC5O0sdI2pow3xGG3iA/Z+vwK0SnBYOkWeSzJo3ruCMxs5gvgzK
	 SPxIFYRb9uQzRfWS+Bnh2Qa89aKxdWS/Oujqs6vUcmFL4syqPAoG45P+6q6aYK623BBU/
	 kLpfw7SXZwZJDjQdBcnu0EKxO92rJ/WRDBg24jNH7/ho1FJdD6E8UYoCThkBW+k6Fqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qdoZ5Rqn;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C510B606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 09:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C510B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qdoZ5Rqn
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35943f55c06so948055eec.0
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 02:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792662435; x=1793267235; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9q11YqtnuZai/AUgbMmLnVNwWFeyd5o7rtmYPoLdPVI=;
        b=qdoZ5Rqn9VCIp/hZc2Q0XK0m0iEl0PcMMXW4shSinapupLoqdJGP30sxEe82kizLjq
         /FIHFApgYrIl0rN9jCqtbmTyryDklYLPnOZNt8KvU0LAaucMkN9O2ieX76GBfCuc+DCG
         fgIR7Tyurs20JcgD5z/UtRqXmGDRoMGu/IR2QYzTKAMPMSIIssh5qi9IpMWlFzxkPTwc
         MbrTp1DZxJ3JqdGvobo4lNZ3OUPzdvjA4g6KzKAtgC7PQXZpOVYTzNNZENjIzLKZVpj1
         2crD+BrslOIvWNi/XpBqzh1RKWj+zn/IOCe5665NqQqHa9K5P6G103TwaH4S6ShArGX/
         9AGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792662435; x=1793267235;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9q11YqtnuZai/AUgbMmLnVNwWFeyd5o7rtmYPoLdPVI=;
        b=aJ55CcijfjFyOIkbbX7hAwn48CkhTRTWBmsgs+uAVrRp1qNgSDs2aGt3TkOO8FQ8bq
         wDTgWsjzFP+Gt/8hBfjPVvstnSAAgihuizaE975kQhRePWa37GXI6CbftEJeDCzniUlh
         p5CbXvvl42UzICeAFZ4flRhUAy6AspdyAxeX23LSWPKo//rTsY9ft+koRiw/9Dp6P6VC
         HscmHN3CaAE0Rm7nyj5VQ9P7JNh5dqXFQ7EuQa8/06SBqwNblDmcdM0Tmj2N4BhQs+jn
         0m+0Fo0nmhXII/ZxfBwbEtZE1L3jeCpfE92k6ZFtRDBsEJxLZqQR13oCc+Wgh7TGeLyL
         6l/g==
X-Gm-Message-State: AFq9FYLIe1vLFv9zzxYVDdM5/8j/od4/Q4LqyrsCygWuvX90RGvwOtDk
	CQHMWI/RJKgEQB7OJAAU0i5zOYYRlKk+hYJwMtpv9Eyl7WMEqhMdedwkPcJSng==
X-Gm-Gg: AYBFou2Z5sJsB/FUcbp7ixupVRieZi2CyxjKsjxxVlypnhdOeNLTut+ZH+rquNpa6HC
	hBnMsJ3dh2fCDgSDI27/Vu4WW6nWpqZHQ11pcWjMLB/RZephq8s2e18+QW0v8zkpg7Ol2Y0csE2
	RJ8RUw/twzC+POTN3QPxcTsQQe5UI3C5Ac7buRq+PJwc3DPYlNJ3oekvkgBoLKRKRcm7yGwMogV
	Zax8c924tkZpkMOSqfaMmhKTdSqCbas2oOVN/S6PuuRv57bJMa5yf6ZS2Y9g4X5L9RBve3cYo7L
	2ZbrKPK/0unfsv7BqnCYCmLR2aQH5ZxsWdMUxkygW1kSsEUemtVPHWXSuMfKoh81HTgAuSkFioJ
	H4Ky8hBUTBzYUij8/+bTYv0lMlsL5gf3WJFmfcdIWmvI38fAzs2e2ILpO8V/ztdAKmB0c6WSQS1
	FTrcZjjmw6Grw6icWiwSt53IGGKZ7YtT80Tolg3jlD1yDn5TdoqBnSEQPaaDNzD29pp7T4QyxKo
	C0SSiTXup1DlbwUkTtVlIaEIfgVxnSXF/OH6RqDsWweoPI1ulEIMAVDtq/m
X-Received: by 2002:a05:693c:20c5:20b0:343:5f5f:eef0 with SMTP id 5a478bee46e88-368b0d402f2mr2463931eec.21.1792662433812;
        Thu, 22 Oct 2026 02:47:13 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.245.141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36741e71eaesm31068176eec.26.2026.10.22.02.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:47:13 -0700 (PDT)
Message-Id: <pull.2271.v2.git.1792662432.gitgitgadget@gmail.com>
In-Reply-To: <pull.2271.git.1792522587065.gitgitgadget@gmail.com>
References: <pull.2271.git.1792522587065.gitgitgadget@gmail.com>
From: "Joy via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Oct 2026 09:47:10 +0000
Subject: [PATCH v2 0/2] config: move pack size limit into repo config
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "Patrick Steinhardt>" <ps@pks.im>,
    "Kristoffer Haugsbakk>" <kristofferhaugsbakk@fastmail.com>,
    "Christian Couder>" <christian.couder@gmail.com>,
    "Usman Akinyemi>" <usmanakinyemi202@gmail.com>,
    Joie Joie <soniqjjj@gmail.com>,
    Joy <soniqjjj@gmail.com>

This series moves pack.packsizelimit from a standalone global variable into
struct repo_config_values, as part of the ongoing effort to reduce Git's
reliance on global state and make its code easier to reuse as a library.

The series includes two patches:

 1. Update repo_config_values_init() to use memset() for
    zero-initialization, while keeping the defaults that require explicit
    values.
 2. Move the pack size limit into repo_config_values and update the relevant
    code to read it from there.


Changes since v1
================

Thanks to Patrick Steinhardt for reviewing the first version and suggesting
the initialization cleanup.

Following his feedback, I've:

 * Added a preparatory patch to simplify how repository configuration values
   are initialized.
 * Reworked the main commit message to explain the existing problem before
   describing the change.
 * Removed the need to explicitly initialize the new pack size limit field
   to zero.


Testing
=======

I built Git and ran the relevant configuration and pack-object tests:

 * make -j2 — passed.
 * t1300-config.sh — 518 successful tests.
 * t5300-pack-object.sh — 63 passed, 2 skipped, 0 failed.

Both test runs reported permission errors during cleanup after the tests had
completed.

Joy Gundu (2):
  repo: zero-initialize configuration values
  config: move pack size limit into repo config

 builtin/pack-objects.c |  2 +-
 environment.c          | 17 +++--------------
 environment.h          |  3 +--
 object-file.c          |  6 ++++--
 4 files changed, 9 insertions(+), 19 deletions(-)


base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2271%2FJoiejoie1%2Foutreachy%2Fglobal-state-mini-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2271/Joiejoie1/outreachy/global-state-mini-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2271

Range-diff vs v1:

 -:  ---------- > 1:  df93a2a86c repo: zero-initialize configuration values
 1:  e3e36c3459 ! 2:  05ae50b5da config: move pack size limit into repo config
     @@ Metadata
       ## Commit message ##
          config: move pack size limit into repo config
      
     -    Store the pack.packsizelimit value in repository configuration
     -    rather than keeping it in a standalone global variable for the repository.
     +    The pack size limit is currently stored in a standalone global
     +    variable, even though it is repository configuration.
      
     -    Update the configuration parser and pack-writing code to read
     -    the value from repo_config_values rather than a global variable.
     +    Move the value into repo_config_values and update the configuration
     +    parser and pack-writing code to read it from the repository's
     +    configuration values.
      
     -    This change removes one piece of global configuration state from Git
     -    and helps make Git code easier to reuse as a library component.
     +    This removes one piece of global configuration state and helps
     +    make Git code easier to reuse as a library component.
      
          Signed-off-by: Joy Gundu <soniqjjj@gmail.com>
      
     @@ environment.c: int git_default_config(const char *var, const char *value,
       		return 0;
       	}
       
     -@@ environment.c: void repo_config_values_init(struct repo_config_values *cfg)
     - 	cfg->check_stat = 1;
     - 	cfg->zlib_compression_level = Z_BEST_SPEED;
     - 	cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
     -+	cfg->pack_size_limit = 0;
     - 	cfg->precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
     - 	cfg->core_sparse_checkout_cone = 0;
     - 	cfg->warn_on_object_refname_ambiguity = 1;
      
       ## environment.h ##
      @@ environment.h: struct repo_config_values {

-- 
gitgitgadget
