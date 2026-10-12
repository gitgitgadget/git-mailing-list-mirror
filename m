Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F1A4AA569
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827500; cv=none; b=jjvQDM2YIwLVLFTjJrKurdVywZBl4GZLdha3H18iTWa9oNb+s10gq9FLBwAsoK1BtITFDFmL6qFELvHE1xr5fM4pBmyEZxNwjpNoVmgYfetsRV4JkOvJ5YkAzJn4osSqjCkTS7gL/tCM4pX+jWq4skAEuxAENik4SibkNbl2gTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827500; c=relaxed/simple;
	bh=c1lfTljH+hB4mY0S3ciX9vJFQV+nhYlVbDFp9IY1wVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PtgxVVhNLEFp9et7C7RUpk9pm8nZk7ownhy46x/36Wx80i6u8qFphWcwUZN9yT2K+lBYo7AJABikXe3H5sqGs6IS2+wByGJ09MLXuv6j4LizpoT+9GdMl2z5PFz2ScdGbqFxbyE8hjFAz+poueQdHQ2HZG5Je4nJ+YJMWIYaAJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0nUBKWV; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0nUBKWV"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b06c0794cfso16453147b3.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791827497; x=1792432297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JoJ1INxqR0nE87+5zm+PAqRpKfcvmfLc0cK/5Gvp1N4=;
        b=U0nUBKWVg8UISE3/qvipk1VWnzChz+xL5+hU/nEwp8Y5VtksnwjwNhDSlSi7y6WApR
         g9dwf6TfsLTXxa4w5v0J7NFC0O2bt2rlRH5ETVaquoMeQBXG4PnYmm2KY0bMt/HcubmM
         CmacUKikpH7wmnXQ7uFlllKuJdln3th0jAjFgMw2ORVm8U7bc9IQcoWuKFSj+gLhOVKc
         bl+vqKvtIAi+zVHnHSf8Z4FWYCTUXLSvSMVvNeV77GQhz6iDerBhBWBRz9aRR5+CmHbg
         rQ9i8N+7vJ0h/3HK3PkMqbEsDOsGTPXp9ZdhtoBlLngRxqyhihq/jPTH0p8scTxvG0aK
         TgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791827497; x=1792432297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JoJ1INxqR0nE87+5zm+PAqRpKfcvmfLc0cK/5Gvp1N4=;
        b=Ff1G92APWtJhX9GU9SwyfMOgthB088lsegKVVKt62KV6W4hzturS+uWi3zzmpn0cbE
         d/yFmP7M+t5xMuaILahAV06N8k0eXvASVZh/KzIjI6rMveUHRyTDw7zURohzqBrV5PtA
         WM1ftvTZ05Izxq5AhTF/agDsS0SkLB0Oy20LdFfvuSm+BHlr3wzMuKJ7YL7PkA0nv5B8
         eRZnWPTUmArSGHHeFiA5u1QknJAhCBXgMRXxK+Gp6jAEz97WM+ijzuYTNS0gCKSuYTpC
         BTgqStkH/yOyHYh2cX2jspUD3FYJBi39frDXXVUSNilg1Andp0/QiouC3JhT0qlZUtDC
         ZCgQ==
X-Gm-Message-State: AFq9FYLNSX7U5dUwwNEPQiLyuRI8MeTG15zUcIHwzFQ4sge+SYYzsGWo
	jOB85WmS4Pb0C+cQ17f1nGvZmNyYIC/SE1pdZNbhaXfImMJg1X3dTpW2jFbQc6GC
X-Gm-Gg: AYBFou2NemVyYD5ga7a43adP7kXTKOEQauouZ66iZhs5zZ+KkEhVKqGeRiuseXk/Hmw
	jFO/0KukPhyZuMEASYfOYr25Q/7pcD2A8ptnQHUd/RzRl0ClRXxf0CXLot+X1zOssFoC7NtKeG/
	PmK1NT5HZKEhU9Trg0mwBhsKbtdTiLWnYWS2gYgnU+vAkTMy5KNDyMSjWYt4XtsczHB6JQHrVCq
	a9MXolUBdPeTlYgV1xQPSBEWVD/GAc8MdDRnFWxEXN5Tg6z08GBgU8wHJWLhMqTaKu7Wn+xAmuo
	PLWHI71WU79ofhn+F1EnL9cx98ogqamIFynwTSmjLLDigt0lbcdyuVBOgzHHSHoqI101CO4sqIp
	nK0QGhkeW7ZWPBcbyScukW+nmoDFyGpx6gYg7u4XTWkPZuhdgxhY9wmOTMY7xMqwEGzD8dhEbzD
	2A1lOCYYxGs3BUFC1xOLY4j5qht5HSxFefqHCA89DIDu4X43X8FjgIpzPCw8VuaxLjpxGtQ+XD8
	aOOnTUJCS42G4pb9JUVn7cj7lFXymO6svyHL1M9Vq3cXtjCXHYl6iGTe3/Hd6+g9wrmNrNl2x6i
	HUzJiHmqqcouJ37FeIHSvg==
X-Received: by 2002:a05:690c:289:b0:8b0:9e27:fcd0 with SMTP id 00721157ae682-8b09e27fd6dmr19895767b3.21.1791827496732;
        Mon, 12 Oct 2026 10:51:36 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07ee8603fsm36797127b3.4.2026.10.12.10.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:51:35 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH 5/5] completion: drop "stash save" completion altogether
Date: Mon, 12 Oct 2026 13:48:31 -0400
Message-ID: <4d228e79bb23c6c4a9b2996a3c8cf55efdeda7c0.1791827304.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.184.g5a00b4a6e9.dirty
In-Reply-To: <cover.1791827304.git.ben.knoble@gmail.com>
References: <cover.1791827304.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's been deprecated since fd2ebf14db (stash: mark "git stash save"
deprecated in the man page, 2017-10-22) and the previous commit removed
further documentation suggesting to use it.

Since we recommend push instead, stop completing for "save" and remove a
special case in completion code.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 contrib/completion/git-completion.bash | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 697fef5462..9cd9c7cadb 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3558,16 +3558,13 @@ _git_stash ()
 	__git_resolve_builtins stash
 
 	subcommands="$___git_resolved_builtins"
-	subcommand="$(__git_find_on_cmdline "$subcommands save")"
+	subcommand="$(__git_find_on_cmdline "$subcommands")"
 
 	if [ -z "$subcommand" ]; then
 		case "$((cword - __git_cmd_idx)),$cur" in
 		*,--*)
 			__gitcomp_builtin stash_push
 			;;
-		1,sa*)
-			__gitcomp "save"
-			;;
 		1,*)
 			__gitcomp "$subcommands"
 			;;
-- 
2.56.0.184.g5a00b4a6e9.dirty

