Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733E6256A
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709015584; cv=none; b=iwNiApNoCIOeg9AfSM03a2vcEACxFP6XhbQ+ggu8fcGJVziSmM9mH3/8yoHLg7ABt0LyhuijrY5a9c8g9aDMX3fJA5SONlXLZxMyn+x2DrgFw/Cbrn5HmaJXg3OlXlIjzie6nlbc2h2cffJGXIsdNY5qXDTrC5IjRMmblmolH4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709015584; c=relaxed/simple;
	bh=f0lkUbb4JzzmuUSM0DKaptbVfsjIqLNrL4WbVFIUqu0=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=lMjOVR1ht8IHH6uY5t+1apSfRaVfk582If9qsWJ5fGTfFGFQqWst/a3gUIrWTfrgAoFP0YbmLL3dILNIJWmohL3c7omECj6gAEfVugV0di8tg5gad3TgoCEbe7DnYzUdv0/S+t9QDWLlDbwwh7YF79jT6WAWnuWiaDqYdaLRc5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHJfmgrk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHJfmgrk"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412a80d7f42so8966475e9.0
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 22:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709015580; x=1709620380; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wcZ+3OhlOctBIjxOoe4a0DcYY249/eV8rQ9lvRb32RI=;
        b=YHJfmgrkJcNaluuCqoIVU9gya+m1hq3PywmNtw8V440E+YxIOHCwfhvNNgzPF/8E3A
         FGiy1h+mIFEc8xA1LnGcT9c+49ia+33tZyFhXAZMd7n17FXJbvoQfn0YTxTGcHP8e6A5
         LLK4k5kjplqgwe5p2ACiqrcH+YHXCuhbTiOta+q6XRoE/PgU2NkOWGvSslNZ6La6bgQB
         K73BB5UPqjoVNsprd8aQ9YGyosWzgEW7eVxs8tmcOddXtkhGU5lzmQjJXwAdoyjO0kY3
         4kq9d+qGfhkRbguHP+gBBzPq7wLkGV0HLpYiTuiS/+b/JOJVKTHKTUJmNncQqt/YEUU3
         UXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709015580; x=1709620380;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcZ+3OhlOctBIjxOoe4a0DcYY249/eV8rQ9lvRb32RI=;
        b=dPPXSfVfDMV6wXT/rYwS52VsQydX4XDr9oohoQeudwtX2UhVrgIDRQGrWncaokBu9K
         P38JDNPxU1vOL5Eqy9pjQzk0UXZrJz+YpLv4KKeQ8/qjaqW2vN+JzHsoW0m6B9u+jHmb
         l8/jaLuswWQh/Xphs1CL2w5YAntiPrn6ilb0YA9GeVDSy8RM7dwyPMM+lee613+yJ8n8
         5aTcaJ6cOznu5RSR2p69eOGBCtFZmJ8jO3LxQ/nZ9SHhfEa9DCP1OM23twVbc3vUfx1y
         LjvJX9v3LKHO9ck+vTtzmPK5tGiBuZqCHRl75wY7U2RxobPyfIkmysDxVlVF/MifLeRy
         c9xw==
X-Gm-Message-State: AOJu0YygN51t2piBJINv3o9hzqMGgV5GL0Iwfev/IFG9AQzh3I3qzOfQ
	aK14cTUNQOf3C84Q2hyfOePqZbW9NtN6igjOtPRUMQKWx7Th1/272Az+lvyN
X-Google-Smtp-Source: AGHT+IHBsZ/ORCjerDVWILf23sxb4aurfxt6sKdxgd5/8p9Dvfxtt3lmhhxs5ZhM5Ldv0ZHfBc17ZA==
X-Received: by 2002:a05:6000:542:b0:33d:222d:f380 with SMTP id b2-20020a056000054200b0033d222df380mr5943624wrf.0.1709015579877;
        Mon, 26 Feb 2024 22:32:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14-20020adff98e000000b0033cf60e268fsm10327580wrr.116.2024.02.26.22.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 22:32:59 -0800 (PST)
Message-ID: <pull.1676.git.1709015578890.gitgitgadget@gmail.com>
From: "Richard Macklin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Feb 2024 06:32:58 +0000
Subject: [PATCH] rebase: fix typo in autosquash documentation
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
Cc: Richard Macklin <code@rmacklin.dev>,
    Richard Macklin <code@rmacklin.dev>

From: Richard Macklin <code@rmacklin.dev>

This is a minor follow-up to cb00f524df (rebase: rewrite
--(no-)autosquash documentation, 2023-11-14) to fix a typo introduced in
that commit.

Signed-off-by: Richard Macklin <code@rmacklin.dev>
---
    rebase: fix typo in autosquash documentation

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1676%2Frmacklin%2Ffix-typo-in-rebase-documentation-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1676/rmacklin/fix-typo-in-rebase-documentation-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1676

 Documentation/git-rebase.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 06206521fc3..e7e725044db 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -607,7 +607,7 @@ The recommended way to create commits with squash markers is by using the
 linkgit:git-commit[1], which take the target commit as an argument and
 automatically fill in the subject line of the new commit from that.
 +
-Settting configuration variable `rebase.autoSquash` to true enables
+Setting configuration variable `rebase.autoSquash` to true enables
 auto-squashing by default for interactive rebase.  The `--no-autosquash`
 option can be used to override that setting.
 +

base-commit: 3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0
-- 
gitgitgadget
