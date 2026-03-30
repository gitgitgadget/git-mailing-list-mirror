Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D923BED3F
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869517; cv=none; b=bxR2wiHBkLVx/YDA8TxG8No6HAqRBVgt+dqbl2rEh5Iiiw36Ox1pxcfxAEmRTfpNMjwbs5neyQEOo/ifEHCDkKNIU5zQ7j/ne2DoMokBf6qYmt4u0CPwyKEn1PhQCn1YCwn6PAp9gXUTvWoY4wwVmxG7lQwty4a3jNggp47/apM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869517; c=relaxed/simple;
	bh=xCvezCMC6GyPZ+UGCp0KBx65Vtx7zPGO0odysYpvw48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FW9sEVwtFloA2N2QJveHW/fI6WKEgpQPicn8+e2horMOIa5KlI2/S8bWHxAwBDVhUd+yU+KXp5ONfX9naZmbld3KaTXwuGAzEHqGbwphWmbCL/haxMY8cNAk/e947KHr9N3wMc3MSuN9lQ6QQMJcitRyoKDFesSCXV2esCxlURs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHWkmQw0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHWkmQw0"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43b9d3ebed5so2983358f8f.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 04:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774869514; x=1775474314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giU1VIBpW0g5EXaVJh0Cf89x1oHc+8v0iTHZom6Mhns=;
        b=XHWkmQw0p9c1aYq4HmyBijldl7NyV8RnVAW+FSWBBY73+hUP1L+cDpNK8Gi1YNAgCJ
         BsHuP1+9g8/CIow0DTLvirNw843iSZEcDckPo1ptpmVcIK6+a4V4UIO93+FhY4pu2rHc
         uCewRAR3QPhJNmMEV+5NMSuii7CaHd76VoUN88acZEpapJ6bLr6/BBeCwPqb4CBKQkXX
         RExVMvJ1LFJI8FANc0dOsi7ZjR1HtydwStr5DRPiGHODrI8FmM3Ang/wgdHB7PcA8vGg
         O3xe7/V9MomaGtBL3RCNPNzzTTwM3FN8TajKhvpk0Gm4A3OkEGq6p6UnXi24aDe9E3B0
         +jYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774869514; x=1775474314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=giU1VIBpW0g5EXaVJh0Cf89x1oHc+8v0iTHZom6Mhns=;
        b=l3nB4cYbPYKY9T5dYh/1gPw/XYUCNwJeJ27Q1u2Ls5KUAEUY5zzCP+z9GxoxZqG/Qk
         mucUoCViHO8LOCWQR9SOBnvGzyo9h9g1kCX8X1x93c6sRKeOH2g0PT0OSI+3lIKbmeI2
         k9Gpp6eXOHgUzAfBghE2nhzs+QyGNCsuuZ9mMPJ7mfnI4wbX+d+z3MqcDB0BHJYE64UZ
         QzAVN+3PSFIMBFpKsNRkMuNEn34NomCMWnyo+xlRmYDsPtdf0MEgO3EVf1DUwzvprwK+
         DCJGF2cre/KB0j/VCeB2kNt6CLS6lXHU5kGN8bpbf3UavLpEG1QM0bsO0Zp0DYAszbfN
         7w7Q==
X-Gm-Message-State: AOJu0YwABaoSzmDzARQqgeVz1lB6Ub48b735jxuly76/5R8u73YUu5HZ
	3v90y4vjzI77LSNJs9XMIQWhYPnj0slqw15ni/K36C0+b5uYhSB2mtcBGuSkOa1/1yU=
X-Gm-Gg: ATEYQzz1VZK6PzSH9OsyFqjoXYxIvJW+QIVknh1jjC28+eLCbERVw7nSKnB5ITFHSgM
	VlxicM2aXyZ/up80WoscM2M4vr8myGywsp847pI7NAXgvXxZBZ/2E4/0jLSuwTYEU0kH2A45/s5
	b0UK59WJ7wN53ZBM1ucH5yqJn4ec8KBT6WCG+k+6BImGpuzuhWN1EqOXA3QkfM7okbHT+mVUrVt
	UFjsgdZPkiBAluOV7Yl6SS9vRm5m+gU2nqoowheIk93N/EqkDZ6Ey3UskblgLyzNSmVNuQWH6yj
	EIEIRBRu4Kb8LJ18JNVJrcMIXmn8gl3YYHOP1m4NeUJE655SW1fSmXr4N/dgY7pO7sPpy9XN/+9
	5EnVYq/3VDOHp3oTGlclslbPnBswFyiEW33J966vlH3Fxf/pJQ8+g6FqGojWSFJ3PQzRmjZOaLw
	4F4l3YSBLeNQw/6+2wTVemhl40ZyQF1zZAEpHPi+GTxW5G6HH9TuotoBC57IrBdd98ovOtfwUx2
	cTiJT2Gl2eBmhT9wqC20w4Ii78cz+UKvKvDGRHntxsr1YBh4oHNe9ULGKY=
X-Received: by 2002:a05:6000:2210:b0:439:c2b6:d5d8 with SMTP id ffacd0b85a97d-43b9eaaeae8mr20338152f8f.36.1774869514052;
        Mon, 30 Mar 2026 04:18:34 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21eba4dsm19140821f8f.11.2026.03.30.04.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:18:33 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: me@runxiyu.org,
	gitster@pobox.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH 2/3] t5516: clean up cloned and new-wt in denyCurrentBranch and worktrees test
Date: Mon, 30 Mar 2026 13:18:21 +0200
Message-ID: <20260330111822.165188-3-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330111822.165188-1-pabloosabaterr@gmail.com>
References: <20260223141236.22476-1-me@runxiyu.org>
 <20260330111822.165188-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'denyCurrentBranch and worktrees' test creates a 'cloned' and a 'new-wt'
but it doesn't clean them after the test. This makes other tests that use
the same name after this one to fail.

Add test_when_finished to clean them at the end.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 t/t5516-fetch-push.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index f44250c38f..c40f2790d8 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1792,6 +1792,7 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 '
 
 test_expect_success 'denyCurrentBranch and worktrees' '
+	test_when_finished "rm -fr cloned && git worktree remove --force new-wt" &&
 	git worktree add new-wt &&
 	git clone . cloned &&
 	test_commit -C cloned first &&
-- 
2.43.0

