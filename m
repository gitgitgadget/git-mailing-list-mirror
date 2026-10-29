Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793262821;
	b=HNhBP/vLLtS+OF/MAz3Um2TwRU6RbOOLUbsJtlC62A/07xZ+/RrZnQDk+7Ul3sauGeEC
	 3pfykEo+3xqcfJfh2Z3XzKM9KI0eVB7ezr8GS85xOAS8Lp8gbtDy2S5NvW5VXpNo4g7hl
	 Q+ZuzBJyqMVGKquyBOA7jLOZvbWaqcKTgVYpPfVRYI2oSPkvltNP5QvrqLIo2vCb3vmBN
	 N+B9QnUt1aPojQkw+bwl16Sl3EFouHRbpd97fLQkom0Ky4Jd8htczbG7XsV31twMHPR2a
	 SfCPtQ02lHtEImPnBy305hDfJqH1OsoixcM9qVU8I3NjJBeIx4kx5VPccW9pKLONSLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=l/PY3qmZhkJs+hCoThO0aC98AtPf+4Y+ktfKtCVqfko=;
	b=vsKejslPoCzI96K7j9NLOPBMRj/Qujgvhw5el/uNohGCvRxH2D3P3PlCJ7Eogd8eK+ZV
	 vPikxFZkZ1YV9v/w9njC8P84FmyBcX9huYLEL9C/TNllTsWOYn5+FEVSBaSQop/4g6W3v
	 H64udwliKdqTWGY7rlWkWvMxQZJuGTiIHNqZaNAHMXE1th5elOoD4o2Y7ahhYySKXfFO6
	 wnN6VZrDIHid/wttao+W0iGgIfOpQDs/b3Y8D47ISWvmUgqhesnm7ALh58tDYVdmselc4
	 Lp4Lx119DcM5SpFn/qop8c6wQ6fnP7yMAZ7gzSu+2UM+r6HMK9tZwmxPTB+vqQ0zU2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N14gNrYO;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15181606A333
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 08:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15181606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N14gNrYO
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e9ae391a05so3487975ad.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 01:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793262820; x=1793867620; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l/PY3qmZhkJs+hCoThO0aC98AtPf+4Y+ktfKtCVqfko=;
        b=N14gNrYOm2U4O93LGv+CBKioWuanJXcay5zMGcA8Az4MchbqP3XmIkRK/4g3/Py6gr
         FE/2aTH1xJQIFdg3xEz2Li3GUZ0R1+sVZkHr4V8ruANqyg3tCXCC5YJlUZkQH7oCOZ9d
         vHPCfJSX+hoXmjAgwDAvCtiHG5sU4uK1b4RhZUQ/lkg/iZAP83LlP+0owJG5OvTEmMh8
         TUIt15IiISPPqAZDT9GQdnY4Xc6y96QeVrJgGtAB9lqn2cPzN4qrcGre6i6eP++wO9zK
         9VabNtqFSpS9jEKNngraX0MszcJQcUZd0PcqR8XGop1lp5pgM1hCE5KCKZ4cBXZrELuV
         OZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793262820; x=1793867620;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l/PY3qmZhkJs+hCoThO0aC98AtPf+4Y+ktfKtCVqfko=;
        b=0LDnNEzpuqwPhywlPKZeF+/2iCVWgfy9MtGQzPZ/xcl7wfNrpz8y+CSCCEj4aVynHy
         Y67zdrd/TrDl3B7LBXjUxTxTTUWydwhopykaZQkaNnp/d8NhDgvUh+y2E/3KmzpO1+DN
         n0oV8VcyrVUqXLjHBs5TzakYtdyQUl37pb4EQTA4z59ZVKgyY+G3eT/qtZTxNG0etxUw
         6/nXhJBzIUCwkgx62pg86CtCRsZjK6GylPSjG+maBhe4Ul2AEpsPRda/wLpbRCTJnl8t
         RR9+LuX08ON+xMlmgWilURDA4sbOGvbosA3IOQ4oek7NXGbHheRefvTe266qzhVt6PXf
         ppqw==
X-Gm-Message-State: AFq9FYJGOGiisDJsDiJBnTMbvmz8edasMM2Qd8g14yd1FK+qU9QlbXu4
	sOZy25dBrQaGQbPZmW24WyNIWrkpfB84pn5QIW5PXpazg8EolOtw5n3dJSNzM39T
X-Gm-Gg: AYBFou00plXnpv3JmSIEpd8cIN046vn6hJFaSk1zBSkk6pr1wYZPCxSieiKDyk8cbfI
	hBFn6gtKIl8O7aa37Zo6Yl/GCqixjKbLxmVRrmbBxQg8XQpD+udMASO+FOTaz9dFvwtZ5MzGZAk
	BXUlztfcqd9nj5XZVbp4Gy1RK1Hu1ApXKFdbNcca2PNykl0GbEUUY0IO1sesWQmYaIJgevYgVFG
	19YZi8vUBn2elZ7uut3+rR6JdK2DPsfqX2zmHlhJmTvFVf9XfPr/aEaZYEgG5LFJ9s6dP+IlbXl
	Sng2/gloKlpg0SL3D8hDACxhvMYPN1LPAqdgdNf/+cfH8aM8bo2IZcUEaETZZKk8a0hd9dXBgHW
	zBpGSQvot3mYx2QlZXIirM7v2f7NK2yeGOlgoiAqSdS/3biEHXXe614qiXyXyWGLloxoGRvNM4X
	hgbYXuakMuaiaCyyINQgpGQoRBtsrkXP3cS0U/PVizEA+R/ri/NMxCzeb5nq2zxc4vD57gTZ5lA
	gt6JY1k0/T3VUbgPVCHnccr7TOJ8+gEN0VTBO+ZvUlw55MqYYqrUSuLq4mez6KmARgniT5FTXaU
	mWWz198nzTCPtYQXnZwRi8Hp6M7dIXBw
X-Received: by 2002:a17:903:1a4c:b0:2ea:238c:4cfd with SMTP id d9443c01a7336-2eb1ac4f070mr13752555ad.25.1793262820310;
        Thu, 29 Oct 2026 01:33:40 -0700 (PDT)
Received: from [127.0.0.1] ([4.155.196.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c3b67bsm29863065ad.52.2026.10.29.01.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:33:38 -0700 (PDT)
Message-Id: <pull.2464.v2.git.git.1793262816420.gitgitgadget@gmail.com>
In-Reply-To: <pull.2464.git.git.1793104847288.gitgitgadget@gmail.com>
References: <pull.2464.git.git.1793104847288.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 29 Oct 2026 08:33:36 +0000
Subject: [PATCH v2] Makefile: let ccache cache objects built with the
 precompiled header
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Since 8d3a673147 (Makefile: precompile "git-compat-util.h",
2026-09-15), rebuilding Git with ccache is almost as slow as building
it without. ccache refuses to cache a compilation that uses a
precompiled header unless its "pch_defines" and "time_macros"
sloppiness is enabled, so it runs the compiler for nearly every object
file, even after a "make clean" in a tree it has already built.

Both settings are safe for our build. The precompiled header is only
pulled in with "-include" ahead of the source file, so no "#define" in
a source file can come before it, and none of our sources use
__DATE__, __TIME__ or __TIMESTAMP__.

Enable them whenever we build with the precompiled header.
On my machine, "make clean && make -j8" with a warm cache goes from
about 100 seconds to under 30.

With Clang, switching to a branch that changes one of the headers the
precompiled header includes and back again still misses the cache,
because Clang records the modification times of those headers in the
precompiled header.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    Makefile: let ccache cache objects built with the precompiled header
    
    With ccache, building after switching between two feature branches gets
    about 6 times faster. The first build of each branch gets about 25%
    slower while ccache fills its cache.
    
    Changes in v2:
    
     * Move the CCACHE_SLOPPINESS export from the precompiled header targets
       into the ifndef NO_PRECOMPILED_HEADER block.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2464%2FHaraldNordgren%2Fmakefile-ccache-pch-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2464/HaraldNordgren/makefile-ccache-pch-v2
Pull-Request: https://github.com/git/git/pull/2464

Range-diff vs v1:

 1:  1984b13246 ! 1:  e61cca8cca Makefile: let ccache cache objects built with the precompiled header
     @@ Commit message
          a source file can come before it, and none of our sources use
          __DATE__, __TIME__ or __TIMESTAMP__.
      
     -    Enable them for the precompiled header and the objects built with it.
     +    Enable them whenever we build with the precompiled header.
          On my machine, "make clean && make -j8" with a warm cache goes from
          about 100 seconds to under 30.
      
     @@ Commit message
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Makefile ##
     -@@ Makefile: $(PRECOMPILED_HEADER_GCH): %.gch: % GIT-CFLAGS $(missing_dep_dirs) $(missing_com
     - $(PRECOMPILED_HEADER_USERS): %.o: %.c $(PRECOMPILED_HEADER_GCH) GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
     - 	$(QUIET_CC)$(CC) -o $*.o -c -include $(PRECOMPILED_HEADER) -Winvalid-pch $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
     +@@ Makefile: PRECOMPILED_HEADER_GCH := $(addsuffix .gch,$(PRECOMPILED_HEADER))
       
     -+$(PRECOMPILED_HEADER_GCH) $(PRECOMPILED_HEADER_USERS): export CCACHE_SLOPPINESS += pch_defines,time_macros
     -+
     - $(filter-out $(PRECOMPILED_HEADER_USERS),$(OBJECTS)): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
     - 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
     + ifndef NO_PRECOMPILED_HEADER
     + PRECOMPILED_HEADER_USERS := $(filter-out $(COMPAT_OBJS) $(REFTABLE_OBJS) $(patsubst %.c,%.o,$(THIRD_PARTY_SOURCES)),$(OBJECTS))
     ++export CCACHE_SLOPPINESS += pch_defines,time_macros
     + endif
       
     + dep_files := $(foreach f,$(OBJECTS) $(PRECOMPILED_HEADER_GCH),$(dir $f).depend/$(notdir $f).d)


 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index a96be506b5..80653bb22c 100644
--- a/Makefile
+++ b/Makefile
@@ -2903,6 +2903,7 @@ PRECOMPILED_HEADER_GCH := $(addsuffix .gch,$(PRECOMPILED_HEADER))
 
 ifndef NO_PRECOMPILED_HEADER
 PRECOMPILED_HEADER_USERS := $(filter-out $(COMPAT_OBJS) $(REFTABLE_OBJS) $(patsubst %.c,%.o,$(THIRD_PARTY_SOURCES)),$(OBJECTS))
+export CCACHE_SLOPPINESS += pch_defines,time_macros
 endif
 
 dep_files := $(foreach f,$(OBJECTS) $(PRECOMPILED_HEADER_GCH),$(dir $f).depend/$(notdir $f).d)

base-commit: 37b3475fb530c14109211faca33716a173db61ed
-- 
gitgitgadget
