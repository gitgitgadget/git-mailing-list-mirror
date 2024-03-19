Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D5F39ACD
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873428; cv=none; b=sK0P3v9/QNNXJmzmENBudCvtvuY3gK9nJmOAag7AlrIqbIwM3gjV8+B7pTMDxc8iWhoKsUXdstol0gHFK/vUZBSnCvQj4/aITP/C517em8UXjKsJaNyR3QizyCdeMiOyOA319XjT6zAAhjAGcN/sRfO+ElWv9BAPFQq+6lKCakg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873428; c=relaxed/simple;
	bh=gSuG3iMxscHnEw+s9HYdSeITTtlTzp7XCxd3ji0GHMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KBWnljaTP/yHKhHyjYQQM0fy1y2GQ+HEVL6Z7Gb7TEaIqyL82YORHJAcf3imtzPW4S2EDHz9WWbCbWuMg4GQ79xdtQ2EIzNZTKomt3V8qQl5JI1biDOOw+FT/Ihb1YD0zi7ZVDV0j6T4uxJkIvI2ReX7aRPuIKK57Muo2x1PRug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=jLQQqkfL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aKuUuzi3; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="jLQQqkfL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aKuUuzi3"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id AF8D518000B9;
	Tue, 19 Mar 2024 14:37:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 19 Mar 2024 14:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1710873424; x=1710959824; bh=PpYCCzjSZOJM574j+x2YEkJ5BSyiGAPw
	KTjNWZTw/yk=; b=jLQQqkfLZQ7aP90xJvggLC9NE0illTjAcszaGJAoExVa5gZg
	/WoiQWufApgMz80P+IJzkkVN+ZToGT5GxVqT8P8DKchb2QZqlVBHFk9ONuly+F7J
	FEgbRx+4lXKDk9HFJTP9xcCkPPUk/wBW1e4eW+/YI5Agxctk9F/+AgCD4+5kZfmE
	2X3Z1eQwKkGwOvK65S8K6GxIXac52DnSmz0lSNsmnqGb2H6qbpNtuEa3zqCfOn18
	WoWxiSkF2GVFY4wqzTol635UF7sWISAINxPl2aOLWKBNauRWG8gy2dv0OBtBs4Xc
	/PM32fntz5Z+SQc7btAYMYlMTBWrwXO+mfaBww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710873424; x=
	1710959824; bh=PpYCCzjSZOJM574j+x2YEkJ5BSyiGAPwKTjNWZTw/yk=; b=a
	KuUuzi3Vsv+gyqHkz7WtEtkP0F0t1M00Z9OrMNz/nnXSBfu7QmutpgzIrt8sk0pJ
	10wNRoLQUxJJF77TKdhlwGDrOStuREYArUIe7G4G1M2JkPRRyGas1BDJAqbIuCaR
	tBZUGHfrYOAqCcel/JN0mh+46wm4t/b9Y1zw3u4xoJw9t3Yiao5IlLqpy2DkIb4o
	wYmEzipSl0DUrcfFu3UhQMc7PSaDlGH+QKjIkOoVSSvf3AIgkuKKHMx4HoAmiQaY
	iNNRqN7qDFxJxt4/C/Ssw31/pyRnFAFxiT3Hpa9Hk8L2Fbxk5DsoaGekJCz8iALR
	XqJnk6Y3tAkp8r8BCZ+2A==
X-ME-Sender: <xms:UNv5ZZ0P0FcAMu7W8vaae1FsDWx5JQviuGzSzqQ9VD13jeJ53aa_L1w>
    <xme:UNv5ZQHQTyTuLnlI8Y_0yT55MNIZw_1NbqIvVuYqT8F0Yy1-Sehf8vJuBBMv6S56R
    wttGUcZ2bIHGUHo8g>
X-ME-Received: <xmr:UNv5ZZ7OKMHAFkKRfPPKxv3PNSrfOrNCf4SoToSxhCEOXVKEsf1a4J1nCuIRp2RzE96NVSis8cmI-ho-FTj3v8PT4firNvJK8pjq1EJFig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrledtgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgsehtke
    ertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepueeiue
    ffuefftefhhfefleelhfeuheettedtheevgeejteehgfevffeugffglefhnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:UNv5ZW1ZjaqC8W1z8eqHbqpdlKRSF-c3iJ6LeqvJb48Z3k0QpRFitw>
    <xmx:UNv5ZcHFRs-US7zr0rIqf0_ELnmDeWSQ5atb1NHXWTda6iNrNuwVIQ>
    <xmx:UNv5ZX81oAMN5PRY2D8P-m0XzMRHxZwxgFDHJqejMkUfgoA7th0Iaw>
    <xmx:UNv5ZZly-GCQbYV0HkqzEEBwl2ST87Wdrp9ZNesc-K0qj2AyKqQCjA>
    <xmx:UNv5ZQAs5HoHBayqpeCAqPpQyhzZ-NzI-9OCRpCdmzEf0AldrN6IrNkJevQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Mar 2024 14:37:03 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 2/3] format-patch: teach `--header-cmd`
Date: Tue, 19 Mar 2024 19:35:37 +0100
Message-ID: <8c511797a476a86bf231595d6d7f5db790f12731.1710873210.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.144.g29ae9861142
In-Reply-To: <cover.1710873210.git.code@khaugsbakk.name>
References: <cover.1709841147.git.code@khaugsbakk.name> <cover.1710873210.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 8c511797a476a86bf231595d6d7f5db790f12731
X-Previous-Commits: f405a0140b5655bc66a0a7a603517a421d7669cf 3b12a8cf393b6d8f0877fd7d87173c565d7d5a90
Content-Transfer-Encoding: 8bit

Teach git-format-patch(1) `--header-cmd` (with negation) and the
accompanying config variable `format.headerCmd` which allows the user to
add extra headers per-patch.

format-patch knows `--add-header`. However, that seems most useful for
series-wide headers; you cannot really control what the header is like
per patch or specifically for the cover letter. To that end, teach
format-patch a new option which runs a command that has access to the
hash of the current commit (if it is a code patch) and the patch count
which is used for the patch files that this command outputs. Also
include an environment variable which tells the version of this API so
that the command can detect and error out in case the API changes.

This is inspired by `--header-cmd` of git-send-email(1).

§ Discussion

The command can use the provided commit hash to provide relevant
information in the header. For example, the command could output a
header for the current commit as well as the previously-published
commits:

    X-Commit-Hash: 97b53c04894578b23d0c650f69885f734699afc7
    X-Previous-Commits:
        4ad5d4190649dcb5f26c73a6f15ab731891b9dfd
        d275d1d179b90592ddd7b5da2ae4573b3f7a37b7
        402b7937951073466bf4527caffd38175391c7da

Now interested parties can use this information to track where the
patches come from.

This information could of course be given between the
three-dash/three-hyphen line and the patch proper. However, the project
might prefer to use this part for extra patch information written by the
author and leave the above information for tooling; this way the extra
information does not need to disturb the reader.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Simplify tests: use `true` and `false` as commands
    • Fix indentation
    • Don’t use `const` for owned pointer (avoid cast when freeing)
      • Link: https://lore.kernel.org/git/cover.1709841147.git.code@khaugsbakk.name/T/#m12d104a5a769c7f6e02b1d0a75855142004e9206
    • Use AsciiDoc definition list
      • Link: https://lore.kernel.org/git/53ea3745-205b-40c0-a4c5-9be26d9b88bf@gmail.com/

 Documentation/config/format.txt    |  5 ++++
 Documentation/git-format-patch.txt | 23 ++++++++++++++++
 builtin/log.c                      | 43 ++++++++++++++++++++++++++++++
 t/t4014-format-patch.sh            | 36 +++++++++++++++++++++++++
 4 files changed, 107 insertions(+)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index 7410e930e53..c184b865824 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -31,6 +31,11 @@ format.headers::
 	Additional email headers to include in a patch to be submitted
 	by mail.  See linkgit:git-format-patch[1].
 
+format.headerCmd::
+	Command to run for each patch that should output RFC 2822 email
+	headers. Has access to some information per patch via
+	environment variables. See linkgit:git-format-patch[1].
+
 format.to::
 format.cc::
 	Additional recipients to include in a patch to be submitted
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 728bb3821c1..4f87fd25db9 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -303,6 +303,29 @@ feeding the result to `git send-email`.
 	`Cc:`, and custom) headers added so far from config or command
 	line.
 
+--[no-]header-cmd=<cmd>::
+	Run _<cmd>_ for each patch. _<cmd>_ should output valid RFC 2822
+	email headers. This can also be configured with
+	the configuration variable `format.headerCmd`. Can be turned off
+	with `--no-header-cmd`. This works independently of
+	`--[no-]add-header`.
++
+_<cmd>_ has access to these environment variables:
++
+--
+GIT_FP_HEADER_CMD_VERSION;;
+	The version of this API. Currently `1`. _<cmd>_ may return exit code
+	`2` in order to signal that it does not support the given version.
+GIT_FP_HEADER_CMD_HASH;;
+	The hash of the commit corresponding to the current patch. Not set if
+	the current patch is the cover letter.
+GIT_FP_HEADER_CMD_COUNT;;
+	The current patch count. Increments for each patch.
+--
++
+`git format-patch` will error out if _<cmd>_ returns a non-zero exit
+code.
+
 --[no-]cover-letter::
 	In addition to the patches, generate a cover letter file
 	containing the branch description, shortlog and the overall diffstat.  You can
diff --git a/builtin/log.c b/builtin/log.c
index e5da0d10434..bc656b5e0f8 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -43,10 +43,13 @@
 #include "tmp-objdir.h"
 #include "tree.h"
 #include "write-or-die.h"
+#include "run-command.h"
 
 #define MAIL_DEFAULT_WRAP 72
 #define COVER_FROM_AUTO_MAX_SUBJECT_LEN 100
 #define FORMAT_PATCH_NAME_MAX_DEFAULT 64
+#define HC_VERSION "1"
+#define HC_NOT_SUPPORTED 2
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -902,6 +905,7 @@ static int auto_number = 1;
 
 static char *default_attach = NULL;
 
+static const char *header_cmd = NULL;
 static struct string_list extra_hdr = STRING_LIST_INIT_NODUP;
 static struct string_list extra_to = STRING_LIST_INIT_NODUP;
 static struct string_list extra_cc = STRING_LIST_INIT_NODUP;
@@ -1100,6 +1104,8 @@ static int git_format_config(const char *var, const char *value,
 		format_no_prefix = 1;
 		return 0;
 	}
+	if (!strcmp(var, "format.headercmd"))
+		return git_config_string(&header_cmd, var, value);
 
 	/*
 	 * ignore some porcelain config which would otherwise be parsed by
@@ -1419,6 +1425,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 		show_range_diff(rev->rdiff1, rev->rdiff2, &range_diff_opts);
 		strvec_clear(&other_arg);
 	}
+	free(pp.after_subject);
 }
 
 static char *clean_message_id(const char *msg_id)
@@ -1869,6 +1876,35 @@ static void infer_range_diff_ranges(struct strbuf *r1,
 	}
 }
 
+/* Returns an owned pointer */
+static char *header_cmd_output(struct rev_info *rev, const struct commit *cmit)
+{
+	struct child_process header_cmd_proc = CHILD_PROCESS_INIT;
+	struct strbuf output = STRBUF_INIT;
+	int res;
+
+	strvec_pushl(&header_cmd_proc.args, header_cmd, NULL);
+	if (cmit)
+		strvec_pushf(&header_cmd_proc.env, "GIT_FP_HEADER_CMD_HASH=%s",
+			     oid_to_hex(&cmit->object.oid));
+	strvec_pushl(&header_cmd_proc.env,
+		     "GIT_FP_HEADER_CMD_VERSION=" HC_VERSION, NULL);
+	strvec_pushf(&header_cmd_proc.env, "GIT_FP_HEADER_CMD_COUNT=%" PRIuMAX,
+		     (uintmax_t)rev->nr);
+	res = capture_command(&header_cmd_proc, &output, 0);
+	if (res) {
+		if (res == HC_NOT_SUPPORTED)
+			die(_("header-cmd %s: returned exit "
+			      "code %d; the command does not support "
+			      "version " HC_VERSION),
+			    header_cmd, HC_NOT_SUPPORTED);
+		else
+			die(_("header-cmd %s: failed with exit code %d"),
+			    header_cmd, res);
+	}
+	return strbuf_detach(&output, NULL);
+}
+
 int cmd_format_patch(int argc, const char **argv, const char *prefix)
 {
 	struct commit *commit;
@@ -1959,6 +1995,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(N_("Messaging")),
 		OPT_CALLBACK(0, "add-header", NULL, N_("header"),
 			    N_("add email header"), header_callback),
+		OPT_STRING(0, "header-cmd", &header_cmd, N_("email"), N_("command that will be run to generate headers")),
 		OPT_STRING_LIST(0, "to", &extra_to, N_("email"), N_("add To: header")),
 		OPT_STRING_LIST(0, "cc", &extra_cc, N_("email"), N_("add Cc: header")),
 		OPT_CALLBACK_F(0, "from", &from, N_("ident"),
@@ -2325,6 +2362,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_letter) {
 		if (thread)
 			gen_message_id(&rev, "cover");
+		if (header_cmd)
+			rev.pe_headers = header_cmd_output(&rev, NULL);
 		make_cover_letter(&rev, !!output_directory,
 				  origin, nr, list, description_file, branch_name, quiet);
 		print_bases(&bases, rev.diffopt.file);
@@ -2334,6 +2373,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		/* interdiff/range-diff in cover-letter; omit from patches */
 		rev.idiff_oid1 = NULL;
 		rev.rdiff1 = NULL;
+		free(rev.pe_headers);
 	}
 	rev.add_signoff = do_signoff;
 
@@ -2380,6 +2420,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			gen_message_id(&rev, oid_to_hex(&commit->object.oid));
 		}
 
+		if (header_cmd)
+			rev.pe_headers = header_cmd_output(&rev, commit);
 		if (output_directory &&
 		    open_next_file(rev.numbered_files ? NULL : commit, NULL, &rev, quiet))
 			die(_("failed to create output files"));
@@ -2406,6 +2448,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		}
 		if (output_directory)
 			fclose(rev.diffopt.file);
+		free(rev.pe_headers);
 	}
 	stop_progress(&progress);
 	free(list);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index e37a1411ee2..dc85c4c28fe 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -238,6 +238,42 @@ test_expect_failure 'configuration To: header (rfc2047)' '
 	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs9
 '
 
+test_expect_success '--header-cmd' '
+	write_script cmd <<-\EOF &&
+	printf "X-S: $GIT_FP_HEADER_CMD_HASH\n"
+	printf "X-V: $GIT_FP_HEADER_CMD_VERSION\n"
+	printf "X-C: $GIT_FP_HEADER_CMD_COUNT\n"
+	EOF
+	expect_sha1=$(git rev-parse side) &&
+	git format-patch --header-cmd=./cmd --stdout main..side >patch &&
+	grep "^X-S: $expect_sha1" patch &&
+	grep "^X-V: 1" patch &&
+	grep "^X-C: 3" patch
+'
+
+test_expect_success '--header-cmd with no output works' '
+	git format-patch --header-cmd=true --stdout main..side
+'
+
+test_expect_success '--header-cmd reports failed command' '
+	cat > expect <<-\EOF &&
+	fatal: header-cmd false: failed with exit code 1
+	EOF
+	test_must_fail git format-patch --header-cmd=false --stdout main..side >actual 2>&1 &&
+	test_cmp expect actual
+'
+
+test_expect_success '--header-cmd reports exit code 2' '
+	write_script cmd <<-\EOF &&
+	exit 2
+	EOF
+	cat > expect <<-\EOF &&
+	fatal: header-cmd ./cmd: returned exit code 2; the command does not support version 1
+	EOF
+	test_must_fail git format-patch --header-cmd=./cmd --stdout main..side >actual 2>&1 &&
+	test_cmp expect actual
+'
+
 # check_patch <patch>: Verify that <patch> looks like a half-sane
 # patch email to avoid a false positive with !grep
 check_patch () {
-- 
2.44.0.144.g29ae9861142

