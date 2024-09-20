Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA841C6BE
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726863272; cv=none; b=d9oH/UW0JN3huYsFR1sVeHdD4dCJCqiz4sMwLAS0rqtV+sbByvzoSHIdSbKroF+1ua6Zo7758m51qDkpVncE/VY09mpLbtfrsI+bNw5HIjWz5L+QYkUPQmoYUnnElR1YHoNcyL0mNLMZcThIvVuHnyW3/w1Krdn9YRwN6TDWMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726863272; c=relaxed/simple;
	bh=Z16xg8zgr+nfB6BInDZ8/cjZe/1pMe2s5qX2RkNMRkk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VUtFVM+ndyv19WIg0uJ88PDAX2KtiLJIOvLLq7SqRKa8dTDbL4jYe9xJ2susyNYKGEmdZ1sV6+v1kK/Ssh3rhjfmvRl434HGeHzIlTOVmXP6z1WOILJrmfbLyc2fm0+uhBoK9Szb+hbM3tt3V5cpM/iZEDjZlwRiAj48+YuP6LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AK/6ThIg; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK/6ThIg"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7163489149eso1971738a12.1
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726863269; x=1727468069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cRq5j7B5gxet5bKpqav+Dz7/JzI+VLpHeZKcwqi9UTM=;
        b=AK/6ThIg/P2tGU0To/P4YzMP2eAMcgdMSINuharzOvvF3sXNBtC9+q/PqR8HKDCS2/
         rZSNOqfwPKi2HDa/6zAEWc2h1OVzzL7tfjg6BcXtO5w2zPrLOuZqHFwKo3xhI5Ly3PYh
         M63eSVpGbj06evgfpp1MaULdQnYlKQQzamHENcQXwMQJ5frCQbk7WNU3EBRJIJL+7WNs
         +StIN64is7032+sbHNQY2FltwdFfmaAoX/9fi49pXGwdWmdvuPZcMg1iICuhzE/4IPA8
         qAaZaTbB6kx3exiMSiMaWX0X2a4RRioKY9tQMJzVnFG2/Sy/CW33MRfVFbOyzqwLfIWy
         ZQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726863269; x=1727468069;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRq5j7B5gxet5bKpqav+Dz7/JzI+VLpHeZKcwqi9UTM=;
        b=eTkemx42+jNpy8Ei7/CI9MFOQrQrcJIMmqNgN6stMr2DGLRyhkuJucgN703bnv8ubL
         en8ur+0jK+Ibl0Zg8q4f2OEBdu57ZG8S9ej9InT5sMwp3mHhJIVHZPt5DAlla/ZEhE3j
         VN+Il+yzxZbv0gaUVZlhu4CJ9wTVCxPhWGbWrtHe7fhhvsAjJhxSKZ8r+64B1xjuV6Ny
         lafrCznxdwLOX7gd4J0FjmbWXfa0TT8baWmnx2cyjTSGIgADnCdAcXCo/ZmHtq4F2ZqN
         xJqh4drptHtuDh3zwVvMR24brVKkX5kVqqy84Uds1wHiqJDJ5I2lCcGwxTZxKfY/ZOms
         LiNw==
X-Gm-Message-State: AOJu0YwvG63zcbUcMybeQU6sbA9SX5KgEJKs3HSfzBrrq6h27/wgXwMw
	+RUe0Y6gvDqZU2NeSKmusa07uK/lR8DpJ/327my14LV5FcG5S8m3+fd24w==
X-Google-Smtp-Source: AGHT+IG8RENMdmkErNvXH65gI1wuAgh0RAIrLDn838SkTsf/XBPUCuhT1A78ewoIEEhb0+exQ+W7ZA==
X-Received: by 2002:a05:6a21:1698:b0:1d2:e458:4061 with SMTP id adf61e73a8af0-1d30a900c57mr6101449637.15.1726863268686;
        Fri, 20 Sep 2024 13:14:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8e80:3680:29f4:7daa:d86f:fa2f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b13dsm10524139b3a.97.2024.09.20.13.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 13:14:28 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH v2] ci: update FreeBSD image to 13.4
Date: Fri, 20 Sep 2024 13:14:09 -0700
Message-Id: <20240920201409.8723-1-carenas@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Reply-To: 20240920043935.56805-1-carenas@gmail.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

FreeBSD 13.4 was recently released, and that means the version
of the image used by this job (13.2) will be out of support soon.

Update it before the job starts failing because packages are no
longer compatible or the image gets retired by the provider since
it is now EOL.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 .cirrus.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 77346a4929..1fbdc2652b 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -9,7 +9,7 @@ freebsd_task:
     DEFAULT_TEST_TARGET: prove
     DEVELOPER: 1
   freebsd_instance:
-    image_family: freebsd-13-2
+    image_family: freebsd-13-4
     memory: 2G
   install_script:
     pkg install -y gettext gmake perl5
-- 
2.39.5 (Apple Git-154)

