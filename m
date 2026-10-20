Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520359;
	b=WA6d2yyaz5yevOCpKfzKM8CJDaMBwkdLlEWo4oAPIhnnYtwDBItrOYytZqKq/uXgNYA5
	 W6hgDIKK7a/RR6IC1W1c9jqC9+BXYXLFZCV8wMychQwzK1GrNvt7rctQIwTINkZNtgj4D
	 ujv5MKmb2K7qFuC8IvX+rcpPElVeP/8dTbILRwApgWyj4UulpRT7cS5DWyJR2B47xMqBT
	 zHmzmhd0rmKF1idVMAtzr6/LbUNdMJEkRZkvgqFzyU5Z1TQVsWA23swYepvdgqGwL5ff/
	 /lCgEoJo5HCyNoAK1qIQRh9RF/ySpg0dlp91doScDQd5CkrdqVDzGjzk3D/7Kle1snA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=anUtZPGdoaCjKf4Ht/1ETqaA1PoaFAxJqG6pPt1CKvY=;
	b=smxFCcUtuggf+JOiQ19DEZJtPJGbbAK/yHEzmERkJmr9gOplIjDrfgaROdHJ3tvwUdJ5
	 NBQVc9pXUHbO7mq2XM89YVaDVkIWH9x2KyXzC41TiFQEJuuqjl3BwWRSpKK2kMzh88AMt
	 Z9ZpguTs4nprGwETkHGNgeyuFG43Z31IIt8BZNMqAPtipVXAaw4pJmDr+VsG404K8QdCD
	 ugu+pu235dIf24Y7pjVqJHFn1yJT9qUIc0uVO566smbJNGYmAu9UhycGs3pAzbRTXYuiW
	 a1XK8gC/cJ9kpjh2R7qauwPtLeaIFIzxaEq0FFnKWf26x/vvf2OwkLyuybXPCcNVbuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="czdsXK/z";
	arc=none smtp.remote-ip=209.85.160.44
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DF860A262D
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 18:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38DF860A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=czdsXK/z
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-48e94879f02so1122824fac.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 11:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792520358; x=1793125158; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=anUtZPGdoaCjKf4Ht/1ETqaA1PoaFAxJqG6pPt1CKvY=;
        b=czdsXK/zG5OiPVvNTIaM9qhJ9K42ZMb0potJkcHXnVC8Srt7UiY2S94KdCpHpkQdSj
         nhTzws8KM9WsARwnEHBcDVoiayoQktGzOGmw2HO9qEaN3aLaMtJuInt/kbwEaXzhLALb
         y/vYLHcbvKdLLxtwxdmziI3/43LSyLB1gZiAerggL0G+gUcvM6ErTAdi1/ASHYnmirCe
         NqiCbll+evjB+rxYAktAcwwnGELXooNkMHlOUcGcg5ooEcNNHqRVaYPgLHYuNatYrj6Z
         kg53iB6CttTRzEUWZM9zCO23nV+PSB4+H1qXhIRSV631rmnVSXEW93idbShp1kJlNhGR
         ImCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520358; x=1793125158;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=anUtZPGdoaCjKf4Ht/1ETqaA1PoaFAxJqG6pPt1CKvY=;
        b=JCjrNlVvuR+khUp/t/yPHsw7Iqv6bNLmmLMafstBzLFmNS0cZD64tGYHeb5Y2hXL+e
         +zwAX3OZ2QdOhjvzwcklIfWJNqUH6bfNlnLyaAgzSpjkWkabDBf9FqEiGPQOXOnmVSsh
         PwOF1MMR2/9iXmhBNx3NPB3sVrEViU5UNqTLo8M/Vuk6pKMWvlCsK5wBEjhgiH8Ts7aN
         ex+d0YkoyDpKQ6USUD/yh6B44ieL2xdsYgB02IPfbmbCpa+beffeFaC/7jWIRFBgBcZX
         hrqKOwhj4q/7g4a69rJ147J4OFQOgjTj1WbbUhwl35i/1AQD5g88GZJPb5xnhmK+Ugni
         j1Zw==
X-Gm-Message-State: AFq9FYKF5c9uT5okiGdD0EDWj2PIEU+x9NkwcnnsNxfotWig+A99xCCf
	mCOIFe37f8NZbvyw6voI8EpAfQV775/He+CaNwJCZYlYEnrSODbLSOVhvy1vQ6fD
X-Gm-Gg: AYBFou37Pb4PlcAamnPmkGD+qBsA/mcl/GDAfout5Zs41CCoq/2G61FXYPSqVvECKkz
	w6fpHeAC3OJWhewtpad0WGaFMw2j3XoF/TmFlL6vPVtY0Bx2UKezZFed2XCBqR6LXWJifAkqRfQ
	KIU+VcE2fDbvdwmrqSJlvJlRMCNFJHE0zOYOw8ojw8mfIoOqTQEqr0QwbdfgFAQZu0hibgmHmE4
	yRQHALdrFLckVCumzvPE64Tyf7N7UAHfpzYrhkDvF9nrqGw5aK640I3RhwFcQqU8F7tMMoY4Ht4
	7q0cvTZLNYoxhGchzYKH2e/FmgzSSiIOfpIH4Ph4EHzvw0af1g8BHKgzf052Gq3RPtj5P2yf/vo
	8YHpHoHqaGXNhcOY3ynR+wQ5dLSfOVEI1PZe545S4cRezwVjRlkBq9vlTO6EsfXluprD3Z7RvmA
	utN0zhsDtN5wXluXLwpu4VH7l0BhpzhUWbDswAhPLfnMd6Rt6V7xgr8aD8aKH9PgdMA2F2WFrlg
	Q==
X-Received: by 2002:a05:6871:7b0d:b0:49d:d220:e234 with SMTP id 586e51a60fabf-4a7579a1421mr8157844fac.35.1792520358115;
        Tue, 20 Oct 2026 11:19:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.89.125.200])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a7d5ebc240sm191721fac.2.2026.10.20.11.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:19:16 -0700 (PDT)
Message-Id: <1a7d060fae0decbe7dda63ec4ab57e32e0205df0.1792520353.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2272.git.1792520353.gitgitgadget@gmail.com>
References: <pull.2272.git.1792520353.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Oct 2026 18:19:12 +0000
Subject: [PATCH 1/2] hook: honor hook.<event>.enabled for the hookdir hook
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
    Patrick Steinhardt <ps@pks.im>,
    Emily Shaffer <nasamuffin@google.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

The documentation added by dcfb5af67e (hook: add hook.<event>.enabled
switch, 2026-04-10) says that with hook.<event>.enabled set to false
"no hooks fire for that event", but only hooks defined in the
configuration are skipped. With hook.pre-commit.enabled=false,
"git commit" still runs .git/hooks/pre-commit, and "git hook list"
shows that hook without the "event-disabled" mark.

Move the event_disabled flag out of u.configured in struct hook, set
it for the hookdir hook too, and check it for both kinds of hooks.

The test for hook.<event>.enabled=false looks only at the standard
output, but "git hook run" sends hook output to the standard error,
so the test passes even when a disabled hook runs. Add a hookdir hook
to it and check the standard error as well.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 builtin/hook.c  |  6 ++++--
 hook.c          | 14 +++++++++-----
 hook.h          |  8 +++++++-
 t/t1800-hook.sh | 29 +++++++++++++++++++++++++++--
 4 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/builtin/hook.c b/builtin/hook.c
index cceeb3586e..1ea698ecc2 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -82,7 +82,9 @@ static int list(int argc, const char **argv, const char *prefix,
 
 		switch (h->kind) {
 		case HOOK_TRADITIONAL:
-			printf("%s%c", _("hook from hookdir"), line_terminator);
+			printf("%s%s%c",
+			       h->event_disabled ? "event-disabled\t" : "",
+			       _("hook from hookdir"), line_terminator);
 			break;
 		case HOOK_CONFIGURED: {
 			const char *name = h->u.configured.friendly_name;
@@ -95,7 +97,7 @@ static int list(int argc, const char **argv, const char *prefix,
 			 * "disabled" surfaces once the event is re-enabled.
 			 */
 			const char *disability =
-				h->u.configured.event_disabled ? "event-disabled\t" :
+				h->event_disabled              ? "event-disabled\t" :
 				h->u.configured.disabled       ? "disabled\t"       :
 								 "";
 			if (scope)
diff --git a/hook.c b/hook.c
index d10eef4763..5e756cb353 100644
--- a/hook.c
+++ b/hook.c
@@ -115,6 +115,9 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
 
 	h->kind = HOOK_TRADITIONAL;
 	h->u.traditional.path = xstrdup(hook_path);
+	/* list_hooks_add_configured() has loaded r->disabled_events */
+	h->event_disabled = !!unsorted_string_list_lookup(&r->disabled_events,
+							  hookname);
 
 	string_list_append(hook_list, hook_path)->util = h;
 }
@@ -514,7 +517,7 @@ static void list_hooks_add_configured(struct repository *r,
 			entry->command ? xstrdup(entry->command) : NULL;
 		hook->u.configured.scope = entry->scope;
 		hook->u.configured.disabled = entry->disabled;
-		hook->u.configured.event_disabled = event_is_disabled;
+		hook->event_disabled = event_is_disabled;
 		hook->parallel = entry->parallel;
 
 		string_list_append(list, friendly_name)->util = hook;
@@ -559,8 +562,9 @@ int hook_exists(struct repository *r, const char *name)
 
 	for (size_t i = 0; i < hooks->nr; i++) {
 		struct hook *h = hooks->items[i].util;
-		if (h->kind == HOOK_TRADITIONAL ||
-		    (!h->u.configured.disabled && !h->u.configured.event_disabled)) {
+		if (!h->event_disabled &&
+		    (h->kind == HOOK_TRADITIONAL ||
+		     !h->u.configured.disabled)) {
 			exists = 1;
 			break;
 		}
@@ -583,8 +587,8 @@ static int pick_next_hook(struct child_process *cp,
 		if (hook_cb->hook_to_run_index >= hook_list->nr)
 			return 0;
 		h = hook_list->items[hook_cb->hook_to_run_index++].util;
-	} while (h->kind == HOOK_CONFIGURED &&
-		 (h->u.configured.disabled || h->u.configured.event_disabled));
+	} while (h->event_disabled ||
+		 (h->kind == HOOK_CONFIGURED && h->u.configured.disabled));
 
 	cp->no_stdin = 1;
 	strvec_pushv(&cp->env, hook_cb->options->env.v);
diff --git a/hook.h b/hook.h
index 27bb1aeb2e..6af24cb331 100644
--- a/hook.h
+++ b/hook.h
@@ -32,10 +32,16 @@ struct hook {
 			const char *command;
 			enum config_scope scope;
 			bool disabled;
-			bool event_disabled;
 		} configured;
 	} u;
 
+	/**
+	 * Whether this hook's event is disabled with
+	 * `hook.<event>.enabled = false`. This applies to configured hooks
+	 * and the hookdir hook alike.
+	 */
+	bool event_disabled;
+
 	/**
 	 * Whether this hook may run in parallel with other hooks for the same
 	 * event. Only useful for configured (named) hooks. Traditional hooks
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 7d4b2982b4..27cb0eb01c 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -496,6 +496,15 @@ test_expect_success 'disabled configured hook is not reported as existing by hoo
 	test_grep ! "pre-commit" git-bugreport-hook-exists-test.txt
 '
 
+test_expect_success 'event-disabled hookdir hook is not reported as existing by hook_exists' '
+	test_when_finished "rm -f git-bugreport-hook-exists-test.txt" &&
+	setup_hookdir &&
+	test_config hook.pre-commit.enabled false &&
+
+	git bugreport -s hook-exists-test &&
+	test_grep ! "pre-commit" git-bugreport-hook-exists-test.txt
+'
+
 test_expect_success 'globally disabled hook can be re-enabled locally' '
 	test_config_global hook.global-hook.event "test-hook" &&
 	test_config_global hook.global-hook.command "echo \"global-hook ran\"" &&
@@ -1110,9 +1119,13 @@ test_expect_success 'hook.<event>.jobs rejects values less than -1' '
 test_expect_success 'hook.<event>.enabled=false skips all hooks for event' '
 	test_config hook.hook-1.event test-hook &&
 	test_config hook.hook-1.command "echo ran" &&
+	test_hook test-hook <<-\EOF &&
+	echo ran
+	EOF
 	test_config hook.test-hook.enabled false &&
 	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
-	test_must_be_empty out
+	test_must_be_empty out &&
+	test_must_be_empty err
 '
 
 test_expect_success 'hook.<event>.enabled=true does not suppress hooks' '
@@ -1147,10 +1160,14 @@ test_expect_success 'git hook list shows event-disabled hooks as event-disabled'
 	test_config hook.hook-1.command "echo ran" &&
 	test_config hook.hook-2.event test-hook &&
 	test_config hook.hook-2.command "echo ran" &&
+	test_hook test-hook <<-\EOF &&
+	echo ran
+	EOF
 	test_config hook.test-hook.enabled false &&
 	git hook list --allow-unknown-hook-name test-hook >actual &&
 	test_grep "^event-disabled	hook-1$" actual &&
-	test_grep "^event-disabled	hook-2$" actual
+	test_grep "^event-disabled	hook-2$" actual &&
+	test_grep "^event-disabled	hook from hookdir$" actual
 '
 
 test_expect_success 'git hook list shows scope with event-disabled' '
@@ -1169,6 +1186,14 @@ test_expect_success 'git hook list still shows hooks when event is disabled' '
 	test_grep "event-disabled" actual
 '
 
+test_expect_success 'commit skips the hookdir hook with hook.pre-commit.enabled=false' '
+	test_hook pre-commit <<-\EOF &&
+	exit 1
+	EOF
+	test_must_fail git commit --allow-empty -m blocked &&
+	git -c hook.pre-commit.enabled=false commit --allow-empty -m allowed
+'
+
 test_expect_success 'friendly-name matching known event name is rejected' '
 	test_config hook.pre-commit.event pre-commit &&
 	test_config hook.pre-commit.command "echo oops" &&
-- 
gitgitgadget

