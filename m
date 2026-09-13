Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8A036C5BB
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789315036; cv=none; b=M/uBfN2VAKWhxPkvFnHFr/5pxZqORzN0eAm/LmzWBpqyViV8BEqocQKS4jI8rgFkhMrImPGrlgPKGfYU11aQqebvAaTt76YsLlLEww2XxvZ5te4XJVunaBSXnuNknDko4weA8Lh3IwE/lTCXDWziS2vQVKbK38RDgn1hsadA5LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789315036; c=relaxed/simple;
	bh=PiP8YCeskq8t3KDOhpr+G0/q6Yp1YoqSwQgWGNq+jgo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=S4BU+S22lEIiI3OwPaznxYHJnV6RbJAzNVcFTm230rOV4MvluHPH+0B+GK/87nboL5z8FC9yHHE2vrHKnXQMd9q6wqtlh5ppYXQGuQ1kUSoFQsVG3fPOJ2/IhjTuTX/yejdTCUql7UCNNIFvUzzr0n42Dx0xA706cVQkVHvGpQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhGb6X45; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhGb6X45"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb751so1263915a91.2
        for <git@vger.kernel.org>; Sun, 13 Sep 2026 08:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789315034; x=1789919834; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xe1I5qbpgojxlxGpVRTMNTQbLO1llVPN8D1dRd7iMWQ=;
        b=nhGb6X45VHP6oWLGH7mo4KKrZkKsoBdPyMxNmRruVXC/2tHNwPwd1TyevFix3FBRIc
         YeojF8Pbbd8T5S2M3C2WEeetbC3xcSfXj4GWYjKTUIlJm2ov3MNlRXrC+n/80imbXc3d
         1tPu7s+GaOWBdyMSq749XswiyMswDsLqrZ/HVUxQqAknoVWUuF4DLNdz8J3Gq1ucgOBs
         DaZB7d9Fl2cFXCjG7H3TupAiO6vExaspFJpxculjaa3Bojy4Rzzb7erhF1pKWOLc2gWF
         glBy4ncz5NbtHx4ZtQaaRGNAIjplOfv4TAVWuT/WHwmbb2Gl5phObqwM4OrZNu6b7Cug
         yP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789315034; x=1789919834;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xe1I5qbpgojxlxGpVRTMNTQbLO1llVPN8D1dRd7iMWQ=;
        b=PQTpa935qGHQSBqLFZlmHB8Ol/k3PN5mGpTdXlRR/TlUQcuxYjyIohCRHE0n5EvF2W
         KC7ZFIH//oh+segAi8HvUYLQYqP8XS53HfqFTSpfQlRzct4tPqtpf9g23hp79im8kbUp
         OleLoAe7SAT6a4SHmgHXLfHfmbrN/Xwfppd4SW7FDCMxQfN3Q6PR0/t4tINd8xPv1rQb
         XzXL0W/NDfz0IRs2QXPhVO3hyE6TCikBrEQT9ncM4u4BWQONvufif9ohkQVQ9pZoQqUp
         a+plW2jS6Nmpy4KrLFojZPFSN6RFC7UKypM9CvZhxYYdSY5g2x0yyXPfyIq2fgt3NCFX
         kEHg==
X-Gm-Message-State: AFuF++kwOCn/A6aejc0tHQTeqXkGvUXvQ0NB/gWW4rR4f7hJT9w9jYbl
	9FGpv+ITKyKmTWyfIxo9kNFAJmp+bX8MCLAWym1vJgfn+q8gGsklEB2Ih3R3cg==
X-Gm-Gg: AYBFou0CgGO3PK9QZhUK6VR9KQ5u60Polp+TO6oO5o/bUxEQXOI619mUk9sw/fqPXtc
	Q/90u4krGeB2yNQVfe6p6EvbpbBEhBt4gjyrwX+4RpiNLltN82ZpE74z9l2rZPsXYr/fydaXSWf
	S2WvsarahKCRSFIQSCG504bTTgvzOZz4iFMa1GLcYp+sdY0XHNNlWYlyPSK3EcA9NCGxkQFnFoF
	5heqqZzwnejIS4WtVjaEjgA8yiqRP3MkjvAKlHmjD0D/vFXsMGbBG2lf15iFRk6P1x8QbLoPHpP
	IDh7bXQIdE06v+xz43FEj2ZZbMLwmTzGK0dSyne/v27NW9Inay28Jpj9GPO85W2NZ7FNafkqbC8
	MnPF1mAp4zSLstFUp11JiOgKJlIH/isTa6zOcz7MwokbsP9K/r2PnfiNd+tmODaClHfcNLfINf7
	+SfOjluKTYihLF3GcxHq0mw6Hwls2Vo0wa8WPSCSlEGORE38jj7dFINfOrHGl6X0v1nZdJ57LCC
	fg=
X-Received: by 2002:a17:90b:5383:b0:390:8361:a532 with SMTP id 98e67ed59e1d1-39d9bc44d58mr27805413a91.7.1789315034354;
        Sun, 13 Sep 2026 08:57:14 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.225.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95091214sm16799656a91.3.2026.09.13.08.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 08:57:13 -0700 (PDT)
Message-Id: <pull.2213.v4.git.1789315032.gitgitgadget@gmail.com>
In-Reply-To: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
References: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 13 Sep 2026 15:57:10 +0000
Subject: [PATCH v4 0/2] Use Rust in the Windows CI jobs
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
Cc: Patrick Steinhardt <ps@pks.im>,
    James Le Cuirot <chewi@gentoo.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

With v2.55.0, Git requires Rust by default, with an opt-out that is intended
to be dropped in one of the next versions.

Due to the special circumstances in the Windows part of the CI builds, each
Windows build job first downloads a "minimal Git for Windows SDK" that
contains the GCC toolchain required to build and test Git. As a consequence,
brian m. carlson opted out of Rust in Git's CI definition in 32d5b905909e
(Enable Rust by default, 2026-04-09).

So: How could we stop opting out? Notably, Rust is not part of that minimal
Git for Windows SDK, and including it would more than double that payload,
which I consider prohibitive. Yet including Rust in the minimal Git for
Windows SDK is not actually necessary, at least not for the GitHub workflow:
The runners on which this workflow is defined to run come with Rust
pre-installed.

Granted, this Rust installation is configured to target the Windows-native C
compiler, Visual C. To accommodate for the Windows CI job building with GCC,
this patch series adds a step to the workflow that ensures that the needed
Rust bits are installed and configured.

GitLab peeps, I still would love to ask for your help: I haven't been able
to confirm that GitLab's Windows runners come with Rust preinstalled,
https://docs.gitlab.com/ci/runners/hosted_runners/windows/#available-runtimes
did not clarify that for me. Patrick (or anyone else with access to GitLab
CI), could you see whether this patch series builds on
saas-windows-medium-amd64 without need for further changes?

Changes since v3:

 * Now including the "Changes since v2"... (I thought I had edited the PR
   comment, but either I forgot to press the "Update comment" button, or I
   missed one of the many issues I had today with PR comments, caused by
   many a 500).
 * Removed the now-incorrect paragraph from the commit message that still
   talks about --target.
 * Sending my humblest apologies for such a quick succession (but I really
   think that v3 is ready for next).

Changes since v2:

 * Now using CARGO_BUILD_TARGET; Reworded the commit message accordingly.
 * Dropped the now-unnecessary --target option.

Changes since v1:

 * The inconsistency pointed out by Junio, that UCRT64 was once marked as
   using clang and once as using gcc was fixed by clarifying that UCRT64
   uses GCC.

Johannes Schindelin (2):
  rust: pick a GCC-compatible Cargo target under MSYS2/MinGW
  ci(windows): build with Rust

 .github/workflows/main.yml | 24 ++++++++++++++++++++++++
 Makefile                   |  2 +-
 ci/lib.sh                  |  3 ---
 config.mak.uname           | 25 ++++++++++++++++++++++++-
 4 files changed, 49 insertions(+), 5 deletions(-)


base-commit: f4742f3165d096130c39a71feb26374da37620f2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2213%2Fdscho%2Fuse-rust-in-windows-ci-builds-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2213/dscho/use-rust-in-windows-ci-builds-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2213

Range-diff vs v3:

 1:  b70b001f62 ! 1:  6e8648b21c rust: pick a GCC-compatible Cargo target under MSYS2/MinGW
     @@ Commit message
          not defined in Git for Windows' minimal SDK that Git uses in its CI
          runs.
      
     -    Note that this _still_ requires an explicit `--target` option to be
     -    picked up in the way Git's build process calls cargo.
     -
          Assisted-by: Claude Opus 4.7
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
 2:  76469029ff = 2:  f6c2f52fb3 ci(windows): build with Rust

-- 
gitgitgadget
