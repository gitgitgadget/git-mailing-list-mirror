Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CDB2F2A
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 00:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734482339; cv=none; b=EtPH0wnQdy4pIOg9IzaIUrlUriQyXrJhAWB9LrT1YoAjcVrmFeWworEth7oaPUH4t77DavLbfIzOxJ7wP0cnktsmeMz5Eu4RFQwmXmT/7TS90605J40KdnB5AscR/eH7uMsI098O8BLAVvMvHjiCQ+h2Fs8mavDlE1pUn4b8jrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734482339; c=relaxed/simple;
	bh=lMNqngZrZgxgkoFMGeQd/5kV63g0T69oP31W9mMlEBc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eJG8DIeyBANZbT3XkJTP6O5YsioZGsFSiEGehsmLN6qoJ4AzoQPEmzBScwrFIwosjvh3quCdSRYLGlzIcAh/ojsqhYbBMcjl8hlDqY+vDFZLYWOk8YtXqLWHyliMjKYME/NyhFt9pPBUV0BJPniz5c2tHLdg2A0zkLHWfWaJ6gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joUAkB08; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joUAkB08"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43634b570c1so30064565e9.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 16:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734482336; x=1735087136; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=li4F0fbOdMdkSDJENB3acYzHUrR+ldNIevBYSeVMIz0=;
        b=joUAkB08f/TVESyV7URs+a/eO4wmm0giOv52H3lQCd167oauVOFe2mNzdT+7rc44wO
         KZILEv/81I9O7Ffa5GpSMDT4lV9pvmUpNQVNtp9KJsJlHEGUFQNBOhLP0WxNa/CYMW+9
         BiKrpcePrvVSHlOchXiPOJLYuGyEV0mKM34RL/zC0c+VgrH9hvj8x5H4fcoU39xMgDDa
         +RHo8QYp1Q9vuYbzsNAaiRPwtxw8KhuXxj/GQtLJ1oyn6ydhtneAnl7Gnljj1OnA+nBP
         9AQQTTIL1geMVH798r23QCn/7CCM7daBgVPS7OXd0ygGV22c6uQuId1CRM2S/u9oFSiV
         o2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734482336; x=1735087136;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=li4F0fbOdMdkSDJENB3acYzHUrR+ldNIevBYSeVMIz0=;
        b=B8RKeVUoairRGum2bYOa5KxNYn+Lv5onoSjsGuofcW1DA3YpTzZ2TnJ9RsIbBG8A7z
         nCpKeC+4iOe27hl84Ksvm19OEMkXHDkr6FwsjGKfNa5HtDe9jodSw5tctR0IUfUbMx0+
         He9moIdbpeWdq8GfxcEB4rmeoP7qW2udDPue/TrMzwimLLRn9BxdlqCPHbC3uS/MVlqX
         Mx8JK9NvDjxe4lthLdd8906JRObdMuhpQHIzwF7KHOfYCMs4t2pq3A+0WPj9nSIURTam
         NDvO6cXv5JwtPoffK31ynKyxBm5Yc/QGc8Qej/ed7kfC5pHHtSjQ9FqLb+gkZccy1kVT
         jumQ==
X-Gm-Message-State: AOJu0YwtH4aAJtkc2MnQTaCt6KH2ZwxE6UEnt4NfLlZwOrhlFKN2lcca
	/ybTKLXdUEbEplNuAAEl+sYJv3gXrSdYJX4+afaawXz6Vtfwh3vnDgwmgg==
X-Gm-Gg: ASbGncu5fHnUAv4n5EylckKG9mLFWJV1Ilq0Nuti92md7HNXxFRJtKYN8S+2+Czt2rF
	vRya217j+x1dw3c6Fpzna9XBgh8YIVLJW8KcNPskkleeFeYkA5mKKGhAYm0QmKiSskm8jQZ5Ejy
	U/GUnVc9nEwS45piYRc5HuRf973eOO1KzlwW/B2YqkmJCUoOu2F0G+wWWS2i7c1OH2lXjihKkAg
	uQ2e0iqhNug0MHC5GGLtQX15IOCgKp3N1h8/GSZpsipZK7IjiDweEnmGA==
X-Google-Smtp-Source: AGHT+IGQ0TMmwmukDxu62JYnk/3uhuRTmkr971IZh+LPlDSuToES7TpT7k29jeX80Jg62ZQo3FfYog==
X-Received: by 2002:a05:600c:190f:b0:434:9e1d:7626 with SMTP id 5b1f17b1804b1-436553f4992mr4436825e9.25.1734482335680;
        Tue, 17 Dec 2024 16:38:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b12399sm2631995e9.20.2024.12.17.16.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:38:55 -0800 (PST)
Message-Id: <pull.1432.v2.git.git.1734482334390.gitgitgadget@gmail.com>
In-Reply-To: <pull.1432.git.git.1673290620410.gitgitgadget@gmail.com>
References: <pull.1432.git.git.1673290620410.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 00:38:54 +0000
Subject: [PATCH v2] git: replace two checks with one not equal check
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
Cc: AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

(version < 2 || version > 2) looks silly
considering this is an integer.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    git: replace two checks with one not equal check
    
    (version < 2 || version > 2) looks silly considering this is an integer.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1432%2FAreaZR%2Fversion-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1432/AreaZR/version-v2
Pull-Request: https://github.com/git/git/pull/1432

Range-diff vs v1:

 1:  e9172aea097 ! 1:  07e0d614c21 git: replace two checks with one not equal check
     @@ Commit message
          Signed-off-by: Seija Kijin <doremylover123@gmail.com>
      
       ## builtin/show-index.c ##
     -@@ builtin/show-index.c: int cmd_show_index(int argc, const char **argv, const char *prefix)
     +@@ builtin/show-index.c: int cmd_show_index(int argc,
       		die("unable to read header");
       	if (top_index[0] == htonl(PACK_IDX_SIGNATURE)) {
       		version = ntohl(top_index[1]);


 builtin/show-index.c | 2 +-
 packfile.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/show-index.c b/builtin/show-index.c
index f164c01bbea..5fb71a1c425 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -44,7 +44,7 @@ int cmd_show_index(int argc,
 		die("unable to read header");
 	if (top_index[0] == htonl(PACK_IDX_SIGNATURE)) {
 		version = ntohl(top_index[1]);
-		if (version < 2 || version > 2)
+		if (version != 2)
 			die("unknown index version");
 		if (fread(top_index, 256 * 4, 1, stdin) != 1)
 			die("unable to read index");
diff --git a/packfile.c b/packfile.c
index 9c4bd81a8c7..de0662b2353 100644
--- a/packfile.c
+++ b/packfile.c
@@ -114,7 +114,7 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 
 	if (hdr->idx_signature == htonl(PACK_IDX_SIGNATURE)) {
 		version = ntohl(hdr->idx_version);
-		if (version < 2 || version > 2)
+		if (version != 2)
 			return error("index file %s is version %"PRIu32
 				     " and is not supported by this binary"
 				     " (try upgrading GIT to a newer version)",

base-commit: 063bcebf0c917140ca0e705cbe0fdea127e90086
-- 
gitgitgadget
