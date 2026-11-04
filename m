Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826941;
	b=oB9+UZk0LU+DbaISZeORZLqCc/qiVH4CSBKMA+lqZAqWLBotxR7aGrdhtra25zuZcJw1
	 H6JcHRH9PjXy3Oc01d7rtK7mgvpLN0Y/mqyXenan7lcUkjqKCqfBKPyVIv25+mpYZsOLz
	 7bvaK3mV3OkvJh0g9/OIasiXyKtAn50bXTjfnMQ0VVtYiACJs9pQ3eph+Q8TcEkL4/K7k
	 /CVkiZ5zUROcf0uQyHBqqICMe/+aKaRlrQCRH7k+KAGuGpgagAULhmJeZWcMed2h4mhnh
	 FMW5VZDzUcCMZW5+FfpK7mRlLhCASy1YkEcv5Lv/szFcE0UtcvSR4noLCcrleoFvUqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=I3JunHXGKdg7ckUOiIVhTcKPr3p1xzmdmyH8n3sXK+0=;
	b=A/NYfwnqO8Myj8CZYcrYGmtGQpEaRR81tXiu6zxAZoUkUegbHnLpWA0e5RaxFb1mHWZn
	 JdFNdovItEeptIgMMGbqyEiD7tMMRB6Kf3L+G55Atgy2VxvnGQ6I9QyZJRkDpa0nEE4+k
	 WLQWptQlIJjfW1UxFgYIkQ1LN/8rP9Tu+VE5pwBNLsToq51aVCD4VtsNDrMX5GeF8wgVn
	 IrqP5SUXAfiv7RufyjHaYLMERW9l6dx24uwQs5A1iPUtnrLdg63XaJ3zVe7h+ju1K5HFD
	 /qs1zGyWo89PJPPSSTsdrkTmsb3Z2N29C713F0ke7m6tkA7QkBm32WVGCwXFkqC6UuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wANgIu76;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4996073514
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 21:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B4996073514
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wANgIu76
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91e8a05ec5aso8533916d6.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 13:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826940; x=1794431740; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I3JunHXGKdg7ckUOiIVhTcKPr3p1xzmdmyH8n3sXK+0=;
        b=wANgIu76AwJL1kKhoilZuu5hBPw85ne63CcU3z6ucQgCccBXBHH5oz7uHvz6cSQzPi
         35v1bfB95Odk0Yl30hRUy0fx7sXUxfTbCrSJXnXnmeFgzB/5FLihofIB7f16A/G/JgV8
         sbvD5zRO5vT9FwnkMTVR+Ta9upzKndk5zOuc6aRbbRZvVh9IRHXW6E5+rnx3j7z6cWot
         1IPM5VYEb2wnKNJ/NVxtdGq/3Pt+ZVKXWOkwZNqEULYeSDH7LhfXUBZLuevUeHCpyEWO
         RIutsuXIHdKrw2pGYd/D+iQkd8PWHcupWAVBMUVKxPff8+bAbo/FgnZf1jP5iwyG+yKb
         wu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826940; x=1794431740;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I3JunHXGKdg7ckUOiIVhTcKPr3p1xzmdmyH8n3sXK+0=;
        b=wEwWLxoxzQVWKVYF5vyPOxjqObwaaee7tWJrSV8LuaGkqXgYVHpQnXqwZEro2cx/SJ
         WTVR39EOXCRhgVHb0HN47Bb6+27EagsMV2Tlq5X40HyPbcxODGqtWZrDf2G36BMVO9HQ
         yHxcDvDTAjL6jHX1k0u733+R+0KQ8E025J+HfK34GgkWX4zr00IF83ixFkruNtTpiB2Y
         ewlvZtxv/ufqG/K/aK1rBzo8tAEz7ySWv9ewSQK9PSC4YOhE1H4Kgg5FVisLQgdRlk7/
         aUhVhdzJRjUMwLVfDJQIgODEP6bXhTu5NBECc+7ryA5gelfpT6Uz47n7+ZSv+DNQRdcH
         Fvrg==
X-Gm-Message-State: APuU4Z9j1BCOIyUS0iLgqholpVzFN9VRsZaXgS9rU4/rFutf5d5nXJEE
	pH6sxLPhk2z7pUCiaon2IbnhO9HIekdXdi8ggYvY8haL5bK10WgIP+mrz1LkccUBgNM=
X-Gm-Gg: AYBFou2rbiU08KywEtGXK7Q0ybmaCWiz0uzNGYPhnSQEnhCmDxBgW2VzFmLvVgE7fdF
	wI0Gd7Gckvw8xpWGXUb/JhI0LRNaFIMSeIkeP+M5oqwmJZeZNpDP/1o7cx+SMPIKSvcB4F7mZEd
	ufimNJXHFnOES9ljuwHQtDwtrqzNqCZSweuO/K4RCX353kBfOJRxBzEjZIw7N5ECMg/qPSpq+vH
	p2Nopk5ANp5kKuuGsKRmFhwmBZ3LW2Q0CKHGc+d5tBvFFb1t876gw6Vg6jPyfc9M3Nziu2CszNy
	7X37uxvUy/zmZHJAzWBXUyzLy0hJ3KL1UUFIMaDWLGLHkaFhDyRAIFDP3GOEuwyelkKN+p7lNjF
	ryQmOlEXtiA7WAWJYTryaj2HCKTJaMOt2gQBFmqRfm48RKTrgypgucc57YPHTY0EVeFJlAaFUT7
	TQRrG1sNNPhe62iyHRH+PmrQ9VT2jFGpUfBpH379qLpMtqAZ3n+Qh/AdkF90OVsgr+kIWKl7GTQ
	PKbe/m/MA2Ct3TO1Gizc0ecQEVisTh5RTtWVBKemJVNlIvYR6M3Uh0AQT3NfMauf4u9HzSwecFg
	kaz9AGFfnH91fgOrfNrtkVp0ecQv3cfvEQ==
X-Received: by 2002:a05:6214:8588:20b0:91e:85d8:f3f7 with SMTP id 6a1803df08f44-91e85d902a1mr36795146d6.23.1793826940002;
        Wed, 04 Nov 2026 13:15:40 -0800 (PST)
Received: from [127.0.0.1] ([48.217.227.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e01a3f5sm28890846d6.30.2026.11.04.13.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:15:39 -0800 (PST)
Message-Id: <pull.2448.v4.git.git.1793826938.gitgitgadget@gmail.com>
In-Reply-To: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Nov 2026 21:15:36 +0000
Subject: [PATCH v4 0/2] reflog: add format %gb
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Create a better reflog. Follows the discussion in
https://lore.kernel.org/git/akZfm-igZKeHaDST@pks.im/.

The reflog of HEAD records the work done on every branch, so "git reflog"
mixes them and does not say which entry was made on which branch. This adds
a "%gb" placeholder that names the branch HEAD was on when each entry was
recorded:

$ git log -g --format='%h %gd: (%gb) %gs'
9c8d7e6 HEAD@{0}: (topic) rebase (finish): returning to refs/heads/topic
1a2b3c4 HEAD@{2}: (topic) rebase (start): checkout main
1a2b3c4 HEAD@{3}: (main) commit: fix typo


It follows branch switches, branch renames and rebases, including "git
rebase ", rebases of a detached HEAD and rebases of a branch that was
already up to date. When HEAD was detached, the entry shows "detached at ".

Changes in v4:

 * %gb now names the right branch when git rebase <upstream> <branch> runs
   with GIT_REFLOG_ACTION set.
 * Reworded the %gb commit message.

Changes in v3:

 * Dropped --operations.
 * Replaced --historical-branch with a %gb placeholder for --format, e.g.
   git log -g --format='%h %gd: (%gb) %gs'.
 * %gb names the right branch after git rebase <upstream> <branch>, a rebase
   of a detached HEAD and an up-to-date rebase.
 * Named the returning to and checkout reflog strings in reflog.h too.

Changes in v2:

 * Move the "historical branch" rightward in the display for cleaner
   alignment.
 * Improve commit messages.

Harald Nordgren (2):
  reflog: name the strings that mark switches, renames and rebase steps
  pretty: add %gb to name the branch of each reflog entry

 Documentation/pretty-formats.adoc |   3 +
 builtin/branch.c                  |   3 +-
 builtin/checkout.c                |   3 +-
 builtin/rebase.c                  |  19 ++--
 object-name.c                     |   3 +-
 pretty.c                          |   4 +
 reflog-walk.c                     | 167 ++++++++++++++++++++++++++++--
 reflog-walk.h                     |   2 +
 reflog.h                          |   8 ++
 sequencer.c                       |  13 +--
 t/t1414-reflog-walk.sh            | 137 ++++++++++++++++++++++++
 wt-status.c                       |   3 +-
 12 files changed, 340 insertions(+), 25 deletions(-)


base-commit: 750f5de7dfe9a4062f95088212b063f189d50e91
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2448%2FHaraldNordgren%2Freflog-operations-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2448/HaraldNordgren/reflog-operations-v4
Pull-Request: https://github.com/git/git/pull/2448

Range-diff vs v3:

 1:  4d779e8da3 = 1:  f960a24b8b reflog: name the strings that mark switches, renames and rebase steps
 2:  dee548f9b1 ! 2:  99a1047702 pretty: add %gb to name the branch of each reflog entry
     @@ Commit message
              1a2b3c4 HEAD@{3}: (main) commit: fix typo
              5d6e7f8 HEAD@{4}: (main) checkout: moving from topic to main
      
     -    The branch is read from the entries that branch switches, branch
     -    renames and rebases leave behind. The entries of a rebase are named
     -    after the branch being rebased. When HEAD was detached, the entry
     -    shows "detached at <commit>" with the commit HEAD was at when it
     -    moved on. When nothing older in the reflog says which branch a rebase
     -    started on, the rebase is taken to have started on the branch it
     -    rebased. For the reflog of any other ref, "%gb" is the name of that
     -    ref.
     +    The branch is read from the entries created by branch switches,
     +    branch renames and rebases. The entries of a rebase are labeled with
     +    the branch being rebased. When HEAD was detached, the entry shows
     +    "detached at <commit>" with the commit HEAD was at when it moved on.
     +    When nothing older in the reflog says which branch a rebase started
     +    on, the rebase is taken to have started on the branch it rebased. For
     +    the reflog of any other ref, "%gb" is the name of that ref.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ reflog-walk.c: static void complete_reflogs_clear(void *util, const char *str UN
      +	return p;
      +}
      +
     ++static const char *skip_rebase_checkout(const char *message)
     ++{
     ++	const char *p = strstr(message, " (");
     ++	const char *colon = strstr(message, ": ");
     ++
     ++	if (!colon || (p && p < colon) ||
     ++	    !skip_prefix(colon + 2, REFLOG_CHECKOUT, &p))
     ++		return NULL;
     ++	return p;
     ++}
     ++
      +struct branch_move {
      +	const char *from, *to;
      +	size_t from_len, to_len;
     @@ reflog-walk.c: static void complete_reflogs_clear(void *util, const char *str UN
      +		   skip_prefix(to, REFLOG_RETURNING_TO, &to)) {
      +		move->from = move->to = to;
      +		move->from_len = strcspn(to, "\n");
     -+	} else if (skip_prefix(message, "rebase: " REFLOG_CHECKOUT, &to)) {
     ++	} else if ((to = skip_rebase_checkout(message))) {
      +		move->to = to;
      +	} else if (!skip_rebase_step(message, REFLOG_STEP_START)) {
      +		return false;
     @@ t/t1414-reflog-walk.sh: test_expect_success 'walk prefers reflog to ref tip' '
      +	)
      +'
      +
     ++test_expect_success '%gb follows "git rebase <upstream> <branch>" with GIT_REFLOG_ACTION' '
     ++	(
     ++		cd branches &&
     ++		git switch main &&
     ++		GIT_REFLOG_ACTION="sync switch" git rebase main topic &&
     ++
     ++		cat >expect <<-\EOF &&
     ++		(topic) sync switch: checkout topic
     ++		(main) checkout: moving from topic to main
     ++		EOF
     ++		git log -g -2 --format="(%gb) %gs" >actual &&
     ++		test_cmp expect actual
     ++	)
     ++'
     ++
      +test_expect_success '%gb names a detached HEAD by the commit it was left at' '
      +	(
      +		cd branches &&

-- 
gitgitgadget
