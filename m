Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282942FE07C
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 11:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468509; cv=none; b=b8CWjN+1OjBPuiBoKPwwJO18ZqJElofJvCipD/BjZNhk/Ao/ydXD4+NaUqQsyHCaLmUSKGZV0Yg/+qEvZ96E6/HWTs9jFnUXBHMqItybiQgBHh4Ggj1IOj3KnfjwrfH0e/kOF03gvZvP1jXDWxeC8/S9YUP0mnZRI2adYA51xO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468509; c=relaxed/simple;
	bh=MhMzrtCCWSdP5KFcg3WORUIKMv7eTV5aQKzO78F9/wM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=B4g3DVpWENg6RjQzp1xtH7zOlH1STTMeJQbPypxwU7rmeOWj2nO9g1lgad7i81yvDwwA0fQJgYol5Rd+akOZVpSbIqS2ry1yOpuk9iHLWsTWPq4l33BdLSRntV80c5urRlnkwwu5FzFBYmbEj0GmzHkSTINlZ5uowDNDUa2T5bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYEgia37; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYEgia37"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3f30b2b2d46so1642605ab.0
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 04:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756468507; x=1757073307; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjRi0c9r85ULS0uygigYuj3iQVleVFMFyDyB7ykqogc=;
        b=hYEgia37cMBmty481oiJ2zRuSD+s8NHz0LuJID6a3qLzuQ7Tn5Wozh4A8D9fXXRYfl
         ys0NQy3G/r044d6s421KQYtjoCGH1geSafqzEzTBrS0TKnZ+F6BBxFlcWV6DSVZOxTZ4
         gMW7DRCfuFI50NBCBRAUrdGtSQXsjBEaoCRVm7EfTodtndu+TVMr5WznyidZfoYKcL0+
         uFaKyZdgOFt+emDBDj29JKtpFtPlDw5QPYLpUbEa+pEd3Bduqq8WAWTdqOMDi87AbMMc
         8lNcLheBAFufXcMTc8+dlZ4MPfC+uLezh+oVTDwMy1DpU8tlui3gv3joXAWLqNYN2nlf
         t5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756468507; x=1757073307;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjRi0c9r85ULS0uygigYuj3iQVleVFMFyDyB7ykqogc=;
        b=SwGDeLltp3A0AMMRYsnqt19Qbu83X+fDDzxyMltsJ2fwCimUjtcX2OIwaKIxr/YJaz
         bYUYziz8k4wcHSJAmFa36EzuBskNyTjUYvShOiOQ3+h9pwlj3TrX/qmTRErfq00GKGNH
         0ea3jTRIf6EcyLxVy6/S6fZAB5lI/6Dpe9wV7w9epfCEwJEO5L364GGoOcEwF/WHta3p
         Oeryb7JFXoICwZnHZaNnJ+xpNUOaswAjatZ865VDtYvE3HDrVyhdHhfRe87eQkkMPkw0
         OGWV70eT97PzTwXXS7i3Y3hLyWyEGc6Apu9SPWxHuqM2u2edQ6q4QBaAJQpaa7l3/MXn
         J0AA==
X-Gm-Message-State: AOJu0YwbaxeGeck+n7EPsFVGcDcRxLGPN1Sia5nrWZVyvzttKqZCc7zY
	94bbBdyAB2FcH7VdKrponARS1Wmtt7LFReiZL7cHq0qez6RhxnPihG+fsPpNdgDbOHo=
X-Gm-Gg: ASbGncsSQxzOR115jTpvrIgybzRu0z+TMEtYH6MOesgomH8KR4GzrPzzHtZ3gw/F6zg
	6guiqFAGH9GHSZQjDoJiWeS59meeXs/+ZcCHcTHM+q22HsK2Nsd+a6REw/83LhBfYTRPIr8q2Vu
	n+l64D79ouQk8jDOlWs/1RvnW1/7Gu8q2I45t5Ufns2XNjZoqZLUsDsnwzTxToBlt29Sf9NodOO
	BOwn004yG+R5iOiv8qBVwjp/ppujblN6U07dmO6IZhgNeOMbYcEuIlHwivw3laNsqqv56+Dx41M
	2nuNWY7A4+gP38hHeFLGu4CeyFQH0f6vyOVH0gn12pSJZ8pzZpTmLsVt6F1Paci+zXaOS/weEB3
	UqCGDxnZu/zyGVl+tjoi2C/EiE8I=
X-Google-Smtp-Source: AGHT+IE2r69elEFwIuxJuJTuoAzttKHZbja7h8qHtMNOHZpAmmYsaN/QGUjDzTbkadRhd98i8gYzng==
X-Received: by 2002:a05:6e02:2219:b0:3e5:8344:49ed with SMTP id e9e14a558f8ab-3ef08858a97mr171240825ab.1.1756468506812;
        Fri, 29 Aug 2025 04:55:06 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.177.182])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d7be01d84sm493707173.9.2025.08.29.04.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:55:06 -0700 (PDT)
Message-Id: <f57effdd2b44dd36dcae77d3c5b456b7d84c173b.1756468502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1952.v4.git.1756468502.gitgitgadget@gmail.com>
References: <pull.1952.v3.git.1755636370.gitgitgadget@gmail.com>
	<pull.1952.v4.git.1756468502.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 11:55:02 +0000
Subject: [PATCH v4 2/2] doc: git-add: simplify discussion of ignored files
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
Cc: Chris Torek <chris.torek@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
    rsbecker@nexbridge.com,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

- Mention the --force option earlier
- Remove the explanation of shell globbing vs git's internal glob
  system, since users are confused by it and there's a clearer
  discussion in the EXAMPLES section.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-add.adoc | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index ffe8fd701a..ad629c46c5 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -37,12 +37,10 @@ you must run `git add` again to add the new content to the index.
 The `git status` command can be used to obtain a summary of which
 files have changes that are staged for the next commit.
 
-The `git add` command will not add ignored files by default.  If any
-ignored files were explicitly specified on the command line, `git add`
-will fail with a list of ignored files.  Ignored files reached by
-directory recursion or filename globbing performed by Git (quote your
-globs before the shell) will be silently ignored.  The `git add` command can
-be used to add ignored files with the `-f` (force) option.
+The `git add` command will not add ignored files by default. You can
+use the `--force` option to add ignored files. If you specify the exact
+filename of an ignored file, `git add` will fail with a list of ignored
+files. Otherwise it will silently ignore the file.
 
 Please see linkgit:git-commit[1] for alternative ways to add content to a
 commit.
-- 
gitgitgadget
