Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83317E542
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654430; cv=none; b=VM2FzhfRp6cELyAVZlJL6pPqTASa8gE4qYFExkRpBAdXIJoi/RDjqyJhjE8Cp8WIy/sqMzsHJDMmAIz3mtLeGj8EKwKl5p/37udUiyXfJBhaLOInHIQ7fLks7qmerJIxi+CW2iVO88MuJShObnz3NhMnawiwa8jk6u/XCfAdtIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654430; c=relaxed/simple;
	bh=7bkfvZiJ7ES65MvxSB8n2Tx9Gi7zbKqGZ/YkmSX+J2M=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=UkzZb0ebz3brfKkhVK989c6z2Vbj60lE4N1EWqH1kD0YQKpEvqm9bAuaLzRT3c4UAoPVdwPfUzJds7/obu2GhbpR/dIWZ/J0wHOUJeEUq4rvJBFGk1+YWiLzw28FDBhupcDci+U70looMH4cTrA7MbIAeJjQfWuttYHgZAXZhoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8s2VI41; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8s2VI41"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so41445145e9.2
        for <git@vger.kernel.org>; Mon, 17 Jun 2024 13:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718654426; x=1719259226; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xoEfjQLX7+o08FkOWh/uQxuF+9zlcN93q3Dt0Rpj0+I=;
        b=b8s2VI41Q7+ueGxCg3yb/uK0f5aFP7duwdi6C4wz62Ucje5qoTIQ99skOorFWocNGc
         hxhvcwRz4TVUNq1cFh1ycvAMXGiky1+B0SHvy0tp7kwdNw8GlcTq31GhbDV47eTluNUl
         p3FkT8HzhnzM3bDwgIbisX9KNFoXy2Hf+z7m3sswflby+06JU2qTAE/Yw+wFXehI4/vi
         EcKIdpSlhmvFqoC9yfWHIKEmBz1pB2UGrY7jL9VxAIYqqJavJyHdfVm4SaQLbro0uwgy
         DYlVUmscjKD+w+20mUWgJ2zhdiV1X0PC5HXAOkijoEpLrjEmt1oxI7i38HGwgVz5oOvt
         /VAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718654426; x=1719259226;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xoEfjQLX7+o08FkOWh/uQxuF+9zlcN93q3Dt0Rpj0+I=;
        b=bNYhW9BPVDKnCa65WZw8UiIk95zkULqQShKZLsraPUIwbHon3Z5C9BtXNa8u047j28
         00eaOo6OlIJ2Od3DqJ8XFqVvBZPbEi1u33DjA13mOVZFL+WazgfVAaeIjeOuQFVO9DGH
         du52Rau0gxy0imYWxpNeqbMH8zjdCzd8Q2iwjdP3EPMbUyxDwlA90oNySTIYTYaw/eP6
         6LCQm+F3UJ9gPr5PsOazCb4Ni/NuGFytUwxAjemzhYy8beSUX8ankodpO3VNFP5jSeBZ
         4VaJhQYUrTW295ftnSTtjTcajr6TCFfbrbJ4jCK1lFLwiFgiTgoyS2NAeKZQByq+UBt1
         IvTQ==
X-Gm-Message-State: AOJu0Yy356f64/nHzs6Sl1D9SYAWm8cT5qb/YN00gUOLbEHBMEcB/NDM
	YtHjSfN3qhUXl/xkk8bAtctaTsyyemWm2s+ImdmwQlPyRngPnydBXrpBFg==
X-Google-Smtp-Source: AGHT+IEFmwym0tSu+A3ArFhylM8yVCs9ElKN2UmiyeJvI9lOfJLW1Rh2ry24sWA9l5S0Jrsy/XkyQg==
X-Received: by 2002:a05:600c:1d0f:b0:423:4c2:7a43 with SMTP id 5b1f17b1804b1-42304c27b17mr90429045e9.0.1718654426292;
        Mon, 17 Jun 2024 13:00:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a5b4sm167606325e9.41.2024.06.17.13.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 13:00:25 -0700 (PDT)
Message-Id: <pull.1747.git.1718654424683.gitgitgadget@gmail.com>
From: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 17 Jun 2024 20:00:24 +0000
Subject: [PATCH] attr: fix msan issue in read_attr_from_index
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
Cc: Kyle Lippincott <spectral@google.com>,
    Kyle Lippincott <spectral@google.com>

From: Kyle Lippincott <spectral@google.com>

Memory sanitizer (msan) is detecting a use of an uninitialized variable
(`size`) in `read_attr_from_index`:

    ==2268==WARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0x5651f3416504 in read_attr_from_index git/attr.c:868:11
    #1 0x5651f3415530 in read_attr git/attr.c
    #2 0x5651f3413d74 in bootstrap_attr_stack git/attr.c:968:6
    #3 0x5651f3413d74 in prepare_attr_stack git/attr.c:1004:2
    #4 0x5651f3413d74 in collect_some_attrs git/attr.c:1199:2
    #5 0x5651f3413144 in git_check_attr git/attr.c:1345:2
    #6 0x5651f34728da in convert_attrs git/convert.c:1320:2
    #7 0x5651f3473425 in would_convert_to_git_filter_fd git/convert.c:1373:2
    #8 0x5651f357a35e in index_fd git/object-file.c:2630:34
    #9 0x5651f357aa15 in index_path git/object-file.c:2657:7
    #10 0x5651f35db9d9 in add_to_index git/read-cache.c:766:7
    #11 0x5651f35dc170 in add_file_to_index git/read-cache.c:799:9
    #12 0x5651f321f9b2 in add_files git/builtin/add.c:346:7
    #13 0x5651f321f9b2 in cmd_add git/builtin/add.c:565:18
    #14 0x5651f321d327 in run_builtin git/git.c:474:11
    #15 0x5651f321bc9e in handle_builtin git/git.c:729:3
    #16 0x5651f321a792 in run_argv git/git.c:793:4
    #17 0x5651f321a792 in cmd_main git/git.c:928:19
    #18 0x5651f33dde1f in main git/common-main.c:62:11

The issue exists because `size` is an output parameter from
`read_blob_data_from_index`, but it's only modified if
`read_blob_data_from_index` returns non-NULL. The read of `size` when
calling `read_attr_from_buf` unconditionally may read from an
uninitialized value. `read_attr_from_buf` checks that `buf` is non-NULL
before reading from `size`, but by then it's already too late: the
uninitialized read will have happened already. Furthermore, there's no
guarantee that the compiler won't reorder things so that it checks
`size` before checking `!buf`.

Make the call to `read_attr_from_buf` conditional on `buf` being
non-NULL, ensuring that `size` is not read if it's never set.

Signed-off-by: Kyle Lippincott <spectral@google.com>
---
    attr: fix msan issue in read_attr_from_index

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1747%2Fspectral54%2Fmsan-attr-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1747/spectral54/msan-attr-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1747

 attr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 300f994ba6e..a2e0775f7e5 100644
--- a/attr.c
+++ b/attr.c
@@ -865,7 +865,8 @@ static struct attr_stack *read_attr_from_index(struct index_state *istate,
 		stack = read_attr_from_blob(istate, &istate->cache[sparse_dir_pos]->oid, relative_path, flags);
 	} else {
 		buf = read_blob_data_from_index(istate, path, &size);
-		stack = read_attr_from_buf(buf, size, path, flags);
+		if (buf)
+			stack = read_attr_from_buf(buf, size, path, flags);
 	}
 	return stack;
 }

base-commit: 8d94cfb54504f2ec9edc7ca3eb5c29a3dd3675ae
-- 
gitgitgadget
