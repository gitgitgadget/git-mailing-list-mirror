Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D244E4C630
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706481304; cv=none; b=docSSLUfc/AXUA9knQ9ae752+6CqqXzKQN3io3jwWitQNcBmt+vQPfM8RdoNFOJzm7s48sQaJD64gGkHmP0dMB42zuFlSFM1eSTqGMS+n33/J8nv9eLbQCz5MINo8Ru+YiLE0Xxh7n5VcWQIO9cvROjd7pafHIuy+D1wdnEdfsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706481304; c=relaxed/simple;
	bh=7B68u1TjIquVda+MOdxfqkpEZq/LSMv/V7UqU41DR3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcjJntSt4Si6Li9EYNf5v67xBac9ozh4Mo9U8z5Ea+Q2SN7ZQh50S9DkdLGoaW1tb9xSEKh8lK0yHV/TqJk3UDy+IdROLNLI95Cfim2rI+Rg0F0+rk3jc65End76khaInB1Fb77cUJ0sRm5hvwXSrsM1dzRQI1aypxvXaVNwP6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNZTDFb/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNZTDFb/"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d70b0e521eso15965445ad.1
        for <git@vger.kernel.org>; Sun, 28 Jan 2024 14:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706481302; x=1707086102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXHyY0UZZQOkQ8vGbOM4A+3Bugm3FTpT589PEAW+ZS0=;
        b=WNZTDFb/d9Koi5nwvhuFiD+wiiUKjnk378PiWvunFdpcmv8N5/PGaBaLAXKEZ9RgHF
         TNjCSJnCbCgF3YTSwbCJCY9/2zNQJ8v6IY9p50wTYx/EXngWcgfcLAQjlSc+JaXbFAkj
         EeBp6FXccVSqcysch0YENR9AYA2v+dsJuSrU2C/5DERB8oSxnpQk2ZHD5TW9exWTAAN8
         8n0z+Zz0lveutBoVyRdcDnQ8WjR1gFXfFwlXIAyoM+Rty7/lSavIrE8z3csvKOjnNglK
         AR1qjpfc2qoBQ1ayexOvuF7DjhFefPUpgqLqGfoQsDHXFscE4jCKp3eCb8p5hO+nNzRV
         cmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706481302; x=1707086102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXHyY0UZZQOkQ8vGbOM4A+3Bugm3FTpT589PEAW+ZS0=;
        b=dWd3pC4Gm1LAnT200PPZe2yAQb/lecL7zPPDBSyZb5n5ojTV3fao+4ogig5yplh0WX
         laMYJSXxkNm0jaWwtpY/HxlzcMl7rvotwZvwWhtvs4AqRvn/i0lTkGoi5ENWhu5KmonI
         AaDxWqSEYNZxf3Ow+Iux27hLf5+qX+b1eW8gBx1DdgNEjjhWY/Iw4BAP6wP6F+/jTNyo
         CgVBybsaZ1SD2hBTpXnaxGRQwUlIpfQ2Sab74nBEKG/xYl2b421SyAGaQVu57WqxwGO3
         vrIHq4XiFjBawW/LQyLoxSEkilx4u9QFFo6tXPnVaP2wLkZPJ+2eltgfO44FWHXXbDX0
         0XYw==
X-Gm-Message-State: AOJu0Yw2JuxSwJ7Vw4EI19DFJs7BJFGfMKZb95FNIh6YrEKl0xa3qdLm
	gEz4wr+rREh5dzdbnsYXMimLGJoFbJgya9Vb/ps7qtnrVs2HZTsH
X-Google-Smtp-Source: AGHT+IHBgw75St+LmcOoaXZe6xRX2Sd4aRFc/nrNt0M4pf/lpeZ+JAKp+aquf7h6zVTQcnANNDBujA==
X-Received: by 2002:a17:902:e750:b0:1d8:a83e:f81a with SMTP id p16-20020a170902e75000b001d8a83ef81amr4505448plf.139.1706481302163;
        Sun, 28 Jan 2024 14:35:02 -0800 (PST)
Received: from brittons-large-Vivobook ([209.112.166.194])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902e34300b001d705b43724sm929248plc.169.2024.01.28.14.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 14:34:57 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 731CF52053A; Sun, 28 Jan 2024 13:34:50 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v4 7/8] completion: bisect: recognize but do not complete view subcommand
Date: Sun, 28 Jan 2024 13:34:46 -0900
Message-ID: <20240128223447.342493-8-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128223447.342493-1-britton.kerin@gmail.com>
References: <20240118204323.1113859-1-britton.kerin@gmail.com>
 <20240128223447.342493-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "view" alias for the visualize subcommand is neither completed nor
recognized.  It's undesirable to complete it because it's first letters
are the same as for visualize, making completion less rather than more
efficient without adding much in the way of interface discovery.
However, it needs to be recognized in order to enable log option
completion for it.

Recognize but do not complete the view command by creating and using
separate lists of completable_subcommands and all_subcommands.

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ae16e742a4..0cf1a5a393 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1462,12 +1462,19 @@ _git_bisect ()
 	# more usual bad/new/good/old because git bisect gives a good error
 	# message if these are given when not in use, and that's better than
 	# silent refusal to complete if the user is confused.
-	local subcommands="start bad new $term_bad good old $term_good terms skip reset visualize replay log run help"
-	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+	#
+	# We want to recognize 'view' but not complete it, because it overlaps
+	# with 'visualize' too much and is just an alias for it.
+	#
+	local completable_subcommands="start bad new $term_bad good old $term_good terms skip reset visualize replay log run help"
+	local all_subcommands="$completable_subcommands view"
+
+	local subcommand="$(__git_find_on_cmdline "$all_subcommands")"
+
 	if [ -z "$subcommand" ]; then
 		__git_find_repo_path
 		if [ -f "$__git_repo_path"/BISECT_START ]; then
-			__gitcomp "$subcommands"
+			__gitcomp "$completable_subcommands"
 		else
 			__gitcomp "replay start"
 		fi
@@ -1490,7 +1497,7 @@ _git_bisect ()
 		__gitcomp "--term-good --term-old --term-bad --term-new"
 		return
 		;;
-	visualize)
+	visualize|view)
 		__git_complete_log_opts
 		return
 		;;
-- 
2.43.0

