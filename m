Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A7A1350D6
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841623; cv=none; b=amvVdgJfodtm1g5MHpZM/7Qv3eXHZDcUZ2C89Diy9tLxDv2uu+hvTVH8RaAlRewu1zRl43mcXw4gefi/WMmmdJuSV8VhPbIUFnBfX1mX4SIjcRBZU67f/mb+d90Bjm6lNFlLfWF7J1lrlNWOiWX2HUiNPuBHIDEutNMs6oDPtyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841623; c=relaxed/simple;
	bh=m2AITGLOWEGXGKkO422d1TWDCgqyCKeyE/UvUdyRGag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ib6iNw1daPvxVk6MsGqTGKPvRu05fmOU8h6SClQEdVtVnFkYYaR1IlEgoUXY8WG+zBnjqE37OPLd7oA8nWPXDQx/8WKsxuOk6AykT+a+3mjBaYRi3VxLZEaf/jcq7gpj/JdyY//oXTnQGxDyTLbEzSNIx3u3TjdnDUR9jn/Oxt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=CTIE8gl7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QUmbutgx; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="CTIE8gl7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QUmbutgx"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3B8D411400E5;
	Thu,  7 Mar 2024 15:00:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 07 Mar 2024 15:00:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709841620; x=1709928020; bh=CLGcmNaoSpwAeM5vJYndjQMIazmvt+E/
	bN85QX5IXDg=; b=CTIE8gl7Mjq9H7+q0B//cRy8yyM9QUpg8vM00uuQeCw49K+4
	dUts9LUiCjoMYcAwPuZv1H/Pc08vH8m8IxUaObOpUJY55H9f+fEsrk2PxU2ZOQGs
	GJQCOvw6gw+vE1XSDam8N3nJAdMaXqd3VX+zsL/O8wsWSP3mTOj66vexbs4Ag+qs
	eY1WQncIvSo1XoUN8ApHbDa6A2bOTFEtUf7fXh04ayHIzL24umxWMHUIT/7joe8m
	6jVCx50+I9ZWRMe6h1F93on2eDpgfG6wOW4CVPUeL48QD4kcaTym6YblouREf3/Z
	53OWUBQSTGXZqzhoy7AYzfxTgBKApZJ4AN87cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709841620; x=
	1709928020; bh=CLGcmNaoSpwAeM5vJYndjQMIazmvt+E/bN85QX5IXDg=; b=Q
	UmbutgxeWX4u755N48x7DFY6z3rLvNICuNpq/LjhyJs5l3fES8EOq9grYZGVmvoo
	HYtzfHtAtxlH/siunFSJfSPGKO705YPm7X0XMiV56L3bRmUHl6F21nBYUpMlwbgO
	lutEuGqeMmtwoz+d6USdB7uRiGUM2mK/7Q4+8c/Er/E02EjnjRUVwcP800ykDymf
	tAlZWwIIsdfGCpP4vF5sjfomxkd1Aw96O5XD84fdo/Fidp6YFHPCX2I6+SJlG+sb
	uPp7zMUhrHd1F4EMhpTeB8ANWKZcymROW3tESr5yMH649SMsOoFmZ7uXxQECEIR3
	f5mKV8eM/DLFUhPXZ4+IQ==
X-ME-Sender: <xms:0xzqZbeDw4oRTG-YQZ4uarvheFi_q_JpsHk_jOxzMxxbQTuYaQdOpKI>
    <xme:0xzqZRObPyTL7Coi4uRdyBImil560a10RZfkms9QrawWYBUAHM2CpYcf6EnPbjTLn
    x4Z08WVhEovWJ3V3w>
X-ME-Received: <xmr:0xzqZUhxTPvDMlxuPKw11n2Ne7OeSd5iRe9WysmzC7x4BsZPRvowfS2EyY_VifxffR3PZSg5irVr3DBc3ak-Zat0dJhU9w_il1tqjW008Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgf
    elveeikeegjeeikeeuvefhleeiuddvleegfeekjedtkeevtdetgfffveettdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:1BzqZc9XltDQzndzdmkYs_gs0SzvHEl80GsCXFcO3F532k3jn5fz1w>
    <xmx:1BzqZXsh_5OpE0p-8W6SIUCqVMLrQZ0yY3btNdipxxpHRdyC5Nyk2A>
    <xmx:1BzqZbFfAEQ0wqK2VZ0i3cgPi_O2ln4tbgQbyswwTb8xVPZ8jHN_Dg>
    <xmx:1BzqZQ7DQILGpzVOmzKd1sReIKtwDpg8wth0giWRt345kDryxUdhsQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 15:00:19 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 2/3] format-patch: teach `--header-cmd`
Date: Thu,  7 Mar 2024 20:59:36 +0100
Message-ID: <f405a0140b5655bc66a0a7a603517a421d7669cf.1709841147.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.64.g52b67adbeb2
In-Reply-To: <cover.1709841147.git.code@khaugsbakk.name>
References: <cover.1709841147.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: f405a0140b5655bc66a0a7a603517a421d7669cf
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
    Documentation/config/format.txt:
    • I get the impression that `_` is the convention for placeholders now:
      `_<cmd>_`

 Documentation/config/format.txt    |  5 ++++
 Documentation/git-format-patch.txt | 26 ++++++++++++++++++
 builtin/log.c                      | 43 ++++++++++++++++++++++++++++++
 log-tree.c                         | 16 ++++++++++-
 revision.h                         |  2 ++
 t/t4014-format-patch.sh            | 42 +++++++++++++++++++++++++++++
 6 files changed, 133 insertions(+), 1 deletion(-)

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
index 728bb3821c1..41c344902e9 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -303,6 +303,32 @@ feeding the result to `git send-email`.
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
+	GIT_FP_HEADER_CMD_VERSION
++
+The version of this API. Currently `1`. _<cmd>_ may return exit code
+`2` in order to signal that it does not support the given version.
++
+	GIT_FP_HEADER_CMD_HASH
++
+The hash of the commit corresponding to the current patch. Not set if
+the current patch is the cover letter.
++
+	GIT_FP_HEADER_CMD_COUNT
++
+The current patch count. Increments for each patch.
++
+`git format-patch` will error out if _<cmd>_ returns a non-zero exit
+code.
+
 --[no-]cover-letter::
 	In addition to the patches, generate a cover letter file
 	containing the branch description, shortlog and the overall diffstat.  You can
diff --git a/builtin/log.c b/builtin/log.c
index db1808d7c13..eecbcdf1d6d 100644
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
+	free((char *)pp.after_subject);
 }
 
 static char *clean_message_id(const char *msg_id)
@@ -1865,6 +1872,35 @@ static void infer_range_diff_ranges(struct strbuf *r1,
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
@@ -1955,6 +1991,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(N_("Messaging")),
 		OPT_CALLBACK(0, "add-header", NULL, N_("header"),
 			    N_("add email header"), header_callback),
+		OPT_STRING(0, "header-cmd", &header_cmd, N_("email"), N_("command that will be run to generate headers")),
 		OPT_STRING_LIST(0, "to", &extra_to, N_("email"), N_("add To: header")),
 		OPT_STRING_LIST(0, "cc", &extra_cc, N_("email"), N_("add Cc: header")),
 		OPT_CALLBACK_F(0, "from", &from, N_("ident"),
@@ -2321,6 +2358,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_letter) {
 		if (thread)
 			gen_message_id(&rev, "cover");
+		if (header_cmd)
+			rev.pe_headers = header_cmd_output(&rev, NULL);
 		make_cover_letter(&rev, !!output_directory,
 				  origin, nr, list, description_file, branch_name, quiet);
 		print_bases(&bases, rev.diffopt.file);
@@ -2330,6 +2369,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		/* interdiff/range-diff in cover-letter; omit from patches */
 		rev.idiff_oid1 = NULL;
 		rev.rdiff1 = NULL;
+		free((char *)rev.pe_headers);
 	}
 	rev.add_signoff = do_signoff;
 
@@ -2376,6 +2416,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			gen_message_id(&rev, oid_to_hex(&commit->object.oid));
 		}
 
+		if (header_cmd)
+			rev.pe_headers = header_cmd_output(&rev, commit);
 		if (output_directory &&
 		    open_next_file(rev.numbered_files ? NULL : commit, NULL, &rev, quiet))
 			die(_("failed to create output files"));
@@ -2402,6 +2444,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		}
 		if (output_directory)
 			fclose(rev.diffopt.file);
+		free((char *)rev.pe_headers);
 	}
 	stop_progress(&progress);
 	free(list);
diff --git a/log-tree.c b/log-tree.c
index 2eabd19962b..3ca383d099f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -469,12 +469,24 @@ void fmt_output_email_subject(struct strbuf *sb, struct rev_info *opt)
 	}
 }
 
+static char *extra_and_pe_headers(const char *extra_headers, const char *pe_headers) {
+	struct strbuf all_headers = STRBUF_INIT;
+
+	if (extra_headers)
+		strbuf_addstr(&all_headers, extra_headers);
+	if (pe_headers) {
+		strbuf_addstr(&all_headers, pe_headers);
+	}
+	return strbuf_detach(&all_headers, NULL);
+}
+
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **extra_headers_p,
 			     int *need_8bit_cte_p,
 			     int maybe_multipart)
 {
-	const char *extra_headers = opt->extra_headers;
+	const char *extra_headers =
+		extra_and_pe_headers(opt->extra_headers, opt->pe_headers);
 	const char *name = oid_to_hex(opt->zero_commit ?
 				      null_oid() : &commit->object.oid);
 
@@ -519,6 +531,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			 extra_headers ? extra_headers : "",
 			 mime_boundary_leader, opt->mime_boundary,
 			 mime_boundary_leader, opt->mime_boundary);
+		free((char *)extra_headers);
 		extra_headers = strbuf_detach(&subject_buffer, NULL);
 
 		if (opt->numbered_files)
@@ -857,6 +870,7 @@ void show_log(struct rev_info *opt)
 
 	strbuf_release(&msgbuf);
 	free(ctx.notes_message);
+	free((char *)ctx.after_subject);
 
 	if (cmit_fmt_is_mail(ctx.fmt) && opt->idiff_oid1) {
 		struct diff_queue_struct dq;
diff --git a/revision.h b/revision.h
index 94c43138bc3..eb36bdea36e 100644
--- a/revision.h
+++ b/revision.h
@@ -291,6 +291,8 @@ struct rev_info {
 	struct string_list *ref_message_ids;
 	int		add_signoff;
 	const char	*extra_headers;
+	/* per-email headers */
+	const char	*pe_headers;
 	const char	*log_reencode;
 	const char	*subject_prefix;
 	int		patch_name_max;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index e37a1411ee2..dfda21d4b2b 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -238,6 +238,48 @@ test_expect_failure 'configuration To: header (rfc2047)' '
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
+	write_script cmd <<-\EOF &&
+	exit 0
+	EOF
+	git format-patch --header-cmd=./cmd --stdout main..side
+'
+
+test_expect_success '--header-cmd reports failed command' '
+	write_script cmd <<-\EOF &&
+	exit 1
+	EOF
+		cat > expect <<-\EOF &&
+	fatal: header-cmd ./cmd: failed with exit code 1
+	EOF
+	test_must_fail git format-patch --header-cmd=./cmd --stdout main..side >actual 2>&1 &&
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
2.44.0.169.gd259cac85a8

