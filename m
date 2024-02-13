Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D7321A04
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813714; cv=none; b=QBd7ncAiqKZD0s7X5XyHQbLDJx7qDd6yNy4K6cAnx+chSugvYV0ASx3wsJYEZxjmM9NxPqztCJNwPqAfVCtzG5qz7T2DgmXMwgMCTs261d6adj14Uo692TiWlQNyaTPeVFI5XNi6PSItGoQTcwIH4imoBqjawnqqVV19CGIdi8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813714; c=relaxed/simple;
	bh=hB7SHI2XYi9z2HqTMV39bGHQ1YaexhuIAL+4MZxEoyE=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=OwoR44aACer47wfoU/26UZfRUqCt2jrj3dzocSSFEidVrmCHKv2ZNbJeMPEn4GFFjb3id4zoQceMfeuM2gzN25/moYQe1AIH6tCUOzgSSOdwaQfYCAN4v85qyr0ki7dJPsQR4RhynzPb0x87JetNBh83lqJ7GLefDCczIJhzo2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJzhiEjr; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJzhiEjr"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33ce0802f17so56611f8f.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 00:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707813711; x=1708418511; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J3vgaKaoLOsrFZNay0mHm5ncTSyVu/7c7zgMQsntGVY=;
        b=VJzhiEjrIgso4cPNNA9OxtcqJl9h6JXuSfuXXDU13l0FZUoZcxwxVJjhBg2Qhbei1R
         vbhNtmddLRuGt52jQ9k5eDRjJDfkJ4S74IFMao4MuNG3P6/9grXVC+qcoGGIziAtSv/f
         O9EIOm7BCqFjFiTtUM8ZtXZFx0z8uBWIYGiLtBe3YXgANjXlWo++6RWnktSxIzNNPE0W
         jTnrhlYeOaRi6q1k8qgD7NUqXCRFOeyIhFfTMu2+x6QbJgH4pz8XlDblsQYTZq/i1+t4
         4tK4CcPwLYMKJVWPp0x6fc+p5qi0PSlrVwKuT070vh7JFtIGYG21d6Yzh60apZjR2/QM
         SDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707813711; x=1708418511;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3vgaKaoLOsrFZNay0mHm5ncTSyVu/7c7zgMQsntGVY=;
        b=PMOdMH5inKXecxus5q11aNSeVPQp7eetKpA5fnpavK+UQVW7pJe9P1VGwFBYCmLc7m
         ndeAZFzldPihr00BMwTUPnoB1CG0roJgSVzeqnH4jbD71ggl/o2OLBjrEpELqwLuvwMT
         TahGA+TlnPQgZ5e0Q2k0FcA23hjt8CnP/dPASWQMYR1ie1ruTEUq9obWxro05wbeVvpB
         eC1KKjUTqW2pGgFp0EwqAoJN3qy/Og3YvvHEse3BxQLJ239EQuo+WKVfP4QyBIOV8Tt7
         ydPxMDTSRW7T5746uLQf5wTt49pHVn9qOwecUsMk5mRSVozEmoh8hSwz/2N9afEXZpfL
         lDYQ==
X-Gm-Message-State: AOJu0YxErtnZEDFKT+J93CdGdvaja83VofmMOQMl+J5VBkmVX+QB2g2N
	auP56/JVZ1nxBQ3FjXJd5KAP/zhJpw0B4zgM3lzKdAvAqP0y5bb45KVM1+2N
X-Google-Smtp-Source: AGHT+IH3/SURNDdDQEuvA9cy+W+vrDOfHH6dY69B93/VmS9bTfZTo7VmWycQ1DzygJdS3LUM7Ac+pQ==
X-Received: by 2002:a5d:5f93:0:b0:33b:79b3:a494 with SMTP id dr19-20020a5d5f93000000b0033b79b3a494mr5820258wrb.31.1707813710550;
        Tue, 13 Feb 2024 00:41:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ce9-20020a5d5e09000000b0033b8808355fsm3114439wrb.28.2024.02.13.00.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 00:41:50 -0800 (PST)
Message-ID: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 08:41:36 +0000
Subject: [PATCH 00/12] The merge-base logic vs missing commit objects
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

This patch series is in the same spirit as what I proposed in
https://lore.kernel.org/git/pull.1651.git.1707212981.gitgitgadget@gmail.com/,
where I tackled missing tree objects. This here patch series tackles missing
commit objects instead: Git's merge-base logic handles these missing commit
objects as if there had not been any commit object at all, i.e. if two
commits' merge base commit is missing, they will be treated as if they had
no common commit history at all, which is a bug. Those commit objects should
not be missing, of course, i.e. this is only a problem in corrupt
repositories.

This patch series is a bit more tricky than the "missing tree objects" one,
though: The function signature of quite a few functions need to be changed
to allow callers to discern between "missing commit object" vs "no
merge-base found".

And of course it gets even more tricky because in shallow and partial clones
we expect commit objects to be missing, and that must not be treated like an
error but the existing logic is actually desirable in those scenarios.

I am deeply sorry both about the length of this patch series as well as
having to send it in the -rc phase.

Johannes Schindelin (12):
  paint_down_to_common: plug a memory leak
  Let `repo_in_merge_bases()` report missing commits
  Prepare `repo_in_merge_bases_many()` to optionally expect missing
    commits
  Prepare `paint_down_to_common()` for handling shallow commits
  commit-reach: start reporting errors in `paint_down_to_common()`
  merge_bases_many(): pass on errors from `paint_down_to_common()`
  get_merge_bases_many_0(): pass on errors from `merge_bases_many()`
  repo_get_merge_bases(): pass on errors from `merge_bases_many()`
  get_octopus_merge_bases(): pass on errors from `merge_bases_many()`
  repo_get_merge_bases_many(): pass on errors from `merge_bases_many()`
  repo_get_merge_bases_many_dirty(): pass on errors from
    `merge_bases_many()`
  paint_down_to_common(): special-case shallow/partial clones

 bisect.c                         |   7 +-
 builtin/branch.c                 |  12 +-
 builtin/fast-import.c            |   6 +-
 builtin/fetch.c                  |   2 +
 builtin/log.c                    |  30 +++--
 builtin/merge-base.c             |  18 ++-
 builtin/merge-tree.c             |   5 +-
 builtin/merge.c                  |  26 ++--
 builtin/pull.c                   |   9 +-
 builtin/rebase.c                 |   8 +-
 builtin/receive-pack.c           |   6 +-
 builtin/rev-parse.c              |   5 +-
 commit-reach.c                   | 202 +++++++++++++++++++------------
 commit-reach.h                   |  26 ++--
 commit.c                         |   7 +-
 diff-lib.c                       |   5 +-
 http-push.c                      |   5 +-
 log-tree.c                       |   5 +-
 merge-ort.c                      |  81 +++++++++++--
 merge-recursive.c                |  52 ++++++--
 notes-merge.c                    |   3 +-
 object-name.c                    |   5 +-
 remote.c                         |   2 +-
 revision.c                       |  10 +-
 sequencer.c                      |   8 +-
 shallow.c                        |  21 ++--
 submodule.c                      |   7 +-
 t/helper/test-reach.c            |  11 +-
 t/t4301-merge-tree-write-tree.sh |  12 ++
 29 files changed, 413 insertions(+), 183 deletions(-)


base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1657%2Fdscho%2Fmerge-base-and-missing-objects-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1657/dscho/merge-base-and-missing-objects-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1657
-- 
gitgitgadget
