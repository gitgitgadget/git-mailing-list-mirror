Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471451E04AD
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 23:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754869571; cv=none; b=akPARwJqpMSnWIfjQYo8IOPwpd+QyUdzgkTOfUqhdNnr9DnqwUkloWj+eLW4U8j6Wq+xr8LLCz4ePx4Jz8uRGoJ6C+q0sg1Gsoie7tda+t4YWi0bCnZYfvj1ibe8O3i8WoswuiefrJpaOJTMEPcmiETVYAuQn53gu9umjazVprU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754869571; c=relaxed/simple;
	bh=uw5ucdsmCqenZ4bHAtSWGG2rVaYFDZiiWn1gyIzjO+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSKjrHfZDKa2lGnruawIEXolW/GFn8v56xTD2yuK3RWyIDz0eqbtmc6m6iF9FxtIhtE14e+7tSuynIjQ43mGFeB4I0Y+JYM17uDLaHBChFIkfvVxNtI+R3kIH624nB5mllZkSUcsYzqvBYvHAYtTcyuKWX5KvALM25yWYB7oNvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2m5aULz; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2m5aULz"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32106b0930eso3966435a91.0
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 16:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754869569; x=1755474369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCgsbzvVs1qa+/Hc5PgqXBpussYBUtI4lAipVaqoFlw=;
        b=E2m5aULzsivCXDVvXYY/CXLwN4Ntf8KhUEEckTNAKkrxoSUmSdpdNvhF4K2NJwT9m4
         oFpi3gX3HjFy6K5njNey/ER3EcBo2pv7mpq7GilEYKp15TfUqQ9izH9+eqJclW0jv0Ks
         jRaAuz2joPyxfz3/cx6siRcAu0lyNPNxW7T999uhsLdMsOwqT7vTpZTnB158bL9A4xw1
         jk5GKzAlmICFnMUa3+YUCyY8qEWWEHEoIAk3GtyvPnTaZFRCs7zsuNE7YsPI0uKUXBCy
         aE4fpxQ2DPM+/1BuUfxgt7d+TGFuz/6sxKQ/XhKhbOJSnopnsbZ0l4Pk3E7zVuPoRMi0
         akBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754869569; x=1755474369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCgsbzvVs1qa+/Hc5PgqXBpussYBUtI4lAipVaqoFlw=;
        b=W8FiTxO43FCQiTmFs23vtK/gaIiBJ6xCqhGq8t8pnfWHvGP9I0BZyTumVMRGnDXXv0
         MDA3Th80rhmB108YGMVAwxZEXbjy11MUfSH5jhqqXOYmTYMM0dRRWpT51BHTv2Kw1AKE
         qs6BEpHkFIs+X7Ip7CFiG5qQp5h3UaKJCqC2aAJ3x/W9ZWk7MzumVc7cQYcSd5+5Rwqn
         7QU13iNy/ZMODIgIC55u51Ze/xBhqWmMkN9hvTlNsQpRmpCKaEPcbWxUy5J85U1R8cV0
         cY9uw9yY/A60f/JahDQe6N3F82PiCLjTlrZK5e9oZQ36BljKHG5/G8G9FtLIPqcTEs2F
         RExw==
X-Forwarded-Encrypted: i=1; AJvYcCXRTzPsNB3pc3llDRNEEuUkRFloGms4RuA4ys0tMBBf7rEszUJTyAHRgxudOakQjHxQD0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvqYe6GIFPtC34DhFfAZBj6LmPpiV5M35IzUt6bRfaixGm/5SK
	B4rZLr5oTDT8Q/oztTLrGkrszium8pkvZnW7tLYULUeZ0vuIqBBkgfjd
X-Gm-Gg: ASbGncsLjjzoTQg7+Grz+01vqvEVLtMjNeJ59fwVa0ZBIrudzjgPLBhHwwnLYrJCTE7
	MS4GRA64aSDhnts689k8dq17/g3LQrgPI/REzj1J3+dPfX80sPJlyuD6oNW/DhA6eEm8m7Q55JW
	6KhED0gcYO+AtpCnalnT0hdxg6YDB0HJe0/FFX6hsCs8TFUX+AgGTx5WF5I4sD2AirNsxYqmk3Y
	uPxeUM5fw3bETKHVPholk3MshabSORSDU7zITJMAURTB7/pgS321SuHqqiQxMb1hXiq2u5WgoBI
	Kz0+JMTk6Hzoed2hQ3ampjVAGACy3bXlQVoQOZUCsoDNb8htPZI9YH8ean9VC2VidwTO95kRUlY
	1c9UORqZqeM3bysOss/xluMY2h+n4H4Yyy643//z9m9hS
X-Google-Smtp-Source: AGHT+IHilvPzPqkbOatnwY6CTRca/VttJqARW68UG3/h+t4CwQSmXkVHIyf2HrTPlLD+koi/V8blEA==
X-Received: by 2002:a17:90b:1fcc:b0:31f:762c:bc40 with SMTP id 98e67ed59e1d1-32183e33936mr16583194a91.16.1754869569352;
        Sun, 10 Aug 2025 16:46:09 -0700 (PDT)
Received: from thinku.tailbd49c4.ts.net ([103.37.200.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32102b9022fsm12349173a91.4.2025.08.10.16.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 16:46:09 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	shyamthakkar001@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com
Subject: [GSOC PATCH v2 0/2] builtin/fmt-merge-msg: remove dependency on global variables and 'the_repository'
Date: Mon, 11 Aug 2025 05:15:44 +0530
Message-ID: <cover.1754868681.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1753804956.git.ayu.chandekar@gmail.com>
References: <cover.1753804956.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The aim of this patch series is to remove the definition '#define USE_THE_REPOSITORY_VARIABLE'
from "builtin/fmt-merge-msg.c" by removing global variable 'merge_log_config' and the global 
'the_repository'

This patch series contains two patches:

1 - Remove the global varaible 'merge_log_config' and localize it in
    'cmd_fmt_merge_msg()' and 'cmd_merge()'. Set its value by passing it in
    'fmt_merge_msg_config()' by passing its pointer to the function via the
    callback parameter.

2 - Remove the dependency of 'the_repository' in "builtin/fmt-merge-msg.c", allowing the removal
    of the definition '#define USE_THE_REPOSITORY_VARIABLE'. Also add a test to make sure that
    "git fmt-merge-msg -h" can be called with repository being NULL.

Thanks to Junio and Phillip for reviewing my patch series and Christian for mentoring me!

Ayush Chandekar (2):
  environment: remove the global variable 'merge_log_config'
  builtin/fmt-merge-msg: stop depending on 'the_repository'

 builtin/fmt-merge-msg.c |  6 +++---
 builtin/merge.c         |  3 ++-
 environment.c           |  1 -
 fmt-merge-msg.c         | 10 ++++++----
 fmt-merge-msg.h         |  1 -
 t/t1517-outside-repo.sh |  7 +++++++
 6 files changed, 18 insertions(+), 10 deletions(-)

Range-diff against v1:
1:  c82620a1f5 < -:  ---------- environment: remove the global variable 'merge_log_config'
-:  ---------- > 1:  3aa014ed46 environment: remove the global variable 'merge_log_config'
2:  04d6f682a6 ! 2:  8e55516cda builtin/fmt-merge-msg: stop depending on 'the_repository'
    @@ Commit message
         builtin/fmt-merge-msg: stop depending on 'the_repository'
     
         Refactor builtin/fmt-merge-msg.c to remove the dependancy on the global
    -    'the_repository'. Replace all the occurrences of 'the_repository' with
    -    'repo', where 'repo' is a pointer to 'struct repository' passed to the
    -    function 'cmd_fmt_merge_msg()' and thus remove the definition '#define
    -    USE_THE_REPOSITORY_VARIABLE'. Also, add a test to make sure that "git
    -    fmt-merge-msg -h" can be called outside a repository.
    +    'the_repository'. Remove the 'UNUSED' macro from the 'struct repository'
    +    parameter and replace 'git_config()' with 'repo_config()' so that
    +    configuration is read from the passed repository. Also, add a test to
    +    make sure that "git fmt-merge-msg -h" can be called outside a
    +    repository.
     
         Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
    @@ builtin/fmt-merge-msg.c: int cmd_fmt_merge_msg(int argc,
      	int ret;
      	struct fmt_merge_msg_opts opts;
      
    --	git_config(fmt_merge_msg_config, NULL);
    +-	git_config(fmt_merge_msg_config, &merge_log_config);
    ++	repo_config(repo, fmt_merge_msg_config, &merge_log_config);
      	argc = parse_options(argc, argv, prefix, options, fmt_merge_msg_usage,
      			     0);
      	if (argc > 0)
    - 		usage_with_options(fmt_merge_msg_usage, options);
    -+	repo_config(repo, fmt_merge_msg_config, NULL);
    - 
    --	adjust_shortlog_len(the_repository, &shortlog_len);
    -+	adjust_shortlog_len(repo, &shortlog_len);
    - 
    - 	if (inpath && strcmp(inpath, "-")) {
    - 		in = fopen(inpath, "r");
     
      ## t/t1517-outside-repo.sh ##
     @@ t/t1517-outside-repo.sh: test_expect_success 'prune does not crash with -h' '

-- 
2.49.0

