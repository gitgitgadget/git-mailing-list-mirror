Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FD259B55
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707185383; cv=none; b=d0aSF2+l97WYrzl8BGCi1HA5PUlUiGPzWYdiV5GWr3TL8rWLTNnGSyJiM85rsoyubHvsNYvd0PWI2BThvsInZ8gIW/YJKziYc2gP4JJWBDfOeMadhl6m48Z9snBkNsQqPh4GzZrkr5gciHaGVJJAAOwzvSrZZnfFPMsl1vYX9TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707185383; c=relaxed/simple;
	bh=4avKA/ZQ6lx+d8v3SqCQ9dDFNtUzvxnfRKhFHORGoPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3bl7pOINM20knhYTmRGyXw04I2h8FLLI1KxPdB9K4dIPiSdtEGvll+qNCMG9Pp8AskW3GCd2eI2glqqhEaiI2T6YoBhJaiYNVTmO2ERpA+P1MUbBuJN+2+h8WawB3Tbep6XYyzkteROgDEJ3nn5DZthGwHDBxewRPxtHhbPD+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4L8JSzp; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4L8JSzp"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8b276979aso354763a12.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 18:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707185381; x=1707790181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUP7isu8qBoKMuGagew9XpTqWYBY7NMocgW32KhuTi4=;
        b=I4L8JSzpFPqyEhourwOw1VXfZ7qxhIm533/tHPGdRlvRP1WraX+w1BWUBCbGpb4SVp
         Sgwj3jFRNBl3egfRcickcF8eX+tu/anburFHp9izEt9zsM01b7bIMry7YR8aWOsrlrih
         BXYUcLlfyJxaL0MDCV3N9JNNonGO5I7nhqf/J/gUnJKMWlHKpZSb6rODRU58ROpOZ6pU
         3PIu0LK0qMBq/uVWOpEl/P6U214EMQrQ8Wq75yLLLbtUiItN+yzmfy09sjZE12UM9E5D
         Q2ynE8QRzzMrOuFgOJSpHz5h7OxXVpJZ9eUdIzahF8m0PsHF/C5McVtEMdTRKg4Azq7z
         PikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707185381; x=1707790181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUP7isu8qBoKMuGagew9XpTqWYBY7NMocgW32KhuTi4=;
        b=M3Gaa/BSyRlhxYQqpE8JuW0xaN5vXh6P1ltqLVtg/6DJDcB6tY3tkV+bayUux1z82q
         a6nDe6cYiKlOsSEPPqPY07ghRptx66eCTwYMLR9QP05xIoLlaBXLP1L4skc1Fug9Sc+z
         Vb8uef0Q8D62eAVM3vc5PySi2ThpHsPqWr3UfFbs5KGua/o/q/A+g1K08C2hx/i2/F0U
         W5a9BfqdimDAxmKXl29vUrxdOL4PSTT786ktI51VUDW9zD1eer/jnFhpZrhGT+mpKJx/
         pwvQsg3z5zhVxO1Ek2hHXt88rr5NAM+bOJEk5BLZ6TJneyto0p2Y2LvoLwKUGbw8XQC2
         8aEQ==
X-Gm-Message-State: AOJu0YyBxmThoY4onDXTvG9PGrzjx6/hM6kebEWaMRGUyoxMJo/Bu+6H
	nfpqdjblg5NzL95U5YUivraWItCoCpxqtKNJkDh2nhq/abytt8wYSANIoNaMk68=
X-Google-Smtp-Source: AGHT+IFb6e8SoBS+jIdEbhEnPOTn1oMOKgn24x4BMj3NuTqbQg9Bf9QAFoTopF5ucK+WHh3bSwpjBw==
X-Received: by 2002:a05:6a20:a326:b0:19e:30b2:bee0 with SMTP id x38-20020a056a20a32600b0019e30b2bee0mr248650pzk.34.1707185381156;
        Mon, 05 Feb 2024 18:09:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUi+P7EnlC0AZyeICHA6Lj0QomkyTY0f/lcyKTVgmhCbpmlMRsxt0cZHaTViN5WC/57jYv6CfBuU2pvnkj2dLJtw9wNgqodcyyOpUKdsGQV9VnM
Received: from brittons-large-Vivobook (mobile-166-171-250-223.mycingular.net. [166.171.250.223])
        by smtp.gmail.com with ESMTPSA id t27-20020a62d15b000000b006e04efcfbc2sm615095pfl.74.2024.02.05.18.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 18:09:37 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 82968520299; Mon,  5 Feb 2024 17:09:31 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v5 6/7] completion: bisect: complete log opts for visualize subcommand
Date: Mon,  5 Feb 2024 17:09:29 -0900
Message-ID: <20240206020930.312164-7-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206020930.312164-1-britton.kerin@gmail.com>
References: <20240128223447.342493-1-britton.kerin@gmail.com>
 <20240206020930.312164-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arguments passed to the "visualize" subcommand of git-bisect(1) get
forwarded to git-log(1). It thus supports the same options as git-log(1)
would, but our Bash completion script does not know to handle this.

Make completion of porcelain git-log options and option arguments to the
visualize subcommand work by calling __git_complete_log_opts when the
start of an option to the subcommand is seen (visualize doesn't support
any options besides the git-log options).  Add test.

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash |  4 ++++
 t/t9902-completion.sh                  | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8c3b1b8e96..b4cd94182e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1490,6 +1490,10 @@ _git_bisect ()
 		__gitcomp "--term-good --term-old --term-bad --term-new"
 		return
 		;;
+	visualize)
+		__git_complete_log_opts
+		return
+		;;
 	bad|new|"$term_bad"|good|old|"$term_good"|reset|skip)
 		__git_complete_refs
 		;;
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index f4d3aa67e3..74132699b1 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1360,6 +1360,20 @@ test_expect_success 'git-bisect - options to terms subcommand are candidates' '
 	)
 '
 
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
 
 test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
 	test_completion "git checkout " <<-\EOF
-- 
2.43.0

