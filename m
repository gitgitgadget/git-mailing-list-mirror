Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761547;
	b=edn5aMNxnuwFWBLTwrYa41QwGtanMLIz2TgeFN5GiHpewTUlJ2N0w5eu52P9js9YoUjN
	 F9hoP5uqOcDAxl2oa8KvPApKW6hLlxW1oQb3HnjT8hx34vbvZKLSBGGBj9Jyx2vwgfDwM
	 bSWBy8A3pNfVHITuAo1hKAKZpnTmlCd2Tv//cz6SmfPLOyYIcMeZo/fHTRs+XwOsRtcH9
	 cvGR38IilT92KuZ8z7WWPKx0IIBhGr8oihU/PbjGh79NloL3fM8AsnEjx+2Ke877OtGAp
	 rFS4ei+f2qG8qNN3w/098C6GiRgyir7KQk7Xd8m3WjuUzuCIN7rZbwUc1VU6X8G0ojw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=tCWlBlZRseBEs2Zile4AbK+CsEf9vRKdX+4QH5baTS8=;
	b=uH6p0Oi18B7j5AcnxGbY+69QMwWRp5nQ0iMbq4xVtnKszRgWlp4h8F1GL3e26A8ciV22
	 XNMC+LvX1ZiAmIvUBsdC446V424sGyTFd2nPt1y07FMg7bnlnrwlKA+bftlclKa2DET00
	 4yNVLooX6iDVNGtLv02R8DTxFTnTHmw0WALqKSbdJJ82nZKU9xdUeBSQBtLAdqoxQjPSl
	 zqb6XGuySRUEgUywmL2iXgs6ukKbD7VR4PRdRmXBWr/dfrp0j2+7uXEcJA+qUWCa1SZqW
	 UnT4y/aY8E/ideJkKRiu6ipmHlo6XCkujlSC9OLfnNV3l52HDqLbhk0sJbMYqnN258A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gvaapFIs;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7BC606A323
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B7BC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gvaapFIs
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-81b54d0cb17so805759a34.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792761546; x=1793366346; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tCWlBlZRseBEs2Zile4AbK+CsEf9vRKdX+4QH5baTS8=;
        b=gvaapFIsJL09po9mJRNx+9PFv7UmIg5DciT2LjpQHrSbDgmgcZuwatxC4QTIBJeU7d
         ljUqM2TialQT55TtYGN3zss56tDGaFqjKUrOU1gnDD/uvylzIQrr//FhT1k7LgOT5HX8
         Yy0r/3TzLGE836kWhS13uQ0WFJXv2Emwskfz5PWCNdcprIKIzndCw84xDa9uLfC6VFDN
         wsfLEj/ro8KCso0qV17c6vThG0l4u7kbKRXo4IhbmlURZztcWZ+JZb7AJ/l6emgrfaSl
         /lsiPKbKTui4RFeeqgFcuvUgxXRZ3ZBI/bzyNC3aXMeUeeb6umiB5ctLadilae+vuJU0
         zxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792761546; x=1793366346;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tCWlBlZRseBEs2Zile4AbK+CsEf9vRKdX+4QH5baTS8=;
        b=Pt9ZrxlBAmT0pJkhkY4z5wnuEMpCRaUwfGixzQ5NRIN1Sz1zQJFe62VdNSaTdhroXS
         JAXoGkIg49GQWV/Gjc6T4l63pCgKE3OUwZbw5Zqym5tGNBjm2455oMd69FAppHmZW74F
         VEJil/YxiImeMBDwN/nKtpUvopWxUXdmV//3soVfEtOUEQVVgY5XxHg8tEFdxmAgcQNW
         Yz4pNX8JuiRKZ/gNOLak0b4VjIaojScY//s+2cvi+7aec3u//kFrDXjS2ITDjgagwzmu
         XlZEU0zCh/YMpZMYdZjSaaFUOuDoj1+DqA7j1gepoS8CoVuH9AuGa1nBcQNT2Y509ezu
         HJWQ==
X-Gm-Message-State: AFq9FYIQyc0yz3Sl+E6igDcpr0NEojcnQd6bUFaDNkZL/fkxlEnlRsez
	cj3rwDjiPpvf11DLB32miihhL8kc9zQTAXImP23hfrUVhm2u+FqM6iJLgLGELdXHd1c=
X-Gm-Gg: AYBFou22SFHFJ2xSNxemgsgVkGjzu1wnrbwoqmdj4YmvBRHq14D8I0DoB6VUGYH0LJ1
	5pXtcQcPq4zOMd1fbMvGkGN+AzqBIBxh6ouwahcJkmmy1HmNB75m8lrH9J52fOIuJh2QAfV1UXX
	dj/HKfuzjgQDvM2CH1TPrp0Xphlut6lmgUJDznGXLfdgtjYitGX/EaNClpAs4kb/a38D5sxO+2K
	vkcgWe4B74WH8sbUd7DFtKwsQZI6IBKh/ZjtTLlD8D6VTdEYcQXgo13mRBJeAo+mEoDGWCsQ4xE
	VSG47NgsTakb9MVvxKLdYalsYorM/hX5sDya/CEBrlWa/LgvNs7HbQ/zRXhMefDNqyKUdG/gYFL
	4p1Re2eWljKbHkDtG7OnFj4SAFW3pmp35X3U9+jb5AIthMYA4J+R5z7nC665EbK+AaPqd9pwqzd
	l8IjWS2H4KooSKyRTsKz2y/6KeESvg1/wm9uY2gHoHsfSfeUQFRN5VTFgnsPSAAIUeKUN5XCtZC
	SmaHMkRlFZnkSuuD2aP94UhE3qPnrqB+38+AJ3OPU/7H7Yfy0EJ2pqPIn55/A==
X-Received: by 2002:a05:6830:2543:b0:812:3ec6:58a2 with SMTP id 46e09a7af769-84fb241b856mr1637034a34.12.1792761545822;
        Fri, 23 Oct 2026 06:19:05 -0700 (PDT)
Received: from [127.0.0.1] ([130.131.204.232])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84fbd362c1fsm2609685a34.4.2026.10.23.06.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:19:04 -0700 (PDT)
Message-Id: <cfcbe80ba5981f6aa2191fe004a3ff8f26b8d8cd.1792761542.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2272.v2.git.1792761542.gitgitgadget@gmail.com>
References: <pull.2272.git.1792520353.gitgitgadget@gmail.com>
	<pull.2272.v2.git.1792761542.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 13:19:01 +0000
Subject: [PATCH v2 1/2] hook: make hook.<event>.enabled cover the hookdir hook
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

hook.<event>.enabled, added by dcfb5af67e (hook: add
hook.<event>.enabled switch, 2026-04-10), skips only the hooks
defined in the configuration when set to false. With
hook.pre-commit.enabled=false, "git commit" still runs
.git/hooks/pre-commit, and "git hook list" shows that hook without
the "event-disabled" mark.

That was the intent, but the documentation says "no hooks fire for
that event", which reads as covering the hookdir hook too. No other
setting turns off the hookdir hook of a single event either:
core.hooksPath=/dev/null turns off the hookdir hooks of all events.
Make the switch cover the hookdir hook as well, and say so in the
documentation. This changes behavior for anyone who set the switch
and relied on the hookdir hook still running.

The test for hook.<event>.enabled=false looks only at the standard
output, but "git hook run" sends hook output to the standard error,
so the test passes even when a disabled hook runs. Add a hookdir hook
to it and check the standard error as well.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 Documentation/config/hook.adoc |  3 ++-
 builtin/hook.c                 |  6 ++++--
 hook.c                         | 14 +++++++++-----
 hook.h                         |  8 +++++++-
 t/t1800-hook.sh                | 35 +++++++++++++++++++++++++++++++---
 5 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
index 083dc60a13..332657e70f 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -47,7 +47,8 @@ hook.<friendly-name>.parallel::
 	the effective job count is greater than 1. {see-git-hook}
 
 hook.<event>.enabled::
-	Switch to enable or disable all hooks for the `<event>` hook event.
+	Switch to enable or disable all hooks for the `<event>` hook event,
+	configured hooks and the traditional hook in the hooks directory alike.
 	When set to `false`, no hooks fire for that event, regardless of any
 	per-hook `hook.<friendly-name>.enabled` settings. Defaults to `true`.
 	{see-git-hook}
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
index 7d4b2982b4..45b99a7f04 100755
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
@@ -1126,9 +1139,13 @@ test_expect_success 'hook.<event>.enabled=true does not suppress hooks' '
 test_expect_success 'hook.<event>.enabled=false does not affect other events' '
 	test_config hook.hook-1.event test-hook &&
 	test_config hook.hook-1.command "echo ran" &&
+	test_hook test-hook <<-\EOF &&
+	echo hookdir ran
+	EOF
 	test_config hook.other-event.enabled false &&
 	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
-	test_grep "ran" err
+	test_grep "^ran$" err &&
+	test_grep "^hookdir ran$" err
 '
 
 test_expect_success 'hook.<friendly-name>.enabled=false still disables that hook' '
@@ -1147,10 +1164,14 @@ test_expect_success 'git hook list shows event-disabled hooks as event-disabled'
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
@@ -1169,6 +1190,14 @@ test_expect_success 'git hook list still shows hooks when event is disabled' '
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

