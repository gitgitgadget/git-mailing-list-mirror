Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5F62163AE
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736419782; cv=none; b=gRMkyZtgKWj+m/Vk61yMaoDljZ31YUDdFM3KXl9GU+AvT4MKPlyW5E1uQr3S6JLCUScPcXx7Ua6ze2995JXfnEilDRXXTKRDx/V0muVIkGneFaGUtFnSZB9y6kQNp7VtOn4I21SetSSTlHH+LCURtNNE+nlaM+XOg3ojJCLd99E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736419782; c=relaxed/simple;
	bh=ajdGmJx6NAxEAc1YrJ5zACURO1SHs1X7M3OKK75BMm4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KsShYTxCIPzaZSwu0naRyA94TD+QpkXPnH3JEkHLlzVW25oAqoNbdPLFnMg5Ef2ecz+kuQNh6Fdhw9D4xdrZ1M12ZBP14Zyh4V1J/yIfCHuF4wxyywhsEvCzVfpR7NiAzO3KNzlO5qAekfa2j1RdxrkL+WCp86nGNxrL0o61yE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iv7vIfHo; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iv7vIfHo"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so394830f8f.2
        for <git@vger.kernel.org>; Thu, 09 Jan 2025 02:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736419779; x=1737024579; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaz8N32m3NU26AXoWvG9lOq2DfdEywX9eGNH30doUx0=;
        b=iv7vIfHoHP1G/BRHJGzKjKw7le6ctCjPUT0XYbOVdTMAWO4kpu27b29RFVTBpW0hVH
         L5u19gSEuHpoipZ3aoRB80hWgpAl5QRUKsOXNhvf8kMJioyQLLRO80mwAdZdKJpdB4Jk
         HWXlEovMUYgD7YCGfg/QoKxZcplwgw7/w/UofkrjJ+WbP3MkiaTxB0GNwAct6DYqScVS
         2kOGQp1YepwqL5TwbC1RFHVqJb1dMa2VQVsjKm0BxWfM4gUdVpPrOeQ3UHDqRaO+hO9W
         wsEQAt/tgaTPMbi98MinSrLrkABYkGPqjvpNLSJ/T3HAYENxuCpS/vxpcJQwYiCrGv1U
         RF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736419779; x=1737024579;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaz8N32m3NU26AXoWvG9lOq2DfdEywX9eGNH30doUx0=;
        b=gNL5bl+GOQuQWQzCRfpmoN3hr48N/Roy35xOvJaIYLgOgfaBTgMCc9I69A1vFMB1cl
         U+aDG/fQxghZ4arQuQQ42Jb0hXDz3bNobrpKS7dNI99kt9kvsI34DRmzZZXqoXaOiuQz
         WIdZkWR53yxNQo/4x5wbl1e0dOxq1A2yZAgjkAjkDuyn+Q02ze5Qn/te1BCkfm1/32t7
         NPBovMzJoiUlcF1llBtN7+sQ6eiQGjgA0I2Zt56sBdEnlebuleLh5wIXUFBpl55zO5DX
         DQm4hx7YpqfAUgbIdq8GE0ebfmGrbwd/gZSzfxGguW6NVXbaqQdDju8UZLwMMKRvaRBK
         5uew==
X-Gm-Message-State: AOJu0YxePvQA90C9QOeb2V6GJ/U3h0kqwfuHFgaPsJ34s4kbg7m6RmlE
	VabJfHLr8NQjN6q8S7qWJQsr/DyLLPDu3mUaAEIcaFoRdp8OfwIFtv/PpA==
X-Gm-Gg: ASbGnctK3Q5Dt7B52Pe/q1W7IFEFAG71ym/wKM+CfoHJDd4yPNbyrpWUVtuYamy7MEv
	3br09bMNVOxBe8rl869X0ddKo0hTKCp+060Af+kh5gVUNWHAoEHVFHaFJx+/Qz36xzOvG1kfRja
	HcRk+NIeZbQISvazSbxwgQTUoWtDX1wwYXcfYpG/vFNXCzf9Ixe2Uu60XJELUxTj+382ybh0Akn
	i1t2FvjH6P5xJWcI35QIQaRcfvwjBsiZDLwtZ0ypevJXJc3+vKJA7WpgA==
X-Google-Smtp-Source: AGHT+IG7CD1zkv/E9mCTf3FpcuzFLmvt3hnSaCdKl5xt6+jwafPzIGxjuLUrGJiYy3QCuOYEu4T2fw==
X-Received: by 2002:a5d:5887:0:b0:38a:673b:3738 with SMTP id ffacd0b85a97d-38a87312dd3mr4895570f8f.33.1736419778741;
        Thu, 09 Jan 2025 02:49:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c697sm1487302f8f.52.2025.01.09.02.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 02:49:38 -0800 (PST)
Message-Id: <pull.1869.v2.git.git.1736419777235.gitgitgadget@gmail.com>
In-Reply-To: <pull.1869.git.git.1736364707068.gitgitgadget@gmail.com>
References: <pull.1869.git.git.1736364707068.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jan 2025 10:49:36 +0000
Subject: [PATCH v2] help: interpret boolean string values for help.autocorrect
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
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Yongmin <yewon@revi.email>,
    Scott Chacon <schacon@gmail.com>,
    Scott Chacon <schacon@gmail.com>

From: Scott Chacon <schacon@gmail.com>

A help.autocorrect value of 1 is currently interpreted as "wait 1
decisecond", which can be confusing to users who believe they are setting a
boolean value to turn the autocorrect feature on.

Interpret the value of help.autocorrect as either one of the accepted list
of special values ("never", "immediate", ...), a boolean or an integer. If
the value is 1, it is no longer interpreted as a decisecond value of 0.1s
but as a true boolean, the equivalent of "immediate". If the value is 2 or
more, continue treating it as a decisecond wait time.

False boolean string values ("off", "false", "no") are now equivalent to 0,
meaning that guessed values are still shown but nothing is executed (as
opposed to "never", which does not show the guesses). True boolean string
values are interpreted as "immediate".

Signed-off-by: Scott Chacon <schacon@gmail.com>
---
    help: interpret help.autocorrect=1 as "immediate" rather than 0.1s
    
    Took Junio's suggestion to include all boolean values as valid, though
    I'm not interpreting "false" as "never", but instead as 0, as they're
    subtly different. 0 will show the guessed commands and exit, "never"
    will not guess the commands.
    
    Changes since v1:
    
     * Include all boolean values rather than special casing "1"
     * Update the help.txt documentation

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1869%2Fschacon%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1869/schacon/master-v2
Pull-Request: https://github.com/git/git/pull/1869

Range-diff vs v1:

 1:  dbda79cd4fc < -:  ----------- help: interpret help.autocorrect=1 as "immediate" rather than 0.1s
 -:  ----------- > 1:  07b47b70ded help: interpret boolean string values for help.autocorrect


 Documentation/config/help.txt |  5 +++--
 help.c                        | 18 +++++++++++++++---
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/help.txt b/Documentation/config/help.txt
index 610701f9a37..6d9c2e06908 100644
--- a/Documentation/config/help.txt
+++ b/Documentation/config/help.txt
@@ -11,8 +11,9 @@ help.autoCorrect::
 	If git detects typos and can identify exactly one valid command similar
 	to the error, git will try to suggest the correct command or even
 	run the suggestion automatically. Possible config values are:
-	 - 0 (default): show the suggested command.
-	 - positive number: run the suggested command after specified
+	 - 0, false boolean string: show the suggested command (default).
+	 - 1, true boolean string: run the suggested command immediately.
+	 - positive number > 1: run the suggested command after specified
 deciseconds (0.1 sec).
 	 - "immediate": run the suggested command immediately.
 	 - "prompt": show the suggestion and prompt for confirmation to run
diff --git a/help.c b/help.c
index 5483ea8fd29..9e0f66c26dc 100644
--- a/help.c
+++ b/help.c
@@ -573,9 +573,21 @@ static int git_unknown_cmd_config(const char *var, const char *value,
 		} else if (!strcmp(value, "prompt")) {
 			cfg->autocorrect = AUTOCORRECT_PROMPT;
 		} else {
-			int v = git_config_int(var, value, ctx->kvi);
-			cfg->autocorrect = (v < 0)
-				? AUTOCORRECT_IMMEDIATELY : v;
+			int is_bool;
+			int v = git_config_bool_or_int(var, value, ctx->kvi, &is_bool);
+			if (is_bool) {
+				if (v == 0) {
+					cfg->autocorrect = 0;
+				} else {
+					cfg->autocorrect = AUTOCORRECT_IMMEDIATELY;
+				}
+			} else {
+				if (v < 0 || v == 1) {
+					cfg->autocorrect = AUTOCORRECT_IMMEDIATELY;
+				} else {
+					cfg->autocorrect = v;
+				}
+			}
 		}
 	}
 	/* Also use aliases for command lookup */

base-commit: 14650065b76b28d3cfa9453356ac5669b19e706e
-- 
gitgitgadget
