Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582922BD5A8
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756240830; cv=none; b=jNfpFu0veKcn9Qsk6xPSGBQPfIcWSGoWeHkiVzzfYhK/QkrKkx3XXtR8yTdeLj+pYE98wLO3/EmxXs8zdJ3jel7FzyjJ4X8ufZXnt//9sz7nL5l3tTTih9n7CapufDHqElMCmBnzqRTSHngMjz4xMkkAYESarjBvHNpQsfmcT64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756240830; c=relaxed/simple;
	bh=YL3UG934QFRRF+Ypzik7AQa7Ardb0v8twhMcCkQBzmk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=enHjYE3vZU5EpVoj5U1Oo4uGwWN5jJVdvul8YhqyU4vayR3tCQsoe34BsDfZQXEePISWCetgk9RnFgEFVcS4cxq0XSZ3rRbD7tPF2yWLytTzwfiRWj5LX9fw9e9n6s1zZR9pt7Wmu+4k3z3EXAuWYGz8qwkk+AEXhhTSOEjXLRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zn+qmSxN; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zn+qmSxN"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3c6ae25978bso3014162f8f.0
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 13:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756240826; x=1756845626; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRlyke9qHpCa0OsNCLtsa90k9bn9pqCQLZtT4Efv8DA=;
        b=Zn+qmSxNsOhoZaUUGaOMnhEZ/NXodSvOTO7li7JGVSIse7yLC2Pp2hzZZ+HSg0FfyX
         VO2zrSoNjInwHgaCZc3jfKjvrr42Lw+LaNZ/pUXbqKx15M9cac3+4fNt9Kj5zkeC7meX
         4+0pZcaYT28LAiNwvDWx8Ny0pKp8Z2T8QNXhYfO0Bf+fzONSsd9VwGxEnB4ASoey0QYq
         0VauFSWXFjRtfS6LYOUQnOVNpkQxQK0xvmC7ceMnqfCXnEAbiKWI1zh346ZiXhQ4DuvJ
         ZsPdEC4g963brDyzBIUjJQ3iV4piNAjhq64P9NxbuO0zwhXnl6amtObqq85xa65w1dDn
         RlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756240826; x=1756845626;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRlyke9qHpCa0OsNCLtsa90k9bn9pqCQLZtT4Efv8DA=;
        b=DLML/4gft7qMBmIMN67xuBXe3VejPw/1phXTAEAP5qskU78VWUVU7/CLJvAf1xGhcZ
         GJK7JXxrStGslSMLx3O9x5pUkBtFcR8HuHETxpUK4O7+ZYH6/geZ15iCopK6RXBXfbjj
         6FYejEjYiTNfUSZE+WLu2wfYs2cOufA/vyKsVNtcJv7mrO2KdYNAvtd01sB7vj96m2DK
         JG1Brxeops8owEakzCyb+grmhwDE5ecsV1CsqTGuad/nUa5xk+rbmxLhW9/c2L68ZKwp
         USR9eh+Ya4Ink2LeQkrerjbS+k774gGb3Z8iGRHIVOy/DPlwxlIzIoOHxHq3XJovNbcR
         LRVw==
X-Gm-Message-State: AOJu0YwrKvOFtXvI2Ui66FlbOTsD8C3/qJt2/pTp9XhFbdES2A54956c
	HrDilMcCX6AByW7E++LhvgF3T6Ewp6fwdIfo61ODKsbjkURloOMJs5ZZpRtIDQ==
X-Gm-Gg: ASbGncuQprSYQLcAOz6/dHKeNrfFeN4XsyIuCtle1iHopSg+sLPNassFVtPPzU2zBEC
	6ZVuWfQiUtw1vgs/qrJteS9R8pUZ+yg5MGYHMKaBEQI6uesRp+M1/CF6neFfBnyZe9lddEtUqK4
	t8vp3izZa8+ZdppCkzwFYJLW3rBtetkreKTm4Ltid7pwGK8iFUy5W6Sti7psGlWMHnu7SaJVrqT
	EDjfhGbKrwr2/tA6u/QaAWzImprm2KqjSCv0lFYKjGfaXUc5NWM/S29FGNoBuKNwSxxDh284Qbu
	mXHvIloKOB69U6WkxY2P20M0M6R+idbB7OYfXz8jcfTUKeCi/QEwUiTMEpEyNYMFfAqRWKDyvmZ
	DIxs8bhEqVgnoJBMcf/JXk53hrp4VGlEV4JsiFA==
X-Google-Smtp-Source: AGHT+IFzv+wfH9TaNHEu/rr7pD2Zk1mQp7BquJ5rOBmAQ7tW/+toNDAQX8Gc5lnQHLPoXxBZ9dFh3g==
X-Received: by 2002:a05:6000:2910:b0:3c8:46b4:2275 with SMTP id ffacd0b85a97d-3c846b4258fmr8927796f8f.27.1756240826106;
        Tue, 26 Aug 2025 13:40:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66a64023sm23038415e9.1.2025.08.26.13.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 13:40:25 -0700 (PDT)
Message-Id: <ac554cbe75444880bbb2791c4d85dcf083d833d7.1756240823.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 Aug 2025 20:40:21 +0000
Subject: [PATCH 3/4] doc: git-push: clarify "what to push"
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

- Be more explicit about what we're describing ("which branches" instead
  of "what to push")
- Split out the ways to specify which branches into a numbered list,
  since there are 5 different ways to specify it and it's a lot to parse
  in paragraph form
- The explanation of "push.default=simple" is confusing to some users,
  use an explanation more similar to the one in `man git-config`
- Mention the most common case where push.default=simple is likely to
  fail, and how to handle it

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-push.adoc | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index 5c934486c33d..0232195515c9 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -27,18 +27,21 @@ argument (for example `git push dev`), then if that's not specified the
 `branch.*.remote` configuration for the current branch, and then defaults
 to `origin`.
 
-When the command line does not specify what to push with `<refspec>...`
-arguments or `--all`, `--mirror`, `--tags` options, the command finds
-the default `<refspec>` by consulting `remote.*.push` configuration,
-and if it is not found, honors `push.default` configuration to decide
-what to push (See linkgit:git-config[1] for the meaning of `push.default`).
+To decide which branches, tags, or other refs to push, Git uses
+(in order of precedence):
+
+1. The <refspec> argument(s) (for example `main` in `git push origin main`)
+   or the `--all`, `--mirror`, or `--tags` options
+2. The `remote.*.push` configuration for the current branch
+3. The `push.default` configuration (See linkgit:git-config[1] for
+   the meaning of `push.default`).
 
 When neither the command-line nor the configuration specifies what to
-push, the default behavior is used, which corresponds to the `simple`
-value for `push.default`: the current branch is pushed to the
-corresponding upstream branch, but as a safety measure, the push is
-aborted if the upstream branch does not have the same name as the
-local one.
+push, the current branch is pushed to the branch with the same name
+on the remote. The current branch must have a configured upstream with
+the same name, so this will fail when pushing a new branch.
+You can run `git push -u <repository> <current-branch>`
+to configure the upstream.
 
 You can make interesting things happen to a repository
 every time you push into it, by setting up 'hooks' there.  See
-- 
gitgitgadget

