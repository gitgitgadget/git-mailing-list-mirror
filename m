Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792567065;
	b=QeSs15u1RWvb9JVh2ElKssEtfxWa07l/ToTKfv1JQ6HE5u7G3r1ZEIbpjB1ATnuImVJI
	 LSU6IrINI5wjTSX+Bm72hOSFATtb0HBzI/4t7UegkSWejK5vGrY/TeNHU/EUdyJBUOEHq
	 Va804CIsdHzwxVp93wlPZG1NJyW/U7fRMNBZlct8wypbybi10szCC4lWKeEG+gb8IXgQO
	 w0CbSqY5mPsJysnkReuhjbqYMUuY0nB3yNHhRlv3txWGxbokhpRv7h6M5I5D/scIIsJqR
	 DCA/LiHX8iDMsOdU/ANDOpd64tJGgqLa25az8ZtOaixcNhgUfpaI7hs5siP6ABQ1HTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=lce1l7tJnwk9f6heC+dQjv8qa8VJ6DHb3yDBVcGMO2E=;
	b=VeZ9cO7xJY2Zgy3Zc9chOki8J1DNqUzCYOsRNJUwBeZXkzAvht2nHmrVuoCXbfgGL2vx
	 pcV3GIwrpbhqFjnEQJ3UADe5dBZYC3hIsy/2sKh+wWw85qjEDEJ03sseLShsa3xjRsb8Z
	 UoMAvzPYE17URavLfTV+Jp8dfCNN9PmK0frNGeEwVThYWITMKftWW9byJ3Ccp7hyj5p+e
	 1ZflUqh1l0gmE+qQ2rC6Q13+blW8IFf0R52gJ/RGQ/Gvhz24pZbSMJLpwiDi9z4ExunjS
	 I1x3LP+5LKNW9EcNKP5hVD+yHY0FtEYnU3MTcphELGhuSLp9stj4IbVmVGtEoV/hlsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A0Prtzy7;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72324606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 07:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72324606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A0Prtzy7
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-844a8bf7e25so319950a34.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 00:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792567064; x=1793171864; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lce1l7tJnwk9f6heC+dQjv8qa8VJ6DHb3yDBVcGMO2E=;
        b=A0Prtzy7jNPNLg1GbjfFbtmrPEncI6/lmwVr6EbNCSEa/b+6d8Tu0MRbForDqPb2aG
         QwnkSTTPhvyBrEpFViTflphERX9LbbJlQwrC/0cRIylg64MKdmr3zNpzV6PzY6Wa6hvz
         KGP1OFmQxXV8/Ntx3uZmNKrTmU+QbSIGq/EBikqWkC/w1cnJXfNPVXWic5JDk0D9qzae
         QhpQPYpI3AyoLSRb9XLTFIsBJyin7wTet5/TemSLFOeMdkzLEmiXdofgC0oJTeCrp9KO
         httrQfaZZytquZX3QzwEJSmM/XWVTPX+ufBIoeIzIprBFSLoBVn4wX+DVkeE1QhUhKB1
         G8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792567064; x=1793171864;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lce1l7tJnwk9f6heC+dQjv8qa8VJ6DHb3yDBVcGMO2E=;
        b=SJpVwLL81HPLDH2SY0ulp2TB1+yyLA9PC4CmYUw7gOVCr/rrNou8foLmo36plvMwyq
         X0sh3zCH821YdeeZRWM+NVIB1CYnHNxVe4fC9q/3STRva6c7zJebZFbkVLGI6m3bhK9t
         kpBpkXnaOIxd/sSizWU+nh0goanuB/bgDtWRTIqSyczkb40qjbcKxlwBsQduvDtD1heV
         PBcfDVdggXJgV9DJDMTa3LsRuVQKoyowYWEs1mCTenQCieMYcL8ybbrHD4h+xCVVCO4r
         PQqd35MhYThxnHSNXTqk3LDjptUJdRAV5HQl0NtqHZd+lk60ehylRKsZ+fJAVEmET0a8
         MeNw==
X-Gm-Message-State: AFq9FYIcbNyYhGByZqLp9AslfIP/jEy/UPgHVxRZY9Q4UD0hnuSTwPZr
	/BVV1+gVVoc6Ajad5hvXszP+lF7JAylLtjPRuCwKy16AXYBoNsFnjazEzbcMnQ==
X-Gm-Gg: AYBFou1MgkGc4XofxenLsm6R1LmWQoank346pe4DzjFMBVrKwMQObKQWo33XJ1vDcne
	fIqUXQ9zTZ0CLmcfxc8+G33RZXQjRFTOqeyKgJNMJsoGxx9aDi7yAtG4g3VT/Hho1CNM/+m/w31
	/fYq5plg2iNkd0KummWR1mQ5dkNvDWwtcmuVkoeB75etHaHT12Sjm7bZlDxXSdBl9MDAb4umiXH
	Y2TeOed55Zaa/m+VXriFEATU6PhGz3dCwF1v9OqXTN7XUW4zVrmsRjOOgq8TGf8KlqnMI97q2aO
	cjRF6d/FZyOGq1e9n4fqv1v4bJ+2eOOMc76uG3Egg9n0laXX7x8d6efLx5LAs4bAUHdEu7bs7Sw
	7oKOeHzyfoqWitQoLoFcqtSMhc7bQHFJgJzmhAMCGErrfooptv0/1Skq5o1rMs4oyq6elyOR5RK
	eoxtD7MLJGRS26D67cnlbT4FmgJjlfZM5ayoqWkqcAd4LfEyaHiwZhyIj+bL6LH/dgaCtZ8TcRq
	gwVfYuuRlq3RpopNMkf2POhi5wQTMkVH8hpW6fdrb9vwdKFI4y3H4+0wPBq
X-Received: by 2002:a05:6808:220a:b0:544:1bec:8daf with SMTP id 5614622812f47-5535d4d7803mr692597b6e.37.1792567064083;
        Wed, 21 Oct 2026 00:17:44 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.140.214])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-552b87ce630sm1317397b6e.15.2026.10.21.00.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:17:42 -0700 (PDT)
Message-Id: <pull.2317.v3.git.git.1792567061.gitgitgadget@gmail.com>
In-Reply-To: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
References: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
From: "Jason Newton via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 07:17:37 +0000
Subject: [PATCH v3 0/4] worktree: copy-on-write creation and ephemeral branches
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Jason Newton <nevion@gmail.com>

When many worktrees share one repository -- for example a fleet of agents
each needing an isolated checkout -- "git worktree add" is costly at scale.
Objects are shared via the common directory, but the working tree is not:
each add rewrites every tracked file, so N worktrees cost N full checkouts
of disk and I/O. A branch created only to back one of those worktrees is
also left behind when the worktree is removed.

Patch 1 adds "git worktree add --reflink". On a copy-on-write filesystem it
populates the new worktree by reflinking the current worktree's files and
index, then "git reset --hard" rewrites only the paths that differ from .
reflink_file() in copy.c uses FICLONE (Linux), clonefile() (macOS), and ReFS
block cloning (FSCTL_DUPLICATE_EXTENTS_TO_FILE, as Git LFS does). Elsewhere
it is probed up front and falls back to a normal checkout. worktree.reflink
(true/false/auto) sets the default; --no-reflink overrides.

Uncommitted edits to tracked files in the source do not leak into the new
worktree. The copied index is refreshed before reset, and because every
reflinked file is a new inode the refresh re-validates by content. Only
untracked files are carried over. The option stays opt-in for that reason:
it copies the source's untracked and ignored files, which a plain checkout
does not.

For many worktrees at one commit, the series does not share a branch.
git-worktree(1) shows a single update-ref transaction that creates a ref per
worktree (or a detached HEAD). A shared branch still lets a stale index in
one worktree silently revert a commit made in another.

Patch 2 treats a branch that "git worktree add " created itself as owned by
that worktree. "git worktree remove" deletes it. Branches named with -b/-B,
or that already existed, are left alone. --keep-branch keeps an owned
branch.

Changes since v1:

 * Dropped the patch that allowed one branch to be checked out in several
   worktrees. Documented the per-ref / detached-HEAD pattern instead (brian
   m. carlson, Junio).
 * Explained, in the commit message and the manual, why a dirty source
   worktree does not leak tracked content (brian m. carlson).
 * Added the ReFS block-cloning arm (brian m. carlson).
 * Noted overlayfs as a supported setup when the lower filesystem supports
   reflinks (brian m. carlson).
 * Kept --reflink opt-in. A whole-tree reflink is not invisible: it carries
   untracked files, and cloning every file can be slower than checkout when
   the files are small (Junio; qub1n on the ReFS work).
 * Rebased onto 47fdf2208c ("The 7th batch"). reflink_file() now takes a
   repository argument, matching copy_file().
 * Added ephemeral-branch reaping for the auto-named branch that "worktree
   add " creates.

ReFS measurements (32 GiB Dev Drive, Windows build 26300). The USB disk
itself would not format as ReFS, so the volume is a Dev Drive VHD on an NTFS
partition of that disk. NTFS rejects the clone ioctl (win32 error 1 there,
error 50 on C:) and falls back to a full write.

The clone shares the source clusters and does not flush. Four thousand
clones of one 8 MiB file, 31.3 GiB of logical names, were read back
unbuffered and SHA-256'd in full: 4000 of 4000 matched the source. The
source was then overwritten with a different pattern. A read-only
FlushFileBuffers failed with win32 error 5; a writable reopen succeeded.
After that flush, 4000 of 4000 clones still hashed to the original contents
and none hashed to the new source. While the clones were created the
free-space counter fell to about 1 GiB, then returned to 28.38 GiB with the
clones still present. The backing VHD did not grow. Deleting the clones
freed nothing further.

Jason Newton (4):
  worktree: add --reflink for copy-on-write worktree creation
  worktree: reap ephemeral branches created by "worktree add"
  worktree: disable reflink on Windows
  worktree: keep the reflink probe referenced on Windows

 Documentation/config/worktree.adoc |  12 ++
 Documentation/git-worktree.adoc    |  75 ++++++-
 builtin/branch.c                   |  28 +++
 builtin/worktree.c                 | 315 ++++++++++++++++++++++++++++-
 copy.c                             |  83 ++++++++
 copy.h                             |  14 ++
 t/t2400-worktree-add.sh            | 166 +++++++++++++++
 t/t3200-branch.sh                  |   2 +-
 t/t3400-rebase.sh                  |   2 +-
 t/t5516-fetch-push.sh              |   2 +-
 10 files changed, 690 insertions(+), 9 deletions(-)


base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2317%2Fnevion%2Fworktree-reflink-cow-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2317/nevion/worktree-reflink-cow-v3
Pull-Request: https://github.com/git/git/pull/2317

Range-diff vs v2:

 1:  83841020f4 ! 1:  a163f737af worktree: add --reflink for copy-on-write worktree creation
     @@ Commit message
          and bcachefs implement, and the one overlayfs forwards when the lower
          filesystem can clone. This path has been tested on btrfs.
      
     -    On macOS it uses clonefile(), the APFS primitive. That path is
     -    implemented and has not been run here.
     +    On macOS it uses clonefile(), the APFS primitive. The t2400
     +    REFLINK prerequisite probes that with "cp -c", because BSD cp has no
     +    --reflink=always, so the macOS CI jobs exercise this path on APFS.
      
          On Windows it uses ReFS block cloning,
          FSCTL_DUPLICATE_EXTENTS_TO_FILE, as Git LFS does. The destination is
     @@ t/t2400-worktree-add.sh: test_expect_success 'relative worktree sets extension c
      +# Reflinks are only available on copy-on-write filesystems (btrfs, XFS,
      +# bcachefs, APFS, ...). Where they are unavailable, --reflink transparently
      +# falls back to a regular checkout, which the test above already covers.
     ++#
     ++# GNU cp probes with --reflink=always. macOS cp has no such option; -c
     ++# is clonefile(2), which is what the APFS CI jobs exercise.
      +test_lazy_prereq REFLINK '
      +	echo probe >reflink-src &&
     -+	cp --reflink=always reflink-src reflink-dst 2>/dev/null
     ++	if test_have_prereq MACOS
     ++	then
     ++		cp -c reflink-src reflink-dst 2>/dev/null
     ++	else
     ++		cp --reflink=always reflink-src reflink-dst 2>/dev/null
     ++	fi
      +'
      +
      +test_expect_success REFLINK '--reflink carries untracked files and reconciles changes' '
 2:  6e2acdc5e2 = 2:  042485f0e9 worktree: reap ephemeral branches created by "worktree add"
 -:  ---------- > 3:  91806975a6 worktree: disable reflink on Windows
 -:  ---------- > 4:  876fb541a8 worktree: keep the reflink probe referenced on Windows

-- 
gitgitgadget
