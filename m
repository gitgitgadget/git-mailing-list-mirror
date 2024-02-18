Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4505CEAFC
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708241621; cv=none; b=hRJLoBqmQ6zuebsAKkWMdP5eWUPPHDGWWDbCLnxnZsfmvBg0oVmFqw1+Pj/HrxMBrBBNSMd053kQ1jMpiJHUjzgw/tTysE16O+Wjj8EvaYNDVtbEnAp2pxshJ5ng81CTmbv2eip+I32k95+T5dV3MHciVRSpo7F5z6UsEsIy95I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708241621; c=relaxed/simple;
	bh=e30FGQSHiNwkp4qApRH3y3xnTx2Zi8WMb/R1wLFE/gE=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eBbm02uO4YqCN6uNHxYZ1LSUfOeqYvRfAYboPhbYZ7VyA/226Oxq5Zt6gQ5gQa17CN3kNZmEEkGC4qrzG8oxbYl6xUsctht8Yt7+pJlfux6N5PJc2OF0Sk8T8n8ldaCjPgIrRzNehjMnOrztPL74Wg54f2f32tO0IvWc8EUliAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hxt1CyY3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hxt1CyY3"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41260adfea7so2935715e9.2
        for <git@vger.kernel.org>; Sat, 17 Feb 2024 23:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708241618; x=1708846418; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwvzsxQ8/Vw/1NrwghNPJcVfjwJf80Rjwp40GXIfL20=;
        b=Hxt1CyY3pXUubngoDWyaNf3/zBB1VOwLSPd0VYz+NAZR4Zx8FCFD8CXu3FUE0BY1ML
         ZIdYx5Qb8IS4usSsDi9WRXiLwkiFgsDf76n1eUwcF8bbJxF6Ra2VXxYBbGo8d62leHZ3
         qMyD4QTOsZhZ13bE9tXnKOOREO6qJinEfAG72pyxIVL2bHF7QQo2RIbUk+grH1psP2tD
         qxwJzm7SydrGFUzj4g9m2thD+77mc2T7YH0IwxoX0j/PdwNo9xG5Cl8gFLPQTpLC7t5v
         0ciX/LrMi/OGjvapN2vEUD+rFOk6s43MI9yajNdNqNTSXwNOcUEscuBEsjmnWd7mdE4X
         WMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708241618; x=1708846418;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwvzsxQ8/Vw/1NrwghNPJcVfjwJf80Rjwp40GXIfL20=;
        b=XbfXxq0MUhmMdgsRMgISDcNPKYmXSpZfy4G9VpK8XWofavTHxxpm9JEZVypojNs4Mi
         qWOQQ2qjMhyXQ0GrxGB2gsUTWkfTd3+sS2pGR0WRoFC8A0+T0hoVtFjukFQymI358i2i
         4JYLiaQyv2gY1xjtFtFH2tbJ/dem/IxKnoPItcI8jnbw4zCniVNNSB57iZ5vscoPzIvs
         Lwjy2Axk7uLogxJFDNY/zPnPlv3bPCgEB+08v9bfLTAv0b1CnePs6vhrbvLeJDt4V6Ct
         vfXNMUrGJ+DJXHxqJDIZki9NefBUcn+Z80NXZyXN8hltohPvE6Z+glokrEQnsn4bnZAM
         SIsg==
X-Gm-Message-State: AOJu0YxhCUR9468RUJr04rsnTZuXNYIhbYRlatjjxiA5X/BA12BO9iJ1
	noiQfmQ4AFPPVyIBBXvST7mgxkT9Iea2F8/sOS5f+jB9zWantviUzN1Xp8+G
X-Google-Smtp-Source: AGHT+IH5d+7jHqAYB3kjmKf8CUh3ScXJa4IcPq4WsgjTWULQx6idhb7u5V7jqt9xZ1Kd3vbsM5Bs7A==
X-Received: by 2002:a05:600c:5486:b0:411:eb73:243b with SMTP id iv6-20020a05600c548600b00411eb73243bmr7417163wmb.5.1708241618529;
        Sat, 17 Feb 2024 23:33:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u22-20020a05600c139600b004122aba0008sm7505327wmf.11.2024.02.17.23.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 23:33:37 -0800 (PST)
Message-ID: <c0d670df198eabc20bf89854184db7a100cb3030.1708241613.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1666.git.git.1708241612.gitgitgadget@gmail.com>
References: <pull.1666.git.git.1708241612.gitgitgadget@gmail.com>
From: "Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Feb 2024 07:33:31 +0000
Subject: [PATCH 4/5] apply: pass through quiet flag to fix t4150
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
    Emily Shaffer <nasamuffin@google.com>,
    Philip Peterson <philip.c.peterson@gmail.com>,
    Philip Peterson <philip.c.peterson@gmail.com>

From: Philip Peterson <philip.c.peterson@gmail.com>

This test was failing because it expects the invocation of `git apply`
to be silent. Because previous patches introduce verbosity where
previously there was a silent error (in the form of a return code), this
adds an opportunity for a bug to become visible. The bug is in the way
`git am` invokes `git apply`, not passing through --quiet when it is
specified.

Signed-off-by: Philip Peterson <philip.c.peterson@gmail.com>
---
 builtin/am.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index d1990d7edcb..799cb8128a3 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -36,6 +36,7 @@
 #include "mailinfo.h"
 #include "apply.h"
 #include "string-list.h"
+#include "packfile.h"
 #include "pager.h"
 #include "path.h"
 #include "repository.h"
@@ -2412,6 +2413,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
+	if (state.quiet) {
+		strvec_push(&state.git_apply_opts, "--quiet");
+	}
+
 	if (binary >= 0)
 		fprintf_ln(stderr, _("The -b/--binary option has been a no-op for long time, and\n"
 				"it will be removed. Please do not use it anymore."));
-- 
gitgitgadget

