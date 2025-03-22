Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754021C5F1E
	for <git@vger.kernel.org>; Sat, 22 Mar 2025 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742637719; cv=none; b=szuC3FcZdspXKlx/JIpSkFLVvem8miYHT4qoUpsXpkjxFakhCwo3K/RRc1IRa0zpwr7E8bddKBbZJjuHOnJWMao88Q9j5ULlaaDMAk+f5H3NV2QoCrgb1eCO0h98CZEbxls108lOKh+w8BVRG+ZWD4p1baAoGqNyNjQZK9DpUYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742637719; c=relaxed/simple;
	bh=3iy1uGvhl0DWsf/LinCj7OGw3waI9YGMLerylynLexg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=CGdTv/oLiEt7YtoykJyW+9adgsIFeic2n8HaN70wQzyL97pbiRyJqkaO8Yq1MmcNFZdRixqNCq9MQd6z8jcskxv09VA4xlQuQZiOa1d163KlwCMKj5C4sBsYFvEqC4Ek3Ig4Yrn9Jvb74en61O4zc+M3gyPMJvLXSA/t3CElVOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQODe5Z2; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQODe5Z2"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3913fdd0120so1581136f8f.0
        for <git@vger.kernel.org>; Sat, 22 Mar 2025 03:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742637715; x=1743242515; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j5g/XAizywkYpObZzY5OBSViIfJ2HwuiANa0fOqMnaM=;
        b=eQODe5Z2QmRURbI1R0ZHI1/vg4AQ1HBF08/qT9Tiwq9mzNy5yiDYp4Vp7P26ldScEH
         kDhpLKUwbuIf4b7q+xPABUtPADFKifUNsV29Drw27ksg7odhwdiveyzvDH2LEnwsKGNB
         qyM0dwiQhTZiG4gPK4wpcv8tqwGUzwZTGETN2aevAjC2sHN1Knx/kDVIRYB89UJ0NegM
         zlg4ofp7ureml9IJCely3Q45sDwnvcdC8IN2rRRLzdOj9EikEIZysSyzCrJwwCeyn294
         n1Q1gyvqRBQHIlpD1FrUkoz5yZ42d6JazS7/vUzvT3lQOnO5/pf/lSOgSzA6PMCdCqPs
         PfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742637715; x=1743242515;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5g/XAizywkYpObZzY5OBSViIfJ2HwuiANa0fOqMnaM=;
        b=VMZn++EN9Kb02vxe4GwVtOkNq+r3xHv0qybmjGa2gefPQfJgrMIVD4W8P7IYm9K+FA
         eyBdLbwtfrAY+zuwW+W9kgT9AhneQC+IuqH9/vZAePJdLh+UeU79tO5wj2XAg3UKIrSE
         acvkRgxZGkD41Fx8aGaogCONmwSVulOM/4iRFXbs84BD6vqth37XhAYy4xeSUJCthMWG
         K8yxfUFeJAKDjfXe3qd8EldkIMw3fqCRuzeEu5Fgrfc6DUIy8dyaTZL0CVTeOfb6hx0b
         ZyawJJgg/mHHHwmUxf8a5oRZXXXlWqlcP1QhRz6cPzM1XAK/maF4H0xI3cLAz2qeUMs5
         j+oA==
X-Gm-Message-State: AOJu0Yzxhhc+HvO6bY3diTdjK0sW6poNR/397twp4vj8BlV36snoeIKH
	0lWtQjcpimcxbVCpevICi+mB/NYrkY42cMGZT4Gyqe0PeMrxLJwks7X8ag==
X-Gm-Gg: ASbGnctA5ONzEZ2Mfb4lPUeVhydYZEVnvNaY1qzg+uMw6aj1HLLgLXhEkRFa3EZdv3B
	ejX9d0O4Rel+MyGUfiLLtznIupLqVTlLMlls7wUX/D7wkGTLKB1plX+2TazYmkRtGolNCbj4r2K
	PvxQC7KWfBPO5wczij9RdMcq5KSS+lINEM8VZLSmwPWEqiNfZmMBVajwdwr0dlidtMCb1oKCd8B
	aw8FUFshDaDqQLflT7Cb33kw0K4fgwDcdtw7XdngtmaejkL2JzE5rENeCxz0JzwU2fCEQLPggRY
	yX/lMeEyQwY2sCDZqRBwVRsHQ0pM6ocYwQK/lW2B4/31FA==
X-Google-Smtp-Source: AGHT+IH8lN/1ob+nT4SnV1CivLEqgbz1e0LZDKHMv3Ulc/AXYkOiOjKLA3yCIVB1PR69WmZR2T8ORA==
X-Received: by 2002:a5d:47c8:0:b0:391:2e58:f085 with SMTP id ffacd0b85a97d-3997f93d39dmr5278924f8f.54.1742637714698;
        Sat, 22 Mar 2025 03:01:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9f0107sm4819424f8f.99.2025.03.22.03.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 03:01:53 -0700 (PDT)
Message-Id: <pull.1930.git.git.1742637713157.gitgitgadget@gmail.com>
From: "Ayman Bagabas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 22 Mar 2025 10:01:53 +0000
Subject: [PATCH] [RFC] shell: allow overriding built-in commands
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
Cc: Ayman Bagabas <ayman.bagabas@gmail.com>,
    Ayman Bagabas <ayman.bagabas@gmail.com>

From: Ayman Bagabas <ayman.bagabas@gmail.com>

This patch allows overriding built-in commands by placing a script
with the same name under git-shell-commands directory.

This is useful for users who want to extend the built-in commands
without replacing the original command binary. For instance, a user
wanting to allow only a subset of users to run the git-receive-pack
can override the command with a script that checks the user and
calls the original command if the user is allowed.

CC: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
CC: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
    [RFC] shell: allow overriding built-in commands

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1930%2Faymanbagabas%2Fshell-override-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1930/aymanbagabas/shell-override-v1
Pull-Request: https://github.com/git/git/pull/1930

 shell.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/shell.c b/shell.c
index 76333c80686..3a6d2e8a044 100644
--- a/shell.c
+++ b/shell.c
@@ -194,9 +194,11 @@ int cmd_main(int argc, const char **argv)
 		/* Accept "git foo" as if the caller said "git-foo". */
 		prog[3] = '-';
 
+	cd_to_homedir();
 	for (cmd = cmd_list ; cmd->name ; cmd++) {
 		int len = strlen(cmd->name);
 		char *arg;
+		char *full_cmd;
 		if (strncmp(cmd->name, prog, len))
 			continue;
 		arg = NULL;
@@ -210,10 +212,16 @@ int cmd_main(int argc, const char **argv)
 		default:
 			continue;
 		}
-		return cmd->exec(cmd->name, arg);
+		/* Allow overriding built-in commands */
+		full_cmd = make_cmd(cmd->name);
+		if (!access(full_cmd, F_OK)) {
+			const char *argv[3] = { cmd->name, arg, NULL };
+			return execv(full_cmd, (char *const *) argv);
+		} else {
+			return cmd->exec(cmd->name, arg);
+		}
 	}
 
-	cd_to_homedir();
 	count = split_cmdline(prog, &user_argv);
 	if (count >= 0) {
 		if (is_valid_cmd_name(user_argv[0])) {

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
gitgitgadget
