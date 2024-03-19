Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF2639847
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873424; cv=none; b=Bur/6MLqOXOtbvJhJZrasiK8DBsB65l6UTbcPY4lmNHoMRPVEyNSBC/ErKBYzP0Uxy4ZHMc+LclKSo5OvT/JsNxsONAUUrzmtiLgpCHkX8mDajA9e8FHwEtp84bYQ1m7inhdAK5yrVIJj2JkN0FTOfF54Ompw3PsWKS+do4IdKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873424; c=relaxed/simple;
	bh=G6b3RnUAXvy9UiHCTgEZa0UbeRWPPPuduFNuEE/2MzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MNZKEjePHcmQnX+EG4oxHeg5xYiFV+P58Me9CA18duTP0EyxFUx4YictZ6AuY8TTCORT1ZeR+JgMiRSVCLfW0iJ4OZfg7M4V30ATzL8p0ot0EcqkBszdGmpajub2yJxEqJTS+QMhwDIz6IqOhiQs7Sup+gn9f8noLVQvz3ulOZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=H/eAulIb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YugZ9uI6; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="H/eAulIb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YugZ9uI6"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 135E71C0009F;
	Tue, 19 Mar 2024 14:36:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 19 Mar 2024 14:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1710873419; x=1710959819; bh=uWJ3ATpIG2UOA93nhNPVvFKuOx5aKnKz
	rnvAKCw6QAk=; b=H/eAulIbgH6WcW5S0GJjHANvUrBuh+k+MOZ9adW5rJ+xghEl
	tkvjmSp66FAg1jaAgptUd+g2oNkQ4FC7D6AmTmwG9dM8eWsI4Qv/9WCDGqwhPwnj
	vQ0xDHluLGHzJtbOB1bKCar1zlFuX+tV9ydCVF0g6bQHgFnF3YcsdzK8gjL0oCts
	j7STGh/uiFnz65E1/JedegIaD4YUXsRfh51Vm3CVYtEULIQt25SOlAwsUv1313ot
	rMw8U5KvfA3y8G9G5mbQDdDDJdvJpliYrIwrvYYu22GaHDooCuhYEnY/zH5M8Bq9
	URNEHVSDj7enp6aeGNphhlkfDH1GnnA1qKeWTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710873419; x=
	1710959819; bh=uWJ3ATpIG2UOA93nhNPVvFKuOx5aKnKzrnvAKCw6QAk=; b=Y
	ugZ9uI6uWmMOSJXEdN76tS5YEr8iurQj/JauZQ7u3dsKgFuIZI7K4JndsL1swrNX
	DYdh7A8b8XknI/S49iERcElf33UlV+DIjwvrZNp4ktM9KzVMY+DdTz7CcenOQ1Ww
	IuWKPDU/rzk8phdvbZczeLoxG9PlOKiBxflXQ/kbXPoaZwj6rBdHmY1FQD2gHdFL
	Q6zXYtPrjvaziOBYLUvUElGzgTUOWkA43mcMvIk9MvH0vI0fGjxfnSWo5xLE6bMS
	lL/tVUHi5GrHugOPwCOzxoGb8z5OccyBQGCKcgV/CnHcTuwIk7cz6xTS508HUEeB
	dFR7dmFAz9wQWy49DoIgQ==
X-ME-Sender: <xms:S9v5ZbZjCgHdYCKnWkH_eT9b4OiRaCQGwoDl4zN4tkWjoRvRwV-eVg0>
    <xme:S9v5ZaYUwM7Zg183FJVmNj-C6NbEiEvMrx0XuZhvwG8g0vpdLJTfwpIxWpEQnw1Ew
    wOce0_O8DvdHh0VZQ>
X-ME-Received: <xmr:S9v5Zd9Gvo760bc9m5sGgrpwFMHtIG_spTeBKyEJDEqRr6Qa2ObWDwAVe0bM3RqEvfHE4hvvi20DBskSWJtaVzfK3P9TavxXIMCwDLy1CQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrledtgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeffhffguddttddthfeiledvtedufefgjeelfeeu
    ieekuefgfedtudeivdfhvefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:S9v5ZRrzJ7cCvSe0ve6v5Di_-zwuNIJYIWOS6qmlRfUFa0Qh7FSHlw>
    <xmx:S9v5ZWqip8TyZfBqa0YHbDal3K2o_aVroFIOL3WiLWVFbnH3Gbub8w>
    <xmx:S9v5ZXT_6X2VB2jJ6_p1mc_k3vQS4TR3DoEAXUY8l09be5CcbqF4ng>
    <xmx:S9v5ZeqNsWFl_5BZ7TFZfheScpdofPZfKBoDEFY7lBjp5S_rifDDqg>
    <xmx:S9v5ZXciUHILFpdpBFK70AavIdiPijBAaTVlTDgaqk-ZR306AzxO0lgrl0w>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Mar 2024 14:36:57 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Maxim Cournoyer <maxim.cournoyer@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>
Subject: [PATCH v2 0/3] format-patch: teach `--header-cmd`
Date: Tue, 19 Mar 2024 19:35:35 +0100
Message-ID: <cover.1710873210.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.144.g29ae9861142
In-Reply-To: <cover.1709841147.git.code@khaugsbakk.name>
References: <cover.1709841147.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

(most of this is from the main commit/patch with some elaboration in
parts)

Teach git-format-patch(1) `--header-cmd` (with negation) and the
accompanying config variable `format.headerCmd` which allows the user to
add extra headers per-patch.

§ Motivation

format-patch knows `--add-header`. However, that seems most useful for
series-wide headers; you cannot really control what the header is like
per patch or specifically for the cover letter. To that end, teach
format-patch a new option which runs a command that has access to the
hash of the current commit (if it is a code patch) and the patch count
which is used for the patch files that this command outputs. Also
include an environment variable which tells the version of this API so
that the command can detect and error out in case the API changes.

This is inspired by `--header-cmd` of git-send-email(1).[1]

🔗 1: https://lore.kernel.org/git/20230423122744.4865-1-maxim.cournoyer@gmail.com/

§ Discussion

One can already get the commit hash from the first line of the patch file:

    From 04967d53399ed2db09d224008f557ec1a5847cc1 Mon Sep 17 00:00:00 2001

However, the point of this option is to be able to calculate header
output based primarily on the commit hash without having to go back and
forth between commands (i.e. running format-patch and then parsing the
patch files).

As an example, the command could output a header for the current commit
as well as another header for the previously-published commits:

    X-Commit-Hash: 97b53c04894578b23d0c650f69885f734699afc7
    X-Previous-Commits:
        4ad5d4190649dcb5f26c73a6f15ab731891b9dfd
        d275d1d179b90592ddd7b5da2ae4573b3f7a37b7
        402b7937951073466bf4527caffd38175391c7da

One can imagine that (1) these previous commit hashes were stored on every
commit rewrite and (2) the commits that had been published previously
were also stored. Then the command just needed the current commit hash
in order to look up this information.

Now interested parties can use this information to track where the
patches come from.

This information could of course be given between the three-dash/three-
hyphen line and the patch proper. However, the hypothetical project in
question might prefer to use this part for extra patch information
written by the author and leave the above information for tooling; this
way the extra information does not need to disturb the reader.

§ Demonstration

The above current/previous hash example is taken from:

https://lore.kernel.org/git/97b53c04894578b23d0c650f69885f734699afc7.1709670287.git.code@khaugsbakk.name/

§ Changes in v2

Changes based on feedback from Jean-Noël and Peff.

Peff suggested changes to the strbuf handling in `log_tree`, removing
constness in order to facilitate freeing without casting, and fleshing
out the preliminary patch.

In detail:

• revision: add a per-email field to rev-info
  • Replaces (subject) “log-tree: take ownership of pointer”
  • Separate out changes for `rev.info.pe_headers`, changes to
    ownership, const, and strbuf handling in `log_tree`
  • Link: https://lore.kernel.org/git/20240313065454.GB125150@coredump.intra.peff.net/
• format-patch: teach `--header-cmd`
  • Simplify tests: use `true` and `false` as commands
  • Fix indentation in code
  • Use AsciiDoc definition list
    • Link: https://lore.kernel.org/git/53ea3745-205b-40c0-a4c5-9be26d9b88bf@gmail.com/
• format-patch: check if header output looks valid
  • (no changes)

§ CC

Cc: Jeff King <peff@peff.net>
Cc: Maxim Cournoyer <maxim.cournoyer@gmail.com>
Cc: "Jean-Noël Avila" <avila.jn@gmail.com>

§ CI

https://github.com/LemmingAvalanche/git/actions/runs/8332742200/job/22802597793

Fails but looks similar to the failures for `master` at 3bd955d2691 (The
ninth batch, 2024-03-18):

https://github.com/git/git/actions/runs/8333455189/job/22804953254

Kristoffer Haugsbakk (3):
  revision: add a per-email field to rev-info
  format-patch: teach `--header-cmd`
  format-patch: check if header output looks valid

 Documentation/config/format.txt    |  5 ++
 Documentation/git-format-patch.txt | 23 +++++++++
 builtin/log.c                      | 76 ++++++++++++++++++++++++++++++
 log-tree.c                         | 21 +++++----
 log-tree.h                         |  2 +-
 pretty.h                           |  2 +-
 revision.h                         |  4 +-
 t/t4014-format-patch.sh            | 49 +++++++++++++++++++
 8 files changed, 169 insertions(+), 13 deletions(-)

Range-diff against v1:
1:  3b12a8cf393 < -:  ----------- log-tree: take ownership of pointer
-:  ----------- > 1:  9a7102b708e revision: add a per-email field to rev-info
2:  f405a0140b5 ! 2:  8c511797a47 format-patch: teach `--header-cmd`
    @@ Commit message
     
     
      ## Notes (series) ##
    -    Documentation/config/format.txt:
    -    • I get the impression that `_` is the convention for placeholders now:
    -      `_<cmd>_`
    +    v2:
    +    • Simplify tests: use `true` and `false` as commands
    +    • Fix indentation
    +    • Don’t use `const` for owned pointer (avoid cast when freeing)
    +      • Link: https://lore.kernel.org/git/cover.1709841147.git.code@khaugsbakk.name/T/#m12d104a5a769c7f6e02b1d0a75855142004e9206
    +    • Use AsciiDoc definition list
    +      • Link: https://lore.kernel.org/git/53ea3745-205b-40c0-a4c5-9be26d9b88bf@gmail.com/
     
      ## Documentation/config/format.txt ##
     @@ Documentation/config/format.txt: format.headers::
    @@ Documentation/git-format-patch.txt: feeding the result to `git send-email`.
     ++
     +_<cmd>_ has access to these environment variables:
     ++
    -+	GIT_FP_HEADER_CMD_VERSION
    -++
    -+The version of this API. Currently `1`. _<cmd>_ may return exit code
    -+`2` in order to signal that it does not support the given version.
    -++
    -+	GIT_FP_HEADER_CMD_HASH
    -++
    -+The hash of the commit corresponding to the current patch. Not set if
    -+the current patch is the cover letter.
    -++
    -+	GIT_FP_HEADER_CMD_COUNT
    -++
    -+The current patch count. Increments for each patch.
    ++--
    ++GIT_FP_HEADER_CMD_VERSION;;
    ++	The version of this API. Currently `1`. _<cmd>_ may return exit code
    ++	`2` in order to signal that it does not support the given version.
    ++GIT_FP_HEADER_CMD_HASH;;
    ++	The hash of the commit corresponding to the current patch. Not set if
    ++	the current patch is the cover letter.
    ++GIT_FP_HEADER_CMD_COUNT;;
    ++	The current patch count. Increments for each patch.
    ++--
     ++
     +`git format-patch` will error out if _<cmd>_ returns a non-zero exit
     +code.
    @@ builtin/log.c: static void make_cover_letter(struct rev_info *rev, int use_separ
      		show_range_diff(rev->rdiff1, rev->rdiff2, &range_diff_opts);
      		strvec_clear(&other_arg);
      	}
    -+	free((char *)pp.after_subject);
    ++	free(pp.after_subject);
      }
      
      static char *clean_message_id(const char *msg_id)
    @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
      		/* interdiff/range-diff in cover-letter; omit from patches */
      		rev.idiff_oid1 = NULL;
      		rev.rdiff1 = NULL;
    -+		free((char *)rev.pe_headers);
    ++		free(rev.pe_headers);
      	}
      	rev.add_signoff = do_signoff;
      
    @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
      		}
      		if (output_directory)
      			fclose(rev.diffopt.file);
    -+		free((char *)rev.pe_headers);
    ++		free(rev.pe_headers);
      	}
      	stop_progress(&progress);
      	free(list);
     
    - ## log-tree.c ##
    -@@ log-tree.c: void fmt_output_email_subject(struct strbuf *sb, struct rev_info *opt)
    - 	}
    - }
    - 
    -+static char *extra_and_pe_headers(const char *extra_headers, const char *pe_headers) {
    -+	struct strbuf all_headers = STRBUF_INIT;
    -+
    -+	if (extra_headers)
    -+		strbuf_addstr(&all_headers, extra_headers);
    -+	if (pe_headers) {
    -+		strbuf_addstr(&all_headers, pe_headers);
    -+	}
    -+	return strbuf_detach(&all_headers, NULL);
    -+}
    -+
    - void log_write_email_headers(struct rev_info *opt, struct commit *commit,
    - 			     const char **extra_headers_p,
    - 			     int *need_8bit_cte_p,
    - 			     int maybe_multipart)
    - {
    --	const char *extra_headers = opt->extra_headers;
    -+	const char *extra_headers =
    -+		extra_and_pe_headers(opt->extra_headers, opt->pe_headers);
    - 	const char *name = oid_to_hex(opt->zero_commit ?
    - 				      null_oid() : &commit->object.oid);
    - 
    -@@ log-tree.c: void log_write_email_headers(struct rev_info *opt, struct commit *commit,
    - 			 extra_headers ? extra_headers : "",
    - 			 mime_boundary_leader, opt->mime_boundary,
    - 			 mime_boundary_leader, opt->mime_boundary);
    -+		free((char *)extra_headers);
    - 		extra_headers = strbuf_detach(&subject_buffer, NULL);
    - 
    - 		if (opt->numbered_files)
    -@@ log-tree.c: void show_log(struct rev_info *opt)
    - 
    - 	strbuf_release(&msgbuf);
    - 	free(ctx.notes_message);
    -+	free((char *)ctx.after_subject);
    - 
    - 	if (cmit_fmt_is_mail(ctx.fmt) && opt->idiff_oid1) {
    - 		struct diff_queue_struct dq;
    -
    - ## revision.h ##
    -@@ revision.h: struct rev_info {
    - 	struct string_list *ref_message_ids;
    - 	int		add_signoff;
    - 	const char	*extra_headers;
    -+	/* per-email headers */
    -+	const char	*pe_headers;
    - 	const char	*log_reencode;
    - 	const char	*subject_prefix;
    - 	int		patch_name_max;
    -
      ## t/t4014-format-patch.sh ##
     @@ t/t4014-format-patch.sh: test_expect_failure 'configuration To: header (rfc2047)' '
      	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs9
    @@ t/t4014-format-patch.sh: test_expect_failure 'configuration To: header (rfc2047)
     +'
     +
     +test_expect_success '--header-cmd with no output works' '
    -+	write_script cmd <<-\EOF &&
    -+	exit 0
    -+	EOF
    -+	git format-patch --header-cmd=./cmd --stdout main..side
    ++	git format-patch --header-cmd=true --stdout main..side
     +'
     +
     +test_expect_success '--header-cmd reports failed command' '
    -+	write_script cmd <<-\EOF &&
    -+	exit 1
    -+	EOF
    -+		cat > expect <<-\EOF &&
    -+	fatal: header-cmd ./cmd: failed with exit code 1
    ++	cat > expect <<-\EOF &&
    ++	fatal: header-cmd false: failed with exit code 1
     +	EOF
    -+	test_must_fail git format-patch --header-cmd=./cmd --stdout main..side >actual 2>&1 &&
    ++	test_must_fail git format-patch --header-cmd=false --stdout main..side >actual 2>&1 &&
     +	test_cmp expect actual
     +'
     +
3:  0e8409227e4 ! 3:  c570467c8db format-patch: check if header output looks valid
    @@ builtin/log.c: static char *header_cmd_output(struct rev_info *rev, const struct
     
      ## t/t4014-format-patch.sh ##
     @@ t/t4014-format-patch.sh: test_expect_success '--header-cmd with no output works' '
    - 	git format-patch --header-cmd=./cmd --stdout main..side
    + 	git format-patch --header-cmd=true --stdout main..side
      '
      
     +test_expect_success '--header-cmd without headers-like output fails' '
    @@ t/t4014-format-patch.sh: test_expect_success '--header-cmd with no output works'
     +'
     +
      test_expect_success '--header-cmd reports failed command' '
    - 	write_script cmd <<-\EOF &&
    - 	exit 1
    + 	cat > expect <<-\EOF &&
    + 	fatal: header-cmd false: failed with exit code 1
-- 
2.44.0.144.g29ae9861142

