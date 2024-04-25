Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2A914F9F5
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071596; cv=none; b=MSMBUkzObUxbolTx4hl4+KJay+0AZrPM6GC7dEh2aPbEnfRwGHpY0BWj7+7OzA0+QiIdVGJ8Wj+MPgU4z8Ms2bZMlWigjleUr861CzFUGzG89YuLOqjJz5y/G4hydT3GqCJ3QenAJOaOBDr33os/G3kZuC2dEjxLyIkreCTewSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071596; c=relaxed/simple;
	bh=al02jXA8QfJ+bDykVm9k+V6pH5Qw/1QorpvN4BOXmuw=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=p8oO54IE/jLZeaRNMgGTt2IOtjGJmtMsb/dc/Loq3LcwZKF6VsTOEtK2KrlBv5/Hh2AhNUdr00FPTgJ4kO14DN2MBCB6+zqKYj9kQQP+Xr5YLTdrwu5pbJHuIicWCsJhMivIbxK+aYPVvVx0krrcuM4vQOR382Ifqv3nlRX+ACM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Quh8xU68; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Quh8xU68"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2db6f5977e1so15330571fa.2
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 11:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714071593; x=1714676393; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zi9J5x31EviBdM4O5UkQZXhhYRD0XPX6hiCPI52L254=;
        b=Quh8xU68REjd6A0qIllfxOjhUZybfzWCtxYZ9PcDWRaRIzcHUa6SuYoDOp5glQlHkN
         3zk/9ORbUkUlHtbv15reav34UcaqbOMf1tmTEKm6MYkGM1xfoUnjGlG74WHQoFP/+edo
         hpOWvyYb+xhDzcG0ImHV8I383113P2k8afwlxlYHeqS/fRon+I8+0qPV7mWlusU6BT5g
         TEq46ThCt88sWR9VQP5HzJpa2yNhZEzy9ZpZxBverPd5wbrpyKSypAh9G6eTe7nbBWDn
         MB2iWfmTfhzI1NQaiKLioupj2EwFJHd5dBouUcByV2N9XflMRHWnfGWyiOTOBc9Y2zSu
         u0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714071593; x=1714676393;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zi9J5x31EviBdM4O5UkQZXhhYRD0XPX6hiCPI52L254=;
        b=ASXEYFGg+UdU+lEi2nUa3QIt1yN4pE3S2ntAL7qdWWvK5zHBG2dm5I7zK4lDLJ/Lur
         9BSdbm7AjY/pFB91eZqtojYmkWAJxyeP2nRbPAYxp+vxbz+i2HFJUcfP5HQgy/CAKgeN
         dbplhxyFSoZ9ZK3YMFlI/3xHjbprbPO/Eu9Dr3M/WFLFXkE/n3nM3QY/lcOZo+XmbfT8
         4iDsDBWqaxEpCnEVl6BqjRAyyzj0vMSyQUk3aOaGL+Ru1rLicBFVla7uq+vTuHxsmJZD
         E0We6LzjCezj1zbtwb8TCrQz0Rb3uPApEFk1Bjlbt2rz9pXXTIthUXo885s+C3YaX1SH
         Yphw==
X-Gm-Message-State: AOJu0YwpsYiD5SrGGSXg8iSgxdUJa3E9upqbFgZh2NXRSbCA2GGR0krQ
	1CPmqwUQmtfAbcsldr0cELi5ySo+3kyx8CLX/sDggqaKwmvo6mNmWt4viw==
X-Google-Smtp-Source: AGHT+IFp4yhXflcJ8QFyzXaPCdsKEder63XG/z5f2eOtUEkMM0zzzNbP0sRUbCpjIBir3LQSFLW8wQ==
X-Received: by 2002:a2e:b05a:0:b0:2d7:1a30:e881 with SMTP id d26-20020a2eb05a000000b002d71a30e881mr163369ljl.12.1714071593270;
        Thu, 25 Apr 2024 11:59:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c470b00b0041a963bf2cdsm12312849wmo.36.2024.04.25.11.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 11:59:52 -0700 (PDT)
Message-Id: <pull.1710.git.git.1714071592035.gitgitgadget@gmail.com>
From: "Thomas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 25 Apr 2024 18:59:51 +0000
Subject: [PATCH] completion: fix zsh parsing $GIT_PS1_SHOWUPSTREAM
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
Cc: Thomas <thomasqueirozb@gmail.com>,
    Thomas Queiroz <thomasqueirozb@gmail.com>

From: Thomas Queiroz <thomasqueirozb@gmail.com>

Since GIT_PS1_SHOWUPSTREAM is a variable with space separated values and
zsh for loops do no split by space by default, parsing of the options
wasn't actually being done. The `-d' '` is a hacky solution that works
in both bash and zsh. The correct way to do that in zsh would be do use
read -rA and loop over the resulting array but -A isn't defined in bash.

Signed-off-by: Thomas Queiroz <thomasqueirozb@gmail.com>
---
    completion: Fix zsh parsing $GIT_PS1_SHOWUPSTREAM

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1710%2Fthomasqueirozb%2Fzsh-completion-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1710/thomasqueirozb/zsh-completion-fix-v1
Pull-Request: https://github.com/git/git/pull/1710

 contrib/completion/git-prompt.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 5330e769a72..9c25ec1e965 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -141,14 +141,14 @@ __git_ps1_show_upstream ()
 
 	# parse configuration values
 	local option
-	for option in ${GIT_PS1_SHOWUPSTREAM-}; do
+	while read -r -d' ' option; do
 		case "$option" in
 		git|svn) upstream_type="$option" ;;
 		verbose) verbose=1 ;;
 		legacy)  legacy=1  ;;
 		name)    name=1 ;;
 		esac
-	done
+	done <<< "${GIT_PS1_SHOWUPSTREAM-} "
 
 	# Find our upstream type
 	case "$upstream_type" in

base-commit: 21306a098c3f174ad4c2a5cddb9069ee27a548b0
-- 
gitgitgadget
