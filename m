Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166B91AAE17
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776357410; cv=none; b=d/cqfHDm+Dor3+wFu+hfbbP74R63XAPtH/CQSkm9VtaV0VCDITVDkS29DENe0d2QZmm0vJDJ4FVE8yn89gKDm33rw7Yfmz8jOKAIxNm16cbkHhzDIgAxZMWgEkJ6e0CLDY6WEPMk0NvnkY/PDCVkwwbsUt6OtqQogBcmZGJ6fKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776357410; c=relaxed/simple;
	bh=ORoEuHbOearEFPzjE0toXwDPIBzQS+cEBuzFJx2WvSM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V21EvOBOB3Upw42hCd05G77KN4Xjmf+ep5xyhmCfuaJ8p5QGMuAD0Wn/TotULhk3UOo4FVPmHCaySvgQ158KYsVBTNDFxG67E6kdLXeygSsLIz5x/VFAEKfX5aSX81rqvFovYdn03r7LXPuw6hqmKIgtwEohLxw8ggU1Ek6bajU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZHADxX4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZHADxX4"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b150559bso65114825e9.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 09:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776357407; x=1776962207; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZP+MDQZ9S2KxLbKc6wUHzq0pAGMTAQ2QTPvhK4UrMc=;
        b=AZHADxX4iucqhUGR+sXoOxx72gAUIOoug6Q+qaf3rR6aY52Xjz2vCSHXHoObEdaYy8
         0LDdFpBlfC5Qun/SSyypyB1pI/JtKWJi69PFmd0dQOctQX1lkadyNGtLxwQ1pCRMbpbm
         p7xI+lXJy/he92IaWosctxhS5aUF4mbImvlKn1nQE+fW60XcE0Mg/RFe/fUx1k38AK3B
         5y8/dycO50Av0GJKscM2g1WWJP4giEFVp/BOr4VBv97UkRPBJddCcldMkc7r6ADgbOUD
         wujcvuejwU6q4Zc/uPoca2T9Z7Xk6PBMHAyVWr0h9P0u8mJMULQmEMtsIWd6al9OXh1C
         m5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776357407; x=1776962207;
        h=content-disposition:mime-version:reply-to:message-id:subject:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZP+MDQZ9S2KxLbKc6wUHzq0pAGMTAQ2QTPvhK4UrMc=;
        b=NmUCqXW1RSp2AkQhW9syJno22vbKxCI8k5xp8jDa33EZTWbgDeKJ4G4Ok4LXS1PYCm
         fdsNAYlqBJRJJC3T289yvegrOLg6kHcSx3UlrxMyJ5XySVxbu7u25Y+nO4uigFDeYI6Q
         U1+cvxRV5UJFugof32yV83+e4hfdjc/JD0hYFtUu+1kwGwxsfZpDwFLav3oBq0WZk4mJ
         0OfH8iIwKo/0nmNGpFfiS8JvRalsCVrK2gOLIy5PPgP5ZjL8A29trRfR25z+mI7Cgfn7
         WRs+eRw0dkypkGjYc9Oov89ZGw+pp8DEWi6Lopo1ukmgcRmIjUqEIiN1IpBqAHwa1lNh
         3l1w==
X-Gm-Message-State: AOJu0YzOVU0ki0ffuSCkb51Oofj/9f4lUhNZFcu09uzhVzJgBESgS3ss
	myfLhcSGHJ41WLWlHNDlLAfZwpv1kNRDY3k2h78otmlXHM01m7+00Etsd34ZAg==
X-Gm-Gg: AeBDietvtlaa4eYxP1V3w/jD5Nl0tZMNFd9jiOmFJ2Kt649dU55dVrclDYr62WiSBCE
	S3TiF+JE/ASx3s0v1MSBuWihBUknbhZPD2KbgngDhpU34ZTMC2Z7bCq9aoqYAQTMT/O/6GSKLIB
	j+SafH/sxkqPc+O3WBdjwFNj/ePypgTz8RngB78pw+ewh6d5gXc6tlpa6FEMlbvBhqN4XJZera4
	qxaFDYifD4mmIYo/clWYf++wZ6mFNASp168akhGI+ks/L0y6mv9xdDuWWQZ2L2Y1knXZNutgBHn
	IWbSaYmTp3OZfF+zUkyNv69WXKz1K4rujf7Ryd/1E3EVA9xPpRWOlz8X22q+4W6cqMKr/YK0Mew
	t5KS3i7qcQKxnadsY5Q4mcKQ7X5mFIyUz0zcCl7xsMGM0U6NAlEjuRScWa9rvO0TGl5GGH+CEye
	jJwMOVjnQYWob8+QaUtF6ofx/54Ct8FjmtuvGgz6Bzm0VtVPI8U0Jz+87MvflcUW4a2XX+hpBrf
	P/zzrjWZZPb2IWE
X-Received: by 2002:a05:600c:a11c:b0:485:303b:c50a with SMTP id 5b1f17b1804b1-488d6804721mr273041875e9.13.1776357407409;
        Thu, 16 Apr 2026 09:36:47 -0700 (PDT)
Received: from RTX ([79.117.197.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f581b8f8sm66923165e9.4.2026.04.16.09.36.46
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:36:47 -0700 (PDT)
Date: Thu, 16 Apr 2026 18:36:46 +0200
From: Jimmy Aguilar Mena <kratsbinovish@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH 3/3] worktree: add --recurse-submodules flag to worktree add
Message-ID: <aeEP2lMfN9_qCTm1@RTX>
Reply-To: CAPSFGa8uu9CEEPH3XVjfN5VEOfcnb2p8YgXVuansjKc0S2S_tA@mail.gmail.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Add two new tests to t2405-worktree-submodule.sh:

1. "worktree add --recurse-submodules initializes submodules": verifies
    that the submodule working tree is populated and that "git diff
    --submodule" shows the expected commit difference after
    --recurse-submodules is used.

2. "submodule in --recurse-submodules worktree uses per-worktree gitdir":
    verifies the isolation guarantee -- the submodule gitdir for the
    linked worktree lives under $GIT_COMMON_DIR/worktrees/<id>/modules/,
    not under $GIT_COMMON_DIR/modules/, and the .git pointer file inside
    the working tree references that per-worktree location.  This ensures
    that removing the linked worktree also removes its submodule gitdirs,
    and that the main worktree's submodule gitdir is unaffected.

Also rename the existing test_expect_failure to clarify that it covers
the case without --recurse-submodules.

Signed-off-by: Jimmy Aguilar Mena <kratsbinovish@gmail.com>
---
  t/t2405-worktree-submodule.sh | 24 +++++++++++++++++++++++-
  1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/t/t2405-worktree-submodule.sh b/t/t2405-worktree-submodule.sh
index 11018f37c7..5ffe0206dd 100755
--- a/t/t2405-worktree-submodule.sh
+++ b/t/t2405-worktree-submodule.sh
@@ -34,11 +34,33 @@ test_expect_success 'add superproject worktree' '
  	git -C main worktree add "$base_path/worktree" "$rev1_hash_main"
  '
  
-test_expect_failure 'submodule is checked out just after worktree add' '
+test_expect_failure 'submodule is checked out just after worktree add (without flag)' '
  	git -C worktree diff --submodule main"^!" >out &&
  	grep "file1 updated" out
  '
  
+test_expect_success 'worktree add --recurse-submodules initializes submodules' '
+	git -C main worktree add --recurse-submodules \
+		"$base_path/worktree-recurse" "$rev1_hash_main" &&
+	git -C worktree-recurse diff --submodule main"^!" >out &&
+	grep "file1 updated" out
+'
+
+test_expect_success 'submodule in --recurse-submodules worktree uses per-worktree gitdir' '
+	# The per-worktree submodule gitdir must live under the worktree entry,
+	# not under $GIT_COMMON_DIR/modules/, so it is cleaned up with the
+	# worktree and does not disturb the main worktree submodule.
+	sub_gitdir="$base_path/main/.git/worktrees/worktree-recurse/modules/sub" &&
+	test -d "$sub_gitdir" &&
+	# .git pointer in the working tree must reference the per-worktree gitdir
+	echo "gitdir: ../../main/.git/worktrees/worktree-recurse/modules/sub" \
+		>expect-gitfile &&
+	cat "$base_path/worktree-recurse/sub/.git" >actual-gitfile &&
+	test_cmp expect-gitfile actual-gitfile &&
+	# The working tree is populated (test_commit creates <name>.t files)
+	test -f "$base_path/worktree-recurse/sub/file1.t"
+'
+
  test_expect_success 'add superproject worktree and initialize submodules' '
  	git -C main worktree add "$base_path/worktree-submodule-update" "$rev1_hash_main" &&
  	git -C worktree-submodule-update submodule update


