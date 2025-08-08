Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2192270EDD
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 22:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754693561; cv=none; b=Qb40LSP/cMfNNKCZSdU/q/Vp85ghGBWXv0whYsxEfRnTpe3t0EBeDp2mh0F48OHNy/PUgYx5H+IwFUKHw624HWdmGVPXEvS1vlP/RXImFWSSlZkT0ola/fe/+S6KQGiIDLyfPJgf0S3O1jlQIZVcmDL95bZXojGa1cRgRwqi3DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754693561; c=relaxed/simple;
	bh=funV0MKY4zMbi/0U0XDay1k7QI3jQgquhtZNbmJJBRY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KyvdPesF9QZNgTX9yIRXezBcvkIKay4TopKyl6eesbRfxh6sxFseYc6demIvSOSUhl1qV1xZxnp64YyA+9umoXZ9tl01MP+IE2/MEccfKNLoaQjm9oyWE2V3wzeoGqeQBwYe/ir7tahlAA2lXHM538OjbMK9HBMdJJqEgGyakB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAL2dalj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAL2dalj"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-458b2d9dba5so16554655e9.1
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 15:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754693558; x=1755298358; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2A/fu11vuLMdDVFtnSZIiYja3lIZ/zZyhk8VFLAAbKk=;
        b=gAL2daljPd8dwXkPoCEojopP/OeCf7YCtn2IVGAm+mzRN1hwQ4k30JTeGTjfizPG7o
         zdnfK0bVfHSH93cNsiEc9EfMkUUzjiIvFYGspL/zlCFRUkKG4cdnoHwJbpCb2+b8lZYq
         Y5W7D4xEhDPInqLz2lQwx8AgUCc8MkR4olwRHr/wWisKHzNLOLaTvsg4z/nK+PhpB5Yh
         MUwIEhfCz1RcXRmYk0GCmRbOV4EN9g/ZqiumjiyKtcuimgUHRakGuKzndp7p5oAbnZV3
         qzGUbnfzcXxdMN+LKW3n3923+kDj//+bJW256CGEVQENe69OFiYzrQM9Lo82bfXI6aqv
         HSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754693558; x=1755298358;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2A/fu11vuLMdDVFtnSZIiYja3lIZ/zZyhk8VFLAAbKk=;
        b=goGZy+Rg5ar84SaMnwYxpkpiRTMTM8KWsIfNVQhYwd5HH1eejJZD1Ks69sXjbo5jsK
         N+FlCRIb64pcSVMuksv5sz275C8Zvn5sbQP4zHwGTBGKGomULGXpXJkrFJxmLjqgFgQo
         4U1EatIUWryG9wYZfjL7CggDSMZIPt3Q1CMYiIzoyeh3KwyRXl4uvWCfYsiQLnFMZvef
         WaltwssclREzjPpkx71Okxg4qFzy6PpJ5yFt9tV8gzDGR35+k3Yzb+pyBwSp7uJOuJnL
         UITyBkp4kDibQ8GpfGwfjBJ2UYKJXYzI3/NJ+PqxVHtVA+Nd1y8C/cQCO/6rZPxpoc20
         B0Fw==
X-Gm-Message-State: AOJu0YzSKuCsa073rY7wcp650/R7UcJ5kXOeuByekYuED6JQhAIl7xUN
	j6jTPaWdys4vtOjKWJko/9BT2mUwilFh1PfBbvR3s5DwUcHD4hMfqVjnjg2fdg==
X-Gm-Gg: ASbGncuN0nHDFnVs6h12QGq3eQ9jEg5XxsU+vrWJlZDtUfWKkbxypxwZ5gB4fDBKOk1
	5GtEsRPj/GUKN4LtHtRUpSa3mK+++Y0Rr/6fypIo0fZmO/rVC6IGyldpAXfmedVZIg+EH6fn3Sf
	yK9iMpM8vsoyq9pUmg1ikZd0UGzYrfWXgl6v8U+/4Yg6wHMhBEIyMRNLuXqyxTKQV1La9nGwmEx
	O/Q2DB3ndlVd0vnxl6BkgSbWoWMtGa8HvjZ1gyBOkniT7qIHTXj68DelmvbbW2/9iF28zyLQgtw
	CYuH+Ut5w04T0TgnHad2A22tN9DPh55Ow0rG1tElUinEMohscFc8esT+UOiX+kos7DOy6Xw3nVt
	3FX5qftfsTt4Ws4vTqWjvfA8=
X-Google-Smtp-Source: AGHT+IGrGRSEOeqjI8t/+nGGf9d8mXdV2uxN3aGlADHkq2AofI39UEqrLcF+Kd6Ek4Hj/CgGV/LCMA==
X-Received: by 2002:a05:600c:3589:b0:456:19b2:6aa8 with SMTP id 5b1f17b1804b1-459f4f0f380mr43261895e9.19.1754693557987;
        Fri, 08 Aug 2025 15:52:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e584302csm166939415e9.7.2025.08.08.15.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 15:52:37 -0700 (PDT)
Message-Id: <eabacd3c159a9abe656cbb778a53558d471b5165.1754693552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
References: <pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
	<pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 22:52:32 +0000
Subject: [PATCH v3 5/5] doc: git-rebase: update discussion of internals
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

- make it clearer that we're talking about a multistep process
- give a more technically accurate description how rebase works with the
  merge backend.
- delete a duplicate explanation of how git rebase skips commits with
  the same textual changes (it's explained in more detail a few lines
  further down)
- remove the explanation of how exactly `--fork-point` and `--root`
  work since that information is in the OPTIONS section
- put all discussion of `ORIG_HEAD` inside the note

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 6a4b3dbd5960..df77bbdecfec 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -65,31 +65,31 @@ linkgit:git-config[1] for details) and the `--fork-point` option is
 assumed.  If you are currently not on any branch or if the current
 branch does not have a configured upstream, the rebase will abort.
 
-All changes made by commits in the current branch but that are not
-in `<upstream>` are saved to a temporary area.  This is the same set
-of commits that would be shown by `git log <upstream>..HEAD`; or by
-`git log 'fork_point'..HEAD`, if `--fork-point` is active (see the
-description on `--fork-point` below); or by `git log HEAD`, if the
-`--root` option is specified.
-
-The current branch is reset to `<upstream>` or `<newbase>` if the
-`--onto` option was supplied.  This has the exact same effect as
-`git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
-to point at the tip of the branch before the reset.
+Here is a more detailed description of what `git rebase <upstream>` does:
+
+First, it makes a list of all commits in the current branch that are not in
+`<upstream>`. This is the same set of commits that would be shown by `git log
+<upstream>..HEAD`. You can use `--fork-point` or `--root` to change how this
+list of commits is constructed.
+
+Then it checks out `<upstream>` (or `<newbase>` if the `--onto` option was
+supplied) with the equivalent of `git switch --detach <upstream>`.
+
+Then it replays the commits, one by one, in order. This is similar to running
+`git cherry-pick <commit>` for each commit. See REBASING MERGES for how merges
+are handled.
+
+Finally, it updates your branch to point to the final commit with the equivalent
+of `git switch -C <branch>`.
 
 [NOTE]
+`ORIG_HEAD` is set to point at the tip of the branch before the rebase.
 `ORIG_HEAD` is not guaranteed to still point to the previous branch tip
 at the end of the rebase if other commands that write that pseudo-ref
 (e.g. `git reset`) are used during the rebase. The previous branch tip,
 however, is accessible using the reflog of the current branch
 (i.e. `@{1}`, see linkgit:gitrevisions[7]).
 
-The commits that were previously saved into the temporary area are
-then reapplied to the current branch, one by one, in order. Note that
-any commits in `HEAD` which introduce the same textual changes as a commit
-in `HEAD..<upstream>` are omitted (i.e., a patch already accepted upstream
-with a different commit message or timestamp will be skipped).
-
 If the upstream branch already contains a change you have made (e.g.,
 because you mailed a patch which was applied upstream), then that commit
 will be skipped and warnings will be issued (if the 'merge' backend is
-- 
gitgitgadget
