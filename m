Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21901184559
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067922; cv=none; b=Q/aEwdbbuQ9eHAz0PMw/Mr8Tw4Tk6onSlrb3QsuUrB0XSD9P8AlBsFAmXSpsh5htRmn4yM1+SAnr7HxTh0SeP/Nxk12eSPqvb74onuQsGnFDITRsFdjAyUYIsq/bRD+84aliL6E+ykDOWrcUjky+tvLMEIPYL4uW7OYQ2vWAmq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067922; c=relaxed/simple;
	bh=mdVJINHqrxD05LIPljBlLCgJeTNHGT4hZXkfExxfRSY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mTbyaq00kMChZMKZEs38qpNlKDwHlJhwSkLvy8k+TBmmrlkAIg/ibjRFxRXY6QlpemiRVPTVPoOM6uf3zLE8xPgHZ1YkxCJ3v+9d6vCHcmqRuTkY3H/FjmQNIsUqXquxxCD6tXwkjlHMdrUig0IwqSW5yIDZzmESWi8zcDoZkzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZUICZUa; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZUICZUa"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d13b83511so597509666b.2
        for <git@vger.kernel.org>; Wed, 11 Sep 2024 08:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726067919; x=1726672719; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1pyEkPKv9cCcubpzKkhNNvCflz2zKVGcrV4R9mnLe4=;
        b=hZUICZUad/cysBqU+D7zkmyAeGmYiYr1L9Lcehf69uoLJJCLaItapGgfCeg+Z4x506
         xqPOgYiazODt+Pi1BPWxmx1nKf3hWBZCSywxWw+cADxZlv01QCyX7gLt70ovBwEhtY3l
         b3iQM1+56s11EoPZliLn9pfMk/tYBS+uHK3FUMIdm5XgvE/HYlewNZ9GJbR3VWY7e1Kr
         tnu2+H9LN3uYESusMOCYPW0UV7QXHMFk4R5KO0D/du179g0DBFFxyg+QxjLNJwqYYd9R
         4UG39n72lg0TRsk+EA/cqGVBEAqEn6R7wmLcTaeyvK28foReeap4p6fxM9RnDG27a//d
         ZbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726067919; x=1726672719;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1pyEkPKv9cCcubpzKkhNNvCflz2zKVGcrV4R9mnLe4=;
        b=Om9jwaDwicqqgTB0ommHYgTnjU/qKgDCpmM4nxqb20nvwr3rvSmBUflPA1s9onmkL1
         Nb5Hy6T6cBm986bAF+lsX1nbM9ThZ6bPnUBAhnlRiqPtcLSCPindQY+Gw6KIHlocRHZ6
         JuHUjQNbaJEyR6aip7pKfAzvE5+f1mk4KuhUH22MXVIoxn0RWzPginbzJd1EyGco1X7m
         GmNaSeBQX0jspSh9gbu0twD8alieWcS0WEchfRNsh66jFGb08iqmX8LuhTTuVVpFxCvS
         OLGhNNkW+bmUrDG+nYBCodUmsF6yAX9IiV60FwskV/EWl/cNEASqIYOKD55Cr6J+8Wia
         VI2Q==
X-Gm-Message-State: AOJu0Yy/51uwAFSAoAjNjjF5KgF28nUyjY/Ze5853HVxG9Vb4w9+ocA+
	FLY1eurU7dZWA42XUtgs1aUZqIFHC4KkkpvQYC8C53BhezX2bki9f9kaSw==
X-Google-Smtp-Source: AGHT+IE3nqxL+A2eVKrmQFpv2qgRX39bDU09FotYOtSe8Dond+Maid6SWoy7x4sRdEfqpLH/wP3WXg==
X-Received: by 2002:a17:907:94d5:b0:a8d:5ba1:88e6 with SMTP id a640c23a62f3a-a8ffab83db5mr428958266b.28.1726067918879;
        Wed, 11 Sep 2024 08:18:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ce9ed6sm618291866b.165.2024.09.11.08.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 08:18:38 -0700 (PDT)
Message-Id: <d95a07a22aadccd0c0e0e63bbb98b3a4306545d2.1726067917.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
References: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Sep 2024 15:18:34 +0000
Subject: [PATCH 1/4] remote: fix set-branches when no branches are set
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
Cc: Han Jiang <jhcarl0814@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

To replace the list of branches to be fetched "git remote set-branches"
first removes the fetch refspecs for the remote and then creates a new
set of fetch refspecs based and the branches passed on the commandline.
When deleting the existing refspecs git_config_set_multivar_gently()
will return a non-zero result if there was nothing to delete.
Unfortunately the calling code treats that as an error and bails out
rather than setting up the new branches. Fix this by not treating a
return value of CONFIG_NOTHING_SET as an error.

Reported-by: Han Jiang <jhcarl0814@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/remote.c  |  8 ++++++--
 t/t5505-remote.sh | 14 +++++++++++---
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d1f9292ed2b..794396ba02f 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1567,8 +1567,12 @@ static int update(int argc, const char **argv, const char *prefix)
 
 static int remove_all_fetch_refspecs(const char *key)
 {
-	return git_config_set_multivar_gently(key, NULL, NULL,
-					      CONFIG_FLAGS_MULTI_REPLACE);
+	int res = git_config_set_multivar_gently(key, NULL, NULL,
+						 CONFIG_FLAGS_MULTI_REPLACE);
+	if (res == CONFIG_NOTHING_SET)
+		res = 0;
+
+	return res;
 }
 
 static void add_branches(struct remote *remote, const char **branches,
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 08424e878e1..cfbd6139e00 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1131,7 +1131,9 @@ test_expect_success 'remote set-branches' '
 	+refs/heads/next:refs/remotes/scratch/next
 	+refs/heads/seen:refs/remotes/scratch/seen
 	EOF
-
+	cat  <<-\EOF >expect.replace-missing &&
+	+refs/heads/topic:refs/remotes/scratch/topic
+	EOF
 	git clone .git/ setbranches &&
 	(
 		cd setbranches &&
@@ -1161,14 +1163,20 @@ test_expect_success 'remote set-branches' '
 
 		git remote set-branches --add scratch seen &&
 		git config --get-all remote.scratch.fetch >config-result &&
-		sort <config-result >../actual.respect-ffonly
+		sort <config-result >../actual.respect-ffonly &&
+
+		git config --unset-all remote.scratch.fetch &&
+		git remote set-branches scratch topic &&
+		git config --get-all remote.scratch.fetch \
+					>../actual.replace-missing
 	) &&
 	test_cmp expect.initial actual.initial &&
 	test_cmp expect.add actual.add &&
 	test_cmp expect.replace actual.replace &&
 	test_cmp expect.add-two actual.add-two &&
 	test_cmp expect.setup-ffonly actual.setup-ffonly &&
-	test_cmp expect.respect-ffonly actual.respect-ffonly
+	test_cmp expect.respect-ffonly actual.respect-ffonly &&
+	test_cmp expect.replace-missing actual.replace-missing
 '
 
 test_expect_success 'remote set-branches with --mirror' '
-- 
gitgitgadget

