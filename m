Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710122;
	b=YUvLVz7klVqooc1XMTBbesY3mEg4lJyo2hjf65Za1ptmfGqbEFlJvlVAr2xjS3UWVR6r
	 5PG1f8kr9+heyax5ifSlTQik07LfLSSAuDaWjQN02U6KjVXA6hti8uKT4HLRj+zgwCfjd
	 Q8c04i5bbB2o5W6AmhJCBGTHeZoU8bc7m4lRbWEmwItB6zk2vOCvIFPI7cLfyKS93IqC/
	 e+/MKr3gRsED5DRfQEhFLYUP8HgZ1Rhj4OpKXA4j5ptETMhkht2aboss7vHacZZxbSfzp
	 euNVfHpqX+aejp8VO0jQ/tsrUWtWj8bOlrzcnmQ4debkHZNyz4Dh25ic3Kva3ThUHKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Q/p8ygBP5PzuwHrg3f0KFOSisu4r4d71905rwuzK7W4=;
	b=yvni9KduYQ8gOYnDg7FexpZsmAOlRIQf0fyLZkgzF3UkKRqZQQHojy+zBb+cCxuWJqQh
	 jn2euMozyDrNvH8dXpIdXbL7SacazlF62xRG4KSlsI297zhywtsF5stopNrsDMgv+5QVx
	 70qDbBNVRy2bnJtB8TZ5besSKBdXiZTJSEwX3An3kGN6HoOpJsTKF5tt8rShuvbV0cXf8
	 rJnxSisdlS/A4Lv7RtKcCdsyqGkx6gHhCKZVb7S+OcxgjGONJZ1Jqjq7/VsSi1cIWa/C8
	 /ltgvu1EUKm4QRyqpK8Y+TTD1jBWapwypYxH9f46wz1A9uYccVH/kuLaHqIivKAdeow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QRa7jIhI;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F35606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 12:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03F35606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QRa7jIhI
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-84d5e56f876so2937295a34.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 04:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793710121; x=1794314921; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q/p8ygBP5PzuwHrg3f0KFOSisu4r4d71905rwuzK7W4=;
        b=QRa7jIhIVeqvTTqkKH9vcCvrmOdZokZCdV8SahQ6fvmNvzyWHkbkjLjoatjvxS0+/D
         J9toyWi4PUWQtaqGuFQ9W/SWjksPjhRHocuuQEPKlpzy1JM8/ENeUnvYjJvboEBSmxQc
         jbpR0ta270wXKNrzudKjTDeNNkyXeq4sUdELw806MJMES74uKiA9MO+gmMkLtU/ouBYw
         GRcW8ViMSyP7cY4oF2eWZLw2c8sprQS4EKVk1Wc1YvnCItehDGvjBq47XxODDvHUIjdc
         JNQzTlxKtu+kKOuVr6ub1kRtK5Bx/19Vh+mPwiycKJvuSooVZ8ZAKPYpnzpuNp5dADAZ
         dXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793710121; x=1794314921;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q/p8ygBP5PzuwHrg3f0KFOSisu4r4d71905rwuzK7W4=;
        b=TOTxNZMCUYCeF1At0ekNHcxswmIduTBsQZsanxUxtI3RHvrxVI3feGT1DpXFZ4VVBE
         ftwVrlGx3KSrRDeYXCllBVSrw0CWNxLWqYLR0DPNoLuBuCLVEIRV6NRrNkbDRRrVPAKE
         AvBe1pOVrHVkhWAYHh8XfpZKr9seYMYgCVW91S4OpOpv/RwOMHh6x4zaLRjqL9i8ow6X
         Vfh4PpI2Eix45grqKE2S3IoDFJtArjfhHEM952zZgwNBsb6PZjKUn2f6xUEMlymqhPfw
         ej6mFKXvzG0AtNSlxWXPXCI5PxzK0x0WYB9QTMxeibEV54+Qy3mVHGllo05xNCTgmil4
         cufw==
X-Gm-Message-State: APuU4Z/TaMF2718GEc8hucCsLoGYBjFIA+6jd6mPtTio+cun1d8tmMDa
	1LTZ/M6ZSVzaIDJ+NLjqLdK7teBStf+oHMdyUJCtwaNuzL76X0JCkKEBb7GZxjxE
X-Gm-Gg: AYBFou1k7VxlUU6ugRvAhtrYezG8QY6WxxT+gT0SVyihPFlpJqguC9AAiJOdrf1Cv5u
	t2hffYuAc+MXyhhUgIPE0WeeAU28YLpIa2ZicQ8MQuclM7h5AEQt7ydZghHBB5DWxsu1e2Uv0nd
	MnJMekKO7RwrvGbo5r7INkdJp9DxNlOpFkoFTzpcwfYkTf+NPuINBoMAMoQrBkR9PcFtQ0iILE0
	IQhvSBalThRoZNMjUUD69ykvgu5sXSocA+hJrbKFQ+UfR5BPBFSb6RtMeqCvPWNbBFmoYwxqMRu
	XHMYFpMWVCL/CVNBy0/C1JFD2WkLI/8JkJvLKdnQ3ENkpoak2hKllRbsuJr9qJpLhrNtTaKog5N
	tJnsNvpMX4nEHdepY+r8uEEqmaHmUQ3hJfPzMO17HSbS74h5vPV/RfYowxPxfb6H1qFC/llBHW/
	zKGCSIk7FvjmAMFCBnTcfdqDvM23Bd3piGCtF6wwPla1TrUN/IhBryDuE3PLyFsIkEevQ3RclaN
	8O2lN48mJBIFTH++V0TNdXzo5dotHPNjgaF1Nj/ccw5gCUR3VT9ukHAuyFHU1xfDC3SdEZwMs9x
	mNiCxjzz91jv2B8u8GQ+lw2HCBSvJA4=
X-Received: by 2002:a05:6830:2b29:b0:824:5be1:f47b with SMTP id 46e09a7af769-85d3645849emr9356658a34.26.1793710120769;
        Tue, 03 Nov 2026 04:48:40 -0800 (PST)
Received: from [127.0.0.1] ([20.64.66.196])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354985b2sm11551303a34.11.2026.11.03.04.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:48:39 -0800 (PST)
Message-Id: <pull.2271.v3.git.1793710118.gitgitgadget@gmail.com>
In-Reply-To: <pull.2271.git.1792522587065.gitgitgadget@gmail.com>
References: <pull.2271.git.1792522587065.gitgitgadget@gmail.com>
From: "Joy via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Nov 2026 12:48:36 +0000
Subject: [PATCH v3 0/2] [Outreachy] config: move pack size limit into repo config
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
    Patrick Steinhardt <ps@pks.im>,
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
 environment.c          | 19 +++----------------
 environment.h          |  3 +--
 object-file.c          |  6 ++++--
 4 files changed, 9 insertions(+), 21 deletions(-)


base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2271%2FJoiejoie1%2Foutreachy%2Fglobal-state-mini-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2271/Joiejoie1/outreachy/global-state-mini-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2271

Range-diff vs v2:

 1:  df93a2a86c ! 1:  dc18b66976 repo: zero-initialize configuration values
     @@ Metadata
       ## Commit message ##
          repo: zero-initialize configuration values
      
     +    When initializing struct repo_config_values, we explicitly initialize
     +    several members to zero or NULL. This adds unnecessary boilerplate as
     +    more configuration values are added to the structure.
     +
     +    Zero-initialize the entire structure with memset() instead, leaving
     +    only members with non-zero defaults to be initialized individually.
     +
          Signed-off-by: Joy Gundu <soniqjjj@gmail.com>
      
       ## environment.c ##
     @@ environment.c: int git_default_config(const char *var, const char *value,
       	cfg->has_symlinks = platform_has_symlinks();
      -	cfg->use_nanosec = 0;
       
     - 	/* section "sparse" config values */
     +-	/* section "sparse" config values */
      -	cfg->sparse_expect_files_outside_of_patterns = 0;
       
       	/* section "branch" config values */
 2:  05ae50b5da ! 2:  ba34e82a0a config: move pack size limit into repo config
     @@ environment.c: int git_default_config(const char *var, const char *value,
       		return 0;
       	}
       
     +@@ environment.c: void repo_config_values_init(struct repo_config_values *cfg)
     + 	cfg->trust_executable_bit = 1;
     + 	cfg->has_symlinks = platform_has_symlinks();
     + 
     +-
     + 	/* section "branch" config values */
     + 	cfg->branch_track = BRANCH_TRACK_REMOTE;
     + }
      
       ## environment.h ##
      @@ environment.h: struct repo_config_values {

-- 
gitgitgadget
