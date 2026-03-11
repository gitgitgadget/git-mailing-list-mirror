Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D863C3BF8
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219049; cv=none; b=g6DrazhTVLrlwuCa51ZYh8eG2EUry+D7dxxKpicESNndISG+9KIJhE+f4W72d5xQoFFiIgMrjoCLfAiXJNH/9YtLSYoj+RlsUHy6GBeA+ZkM98ZMiIbfPMtAzrXJKqhPvhwxwGWqMic73LL8z+6Sfqq8b+lOiOi3ygZvsC34QJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219049; c=relaxed/simple;
	bh=MefLa3wNJXoQO78PhNJGW3K7/C12xLk2rNPg7hPba38=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=l0RvSYTr0fxnysrGZoqFW0B7gYSrsYCzVP7VUIaKUN5jJwN4C7UA5Vn9Sm3TOPER7RtdqGfk1JziyEc8BkCTdnmUBJM4QPHaY4H+R78Jjm/KfMBAlkDPvj9ROgKN9J1LNn/RwRzE8vsDPR4QgFMxdVMp4Zee+2e1+1yCMQJMEmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7ZBOyf5; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7ZBOyf5"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-509061dab77so41301331cf.2
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 01:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773219040; x=1773823840; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9QS6YE58h4NHsYbztqOJDH0/AZAAityfWcz9LtATEw=;
        b=O7ZBOyf5Kl84Lhe8ALmfl5QpFL3LU/wYA5qdYBa+1E0f8Z0T2DTl8K+yGaedw+dCXs
         yOFiwt2z5ysX/JHM/CP0eavXnJAnntUAFFH+rcRrlxL8baqbN7FAUGgqa1VUdQEPzJlY
         dUFLC8eeqle+DJ4Hmsawur1r1+4rpFHtZOPyfcrU5Sm4+vzjiZxPzTvx7Sm5+lmckU1R
         5yZ/73vGT8SU90mRoVbefLOQfzjdDKajeZouKPDWskitbU2NfAhh1ppzfSJ6+cFRvHQ8
         b6uel5OiDTTXxDCfoLJqyk0H8jw+aLckfm6rROgvbaOPDCrLoYGKWpLtt9XWngRlbn8f
         AcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773219040; x=1773823840;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P9QS6YE58h4NHsYbztqOJDH0/AZAAityfWcz9LtATEw=;
        b=TfS3/yi8SmENseQU0anc7WnZ9lvbQRU9k74KtFJNeWC/BEjzacPKW4xPLFPfHEC50n
         G56yfaWPtK4smlyEKwALHkf2uBoCOck3/MjvIXJTygNRXSFstVpEc/etFwHuIHD8LY/X
         dfEFA+m7q+Q9IJOKY3XwYyiOi19g76OkaXOJbGU4cArONTh4vwIfEmpdSNc8DHRdgEQ9
         0AaMy6m9LGr4lS/2u2MGeFD5bkXnx8t/+jBmpnLo6Nkhu5431iTDp63wlazhILOH4ld2
         uqsEvwsB/f0wy3TAp/5n0gz9iTcNnGkupGgRQIYlCeQf5eylZBn1H5Wr/stLH6U6MqJt
         9FpA==
X-Gm-Message-State: AOJu0Yzschq44dfHZA+3ZO7Blb7HTg/HVTEt83Q0Ms5BQ2Xz6JNLvPQm
	oTTAhQYhrfKyRzymYIrgodZVEfwHg4syOhwFeehVw9DkMIFiGoBzdlN4W/CDD8jH
X-Gm-Gg: ATEYQzx+BCpbXNUoCPCNyZo2S35e3XfzL70p1OKEnYgwHHCdbDCMtitbn4Dc4p1S8sa
	/QUIpyUuRiiCcPz7WUSVVFj0OlOaon7fKC+pquNNQvmLNKFcbR/pJXrJaOFi+RyQYi60XtqXdY5
	uq7q78HwfiaAL73dDJHsxY6LnJsTU683+2vLj8rD8ZoGpIzrzsTNKnvOAyrjCcw+mjUQ4kDtepj
	fdu2klSEB4H1SFnB4Jt9qQ6G6U+ajOWrh2YAzbdZqDw5fPUi+67UqBB1ypj7HqHz4hjxUQX6RIq
	GVOjV9BM/PQ5KNX7A5t65dNFWkIyJXna7OM4pF2aOcjzqluTZVowgRMa7S49FoZJhZuTtH7nugx
	jiyR0fdHWIHjFbZ42+Zboutl0kgEVpb2we7cuL5fCoFp6LroaVqDgemOBmQ9rLNF9qREhK36AyL
	48Of6yQMhmbGvLlXjRTj5xWM0=
X-Received: by 2002:a05:622a:180c:b0:509:2faf:482 with SMTP id d75a77b69052e-50939f53262mr20314661cf.4.1773219039863;
        Wed, 11 Mar 2026 01:50:39 -0700 (PDT)
Received: from [127.0.0.1] ([40.81.42.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50939ec5017sm8817811cf.8.2026.03.11.01.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 01:50:38 -0700 (PDT)
Message-Id: <2ef7d5a3d6c2249f153dfc3a2a3dbacfea8253e5.1773219028.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.v4.git.git.1773219028.gitgitgadget@gmail.com>
References: <pull.2233.v3.git.git.1773149337.gitgitgadget@gmail.com>
	<pull.2233.v4.git.git.1773219028.gitgitgadget@gmail.com>
From: "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Mar 2026 08:50:28 +0000
Subject: [PATCH v4 5/5] File updation [GSOC]
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>

From: Arsh Srivastava <arshsrivastava00@gmail.com>

I have ran tests locally for this file
and tried to fix all the CI issues
Lets Hope it works

Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>
---
 t/t6439-merge-co-error-msgs.sh | 6 ++++--
 t/t7406-submodule-update.sh    | 3 ++-
 unpack-trees.c                 | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t6439-merge-co-error-msgs.sh b/t/t6439-merge-co-error-msgs.sh
index 6ebc1d2565..cf996e0e51 100755
--- a/t/t6439-merge-co-error-msgs.sh
+++ b/t/t6439-merge-co-error-msgs.sh
@@ -78,7 +78,8 @@ error: Your local changes to the following files would be overwritten by checkou
 	rep/two
 Please commit your changes or stash them before you switch branches.
 Try using 'git checkout -m <branch>' for a quick fix.
-Please Note :- that using -m (merge) will not save your changes, rather would directly merge them. Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone.
+Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.
+Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone.
 Aborting
 EOF
 
@@ -102,7 +103,8 @@ error: Your local changes to the following files would be overwritten by checkou
 	rep/two
 Please commit your changes or stash them before you switch branches.
 Try using 'git checkout -m <branch>' for a quick fix.
-Please Note :- that using -m (merge) will not save your changes, rather would directly merge them. Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone.
+Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.
+Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone.
 Aborting
 EOF
 
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index a359429bf5..2e4cc9b3fe 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -213,7 +213,8 @@ test_expect_success 'submodule update should fail due to local changes' '
 	> 	file
 	> Please commit your changes or stash them before you switch branches.
 	> Try using '\''git checkout -m <branch>'\'' for a quick fix.
-	> Please Note :- that using -m (merge) will not save your changes, rather would directly merge them. Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone.
+	> Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.
+	> Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone.
 	> Aborting
 	> fatal: Unable to checkout OID in submodule path '\''submodule'\''
 	EOF
diff --git a/unpack-trees.c b/unpack-trees.c
index cb4cdee9b9..9835a82455 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -129,7 +129,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
 			  "Please commit your changes or stash them before you switch branches.\n"
-			  "Try using 'git checkout -m <branch>' for a quick fix. \n"
+			  "Try using 'git checkout -m <branch>' for a quick fix.\n"
 			  "Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.\n"
 			  "Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone."
 			  )
-- 
gitgitgadget
