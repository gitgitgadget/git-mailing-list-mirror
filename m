Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E662D5922
	for <git@vger.kernel.org>; Mon, 11 May 2026 06:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482712; cv=none; b=nIfoAgWZKnigcBqCFgul68+f5A0Zhvn/hAKi2HzKAXESxAe9+nqwID+SQFMo+NsKZrC/hKo2O+TrkM1K4Dx+ImUJaKKxSnK0ccVCoCv1OGZT6JZxy6x88EXtipbUMH6GyKePWmVr5qWB16OeB43kSBGQzyGVZje1OlnK7V470AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482712; c=relaxed/simple;
	bh=gJkrVuNoXSkWnyi44HNBi1/GcNA3W2vxsMMMVNtcIg8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gAauJ7dpCcFLchC8dJojfeHWCei+ifzM5ASvwN4Uq9ZCTjqWYOOObPxofWAoMfNY6DURXhggUNNU2HgBjSZjxHwLmeM68peg+V1zh/BfyJxSfqmhPAPov4Ac80eZIAeZqOxFjjReINmwn3REL7Uf+K2Wslm5ICNRDwqmLqor3Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pWhfyOJ8; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWhfyOJ8"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8eea23d01f7so537121185a.0
        for <git@vger.kernel.org>; Sun, 10 May 2026 23:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778482710; x=1779087510; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3AUIe5E3QDPZyQnYP8gLuni3uyVEWE341EScxMSGqM=;
        b=pWhfyOJ8rTND8rfRHy+6o5FEG8jBPIJmO8tT1YQ8Cz8xSVyndxJG/49H+4FP3DguYi
         T7YzP5iWMC4oVllpm0dnWNMb6Glkupxfj1Nh88XwO6GLlDFo1KwnHPFrppG0IbhJ8GBv
         MUmk0j0pygMIe3gzivwHKjZxrpx+cvENbCzsP3nO5kPMBsTFWmwBxxtBuI4xehzIbdUb
         NLQKbKf7dJKc+hl83Gyc9WC60OSTKrmTA3DqOPFLVA/P/aI4kisbOggYmaopH7OsaA3y
         O3FaS2fuSuT9i3qJD+Ziy+9n00oRkOp8VwzKdNQw1S2XBvBYHlEgsNORJk5W6him5H85
         oQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778482710; x=1779087510;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I3AUIe5E3QDPZyQnYP8gLuni3uyVEWE341EScxMSGqM=;
        b=iUz1/3v8NdK60AZ1xHP1rLsNswPwPxfCf1q49fnpfA0m10CSyKbVJ+I8HawdoAFMhd
         WmuLaEg3Zhpvxmq00+oEA6+lY8oBcQG/nr//m6wptrbSP/bSw2gyX1geTo8crLEDZj//
         fZuUPSygPn5h9EgModH8cCt/nuVjc8R+/qpkVi16GZ6z2aSF2ql4971XnI8SGLBrIr84
         ee4HA6klfTkUy8sTnVwXBxPyiWw8q0UWLbFB7YzcFsF/ixuZesccTlV+D5SNdV1JRGDz
         jYcjIOHgmQ4hri7RgwDcCEj16JlNJJt/HdtW6YvrgRNT2ihw23cZqbqx9UkYBldTgn11
         3dkA==
X-Gm-Message-State: AOJu0YxuMFTuTNSev9G8IIiIRaSAVVq5DSpn52gNzwYOF0GnqdHVTCjb
	4RELFfggHrW7hlch2wFRmhyenenxbdMFPggXYDKkclN9InKeBV8jnDcozFWMtIuN
X-Gm-Gg: Acq92OENJKJ5hsBCXuXLELDTK/4l+HH9xv1zODzvL54pRBcE05X8Vx7m2NDJ96KOlX+
	IpFYr/6irkSfyJ/PjtomRX1y4gJghepit1VaGL5oMqlov+zQL6uBHNOfkhLGlbAEvtACt9WDQY5
	M6OvjpqvymGHreDPP0hLy4oXYpK+A0YR9VgeDx8V4PY/KFlXnJrKCKLgB9bsQkOkAZoNv2Hfq9j
	GfxUtl93mdw6On8rF9oy9TnIo6j/fo/g65jzGWjUjRMTdM++qpQmR6eJ3W9x4ODJHO3/h/nOFN2
	HU1kpBUSt3qGDK9eZQh/CFoFfdmFWl4GdpOxJ/MRZ4JELp1YCS/XEFP/08lXokvjPX9PFk6cg7g
	PjJ3qH9fuoMSV6OnYXXvJktVs0kNhHVQML7UegXroad2jSiTQ9Ps9GJVtUanj4SAPsiZja2bgWe
	X9GnGJ9e3qSoszuCjEOLlJdLgg98s=
X-Received: by 2002:a05:6214:4982:b0:8c0:1d4:4171 with SMTP id 6a1803df08f44-8c001d4430cmr158763406d6.19.1778482709850;
        Sun, 10 May 2026 23:58:29 -0700 (PDT)
Received: from [127.0.0.1] ([135.119.236.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3a71aaa5sm87093646d6.18.2026.05.10.23.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 23:58:29 -0700 (PDT)
Message-Id: <pull.2285.v5.git.git.1778482708.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v4.git.git.1778009038.gitgitgadget@gmail.com>
References: <pull.2285.v4.git.git.1778009038.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 06:58:23 +0000
Subject: [PATCH v5 0/5] branch: prune-merged
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Harald Nordgren <haraldnordgren@gmail.com>

Drop commit 'fetch: add --prune-merged'

Harald Nordgren (5):
  branch: add --forked <remote>
  branch: let delete_branches warn instead of error on bulk refusal
  branch: add --prune-merged <remote>
  branch: add branch.<name>.pruneMerged opt-out
  branch: add --all-remotes flag

 Documentation/config/branch.adoc |   7 +
 Documentation/git-branch.adoc    |  32 ++++
 builtin/branch.c                 | 289 +++++++++++++++++++++++++++++--
 t/t3200-branch.sh                | 247 ++++++++++++++++++++++++++
 4 files changed, 564 insertions(+), 11 deletions(-)


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v5
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v4:

 1:  77e67d4b8b = 1:  77e67d4b8b branch: add --forked <remote>
 2:  807c9f981f = 2:  807c9f981f branch: let delete_branches warn instead of error on bulk refusal
 3:  77beb620d7 = 3:  77beb620d7 branch: add --prune-merged <remote>
 4:  98cfdb87d2 < -:  ---------- fetch: add --prune-merged
 5:  c645526bb5 ! 4:  cf69fb5767 branch: add branch.<name>.pruneMerged opt-out
     @@ Documentation/config/branch.adoc: for details).
      +
      +`branch.<name>.pruneMerged`::
      +	If set to `false`, branch _<name>_ is exempt from
     -+	`git branch --prune-merged` (and `git fetch --prune-merged`).
     ++	`git branch --prune-merged`.
      +	Useful for topic branches you intend to develop further after
      +	an initial round has been merged upstream. Defaults to true.
      +	Explicit deletion via `git branch -d` is unaffected.
 6:  690242d89b = 5:  f2cee8c79b branch: add --all-remotes flag

-- 
gitgitgadget
