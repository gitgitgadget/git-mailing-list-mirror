Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F5540FD9B
	for <git@vger.kernel.org>; Thu, 14 May 2026 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769254; cv=none; b=unbaHJ+dxO10h3V9MU0pSXVOs9CHL9/ldri9ikRrAJbc8juMxCGGvL6BHGn1u2AsTlnBtAuhY5LkIYVOyIHArNIdN5mUntv2/nzWCJtq4PAzNdjC7OqjDzrebesDrfdHrqhJQi34qcMN/F/O3fzAI4t29dkDDF1i/dWWB7e5IjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769254; c=relaxed/simple;
	bh=qR+OyoTMbVqAI10JnfLuZ/K3VhkHMtGmAq0o6xNBzEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6c5s3LTNCcQrKKUxfWGGOLhLWPNuT79+D9Fn4gF1TnHjtVjT8h2WoLM7mMyBS8VqXbUkx9RoDFFaDwTVn0RW2lBRKfzG91lgeFS5jekCQIjFRq/sJuOOivyok8vD/okyDCZyAKnemaYpu3AU2d+/KuulTCnLSSFmr/QS37J5z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctZ3GlpX; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctZ3GlpX"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-910f734b477so76672985a.0
        for <git@vger.kernel.org>; Thu, 14 May 2026 07:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778769251; x=1779374051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AJwr8EWuyhHrAq2V1myfrnYsKQEVZwvjUqHpfRNkyY=;
        b=ctZ3GlpXl82iFziGxap5kqUyhNRupWne5q/P4D5E8LtuApuiZky5OwaaOUFxtx4JgM
         hai7l1pzwtfOvSBdIR8lcNF7WYRokrUsuZjQnCyt8PeL5Ju2cSKZ/aQPEonGNQKW8yBb
         k7eIUhDne6S9xOnxtMXyLEwqFVW0qNtO2GZ3o87B7k26YLWR7nY/D/a3iVpAzOMv0q9B
         Cd9O4j2rM7R/n3B9roXK+uRT8HYK4R9eNT21TXzMmXaT8CAxagJu26JmwrIhCOs9RHDc
         hcglqfGLrsJnW4EdOyGhI1ypAkdbYxc9WNvFJ/7j8Q1IhUJ9HyOycavFcKdrD1Jz277x
         LnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769251; x=1779374051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/AJwr8EWuyhHrAq2V1myfrnYsKQEVZwvjUqHpfRNkyY=;
        b=FIScIKxTky7Ai2JHjtPOsAJfIM09LevZZNCGrJcr91zctV11S5ERzJFJyL65MFwGFg
         QcmEyJmC+nPr0iAYpbg8CapY6o9nMl2BnGCwGzkM7BK7qqIgsKkAFbg6Utb0+8DBe7Gv
         MZs9G+DwabGDldX6UNMrAN1O08MmZFoTZJljFr55eRQKCuWyCr2ZzIuTY1/yXr8jq90L
         Qk/Kvplat897YQr7OmFmUa+pgYe4WlExy1pTsh0PsV3C36SmnshejH64vR4h1ulbLEIx
         2NuC8udTBnziwSUKo+umdc2C29seYRVrWX/N67pjpn/Wc8C/UbYxhYeU0Xw+oeMfuK3q
         ZDFQ==
X-Gm-Message-State: AOJu0YxodAvTEugxaqF2wYKXWzZkHInvjAwciIwniCpp6cz6uu6ciu1b
	uYjNUHaFtoWtdUyk4oVJjLEnVMRNPwFEs2mrRtcYlZBxPw3E9vbyf9A/nMLMf7FR
X-Gm-Gg: Acq92OEjIimEa5XY1cXLwztFtxhmngmXZ/aH1w3guFI5GrydAEfsVFI2J6e6eNk9o6w
	8bzIWdskUbRT8h3vWB6XwpHPJ9YSQn6ad5X1SBzQZqfyTuQU4dZKwyvRYPsi/bKl525FAKzafgx
	FT2KnU9ME18Bqkl1GTbiE9u9OSdPOwa/7Ozfo/MID6a6G7WvXcgPYMIc+sRmw2TBDnsltm1xGRL
	O+jqFJoCmMFJg9dpcevQYXta9RHrqTgI6DzpxChajo0VaFGkmeqLNpgE5L0JByH8HvXVRSr5/xx
	W18shWkbn5gNcou/vFkY9psHBCK9anTS+8SlZte+l0MhUQaCObrj5aT/8ELwBuytTxahitRaLWu
	R1/CKvhmFaOJP48D1vx+nv3M0du2oOY2K1IjWpLi7+XPB6HkWdbjh5mtQ0+21E4OuLR24UfcS4w
	zHIoLMli8=
X-Received: by 2002:a05:620a:3721:b0:8e9:13ea:a0e7 with SMTP id af79cd13be357-90f8a730c52mr1219584085a.41.1778769250763;
        Thu, 14 May 2026 07:34:10 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bad2dd8esm262768585a.19.2026.05.14.07.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:34:10 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: egg_mushroomcow@foxmail.com,
	j6t@kdbg.org,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v1 09/11] git-gui: support using repository parent dir as a worktree
Date: Thu, 14 May 2026 10:33:20 -0400
Message-ID: <20260514143322.865587-10-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260514143322.865587-1-mlevedahl@gmail.com>
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-gui, since 87cd09f43e ("git-gui: work from the .git dir",
2010-01-23), has had the intent to allow starting from inside a
repository, then switching to the parent directory if that is a valid
worktree.

This certainly hasn't worked since 2d92ab32fd ("rev-parse: make
--show-toplevel without a worktree an error", 2019-11-19) in git, but
breaking this git-gui feature was unintentional.

Add a proc to test if the parent of the git repository is a valid
worktree, and set that directory as the worktree if so. Use invocations
of git rev-parse to assure all validity and safety checks included in
git-core are executed.
---
 git-gui.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index a03eaa7..e326401 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1100,6 +1100,23 @@ unset argv0dir
 ##
 ## repository setup
 
+proc is_parent_worktree {} {
+	# Directory 'parent' of a repository named 'parent/.git' might be the worktree
+	set ok 0
+	if {[file tail $::_gitdir] eq {.git}} {
+		set gitdir_parent [file join $::_gitdir {..}]
+		set expected_worktree [file normalize $gitdir_parent]
+		catch {set git_worktree [git -C $gitdir_parent rev-parse --show-toplevel]}
+		if {[string compare $expected_worktree $git_worktree] == 0} {
+			set ::_prefix {}
+			set ::_gitworktree $git_worktree
+			cd $git_worktree
+			set ok 1
+		}
+	}
+	return $ok
+}
+
 proc is_gitvars_error {err} {
 	set havevars 0
 	set GIT_DIR {}
-- 
2.54.0.99.14

