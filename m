Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DD73B71AC
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684188; cv=none; b=R3WuvZa2H2MA5vtLHN+In3e8j39brWX6IhNpFUKFSFqFXQ9cAQhS5N1HrHJP+qZUbIYd/pLYXqTZHxOWt/ef6OlakXSAAonYMBCbcejK/J5PjNRPgnrQ5+l+AulA8fxHu2nRmRFVg9qmcy/DyBQXDQQGnHfjV1RtRkfu+n5T6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684188; c=relaxed/simple;
	bh=GJbBniY10QauoMqVGMPIL6TkGcRSgPyx/rfD5u2r/oc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EUQ90e2bZbUt+CFG1ct8508qJKO8whaspSs88riKKmxGKS4mTrLw60RN5SgBzm/iqSKEicRy8ioo+dmg5QHzGsnLbKwIozikhx0H1E9eHeai4aChtku4jflzcsTa+3gHVH5zQAdQRwHDT7PY3LV8FUzH3BxmTVNn4TWQID1XXSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9vvWXIu; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9vvWXIu"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso266142a91.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 11:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787684183; x=1788288983; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mpc1FTtvvLAt3q5aqsUhQg5+QK87snRK1gXGneAKKyU=;
        b=p9vvWXIupuSMeQ6YwZfJHuEqRWQCjOQFszHEY72PZ9mnhT7XrAHXZ+wBfk2tPuxjk0
         xixnTqe6X7FlrO/x02SKFrAnfV616OQu9dNpU+LX9WqInnpMXOACFgkm/fzAs+/OG3qs
         6OClR+CebjfoP3/2rcQaAAOVohIQD1TZUvfais7wiylmg0ieUD2GIL25qx7G+UnD6LhM
         3o8Wv0LE4vFuWaVvd+V32gCW57IQJpONuVZfb/wKWIM7XWbrTt7A8Lva7oaaa0hblSYs
         Z4QS5R1GfXc/EvQfopnSv0L9hL2tFtdr3yG4xj/MGCh8lvYCYlVsGJ5bWxlIIFMAKcoM
         xx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684183; x=1788288983;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mpc1FTtvvLAt3q5aqsUhQg5+QK87snRK1gXGneAKKyU=;
        b=im3MgBT1AfosiTzwpN0ICTu4svMDPF53aOZye7E/Uprz5buQoW1MtsI95y61uqKQGr
         juR7Kx7JSHm9RoylInykfVd26ut8fop/g3efnxY9FEbViMyh1CHRzH1yZRWAszidYBi3
         GSVtWMisz9aCLuX/yu2X6RqOx8Brftx429R0spxedxhAt288fi9cXARtSjNy71bnTmHD
         oRamDECdMcjClHPefqa3Hxm0f2748UOMrkO4rtWvuZFgHLVHePAHxC1GqLO9FoLYDQwL
         9cIPorn9D2FWKR+618wUj6NDXzL7oOtWMBKXZiIg95gYR7FAaYSW4q3QNOnDPxBi5EPi
         v/8A==
X-Gm-Message-State: AFuF++lthALOmP69T8S/ErNh8+Riijgc0PADa30AuJi4ywla++ji0nLO
	lkYJJgnLZ3sYLBwXCi+LW2N0B0VnKt96zG1Vcmiuv5VvO0KPMKJOuIG5qONuog==
X-Gm-Gg: AR+sD111ls6768s8lOn+tYazVg8xFJ8bDy7oPrazDMAIwYvaGI5oFAEfll5h2+aKSFB
	yXVUVtIodrFlc07a3VVPEA3utkLRgUmjb5dLJ0X2v21jY0VfecYaHXpcSgR2lq2ps/WePFwbGu2
	vWrzrXvb0PtyjfB/d/yCP2U6F38gUviWc1I1eM2gu+WY0BZra3PkeW/oHM7bnROTMozDnMuNJ7X
	s+jEu8Y1iPxf55+7ugVLdiYUNhRtBSfDFFb5CO3FoJFU1MIJKUN/L7QEajLfA982+8PJK4VFmkz
	hSSPg0WhxE7tBGsygievV3LydMsb22CR720HrRdZWFlgb7ifPt5uBUEwOz9GJSBIdGBOixj7W+9
	ocmT4bLvZWro6aUzLyqtYngO9h0RN2Wdslm1VfOwmCUy4mc/hf4ymUrU8OyaMcw76mTM53vCPXW
	U82v35LxVMmOvNLzWsvEC9Bs3OQGqrG7m+HFlP6FOCW0LC8NwZI97qtauBcs+IN0k=
X-Received: by 2002:a17:90a:fc47:b0:38e:9045:bac0 with SMTP id 98e67ed59e1d1-3966d1b1f18mr2657959a91.5.1787684183455;
        Tue, 25 Aug 2026 11:56:23 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.153.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60b59dsm1094412eec.3.2026.08.25.11.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:56:22 -0700 (PDT)
Message-Id: <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
In-Reply-To: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 18:56:14 +0000
Subject: [PATCH v2 0/7] trace2: stop allowing die()
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
Cc: gitster@pobox.com,
    Taylor Blau <ttaylorr@openai.com>,
    Derrick Stolee <stolee@gmail.com>

After v1 was posted, based on a concrete example of tracing leading to a
recursive die() problem, more evidence has come up to imply that allocations
are failing for some users more often. This is potentially an issue with the
allocator chosen by Git for Windows, which is being discussed elsewhere.

But the conclusion is this: the trace2 API shouldn't call helpers that might
call die(). It's too low-level for that.

In this v2, I have a much more robust approach to removing die() from the
trace2 API.

This starts with a new banned-die.h header file at the root of the repo and
including it from all trace2 API *.c files. It starts empty, but the later
patches will add one method at a time:

 * xsnprintf() : This is the original patch, but made more complete by
   adding the method to banned-die.h.
 * xstrdup()
 * ALLOC_ARRAY()
 * xstrfmt()
 * ALLOC_GROW()
 * xcalloc()

During each patch, the goal was to have the trace2 logic be "as correct as
possible" when an allocation failure occurs. This may mean that we have
incomplete messages or dropped trace messages.

The focus here is that the trace2 API should never cause a process-ending
failure, because those failures will trigger trace2 API calls while
reporting the failure.

Thanks, -Stolee

Derrick Stolee (7):
  banned-die: create header for banning of functions
  trace2: tolerate failed timestamp formatting
  trace2: remove use of xstrdup()
  trace2: remove use of ALLOC_ARRAY()
  trace2: remove use of xstrfmt()
  trace2: remove use of ALLOC_GROW()
  trace2: remove use of xcalloc()

 banned-die.h            | 32 +++++++++++++++++
 trace2.c                | 51 ++++++++++++++++++++++++---
 trace2/tr2_cfg.c        |  1 +
 trace2/tr2_cmd_name.c   |  1 +
 trace2/tr2_ctr.c        | 11 +++++-
 trace2/tr2_dst.c        |  1 +
 trace2/tr2_sid.c        |  1 +
 trace2/tr2_sysenv.c     |  7 ++--
 trace2/tr2_tbuf.c       | 50 +++++++++++++++++++--------
 trace2/tr2_tgt_event.c  |  1 +
 trace2/tr2_tgt_normal.c |  1 +
 trace2/tr2_tgt_perf.c   |  1 +
 trace2/tr2_tls.c        | 76 +++++++++++++++++++++++++++++++++++++++--
 trace2/tr2_tls.h        |  7 ++++
 trace2/tr2_tmr.c        | 15 ++++++--
 15 files changed, 229 insertions(+), 27 deletions(-)
 create mode 100644 banned-die.h


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2178%2Fderrickstolee%2Ftrace2-dont-die-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2178/derrickstolee/trace2-dont-die-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2178

Range-diff vs v1:

 -:  ---------- > 1:  84634717e2 banned-die: create header for banning of functions
 1:  95c546bb3b ! 2:  bd45f46a34 trace2: tolerate failed timestamp formatting
     @@ Commit message
          triggering this problem in a loop as the 'atexit' event would be
          retriggered by the die().
      
     -    I could not determine the exact cause of why these errors started
     -    occuring in a bunch. My best guess is that these users are dogfooding an
     -    early operating system version that is more likely to fail in the
     -    gettimeofday() function and thus leaves the structures uninitialized and
     -    potentially violating the expected values.
     +    Based on other symptoms impacting users on the version reporting these
     +    failures, it is most likely that this is actually a failure to allocate
     +    memory, which is a specific symptom in Git for Windows. That fork uses a
     +    different library for its implementation of vsprintf() which allocates
     +    an array when seven or more positional arguments exist in the formatting
     +    string, such as this one.
      
     -    However, for full defense-in-depth I made several modifications:
     +    Ultimately, the trace2 machinery is so low-level that it should not rely on
     +    any helper functions that perform error handling with die(), as that can
     +    trigger issues that would then be traced, causing this kind of recursive
     +    loop.
     +
     +    These changes help remove any use of die() within this file:
      
          1. Both 'tv' and 'tm' structs are initialized with zero values, allowing
             an erroring gettimeofday() or gmtime_r() method to leave them
     @@ Commit message
          but they only die() on out-of-memory errors instead of formatting
          issues. I chose to leave those in place for now.
      
     +    Helped-by: Taylor Blau <ttaylorr@openai.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     + ## banned-die.h ##
     +@@
     + #undef die
     + #define die banned(die)
     + 
     ++#undef xsnprintf
     ++#define xsnprintf(...) BANNED(xsnprintf)
     ++
     + #endif /* BANNED_DIE_H */
     +
       ## trace2/tr2_tbuf.c ##
      @@
       
 -:  ---------- > 3:  ec447a6a77 trace2: remove use of xstrdup()
 -:  ---------- > 4:  db6858d381 trace2: remove use of ALLOC_ARRAY()
 -:  ---------- > 5:  7f0bb405ad trace2: remove use of xstrfmt()
 -:  ---------- > 6:  120cf1967b trace2: remove use of ALLOC_GROW()
 -:  ---------- > 7:  c8fc195a2a trace2: remove use of xcalloc()

-- 
gitgitgadget
