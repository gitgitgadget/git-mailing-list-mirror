Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362F47A0BC
	for <git@vger.kernel.org>; Wed, 27 May 2026 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905916; cv=none; b=TwkUnGvrl4qfSTDhOPg3ztkVRSTrnfsUSEUlF0T9cPKv5Mm8/8HJeJAbBqQ3JGy1JN4ER2jaDbobr5vVmyWVnexNWRDvRoFKu+eFevEg1Deg2ZgCqF5f96NEbX5f2nn0p8o+i5mTc1wCgwNGsJsXXSEHAqwIueWRP4jRocTgEbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905916; c=relaxed/simple;
	bh=KGNm5e2mphLEi9QfJ2KivAqsldRpI5iHGL5Khy58/D4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Y69Fnn4iv/UfYQ8/hSi/2okyDc8a/cgIQmFFmRaej75cvboPCJvU0ZfMvnGor0f6LjILyLN/MwEfCXIIvoF0AirabDEHyBO9YwcoEAGDv46i+KBk1eLHn/0p+plO/nfKVlnWZIWw4HysCA6rVIZbCkBxYQ+5XEDiAhTWwahP/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpfWVK59; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpfWVK59"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2f0ad52830cso15294380eec.1
        for <git@vger.kernel.org>; Wed, 27 May 2026 11:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779905914; x=1780510714; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0R8YpPGji7GX9TvAY4hT3K6CqAh8GFV1bOM7Xt6X7HI=;
        b=ZpfWVK59avIQeh1TqanR7KBeNHaD5Vlpig4fkJtRIwuowwDhOj8HRZ5bqFAjaD6HVi
         dz2IABWdb89wvn2tK1Oex9+rQDWz6b3Ej/4Cw1pBsW+xC0UIhwbn7vyv8KxtwJW0t34u
         7B0hUY2IPT0HD/VQm8Po9dKThCfBofaAmAjfgToqyAeHuU3+FUz/wIo/8d/5/JKvm/zd
         BvgWbEjFg0gNqi9Halp7LTM8qiZXi9lBCd5Ipy6EdUFD6yRQV9aR/IpvV+911fTdmxXl
         nYkFrBCLrNm39B1qEEmdJwBstpJDloZBsI0fSQmR+YzyjBsO+mpvk32PucRLmkzeRDQD
         ASMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905914; x=1780510714;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0R8YpPGji7GX9TvAY4hT3K6CqAh8GFV1bOM7Xt6X7HI=;
        b=nYyoDvkD1gLmF+SC0LuNzsnBv08Ae7N/7kvA52tID4/lCH4iBZ8cjs8kHg60GgxlQe
         EvtLLOU3hJ92vLTI4KJzwJEOENHcPTlEofh4Zg3mkZbFe/PFgtA0FNw05jfRvoTzdueq
         8DBRoVQMCp2NW5XWzHE4pu1WXfwjotFPtxgJ1yG2EBCmQyqvUDV+9a6SWfutaUJqol2s
         A2Z/KD/vvLFozMsKG08V71DvVbS24gK0Vf3Z5X3S8wJ6Rvrik/phgkI510IwTW2dlsxd
         0V6XnPhX8n+IvCMeiBcsFnV2x0ED+vbzTUgak5iU/O6yku0W6b/6Az/yqRCOSD8FvMvO
         zj+g==
X-Gm-Message-State: AOJu0YwxYXvsPVzzde77yElK3p0sg24Lt0heMp1dPYtnutu9bopMcGSf
	DuAr2M9F4ex7Mg79enN3SPIZTSc3rIl5VlgSRyycl7MqvLKBuc7Iy9GRT12Cdw==
X-Gm-Gg: Acq92OEwoaNgEAI6hA0/pjrt2GSLdyV3TJu0wRlNjDGSDWvY3RqxHNOwMR0LCutGwsn
	rqUIe71DFetNHvXWI0k14YFCdPg74A81T+KcBIbwwc2AtiIhQP+j0UFyaOwuf6ZGtkUCZfzAb19
	JF4ATvMEdDjOJ9U9cHiNp10DUmFf0nuc6hfDT9mwBDjlFJKICLdAZ3LLL0G+ylm8YIdjzvj1Kk0
	DiiX5OqXT8pzNuax8BirjHOGJ8tjVTzWVLWsiLYPabRasyEcWOykcNGdPT6Nlnq4naJ6WFL42tZ
	FDe++SnDrR2wcVdwPiWVT2CvPOldLVLogyaovQ+xFsjRzDQtxyrtVL1leNmxGejCRJE1S/woRaS
	7UFShNZ2FwyY07wePsFRVC8kDM+9oXTElOIHTwegzqgH3OfaBtVuFTy4RDs71+7acN/ZmBYJIBT
	RCgn044rDl3SFI8tKZr6hlgRG3QtZi
X-Received: by 2002:a05:7300:ef89:b0:2ed:23cd:babf with SMTP id 5a478bee46e88-304490906d0mr10807096eec.12.1779905913287;
        Wed, 27 May 2026 11:18:33 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.212.101])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451ca2d80sm17295945eec.0.2026.05.27.11.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 11:18:32 -0700 (PDT)
Message-Id: <pull.2300.v2.git.git.1779905911.gitgitgadget@gmail.com>
In-Reply-To: <pull.2300.git.git.1778773592.gitgitgadget@gmail.com>
References: <pull.2300.git.git.1778773592.gitgitgadget@gmail.com>
From: "Sebastien Tardif via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 27 May 2026 18:18:28 +0000
Subject: [PATCH v2 0/3] daemon: fix network address handling bugs
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Sebastien Tardif <sebtardif@ncf.ca>

Fix three related issues in daemon.c's network address handling:

IPv6 address corruption in lookup_hostname(): getaddrinfo() is called with
AF_UNSPEC hints, so it may return IPv6 results. However, the code
unconditionally casts ai_addr to sockaddr_in and passes AF_INET to
inet_ntop(). On IPv6-only hosts, this reads from the wrong struct offset,
producing garbage IP addresses. Fixed by checking ai_family and handling
both AF_INET and AF_INET6.

IPv6 address truncation in ip2str(): The sockaddr struct size (ai_addrlen)
is passed as the output buffer size to inet_ntop(). For IPv6,
sizeof(sockaddr_in6) is 28 bytes but INET6_ADDRSTRLEN is 46, so long IPv6
addresses are silently truncated. Fixed by passing sizeof(ip) instead, and
dropping the now-unused len parameter.

NULL pointer in execute() logging: REMOTE_PORT environment variable is used
in a format string without a NULL check (only REMOTE_ADDR was checked). If
REMOTE_PORT is unset, NULL is passed to printf's %s, which is undefined
behavior. Fixed by using a fallback string.

Changes since v1:

 * Split the single patch into three separate commits, one per fix, per
   Patrick's review.
 * Deduplicated the address family handling in lookup_hostname(): instead of
   duplicating the inet_ntop() call for each family, the address pointer is
   extracted into a local void *addr variable first, then inet_ntop() is
   called once, per Patrick's suggestion.
 * The (void *) intermediate cast on ai_addr is used intentionally: C
   guarantees any object pointer round-trips safely through void *, and it
   keeps the per-family blocks shorter than spelling out the full struct
   casts.
 * For the REMOTE_PORT NULL guard: both REMOTE_ADDR and REMOTE_PORT are set
   by the same code path in handle(), so neither should be NULL
   independently. The guard makes the code consistent with the existing
   REMOTE_ADDR check and avoids undefined behavior from printf %s with a
   NULL argument.
 * Die on unexpected address families in lookup_hostname() rather than
   silently leaving addrbuf uninitialized.

Sebastien Tardif (3):
  daemon: fix IPv6 address corruption in lookup_hostname()
  daemon: fix IPv6 address truncation in ip2str()
  daemon: guard NULL REMOTE_PORT in execute() logging

 daemon.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)


base-commit: 59ff4886a579f4bc91e976fe18590b9ae02c7a08
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2300%2FSebTardif%2Ffix%2Fdaemon-ipv6-and-null-port-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2300/SebTardif/fix/daemon-ipv6-and-null-port-v2
Pull-Request: https://github.com/git/git/pull/2300

Range-diff vs v1:

 1:  b2d8143811 = 1:  b2d8143811 daemon: fix IPv6 address corruption in lookup_hostname()
 2:  5c01ec3cad = 2:  5c01ec3cad daemon: fix IPv6 address truncation in ip2str()
 3:  1b2f9d1a07 ! 3:  e312735716 daemon: guard NULL REMOTE_PORT in execute() logging
     @@ Metadata
       ## Commit message ##
          daemon: guard NULL REMOTE_PORT in execute() logging
      
     -    The REMOTE_PORT environment variable is used in a format string
     -    without a NULL check, while REMOTE_ADDR is checked. If REMOTE_PORT
     -    is unset, NULL is passed to printf's %s, which is undefined behavior.
     +    REMOTE_ADDR and REMOTE_PORT are both set by the same code path in
     +    handle(), so neither should be NULL independently. However, the
     +    existing code checks REMOTE_ADDR before the loginfo() call but not
     +    REMOTE_PORT. If REMOTE_PORT were unset, NULL would be passed to
     +    printf's %s, which is undefined behavior.
      
     -    Add a fallback string for the NULL case.
     +    Add a fallback string for the NULL case, matching the existing
     +    REMOTE_ADDR guard for consistency.
      
          Signed-off-by: Sebastien Tardif <sebtardif@ncf.ca>
      

-- 
gitgitgadget
