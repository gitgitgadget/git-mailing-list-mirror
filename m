Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05FCEAFA
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 00:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742864135; cv=none; b=Xc1HL7xQ8Pizgu2RiqxnfKQ1bSA5SWWWeJjoaS/6FBZ1tauOad2OCvVDtwO5elpfjD+4wOd2JYQHzRm60xtZptUQpxujXTqPNVNHi2bVl7zwRXZiPKEh7uZVMRYquhxOyV6nhTP/C/KUfnGEmxt1XGmUYkog7f9AmC4s/u7UrJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742864135; c=relaxed/simple;
	bh=8y8eIK1wSz/nUuoS7pxQuIzlF0P2Jwa4+BZC/kNVM4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsEeG1t518OCUt0ukHP7wwAkzgLFdIkHl8zOUi6I4Lura8UsPg7TUTf/XibS975mHKKeocNJkxN9rvEAazPEai5i70PLjhxL+Z/QtXj4QAQ9lNagX1IAYQQuWf0K+nwEEKykk8sLHGhnEoCEY/aXcrc5tkofVfF6tDO7lsXXNpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btTqGqqy; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btTqGqqy"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3fea0363284so2730384b6e.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 17:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742864132; x=1743468932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vu+ymH2L2TQpFctTfj84OMWEwe8Kf3viR8MAuwJe6J0=;
        b=btTqGqqyLlY065LEthE6x+FG5LLAFgMiPJsRVf++V3pmDyjm68d51mAvFh+UmgP4AH
         E9i5R1PwaselJUyPDrV73AZjURV/1/0yeVc+7Qpk2zXsKvdeCwKJMDpXuDSfVN5vNiyx
         9uDo/FQy5TuH7UGun+umOcvgRmOSH1qcbVCruDvQMMMFMKTT2bzEsvrHfcGHaaVtyF/u
         ln23t90mTC9TBA97ufBxIsKwXgP24ia64TEbuNwZiPiuMstSHsAbZzlRfITYn0PwoTeY
         7t1XvUd5XFnEcbeb7bOqZKSoJn8Kf+VfIo178fMmZf2l5wVtsM9CW/4INPV6LlR+0ffy
         C/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742864132; x=1743468932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vu+ymH2L2TQpFctTfj84OMWEwe8Kf3viR8MAuwJe6J0=;
        b=J928rSuQ7GjsJJEI20XBBkawdhzd0u1I1WqZfyRu64ectlWluNkeAxadXjFWdZXD5O
         oERwBntBgVT4zoRWnQPZGod/2F1NUzrWosp3E+VMYMMvAXBaFzaEHTOkaDA3qmVhllk2
         yhxdRZiko1isJD9uFIs3nIEKCHjmVvtSqRwL8syQ7m46NwXJq4uU3UmifDLRp2T5s9zW
         nmvNUD69/or1dLpw0zpJBu1QfpqSowd8JHlbLvQRePAujvWiDL58JSPRaeoRlfSbY+5B
         Wjq44JGKI2gwLjr2I1QdOeQ1CycnXmBFbMRu1WpOJFc0tBxGQmxDGxInR+f24PDm+D4q
         uhMw==
X-Gm-Message-State: AOJu0YxrDC5f8oNSY+/z9k70IQoJaa4ATARH3sd3A1Tp22rT0i6WqnHB
	ViZ9Ix2zRGfGIytrASvQ/t4qbdmTGi/48MQiUxeRcL+nP2mgsnTjrwUcQA==
X-Gm-Gg: ASbGncuxrYtwiXYi1sLQ9BMcdYNnqBShsRvio9PcqGhPe6UTWUtyw/tMNLwihK36rdw
	xiZco9HCkRNGilyatvwlK0fvQzoVwd3L4EepK/Et10PGlycE35D/kKniPQF0Btktebkc19G1a9N
	r+u3zgBnZ+i47EkFMPicuSxXFT6pyK2EfKrR5BNLfrUyPBOG7Oi0k4/528Tb8n4LaMx96fN5qRV
	7RwXcKcow/1WuCx9SU+w6xMvGYw9ljxN8VY2wG2YpSwmjqf6mjRv70BWGeFpw486D+UMebZ+mJ1
	tVcHA7GqQMxvAWYlPg2hiPyOG2t210QI5v06NNY5+8+9HNXS0ynb
X-Google-Smtp-Source: AGHT+IFoSgLLYDEsszsqOt6O819knOpKIPAcdfSHByqPMJTLUbtPr3tKiwWSSZQu+olpNFeq0N7M3g==
X-Received: by 2002:a05:6808:159e:b0:3fe:b27d:2681 with SMTP id 5614622812f47-3feb45c3877mr13261582b6e.6.1742864132227;
        Mon, 24 Mar 2025 17:55:32 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c0ac7bbafsm1735316a34.65.2025.03.24.17.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 17:55:31 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood123@gmail.com,
	alan@norbauer.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 0/3] clone: suppress unexpected advice message during clone
Date: Mon, 24 Mar 2025 19:51:45 -0500
Message-ID: <20250325005148.1771502-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321231639.180762-1-jltobler@gmail.com>
References: <20250321231639.180762-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It has been reported[1] that starting in Git v2.45.0, cloning from a bundle
results in the default branch name advice message always being displayed
when it was previously not. It can be reproduced by the following:

        git init bundle-repo &&
        git -C bundle-repo commit --allow-empty -m init &&
        git -C bundle-repo bundle create ../repo.bundle --all &&
        git clone repo.bundle bundle-clone

This issue bisects to 199f44cb2ead (builtin/clone: allow remote helpers
to detect repo, 2024-02-27) where the refdb is partially initialized
during clones before remote helpers are executed. This partial
initialization creates the HEAD file and "refs/" directory.

A side-effect of this change is that the location of the first
`git_default_branch_name()` gets deferred to a later point of execution.
This matters because `git_default_branch_name()` only computes the
default branch name once and returns a cached value for subsequent
invocations. After this change, the `git_default_branch_name()` call
site that actually computes the value becomes `guess_remote_head()` and
is configured to always show the advice message.

Also, `guess_remote_head()` only invokes `git_default_branch_name()` in
cases where the transport is unable to figure out the remote HEAD and
must guess. This explains why the advice message gets printed for bundle
clones, but not all clones.

This series addresses the issue by adapting `guess_remote_head()` to
support configuring the underlying `git_default_branch_name()`, which
has since been renamed to `repo_default_branch_name()`, to be quiet and
suppress the advice message.

Changes since V2:

        - The default branch name advice message may also print with the
          `--single-branch` option in certain scenarios. This instance
          is also suppressed by setting the `REMOTE_GUESS_HEAD_QUIET`
          flag for another `guess_remote_head()` call site invoked
          during clones.

Changes since V1:

        - Instead of adding an additional boolean to
          `guess_remote_head()` to suppress the advice message, the
          function is adapted to accepts flags that accoplish the same
          thing.

        - Added a test to validate that the advice message is not being
          printed.

        - While we are here, added another patch to allow the default
          branch name advice message to be suppressrd by the
          `--no-advice` option.

Thanks,
-Justin

[1]: <7EC98E2F-144D-4974-94F6-FC24B443651D@norbauer.com>

Justin Tobler (3):
  remote: allow `guess_remote_head()` to suppress advice
  builtin/clone: suppress unexpected default branch advice
  advice: allow disabling default branch name advice

 advice.c                |  1 +
 advice.h                |  1 +
 builtin/clone.c         |  7 +++++--
 builtin/fetch.c         |  2 +-
 builtin/remote.c        |  2 +-
 refs.c                  |  3 ++-
 remote.c                | 10 ++++++----
 remote.h                | 11 +++++++----
 t/t0001-init.sh         |  8 ++++++++
 t/t5607-clone-bundle.sh | 12 ++++++++++++
 10 files changed, 44 insertions(+), 13 deletions(-)

Range-diff against v2:
1:  4dae06d2dd = 1:  4dae06d2dd remote: allow `guess_remote_head()` to suppress advice
2:  1180caabf1 ! 2:  2a69b881c4 builtin/clone: suppress unexpected default branch advice
    @@ Commit message
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## builtin/clone.c ##
    +@@ builtin/clone.c: static struct ref *wanted_peer_refs(struct clone_opts *opts,
    + 		if (head)
    + 			tail_link_ref(head, &tail);
    + 		if (option_single_branch)
    +-			refs = to_free = guess_remote_head(head, refs, 0);
    ++			refs = to_free =
    ++				guess_remote_head(head, refs,
    ++						  REMOTE_GUESS_HEAD_QUIET);
    + 	} else if (option_single_branch) {
    + 		local_refs = NULL;
    + 		tail = &local_refs;
     @@ builtin/clone.c: int cmd_clone(int argc,
      	}
      
    @@ t/t5607-clone-bundle.sh: test_expect_success 'git bundle v3 rejects unknown capa
     +	git -C bundle-repo commit --allow-empty -m init &&
     +	git -C bundle-repo bundle create repo.bundle --all &&
     +	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
    -+		git clone bundle-repo/repo.bundle clone-repo 2>err &&
    ++		git clone --single-branch bundle-repo/repo.bundle clone-repo 2>err &&
     +
     +	test_grep ! "hint: " err
     +'
3:  6fef1d070c = 3:  98b32cdc99 advice: allow disabling default branch name advice

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
2.49.0

