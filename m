Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7CA7A127
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710260817; cv=none; b=GgFQhWZD4qZmoS33c77Jvai/2vyONM1P7kmjhl6XGTSKUPjQ6oLKAJ83u51cF29HNrMDYSgDoEXqHnKioroLtpEjWqeJpz25lBCM5ERbBKULxhAgYrqmSOFVksjulJiDFGMZQrQf+yjr0PZGYE5W4su6AS+2Ux7sFiIAgvLgLlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710260817; c=relaxed/simple;
	bh=U5avtdg7GsY3pt4X/IfPiN/zqCveXCJaOimg8IZ+XEY=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ADJq+mVd5ZfuHsYszlK6o+I8/eiY9FTcrc9MSY/9R1YBjUN7sAgRninYwcY8puauzRLoEKc7LZr9auiOtVKR+Npmu/luYtVu5XzXFptyNURSED7SkxpLXgZLeGYyxrzT0jlOI+cvmDmmt3ExW48Q7D/Io9ucneRIO6yHlb55cIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyeSJdky; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyeSJdky"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4133847e47bso5994645e9.2
        for <git@vger.kernel.org>; Tue, 12 Mar 2024 09:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710260813; x=1710865613; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2J43wI7NWpBWhZlwcC1jqOZI/JAyLK3zopTFbeoTeoQ=;
        b=TyeSJdkyW5d5vRIPOEb0pbZ2mOdV98JuS1aqc0BnEZp2QZ4cW8tRvO0zzcTDhkJnXg
         CwIx3fG3DijiFSVjeSPR4L06KsTYVO5vQAS+g9TOg3+XQBgluucjdiNryGTOQNBY6vmp
         OYATMViryLjJZFzK3dA9Wtgr5joGvGp5uwAUU67BJ1lXxOuMoVQ9nnr2Ul3H6b3vivsI
         19S9zdI8FJDJlwWU7X0U/ArXl4BLXhgkdUeCBt8+IeD343gzs0XNaXRurYdWYnTLdVRv
         w1r81hTV7c0NdqjAStXWqr/YfLdtmbopaLfqofezweqiaprUhZ3qoqz5YgM2m+wvxXf7
         zorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710260813; x=1710865613;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2J43wI7NWpBWhZlwcC1jqOZI/JAyLK3zopTFbeoTeoQ=;
        b=ZgX52LeZSmWS5Ka+MN3FTgM57mydLjFdFW1gmu2XEmSu44sXBwaWB9S7fxpY7JLt8+
         FW5bbGJvqjRZDJu1VhL6XxHNTPbzbpTMiHfIMKfwvrBzlK1tocttD/T9sFb6f2ihmk3E
         uoGGjC5ilnU9XYfRwkIc8Q/bgnAba07mqYXbP7Q9VlA2TQ9tAurqR3iDE1TUyYxTL8XY
         UEdbMFmjJo286OymGkdiCmNmeQ6QTEUihOL7UbGUnlhmg7wP10rpkIiMlAKTN3iSdDsl
         ueXvH6gsM5E14OuMsJuhh+Ydm9Rr9PBJlfRkb2VBYc8Qz7X99rgeEU/v1QWtrvDDce9p
         dfwA==
X-Gm-Message-State: AOJu0YwzIkiZ8Dejt8tQsPYWW648CqeGftHW/4fTumGozZZh63lldBkd
	sdCZbmn7llCe6tsB7Rpt7lXWXwRxlLrSXj0fJXiD8TxY65OZcHvc3HA2EofI
X-Google-Smtp-Source: AGHT+IFTCuhq2fCYXCxDZq74Iv+d2rpYRHCMb2nezO1IGWyCWnAkyPTVrw8P4Mi4rkvIUVFvFcUAjA==
X-Received: by 2002:a05:600c:3b23:b0:413:286c:4fc0 with SMTP id m35-20020a05600c3b2300b00413286c4fc0mr5865563wms.34.1710260813066;
        Tue, 12 Mar 2024 09:26:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c350c00b0041312d21a35sm17702517wmq.7.2024.03.12.09.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 09:26:52 -0700 (PDT)
Message-ID: <pull.1693.git.1710260812280.gitgitgadget@gmail.com>
From: "barroit via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 Mar 2024 16:26:52 +0000
Subject: [PATCH] bugreport.c: fix a crash in `git bugreport` with
 `--no-suffix` option
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
Cc: barroit <barroit@linux.com>,
    Jiamu Sun <barroit@linux.com>

From: Jiamu Sun <barroit@linux.com>

executing `git bugreport --no-suffix` led to a segmentation fault
due to strbuf_addftime() being called with a NULL option_suffix
variable. This occurs because negating the "--[no-]suffix" option
causes the parser to set option_suffix to NULL, which is not
handled prior to calling strbuf_addftime().

Signed-off-by: Jiamu Sun <barroit@linux.com>
---
    bugreport.c: fix a crash in git bugreport with --no-suffix option
    
    executing git bugreport --no-suffix led to a segmentation fault due to
    strbuf_addftime() being called with a NULL option_suffix variable. This
    occurs because negating the "--[no-]suffix" option causes the parser to
    set option_suffix to NULL, which is not handled prior to calling
    strbuf_addftime().

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1693%2Fbarroit%2Ffix-bugreport-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1693/barroit/fix-bugreport-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1693

 builtin/bugreport.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 3106e56a130..32281815b77 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -138,8 +138,11 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	strbuf_complete(&report_path, '/');
 	output_path_len = report_path.len;
 
-	strbuf_addstr(&report_path, "git-bugreport-");
-	strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), 0, 0);
+	strbuf_addstr(&report_path, "git-bugreport");
+	if (option_suffix) {
+		strbuf_addch(&report_path, '-');
+		strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), 0, 0);
+	}
 	strbuf_addstr(&report_path, ".txt");
 
 	switch (safe_create_leading_directories(report_path.buf)) {

base-commit: 945115026aa63df4ab849ab14a04da31623abece
-- 
gitgitgadget
