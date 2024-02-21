Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9534283CCC
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537104; cv=none; b=YVHJigVHQcUCd7IESVEnoB3GdCckZrsDgT3VxT3K/zA+v8FuXKBndxcpHiE7YpZKnMYMwq6JTONUH2dQPaL5PdQWhAv9MNqFvgMFbPW1HKG1HEC4bzzXmxD/ABx8xBQWRcBdXlaiK9RoAd0AFk5NJVl7h+QIv3xOE2C08kmYdG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537104; c=relaxed/simple;
	bh=Py5oBN8UZhfl1EWYCkMbpTY5Lp9q5dXGcQV50ozCW5A=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=laLHedBnWweH4OZukZa6Qli3O+F9N8oSncsns9aefQq7iPXLmCElYQHD3EEdMGYF+MpYtxU4yFIIiVb6/+souEcbEYwWK23ARxPmMagIyjjNXUBeWvd73MTHvrvjPHplJJ5QOLZYsOBKGl4gtFQ2V2R1HmPubrgngcSGCvCgyXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+Mybma+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+Mybma+"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41274cada64so7555565e9.1
        for <git@vger.kernel.org>; Wed, 21 Feb 2024 09:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708537100; x=1709141900; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZHrTFYupsssWIpdmrbgMehjbtAXTG4o6D53icoO60s=;
        b=V+Mybma+sg+OROus9sEcXjNuw1pRzQYxwgdpvG+acA7Qt62HLS2IWMBinOlp11jHZC
         OTRVoJb13CxzPKcIwvDRdPh8zWhdMgewPnN6X5rMHTOxB9DsdqLvGogLLA4RGUxAEEOX
         Kcd3dRpyHE9nV7sJBGGaXhLz7EKgLkrxwscW1OLrnRj5yNdn5vw2W7tXVS8fwba2toF9
         8lw0tHpkrG8BGagP+h1oDpknfK0GUl5S5vOERXkVEQsd8RRYRMVrH0lN0gq8Wam2pX57
         lTaOJ85LmwaQnraJwne4Z+nCtYk5obUBRS7cDbhwd+YDrKveWN5kJWvfzTcl9cxUACtn
         XC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708537100; x=1709141900;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZHrTFYupsssWIpdmrbgMehjbtAXTG4o6D53icoO60s=;
        b=E+j1ERwlSZEijms0hRGYkofvEOR/pNc3d1xGsdtLHh5fzZ1UCHyW+Rttw+qPvGtrfS
         fEpC75n6HyYEZcykNAUutgpx/E7VloO/N6Tnqq4Vd1v4Kyu0pgIfiXJPxym9ZxjVPEhP
         GRI2snbQ3jyXLVHofN2rQ3En3F02t02iMjbhPQcxKn8rsy3sC+bk7svGyCYNPtLRoXyW
         6XEHop9NTn4mpv/keoNd1BGj/8iZiZ4/E64mXuurlLdLODnOYYzL6S/u6AMvLyiLRhYv
         KLH7liwJOdV5WBKLIYy2MqlaNy2XjQm0ZWkfrURHP63F5ahyssBgRpnEbVeeXbp0keZt
         NS5Q==
X-Gm-Message-State: AOJu0YwrXSgKQRm9UQs6V/X8IiW5gAxj7YixbkzwPyTpCQSWYkiluDuL
	HqfM4h9W74EddG2qd6WnPMaEKa0boiqC+J8+PztK0gCYGB10NNiZ5uXBGXJp
X-Google-Smtp-Source: AGHT+IGGR02SpVtJ7aZ633XnIYrhoyL564friZSPq52nEjgDmUVXiLdNgWAzKwuoV998WqEbNshHCg==
X-Received: by 2002:a05:600c:1c0e:b0:412:698b:d7bd with SMTP id j14-20020a05600c1c0e00b00412698bd7bdmr5787956wms.31.1708537100001;
        Wed, 21 Feb 2024 09:38:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13-20020a7bcd0d000000b00410b0ce91b1sm3173087wmj.25.2024.02.21.09.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 09:38:19 -0800 (PST)
Message-ID: <pull.1669.v2.git.1708537097448.gitgitgadget@gmail.com>
In-Reply-To: <pull.1669.git.1708442603395.gitgitgadget@gmail.com>
References: <pull.1669.git.1708442603395.gitgitgadget@gmail.com>
From: "Harmen Stoppels via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Feb 2024 17:38:17 +0000
Subject: [PATCH v2] rebase: make warning less passive aggressive
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
Cc: Harmen Stoppels <me@harmenstoppels.nl>,
    Harmen Stoppels <me@harmenstoppels.nl>

From: Harmen Stoppels <me@harmenstoppels.nl>

When you run `git rebase --continue` when no rebase is in progress, git
outputs `fatal: No rebase in progress?` which is not a question but a
statement. Make it appear as a statement, and use lowercase to align
with error message style.

Signed-off-by: Harmen Stoppels <me@harmenstoppels.nl>
---
    rebase: make warning less passive aggressive
    
    cc: Patrick Steinhardt ps@pks.im

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1669%2Fhaampie%2Ffix%2Fpassive-agressive-message-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1669/haampie/fix/passive-agressive-message-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1669

Range-diff vs v1:

 1:  4dfc578da84 < -:  ----------- rebase: make warning less passive aggressive
 -:  ----------- > 1:  a6f7a3a2477 rebase: make warning less passive aggressive


 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5b086f651a6..6ead9465a42 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1254,7 +1254,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		die(_("options '%s' and '%s' cannot be used together"), "--root", "--fork-point");
 
 	if (options.action != ACTION_NONE && !in_progress)
-		die(_("No rebase in progress?"));
+		die(_("no rebase in progress"));
 
 	if (options.action == ACTION_EDIT_TODO && !is_merge(&options))
 		die(_("The --edit-todo action can only be used during "

base-commit: 96c8a0712e569dd2812bf4fb5e72113caf326500
-- 
gitgitgadget
