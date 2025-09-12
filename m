Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49777334394
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703317; cv=none; b=HkOGmIauHl/hueI+TfLCYNrL5P8bNURxtgfg8Y4kEG3ZK5ZZXjgtdL8gnvPjSKzaiZ5uTdRKlU723KEuK5KTyfLFfOhD16S9XFa3Esb8LbnSm/md+dpRwwVEk1Zeex1pgw9ZytAxDlE4lkQYYOz3Dmy3e467/2k/5JhqEwX7lAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703317; c=relaxed/simple;
	bh=OwL8y7KB6CEPaGhsiO/UzRjWUYzxR3OyuFL7UNEiyuo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ohaqU2c/Vt5QM6Ch5Y1iQjZFZZ6c+O9+ePSMgUNpKoV0e2PGz9pUEPIN+z5NX4sBoERpFlFWGSHksriJFK7qsi2e2OxYGzgs4/yFCPeasCt0oncDZPTZRBW+0qzOOyQUM9c9ORirg+wQDnIedZB/3mpqVD84CHovXM9iP49pvr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVjPVv/2; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVjPVv/2"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-417661ecbb1so23593045ab.2
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 11:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757703314; x=1758308114; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5e6oBg5PcplAsJ6aIc0VUGvEbXcDy3kaxmmzeoT/Ew=;
        b=RVjPVv/2YqgSl2sXni0Ct6FeQI+Hmb910iFGFqL2eqx/5TsbryBjtgn/ZMWO/YC3nj
         L4ktTorZBg+fN0oTWRVrJ8c2c7WBevca3SBEYRZQaMZmBbYblR19rsruuG66cWN8kzVG
         nOfCP7fAurDngA3RgnaJKSYnbzGH8PsJAkFUzB31zKrTr09sej+bkWFS2lZHnxC8S4Rv
         3iwp2uMOO6p9VEtecT0iF0LYXcmDu8fk6iGh2pzIrw+DipNH7CMG8i0KC9FVEtFpuMqr
         O64mky6rYmdQ4wKSy84UHdbaehruY6KIS7lKEJVK7Q4poSIncBuynEeMMfifJ/muI8aj
         zIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757703314; x=1758308114;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5e6oBg5PcplAsJ6aIc0VUGvEbXcDy3kaxmmzeoT/Ew=;
        b=NGYwmSLdHMyQK5PbdfsFRI1zUG27/eMPVK+S6dNOkmL3eFT/TBgeaTlOFSY4UB0Yry
         Hgmjv7HYMqKM3x3mhfiTipSAd/H839r7SiYqEPIgnbvhAEVGbZsql70uGpli6ZWGYPYs
         UcG63VoAPsD3HFbWH22bBEVfrYRgz309D+MAdDEFpYufH7y42h7HQwcficSupUppUWpI
         Ju9ltsT38YFWtvpGUgwScHMBXp46mARCP/7bfFmXh40A2kMDnSTWOJqn67xYP7IxcrLo
         rCirYfJuo3zPa072QJMWxi17lDkR7qsza2RLhdX5mj3mpspi8ufM+TDJ9OFGme7ocx+c
         +0TQ==
X-Gm-Message-State: AOJu0YxijSDzip37TItW8Qd7yg/HePW4Lxfjxp66o4mHDRaDEgWiLQy3
	gGXkpeHF4OKmhymxb3EXUCKVRUvqqISeSEXU10LpK+xMDvu6DdPbvOXUmmMMDA==
X-Gm-Gg: ASbGnctEkpDUmewr0mS1gVq+CRDY6QWZHp8gITQv6gQ0sM4fP4aHpTSFbF59FZu/Cj3
	m4DPBULeWoGG0c17PDhL7W6evPKyrG6siDKLvrX7Y4vPITEGk6YC/Jhv4kNBqA5NHO1Ut42mF3B
	toDfWoaHKOnD+gktzHdYfL6HzxFXGyeTR7/J1cPCroQdOBMubsslC5UlEknub7w4yu4XYT3y5fb
	5fEEZufTWQ+vEmw4yvZch4j3u20crzF1F88l3YBfVEnHW+y/n1ESiQUf6qgc5dApgaZHu+xM24L
	qWMa2ZnwCPH7Hm8u2S+qqi7NSAs2dD3ZS91sA+JFBioccbSsarjO3TLLLGz35vwTYMLILEKZqKv
	md+ays9RajEL9UVZ+665iPQFZKvA=
X-Google-Smtp-Source: AGHT+IHzZLDi7a6dKn97HYG2aNclNp4FZX/4/a97yr555+4NQY5YdODTHmQRrmYnuaEIpJ4RYN3zVQ==
X-Received: by 2002:a05:6e02:b46:b0:41e:799a:819a with SMTP id e9e14a558f8ab-420a34001bdmr57591015ab.21.1757703313953;
        Fri, 12 Sep 2025 11:55:13 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.157.180])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511f3062bc3sm1962231173.47.2025.09.12.11.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 11:55:13 -0700 (PDT)
Message-Id: <0ec629d4037bf5d1ccc248ca1bbd87ccc08119a3.1757703309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
	<pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Sep 2025 18:55:07 +0000
Subject: [PATCH v2 2/4] doc: add an UPSTREAM BRANCHES section to
 pull/push/fetch
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback: one user mentioned that they don't know what the
term "upstream branch" means. As far as I can tell, the most complete
description is under the `--track` option in `git branch`. Upstreams
are an important concept in Git and the `git branch` man page is not an
obvious place for that information to live.

There's also a very terse description of "upstream branch" in the
glossary that's missing a lot of key information, like the fact that the
upstream is used by `git status` and `git pull`, as well as a
description in `git-config` in `branch.<name>.remote` which doesn't
explain the relationship to `git status` either.

Since the `git pull`, `git push`, and `git fetch` man pages already
include sections on REMOTES and the syntax for URLs, add a section on
UPSTREAM BRANCHES to `urls-remotes.adoc` and rename it to
`urls-remotes-upstreams.adoc`. That's an awkward name but at least it's
clear what's in the file.

In the new UPSTREAM BRANCHES section, cover the various ways that
upstreams branches are automatically set in Git, since users may
mistakenly think that their branch does not have an upstream branch if
they didn't explicitly set one.

A terminology note: Git uses two terms for this concept:

- "tracking" as in "the current branch is _tracking_ some remote"
  or the `--track` option to `git branch`
- "upstream" or "upstream branch", as in `git push --set-upstream`.
  This term is also used in the `git rebase` man page to refer to the
  first argument to `git rebase`, as well as in `git pull` to refer to
  the branch which is going to be merged into the current branch ("merge
  the upstream branch into the current branch")

Use "upstream branch" as a heading for this concept even though the term
"upstream branch" is not always used strictly in the sense of "the
tracking information for the current branch". "Upstream" is used much
more often than "tracking" in the Git docs to refer to this concept and
the goal is to help users understand the docs.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-fetch.adoc                  |  2 +-
 Documentation/git-pull.adoc                   |  2 +-
 Documentation/git-push.adoc                   |  2 +-
 ...motes.adoc => urls-remotes-upstreams.adoc} | 41 +++++++++++++++++--
 4 files changed, 41 insertions(+), 6 deletions(-)
 rename Documentation/{urls-remotes.adoc => urls-remotes-upstreams.adoc} (63%)

diff --git a/Documentation/git-fetch.adoc b/Documentation/git-fetch.adoc
index 16f5d9d69a..6402b3d69e 100644
--- a/Documentation/git-fetch.adoc
+++ b/Documentation/git-fetch.adoc
@@ -52,7 +52,7 @@ include::pull-fetch-param.adoc[]
 	Read refspecs, one per line, from stdin in addition to those provided
 	as arguments. The "tag <name>" format is not supported.
 
-include::urls-remotes.adoc[]
+include::urls-remotes-upstreams.adoc[]
 
 
 CONFIGURED REMOTE-TRACKING BRANCHES[[CRTB]]
diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index 3f4ecc4730..6cc329895d 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -140,7 +140,7 @@ include::fetch-options.adoc[]
 
 include::pull-fetch-param.adoc[]
 
-include::urls-remotes.adoc[]
+include::urls-remotes-upstreams.adoc[]
 
 include::merge-strategies.adoc[]
 
diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index e73b64f61f..ec396b4cf2 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -431,7 +431,7 @@ further recursion will occur. In this case, "only" is treated as "on-demand".
 --ipv6::
 	Use IPv6 addresses only, ignoring IPv4 addresses.
 
-include::urls-remotes.adoc[]
+include::urls-remotes-upstreams.adoc[]
 
 OUTPUT
 ------
diff --git a/Documentation/urls-remotes.adoc b/Documentation/urls-remotes-upstreams.adoc
similarity index 63%
rename from Documentation/urls-remotes.adoc
rename to Documentation/urls-remotes-upstreams.adoc
index 9b10151198..1e9c56dc5f 100644
--- a/Documentation/urls-remotes.adoc
+++ b/Documentation/urls-remotes-upstreams.adoc
@@ -91,6 +91,41 @@ git push uses:
 	HEAD:refs/heads/<head>
 ------------
 
-
-
-
+UPSTREAM BRANCHES[[UPSTREAM-BRANCHES]]
+--------------------------------------
+
+Branches in Git can optionally have an upstream remote branch.
+Git defaults to using the upstream branch for remote operations, for example:
+
+* It's the default for `git pull` or `git fetch` with no arguments
+* It's sometimes the default for `git push` with no arguments. See the
+  `push.default` section of linkgit:git-config[1] for the details.
+* `git status` and `git branch -v` will show the
+  relationship between the current branch and the upstream,
+  for example "Your branch is up to date with origin/main"
+
+The upstream is stored in `.git/config`, in the "remote" and "merge"
+fields. For example, if `main`'s upstream is `origin/main`:
+
+```
+[branch "main"]
+   remote = origin
+   merge = refs/heads/main
+```
+
+You can set an upstream branch explicitly with
+`git push --set-upstream <remote> <branch>` or `git branch --track`,
+but Git will often automatically set the upstream for you, for example:
+
+* When you clone a repository, Git will automatically set the upstream
+  for the default branch.
+* If you have the `push.autoSetupRemote` configuration option set,
+  `git push` will automatically set the upstream the first time you push
+  a branch.
+* Checking out a remote-tracking branch with `git checkout <branch>`
+  will automatically create a local branch with that name and set
+  the upstream to the remote branch.
+
+[NOTE]
+Upstream branches are sometimes referred to as "tracking information",
+as in "set the branch's tracking information".
-- 
gitgitgadget

