Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2405D18595E
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935362; cv=none; b=hJRgOaA8rovujLpEEA8yy8Hh3GAoldZ2R9g0dD15QBUT8cR8LdcgD+v/mfvscD6kxnoqRRFtcZ9HntOqWc2xKNiSg6NggewAfCnXjf5ViO/25gJroZexijSbSaXmAhWyz2iNy4O+tAr4gB5gE/k1o0jS8odF2SGqNwRMc6kXrq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935362; c=relaxed/simple;
	bh=gId5JgM7izLt873jtAaSsdX7yjFb2X805k/gda2kMKk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PxNuf623+xAaabKba4sMiY5CJn/QrgfKrQt0lNHEpVe9VOwy9sQ+TJrNw8kdjp1B1EGX3gBFkV75v8oYCR7UVbprwlY/I1TFag6v0mLqBUdMCwVighbBERqxBO6TeAceJpR7TKZ6W7KlCudrq5K9CoA0Y3Cr28WF09TlFbPwBB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eav9bwZM; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eav9bwZM"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-535dc4ec181so4578669e87.3
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935359; x=1726540159; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeWlcwU9yAFb56Ubkr+pvO6A5aBn24BR3efejK8Q6RQ=;
        b=Eav9bwZM6F6Y89HHbMJNtF+x+CnJThakBNQqMb3435nL9ut+5GzDZoTeTWRMyEpp+P
         1qW3l2mZqF1eurKt1xw3o3c4MInbZfgZendLNG2VO3gBgITpsC8FAI3EzhAo2tHZeeR0
         Ee2Cl9miwAxgZ56IGzzp4ZxT+g5S3ghVKpfxoKcpe449PPqJNQ0a/2t8lOf66JiNBxUW
         AW6pRlIQUCpz6TaDWiVV5UwdzhyhYC2tXueKGcTn+QWlvdAg7HobiRWWQiJl/yQxOakv
         KPr1Ju4EhgLxh3BhhXIaO3f8Bqn//WYIr7RtqrsiOm19RalLvXNcMVqibrf+3kVGseXM
         Stow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935359; x=1726540159;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WeWlcwU9yAFb56Ubkr+pvO6A5aBn24BR3efejK8Q6RQ=;
        b=aDWQFfGgSDzMxY9X/j+13vOJ2ZzA9DjsDHzu01XgJiFu6MyfVrVnoVU8VsJehTWriv
         lyocMHIZdTEm7zBmARFcipBvhT9A5TQOc570XMSBAH8No2UGZjp6SpDbPuAROmqw72L/
         n/vofDLmk8XeU7g3RDyH/sWUC9kpjObNo6zqhinRSnziPQNINQsS5FiKD6tGq66VJUro
         bmwj8W1j0rBOUv364diihVk6VV1soahBiv+GmZUmqnfGiYRTNa7FWkX00b/ne2odj7y3
         UtBrfTM1YaQEfhZnV6BJ2fG38YGkVLEHDvgeBgR1g2ENjwhGi+j2tQApEaGYpibQfwDm
         Lcdg==
X-Gm-Message-State: AOJu0YxKAcxxlICPNpQrinjVTxa6Dbw7xRCgLCG/OMX0ShZtz/slTG8S
	E4MyAaGkSsyouR4m2UK2C3DBI7WrxrS5z2JKC7xqEePfC5EwZOI89HSoiw==
X-Google-Smtp-Source: AGHT+IFy0ZGMqpHvNLFzvifbE1PUolJy3/xw0Zb3hy+jxGyOL9Q7JSTrmGCiVO3Ae9HHVA7wcCAbEw==
X-Received: by 2002:a05:6512:124b:b0:535:6892:3be3 with SMTP id 2adb3069b0e04-536587fc4c8mr7577395e87.41.1725935358798;
        Mon, 09 Sep 2024 19:29:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25835adfsm414164166b.44.2024.09.09.19.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:18 -0700 (PDT)
Message-Id: <b52ee338d1524a938e679fdeedc04818b75fd4d5.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:47 +0000
Subject: [PATCH 22/30] pack-objects: introduce GIT_TEST_PACK_PATH_WALK
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
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

There are many tests that validate whether 'git pack-objects' works as
expected. Instead of duplicating these tests, add a new test environment
variable, GIT_TEST_PACK_PATH_WALK, that implies --path-walk by default
when specified.

This was useful in testing the implementation of the --path-walk
implementation, especially in conjunction with test such as:

 - t5322-pack-objects-sparse.sh : This demonstrates the effectiveness of
   the --sparse option and how it combines with --path-walk.

RFC TODO: list other helpful test cases, as well as the ones where the
behavior breaks if this is enabled...

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c | 1 +
 t/README               | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b1d684c3417..b9fe1b1fbd5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4534,6 +4534,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	disable_replace_refs();
 
+	path_walk = git_env_bool("GIT_TEST_PACK_PATH_WALK", 0);
 	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", -1);
 	if (the_repository->gitdir) {
 		prepare_repo_settings(the_repository);
diff --git a/t/README b/t/README
index 44c02d81298..a5d7d0239e0 100644
--- a/t/README
+++ b/t/README
@@ -433,6 +433,10 @@ GIT_TEST_PACK_SPARSE=<boolean> if disabled will default the pack-objects
 builtin to use the non-sparse object walk. This can still be overridden by
 the --sparse command-line argument.
 
+GIT_TEST_PACK_PATH_WALK=<boolean> if enabled will default the pack-objects
+builtin to use the path-walk API for the object walk. This can still be
+overridden by the --no-path-walk command-line argument.
+
 GIT_TEST_PRELOAD_INDEX=<boolean> exercises the preload-index code path
 by overriding the minimum number of cache entries required per thread.
 
-- 
gitgitgadget

