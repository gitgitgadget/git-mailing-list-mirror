Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F323E0083
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903095; cv=none; b=mqbstDKZ/zBWaVvRjhMZ1rI+S4tRyRs/fXJPpMdIFvY5uYKBlF0yUzun8CPZpeU793Keq8KpfRDr+Htl2zbyNnqANuB64OsOcOqUSEIgS3b7jzioCMMG+53l99lZ++G5ikzE6GzlB5Yx2zDgnFRpnQTovn9tEazYuK+BbbMmMms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903095; c=relaxed/simple;
	bh=rJrgAbd10CHpFo+nSNBBg2L4Bw0ph79UcB0MSHe2QV8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=man0owfdlNKevNXoRzIjZFhbKRBKZ/GfCKGdoirXXKZC9fAFxVJl3Wj3h17tYpEvtujOEdBy4BvEolHBtuVj1f5JhoP1OioSGDatpfwlM1J/l0RSKmuCdRji7VJFxLxRL3aI7of/wyT65sM9HFZqR3Dyj81CW19meEPdgu/flUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps/ihjDM; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps/ihjDM"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-46556b9e02cso648479fac.1
        for <git@vger.kernel.org>; Fri, 28 Aug 2026 00:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787903092; x=1788507892; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p50Tr/uHmYjs7XETcmH/uTMlBsXyUasKDIjTUKhfg4I=;
        b=Ps/ihjDMy8WVok1/sIER1ofEhFfI/7Wr+HeOISzFhBwt33XX2wPjoJn1YyuaAN4EKE
         iwn2Pa5N4Nyq3+qi/4X/8hS6mjVAcB9R6s0HZaPSt9whXoCsmIVHbfNop9e1i6FFhfIb
         7yeO6G97X30P+7TzihUiq64eSeSnwKx8F+XnHq8WGC3K8HzAOFIIrkIbHkzWgSgrCKtV
         ThcrBPl4EZnUjPC6ozBC1/JOMnoYoCNCUgSikWfRN/JYd8TnIhNs2ZO9iwbziKavDb0P
         4cO6y2/ERlq9/1GSGawspt28XZuDuo7G9sLsEvSyKPmJkvq+4Bg+n5xDkkkcSfpjnaVW
         WX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787903092; x=1788507892;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p50Tr/uHmYjs7XETcmH/uTMlBsXyUasKDIjTUKhfg4I=;
        b=S8pPXhbiMbFvOMOQZmpZ9chHJbByXp9FMe1NdOjp2/naPir+kGY3BDsN9iuLBtn+9O
         uN9fJ8Iv6lFkB+81duj6rh9+Iuc6rC4/kULLB2tWQN8FdLm35gEli0aLAoaVC9y6StzL
         t9jNMSTO41S2E7wHFWaXsZeS7jJNh6s738TQ2PfHiqz5s4QU3POiEPRljrxjINhqPmjW
         6WhBgjsmc6V4joWz1RbxAXwEL6qdP8WKy/NvLmuSkAKsqBj+OOPPhklhK3eEWqmDxh5t
         Tu74XOk5bn3koF4yTYEMK6gSekHEBIt2Aj8PLZvmPcAvG7k9RfTjFolb1m5QwNaTYh/b
         tcOw==
X-Gm-Message-State: AFuF++lrhS6EDq9MhvGomVj/DnXcI8S+bk6C40MlOG66JKcKuHa0rn59
	HE++2mr4zT2xwUaeH5ISJIAKHbGzPXqYVfuM5r9eeRBeDcykzNmSdV+NMIfgULaF
X-Gm-Gg: AR+sD12KFQW3+UZaGDYQ32tTQOhTjdxVbx/t+uWJIaar7Bv9IYipNRkmavh8nkU0Nbt
	EmIt0aPHY8YRw1HP5AQ88FIn3pVO76SYnApjbDjL8Gi3aJ8nPEIHMc5AytzSllQT0tL06PjWgWy
	4g7/KTwCc9WG3HDFN3AiQxcbqCCPGj5UEQPzYv+PW7yakXn+XyMyx0Axf0j/jMnrfuL+LFEsjfj
	MIeE8AKXoWUGTja1bX/jFP0MJ0UP14kyC8m+WqmCM9vPWmlWjg4/E74MyE/nIO6Sf9mmNrxwm5P
	iSubdNSTPS/tvZsSan2NpBiogmwOn57x7+ETzOpbn9doZKwOhU0PzHLxmbgm6xYF8mZd1ftURia
	keyk8D1n3npDIUYp6jVCqKRz6R7qriyVkEJ+gKegqLFraeqjoBR9X2JWKaTrc6ZKcUAX6q+fBgQ
	FFBwmsudlHvigVSt+9wA0qMRRYrcBKGy2B5A0yZJRlh8h7LnPBjuCallJGR11sDdY=
X-Received: by 2002:a05:6870:a0a6:b0:448:6ba8:539f with SMTP id 586e51a60fabf-4682ec5e867mr4771039fac.6.1787903092465;
        Fri, 28 Aug 2026 00:44:52 -0700 (PDT)
Received: from [127.0.0.1] ([172.202.78.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-468a543ae75sm758996fac.13.2026.08.28.00.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 00:44:52 -0700 (PDT)
Message-Id: <e16930361978335a6718814cf5d56a8dd8b42f75.1787903085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2389.v3.git.git.1787903085.gitgitgadget@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
	<pull.2389.v3.git.git.1787903085.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Aug 2026 07:44:42 +0000
Subject: [PATCH v3 2/5] commit: allow a partial commit when a rebase pick
 becomes empty
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

For years, we disallowed partial commits during merges or cherry-picks.
In commit 430b75f7209c (commit: give correct advice for empty commit
during a rebase, 2019-12-06) it was noted that the "cannot do a partial
commit during a cherry-pick" message was also printed when rebasing a
commit that became empty, and rather than drop the check in that case,
that commit opted to make the message print the actual operation that
was in progress.

Since a commit that has become empty comes without conflicts, a new
partial commit poses no problems; remove the error in that case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/commit.c              | 2 --
 t/t3404-rebase-interactive.sh | 5 ++---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 569e31fb60..610820c99f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -520,8 +520,6 @@ static const char *prepare_index(const char **argv, const char *prefix,
 			die(_("cannot do a partial commit during a merge."));
 		else if (is_from_cherry_pick(whence))
 			die(_("cannot do a partial commit during a cherry-pick."));
-		else if (is_from_rebase_empty(whence))
-			die(_("cannot do a partial commit during a rebase."));
 	}
 
 	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ff11abb2f2..3588e16543 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1858,7 +1858,7 @@ test_expect_success 'post-commit hook is called' '
 	test_cmp expect actual
 '
 
-test_expect_success 'correct error message for partial commit after empty pick' '
+test_expect_success 'partial commit is allowed when a rebase pick becomes empty' '
 	test_when_finished "git rebase --abort" &&
 	(
 		set_fake_editor &&
@@ -1867,8 +1867,7 @@ test_expect_success 'correct error message for partial commit after empty pick'
 		test_must_fail git rebase -i A D
 	) &&
 	echo x >file1 &&
-	test_must_fail git commit file1 2>err &&
-	test_grep "cannot do a partial commit during a rebase." err
+	git commit file1
 '
 
 test_expect_success 'correct error message for commit --amend after empty pick' '
-- 
gitgitgadget

