Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67824A3841
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231616; cv=none; b=tXAZckxm8mAdj9bNTCYeawx9G1JU530gMS79Gc+qrYAC0ppUlcHU7Pboqp5ouTaKrqUSaSNKAOYmJ1hTJaYYql3GcstMv5kg/0Xvi1lGfn6jEEaMe1fn9WHmX+xlwrSONcpVQtScWD0pvXj37VxwMT6JkSl4MK7xtFVi0mtib6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231616; c=relaxed/simple;
	bh=h+g3/lusOd0I+6UJ1ik76hcZRPfrc8mZfYqIRC76srk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VNdKOQHdiL3gpx9c8gGVZD+/YdkGLgi0vMLuYcGnVhrL57Jv9UYb5haeY7IcQk+4wGIk+EYX+1LUhR8H4xpV94TW2rcZ3Km+xb3x+j1VC9kulpmyvUJ01yRbrQZPJrSvMtVY5iFUYloHVyDfLkBAzNa4wu3QmDojvkI7vi5TIuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0VQ8cc6; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0VQ8cc6"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1419d3416ceso3443350c88.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 13:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791231613; x=1791836413; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P7AQKDrqwEKegVIYuCSjsU31qlZ5yTrFhCuwtxWKEq4=;
        b=I0VQ8cc6TteObBdzezyv1Qoqb7g7JdkoRdCOyNGR+ZqaXHbN38A6YqEzr9a4SVxIzP
         h2SUlSxbRYrSJizuobe38JFKWeLdZjA24rWs9lt2oNGU7TcgaVWdlQiyBIdO9iIBVs+l
         RVgMBE9iWWlRJ+WtSeeZdW8yK7ZFSQGt/7KjWxczUyCPawozW8tCEgr/WOZrvkX86DBN
         e37OWsN0ynKTm0xO+ft3IAxO2BJiI5SYq5/7Gpx4X/pQCdXzEisIfL/4wV8j6oFI8oU1
         qucwQl6MNQxyLE2sdZaS4nfLuimWrCoISRuTo7QDdY6CnIrH4pNBrt/kZf3jBSrrdk/j
         jBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791231613; x=1791836413;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P7AQKDrqwEKegVIYuCSjsU31qlZ5yTrFhCuwtxWKEq4=;
        b=aMDu0TtwOR+7S12TQVuug/U3IJqBa7Odi+rbMrGM1spAmqMe4MFy3cae2wpZrxnSAk
         OZ9YXbQN6m6T4ysB7FgQawEAImYECm3+iNNp/ZlDgFc3OyFv3+s4dZbly3VqZlBbHROH
         0kZnmyWBd63RgEytSyRAhk2rq4/TyZIlexMN+l2ioGvGB8udbEGoSkmgfqbBqlnFGy+V
         GrEwooR0BWhUufl6dnBZ80MRnHdaj2e6XRbu9vVCL7/qfJjQcwFzBI25PEPfjsuund1N
         3iaj3NAafHCGe55eHYT1zqBfhnAx9bp2K1vTmdVpFhseWTkB9rinkhGzjEokmA34A1hy
         HZoA==
X-Gm-Message-State: AFuF++lm/zsClJQlyOcHngP9ZVHGgf5nEmgIrDbSI+TbIR16zWfmB1i+
	w0PHatraJJCp77Rvmh+4lolA4sY0zHuLmR3yak/bQmUK1Y4N4ILUORMc8/r0dw==
X-Gm-Gg: AYBFou3G/imvNrTQnkfC9LPF1qPfbGzT/FUx8drdK/FvMQjjbn3/zSETXMCQ+ev8cdN
	RKD6gDzGMTJy3PmPllVRrohFF+tEN7ouzX5M2E5U19HDailQbk8u9QpUkn+BaTcQOgIXB4AlqwJ
	XaCII/1Ay3XU62k+n1EllLFyho0V1dylZoLuDdm9gqYIDSPtAcx2e3POLLWv93pMRfJdMAlNnBN
	C5h/6dhIOtKD0yuqr9d2sRMa9ss35eQTQvElj5JNs1WrmIBo1r5sHXF6c+QA7zCJ6+tZo9kDGTB
	tkC930dlZpmx53rksitkLgb7Qv+oC0p64SAZvF4KLgeGO9Mx3iP8qzXhNurtEnsOCk4INFi4YNO
	A25MffpsCZKXbLvBZXkKyhDPZMDP4D2Xuj2NFlcC9NxSNViMvoItFfS/63Vg5xQTQRkmM9nfZvz
	QDIBZre0ZlLRpmcqDLGnk5yiEAIvKr/+LXl7A37ADskEH0M2uqo6G3YCh1iS1Fa3PE5ZdvsMA=
X-Received: by 2002:a05:7022:158a:b0:144:fb42:52 with SMTP id a92af1059eb24-151c36be9c1mr15193072c88.28.1791231612797;
        Mon, 05 Oct 2026 13:20:12 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.2.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35146aa465asm619140eec.20.2026.10.05.13.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:20:12 -0700 (PDT)
Message-Id: <pull.2241.v2.git.1791231610.gitgitgadget@gmail.com>
In-Reply-To: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 Oct 2026 20:20:08 +0000
Subject: [PATCH v2 0/2] [doc] Remove gittutorial-2
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
Cc: Tuomas Ahola <taahol@utu.fi>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>

This patch series removes gittutorial-2 and all references to it, leaving a
stub behind to help out any users who might be looking for this
documentation.

The goal is to remove obsolete documentation and make it easier to improve
our tutorial material in the future.

I tested that the docs are staying internally consistent by running git grep
tutorial-2 and making sure that the only remaining references are in the
Makefiles, the document itself, and some example output in user-manual.adoc
which isn't relevant to the actual manual.

Changes in v2:

 * Remove changes to .po files (thanks to Junio)
 * Reword commit messages to doc: ... (thanks to Tuomas)

To deal with the conflict with 4ce144a1 (which requires that all guides be
listed in command-list.txt) I think we need to add another exception to
lint-manpages.sh (like Tuomas said).

Julia Evans (2):
  doc: remove gittutorial-2
  doc: remove references to gittutorial-2

 Documentation/MyFirstObjectWalk.adoc |   2 +-
 Documentation/git.adoc               |   2 +-
 Documentation/gitcore-tutorial.adoc  |   1 -
 Documentation/gitcvs-migration.adoc  |   2 +-
 Documentation/gitglossary.adoc       |   1 -
 Documentation/gittutorial-2.adoc     | 422 +--------------------------
 Documentation/gittutorial.adoc       |  23 +-
 7 files changed, 14 insertions(+), 439 deletions(-)


base-commit: 0f8e75abebff0877cae681a3d5ff31ac47f54220
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2241%2Fjvns%2Fdelete-tutorial2-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2241/jvns/delete-tutorial2-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2241

Range-diff vs v1:

 1:  54404cd8df ! 1:  5fd36f91f0 [doc] Remove gittutorial-2
     @@ Metadata
      Author: Julia Evans <julia@jvns.ca>
      
       ## Commit message ##
     -    [doc] Remove gittutorial-2
     +    doc: remove gittutorial-2
      
          It hasn't been substantially updated for 20 years
          (see `git diff e31952da5c52a4c1:Documentation/tutorial-2.txt
 2:  a76819e3af ! 2:  68867aa3fc [doc] Remove references to gittutorial-2
     @@ Metadata
      Author: Julia Evans <julia@jvns.ca>
      
       ## Commit message ##
     -    [doc] Remove references to gittutorial-2
     +    doc: remove references to gittutorial-2
      
          Redirect folks to `gitdatamodel` instead, since every time it's
          referenced the intent is to explain objects, references, blobs, etc.
 3:  017ca1346d < -:  ---------- [doc] Delete translations of gittutorial-2 description

-- 
gitgitgadget
