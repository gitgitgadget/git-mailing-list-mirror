Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425FF5381B
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559160; cv=none; b=IMylOe3DwYQ1qBHAXZHApH9mLlMWxw4IQfau/s0R8II48cnVwuAdJw4L5Vr8uaokyeokvLHJfU76fDmyE8ycqXohQwuLUkQebfMNhAIQIaq4IqgoDkcNKidrHczVBMZaSmBpUMo5a5imnx0JBn3VZT8Lsgd5jIaTx2nGDTqsUtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559160; c=relaxed/simple;
	bh=VtzPPf5aRoz0dUv06zmMVi8QOWKxlFRh1mwGWJYca4g=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=KHs94EAGHisQ9XIiRM6NMsa45p+ZYXGIAlCpgI8jWeJ5nt308LwWND4simzypWIw5WtnguOfijIsFLTpY4fscWjbtS4jT4x/gedWykgvZdtXtzIg81+GvIks/M+ji2Q7cU7A3svuqyfaYTzXRIibA2omiOyw49rBWg9DAXQwE6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfkSUldn; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfkSUldn"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bf01bdaff0so1241177a12.3
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725559156; x=1726163956; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c9vw2KbRrdWLKdMyUO6MelXj2ZZPLVfCfcuu9YzGrgU=;
        b=PfkSUldnm+7DYGMeewwjxuGzxaCFzCJx9ABYp6cWOy76LYR2OjkSfL5AhHX1mnTI6f
         pPrADUPAyQ+BE8FpnKGynzjo3jHJ3QpbNGF7GoKS32wTj5Aq4fRb2CDhSjlDB40BYM9V
         4Mn/b+3EFVHaGVEAUndtoc7e+qbPKB5ZU/tKjJ7UqGpViGH+XJ9o8aUzrtkqcRz7Ydg2
         xnRgoi5ZX9d1vdFYZwWOH53LHphFgGT3iw8ZqtNXFHie7Om7qJjZWI8WUBCBd8YphCBW
         pGAcQUoKg3Z8i2FQ2L3O4tz1+hrFGuu8CQ23oPhHF9Nw+z8pTTfsCbNMsA1kSmGW6vMs
         SchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725559156; x=1726163956;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9vw2KbRrdWLKdMyUO6MelXj2ZZPLVfCfcuu9YzGrgU=;
        b=r8bBNw/NjFGGoA7vSrKKVXoPDY6AbVzrhgVfpPHPsAvTvkX3fI5/R9ppkG0FPFHavY
         g6zIMSZoS2EpQ1k8b2aYVW8VwMD9gXT3qXrbnYmIvudIcxJfwaRuITKBIWIMVp4rqYZc
         jYVr2azFZj+7nJhZJv4v2v2xK++BewYbPwcHPHuA2mWFJ1Cg/WktCVGNUkG9+KgM2PS4
         AX82owP3/vQC58tcnprp53N5zh98dot3TtB5rRlkVc+NVAPKDMGBg81o8p2cZqGkrVGd
         +HTxFiRsdBgEOHhlINYz72EA8U5g2vhIpvdGp6D9MnbanuiLftx8gqxct7I4QNT5oNAO
         6E0w==
X-Gm-Message-State: AOJu0YzbFwDGth7w+fKCWsz+sHvwN+eICcoL6hM/nlSToME1vUQxidKL
	LT4pybz/Q0wdnm3Qb5HgPJLP/eg44jwr7J39joEOcxGIyQK9jsUrQQH+Aw==
X-Google-Smtp-Source: AGHT+IGzTxUwPf8LwMbUWK7Pp5YNMwCcnIg8TTRHMRfJqpVuVS6Y+9tkZcU7VeiYiWflmVC17PSLYQ==
X-Received: by 2002:a17:907:7dac:b0:a7d:c148:ec85 with SMTP id a640c23a62f3a-a897fad50afmr1614035866b.62.1725559155434;
        Thu, 05 Sep 2024 10:59:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a620525b4sm165647866b.85.2024.09.05.10.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 10:59:15 -0700 (PDT)
Message-Id: <pull.1781.git.1725559154387.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Sep 2024 17:59:14 +0000
Subject: [PATCH] advice: recommend GIT_ADVICE=0 for tools
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
Cc: gitster@pobox.com,
    Johannes.Schindelin@gmx.de,
    ps@pks.im,
    james@jamesliu.io,
    Jeff King <peff@peff.net>,
    Gabor Gombas <gombasgg@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The GIT_ADVICE environment variable was added implicitly in b79deeb5544
(advice: add --no-advice global option, 2024-05-03) but was not
documented. Add documentation to show that it is an option for tools
that want to disable these messages. Make note that while the
--no-advice option exists, older Git versions will fail to parse that
option. The environment variable presents a way to change the behavior
of Git versions that understand it without disrupting older versions.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    advice: recommend GIT_ADVICE=0 for tools
    
    I'm finally getting around to this doc update that I promised [1] a few
    weeks ago.
    
    [1]
    https://lore.kernel.org/git/e90949ed-8065-4498-9ddb-3d5c6afa7b35@gmail.com/
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1781%2Fderrickstolee%2Fadvice-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1781/derrickstolee/advice-docs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1781

 Documentation/config/advice.txt | 10 +++++++---
 Documentation/git.txt           | 11 +++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 0ba89898207..c05f42c27c8 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -1,8 +1,12 @@
 advice.*::
 	These variables control various optional help messages designed to
-	aid new users.  When left unconfigured, Git will give the message
-	alongside instructions on how to squelch it.  You can tell Git
-	that you do not need the help message by setting these to `false`:
+	aid new users. These are output to `stderr` by default as they are
+	intended to help human readers. Tools that execute Git as a subprocess
+	can disable these messages by setting `GIT_ACVICE=0` in the environment.
++
+When left unconfigured, Git will give the message alongside instructions on how
+to squelch it.  You can tell Git that you do not need the help message by
+setting these to `false`:
 +
 --
 	addEmbeddedRepo::
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 4489e2297a3..d15a8697625 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1027,6 +1027,17 @@ standard output.
 	adequate and support for it is likely to be removed in the
 	foreseeable future (along with the variable).
 
+`GIT_ADVICE`::
+	If set to `0`, then disable all advice messages. These messages are
+	intended to provide hints to human users that may help them get out of
+	problematic situations or take advantage of new features. Users can
+	disable individual messages using the `advice.*` config keys. These
+	messages may be disruptive to tools that execute Git processes, so this
+	variable is available to disable the messages. (The `--no-advice`
+	global option is also available, but old Git versions may fail when
+	this option is not understood. The environment variable will be ignored
+	by Git versions that do not understand it.)
+
 Discussion[[Discussion]]
 ------------------------
 

base-commit: 2e7b89e038c0c888acf61f1b4ee5a43d4dd5e94c
-- 
gitgitgadget
