Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F98463B64
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 22:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791757298; cv=none; b=PjS4O4mjksOMyNYpmgZCZSKhB5RGzJXT3fWCqb79BcuIwL6Tnx201AVP3HHujYPUNrIahrd0qW3GeTrv4wT6NjL5yxZwZ0o2eex8Ip112PanboRI0yyHVWCVmI4C8FRsGKWlZd3GuFNYCeydpZtkDhG6VGJ0PAL8lFF4BIRMWik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791757298; c=relaxed/simple;
	bh=zhrQ0ANBRvGdfPSTsgs2qZclsTe/vv3Yysr9E6J5amQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YvBZZ/TBX3lIXun58UtnU3ukkBnPiihOeWCbMIQK4zOkwTsYLvNG1G8vIo0bzN3FdbYDcliAKtTzQ1TZOubnlncfN/Dnz5pdFlW+FuA1LzDB+Ei28BmYpwURtLV8ORi9DiOybo+9haEfABb1v0bWyeNWM24HY4TULIZ8t+itgCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Om99ZnIM; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Om99ZnIM"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3115c4451c8so1397862eec.1
        for <git@vger.kernel.org>; Sun, 11 Oct 2026 15:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791757295; x=1792362095; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kqj9esJKVWRUSrlxcC/yH4dMd9lkltGn0/eqmZr/juM=;
        b=Om99ZnIMkNQ0NAjKmg/Z/IIrVThc4CvN7BrhXPiBmLlZFwMrwZu9eviYVpIL+lKfJE
         1CMUe7O9/saBMsY7oXSjtlfm0xSHGOzmxn36N8H6X6C7onaZ3fnjwEM+vHE4LR75V+TP
         it9/624Uc2gq8SgEL88vzgm+fRlpuGLNJ5atEEKCwmbsuqmJsqszRasrlbFOup8N8bZk
         gw9OzE+2XilGsNyWOu0K4yYU+/IM81jDf+EhTJFW9l0P46P62zQPBDlmRJIaNob1u09h
         9TzFHUUwk9DRBn3oQ9d8fJamqJJE98ofkkPaKWMaCHyyGJEAaoxJ8kRB5QA/L4oBT5wh
         UHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791757295; x=1792362095;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kqj9esJKVWRUSrlxcC/yH4dMd9lkltGn0/eqmZr/juM=;
        b=qYNqRHcbIQ2Dumolg3A6XPxbxxlk8T/jisvxKZV1tkMRiRqv6BqwhmUCg8uOccP26b
         epmFaMllXMFsgtnqkOFG9X4t3pH71Z4IEgF420sK7XhgbZwu3/Vn/f77GELoP0nlHkMb
         cF+umUp2BUNRwSCjS8+B3ZCCD9oZR03rgdVnt+tJibsZvCa5/XqtcJbrgyXNBvAjODtJ
         hkn461xneqeGt0nCA399fq8VxCVUZ68q2y5Ksae/f84HbXvz29DGBtFDe66Hz51E0j79
         yiXgFhaLKc31YsTen0HX+3uS/MAXFV69HKAnqly1pNp+Anik+6x2Fgr0fkiLYS11Bv7n
         +KTA==
X-Gm-Message-State: AFq9FYLb8SdnP1U74+qw+fLWFCSl7DApLjRGYsmDn/DZEFJ46HBXHtt7
	/cCNb+GAeyhcXMZ76D+8pT4MMkyym5oIbpT2aAVA/fyNykAHyHHNi7RLVMYXH/Jz
X-Gm-Gg: AYBFou39galBv+9taRTmgZh2B9O1blpWuERaa3TVDlj7WSTp9JpGfImTh97v32inIbA
	Gp2ZSMI7MKUri07+4qY7sghM/y5Jtk9Fc0EyFcdqkEimYYOo96zxm0V0mpdArsAlYzOf88Hkxhm
	9FqNzqZrIPxqDagH5/g4RNd9jEY3Vyr8duMYO+cTEmF50LCX5ZzIkNwWtUB4uiNcvUiZ+zYB2Hi
	ggy8Hda/75zALB8tO6Rb1QMO1d/0oaLp20UlwD4da7ummcOIhUoS6dr/3kUgT/N+QbAAejbuWvD
	Fc0TTLRu86RZ8PVHohG9yPYRQrWkt/AeqHCrq1VmaqJRT0T9uNuLmHpCKY5UGi5rMPSHEeiKwkb
	BPZjLtpEpp4ZU3JzAGSCSRnM+dqhSOiXVjLaBS7/7Qjq6L/jXiFI8zLW4+g+SZCBGVep+mNTcBh
	v1+6T0jIsrGkk1xSosX/EDBSZ3hwcLrOxUoDmv/yBiGBtuaHe81PrRwA/X/flUwhcbZ9Oxmbu2
X-Received: by 2002:a05:7301:7d19:b0:353:7b3a:1c84 with SMTP id 5a478bee46e88-3537df7772fmr11791784eec.5.1791757295357;
        Sun, 11 Oct 2026 15:21:35 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.103.16])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm30190427eec.3.2026.10.11.15.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 15:21:34 -0700 (PDT)
Message-Id: <pull.2224.v3.git.1791757294.gitgitgadget@gmail.com>
In-Reply-To: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 11 Oct 2026 22:21:31 +0000
Subject: [PATCH v3 0/2] blame: ignore revs in HEAD:.git-blame-ignore-revs by default
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Abhijeetsingh Meena <abhijeet040403@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Ravi Mistry <rmistry@google.com>

This series teaches git-blame(1) and git-annotate(1) to automatically use
the HEAD:.git-blame-ignore-revs blob by default if it exists, so local runs
match hosting platforms without requiring manual blame.ignoreRevsFile
configuration in every clone. This restarts the stalled attempt in PR
https://github.com/gitgitgadget/git/pull/1809
(https://lore.kernel.org/git/pull.1809.v2.git.1728707867.gitgitgadget@gmail.com/)
and addresses https://github.com/gitgitgadget/git/issues/1494.

Changes since v2:

 * Patch 2/2 uses sb->repo instead of the_repository in
   parse_default_ignore_revs_blob().

Changes since v1:

 * Split the series into two commits.
 * Patch 1/2 hardens oidset_parse_file_carefully() in oidset.c and
   peel_to_commit_oid() in builtin/blame.c before exposing them to
   upstream-controlled content at a well-known path:
   * Reject lines containing embedded NUL bytes via memchr() so trailing
     bytes after a NUL cannot be silently ignored.
   * Pass OBJECT_INFO_LOOKUP_REPLACE | OBJECT_INFO_SKIP_FETCH_OBJECT |
     OBJECT_INFO_QUICK to odb_read_object_info_extended() and peel tags one
     layer per iteration so missing OIDs or tag targets do not trigger lazy
     promisor fetches or pack directory rescans in partial clones, and
     verify that each peeled target matches the tag's declared type.
 * Patch 2/2 reads the committed HEAD:.git-blame-ignore-revs blob (in both
   bare and non-bare repositories) instead of reading a file from the
   working tree, matching hosting platforms even when an untracked file is
   present or a tracked one has local modifications. The tree entry is
   checked with S_ISREG() so non-regular entries (such as committed
   symlinks) are skipped, parsed in memory via
   oidset_parse_buffer_carefully(), and bypassed without reading if cleared
   via blame.ignoreRevsFile="" or --no-ignore-revs-file.

Ravi Mistry (2):
  blame: harden ignore-revs parser and tag peeling
  blame: ignore revs in HEAD:.git-blame-ignore-revs

 Documentation/blame-options.adoc |   8 +-
 Documentation/config/blame.adoc  |   9 +-
 builtin/blame.c                  |  65 ++++++++-
 oidset.c                         |  81 ++++++++----
 oidset.h                         |   9 ++
 t/t8013-blame-ignore-revs.sh     | 220 +++++++++++++++++++++++++++++++
 6 files changed, 357 insertions(+), 35 deletions(-)


base-commit: fa7f9290efe2bd22dd736689597b474b93798e11
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2224%2Frmistry%2Fblame-default-ignore-revs-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2224/rmistry/blame-default-ignore-revs-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2224

Range-diff vs v2:

 1:  2e12486c0d = 1:  2e12486c0d blame: harden ignore-revs parser and tag peeling
 2:  35e303d65b ! 2:  72a87d1c34 blame: ignore revs in HEAD:.git-blame-ignore-revs
     @@ builtin/blame.c: static int peel_to_commit_oid(struct object_id *oid_ret, void *
      +	size_t size;
      +	char *buf;
      +
     -+	if (get_oid_with_context(the_repository, name, GET_OID_QUIETLY,
     ++	if (get_oid_with_context(sb->repo, name, GET_OID_QUIETLY,
      +				 &oid, &oc))
      +		goto out;
      +	if (!S_ISREG(oc.mode))
      +		goto out;
      +
     -+	buf = odb_read_object(the_repository->objects, &oid, &type, &size);
     ++	buf = odb_read_object(sb->repo->objects, &oid, &type, &size);
      +	if (!buf)
      +		goto out;
      +	if (type == OBJ_BLOB)
      +		oidset_parse_buffer_carefully(&sb->ignore_list, buf, size,
     -+					      the_repository->hash_algo,
     ++					      sb->repo->hash_algo,
      +					      peel_to_commit_oid, sb);
      +	free(buf);
      +

-- 
gitgitgadget
