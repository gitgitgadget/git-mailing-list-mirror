Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795563146;
	b=xeZr3QQ4bcoYGOY650G5DJTIF6RudEu9hWPf0FVjEYRAnx8dwwVypyshltRuCn0CTQeU
	 5vky0uHHvCBa1sitSw7twwWyKH+nWZ5dFQZ/J0453xfXHHUYaerQp21jDyU99RfWxHoxt
	 0Q38Sy91/f7AO+RPWDy6RzFafbEDjX4HGKFA0ta5FHSB/HJyGE9IxZshAzulbKnMXy7FG
	 KNOvUb7DkH3Z9sSgUrb5oZOQCvwWWfCRtNoHY9JOCoFLXD45O1IfJVQz83KCBrXLDwHvp
	 NUcZ5fHz1+wQEIAo2SKK52pS3MXJ2MkRss18QAhwZeWznO22+5aBxj7Jki62GKXFzag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795563146;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h3zt7yn41IG565ZREGslcLBkHA6lcSpRgQyjddIWGMk=;
	b=RyxqbsXsx8UUQ8N9/8Dzw9f2Ge6X5nyY/zJFWEJgy5v1LB54Y8AftBScvWhAzTUtBZ8j
	 s2VpEBTBuBb2gm8n2pqp5QQWf0khFv0KVsrJyiCOpks6nsSg/5H1uhFUSkonwz69pucfU
	 9Cxdv/No6qJ+wW64ZZ26uf+Sz8qFPVDWW97JYy+6maMun/TtternuDbRnqbQekQuXKqUK
	 p/Jh3wtMWMyK77u95Kv6mjRafnBkNB6pDaHZTKjkkq+ieTLLFyDvPNfpeLJ8hQ+thtLhs
	 Covy/yuFfU8O+oppynAuas/bQZas7KLOZadTssVb8qNkyKVo95C6ADSiFRZ8dfgyNGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=cervined.in;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ejxDj44Y;
	arc=none smtp.remote-ip=209.85.208.175
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8B7606A327
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 23:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A8B7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ejxDj44Y
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3ae85e3685cso33697531fa.2
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 15:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795563144; x=1796167944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h3zt7yn41IG565ZREGslcLBkHA6lcSpRgQyjddIWGMk=;
        b=ejxDj44YF0AXYUHCG6MyL0tCaUj+2A5Ue51xtSIp9tHzMDQp+R62TZO4Z0M/mqLOGZ
         5tyQz5wFRl/xkWENC/7bn4ZC4x4NSOdoQF1V0j2E3u48ID9oDE3wU1RCbYqqAf+xb2wF
         JCBSv6HuJA0FmpWAfhxNfiu+B2Awv+co0Drdaxe/IY8SAIMFLFTqboKwPRQjexLuxIij
         sejoyuJeYvvutCdK/UPja2G8TSTo6cy2QFria+b/vRf0nxDVBc8Kfj7OS2NtfmZbLj4x
         5R7X1J+auqCoRRgZUfyDF8jcKPGW6k/TQ9MDvCSGTjVNT40WCxl4eEY87P7UawUfMmvp
         CI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795563144; x=1796167944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h3zt7yn41IG565ZREGslcLBkHA6lcSpRgQyjddIWGMk=;
        b=zt3po/jClF1tEHjqVaLObzJf8LPS3Q80Pqzmz/n8kW8FyLogM5PAvzDABH3VRkYLSY
         YSyqZlW1uLu/z0vCAvhOkoeHqlRNHd0McJUygo9K6CKzouEFHB8pCE6jXHC4lC52qvDL
         Bn+wnvn9VI3h6j3Y+oFT7C8U1CddHqsf9eEoQD0sNy0UNa5uH4Gbix1os8OEaK8lra0Z
         fg+moP7imU8r542f+4t7LKuQlU1tOWcd2Uaof/quCMUhJIjdSOwsRog7mtVTm+GwWSvi
         lmWynV/VVqzfqht8RI4huuVdaos39ySJLnw3e+sWFVDiK9TeBTnHwWCJQ84lwy6ZQsbS
         IZtg==
X-Gm-Message-State: APuU4Z/sVP45PDvHSSPSd8E2qrBY6ixxlR2SuPFaCwlxJKh7kcD7L1wd
	HOm51Z4rcJ2tu95kS9/zmV6StYXS6ztPsot5IcbfE/D7VzPF/35yCjrZC+y2yw==
X-Gm-Gg: AZFdTZcjjwBfo5TRSn3BC3XNU6EhlK6kSMZdeiALwpbTHyfPKir42HfNuBnkLyFPY1O
	nD9J4Mr8DU5DkIGzQtf2SL7HNsnG7+yCtJekN88X8NAI7F1RlwtDEbLyUQi75QI4Tts+ndqRN+a
	uJ0UXnYaxhT9H8heCtWAwaa5Kk0PY1Y5pJ7LUxdapUhglUOU0qUItPoghlHqOYY6N/juLGmNgif
	bTDR9Wy2u3ksMgN0qtxVf0wyJ65CJVq/TLfTVU0q/i5C8pq/8MDxaJSWF/Pud/oA2gP9ccRRBmR
	w6sNQvyC+UbEaq/OgvBXIgVv0ZofK0had+52ikdJdh897ixzqxeRg/J+6XoxaaUGch50qdGHZG1
	jfTzOJuPGcnV69ZrUa/rfifbfREcXQdz2alxUKAvWtoIwu+Udn4MHiKJDR1htj5IPcEzNaDqlld
	7Z9MNBCxvvwF2jkfL4P7zaEJvSdGWG4IP/qy5iRCdRk5YHabBa1YHhwtgVtsSYNN22tKldAst1r
	S5KwENLrvPUaiVofpFMDjosIhB9PDMwUXnQOTcvgQ6cZLP9rp4dF9YkwQv/rc4odzQRQ0LGCF0i
	tSgQgez7YvpHX3nnhf706ASZRndOmanrpJPToS5Uarpf2cwW9SU3nAGUetQ447k3/H8pkKNtgC8
	LMlUWO6Vloa0F+Pg3sPLg7xBO2Sb6GCfxyyqX8GiQOP2hOA==
X-Received: by 2002:a05:6512:3056:b0:5c1:4b7c:96c6 with SMTP id 2adb3069b0e04-5c1bc8054c2mr4943472e87.32.1795563143891;
        Tue, 24 Nov 2026 15:32:23 -0800 (PST)
Received: from localhost ([2001:2043:be0a:d700:bd32:e7e3:cfbd:5b51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae8044df03sm40020581fa.1.2026.11.24.15.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 15:32:23 -0800 (PST)
Sender: Erik <erik88@gmail.com>
From: Erik Cervin-Edin <erik@cervined.in>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	Erik Cervin-Edin <erik@cervined.in>
Subject: [PATCH v4 3/3] commit: allow -c/-C for all --fixup variants
Date: Wed, 25 Nov 2026 00:32:11 +0100
Message-ID: <159a56c5106c12b8013e91244ab1142a74e59400.1795562078.git.erik@cervined.in>
X-Mailer: git-send-email 2.56.1.978.gcc9bcf3eaa
In-Reply-To: <cover.1795562078.git.erik@cervined.in>
References: <cover.1790082176.git.erik@cervined.in> <cover.1795562078.git.erik@cervined.in>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fixup code path in prepare_to_commit() only knows how to take a
message body from -m or -F.  Now that the previous commit allows -m and
-F for all --fixup variants, -c/-C are the odd ones out.

Teach the fixup path to take the message body from the commit given to
-c/-C, using prepare_amend_commit() as --fixup=amend does when no
message source is given.

The main motivation is consistency: with -c/-C allowed, every message
option works with every --fixup variant, and there's no exception to
document or remember.  Using -c/-C under --fixup is admittedly niche,
but not useless; for example, rewording commit Y based on X's message
after an earlier rebase split X into X' and Y, when Y wasn't reworded at
the time:

    git commit --fixup=reword:Y -c X

Like --fixup=amend, this copies only the body when the source itself is
an "amend!" commit.  Under --fixup the subject is always generated, and
the body of an "amend!" commit is the message intended for its target,
so copying its "amend!" line would leave it in the final message after
autosquash.  This also means that "git commit --fixup=amend:X -C X"
produces the same message as "GIT_EDITOR=: git commit --fixup=amend:X".

Plain --fixup never opens an editor, so -c there behaves like -C.

The incompatibility check grouping -C, -c, and --fixup can go away
entirely, as -C and -c are already rejected together by the check that
groups them with -m and -F.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Erik Cervin-Edin <erik@cervined.in>
---
 Documentation/git-commit.adoc             |  9 ++--
 builtin/commit.c                          | 19 ++++---
 t/t7500-commit-template-squash-signoff.sh | 60 +++++++++++++++++++++--
 3 files changed, 74 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
index 61efd29e66..98c50a3be5 100644
--- a/Documentation/git-commit.adoc
+++ b/Documentation/git-commit.adoc
@@ -102,8 +102,8 @@ include::diff-context-options.adoc[]
 +
 The commit created by plain `--fixup=<commit>` has a title
 composed of "fixup!" followed by the title of _<commit>_,
-and is recognized specially by `git rebase --autosquash`. The `-m`
-or `-F` option may be used to supplement the log message
+and is recognized specially by `git rebase --autosquash`. The `-m`,
+`-F`, `-C`, or `-c` option may be used to supplement the log message
 of the created commit, but the additional commentary will be thrown
 away once the "fixup!" commit is squashed into _<commit>_ by
 `git rebase --autosquash`.
@@ -112,8 +112,9 @@ The commit created by `--fixup=amend:<commit>` is similar but its
 title is instead prefixed with "amend!". The log message of
 _<commit>_ is copied into the log message of the "amend!" commit and
 opened in an editor so it can be refined. The replacement message may
-also be supplied directly using `-m` or `-F`, bypassing the
-need to open an editor. When `git rebase
+also be supplied directly using `-m`, `-F`, or `-C`, bypassing the
+need to open an editor, or using `-c` to open the editor pre-populated
+with the referenced commit's message. When `git rebase
 --autosquash` squashes the "amend!" commit into _<commit>_, the log
 message of _<commit>_ is replaced by the refined log message from the
 "amend!" commit. It is an error for the "amend!" commit's log message
diff --git a/builtin/commit.c b/builtin/commit.c
index e0fac284bc..b52ef283f2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -827,7 +827,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			die_errno(_("could not read log file '%s'"),
 				  logfile);
 		hook_arg1 = "message";
-	} else if (use_message) {
+	} else if (use_message && !fixup_message) {
 		const char *buffer;
 		buffer = strstr(use_message_buffer, "\n\n");
 		if (buffer)
@@ -835,12 +835,20 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		hook_arg1 = "commit";
 		hook_arg2 = use_message;
 	} else if (fixup_message) {
+		const char *refname = NULL;
+
 		hook_arg1 = "message";
-		if (!strcmp(fixup_prefix, "amend")) {
+		if (use_message)
+			refname = use_message;
+		else if (!strcmp(fixup_prefix, "amend"))
+			refname = fixup_commit;
+
+		if (refname) {
 			struct pretty_print_context ctx = {0};
-			struct commit *c = lookup_commit_reference_by_name(fixup_commit);
+			struct commit *c = lookup_commit_reference_by_name(refname);
+
 			if (!c)
-				die(_("could not lookup commit '%s'"), fixup_commit);
+				die(_("could not lookup commit '%s'"), refname);
 			ctx.output_encoding = get_commit_output_encoding();
 			prepare_amend_commit(c, &sb, &ctx);
 		}
@@ -1329,9 +1337,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	}
 	if (fixup_message && squash_message)
 		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
-	die_for_incompatible_opt3(!!use_message, "-C",
-				  !!edit_message, "-c",
-				  !!fixup_message, "--fixup");
 	die_for_incompatible_opt4(have_option_m, "-m",
 				  !!edit_message, "-c",
 				  !!use_message, "-C",
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 9b2ecb1356..04520be0c3 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -492,6 +492,62 @@ test_expect_success 'commit --fixup works with -F' '
 	EOF
 '
 
+test_expect_success 'commit --fixup works with -C' '
+	commit_for_rebase_autosquash_setup &&
+	GIT_EDITOR=false git commit --fixup HEAD~ -C HEAD &&
+	test_commit_message HEAD <<-EOF
+	fixup! $(git log -1 --format=%s HEAD~2)
+
+	$(get_commit_msg HEAD~)
+	EOF
+'
+
+test_expect_success 'commit --fixup=amend: works with -c' '
+	commit_for_rebase_autosquash_setup &&
+	GIT_EDITOR="echo edited >>" git commit --fixup=amend:HEAD -c HEAD~ &&
+	test_commit_message HEAD <<-EOF
+	amend! intermediate commit
+
+	target message subject line
+
+	target message body line 1
+	target message body line 2
+
+	edited
+	EOF
+'
+
+test_expect_success 'commit --fixup=amend:HEAD with -C HEAD and without have the same message' '
+	commit_for_rebase_autosquash_setup &&
+	start=$(git rev-parse HEAD) &&
+
+	git commit --fixup=amend:HEAD -C HEAD &&
+	git commit --fixup=amend:HEAD -C HEAD &&
+	git log -1 --pretty=%B >with-c &&
+
+	git reset --hard "$start" &&
+	git commit --fixup=amend:HEAD &&
+	git commit --fixup=amend:HEAD &&
+	git log -1 --pretty=%B >without-c &&
+
+	test_cmp with-c without-c
+'
+
+test_expect_success 'commit --fixup=amend: with -C copies full subject + body of squash commit' '
+	commit_for_rebase_autosquash_setup &&
+	git commit --squash HEAD~ -m "inner body" &&
+	echo "extra" >>foo &&
+	git add foo &&
+	git commit --fixup=amend:HEAD -C HEAD &&
+	test_commit_message HEAD <<-EOF
+	amend! squash! $(git log -1 --format=%s HEAD~3)
+
+	squash! $(git log -1 --format=%s HEAD~3)
+
+	inner body
+	EOF
+'
+
 test_expect_success 'commit --fixup=reword: works with -F' '
 	commit_for_rebase_autosquash_setup &&
 	echo "message from file" >msgfile &&
@@ -553,9 +609,7 @@ test_expect_success 'invalid message options when using --fixup' '
 	echo changes >>foo &&
 	echo "message" >log &&
 	git add foo &&
-	test_must_fail git commit --fixup HEAD~1 --squash HEAD~2 &&
-	test_must_fail git commit --fixup HEAD~1 -C HEAD~2 &&
-	test_must_fail git commit --fixup HEAD~1 -c HEAD~2
+	test_must_fail git commit --fixup HEAD~1 --squash HEAD~2
 '
 
 cat >expected-template <<EOF
-- 
2.56.1.978.gcc9bcf3eaa

