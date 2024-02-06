Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0A61BF26
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 21:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256254; cv=none; b=Kbr8loYYnRneSDc123QMtafyx5diLgwBRopFvKMwY900yGhs7EOxRLl2Irh1Ivc/4kOFLzx+6ZaI5dcxFbuBuc4XRBZKBknJ3E6H7zW3uFKgwkIKIoLfrEkBpzvhOuuafO1TKmMQUSE6F7JgqgCoTCUvZ3+bPvlyKLmEBgMP1D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256254; c=relaxed/simple;
	bh=eIHyv2haFZwD3lYyfzZbFiANNnckVPLurfbfjJDekk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1weS9oXFYMdKpDf8YOJF9KS8v8ZtlAYtJB0ycdQTMFkMAuX3S4U36WZbWf+ts5g2A/vFBmpx7baMqeX/b1BQovafT9M0nxFrbj8ThY/0qECfb3F+0njHQ2h6Aj5YZmOJfBk2FsHoXG8LfX+bqi8V7EhEwvsOxb1ZFYgoLM6At0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYsy4Pxd; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYsy4Pxd"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d3907ff128so5335787a12.3
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 13:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707256253; x=1707861053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsPuOaiMnzGydyh48Sl44aMJPe9XM3/eGmgUsPpN6Ok=;
        b=gYsy4Pxd9GniwG8bkvKL9y5zUaDa0I3cmAOVQvhfT/pTg4gVPacFjRajzqH164uUWI
         Iz++H8AMSgTpVPVvRCAjSvj52voOtrIBazNCij51XnJQBqiKSXKuNLHrENZjJ/vbRODy
         elF7HDyNsGaqEQSl0YzcTOfuk/FtWLiuVUokd34Ra14QDfMhMyywGpWdhsXTCJNg24e/
         lKw37U8uijeZu3tEIgDt7w2qADMywplHoAightvLLIyR83mA+xbP7uhGzRzr/O2cOic1
         W80wPtivM+ps6+02q/oP2oh4iGr/lwo74sR0D3EIQsJzImfDFsG1Z3tEAPK3w1hmy29c
         EOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707256253; x=1707861053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsPuOaiMnzGydyh48Sl44aMJPe9XM3/eGmgUsPpN6Ok=;
        b=KgRcq5GUkfIHyhYywtshW5aPG+rTjtJMWXA0WZAfRX8QS2EpSvpBh+KAllzFny7Bs0
         jMXY+0hAYFZEIgFWy2cjC+y2WTFX9P281Tm2m22GJ8kTwWSodeMyacYUuyY58dpwZTmh
         dbIig1JAKflHFjj5GDgg79KzxBWfyNdkTlM0jp7bUZwhvEffzWr5Gk9bL9pjmC8ACDww
         G2JpsPt8QToxuobGS0fDPsuGWqdPqpGhEK3aaUhw23YT7cWEO6FI8iyMtG7ARPvovm1Y
         +bYjnzuGvs4D8FUrob4Kovjvuh4Pzkqd+9VBsvxfT7Il5M0wjh0R8ASzeq4QExc3cZZ4
         sZDQ==
X-Gm-Message-State: AOJu0YyjHP3bnCL/XSzij2Re7fJiXrIwTEN+fMfMO3kHEpqbZsaHZgal
	Hv8yNOZDpmm/czZ9dyMQkznpEJgsBDPh6YK2tVACPgUWZzlc99B+
X-Google-Smtp-Source: AGHT+IGt/FpvLvPlF7EUcEV25iBcCsnfSLRIHfICXlxRWwml8gK9alBufQCfDuU5EegOoDBxaq9XhA==
X-Received: by 2002:a05:6a20:a092:b0:19e:987c:78a7 with SMTP id r18-20020a056a20a09200b0019e987c78a7mr2174763pzj.32.1707256252801;
        Tue, 06 Feb 2024 13:50:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX3Ovq2WxpVMntfpK1V1DILLNFZgqpzC4+84S9R9DhXYkx2r3+ypsqIkRTSKcaHYSsxYVtpAvgGVnEiro7zhUHRyleQvENp8uFiLDArlcohDxEX
Received: from brittons-large-Vivobook ([209.112.166.194])
        by smtp.gmail.com with ESMTPSA id z10-20020aa79e4a000000b006dd84763ce3sm2469480pfq.169.2024.02.06.13.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 13:50:51 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 496095202A1; Tue,  6 Feb 2024 12:50:50 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v6 2/7] completion: bisect: complete bad, new, old, and help subcommands
Date: Tue,  6 Feb 2024 12:50:43 -0900
Message-ID: <20240206215048.488344-3-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206215048.488344-1-britton.kerin@gmail.com>
References: <20240206020930.312164-1-britton.kerin@gmail.com>
 <20240206215048.488344-1-britton.kerin@gmail.com>
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
Add tests.

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash |  4 +-
 t/t9902-completion.sh                  | 71 ++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 2 deletions(-)

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
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index a5d4e900a2..7388c892cf 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1264,6 +1264,77 @@ test_expect_success 'git switch - with no options, complete local branches and u
 	EOF
 '
 
+test_expect_success 'git bisect - when not bisecting, complete only replay and start subcommands' '
+	test_completion "git bisect " <<-\EOF
+	replay Z
+	start Z
+	EOF
+'
+
+test_expect_success 'setup for git-bisect tests requiring a repo' '
+	git init git-bisect &&
+	(
+		cd git-bisect &&
+		echo "initial contents" >file &&
+		git add file &&
+		git commit -am "Initial commit" &&
+		git tag initial &&
+		echo "new line" >>file &&
+		git commit -am "First change" &&
+		echo "another new line" >>file &&
+		git commit -am "Second change" &&
+		git tag final
+	)
+'
+
+test_expect_success 'git bisect - start subcommand arguments before double-dash are completed as revs' '
+	(
+		cd git-bisect &&
+		test_completion "git bisect start " <<-\EOF
+		HEAD Z
+		final Z
+		initial Z
+		master Z
+		EOF
+	)
+'
+
+# Note that these arguments are <pathspec>s, which in practice the fallback
+# completion (not the git completion) later ends up completing as paths.
+test_expect_success 'git bisect - start subcommand arguments after double-dash are not completed' '
+	(
+		cd git-bisect &&
+		test_completion "git bisect start final initial -- " ""
+	)
+'
+
+test_expect_success 'setup for git-bisect tests requiring ongoing bisection' '
+	(
+		cd git-bisect &&
+		git bisect start --term-new=custom_new --term-old=custom_old final initial
+	)
+'
+
+test_expect_success 'git-bisect - when bisecting all subcommands are candidates' '
+	(
+		cd git-bisect &&
+		test_completion "git bisect " <<-\EOF
+		start Z
+		bad Z
+		new Z
+		good Z
+		old Z
+		skip Z
+		reset Z
+		visualize Z
+		replay Z
+		log Z
+		run Z
+		help Z
+		EOF
+	)
+'
+
 test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
 	test_completion "git checkout " <<-\EOF
 	HEAD Z
-- 
2.43.0

