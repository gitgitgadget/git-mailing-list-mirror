Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910BC2236F0
	for <git@vger.kernel.org>; Sun,  3 May 2026 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777816331; cv=none; b=N0rlSwBSxO8zB/X8f+LaSH6D/QzoTyl5gs3AHTaoFvkU1y/Ci3yShW4u1fDB0QlMoJm7VcOdOq+5Uqga1eclCnT/PPV/tCKI6Igs7p8+hto0J169jVxUoXww9pjrgiROd27WXzuUPfDyCpCh3KKLLNoVQAaCmPui/VYQXCVJ0Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777816331; c=relaxed/simple;
	bh=gdQBlQRGy2tnB+4kkyrYne0maqWIxf/0umEtQlFXGcs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BKnZTWyMYsUE/AN2B+rnF9tz+DCnXGItBQlwMupJALjqGZ3pZZHFpjm6cM5nhL+wRllVFzI4A/UPt1WuflUpGV0m+OqjySAyiK1Mt3IkRlCBmdULcm/gCW0gq1R6d0Z0/cFPrnjrJQQ98RobE8gXiyNhUpNdxvPU7295eKwKtqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcZWO845; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcZWO845"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8ef45a6d9dfso372039385a.0
        for <git@vger.kernel.org>; Sun, 03 May 2026 06:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777816329; x=1778421129; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hB6J7oG/HSWEnLT6qrOfDZQTBxp8sAcezGOhX45EeOs=;
        b=jcZWO845si+8iNSnA9m8H/h5sw2Vv4mDNXMaepXBb4MNvIPoTu63noORrhLBxY0eQ5
         fOcxl622hRP0Zu8snYiw4YULq5Ml+Divt+k4hON/JTFc6fBysKGlKK9u6i0Ao4bWkGSZ
         a1xH2rIZqZrI6MGCOwMJTNF0bwLQ4Sq5OPICPwpv0nBgMpv3BjDywVlbmsQZQyz5HPsj
         HlEFhWX6CTROHjheRfIkAYEjiVSwmiN5HwZDl5bP1pX9crqLpOXG3P9iEH46baDmF2jc
         YfJEbTohWJhNkBSv45MH/U12S7U+yUTwR9XOXK3V5dcOM5XQegb7axZtMhubIc7IbTdP
         yP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777816329; x=1778421129;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hB6J7oG/HSWEnLT6qrOfDZQTBxp8sAcezGOhX45EeOs=;
        b=lDWxBJvVWZTHKFDKHLJCQfLUQex23h4IVwHeGPGvCEU75ku+wNDu0Htsp2edALLqUk
         NZ94HGa1gK3btWUDX/Wh7puOqqJ4PYkKTU+NjHPxz7bh7Wle/5uzXcBRxaYydtDvnQnz
         D6zU2kfak3kqH695c36xNT9RvzsK9bLPpUauN4N574PJ+pbQVnzmqCLemUBfRr1DOJZ0
         UzuJR8ZEZiFl6bbqbjO1zfmFlHvdoqf1pqq6w/drPwv5C3OEkN0I+3aHe4dOOlXHK6Nq
         CpPX2lGYeLdIZv1XbuVkvbin78bHQPGoxiCxux4uNIE2E1hW7kDvjYoBVrqGzs2RPUlT
         ypnw==
X-Gm-Message-State: AOJu0YwRYqbymWrMJZE8CO7Xui6f9rH2L6RY7BB4qezuKgBu7IQ+VK74
	EMgap8d/9iyN/5OWdzYH5gdkx44BmgboTT2X5YZw5eU5trdjGMS5N4wO/CNCWg==
X-Gm-Gg: AeBDievAqEPe30H5NBMsfuo1AC/zsz0nMRW1s9OY/SRFZue12yxTd9H2Nw3YCA+PMIv
	SQt2m6zcHkGZ6Wm5FCvqw2tpu7XTqKjDYZ0msrR/eAQ0uh8heuK6+tBAhm5QBqC57yTnmlJqsIC
	q2vY9UXLpmE50+OTl1ITdY7yC08ML/W+fDU7BpenNcffyOjS+XyaSKiY1caDEzHP4JEVzQ7I0cg
	taSFwU07uHnY6VSq40nyo1JLJo+Lbo5cwEPl+l9lyZjTyciV+vodqmsMFnQo3645ad5yIF9Bi/n
	5Zf+9D086QMd9g2ksp8SweruMGmHM8TxvSFE9aPm6bs7fpPVWjKUPfylL3jijiCIFVZTmeJ18mS
	aYAm1BqmcOWi0RJq2iJ9aqgwHJdqLs3efbm/5lpPB15FcVfu+X5kQNUubVvNxSxxwXwARSrpUgB
	x/cb3nB6oD0A3Eoa6Xf2+ZjvI4Ze5yQitfFbn7cdqgDo/nId0=
X-Received: by 2002:a05:622a:14ca:b0:50d:d1ea:65dd with SMTP id d75a77b69052e-5104be22865mr92863541cf.14.1777816328942;
        Sun, 03 May 2026 06:52:08 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.70.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5391e34dasm99504086d6.14.2026.05.03.06.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 06:52:08 -0700 (PDT)
Message-Id: <pull.2287.v3.git.git.1777816327842.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.v2.git.git.1777809430925.gitgitgadget@gmail.com>
References: <pull.2287.v2.git.git.1777809430925.gitgitgadget@gmail.com>
From: "Saagar Jha via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 May 2026 13:52:07 +0000
Subject: [PATCH v3] submodule-config: fix reading submodule.fetchJobs
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
Cc: Pablo <pabloosabaterr@gmail.com>,
    Saagar Jha <saagar@saagarjha.com>,
    Saagar Jha <saagar@saagarjha.com>

From: Saagar Jha <saagar@saagarjha.com>

update_clone_config_from_gitmodules() passes &max_jobs to
config_from_gitmodules(), but max_jobs is already a pointer. This causes
the config value to be written to the wrong address and get dropped.

Pass max_jobs directly.

Signed-off-by: Saagar Jha <saagar@saagarjha.com>
---
    submodule-config: fix reading submodule.fetchJobs

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2287%2Fsaagarjha%2Fmaint-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2287/saagarjha/maint-v3
Pull-Request: https://github.com/git/git/pull/2287

Range-diff vs v2:

 1:  868901f1a6 ! 1:  70fb2ede0f submodule-config: fix reading submodule.fetchJobs
     @@ Metadata
       ## Commit message ##
          submodule-config: fix reading submodule.fetchJobs
      
     -    The old code accidentally passed &max_jobs rather than max_jobs into
     -    config_from_gitmodules, which caused the setting to be written to the
     -    wrong place and dropped.
     +    update_clone_config_from_gitmodules() passes &max_jobs to
     +    config_from_gitmodules(), but max_jobs is already a pointer. This causes
     +    the config value to be written to the wrong address and get dropped.
     +
     +    Pass max_jobs directly.
      
          Signed-off-by: Saagar Jha <saagar@saagarjha.com>
      


 submodule-config.c          |  2 +-
 t/t7406-submodule-update.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/submodule-config.c b/submodule-config.c
index 1f19fe2077..57b190678e 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -1037,5 +1037,5 @@ static int gitmodules_update_clone_config(const char *var, const char *value,
 
 void update_clone_config_from_gitmodules(int *max_jobs)
 {
-	config_from_gitmodules(gitmodules_update_clone_config, the_repository, &max_jobs);
+	config_from_gitmodules(gitmodules_update_clone_config, the_repository, max_jobs);
 }
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 3adab12091..234a021fb3 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1055,6 +1055,16 @@ test_expect_success 'submodule update can be run in parallel' '
 	)
 '
 
+test_expect_success 'submodule update honors fetch jobs config from .gitmodules' '
+	test_when_finished "rm -rf super3" &&
+	git clone cloned super3 &&
+	(cd super3 &&
+	 git config -f .gitmodules submodule.fetchJobs 67 &&
+	 GIT_TRACE="$(pwd)/trace.out" git submodule update --init &&
+	 grep "67 tasks" trace.out
+	)
+'
+
 test_expect_success 'git clone passes the parallel jobs config on to submodules' '
 	test_when_finished "rm -rf super4" &&
 	GIT_TRACE=$(pwd)/trace.out git clone --recurse-submodules --jobs 7 . super4 &&

base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
gitgitgadget
