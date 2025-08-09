Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF48277031
	for <git@vger.kernel.org>; Sat,  9 Aug 2025 01:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754702069; cv=none; b=uLP7hbtvU5tuYCMl+GC97JUCSoOcXqcsaoMDmclnK8vgaOaKvTFQ3jwtLPeSxbIPNwZDECby1rkVpFqJIuxO5J05FodO9eH1+VdsXBZazRLKjFqtgr2uH/VgbYMCb3UIgN8kipwDTTArebPidezUTPdHrWPGLvGy80Wx/vWdjug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754702069; c=relaxed/simple;
	bh=v3SjaZJIFv+L8xtxzF93GEATKxncPdGnBMufZu8m3WI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZR75071j+j+YzTX725PsgnBOGjK0+bMGZ5MpvJQ5mi5/rabPb8/Qm4hrz3s/4ODUQD8EicYSRxi/3ppevVTduToCvZ58VJ5jipbbrCrzYRjM1qK2hgC9c8SHAs+szPSCJ0LZH9hIQ4hm11BuToDoQyNiglDaNhtlXfWlJdtoINo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixef22W6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixef22W6"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-459ddf8acf1so22907165e9.0
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 18:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754702066; x=1755306866; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJEnUvOivdSppTnA+m5QlaWFUai/ubIYcKvlnzFC+QE=;
        b=ixef22W6TgLMGPx3ga/dV4G6eNXbLP01jjJ8eQ/5K6GNSv5UFo7N0YfPn3/GNSpKZG
         Bqho+Tqs9eWMI/5qYU+dkszhGZeq9KcECF9E0iRRCvegDGMrfag2mz65LSjSxyWcdISF
         fdTV4NKfHD1JxkxuXpGkKv26B7DN0p6Xk+Zi8AV9vwNsi93O7iDXmKejGjgM82FtPvbO
         qFWjdY0B+k9W8dF+yoUg21wCmh2cVl3WtATw2BlR0bKttsjeDfOiAKuRdjexs5bVKUwu
         O4zSIGA4GJkjBZ2xZIAltTyPPMRBYVm4iHpwY6LszvHs2tvKehjaxD/8RDZl6UsUp26v
         /nxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754702066; x=1755306866;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJEnUvOivdSppTnA+m5QlaWFUai/ubIYcKvlnzFC+QE=;
        b=aQrBe5wEbx7motPmIMeNru9GE6okrsn1DehGM2paRKKhoEfYLUYs6OLUmVviRcan5c
         DwosxPT5qjjQR+0321ytD84qRnvPVKIMW8ixlavjhQrvyfe5QTUrnF7Rfelb1+ygS8mC
         /H9261luXi+ClIDSQeQ5q6SOBG575sL8h8BjLQHm/3zviwtrO+xPO5NH+1MRyJaWdYS0
         UvI5B56nq6yJn1mQESXMrHizurz5GjXBa035WudXL7FjwDuYOhIOR8vrn6vkowVY7Rp7
         Zb6RsfGo0r4rzJ4oaEEAK8nKexXwYTY0DenggSUfzF4uWsxbyo34NVGR1hNk+ToIH9/x
         y39A==
X-Gm-Message-State: AOJu0YwKhC/9SacczAy9hut3ZR6FHR5TZbQ/Em6Odg6m3xaxyV+88oJ8
	/zRQvG6907aR659Pt2Zxuryx5s39MGnZ4SIUe7SpuwzneEpk6DsRZkhLL/P5Bg==
X-Gm-Gg: ASbGncsXABJRP0fPfJ8F3/Toosxim3sufhVeb2eUA0hcXEx1m9tNhEU/6LuEvodg2zn
	kfR96u3VM0ArHdUHm1YvRlwhXBM+7A7P8LczUolOOJGcIbq2d/UQbWE8dL/fG7+GfbZZT6cTVBI
	fCl2u748JI6vkBtEYT44+duHRCAKVmO1uO9UMhch7Jy1MoaoRkb8s2gBtLGXTixIR4PZfYJGNRG
	Wn8alosht9qItWvA7/cxGGVWALwcidqcv8ZDdPs9X+9+TwwEnXTBl2xL+rdnFWIkhMOqPJWJRxf
	tMixqiGqYV/X5nL3kzF2NHYELBh9Vnv5f7jW3EreHVG/OzLJ0zvM7WVWuEXidqbvxjFVHTa6zbx
	tnc/I0ZHRf4MaC8ulnU3BxB0=
X-Google-Smtp-Source: AGHT+IE4RlrOk+rpdn1gKj17PwxdeGeEqdZcU3JaEI0HPM6sWmV5TfmQcq/zf9tHNwZU7pll8+txtg==
X-Received: by 2002:a05:600c:4ec7:b0:459:e398:ed89 with SMTP id 5b1f17b1804b1-459f4ea2167mr35458935e9.1.1754702065712;
        Fri, 08 Aug 2025 18:14:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e04c7407sm22544486f8f.13.2025.08.08.18.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 18:14:24 -0700 (PDT)
Message-Id: <105a65e6e7121ac6a9a8a1d0b4f3217495a9f5e7.1754702057.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
References: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
	<pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 09 Aug 2025 01:14:17 +0000
Subject: [PATCH v4 5/5] doc: git-rebase: update discussion of internals
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
index 50c84f138212..c16ee37b46a7 100644
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
