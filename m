Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793644183;
	b=HVe6R4U7UgoUXe1JY46aqjgPttU9sxVwt6eFG7He3Q66kU5XFybzGmJ8tgA87GE/j7tG
	 6FOc5f2GxILAXPr+q+dhQrfS6jEpdPDHvoEzpqyxvvw0hivxbe59zbMADsrvKXSOI7sr6
	 P4bOVD5fAqwnzykGHxemHSeYbQyuSn2E2cF+FQcOsIIpJjNUFDqnzouYEdgbe6xMAjGo7
	 5o8CTduxC/D7i92E5S9jG+LI4WQZEix3KBllD4RCmlUqFO6Fkd6R46YBGQNuW+h0A3cvo
	 TAZwPvDnI/v16wLvdxsIA132nLnhfuvmOQYdLx6MmvqBUvpqGmp1sIQ9b3EzgUniq+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6WGAoD2Cj1ZchZIlJD+M3KVUYlVk5eTPr5T2jG+f6y8=;
	b=d3n4pl5O2aJsfYSh6PcOWwZ9nLDma2jB79IJRIvKOjDRURS3mC53zI+OtLf/q39OrT46
	 V/6QEmfgMij2mm7dR/otcOygjfc7loYIDoko9lsVbSQeUtDKs3gOaoSwq5INo9mVgs5tW
	 NRWb5ZPF014j7IkK/ca8m97lALPyF3ApHd/A8H8/Gome7uuMZtTqdFxeJiXewLdgocdCl
	 HAVVgzcVOWGgXvCISvqJ+rlWEmy6Im1hAG69yds3U0tABHIjloiBVcZupkRCoiwvpHIZs
	 rSQ6huckXth87nSr53F8bWQTrYnHt6K25bfMlJNLbjJ/WDf9e7HKk/JFqvct64m6nHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=HU5AU9w6;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDEE606D80C
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 18:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CDEE606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=HU5AU9w6
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5351d76e1baso38779781cf.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 10:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1793644182; x=1794248982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6WGAoD2Cj1ZchZIlJD+M3KVUYlVk5eTPr5T2jG+f6y8=;
        b=HU5AU9w6nGzFdNP8g0CuvtAi/3g8im7xKDWWJ25weVqpqWrsfEJiWa6xg7KzuLSnrP
         qFiOI0oAaLC1Wycz7ENHY+1gMfGsmkGo2CapysHJeA2u8GATWmHUF1w8ynHIpN7nroFQ
         774LvI3geErywRb/POGpR29vXm8l4w1NWYlx3h79s4j7sNfGuQrgkTSV+hXLdzNC5i+r
         MtVGSWtmGTUxC+ru9Bl8fNzOgpYZeF6Fyq8e6h4AMA9Ocu5o0qpiFg67K+K/DDwFVjAV
         7iTafSR+rbv1FIPIZZPj/VEwW+aEmqFigwBwkrc2GhORtst0Gb64+/9FXMehi0bl3lm/
         kFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793644182; x=1794248982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6WGAoD2Cj1ZchZIlJD+M3KVUYlVk5eTPr5T2jG+f6y8=;
        b=dLXE86q25EZ6ebsng38+iWud3EIyWFjJ29+ZaIHDoU0eelN7CSnXSNidkPOklH4lnC
         hWBFIoSIrQbtk6TbpBzWoyjLlxePODJgjwrgBIxhyueb2cJCGF94o3wFSHZ3rOlg05ag
         ljoEfe0IHEzVpmPN5HUOYpOUlfga6msl12U1ueyT5WAlmPhcg0CJoxupooSpP/FmIRDd
         5yNl0lf21ZHSMIw2Ghdf9KqXsPAZe4E9YeNQveXsphTFJrRGPeAg/idTF6VgwsMx1EFa
         BBHtFYISzdmzmKd7HlvWs59jGlRkNKHOGBIvCUodndu8hmhdFAX8y1IJBTiGwE4w2OBU
         o7jQ==
X-Gm-Message-State: APuU4Z9o7ebf4jjUraVu4tDnVth14+1Jc8jNXf/5DzA71LgdNHuZwgc5
	/IyEGWyAHywqO5RTZ3IV0z0NoyAnmJnywmEhXEwKLTkzQ+tGzAZcPB4eQ/esHqe1H565c6SPycN
	NdqGVu2jvux+S2/NsQ0zGJodwL8wvBu3XUxJWmXpD25uJkMdi6eX/U2G3HnhujNJqT08N7Zizf8
	y8reh0bY2YaMkkiioGNVDDnd+3uSmkQTtergCJ0yYLLgYpw1yYSfm3mAVT1p9QQDn2lXgBw5AOc
	icD/Zd8guR88Ro/JWTrie8B9ZRiXReKFVwRVcVubj8=
X-Gm-Gg: AYBFou1Zc5U40BNp8WEyLc6P+IgEpxZhqzgsRBrGeo5HXo3FMJ679Kbt3KU8a3YWQZ1
	eB9fOZhdhjP7LGD6CSvGjt/dkeu5RD4px3c7qTkhWq8gDCqRUSyTltP99N4dyQaq0xBtEZU66TW
	CNfML05ileqsp8nPfFbdGO2jV8QWymo4tDxxAMBewEC/JKeaPqwNnqwnbXLDCDn8swpUUkMNv4T
	uyGCAd7YFZz99f2VJsB3Tc1SZjkBjR1GdznoUa7yGE23xESb7MEIFMz1nvutjME/kcDe8qbCdK+
	D5Mj/PKOAyO8AAvyDWqn9DgUjBW9x4jyfe0kC2bQgmke7ZLO09NgwNeRCoboDfvCvLgq9IPyVgJ
	18l8w56/h07gTMr/w6Fwpyq7VHj2qxzm3USajmuR/IWsT8aBeT8EtKuGE/Yk7OaG/B0QxxuAsAl
	xhK9NCqOaiXTvGW3uJ+7mEDmyWfTUjeynaIc0bWTvof3pyLh2bqbrK3Qi6apC95SFdeq583+0YD
	Ns06TN4LCBOuA5kC79gxNbR/uvpTFnnlUXPbw4GkkiyUEEC2yYO5L1P1rm7VIsSMQDXtml07eYT
	K9WMyyP/HftL7aOv5kuhtgKr6mb20wiH9oQBMl7f1pg3TvqSDyvtEs+JnXbG1mRESSRYpybKucd
	zDxHMJZFdgeL/CiL97US0rjSc+D4JKXHmeaXfAPIKPailw2ceFuk5DBSHZXRNxvIxAoY796u+sl
	jZerwSHR3IiMb9QBbqyV8wb2MJ5IrmeKxIIG1WWZJBsAGSBOovJ1HbD+5FCRWASKaPuvs0Ezb5S
	HODIP5njYkoFVKk/UQXK6MHPTjdLlBO1lVEnlSoq0UL6sQ=
X-Received: by 2002:ac8:5f08:0:b0:532:3e92:7255 with SMTP id d75a77b69052e-54120923988mr220352771cf.25.1793644181699;
        Mon, 02 Nov 2026 10:29:41 -0800 (PST)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.66.31])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498b49ce29sm4346221cf.4.2026.11.02.10.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:29:41 -0800 (PST)
From: Jasper Mayone <me@jaspermayone.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	haraldnordgren@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: [PATCH v4 4/4] branch: do not mark the branch the current worktree is rebasing
Date: Mon,  2 Nov 2026 13:29:30 -0500
Message-ID: <20261102182930.3511-5-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102182930.3511-1-me@jaspermayone.com>
References: <20261030142137.54750-1-me@jaspermayone.com>
 <20261102182930.3511-1-me@jaspermayone.com>
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

Since the previous commit, "git branch" marks a branch with "+" when a
worktree is rebasing or bisecting it. In that worktree itself, the
list already starts with "* (no branch, rebasing topic)", so the
"+ topic" line below it says the same thing twice.

The default format cannot tell that apart: %(worktreepath) gives the
same path either way, and comparing it with %(if:equals=...) is not
safe because a path, or a branch name, can contain the ")" that ends
the atom. So build a second format that has no "+" marker and no
"(path)" for -vv, and use it for each branch that
branch_checked_out_worktree() maps to the current worktree. A branch
that is checked out normally in the current worktree also gets that
format, but %(HEAD) still marks it with "*" and -vv already hides
its path, so its output does not change.

To pick a format for each branch, print_ref_list() now formats the
branches itself in place of print_formatted_ref_array(), keeping
--omit-empty. A format given with --format is used for every branch,
as before.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Jasper Mayone <me@jaspermayone.com>
---
 builtin/branch.c         | 103 ++++++++++++++++++++++++++++++---------
 t/t3203-branch-output.sh |  22 ++++++++-
 2 files changed, 101 insertions(+), 24 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a613148fc7..b55a400217 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -418,16 +418,28 @@ static const char *quote_literal_for_format(const char *s)
 	return buf.buf;
 }
 
-static char *build_format(struct ref_filter *filter, int maxwidth, const char *remote_prefix)
+/*
+ * With "show_worktree" unset, the format does not mark a branch that is
+ * checked out in a worktree, nor show the path of that worktree. It is
+ * used for a branch that the current worktree is rebasing or bisecting,
+ * because the "(no branch, ...)" line already names it.
+ */
+static char *build_format(struct ref_filter *filter, int maxwidth,
+			  const char *remote_prefix, int show_worktree)
 {
 	struct strbuf fmt = STRBUF_INIT;
 	struct strbuf local = STRBUF_INIT;
 	struct strbuf remote = STRBUF_INIT;
 
-	strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)%%(if)%%(worktreepath)%%(then)+ %s%%(else)  %s%%(end)%%(end)",
-			branch_get_color(BRANCH_COLOR_CURRENT),
-			branch_get_color(BRANCH_COLOR_WORKTREE),
-			branch_get_color(BRANCH_COLOR_LOCAL));
+	if (show_worktree)
+		strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)%%(if)%%(worktreepath)%%(then)+ %s%%(else)  %s%%(end)%%(end)",
+			    branch_get_color(BRANCH_COLOR_CURRENT),
+			    branch_get_color(BRANCH_COLOR_WORKTREE),
+			    branch_get_color(BRANCH_COLOR_LOCAL));
+	else
+		strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %s%%(end)",
+			    branch_get_color(BRANCH_COLOR_CURRENT),
+			    branch_get_color(BRANCH_COLOR_LOCAL));
 	strbuf_addf(&remote, "  %s",
 		    branch_get_color(BRANCH_COLOR_REMOTE));
 
@@ -447,8 +459,9 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 
 		if (filter->verbose > 1)
 		{
-			strbuf_addf(&local, "%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(worktreepath)%%(then)(%s%%(worktreepath)%s) %%(end)%%(end)",
-				    branch_get_color(BRANCH_COLOR_WORKTREE), branch_get_color(BRANCH_COLOR_RESET));
+			if (show_worktree)
+				strbuf_addf(&local, "%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(worktreepath)%%(then)(%s%%(worktreepath)%s) %%(end)%%(end)",
+					    branch_get_color(BRANCH_COLOR_WORKTREE), branch_get_color(BRANCH_COLOR_RESET));
 			strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
 				    "%%(then): %%(upstream:track,nobracket)%%(end)] %%(end)%%(contents:subject)",
 				    branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
@@ -477,6 +490,32 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 	return strbuf_detach(&fmt, NULL);
 }
 
+static char *current_worktree_path(void)
+{
+	struct worktree **worktrees = get_worktrees(the_repository);
+	char *path = NULL;
+
+	for (size_t i = 0; worktrees[i]; i++) {
+		if (worktrees[i]->is_current) {
+			path = xstrdup(worktrees[i]->path);
+			break;
+		}
+	}
+	free_worktrees(worktrees);
+	return path;
+}
+
+/*
+ * Is "refname" checked out in the worktree at "here", or is that
+ * worktree rebasing or bisecting it?
+ */
+static int checked_out_here(const char *refname, const char *here)
+{
+	const char *path = branch_checked_out_worktree(refname);
+
+	return path && !strcmp(path, here);
+}
+
 static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting,
 			   struct ref_format *format, struct string_list *output)
 {
@@ -485,6 +524,9 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	int maxwidth = 0;
 	const char *remote_prefix = "";
 	char *to_free = NULL;
+	struct ref_format here_format = REF_FORMAT_INIT;
+	char *here_to_free = NULL, *here = NULL;
+	struct strbuf out = STRBUF_INIT, err = STRBUF_INIT;
 
 	/*
 	 * If we are listing more than just remote branches,
@@ -501,39 +543,54 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	if (filter->verbose)
 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
 
-	if (!format->format)
-		format->format = to_free = build_format(filter, maxwidth, remote_prefix);
+	if (!format->format) {
+		format->format = to_free = build_format(filter, maxwidth,
+							remote_prefix, 1);
+		here = current_worktree_path();
+		here_format = *format;
+		here_format.format = here_to_free = build_format(filter, maxwidth,
+								 remote_prefix, 0);
+	}
 	format->use_color = branch_use_color;
+	here_format.use_color = branch_use_color;
 
-	if (verify_ref_format(format))
+	if (verify_ref_format(format) ||
+	    (here && verify_ref_format(&here_format)))
 		die(_("unable to parse format string"));
 
 	filter_ahead_behind(the_repository, &array);
 	ref_array_sort(sorting, &array);
 
-	if (column_active(colopts)) {
-		struct strbuf out = STRBUF_INIT, err = STRBUF_INIT;
-
+	if (column_active(colopts))
 		assert(!filter->verbose && "--column and --verbose are incompatible");
 
-		for (i = 0; i < array.nr; i++) {
-			strbuf_reset(&err);
-			strbuf_reset(&out);
-			if (format_ref_array_item(array.items[i], format, &out, &err))
-				die("%s", err.buf);
+	for (i = 0; i < array.nr; i++) {
+		struct ref_array_item *item = array.items[i];
+		struct ref_format *f = format;
 
+		if (here && checked_out_here(item->refname, here))
+			f = &here_format;
+
+		strbuf_reset(&err);
+		strbuf_reset(&out);
+		if (format_ref_array_item(item, f, &out, &err))
+			die("%s", err.buf);
+
+		if (column_active(colopts))
 			/* format to a string_list to let print_columns() do its job */
 			string_list_append(output, out.buf);
+		else if (out.len || !format->array_opts.omit_empty) {
+			fwrite(out.buf, 1, out.len, stdout);
+			putchar('\n');
 		}
-
-		strbuf_release(&err);
-		strbuf_release(&out);
-	} else {
-		print_formatted_ref_array(&array, format);
 	}
 
+	strbuf_release(&err);
+	strbuf_release(&out);
 	ref_array_clear(&array);
 	free(to_free);
+	free(here_to_free);
+	free(here);
 }
 
 static void print_current_branch_name(void)
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index debfac5f26..5541f1429b 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -456,6 +456,23 @@ test_expect_success 'branch being rebased in a worktree is marked' '
 	test_cmp expect actual
 '
 
+test_expect_success 'branch being rebased is not marked in its own worktree' '
+	test_when_finished "git -C rebase_dir rebase --abort; rm -rf rebase_dir; git worktree prune; git branch -D rebasing" &&
+	git worktree add -b rebasing rebase_dir branch-two &&
+	(
+		cd rebase_dir &&
+		git commit --allow-empty -m rebase-me &&
+		test_must_fail git rebase -f -x false HEAD~1 &&
+		git branch --list rebasing >actual &&
+		echo "  rebasing" >expect &&
+		test_cmp expect actual &&
+		git branch -vv --list rebasing >actual &&
+		test_grep ! "$(pwd)" actual &&
+		git branch >actual &&
+		test_grep "^\* (no branch, rebasing rebasing)" actual
+	)
+'
+
 test_expect_success 'branch being bisected in a worktree is marked' '
 	test_when_finished "git -C bisect_dir bisect reset; rm -rf bisect_dir; git worktree prune; git branch -D bisecting" &&
 	git worktree add -b bisecting bisect_dir branch-two &&
@@ -464,7 +481,10 @@ test_expect_success 'branch being bisected in a worktree is marked' '
 		git commit --allow-empty -m bisect-one &&
 		git commit --allow-empty -m bisect-two &&
 		git bisect start HEAD HEAD~2 &&
-		test_must_fail git symbolic-ref -q HEAD
+		test_must_fail git symbolic-ref -q HEAD &&
+		git branch --list bisecting >actual &&
+		echo "  bisecting" >expect &&
+		test_cmp expect actual
 	) &&
 	git branch --list bisecting >actual &&
 	echo "+ bisecting" >expect &&
-- 
2.56.0

