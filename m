Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5763028725E
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262321; cv=none; b=XSGK5ans4Tr+4TWz3OracFdpLpJORygN6LwPrRigzpbGWeSBYsiYltqzOI+1Lp+pTFE8/yIl+Qs7gkhDKsuylQFbjB6Z857x/UGhDElPMPatbLTH+SM8ov2J/imfx8onUhdZ1wYuk/Y5R6euzIbEMbmOHNe5ZXksAYWAHJVX8wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262321; c=relaxed/simple;
	bh=ds0nJ+gBBPaw7Wx2snz0avjhZaZxEPDMUVxNghUy4MU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Y27pdLo9eMQLRnEJSjku8BxyTxOjcTtvJa9jGW/KHBtu6hmSaK2ZFojKg7y1p+q/oi9B3dkxJ8srkIqXo9/INgequny+r6APeJNn/ruY+K2OcRsxria17aPH2JDak5+8QW/PfdCjA4WqhSPCPDvXVGSmzhvyWg/dfjVQlfnx6NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnFRL1SF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnFRL1SF"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-279e2554c8fso64938565ad.2
        for <git@vger.kernel.org>; Tue, 30 Sep 2025 12:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759262319; x=1759867119; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mA/T57MyYrvMUBdhSMYl4ImtAJpN1EibsFR4is+ulU=;
        b=gnFRL1SFCPVgfhnOUwbRznUk/vCrUkPzGYTER5lX6e2rM29oKWsQ/quBXOlwxI+Qbs
         IYtj9BETn0s4uzETwumgXej5le/BV3p6qIMVblhb4y4jgMvp6MQlvIosMOT2k1/bX0eF
         zKXoV014DA/o3u75ffQKqhHXXV9VB8FmFSkxatQ0RC7ziULqLUhCNSVzgZzSMF0+05cI
         ilPYDvIyvjYNl1xCqIzrO+1yuD3T2k13kvzmis0qXkJRkxMkFxotKuNfNv1nOSLJHuvV
         uxNX14wrh3gfqRlZd6ktZfO4galIuJiRqMhrS+7jul4eHAcFR+oX7jjLEBq8iWoQ9MVj
         YTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759262319; x=1759867119;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mA/T57MyYrvMUBdhSMYl4ImtAJpN1EibsFR4is+ulU=;
        b=JlAAhy4mzGEcu2W4g08j5qXjedIVvCvaJsGIOYqjdmBf7yyGChb4Ex7+3+vF14kNR+
         FubgPweHlEqkuOlCc7gxDyEq1rDjgxDqHD54KmR/yKW2z9iUd1WcFjsWjPdypf7MteX5
         b0xjxmpccchOVLXNAd81BCOcoX4eLQYtiQQjENbe8ULuCh61V0DCSBRn4zvKGIRaxgLH
         B5ax4Mvua14FzMG3caUqdroad56x0jW4N1Ck9Z4C9EYH3ONn15q6SfCPl9h1jYmQJeu6
         dgyOeay6aAzoqsq9eCBwoE2MWNrCPzyG67EBcPUQrpIyQv2XEfuWssxGy4Ggbva38bHi
         /TSQ==
X-Gm-Message-State: AOJu0YwAOgBS91LVoOPYyGIt+YmEP2xGeqrabEnPqan2VBMR7udJTiRl
	IwyAK6ENIopcDhM64jcPqdj5v6PzyxKGJKRZb2Z1gJPoazwion47dMJ0CHGkGw==
X-Gm-Gg: ASbGncsclxviVckI08r979CLWoLD44iBSeaOn25kVaKw+cGzd/LI8iH151I+XsR8+y9
	O/ivHbFlfmZzGdRjuYzJHhZVwPGQtFtv8xkmitSGzY2SV2b10PGlFT0frpn02dsp5FavCgnGaa9
	Ju9lqTx2aRxJ36zNM0nBWwJrbLkX/j2MdyV98+uZzoUbjmizQHqlpWnpCmB3bB+6XEdq+cxot18
	xQU/qNQNNHwIn4YkG2LRYBkzi7PUdQ0XlGBtS4Fv5bNXHGkDTE/doDcdHcqiUOLGBnXojyK1yya
	BxXapjlH0UWLPcItiULMLNelUgZtRBNe+Y5EcHMbBd1b6/64aO3CsMHRTTyVH5kce+wM5uE5esr
	yRy5lOVCki5/i9IWwT/1mj0bCAHhw9TlW5oOVq+8BNh1NCSRCtQ==
X-Google-Smtp-Source: AGHT+IHoMRiLsAUBL5n6/icyxzf4nlvWaIb+EtQPM89In87ENKf89gJ1Idp4AZ5vP2q61zJIltZ5JA==
X-Received: by 2002:a17:903:1b2c:b0:28c:2db3:b9ab with SMTP id d9443c01a7336-28e7f2a62bbmr11906675ad.26.1759262319047;
        Tue, 30 Sep 2025 12:58:39 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.210.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d3cafsm167989565ad.14.2025.09.30.12.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 12:58:38 -0700 (PDT)
Message-Id: <69825d46349e55dd1b17444ab4e6d542fd44f371.1759262314.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
References: <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
	<pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 30 Sep 2025 19:58:31 +0000
Subject: [PATCH v4 2/5] doc: add an UPSTREAM BRANCHES section to
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
UPSTREAM BRANCHES to `urls-remotes.adoc`.

In the new UPSTREAM BRANCHES section, cover the various ways that
upstreams branches are automatically set in Git, since users may
mistakenly think that their branch does not have an upstream branch if
they didn't explicitly set one.

A terminology note: Git uses two terms for this concept:

- "tracking" as in "the tracking information for the 'foo' branch"
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
 Documentation/urls-remotes.adoc | 43 +++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/urls-remotes.adoc b/Documentation/urls-remotes.adoc
index 9b10151198..dba5adeb58 100644
--- a/Documentation/urls-remotes.adoc
+++ b/Documentation/urls-remotes.adoc
@@ -92,5 +92,44 @@ git push uses:
 ------------
 
 
-
-
+UPSTREAM BRANCHES[[UPSTREAM-BRANCHES]]
+--------------------------------------
+
+Branches in Git can optionally have an upstream remote branch.
+Git defaults to using the upstream branch for remote operations, for example:
+
+* It's the default for `git pull` or `git fetch` with no arguments.
+* It's the default for `git push` with no arguments, with some exceptions.
+  For example, you can use the `branch.<name>.pushRemote` option to push
+  to a different remote than you pull from, and by default with
+  `push.default=simple` the upstream branch you configure must have
+  the same name.
+* Various commands, including `git checkout` and `git status`, will
+  show you how many commits have been added to your current branch and
+  the upstream since you forked from it, for example "Your branch and
+  'origin/main' have diverged, and have 2 and 3 different commits each
+  respectively".
+
+The upstream is stored in `.git/config`, in the "remote" and "merge"
+fields. For example, if `main`'s upstream is `origin/main`:
+
+	[branch "main"]
+	   remote = origin
+	   merge = refs/heads/main
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

