Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF98366052
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214330; cv=none; b=uhoNkw7oUVYmaY7ozFgA5MZvSxoWVWl3J8p32WHs/Qoobrp+/trLByw+M8c3S5RgS4Ayd4/CvI5KpRRe+Yk7eyQ5GUuigkAHjLpv7wu0B1wFMXcLxAKj8yZlYqdnTWahd51uuVPsNDONBJDBFPC7K5VcQE1+8yqwclF7AYL/R14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214330; c=relaxed/simple;
	bh=jnm/Z1If7bkvFQkcU7sqYak1vdbr0fMaw8wj4FMrIJk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HxPm38VMrqHVxBMOfxojKgwbMLy1yih6auE1XeLyBQ/kyg6RSzSHQ4LvU0KuTFjtwQWBWunijw2s298IlL3uf8gb/Sl3C1GC4SmdmbloXDiU0nGrGqYJbfVgIrUCA5L3Vek2M5MlM64yZC6kC1VpGFcb58SdGJct+ZFdFccpi3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbtlWCMk; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbtlWCMk"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8a1e1817db6so76125476d6.2
        for <git@vger.kernel.org>; Sun, 26 Apr 2026 07:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214327; x=1777819127; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCHz9aPq0NVGCNpLUqgbv5QeQXOox7FOOXUOGvMdvAw=;
        b=SbtlWCMkkSSdiCSvRO7lDjf3oPH6J9tJlmL+r5Rcue1mqRhM6AUpcOc5mLZwAyqxKT
         DzkE9jMgJvdk6DQBhNsRYdbd0PUKgNlm8yNFEyKSWQkaA4gYS+RJROw/4T1FHulnncU7
         +CbPKyl3BBWLyHVGjSXydLfVCHMaqRf1uxI2uq5HQYQEfzlpUUW7F2ZyvMIZ7/dZdqeJ
         sZbzWY0J1WT+EBYfbVHrasivd8ZyefPyUcECWaS40ezc9SKyATkCVUBTsCewoGUxWUSA
         uKk85P0kviIe276KJxWaNK0TnyURIVfBbb0B/cJKvNXiP8ggAy6dNToU66BrBRiIqA7m
         v/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214327; x=1777819127;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oCHz9aPq0NVGCNpLUqgbv5QeQXOox7FOOXUOGvMdvAw=;
        b=P383k4VO6UYnBfIOlKtG+xcSEDECO2VCHGlBDw4sjWNBNv+tFv2zc7EdawkKuJjEWp
         pMCeFb8rRtjVQF9Rzsh6scbbGM7B8ygBdPzZBTnNEnYc14dCDGHQHIpYw/N4aWwS+eDy
         VHiL2rO5RSeyC4Y/6UgfaHFU00yqib3QFWSlr2UTxz+ke9dj7WI2hDoCogBX4/drmRX7
         jql7X/+EnmzE4FRTLTQoVrJEYID9IeG1RHDnepGc9lw9VS/Z/tUxzPI8+tliUzHvxzJS
         sJF+WFZIdL/hdDt0EkCnlB9dMJ+pK+bsKEyUtOGEJSoC6ftUmYM8OXqmnZrk1CYlLkzX
         n3jQ==
X-Gm-Message-State: AOJu0YzeF3jA1rWPUTfLC6DBOXO4O2WrsBHs5qYk178vz+8MIMRtB38j
	16QREnjE1H9g5NA++xYrqlolVHI1XeEnKOpcN876dx8qE34jkBWncrorY6GHKiTl
X-Gm-Gg: AeBDievbOowflwcqfoU1en2/XKP5j/lPTrj+KkMnaTXqgSjpGPVhq2qdTpvxRzSZOKu
	3U4RN/QO+ogXKXrOolelgM/terkc3cPrc10IbPct9j5DiEHJWJdW6WubILCCmexBgbp9umu0C0i
	L4E5chvrpiRROKiPZznHoAfVQcotDgA4k9QPiE8owGWs55Oc46q+jXRznbb5H2s9nw5Bc46z8aT
	+RrOx+WN9m2IzUH804ILbqWF8bpKQzTv4uflxr1v3h2dA3LF4k7YxNz285+ys1FV7UN7+5wO0td
	CBcmotLPlrTWT2ctmkS+DLvyOd/H0cbaabS2Dm8sqQ4Ax/Zb4oELcjQRvSAtOQfkubvQaD7t/vE
	8S4KhNwsAi2KfLBGac/eswBByUAGl6Qo64RcFlDIbawdLdjWkERGZGaqWkQowSaVCaC5EK5a7bA
	cGsrj30g5Ndklj68Cv+/clSK+NsLc0IXt2PA==
X-Received: by 2002:a05:6214:20ab:b0:89f:2fa:a9bb with SMTP id 6a1803df08f44-8b027ffb7b9mr624539236d6.9.1777214327485;
        Sun, 26 Apr 2026 07:38:47 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.18.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aebc655sm232411376d6.48.2026.04.26.07.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:38:46 -0700 (PDT)
Message-Id: <ed7294ace3770d177a4ee92aaa28013013dcc2f7.1777214316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2098.v2.git.1777214316.gitgitgadget@gmail.com>
References: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
	<pull.2098.v2.git.1777214316.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Apr 2026 14:38:33 +0000
Subject: [PATCH v2 5/8] t5601: restore `.gitconfig` after includeIf test
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

One test in t5601 overwrites `$HOME/.gitconfig` with an `includeIf`
configuration snippet and removes the file in its cleanup. This
destroys the `safe.bareRepository=all` entry that test-lib.sh
writes when `WITH_BREAKING_CHANGES` is in effect, causing later
tests that use `git -C <bare-repo> config` to fail with "not in a
git directory".

Back up `.gitconfig` before overwriting and restore it in the
cleanup, so the global config survives into subsequent tests.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5601-clone.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index d743d986c4..3dd229c186 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -813,7 +813,9 @@ test_expect_success 'clone with includeIf' '
 	test_when_finished "rm -rf repo \"$HTTPD_DOCUMENT_ROOT_PATH/repo.git\"" &&
 	git clone --bare --no-local src "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 
-	test_when_finished "rm \"$HOME\"/.gitconfig" &&
+	test_when_finished "cp \"$HOME\"/.gitconfig.bak \
+		\"$HOME\"/.gitconfig 2>/dev/null || rm -f \"$HOME\"/.gitconfig" &&
+	cp "$HOME"/.gitconfig "$HOME"/.gitconfig.bak 2>/dev/null &&
 	cat >"$HOME"/.gitconfig <<-EOF &&
 	[includeIf "onbranch:something"]
 		path = /does/not/exist.inc
-- 
gitgitgadget

