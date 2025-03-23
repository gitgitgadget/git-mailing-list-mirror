Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6061118FC90
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 00:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742688746; cv=none; b=N+2SA0ScLMcwFV1krueDOyRPeq+JUWauDo93XQURbQnM3xnANc34un1u20hrI62qqlwddb6ET600g0vFzmwitiYWMoZAgRYoXk6NJ3ZTr1SmBXyFUiEVa/xJU396zFiE5A5TCfKdjvU8T6+Vn6efSrvEptRjjXQ0u6RXuWZkZLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742688746; c=relaxed/simple;
	bh=NMqCPWhigt7/NP7OovPwBEKkO2kK7kO7a5sHTVYeSts=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oGrAm6q9z6RUQLDzSKpwW6vCHmEteSTBGwU/7i2IATNwFw+8fR/JSFlVjs3wQGQ5EcTxV7bryW9Yox7wQJmhly3Ew6J+pxObEasJEBvCzGrPXYpUNy1m8SslTf0Q8feQA6lmADA3ECWMapfaPHxaOWFw/+EqVRzyOTAT6d0c+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlK65y7V; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlK65y7V"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso35426615e9.3
        for <git@vger.kernel.org>; Sat, 22 Mar 2025 17:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742688742; x=1743293542; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLb/qHjdL6/1LSIQEpVpMl0XLjpjNgGhi0oxVk/laQM=;
        b=AlK65y7VrwueFJELl92IQkWv7sx4gUzfVs6A3M5BGJNH1b7sWwbZyEjIGcqnyQ6iJ2
         08IGrRm078YHX3CytbzV97tN8UCU9pQd+UNN9rklL3ggNc5vIW4D4jWZLAYfT4L43a5l
         jbndoy4rryfBwCD7Y18qOeW01VXRvOau+wo+ZR/+PlRIXcwXXWaQj5eJgaufdU8i3zpu
         9/2khuN3UatD9rhF/2yz2CtRxFXwdOfPXKh35GPau0gvn8KODWecos1kUv70ibdGA4dy
         SaEC6JDJfFDQKtBeYNOnyFR7SHcQDFC+wdMyNykD0RoOcvEDGW8ned3/qPwN/MpuCpoW
         3D3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742688742; x=1743293542;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLb/qHjdL6/1LSIQEpVpMl0XLjpjNgGhi0oxVk/laQM=;
        b=L0+cPOFK9p+8d05RwTgeYEVxY8po6//fwyTy8MEHwzYlsIa5U9dWr5wO511+RUyS4l
         rJ2vbpaeblZ8qbU4reWFMMzJavVGYY5DD5AH4b2nIwXwGfRgK6Ed9QhFBTLvk2al9xc4
         UErr3KTsuzcvi2SgX2G6RPHU/S0N+y9gIABoKDI9XgRVg+wmziLBHfPonjlfLmpXEeLQ
         1My35m4wRHUtg9Vcg4YdbG8y3IwtsGd+s/Lk9Do/xLwb9ZdAsr01GOpNfQnJF5YLytuc
         /8qEciL1UcBCgxIC3OSRSvULhF2S6NUUceOdqhDTsY/A4jLEKreEx/6tiGUvkEmZbpIK
         e84g==
X-Gm-Message-State: AOJu0YxkBrAvF06jaTCJ0oZDhkyI1TEajpcaNJKzFbNBT7JRAQpKlkU/
	H/WXQ5iXUHn7Ws3u0oI2J3qF2hwL8I/KUfnfPOukCTuKCj/rbevP34yaSg==
X-Gm-Gg: ASbGncsH9Wu2i6SqMgFZN9+Jr62YRP+JLKWyoNrxCBIeqlTsQUW+xHzbk6ZNlYyVa0x
	DHAZxXbP0paSo+DgXft0Lt92hLZ4uQVyuMpp+1z15yZA4llHs8qaSA0K85AFVnH4ny9N1RTkUhu
	t5DWS9kkAOfmLz6VFao4DD654KKxXw2nLaJSOywSQLc4dXUsKnIptHFwX/OWWot8gB5vp6xhCoi
	fpKkgq7ACRyENmVnYtkZZs1HbLqcEKa0tItnDXJnJiySrrLw44kJib0GGJ8sA+x6YtVn9e7jD0C
	CiG2BMZa4MH72DN/8XNegFBNZ/bnpSogea04J+2gdK1K5A==
X-Google-Smtp-Source: AGHT+IEUoEy9re0Yiv/tMnAEmB+1VgfFpAfGtHD8fsoLC3jX15bxxIT5VBFDWbt+1yMt/FjmX180QQ==
X-Received: by 2002:a05:600c:5491:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-43d508728eamr68602145e9.0.1742688741932;
        Sat, 22 Mar 2025 17:12:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fcea65fsm72388855e9.7.2025.03.22.17.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 17:12:21 -0700 (PDT)
Message-Id: <pull.1930.v2.git.git.1742688740650.gitgitgadget@gmail.com>
In-Reply-To: <pull.1930.git.git.1742637713157.gitgitgadget@gmail.com>
References: <pull.1930.git.git.1742637713157.gitgitgadget@gmail.com>
From: "Ayman Bagabas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 23 Mar 2025 00:12:20 +0000
Subject: [PATCH v2] shell: allow overriding built-in commands
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
Cc: Elijah Newren <newren@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Ayman Bagabas <ayman.bagabas@gmail.com>,
    Ayman Bagabas <ayman.bagabas@gmail.com>

From: Ayman Bagabas <ayman.bagabas@gmail.com>

This patch allows overriding the shell built-in commands by placing a
script with the same name under git-shell-commands directory.

This is useful for users who want to extend the shell built-in commands
without replacing the original command binary. For instance, a user
wanting to allow only a subset of users to run the git-receive-pack can
override the command with a script that checks the user and calls the
original command if the user is allowed.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
    shell: allow overriding built-in commands

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1930%2Faymanbagabas%2Fshell-override-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1930/aymanbagabas/shell-override-v2
Pull-Request: https://github.com/git/git/pull/1930

Range-diff vs v1:

 1:  4fe18878afa ! 1:  60c6339e790 [RFC] shell: allow overriding built-in commands
     @@ Metadata
      Author: Ayman Bagabas <ayman.bagabas@gmail.com>
      
       ## Commit message ##
     -    [RFC] shell: allow overriding built-in commands
     +    shell: allow overriding built-in commands
      
     -    This patch allows overriding built-in commands by placing a script
     -    with the same name under git-shell-commands directory.
     +    This patch allows overriding the shell built-in commands by placing a
     +    script with the same name under git-shell-commands directory.
      
     -    This is useful for users who want to extend the built-in commands
     +    This is useful for users who want to extend the shell built-in commands
          without replacing the original command binary. For instance, a user
     -    wanting to allow only a subset of users to run the git-receive-pack
     -    can override the command with a script that checks the user and
     -    calls the original command if the user is allowed.
     +    wanting to allow only a subset of users to run the git-receive-pack can
     +    override the command with a script that checks the user and calls the
     +    original command if the user is allowed.
      
     -    CC: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
     -    CC: Taylor Blau <me@ttaylorr.com>
          Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
      
       ## shell.c ##
     @@ shell.c: int cmd_main(int argc, const char **argv)
       		default:
       			continue;
       		}
     --		return cmd->exec(cmd->name, arg);
      +		/* Allow overriding built-in commands */
      +		full_cmd = make_cmd(cmd->name);
      +		if (!access(full_cmd, F_OK)) {
      +			const char *argv[3] = { cmd->name, arg, NULL };
      +			return execv(full_cmd, (char *const *) argv);
     -+		} else {
     -+			return cmd->exec(cmd->name, arg);
      +		}
     + 		return cmd->exec(cmd->name, arg);
       	}
       
      -	cd_to_homedir();


 shell.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/shell.c b/shell.c
index 76333c80686..76c0157e321 100644
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
@@ -210,10 +212,15 @@ int cmd_main(int argc, const char **argv)
 		default:
 			continue;
 		}
+		/* Allow overriding built-in commands */
+		full_cmd = make_cmd(cmd->name);
+		if (!access(full_cmd, F_OK)) {
+			const char *argv[3] = { cmd->name, arg, NULL };
+			return execv(full_cmd, (char *const *) argv);
+		}
 		return cmd->exec(cmd->name, arg);
 	}
 
-	cd_to_homedir();
 	count = split_cmdline(prog, &user_argv);
 	if (count >= 0) {
 		if (is_valid_cmd_name(user_argv[0])) {

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
gitgitgadget
