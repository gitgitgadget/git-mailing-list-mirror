Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E414779BE
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207903; cv=none; b=at3Z+aOYEOsSxY4SEZNYeXseL7JifF23obWYQuQBHXGNd6VYQ2HWdejAZfcw9LsUtnZgVJhSAlp9HD/DRe5uwHiBZubWCnLrQ/6vsSRIeJIpLEB9zDkPZ0iVrZTr/Mj7fnfaz1vRJAWx9fiJkK1/mq7HyVDNNTrJsw2J5MxUPxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207903; c=relaxed/simple;
	bh=mXmMA8rJNniuRjDJ1QOrTxP3Z/G/ktHUDuSnW3zJWIc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=J0Kdnwh4WMWsH8Mh4GUhpiIL75NzeoHHEn67nA8pGEyEwIXV5C/hEA8WGm5VZ3tMP3t4Q+qII1tPS0jHB08PjUZpvP2k23lPdv5N0asCX8V97uPTiR+VAJO8/osMTFiVcMauIr3fHpFVtwaaw8b1FlbUuxHAITpMZtNEI1hiAAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSuM1peA; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSuM1peA"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso4726580eec.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 09:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779207900; x=1779812700; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzG2Rmys5M78WLYdH6r9JBsGE0O3vYNTzZS6vUQinVU=;
        b=OSuM1peA9/8ihPPIXFsL4my2E/qOdzbeu/DL03DIJRPaTQ53r9OeNpahz5BTAc2kWd
         q+As7kDVj7LRbwmtdeYQ1Qnu6fbzlTxnuqZIG0ijeTvnf69xthK/as241NuwzdjGGfCf
         0KNvcm7Kd673/Mj4PWKryIhnFFOMUq1Sdgg4bakH1DBgTDX1WEUz+9/BkDyPiJ1+6jKx
         DX8LEYC8TTgmhDp+DhsfKEMopshehspuhd8fdA7Mk2EI1eSIp6MT8D5geSrdOsCmaZWQ
         YwunLj87xmBseWue83PoYVNPKtLcCdY5qcIUksQG6YIDNRxTMvnFc7ZGzJPrd3pmgb8h
         GQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207900; x=1779812700;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JzG2Rmys5M78WLYdH6r9JBsGE0O3vYNTzZS6vUQinVU=;
        b=Sh6u3l9zwOiZtPaQIhmO1MuJ01n/fpgfaZi1SMXpx080T6Boni4CRpyztWymne27zo
         zmtrx6T23MFYxDod7KARcvKnz51X9c5gta719oRBnUcOcCdBH8eYEM3qDT9dnzqqVx00
         1oUK90QTD9n0pb6eRuIHd9e28GnHYmwRS2YvbGMd/nvbWHEAuLjFbfcJ2nx5uiP4aJAL
         lBTviZdw0Zxo576e88hgNBI3smmQ5EtKX1fNQ/Pw5NEUfnAwMHl2jWrFM/MuQ27loLpY
         DNNSwjoSnHg/Hp/7g8kAy0XO4oO5jhJOg1NTtr6GA1fQnQvkpV+kz0iVn4pfRZItV0Qz
         Mszw==
X-Gm-Message-State: AOJu0YwN5qtJ65v9Fwlg8wdSBoygEa5xKDyJStvXg4iO+a7gUefar/Y7
	Ymll9aOXV4X4ovgaXgHOqWJIE35y9V9kh+JH5AuQNlKEVT3TKthPqhhVvOGXPw==
X-Gm-Gg: Acq92OHvn5EMa7BtCJMcZRamXuCnmJHzr3YM3mnTRNEiUhFbQ2c8dmodse4WeaSbMD4
	15nWefdEEDwjKY6sDRJ1AaZbKQ6Te5Z4soAhvdoNwvqPioJdtvdjWsvRpJrfwEToZuP8k8X7ZhZ
	ZKdolJWBl08H0XdROZ8bBGZPQ/OTYG/KHnV26WA9gZPmmcF0F+QM3ZqkcdNclCukLjb6nUllvXG
	d03Ztwyl7b8XxZQCI2YvTs2xAILoMIsQT2slSvEZeF5j2gaen+Y0vdl9ilsP1M40npaHJe9Wl7J
	DIAYLuEk6SqVrT8A5H+UNImveDrWdqoqkhDCzDWp55BGEQZKHo5EGMz/99ijAaI9SuES/0qQLQl
	KGDb6OdkrHW2Ib0UL2b917Af0OTdjAc6j0TJrPt9ZV6iA4S8X7/ufo2mM1cNo9YlewHEJTjYpry
	+UMRDClHnVMUHr53zN4d6AQqztKYhN
X-Received: by 2002:a05:7301:4001:b0:2dd:6937:79b8 with SMTP id 5a478bee46e88-3039812b459mr9511545eec.5.1779207900067;
        Tue, 19 May 2026 09:25:00 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e686sm19672022eec.5.2026.05.19.09.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:24:59 -0700 (PDT)
Message-Id: <ac3e8f74d9511e1896a662507517ed885531edf0.1779207896.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v6.git.1779207896.gitgitgadget@gmail.com>
References: <pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
	<pull.2085.v6.git.1779207896.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 May 2026 16:24:49 +0000
Subject: [PATCH v6 2/8] fetch: add --negotiation-restrict option
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
Cc: gitster@pobox.com,
    ps@pks.im,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The --negotiation-tip option to 'git fetch' and 'git pull' allows users
to specify that they want to focus negotiation on a small set of
references. This is a _restriction_ on the negotiation set, helping to
focus the negotiation when the ref count is high. However, it doesn't
allow for the ability to opportunistically select references beyond that
list.

This subtle detail that this is a 'maximum set' and not a 'minimum set'
is not immediately clear from the option name. This makes it more
complicated to add a new option that provides the complementary behavior
of a minimum set.

For now, create a new synonym option, --negotiation-restrict, that
behaves identically to --negotiation-tip. Update the documentation to
make it clear that this new name is the preferred option, but we keep
the old name for compatibility. Mark --negotiation-tip as an alias of the
new, preferred option.

Update a few warning messages with the new option, but also make them
translatable with the option name inserted by formatting. At least one
of these messages will be reused later for a new option.

Reviewed-by: Matthew John Cheetham <mjcheetham@outlook.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/config/fetch.adoc  |  2 +-
 Documentation/fetch-options.adoc |  6 +++++-
 builtin/fetch.c                  | 13 ++++++++-----
 builtin/pull.c                   |  3 ++-
 send-pack.c                      |  2 +-
 t/t5510-fetch.sh                 | 25 +++++++++++++++++++++++++
 t/t5702-protocol-v2.sh           |  4 ++--
 transport-helper.c               |  3 ++-
 8 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/fetch.adoc b/Documentation/config/fetch.adoc
index cd40db0cad..04ac90912d 100644
--- a/Documentation/config/fetch.adoc
+++ b/Documentation/config/fetch.adoc
@@ -76,7 +76,7 @@
 	default is `skipping`.  Unknown values will cause `git fetch` to
 	error out.
 +
-See also the `--negotiate-only` and `--negotiation-tip` options to
+See also the `--negotiate-only` and `--negotiation-restrict` options to
 linkgit:git-fetch[1].
 
 `fetch.showForcedUpdates`::
diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 81a9d7f9bb..d39cecb446 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -49,6 +49,7 @@ the current repository has the same history as the source repository.
 	`.git/shallow`. This option updates `.git/shallow` and accepts such
 	refs.
 
+`--negotiation-restrict=(<commit>|<glob>)`::
 `--negotiation-tip=(<commit>|<glob>)`::
 	By default, Git will report, to the server, commits reachable
 	from all local refs to find common commits in an attempt to
@@ -58,6 +59,9 @@ the current repository has the same history as the source repository.
 	local ref is likely to have commits in common with the
 	upstream ref being fetched.
 +
+`--negotiation-restrict` is the preferred name for this option;
+`--negotiation-tip` is accepted as a synonym.
++
 This option may be specified more than once; if so, Git will report
 commits reachable from any of the given commits.
 +
@@ -71,7 +75,7 @@ configuration variables documented in linkgit:git-config[1], and the
 
 `--negotiate-only`::
 	Do not fetch anything from the server, and instead print the
-	ancestors of the provided `--negotiation-tip=` arguments,
+	ancestors of the provided `--negotiation-restrict=` arguments,
 	which we have in common with the server.
 +
 This is incompatible with `--recurse-submodules=(yes|on-demand)`.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4795b2a13c..fc950fe35b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1558,8 +1558,8 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
 		refs_for_each_ref_ext(get_main_ref_store(the_repository),
 				      add_oid, oids, &opts);
 		if (old_nr == oids->nr)
-			warning("ignoring --negotiation-tip=%s because it does not match any refs",
-				s);
+			warning(_("ignoring %s=%s because it does not match any refs"),
+				"--negotiation-restrict", s);
 	}
 	smart_options->negotiation_tips = oids;
 }
@@ -1599,7 +1599,8 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
 		if (transport->smart_options)
 			add_negotiation_tips(transport->smart_options);
 		else
-			warning("ignoring --negotiation-tip because the protocol does not support it");
+			warning(_("ignoring %s because the protocol does not support it"),
+				"--negotiation-restrict");
 	}
 	return transport;
 }
@@ -2565,8 +2566,9 @@ int cmd_fetch(int argc,
 			       N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg),
 		OPT_STRING_LIST('o', "server-option", &server_options, N_("server-specific"), N_("option to transmit")),
 		OPT_IPVERSION(&family),
-		OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
+		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_tip, N_("revision"),
 				N_("report that we have only objects reachable from this object")),
+		OPT_ALIAS(0, "negotiation-tip", "negotiation-restrict"),
 		OPT_BOOL(0, "negotiate-only", &negotiate_only,
 			 N_("do not fetch a packfile; instead, print ancestors of negotiation tips")),
 		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
@@ -2657,7 +2659,8 @@ int cmd_fetch(int argc,
 	}
 
 	if (negotiate_only && !negotiation_tip.nr)
-		die(_("--negotiate-only needs one or more --negotiation-tip=*"));
+		die(_("%s needs one or more %s"), "--negotiate-only",
+		    "--negotiation-restrict=*");
 
 	if (deepen_relative) {
 		if (deepen_relative < 0)
diff --git a/builtin/pull.c b/builtin/pull.c
index 7e67fdce97..cc6ce485fc 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -996,9 +996,10 @@ int cmd_pull(int argc,
 		OPT_PASSTHRU('6',  "ipv6", &opt_ipv6, NULL,
 			N_("use IPv6 addresses only"),
 			PARSE_OPT_NOARG),
-		OPT_PASSTHRU_ARGV(0, "negotiation-tip", &opt_fetch, N_("revision"),
+		OPT_PASSTHRU_ARGV(0, "negotiation-restrict", &opt_fetch, N_("revision"),
 			N_("report that we have only objects reachable from this object"),
 			0),
+		OPT_ALIAS(0, "negotiation-tip", "negotiation-restrict"),
 		OPT_BOOL(0, "show-forced-updates", &opt_show_forced_updates,
 			 N_("check for forced-updates on all updated branches")),
 		OPT_PASSTHRU(0, "set-upstream", &set_upstream, NULL,
diff --git a/send-pack.c b/send-pack.c
index 67d6987b1c..3d5d36ba3b 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -447,7 +447,7 @@ static void get_commons_through_negotiation(struct repository *r,
 	strvec_pushl(&child.args, "fetch", "--negotiate-only", NULL);
 	for (ref = remote_refs; ref; ref = ref->next) {
 		if (!is_null_oid(&ref->new_oid)) {
-			strvec_pushf(&child.args, "--negotiation-tip=%s",
+			strvec_pushf(&child.args, "--negotiation-restrict=%s",
 				     oid_to_hex(&ref->new_oid));
 			nr_negotiation_tip++;
 		}
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 5dcb4b51a4..dc3ce56d84 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1460,6 +1460,31 @@ EOF
 	test_cmp fatal-expect fatal-actual
 '
 
+test_expect_success '--negotiation-restrict limits "have" lines sent' '
+	setup_negotiation_tip server server 0 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-restrict=alpha_1 --negotiation-restrict=beta_1 \
+		origin alpha_s beta_s &&
+	check_negotiation_tip
+'
+
+test_expect_success '--negotiation-restrict understands globs' '
+	setup_negotiation_tip server server 0 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-restrict=*_1 \
+		origin alpha_s beta_s &&
+	check_negotiation_tip
+'
+
+test_expect_success '--negotiation-restrict and --negotiation-tip can be mixed' '
+	setup_negotiation_tip server server 0 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-restrict=alpha_1 \
+		--negotiation-tip=beta_1 \
+		origin alpha_s beta_s &&
+	check_negotiation_tip
+'
+
 test_expect_success SYMLINKS 'clone does not get confused by a D/F conflict' '
 	git init df-conflict &&
 	(
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index f826ac46a5..9f6cf4142d 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -869,14 +869,14 @@ setup_negotiate_only () {
 	test_commit -C client three
 }
 
-test_expect_success 'usage: --negotiate-only without --negotiation-tip' '
+test_expect_success 'usage: --negotiate-only without --negotiation-restrict' '
 	SERVER="server" &&
 	URI="file://$(pwd)/server" &&
 
 	setup_negotiate_only "$SERVER" "$URI" &&
 
 	cat >err.expect <<-\EOF &&
-	fatal: --negotiate-only needs one or more --negotiation-tip=*
+	fatal: --negotiate-only needs one or more --negotiation-restrict=*
 	EOF
 
 	test_must_fail git -c protocol.version=2 -C client fetch \
diff --git a/transport-helper.c b/transport-helper.c
index 4d95d84f9e..dd78d40668 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -755,7 +755,8 @@ static int fetch_refs(struct transport *transport,
 	}
 
 	if (data->transport_options.negotiation_tips)
-		warning("Ignoring --negotiation-tip because the protocol does not support it.");
+		warning(_("ignoring %s because the protocol does not support it."),
+			"--negotiation-restrict");
 
 	if (data->fetch)
 		return fetch_with_fetch(transport, nr_heads, to_fetch);
-- 
gitgitgadget

