Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695401990BB
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915097; cv=none; b=fPPoGEWncnx2IdFs9n7vRwNZpRv5CYL4pmH2nWdjqjc6ZVfZ/uYEjkMHx7Z1+ep7PMp7Q2ltgQJFlOxqxGnSvlEG3BOyIkViwkj0ufVYuMiPo/SAnV3DYySm1JwioKhlAL+i3Pv2a2ZzJQ1Mnz2bDZjEECgp4lnW7acML9gG4eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915097; c=relaxed/simple;
	bh=GV734m9V7QNKWSGbLv1Vx8MnN+Z1vTqWLwb9IuSOTUw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V5NNctcSYVqS0Gu4r+goH4/V1Zoeh0O9nVKRGh9dIXrNj0Fqa16sRHh2MX4tK/MRML0pqT3vtsGdgqle5OksXKJdq9S8Ba8AulM57+WCZPUtNcQwtj+QjpSsIRs7a9ZvLF1ftGM0YfdR0Bq92tDTigqBA5Y8DUw/wXae5dAqt8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuFeFXXM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuFeFXXM"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42802de6f59so6775325e9.3
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 06:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721915094; x=1722519894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Qc5AaGdblyDK7RC33GVsdYZ4Ocdj86kv+dUg9bCWmw=;
        b=RuFeFXXMJKzdC5Ru96Al8wFs6akJnCE8s0TXW2AMPjbPgdWhFf1gqJ2k5uHWqajdg2
         rxsjdJq1E5C568xYTV9d3upnjWt+MGEWWC0ri9BT2yXuPqCfLoOVdgQcX2+40nSF/1GF
         ckPsjzU5P4QVprde9jqGBavejB+cO5U372kwaAudT6n4iwOIIPryVEtfuk6gj3IWf0lZ
         cnru58wxBxnK4V3vDzERWeksugzqOjWNFCY0HYyVlxXqUdEn/KIMkcCSbQkNljlIA3Yj
         rWX066J1mEGCkQSeUKQ4vw8o05JYT3SlAFtar6H9F80qznunNMJnuoRR5jL5Fn14Kmjm
         Ll6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721915094; x=1722519894;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Qc5AaGdblyDK7RC33GVsdYZ4Ocdj86kv+dUg9bCWmw=;
        b=Ls6yiUSCTO1DSU/730haTn/1TUxSbli6R+dnCJ+5LQn7rltmIC6PRczSn1DokZibiU
         R5VoiMFiVJA8fI/+YFH/PECpY9YviCneAVlbdTviwhU9ffE6l4EWqGVaV2LnXeN+W5Xw
         DbcwlyEGIE8oIWJGRHLVvkIhhQBzjDgYjmOF+WrPFtzMbJpEdo7w/JlD4AuzjA4HQPdn
         XwFdwECWJzlVzGNK1UHq47ZuBUSHGxlzcJy6jJiSP3bdJy+MgHgP/g2u/is1srva+Wgg
         ADSywcj+mxd+1/wCcVGQyty10auwcdHgag9Swx/NaJ4YywQcHiXlROb2Y1V3zq3iVMjG
         ik7Q==
X-Gm-Message-State: AOJu0YyVjM0q9KnT957Og0HjgOkCD8iBqduXj0QoECic3gu2Di0dI/Zx
	d4o2bm72jZulU4Rt20C8atgCCrfUX+Y0KBDWpomaUvD0zzKpg/coMTIvGQ==
X-Google-Smtp-Source: AGHT+IH85M59zSyYQWduRo8/Fk+sf6H/5RhH4PZQyntQ5Xvby9mZcKPfj7yYhm65b+H7bQrxDQKmuw==
X-Received: by 2002:a05:6000:1567:b0:369:b838:9155 with SMTP id ffacd0b85a97d-36b31b4cff9mr2564303f8f.40.1721915093607;
        Thu, 25 Jul 2024 06:44:53 -0700 (PDT)
Received: from gmail.com (155.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42805730d5bsm38459685e9.8.2024.07.25.06.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 06:44:53 -0700 (PDT)
Message-ID: <0c0cff56-d44b-4a95-809e-afdd219539aa@gmail.com>
Date: Thu, 25 Jul 2024 15:44:52 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/4] add-patch: render hunks through the pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
 <62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
 <2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
 <5735bee3-0532-4894-b717-12a0bdcb9e84@gmail.com>
 <a25c37e2-fcfd-4a4c-890b-a85039ccef12@gmail.com>
 <97902c27-63c9-4537-8ebe-853ef0cb1d3b@gmail.com>
 <88286ad9-eab7-4461-a407-898737faa6a1@gmail.com>
 <76936fb1-446d-455f-b4e7-6e24dda3c17d@gmail.com>
Content-Language: en-US
In-Reply-To: <76936fb1-446d-455f-b4e7-6e24dda3c17d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make the print command trigger the pager when invoked using a capital
'P', to make it easier for the user to review long hunks.

Note that if the PAGER ends unexpectedly before we've been able to send
the payload, perhaps because the user is not interested in the whole
thing, we might receive a SIGPIPE, which would abruptly and unexpectedly
terminate the interactive session for the user.

Therefore, we need to ignore a possible SIGPIPE signal.  Add a test for
this, in addition to the test for normal operation.

For the SIGPIPE test, we need to make sure that we completely fill the
operating system's buffer, otherwise we might not trigger the SIGPIPE
signal.  The normal size of this buffer in different OSs varies from a
few KBs to 1MB.  Use a payload large enough to guarantee that we exceed
this limit.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 add-patch.c                | 18 +++++++++++++++---
 t/t3701-add-interactive.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 6e176cd21a..f2c76b7d83 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -7,9 +7,11 @@
 #include "environment.h"
 #include "gettext.h"
 #include "object-name.h"
+#include "pager.h"
 #include "read-cache-ll.h"
 #include "repository.h"
 #include "strbuf.h"
+#include "sigchain.h"
 #include "run-command.h"
 #include "strvec.h"
 #include "pathspec.h"
@@ -1391,7 +1393,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
    "/ - search for a hunk matching the given regex\n"
    "s - split the current hunk into smaller hunks\n"
    "e - manually edit the current hunk\n"
-   "p - print the current hunk\n"
+   "p - print the current hunk, 'P' to use the pager\n"
    "? - print help\n");
 
 static int patch_update_file(struct add_p_state *s,
@@ -1402,7 +1404,7 @@ static int patch_update_file(struct add_p_state *s,
 	struct hunk *hunk;
 	char ch;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	int colored = !!s->colored.len, quit = 0;
+	int colored = !!s->colored.len, quit = 0, use_pager = 0;
 	enum prompt_mode_type prompt_mode_type;
 	enum {
 		ALLOW_GOTO_PREVIOUS_HUNK = 1 << 0,
@@ -1452,9 +1454,18 @@ static int patch_update_file(struct add_p_state *s,
 		strbuf_reset(&s->buf);
 		if (file_diff->hunk_nr) {
 			if (rendered_hunk_index != hunk_index) {
+				if (use_pager) {
+					setup_pager();
+					sigchain_push(SIGPIPE, SIG_IGN);
+				}
 				render_hunk(s, hunk, 0, colored, &s->buf);
 				fputs(s->buf.buf, stdout);
 				rendered_hunk_index = hunk_index;
+				if (use_pager) {
+					sigchain_pop(SIGPIPE);
+					wait_for_pager();
+					use_pager = 0;
+				}
 			}
 
 			strbuf_reset(&s->buf);
@@ -1675,8 +1686,9 @@ static int patch_update_file(struct add_p_state *s,
 				hunk->use = USE_HUNK;
 				goto soft_increment;
 			}
-		} else if (s->answer.buf[0] == 'p') {
+		} else if (ch == 'p') {
 			rendered_hunk_index = -1;
+			use_pager = (s->answer.buf[0] == 'P') ? 1 : 0;
 		} else if (s->answer.buf[0] == '?') {
 			const char *p = _(help_patch_remainder), *eol = p;
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 6daf3a6be0..1b8617e0c1 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -591,6 +591,38 @@ test_expect_success 'print again the hunk' '
 	test_cmp expect actual.trimmed
 '
 
+test_expect_success TTY 'print again the hunk (PAGER)' '
+	test_when_finished "git reset" &&
+	cat >expect <<-EOF &&
+	<GREEN>+<RESET><GREEN>15<RESET>
+	 20<RESET>
+	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
+	PAGER  10<RESET>
+	PAGER <GREEN>+<RESET><GREEN>15<RESET>
+	PAGER  20<RESET>
+	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET>
+	EOF
+	test_write_lines s y g 1 P |
+	(
+		GIT_PAGER="sed s/^/PAGER\ /" &&
+		export GIT_PAGER &&
+		test_terminal git add -p >actual
+	) &&
+	tail -n 7 <actual | test_decode_color >actual.trimmed &&
+	test_cmp expect actual.trimmed
+'
+
+test_expect_success TTY 'P handles SIGPIPE when writing to pager' '
+	test_when_finished "rm -f huge_file; git reset" &&
+	printf "\n%2500000s" Y >huge_file &&
+	git add -N huge_file &&
+	test_write_lines P q | (
+		GIT_PAGER="head -n 1" &&
+		export GIT_PAGER &&
+		test_terminal git add -p
+	)
+'
+
 test_expect_success 'split hunk "add -p (edit)"' '
 	# Split, say Edit and do nothing.  Then:
 	#
-- 
2.46.0.rc0.4.g6f4990c0d4
