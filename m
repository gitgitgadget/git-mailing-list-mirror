Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5E14C629
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706481304; cv=none; b=uaU/a8FL+XgdLet8/gdhAQ4cqnfybnuvzSDUCzE55s0X0e8GmV6Hr7ZN0HTunDqBwvMEpR7c7GkvAGGDIQ3xTWTCTXz+WcgX8xIwiK6QEl2IaAXoyhVMv4WSNv5ej3qKnAyLb11Zf1SGfzeZxrtQpkAqfe9OEvHZZLRtsRfaF6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706481304; c=relaxed/simple;
	bh=hfO1pJTRmo8pyRqIWC89UVk69ySeYY953YxSKoSs1oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qx0r5gtKd4gbKcRsdGwC2RLT1I33BHNPCC95Kjyenhqnqx9/Jt0v+tdWe44E4Jf7+yakhrj/SjhM3vScn6FEVApTVy35LcDQEsJyQA3SwIKifdGQGB4JeUcC9dTxBUGhIDuYwjPuewukUTUfKobYbRdF7L0zLQ5rf0wHR/MEt3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJ5MScT1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJ5MScT1"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d51ba18e1bso22036315ad.0
        for <git@vger.kernel.org>; Sun, 28 Jan 2024 14:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706481302; x=1707086102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dsf0Uhi761DKIrcydqAnu74mD2RbuAw96sc1uH2tMec=;
        b=NJ5MScT12rxCWDLx8ASWyAGu1qyXiJ4L3785uIgxoKZdBVnsquepLZVFN18mrnvgCx
         +q6oFiW0FBSdiIam+1cpIk//Nv8JBTGGBBSpo/0jDxqRqQTHTGpbFZakDcyIJcmrTNu/
         ZB6u4akZyYzM1VWZVhpT/ke8ca71ard/LoCMeBHLlwqu4BluOF+DMkr79kQkKoiU0wD9
         J57DRg0GogOZLhGmyrTiC9Lp9wWn3OHxjIVAQBfzaRMN8rXcrnMRWFrfWsuogNlteg0y
         U0AqLHifU3fPJrI1t32W0Q4s5YabuFzBEi9ZHosMfxdT2T9JgAM0dS3fJpODfxaZz3lC
         rmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706481302; x=1707086102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dsf0Uhi761DKIrcydqAnu74mD2RbuAw96sc1uH2tMec=;
        b=iQbP1P7tvP3A8sV+zXJG81enoDBxtgwJZsNjYLt4r0WLdaz0xK+GZPgKCqlF3XUAGg
         v9HZc3o6m5Ol3UGUiD1xZhaxPIkn9b/f2q1Qul5eViJEoWr7ZhINMU1nC9dD8TpoKhZ+
         WJ3hyz7AY1oGhFPsQb1D/1FYI7vxauZrZuMIcpxxEmPqJoFZnipwRZFoep+7G2UaVk0c
         MwVM48QDLZAT4rGomQilT5WBpBGfsbl8LtKYJC8EKmDt5dn/sVOtZ/AKpa/zuE1PdAtF
         l/F7gO41m5d0U6+BtgWIvWEv6o3Y/t+oZOSrsQ8Fvg5QusWzVIxxzepPanNaSVZWsr4b
         5lzA==
X-Gm-Message-State: AOJu0YxSUt72WEaTLrZe2h+9cvtKfu1o/sWARCsJ5+BdAx/MkNoquPJh
	/VPbuQtLavEAMlVkboRox556p69Ha5AsSF8d208rwIH0Cbd1yPjt
X-Google-Smtp-Source: AGHT+IHF9D94jtDYAeSKWqAXy5s+WEUbNCJtmVyJLG5MhrGR+NSRwjmNBGWyiI1KUxEgEju6YpYYHg==
X-Received: by 2002:a17:902:9f90:b0:1d7:204a:f7fe with SMTP id g16-20020a1709029f9000b001d7204af7femr3809156plq.61.1706481301839;
        Sun, 28 Jan 2024 14:35:01 -0800 (PST)
Received: from brittons-large-Vivobook ([209.112.166.194])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902ee4400b001d8ceaa1a5bsm1301600plo.304.2024.01.28.14.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 14:34:57 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 74EF452053B; Sun, 28 Jan 2024 13:34:50 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v4 8/8] completion: add tests for git-bisect
Date: Sun, 28 Jan 2024 13:34:47 -0900
Message-ID: <20240128223447.342493-9-britton.kerin@gmail.com>
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

There aren't any tests for completion of git bisect and it's
subcommands.

Add tests.
---
 t/t9902-completion.sh | 135 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index aa9a614de3..698e278450 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1259,6 +1259,141 @@ test_expect_success 'git switch - with no options, complete local branches and u
 	EOF
 '
 
+test_expect_success 'git bisect - when not bisecting, complete only replay and start subcommands' '
+	test_completion "git bisect " <<-\EOF
+	replay Z
+	start Z
+	EOF
+'
+
+test_expect_success 'git bisect - complete options to start subcommand' '
+	test_completion "git bisect start --" <<-\EOF
+	--term-new Z
+	--term-bad Z
+	--term-old Z
+	--term-good Z
+	--no-checkout Z
+	--first-parent Z
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
+		custom_new Z
+		custom_old Z
+		new Z
+		good Z
+		old Z
+		terms Z
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
+test_expect_success 'git-bisect - options to terms subcommand are candidates' '
+	(
+		cd git-bisect &&
+		test_completion "git bisect terms --" <<-\EOF
+		--term-bad Z
+		--term-good Z
+		--term-new Z
+		--term-old Z
+		EOF
+	)
+'
+
+test_expect_success 'git-bisect - git-log options to visualize subcommand are candidates' '
+	(
+		cd git-bisect &&
+		# The completion used for git-log and here does not complete
+		# every git-log option, so rather than hope to stay in sync
+		# with exactly what it does we will just spot-test here.
+		test_completion "git bisect visualize --sta" <<-\EOF &&
+		--stat Z
+		EOF
+		test_completion "git bisect visualize --summar" <<-\EOF
+		--summary Z
+		EOF
+	)
+'
+
+test_expect_success 'git-bisect - view subcommand is not a candidate' '
+	(
+		cd git-bisect &&
+		test_completion "git bisect vi" <<-\EOF
+		visualize Z
+		EOF
+	)
+'
+
+test_expect_success 'git-bisect - existing view subcommand is recognized and enables completion of git-log options' '
+	(
+		cd git-bisect &&
+		# The completion used for git-log and here does not complete
+		# every git-log option, so rather than hope to stay in sync
+		# with exactly what it does we will just spot-test here.
+		test_completion "git bisect view --sta" <<-\EOF &&
+		--stat Z
+		EOF
+		test_completion "git bisect view --summar" <<-\EOF
+		--summary Z
+		EOF
+	)
+'
+
 test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
 	test_completion "git checkout " <<-\EOF
 	HEAD Z
-- 
2.43.0

