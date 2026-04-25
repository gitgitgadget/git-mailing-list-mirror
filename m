Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2082394498
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777114732; cv=none; b=EYDdt8YiThyo5A1hRB4yNHCyxLDw0JRGBhVbwdt1dkzvp0CEX9S6nm084tF42RF0rBVlLLguqwpBJa9F1C7q9Nq+XoIi2X+JcDNHSafY81wroBn6HN4g0CSFZier/KfhngWkTCoyg7r+yHwfo6APKfdRLVhU+rrNX/99J0Psml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777114732; c=relaxed/simple;
	bh=Um8dOrD+8n7ZrMuNeTQQ0c1fT14axWDGTKlXtmstISk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Wlys2Dcwr7eScVSTvTrAjecfPQlGoR5vStfECHjRX2XXHaFeE/veajMTu4ToJwZPNe3nIAa29R2HY2WOjOwNpMthymCNy7qX/J/BmvWZfms7zl9t51ZHKbC3BsFOPvuhqFS/CPSc4eZQ3kb1MTeQZ06AjeaQuR6FIxasTgqlU+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4cEs7+1; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4cEs7+1"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so123433136d6.2
        for <git@vger.kernel.org>; Sat, 25 Apr 2026 03:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777114729; x=1777719529; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7/Z7XbxFNeQcezkDTaSLriPc4aaAKyWW1amkiukUes=;
        b=j4cEs7+1BM4LC5KEhhVSU0gqy7qzroroTyz6iA/PQg0orbRCfXnOhIa5K40pBZE8RZ
         AKDi72CbJkzYOYZiFpKLm/qZKflzJix0dyPXfXI8wt/JYkbAp+PPVZcHvxnWzJS9BKfa
         2sRjvHNf8bZpeitfAvePnv0snNs9E/eyympKYsv1tScbe++QnMh1RGOkmRASzEwiTAVW
         /UofHUwRn9KiDdAVvKRMJPka+YMnctcIInRYWfgXotdvoT427WiLvZOp+CybqygFWeqT
         x564Id22Opdf0QW/2X6hvZLXk68sFUjc5urf2GMfi68xCEUYx9+njdkqX5ql7UTonE/0
         Bdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777114729; x=1777719529;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/7/Z7XbxFNeQcezkDTaSLriPc4aaAKyWW1amkiukUes=;
        b=VhwPIfTtqivV1PVpclzcZIgPZOSGap6FpKqFR0Zhj//upXHjrGw/G8J1zk/0WC9uM+
         x45uQAHYkb4cTRHGMtMqFLfavygaVIj+zVxwir8DJsXJGM27q4yQaD1TpSaqEoHMbLda
         ssVmNM6AqfzJC5UAUmDTKfGwYzF73T87syshv/lHkUvhDbar86rWtAqKmXkcIakYjWG5
         35Us2L4dk+KPLZ/pBdM+grJJvwdkjyQX+qGuhIbbHdD0dpkEz6Q9fP1Tnubc/r9qc1DD
         6lz31XiV8XsF/lYVp4E9Lq3Zrpk8O7xcesAAwrFLKj0QvJEnwtU/XFHPicQSM5bkFp/0
         aYyQ==
X-Gm-Message-State: AOJu0YyU4D0dSfnLYrKXn+d4WZlIwZfAEi4/xLmqs5KVlJ+TKAXV83C/
	akQn/m6ODa9yOE+hR/xWddQckxcMuvT7r2/nsf4qwJlThpQHHkaLwdGn01TXDQ==
X-Gm-Gg: AeBDietw0PSp16PeMKmRZO4rxNlzVPQKvsxWaeGHh9pIltkgMeZxW62pXL53FwOCcH1
	yb5QEGfDN+FmiciPC2XsXR9Nm7pKkvOEQOy1eYsssW1YNA4XDL+LQUKfGEBeirsMwISz/PHgth8
	96QwQjJyxV7o0VOEmDTlpyRHpbPZDmwliXD8wOVpOITxyYehOSCwM1i7Vq6eYOR09mj8dhOFDcK
	eu/hzHJ6KkTQFM14u2VuzB3nPC6x9pVB23saq+V8gYqcaQtEWgxEwTIapENZ3iA16fjJlrpBg4N
	p5T2XiU5nfATq4xWRslm8DdQlp51jmKGEjO+/zHw8UUEDiAvd/Taw6v/338jtIERji/Yu6hPSdr
	GKTPd9YoxGxmNYU2Y/m4fQlQDBHbGeHp4ZVL7mbYUiz2op9EqLAQSfsH+M+loDRJfMOMXsLV8Mb
	FFEOROFm8AZcY0CCd98LZ9s5F0uFTGLH21syJRUQ==
X-Received: by 2002:a05:6214:498c:b0:8ac:a097:2810 with SMTP id 6a1803df08f44-8b02812e41amr569711546d6.27.1777114729273;
        Sat, 25 Apr 2026 03:58:49 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac4685csm205530786d6.6.2026.04.25.03.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 03:58:48 -0700 (PDT)
Message-Id: <faa83723f4d09616f4bf18b9e040dbea351d2eb1.1777114720.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2097.v2.git.1777114720.gitgitgadget@gmail.com>
References: <pull.2097.git.1776775319.gitgitgadget@gmail.com>
	<pull.2097.v2.git.1777114720.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 25 Apr 2026 10:58:40 +0000
Subject: [PATCH v2 5/5] l10n: bump mshick/add-pr-comment from v2 to v3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Christoph =?UTF-8?Q?Gr=C3=BCninger?= <foss@grueninger.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The l10n workflow uses `mshick/add-pr-comment` to post git-po-helper
reports as comments on translation pull requests. It was still pinned
to v2, which runs on Node.js 20. GitHub is phasing out the Node.js 20
runtime on Actions runners, so staying on v2 will eventually cause the
"Create comment in pull request for report" step to fail.

The sole breaking change in v3 is the switch from Node.js 20 to
Node.js 24 (https://github.com/mshick/add-pr-comment/releases/tag/v3.0.0).
The action's inputs and outputs are unchanged, so the upgrade is a
drop-in replacement. Subsequent v3.x releases added new opt-in
features (message truncation, retry with exponential backoff, file
attachments, commit comment support, "delete on status") but none of
them affect existing callers that do not opt in.

See also:

- Changelog: https://github.com/mshick/add-pr-comment/blob/main/CHANGELOG.md
- Compare: https://github.com/mshick/add-pr-comment/compare/v2...v3

Pointed-out-by: Christoph Grüninger <foss@grueninger.de>
Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/l10n.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/l10n.yml b/.github/workflows/l10n.yml
index 95e55134bd..114a12a9e5 100644
--- a/.github/workflows/l10n.yml
+++ b/.github/workflows/l10n.yml
@@ -92,7 +92,7 @@ jobs:
           cat git-po-helper.out
           exit $exit_code
       - name: Create comment in pull request for report
-        uses: mshick/add-pr-comment@v2
+        uses: mshick/add-pr-comment@v3
         if: >-
           always() &&
           github.event_name == 'pull_request_target' &&
-- 
gitgitgadget
