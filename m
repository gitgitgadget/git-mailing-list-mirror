Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820B84597C
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 22:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706481299; cv=none; b=q7O6fjDueUx5X89vWa+12phe5lpjEZM2TaLVJ6fRindJu5/U+VN29GkOGLC8Qa1Nrdg1/1mArhQmL7r8T3Gx4sEDkRTW9SyXyed0bZH/hvGXrHvcmLfNi+W13Jr+nl1wS/YixE1IbiHIys+FrMybcxhMpQYK3OnVQUwejbdkPM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706481299; c=relaxed/simple;
	bh=V37AEyqlltY9lepgl1mE/4JkhjbsfK/djZb+FLWCShw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMv+vjUJV1R/JR3SbN5GdjeZGUeSV2QAf5ebhor68gaxKLpicEl05w8s2HoKlXGJZ//3oJOI/2lz3ztGGl+IfELi6IMeKKU33qUe+YUdIf+xhIlWHxEVbZaC+tyZuGgIr/HUF1Dun3p3YifhR7uu8+IuP7GH+qdPIN31hNZsgqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsNRyF2m; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsNRyF2m"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42a8af3c10cso16944521cf.0
        for <git@vger.kernel.org>; Sun, 28 Jan 2024 14:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706481297; x=1707086097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8A1lp9jpxGG9/mMJ/5+qub/9diavCbzMP2XThYtQ6I=;
        b=FsNRyF2mt5KA2A6YOioqjdNKP4+BQTBTy1FZaCI2CSalR6OSAcxcUjZVlgZ/WNK++t
         hh8xTNgab0yhfefX0o7w5DBH3g68VGoEWoydtjXLnvxpv5D4z3UjpCrXxUWvXdLwm8fH
         /9t5OCXjbSL/PRCapEBUM66Yqp9qHEozquPeFyel96YywRmeLMKtQUltWUA5IAGa2OzL
         mE/iIolHX1S5560AfzpGcc/uqNRbLPgbGWhPbThJWLY+SgUmjlF8G1aDwU/NmZgyViFV
         cbdM97u87JwfG8pBl7Kyku0kdWfCFTJScTh1+uIKIidKvON0hnjfyaA1M+BpRuSzrD+a
         dP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706481297; x=1707086097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8A1lp9jpxGG9/mMJ/5+qub/9diavCbzMP2XThYtQ6I=;
        b=ibeLbImjOcvGWibvhXp311n0r4Y/CGu6l9Q7HFLcecQcHLZlm3/Kr7O7CgVORmz7O6
         TlA9xij/oTln365whKZvODVkNEL/cPVAHewIEFfVgbcC6XM024UEtjo/0Eh7oUI6w8j+
         HxKFVFLKzr1jepknDKwFG79CK7RPsjFGB2fLJITH3jd5kp2eyhKnmUtmc9oWqX73iaZq
         ss71WAGIZm+H09h5csmW7sZHwkh1VdKDSXtRzSDvofr2cTCZA5QS169FwmRy9vUn3rR/
         bkXSZIZOq4JUdwWHvq7uraB3Sgnodk/A2IQdBleV3pyzg+flvBnblaCSRibA2xhJEe+i
         MzRg==
X-Gm-Message-State: AOJu0YxuRw/6/oPwpdoIC2Pw6Uczu9iMmP5TISJlrtPUxw/Sz6Eu6Psn
	8ykR71VSJjKXpIumtATsAKOjRYg1yX/G1LKSGZ2GtIS/jJmlCRG4
X-Google-Smtp-Source: AGHT+IHIOgdVib+qECHdUOjs16vQq6qR2Z+UXWfk2xjudnQkJ1qWxjj3JZs7s2M1Dl2GAMQrUOyJLQ==
X-Received: by 2002:ae9:e014:0:b0:783:bdab:aaa7 with SMTP id m20-20020ae9e014000000b00783bdabaaa7mr5011428qkk.115.1706481297372;
        Sun, 28 Jan 2024 14:34:57 -0800 (PST)
Received: from brittons-large-Vivobook ([209.112.166.194])
        by smtp.gmail.com with ESMTPSA id j19-20020a17090a841300b00294483f38dbsm4408893pjn.9.2024.01.28.14.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 14:34:53 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 6680152019A; Sun, 28 Jan 2024 13:34:50 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v4 1/8] completion: bisect: complete bad, new, old, and help subcommands
Date: Sun, 28 Jan 2024 13:34:40 -0900
Message-ID: <20240128223447.342493-2-britton.kerin@gmail.com>
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

The bad, new, old and help subcommands to git-bisect(1) are not
completed.

Add the bad, new, old, and help subcommands to the appropriate lists
such that the commands and their possible ref arguments are completed.

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 185b47d802..06d0b156e7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1449,7 +1449,7 @@ _git_bisect ()
 {
 	__git_has_doubledash && return
 
-	local subcommands="start bad good skip reset visualize replay log run"
+	local subcommands="start bad new good old skip reset visualize replay log run help"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__git_find_repo_path
@@ -1462,7 +1462,7 @@ _git_bisect ()
 	fi
 
 	case "$subcommand" in
-	bad|good|reset|skip|start)
+	bad|new|good|old|reset|skip|start)
 		__git_complete_refs
 		;;
 	*)
-- 
2.43.0

