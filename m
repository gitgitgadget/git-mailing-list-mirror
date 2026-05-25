Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AA23537FB
	for <git@vger.kernel.org>; Mon, 25 May 2026 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779704912; cv=none; b=ELtE65+3oyVGwjQ1yGn838haiDFuvLFvp6bRFQOJmNjaeO55Xpeyt8We/9BK5OnHZOszxsSG+m6Jiwkvc58j8G9QHjWJcYyTrrcVRBaKMZjxTsYBhL7SUDiAmKMepBdznP0X+169u2eLlMCCOsFqS6UHk05jhqi7rutkR4xRO4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779704912; c=relaxed/simple;
	bh=Bv2d9kn503yhSJa5vNnVaEPNtcPjVQlnkeVHXgRQdk8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=TbEDIW426jRCiP9jyjpYOtDwM+rWuULURaeokwjxe38HeNdnL83GSuSCvP7xL2ae6f4QqHkT9mjkXQEkigFFMF6ppSCVg+5Yhu7a8w3C9/ZAR8rivmkpwhtjTbZcj2LopeF/K8EKRYJa5ZEeV3yLR7S3JuMS2z+I9eWr0vA9Ud0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1yh385J; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1yh385J"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8b74b460d77so130137396d6.3
        for <git@vger.kernel.org>; Mon, 25 May 2026 03:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779704910; x=1780309710; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnpPODLwWj0Mx12OfcKN9RaADNBKaGd/MkTRuRuqfmM=;
        b=C1yh385JZVmSQTDyPs5O/qUr3k1upnE6R5rla3cr6KtVtqPvh3X67jqP69Ht1fYJfb
         gTxgIV/RAL6E7MeEwUmXvPwcPU95n4nTjItEXG9arCOgBTSccIuKnqXsdGzRmHTe4ZTM
         fVj+Wbk5jxxVM5dH1WlB4w5YHgjG6tLhVXINHL+642OdJn0T+7e8nuj2fhulDnd0fcLB
         OPe1pm2yq/I2EIfZeaZwYCZN7/pUznWiy4GQmx3JSppznS4kLunN5Yr0Ou/DuOfDXbvy
         qFeUZiIh+14s+InWVVUIDPqcYLhH8qo4nRXOkm2mYPS18JM7ljW3xUopgqfQOZ9x/l3f
         POYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779704910; x=1780309710;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EnpPODLwWj0Mx12OfcKN9RaADNBKaGd/MkTRuRuqfmM=;
        b=mdTjiyxAAapCwrTd5jCf0HftJkmFAYcI+NNIql4OlPTsInHS9Qz0gtdvuNxUG7f2Tv
         dqfXdS5vnZVKIXB+RZ3DjgSZvPJwStHOd6Jy1r5YAr9aDdWPhLKyfCVj7ufReQmt7Xx8
         Wops6MNFpAaA1/bx0apFNTJXi+vbCy9ldTnIIXh20S/AUSk29GF4GKk6rOOV+4UZaFmJ
         aPujsruvU8JW0jMwlNnlsqR7wXOVy+OY/JT4leWhwNM2ci9/VsLsPljK+3bZieQUNeUs
         TUkC3j6BXYjGYUFhObf1zjNCtHbI8ICyrYUiSAvWbH2c4I7nXjONYsMx3VUf2oFc56yp
         C/yA==
X-Gm-Message-State: AOJu0YzzgzUPN3Ajc4TxqF5OT0i4tyus9dXbJLelvEKs2CTtyvBvee9l
	AF1A2V0gV0OhiucmHvfIpEy2KZZaCEHqSOv5nQ26vzGUqqmqr95rCiF98tbMC8hl
X-Gm-Gg: Acq92OFvJCB0N6c8EKScVb1d05Kl5Z8Q4ViTa8MFf9bWL3PtGGkePYphUOIfgoGr2wE
	pKqnM0ZpgygwsvC7cUkZ5v+YaK3NJMHKUnJPZd7/mCN77RcVK35NsjUkS1gDOr0w/ACEcIrXmZ4
	kNgTw8O8vLdJ9u4oAkc+3369f0bmDkUDoxE5RLBq4+HyFafmynJIYNuhXAV67LIM1ZcxSeqoPTV
	4O9/0Ko+DX2qmImwFb7JmEdASfrdhJ6zRRDZcYXGaY8knr9OkoSVfemWnndLEs/a1ffNYXcDegl
	cwkQItpCaF7h9uPo+ynOD9Jj/YYJC/uuhXa0oKN3ztxhe0Vdj0r4VB+/02SS6WT80k+EkCtzliD
	M48xedJdhyqo2myDplGlIvQyz8vMeBbcCL70jiqNGxYjnHrILj74MIX+CR/qy+/ylzk1rWE/wk4
	fElMESQFOg5uW4CnYXNj1iMzQQ+w==
X-Received: by 2002:a05:622a:a18:b0:516:dd5d:4f3b with SMTP id d75a77b69052e-516dd5d53e1mr157261031cf.8.1779704909897;
        Mon, 25 May 2026 03:28:29 -0700 (PDT)
Received: from [127.0.0.1] ([130.131.15.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b0065asm88149361cf.2.2026.05.25.03.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:28:29 -0700 (PDT)
Message-Id: <pull.2117.v2.git.1779704908.gitgitgadget@gmail.com>
In-Reply-To: <pull.2117.git.1779049615.gitgitgadget@gmail.com>
References: <pull.2117.git.1779049615.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 10:28:21 +0000
Subject: [PATCH v2 0/6] doc: convert another batch of files to synopsis style
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

This time, 5 new conversions:

 * git-bisect
 * git-grep
 * git-am
 * git-apply
 * git-imap-send

This batch was an opportunity to test AI-helped conversion.

Changes since v1:

 * clarify the use of synopsis vs code block in git-bisect, which also
   include using '$'

Jean-Noël Avila (6):
  doc: convert git-bisect to synopsis style
  doc: git bisect: clarify the usage of the synopsis vs actual command
  doc: convert git-grep synopsis and options to new style
  doc: convert git-am synopsis and options to new style
  doc: convert git-apply synopsis and options to new style
  doc: convert git-imap-send synopsis and options to new style

 Documentation/asciidoc.conf.in                |   6 +
 Documentation/config/am.adoc                  |   6 +-
 Documentation/config/apply.adoc               |  17 +-
 Documentation/config/grep.adoc                |  36 ++--
 Documentation/config/imap.adoc                |  30 +--
 Documentation/format-patch-caveats.adoc       |   2 +-
 .../format-patch-end-of-commit-message.adoc   |   4 +-
 Documentation/git-am.adoc                     | 132 ++++++------
 Documentation/git-apply.adoc                  | 125 +++++------
 Documentation/git-bisect.adoc                 | 109 +++++-----
 Documentation/git-grep.adoc                   | 196 +++++++++---------
 Documentation/git-imap-send.adoc              |  24 +--
 12 files changed, 346 insertions(+), 341 deletions(-)


base-commit: 56a4f3c3a221adf1df9b39da69b8a6890f803157
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2117%2Fjnavila%2Fbisect-synopsis-style-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2117/jnavila/bisect-synopsis-style-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2117

Range-diff vs v1:

 1:  dca7f192f1 ! 1:  7284281fe0 doc: convert git-bisect to synopsis style
     @@ Documentation/git-bisect.adoc: that, as it cleans up the old bisection state.)
       With an optional argument, you can return to a different commit
       instead:
       
     +-------------------------------------------------
      +[synopsis]
     - ------------------------------------------------
       $ git bisect reset <commit>
     - ------------------------------------------------
     +-------------------------------------------------
     + 
     + For example, `git bisect reset bisect/bad` will check out the first
     + bad revision, while `git bisect reset HEAD` will leave you on the
      @@ Documentation/git-bisect.adoc: To use "old" and "new" instead of "good" and bad, you must run `git
       bisect start` without commits as argument and then run the following
       commands to add the commits:
       
     +-------------------------------------------------
      +[synopsis]
     - ------------------------------------------------
       git bisect old [<rev>]
     - ------------------------------------------------
     +-------------------------------------------------
       
       to indicate that a commit was before the sought change, or
       
     +-------------------------------------------------
      +[synopsis]
     - ------------------------------------------------
       git bisect new [<rev>...]
     - ------------------------------------------------
     -@@ Documentation/git-bisect.adoc: to indicate that it was after.
     +-------------------------------------------------
     + 
     + to indicate that it was after.
       
       To get a reminder of the currently used terms, use
       
     +-------------------------------------------------
      +[synopsis]
     - ------------------------------------------------
       git bisect terms
     - ------------------------------------------------
     +-------------------------------------------------
     + 
     + You can get just the old term with `git bisect terms --term-old`
     + or `git bisect terms --term-good`; `git bisect terms --term-new`
      @@ Documentation/git-bisect.adoc: If you would like to use your own terms instead of "bad"/"good" or
       subcommands like `reset`, `start`, ...) by starting the
       bisection using
       
     +-------------------------------------------------
      +[synopsis]
     - ------------------------------------------------
       git bisect start --term-old <term-old> --term-new <term-new>
     - ------------------------------------------------
     +-------------------------------------------------
     + 
     + For example, if you are looking for a commit that introduced a
     + performance regression, you might use
      @@ Documentation/git-bisect.adoc: of `git bisect good` and `git bisect bad` to mark commits.
       Bisect visualize/view
       ~~~~~~~~~~~~~~~~~~~~~
 -:  ---------- > 2:  4fb33dd440 doc: git bisect: clarify the usage of the synopsis vs actual command
 2:  1b4efce1b2 = 3:  fceaf195e8 doc: convert git-grep synopsis and options to new style
 3:  4ab60a95f4 = 4:  b9c2adfa1d doc: convert git-am synopsis and options to new style
 4:  437e3f99c7 = 5:  60a420ea38 doc: convert git-apply synopsis and options to new style
 5:  dbe4d20b4b = 6:  d88824bf09 doc: convert git-imap-send synopsis and options to new style

-- 
gitgitgadget
