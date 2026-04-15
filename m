Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0923D646A
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266073; cv=none; b=NKX9uUH2+HClKRB+TsWQV+SbosUcz8JfuXUa1szJ0Zxh1c/5rHhP6ge0dCtTRN8gjb3MyFhE+9hoNDCk8PpZzh3WiDeqCsSbv/4DI/DbSRfKy9IXczhdNQxYMOsrn1OJFk+vZBVOK3bI+OnOBuSQsvtUXcUdfdTOXuKR5dHKR/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266073; c=relaxed/simple;
	bh=9OtOj3aR1Qa1novL8yGm6wPnQbA6q/ZMZ3M38XTe2VM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=COcVu7vcpJeGRBhcIxSNcuk+rhWwv18dkKnH80k7cS807N/OjlwmC1lXhQ7YdwGL5PFwCAsjuiFeLfjZUjIwSxNYo67fd0qaCP1yb92BrN9/Xdw3qXNQ4IMewX6KHQf4G1anJYMJZlA7CxW7R2eri20oqa5sIhgoVNYetyWf8P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/f8HkOk; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/f8HkOk"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8d560ede296so810357385a.0
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776266070; x=1776870870; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvBM1Fcgr9TVj8/VKs6CmdNfk442w5DvAWB0aRaW9G0=;
        b=Z/f8HkOk2fgNj7+oYsMkrcWLd2Y1yKQqvxBdiyaF8U7yzzoxOES/BTUppx2nMPh9GV
         p6zcZblLdNpYoQqPc40nbttFZAy+mS4HSq8Sm5dh/sD5uoTXE+VOhmnMq7KuxN2MQPTM
         E3JZdtiY1CwdLkeEFztv5Psg9ylLGuEjLvTJ7H1bnR+gBrQeN6ZyhdFIyk3ErwSpS+rj
         pb+q70cbskYigw6o9cNPkpe9vlRFW701+iBgIKQL2nDxssKRxDTILhFSKxw2J4EG/PmV
         GHthfaae3/YtGYJs2Vw6zp+Yef+ywtK+WGq1V26FKHcJOOZNonL3tVaZAiAepItizEhr
         qXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776266070; x=1776870870;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mvBM1Fcgr9TVj8/VKs6CmdNfk442w5DvAWB0aRaW9G0=;
        b=VZB+GqWx6edoynXIBL+sEDCGl7ldB9ZMZNHc/Xnk3IVT+w5W0TZsPPn4TMeHZV2km8
         fXu0YMAOyG13LDS8HhtKcSjI07mzppySSrrJKAF3SWejP+5JRWfZ+KhwPg+/UYRKJfCC
         l0VdF+ccHIzh0oQJR7CpxGRN4DyRoOm/GQYGAnAh7M2ud8hHCq0nztEQMuI2H9MzZwWW
         N037ZGMfRV4+l27yKbZJHgtylLrPNpaMv/QRmr0TfytzSEUaez+TzDrwCmK/PtZN/RRE
         +vnxJfL2/VesX7f+KcUA+IA9c7ejBkvlWnx0/YEnRYaHYg1Iwl55aZpTNeP1aYPps2My
         9D5Q==
X-Gm-Message-State: AOJu0Yxb5Wg+L5VnEEjms4rAcz6lookU5XK3E8TWYW+zDPkUAWcBiYLf
	YA/4nNtp7AbExj99NzNXnC5Z433MDHnGknOT03I1r5lT43bt27hTqPgtsJdrPg==
X-Gm-Gg: AeBDievOQ0K/O3f7XXamZySWks9mmnvGYLzyTTbbc2xezo7Kszn4OtlSziaKmkj3AyZ
	vTBsZ1ExH09GPVggb9jlsGOoxk/NhcA2KqrJ560YCcvm4P5PIloXDl6rx7C5BIiH6BFwp8q3vpw
	GWNZA44y2Z0q6XxkejowcxMJ7KBVUqwtLcVZBXhzv3DCbPVpSxsr+65Er3DVmZxeNhaGFWuo/Z+
	SiaS6RoZZrqSrMV/r5LrGkm7Q0lqTb2yApQ9QrRXROEyrUXHE3ntcJyvlnx81pTQbfLxY+0puST
	eKM3OaoUaubVf95J7ju7CTShoGssDsddFFDFeNZfuw77P090U2c2lOFzH+PB1s8a8ToNM34HAuX
	/MBmN8mFk5XnSonhmeGIMWcGwVt7Ts81t6KCsM0X8zbXYqrJLOIgQ+EDa6CuLDIYuWv9FKqTBWN
	4xfOl7Ow/UQqvlmRI7VTrbpZAf
X-Received: by 2002:a05:620a:711a:b0:8cf:dd93:acbe with SMTP id af79cd13be357-8ddcd9ebf3fmr3217723485a.24.1776266070128;
        Wed, 15 Apr 2026 08:14:30 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.13.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4ef33b570sm164690985a.13.2026.04.15.08.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:14:29 -0700 (PDT)
Message-Id: <9a25b0fadebb5f0219ceeca9496fc6f84abd020c.1776266066.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
	<pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 15:14:21 +0000
Subject: [PATCH v2 2/7] fetch: add --negotiation-restrict option
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
the old name for compatibility.

Update a few warning messages with the new option, but also make them
translatable with the option name inserted by formatting. At least one
of these messages will be reused later for a new option.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/fetch-options.adoc |  4 ++++
 builtin/fetch.c                  | 11 +++++++----
 builtin/pull.c                   |  3 +++
 t/t5510-fetch.sh                 | 25 +++++++++++++++++++++++++
 t/t5702-protocol-v2.sh           |  4 ++--
 5 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 81a9d7f9bb..c07b85499f 100644
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
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4795b2a13c..3bcb0c9686 100644
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
@@ -2567,6 +2568,8 @@ int cmd_fetch(int argc,
 		OPT_IPVERSION(&family),
 		OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
 				N_("report that we have only objects reachable from this object")),
+		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_tip, N_("revision"),
+				N_("report that we have only objects reachable from this object")),
 		OPT_BOOL(0, "negotiate-only", &negotiate_only,
 			 N_("do not fetch a packfile; instead, print ancestors of negotiation tips")),
 		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
@@ -2657,7 +2660,7 @@ int cmd_fetch(int argc,
 	}
 
 	if (negotiate_only && !negotiation_tip.nr)
-		die(_("--negotiate-only needs one or more --negotiation-tip=*"));
+		die(_("--negotiate-only needs one or more --negotiation-restrict=*"));
 
 	if (deepen_relative) {
 		if (deepen_relative < 0)
diff --git a/builtin/pull.c b/builtin/pull.c
index 7e67fdce97..821cc6699a 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -999,6 +999,9 @@ int cmd_pull(int argc,
 		OPT_PASSTHRU_ARGV(0, "negotiation-tip", &opt_fetch, N_("revision"),
 			N_("report that we have only objects reachable from this object"),
 			0),
+		OPT_PASSTHRU_ARGV(0, "negotiation-restrict", &opt_fetch, N_("revision"),
+			N_("report that we have only objects reachable from this object"),
+			0),
 		OPT_BOOL(0, "show-forced-updates", &opt_show_forced_updates,
 			 N_("check for forced-updates on all updated branches")),
 		OPT_PASSTHRU(0, "set-upstream", &set_upstream, NULL,
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
-- 
gitgitgadget

