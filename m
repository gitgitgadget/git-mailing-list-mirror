Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B07E17CA
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 01:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYcjrNX4"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so83814b3a.1
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 17:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704417322; x=1705022122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5EH92d/9dEb91KNQCX1eR51W/hwVYcKE9Y4SZaaawg=;
        b=OYcjrNX4OKHX1DDi5lHxeATSZ4ABLOWjo9/5M6hsKNtN46Gr8yWw1MRguZJ/OMH45F
         OEW2Vt0M51lqBnLOQhRrorBE55VoRsXy4gKXUs5MTsGGpWyP/rQkOFMkKezuMoe1+4Cu
         DWScFLOw0c6qLDo3K2rC7y8pyfr59TDI0Gp9CDdWACBpUENjNLfYEZB51pOfPUFX2i0L
         x5zVAVKVxnAEEWamWrmwl+YHdqe6XvszxF2VdmcKPyoAvxArxeIQCB10+y6Do+tcH49U
         dWKflx8tALVr3SXrhuIw24l/sgm5EM6fjxMCPwlTBdMUJ9eTeZMCFjKbG0iqisj3lzjN
         8nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704417322; x=1705022122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5EH92d/9dEb91KNQCX1eR51W/hwVYcKE9Y4SZaaawg=;
        b=rGzdHgoNYXAB0nu/ZmFQaGCPSnZDIhZIT1Grni+MGzLl9mV1WkYdOrzEw/mrMVoHLK
         vOp0/gflYIUHVnyDu/Lhok9+ffODfDH5HupE2UgP7Y6NXiGTTBXCGAR3dB+7biUStSyE
         J4r9OCHs+VL2/LBgh0MQzx2yMCaTSCsvS3Xb/sftYGFcbkKsVtyMcKVe4Q1A/f2WAkjW
         cJwq2j+ppBbjpQu9g/E1mGzI5wUhhxT9XL8/u5W4i8OJOTm/4vM/Hh0hWuIPMZ6F9ynf
         uvUzBl1xzAlVpGLyb8XywfVWmsnoAC58D/Cz0KYx7GX63oGe9PkWGrkTSHoJ5yvcY6Cn
         q7Pg==
X-Gm-Message-State: AOJu0YwQDzE60k/HtZ892/+RiAYA8CLJ9Qz/YobDJ4khcDoopR3bNOta
	N/v4My9OQleQXcvvbovUkFlV2lt4hW0dMg==
X-Google-Smtp-Source: AGHT+IFMGL+D3tQEC2q2w4E3+cwTRdRtp6ntqHzGTcnIniNx00/pBmA0HHkDEW6hONh9olX87s+Thw==
X-Received: by 2002:a05:6a00:9395:b0:6d9:93d7:478 with SMTP id ka21-20020a056a00939500b006d993d70478mr1691588pfb.34.1704417322027;
        Thu, 04 Jan 2024 17:15:22 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:c2a2:6c8a:c793:9aa0])
        by smtp.gmail.com with ESMTPSA id h24-20020aa786d8000000b006d9af7f09easm276194pfo.29.2024.01.04.17.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 17:15:21 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,
	Illia Bobyr <illia.bobyr@gmail.com>
Subject: [PATCH v3] rebase: clarify --reschedule-failed-exec default
Date: Thu,  4 Jan 2024 17:14:26 -0800
Message-Id: <20240105011424.1443732-2-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ZZcE/Kw24YKlqSOT@nand.local>
References: <20240104080631.3666413-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation should mention the default behavior.

It is better to explain the persistent nature of the
--reschedule-failed-exec flag from the user standpoint, rather than from
the implementation standpoint.

Signed-off-by: Illia Bobyr <illia.bobyr@gmail.com>
---
 Documentation/git-rebase.txt | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git Documentation/git-rebase.txt Documentation/git-rebase.txt
index 1dd65..b6282 100644
--- Documentation/git-rebase.txt
+++ Documentation/git-rebase.txt
@@ -626,13 +626,16 @@ See also INCOMPATIBLE OPTIONS below.
 	Automatically reschedule `exec` commands that failed. This only makes
 	sense in interactive mode (or when an `--exec` option was provided).
 +
-Even though this option applies once a rebase is started, it's set for
-the whole rebase at the start based on either the
-`rebase.rescheduleFailedExec` configuration (see linkgit:git-config[1]
-or "CONFIGURATION" below) or whether this option is
-provided. Otherwise an explicit `--no-reschedule-failed-exec` at the
-start would be overridden by the presence of
-`rebase.rescheduleFailedExec=true` configuration.
+This option applies once a rebase is started. It is preserved for the whole
+rebase based on, in order, the command line option provided to the initial `git
+rebase`, the `rebase.rescheduleFailedExec` configuration (see
+linkgit:git-config[1] or "CONFIGURATION" below), or it defaults to false.
++
+Recording this option for the whole rebase is a convenience feature. Otherwise
+an explicit `--no-reschedule-failed-exec` at the start would be overridden by
+the presence of a `rebase.rescheduleFailedExec=true` configuration when `git
+rebase --continue` is invoked. Currently, you cannot pass
+`--[no-]reschedule-failed-exec` to `git rebase --continue`.
 
 --update-refs::
 --no-update-refs::
-- 
2.40.1

