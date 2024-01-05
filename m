Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F525234
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 00:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcQMC0jx"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28cf491b197so639218a91.1
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 16:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704415432; x=1705020232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHWUYviedtKd/IU95qogPu7Vl3ptEuEtNB/M1RwKSFg=;
        b=VcQMC0jxE8XQt+CbamdBXlPtn2sDM1OU/xjxiPum9Dc4Do6j9xK0F9cBNXAVTv5anv
         4EJqesaU2wrup/43YELETuJCa9LkWc611MgkLV2EpaUKPZcXa4JusFtK9MGCMJe9pDN0
         9Vmx45TmCtq8DCV9DQBZ2wQQ+hy5PsRFnUi299xk9bgVWaY2nFlPH8K2ZPjJ+Q+581LU
         QhC523h1dDb/hpKP3kuaX76rCvbcFtVmjRkr3KA2OEFjoNYxS9XUk7UnYDx4GmhRAyOB
         Qoy8oR8okQUT/fKTcLGw730JIFsoJ4AqM11bv3GDv7wENyx0ZFkUuaTNkb/e23qvi6HW
         ENVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704415432; x=1705020232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHWUYviedtKd/IU95qogPu7Vl3ptEuEtNB/M1RwKSFg=;
        b=rk3xjjktp6oPYnuAW9KjY+ldfz/aW8gVsm49Z/Ab3EG7oaEWYjXFvkhTbvARnOvLW5
         HUx/sTrhgVAw/NkGtW5FCL9gcmwn6WROa+oiUskcKh4g3I7cCm3O3wjG2wgu1hlb0u8N
         B96sWv+ho8Q43lC+O+rP4g8KMOgeJrQ4r1DberkJVswKelotJrBRl2HY6Vs/xKETBjPp
         X9nRfkdazcMS/wJqTwpzejik0u6GjpGVhG3ocefFoT9TC8mxtfm14YPPe9ZshhNvRNDX
         XTdLG83NaSH1GkrQJV+vEFOLJb8yKOdS7Ec7Ps+McrchbAfuEZCmmTolvyHc1Csjvkff
         Vy/w==
X-Gm-Message-State: AOJu0YwS1c9InKRKl794zwf5Z9ofSZLv+MPcCKZdVR/Cd1PYo+exZ/DU
	caN8EyrnYVA2FUT/sxYKth2FIvA1hJc9JQ==
X-Google-Smtp-Source: AGHT+IFnUnIUJ6i0g2eSCTyukCyB/ItuJ20gH323pe5cCUlyZ+WbijmveUP3L3KN4CnvGscCBnrCBQ==
X-Received: by 2002:a17:90a:4bce:b0:28c:2e1f:8bf2 with SMTP id u14-20020a17090a4bce00b0028c2e1f8bf2mr1290516pjl.84.1704415432176;
        Thu, 04 Jan 2024 16:43:52 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:c2a2:6c8a:c793:9aa0])
        by smtp.gmail.com with ESMTPSA id x12-20020a17090a9dcc00b00286920600a9sm4303636pjv.32.2024.01.04.16.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 16:43:51 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,
	Illia Bobyr <illia.bobyr@gmail.com>
Subject: [PATCH v2] rebase: clarify --reschedule-failed-exec default
Date: Thu,  4 Jan 2024 16:42:46 -0800
Message-Id: <20240105004246.1317445-2-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240105004246.1317445-1-illia.bobyr@gmail.com>
References: <ZZcE/Kw24YKlqSOT@nand.local> <20240104080631.3666413-1-illia.bobyr@gmail.com>
 <20240105004246.1317445-1-illia.bobyr@gmail.com>
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
index 1dd65..45d3c 100644
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
+rebase --continue` is invoked. Currently, you can not, pass
+`--[no-]reschedule-failed-exec` to `git rebase --continue`.
 
 --update-refs::
 --no-update-refs::
-- 
2.40.1

