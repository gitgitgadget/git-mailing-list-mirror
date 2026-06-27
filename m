Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1488D30C179
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782583350; cv=none; b=fnLFNhyi/vu+mJuxSrf5Ljwmttxce2yCW/0chdz5gUzk4ltzO5rSDAoSil8IbFHTf5HbsxQHMF9hpHYvf9mzFLMQEkfv3UJOnYxpLuhykiag+NfhSUh2OeZfPUO+7mATME+PW8V5vBHRsozAcliCi7sRjVMk0Tk0YmJbP+iLu6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782583350; c=relaxed/simple;
	bh=abBAkQEXjOh32C/7y7geuSopG1gq6cSOIZRO/jW+mII=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uRWnIqSxsDel0ENq2X2XNDudC3vufB9lnch14x6YrwRq1wLX7+xPRVI1eXVW57NLTadOonBBYL+Ia2apiQ+BO9iFiT7SLeBWJGu5KWCFKSjWx9rtmo82SzZctoAye47zYL1E3CyM61I4CI1zzkQ626erbSiPWbTRMTYstW0rWA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vgqby9T8; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vgqby9T8"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-13981833e13so2563335c88.1
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 11:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782583348; x=1783188148; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRfrgG4dhVmibtTnRw6QSAgLr0P44zomWP0nELMjpRw=;
        b=Vgqby9T84rufJlMm9JpB/Zr5fSyhvE8N+QAvg6oubxRhOvss+f8+kiicNK3kpqnXej
         d4+rfKgi4ovLbqRBKhmmWh3oMb8MQTQzdQVLOYAT1wsqoBDNt7F094sKZ/wFHW4ch53L
         hUmrztFyOB9yk37eBed0ZMSjUHWGObIhsII11A0MqibtAeHBNAvEHQYjZHNBlCM14HcB
         fTTyso/TyrioRDJGR/Vcvo3mS9xTwswu2lC0rD5uzjKdHL4Wnfz+6JbheVtnWVXIBVjK
         Vpst636VMFRXwZ1yq5jzCktfj2F3CxrrgC3abK2FcjybuqTYBxq29sKYQzAwGOdSOkTF
         nBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782583348; x=1783188148;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bRfrgG4dhVmibtTnRw6QSAgLr0P44zomWP0nELMjpRw=;
        b=OSaqcUVX6Q7KKTx6iLREombUGIsjziT6ZgRuwWXeFIWauZbUqbcyyHwDEnRuVVSV/F
         faFkDFx0fxOuxPjE42P/HMWk3IUwsj1E99Wxekuo0t+tFwevALbM/WV7SqGsmLNQ8wmP
         pn2pr2oGY4vHu6uPuIimrWgvyUS50k1cHC+bZY8/xOazMQzLcRviDEeBog1dnsGRwgLD
         AwD0sT/D/3dOJHe2Z4/Mr5Kqzl92gJrd7tsmiMkVoj7QFCn4l14JDGfJU+0pN3PJSLHT
         z0QhrpHyst4dpcHpTazI0qROZRkYQ3+j2aE0D8wLhFzdb31WNylvSAIMEvKjSuDnaIFc
         i9Pw==
X-Gm-Message-State: AOJu0Yy8SfpPWxVIvhGGLXBCJ6FUldtdjgxvpeJqnlNsGF0hv5bLqvu6
	hv6gtti1zKpK58Uxxe35a3usVAbD11BeLdIJ086LY2654T1AjBf6fK2XZYt+Pg==
X-Gm-Gg: AfdE7ckkHszRiewsOYQ65AdGIOVaFUiSk1Erpf0xjLRnSUOa11C4GtkBiRdEjFXYy+d
	NFHKhCNIHDbZwxmmw+E6FBhYiMXv3SrtGsogxCV5FJgILNovvAF0WRydrWnxVDHryDynAksYnDx
	vvVdSXB0NJMBssH9DWBw38QJgn2n87HqNy/Hr6fVONhianterbNKkHTmO1quozrmIbqyoVoUk0R
	9W+ltwu2SqAaEcvuP0BV3VwjUqgcC19diSKcQ2ligr0cOv4jejGonmZoGTIZjw4inqWrEdQXqtb
	+tg0rAShSUwBRfQAFAmCMAuoBN7aClcrTi1uhyfLQ+hq6wllqvLsCiAWooGQ5tQvUhmRH5bAN1x
	dN5OuNrjBvU2VHmr2oosITuf9cISdqKxwdXJrN/Kls3aw94Zbz5finYn6f82/8DQ1iN4FzOxn+i
	j7x6nYQT+Ic7qoFPYI
X-Received: by 2002:a05:7022:318:b0:137:f875:c1e8 with SMTP id a92af1059eb24-139dbac326bmr8545402c88.19.1782583348090;
        Sat, 27 Jun 2026 11:02:28 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.213.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139e4c33af7sm16136871c88.5.2026.06.27.11.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 11:02:27 -0700 (PDT)
Message-Id: <9883c28482be4ad43f0f999c2e6be9f9dd9fb13b.1782583345.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2331.v3.git.git.1782583345.gitgitgadget@gmail.com>
References: <pull.2331.v2.git.git.1782338114.gitgitgadget@gmail.com>
	<pull.2331.v3.git.git.1782583345.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 27 Jun 2026 18:02:24 +0000
Subject: [PATCH v3 1/2] branch: suggest <remote>/<branch> on upstream slip
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When setting the upstream of the current branch to the 'main' branch
of the remote 'origin', i.e.,

    $ git branch --set-upstream-to origin/main

it is easy to mistakenly write

    $ git branch --set-upstream-to origin main

That is parsed as a request to set the upstream of the local branch
'main' to 'origin'. When 'main' does not exist, the command dies
with:

    fatal: branch 'main' does not exist

pointing at a branch the user never meant to name. When 'main' does
exist, it instead dies with:

    fatal: the requested upstream branch 'origin' does not exist

leaving the user equally puzzled.

When the operated-on branch is missing and '<remote>/<branch>' names
a real remote-tracking ref, suggest the intended form:

    $ git branch --set-upstream-to=origin/main

The suggestion is gated on '<remote>/<branch>' existing so it only
appears when a slipped slash is the likely explanation.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c  | 32 ++++++++++++++++++++++++++++++++
 t/t3200-branch.sh | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 1572a4f9ef..dede60d27b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -706,6 +706,29 @@ static int edit_branch_description(const char *branch_name)
 	return 0;
 }
 
+static void die_if_upstream_looks_like_remote(const char *new_upstream, const char *branch_name)
+{
+	struct strbuf remote_ref = STRBUF_INIT;
+	int code;
+
+	if (strchr(new_upstream, '/') ||
+	    !remote_is_configured(remote_get(new_upstream), 0))
+		return;
+
+	strbuf_addf(&remote_ref, "refs/remotes/%s/%s", new_upstream, branch_name);
+	if (!refs_ref_exists(get_main_ref_store(the_repository), remote_ref.buf)) {
+		strbuf_release(&remote_ref);
+		return;
+	}
+
+	code = die_message(_("--set-upstream-to takes a single <remote>/<branch> argument"));
+	advise_if_enabled(ADVICE_SET_UPSTREAM_FAILURE,
+			  _("Did you mean to use: git branch --set-upstream-to=%s/%s?"),
+			  new_upstream, branch_name);
+	strbuf_release(&remote_ref);
+	exit(code);
+}
+
 int cmd_branch(int argc,
 	       const char **argv,
 	       const char *prefix,
@@ -957,6 +980,15 @@ int cmd_branch(int argc,
 		if (!refs_ref_exists(get_main_ref_store(the_repository), branch->refname)) {
 			if (!argc || branch_checked_out(branch->refname))
 				die(_("no commit on branch '%s' yet"), branch->name);
+			/*
+			 * Check the advice up front to avoid the ref
+			 * lookups when the hint is off. The helper still
+			 * calls advise_if_enabled() so the hint carries the
+			 * standard "disable this message" instructions.
+			 */
+			if (argc == 1 &&
+			    advice_enabled(ADVICE_SET_UPSTREAM_FAILURE))
+				die_if_upstream_looks_like_remote(new_upstream, argv[0]);
 			die(_("branch '%s' does not exist"), branch->name);
 		}
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e7829c2c4b..e2682a83a0 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1022,6 +1022,44 @@ test_expect_success '--set-upstream-to fails on a missing dst branch' '
 	test_cmp expect err
 '
 
+test_expect_success '--set-upstream-to suggests <remote>/<branch> on slip' '
+	test_when_finished "git remote remove slip-remote" &&
+	git remote add slip-remote . &&
+	git update-ref refs/remotes/slip-remote/slip-feature HEAD &&
+	test_must_fail git branch --set-upstream-to slip-remote slip-feature 2>err &&
+	test_grep "takes a single <remote>/<branch> argument" err &&
+	test_grep "hint: Did you mean to use: git branch --set-upstream-to=slip-remote/slip-feature?" err &&
+	test_must_fail git -c advice.setUpstreamFailure=false \
+		branch --set-upstream-to slip-remote slip-feature 2>err &&
+	test_grep ! "Did you mean" err
+'
+
+test_expect_success '--set-upstream-to does not suggest when no matching remote ref' '
+	test_when_finished "git remote remove slip-remote" &&
+	git remote add slip-remote . &&
+	test_must_fail git branch --set-upstream-to slip-remote no-such-branch 2>err &&
+	test_grep "branch ${SQ}no-such-branch${SQ} does not exist" err &&
+	test_grep ! "Did you mean" err
+'
+
+test_expect_success '--set-upstream-to to a local branch is not mistaken for a slip' '
+	git branch slip-local-upstream &&
+	git branch slip-local-target &&
+	git branch --set-upstream-to=slip-local-upstream slip-local-target 2>err &&
+	test_grep ! "Did you mean" err &&
+	echo refs/heads/slip-local-upstream >expect &&
+	git config branch.slip-local-target.merge >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--set-upstream-to slip suggestion keeps a slashed branch name' '
+	test_when_finished "git remote remove slip-remote" &&
+	git remote add slip-remote . &&
+	git update-ref refs/remotes/slip-remote/slip/feature HEAD &&
+	test_must_fail git branch --set-upstream-to slip-remote slip/feature 2>err &&
+	test_grep "hint: Did you mean to use: git branch --set-upstream-to=slip-remote/slip/feature?" err
+'
+
 test_expect_success '--set-upstream-to fails on a missing src branch' '
 	test_must_fail git branch --set-upstream-to does-not-exist main 2>err &&
 	test_grep "the requested upstream branch '"'"'does-not-exist'"'"' does not exist" err
-- 
gitgitgadget

