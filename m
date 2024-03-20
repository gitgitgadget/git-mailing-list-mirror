Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6128613E
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 23:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710977956; cv=none; b=JDCDzr425Vis7EA8Pudz1ftx8W5TEGpfqyoYRyC3XI6ePR/uATyCjEfF0ZmKa5d7h5Hr3xqIjDcbZHoUgdPejef/qwwIjBSDe1xKb6E421Ca81tACz0f/vqR3E53fGDZV4JV7iue/V+RI5wnt+ySZtfHLoP99m5A+vc8sBaXWRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710977956; c=relaxed/simple;
	bh=7vi9xEIraSQTmgrxuX9lWfU89wiQ3Rx44ve0Uy/5DOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxTIhoTkLaicFCDAqdrj2pf0G388glHqEsgWXDgBwPNRtgFprcll3sgmZZ+76UoDe4Q+bpDm/4VbABE2FO9rxwAQ/XC0aBnX+yl2VaLoZ7T11sUoKdBJvWu35IJ69kB1/tETdEPDFhvauSDt8q1uXZuCzAwGmv1QkzDBNO5cnIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdVmcR73; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdVmcR73"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78850c6609bso20399985a.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 16:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710977953; x=1711582753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtZyJeuKt/HRxb8Ihb0j/W0T1+psaZxhXjN6gBA936M=;
        b=PdVmcR73HOwrnWgmt5xadSHTC9JVxLy437O1iaKp6MEQh0xXqq11UqfOX5p4ZVcYIA
         S82r37ux4WCTZoL6miAjXeUltvlI1akMBoz8RJnXyGznbiZUmTq9MxjDL7yO/Wt+42t1
         70jQefx0zW/e0wU1YsOAM58ElET0mCbHko9UW4PdFYUem45N1Ml+OSi/MWLUmxyu7W7N
         OmC8np9d9VZeEDWDMXTarQbtK76z5Qk582fofURL9ztp0m1VqwJcIiidrRbhrk5bKt1m
         tVT+cS6/8NrdaHY5V2DG6zif7/8QnMoGZcZO9oDSNjzpAzIFHCf/C6lwiJZ0FCwvI8Xp
         M0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710977953; x=1711582753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtZyJeuKt/HRxb8Ihb0j/W0T1+psaZxhXjN6gBA936M=;
        b=rfEIptJFHYwrrlUs/f1n4rDmoIfvBzYEWyynL4JjtNdGENIQSpxP/IMmPopgsUNlmv
         tez2BLJ2Y2clUyzp4rtqKmpFPi1NLaCa1SuuLS/jGxYhn+0hLM/9SY/0nk2KngxhccHn
         izpZWXJaEaYXjXH3qM6aFAxgjicygcFBOaF+QJo+NwPFwTLG9M95Lusts6yaVS+IJM8P
         ly7KDH07C+QxSkgG0a1Hh43FOeIcKyYrwoMQDBw4Mj53ByRx3MtelXo0mv6WV6H31TPr
         VoAFw9Pa14jZ72XV4T6/oWmRiB+Tc5cjxoe3LPH+tqtHxglZAcs8Yl4dFZlympSe2s9X
         v0rQ==
X-Gm-Message-State: AOJu0YyJLMYS27IMV7Om4SDmrHOnhwecMKK6FqHC9YDHM4ftBQpMjCAw
	+sbe0EcX5G+kDQ1ZGs8pFI9zG7svrhlH95G7POF9u3NFDgx+Ql/yLum4k0aN5pY=
X-Google-Smtp-Source: AGHT+IFirGrTOX0szZRJJ4YARkFv6teDSCiC/7v6b1eOAog0psxxXe8iURXX4XB7HABomRT9ycKXGw==
X-Received: by 2002:a05:620a:84e:b0:789:ea39:50c0 with SMTP id u14-20020a05620a084e00b00789ea3950c0mr346171qku.33.1710977953104;
        Wed, 20 Mar 2024 16:39:13 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id v18-20020a05620a123200b0078a0edbaa94sm2400867qkj.91.2024.03.20.16.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 16:39:12 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 1/7] docs: address inaccurate `--empty` default with `--exec`
Date: Wed, 20 Mar 2024 18:36:56 -0500
Message-ID: <20240320233724.214369-2-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation for git-rebase(1) indicates that using the `--exec`
option will use `--empty=drop`. This is inaccurate: when `--interactive`
is not explicitly provided, `--exec` results in `--empty=keep`
behaviors.

Correctly indicate the behavior of `--exec` using `--empty=keep` when
`--interactive` is not specified.

Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 Documentation/git-rebase.txt | 10 +++++-----
 t/t3424-rebase-empty.sh      | 38 ++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 06206521fc..3334e85356 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -295,11 +295,11 @@ See also INCOMPATIBLE OPTIONS below.
 	empty after rebasing (because they contain a subset of already
 	upstream changes).  With drop (the default), commits that
 	become empty are dropped.  With keep, such commits are kept.
-	With ask (implied by `--interactive`), the rebase will halt when
-	an empty commit is applied allowing you to choose whether to
-	drop it, edit files more, or just commit the empty changes.
-	Other options, like `--exec`, will use the default of drop unless
-	`-i`/`--interactive` is explicitly specified.
+	With ask, the rebase will halt when an empty commit is applied
+	allowing you to choose whether to drop it, edit files more, or just
+	commit the empty changes.
+	When the `-i`/`--interactive` option is used, the default becomes ask.
+	Otherwise, when the `--exec` option is used, the default becomes keep.
 +
 Note that commits which start empty are kept (unless `--no-keep-empty`
 is specified), and commits which are clean cherry-picks (as determined
diff --git a/t/t3424-rebase-empty.sh b/t/t3424-rebase-empty.sh
index 5e1045a0af..73ff35ced2 100755
--- a/t/t3424-rebase-empty.sh
+++ b/t/t3424-rebase-empty.sh
@@ -167,4 +167,42 @@ test_expect_success 'rebase --merge does not leave state laying around' '
 	test_path_is_missing .git/MERGE_MSG
 '
 
+test_expect_success 'rebase --exec --empty=drop' '
+	git checkout -B testing localmods &&
+	git rebase --exec "true" --empty=drop upstream &&
+
+	test_write_lines D C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --exec --empty=keep' '
+	git checkout -B testing localmods &&
+	git rebase --exec "true" --empty=keep upstream &&
+
+	test_write_lines D C2 C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --exec uses default of --empty=keep' '
+	git checkout -B testing localmods &&
+	git rebase --exec "true" upstream &&
+
+	test_write_lines D C2 C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --exec --empty=ask' '
+	git checkout -B testing localmods &&
+	test_must_fail git rebase --exec "true" --empty=ask upstream &&
+
+	git rebase --skip &&
+
+	test_write_lines D C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.43.2

