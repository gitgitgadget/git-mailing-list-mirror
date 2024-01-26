Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4141B7E5
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706273611; cv=none; b=Znph3HKxgaM4+CHttT6O1Ls2VJiIPW3jJ/g+zm7g5T3p1/RTGuVsGT+V/Tg5e6l5GHNGAwiZs52VaZSC9a/276v2jvbS8U2R4qp05pXQjyubdqLt9JwkORw2QOdvTyhtV+8blZRu8ire3dDN2bMOOHbzZ8JYhXkGJp4ABpH2IU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706273611; c=relaxed/simple;
	bh=F6GH+jz8q2fksQP8UgA7+8VtDzqLwQJz+PtCp31EtMk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Aa3XCm76ut/8AfWx4fHgUvL8VFV42x+R+Y4NSBdAKH6z8v7ni+mWlowXtXZnjkYb/UpW4la6KFOBSM+oDfLgQ3SzQ2nRKRVR4bWUBKJx1C/lykIUN1OnAIetyMRBd6j3JPVlYwauVLWy12cvSxWoV/rMen1nqqobtGeoFvgWj5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj1A5qUS; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj1A5qUS"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ade052953so224656f8f.1
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 04:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706273608; x=1706878408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G7BZyHaahLPTuros5zaVvI85PZTPdM+woCXvZteLJVY=;
        b=Wj1A5qUSyga+ut0YwYkwi8kcIfOk5yRb2f7OJZQDVpIAo24DT/+pfKqG0T5RzcBQAQ
         6zTIjPrOyxEj3V02+Rs6E0fLAFYVMsgYgveCpXzclP+TiX8zfdgYvEJgdOb7tVnylPNc
         Ehi2fEmWFGtSGtNPwLvoRpzXIQIhFuDY7iSQnH9pFReEoPTg8I2asCMFzydyefoJC6tE
         nHxZdf/qWsYC8nINq+pEKREo49hvD8i0FjwewTBKegHRajvW1r3arF7KOY1hiz98HhQC
         VlaYaFGxM96qJfwJyk6lyUfTYCAbRcQnkJqNFgOYS9VPQZbe64uICyIhWvo5R9G2mafx
         LvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706273608; x=1706878408;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7BZyHaahLPTuros5zaVvI85PZTPdM+woCXvZteLJVY=;
        b=WrDkrYJ6owtwPk0RifeogDkB5Jwiclpde15jcFgTwEV2nqHgFUu761b5TriVcKP+Gx
         Jq8YDyIzs8U6QfHKXfsu9ld2jEMz5dJDuEaeSWUCJWkICtT88MBzHDBXHbg5bWFCMAOz
         PTeigph67UKb+nTbRkFo4qX05D4QMyUDcXCLi2jxwkYHOi29uCH7OiirdcuAbP27C6z/
         7FRL+KVxOXedknM5hED5kYbJA+SHCzpH0sam/vbJAO6euJlRcr1L+s4H9TWQtxciX0Rj
         fa0Zzr/X98ve4Hlv2BkL4+WvCqFdvLpS3xS3/zB7ha6crZI6+WnAve5VLFSv0agcFnBB
         8Cxw==
X-Gm-Message-State: AOJu0Yy9HkMx15xuW/I34Uu8XJF8hXGsO+Vj8TMwVOxOy2Qs87nqWayb
	uOTDtbBXAI89CacyHp4BPkn+Mhu41uq5Xf9PIVWG7o5aeY+l41zg792ya7gl
X-Google-Smtp-Source: AGHT+IE5IgunkH/Fbg6y8+gIQmqWwa1DcUtU++MpJzwz+KnGU3FhBd0iLqWdI8tDA5M/I0xGv2+gCg==
X-Received: by 2002:adf:f284:0:b0:337:c7f2:850f with SMTP id k4-20020adff284000000b00337c7f2850fmr822839wro.53.1706273608492;
        Fri, 26 Jan 2024 04:53:28 -0800 (PST)
Received: from gmail.com (77.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.77])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4806000000b003392ae3aee8sm1207551wrq.97.2024.01.26.04.53.24
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 04:53:28 -0800 (PST)
Message-ID: <42861028-3ffa-40e2-bb97-a54cfc11ddcc@gmail.com>
Date: Fri, 26 Jan 2024 13:53:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/4] completion: reflog show <log-options>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
In-Reply-To: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Let's add completion for <log-options> in "reflog show" so that the user
can easily discover uses like:

   $ git reflog --since=1.day.ago

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 contrib/completion/git-completion.bash | 13 ++++++++++++-
 t/t9902-completion.sh                  |  5 ++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c41f25aa80..3deb98389c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2447,12 +2447,23 @@ _git_rebase ()
 
 _git_reflog ()
 {
-	local subcommands="show delete expire"
+	local subcommand subcommands="show delete expire"
 
 	if __gitcomp_subcommand "$subcommands"; then
 		return
 	fi
 
+	subcommand="$(__git_find_subcommand "$subcommands" "show")"
+
+	case "$subcommand,$cur" in
+	show,--*)
+		__gitcomp "
+			$__git_log_common_options
+			"
+		return
+		;;
+	esac
+
 	__git_complete_refs
 }
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 231e17f378..a74d774168 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2623,7 +2623,10 @@ test_expect_success 'git reflog show' '
 	git checkout -b shown &&
 	test_completion "git reflog sho" "show " &&
 	test_completion "git reflog show sho" "shown " &&
-	test_completion "git reflog shown sho" "shown "
+	test_completion "git reflog shown sho" "shown " &&
+	test_completion "git reflog --unt" "--until=" &&
+	test_completion "git reflog show --unt" "--until=" &&
+	test_completion "git reflog shown --unt" "--until="
 '
 
 test_expect_success 'options with value' '
-- 
2.43.0

