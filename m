Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978EC3793CA
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773530463; cv=none; b=ezlX53JC7Lyh9nRbPFHjHfNqxs2E81cRbKBao195b8OG8VuIsTeUoaCOje9/BWee3ue3+ffRsbGGJwil2T1zXebU2ajyk77kx1AwySu/6zVhKdSk/tU+zPwxpqFiZToQACGu2HGOnf71xX9SlvvKNBTHkevc+NFR4Y/isCgSe40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773530463; c=relaxed/simple;
	bh=1LBw7KHWLWr2600P/XqceRIt9eURYzKkzV6BImEhYKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTextJei+rXAijCIDN8oX1okl7SHcY8o33iSqHu35itKecXV9NB1k6m7L8vMFtHFcIUbfvEbVEb6WNZwNSOBbX7FR3HPCsC5VpxBTatTVQAdJAzOrJgih6CYeV3VJBhjQnvam1oafPtvNjwn4oLuLwN1kOSG4yEYnDFUyOymv6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=MoHOnv5R; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="MoHOnv5R"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773530454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8oXCYJlLAMp5TeVFOJMAqtkAFtpTnXAiWFRhdO5agF4=;
	b=MoHOnv5Rp5SNrVK4F3rLKeMfU8amA3YXrW4oXV9gBstx8rTRlCUBp6PKmhp3ZnvrqxDQeI
	cEmPEujLAOW7yGXpNzGSxAlwYtzisNnS8uVF5iPRix0/Sh+xI546ZXpq0D4IrSBttTvwFW
	GQxbmE0lLLc5D1eSvu4IzloMNvs6WhxwQ0hyZhKHEn15vJloLCbhUCfL7MeBq49SggyMpq
	5OKK6xHXvM60q7yx/fhGBMkbJAly9/TSstDevJOu31+25+S9ouIWZzi4WfMW9pMcpfhvw8
	qwKJkOk3z8/bpPiCfrrcnXTsAZ4vG7+H1sIS/a7eDJN6wp1kxjg1NGmHFIXq3Q==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>
Subject: [PATCH 3/7] format-patch: rename --cover-letter-format option
Date: Sun, 15 Mar 2026 00:20:46 +0100
Message-ID: <f8d1359eaa1c05d76b3dcce7596e60f48f577b63.1773530191.git.mroik@delayed.space>
In-Reply-To: <cover.1773530191.git.mroik@delayed.space>
References: <cover.1773530191.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7228; i=mroik@delayed.space; h=from:subject:message-id; bh=1LBw7KHWLWr2600P/XqceRIt9eURYzKkzV6BImEhYKA=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBptezDpcb61VGhrChy1hAEJ9Apqo895aZrZf74J XWgkleIE4qJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCabXswwAKCRBIeX6hnBm+ 0bJOD/9yo+hNNir3Rofh+bObNd5S71CUCHb8oAXOrmjOt9FoOtgrrD2zn61rtzw3GmijpXT4GIR esp7HRqDNU1UL8XtMG/vWfJdG49p8uDEhjwV9sILrTk5od+g2NkZ2Qnk9BS+nI5YbeLBlRqSlg2 TbbHzfANJ++vIi80nrkoVRecCDPX3To+iZChlteWNxoYKZD+wERjIIkpOz2GDkKAd3kldqdZlFU zjED3d+pIP6dGcoqg0iuS8P5BBPB+b3KHR7GMEXgg9BdyK37Yk4pXw1EeLKYM2KA+CN+c0weqSo 3tpmLeUTuqsDKXbs4K4WuKXIuyrPU8QTSE+rky67efdZUdVRTBLLfWzZ7AehITUuHyLHidKu7tI tTIlLNni9ONRbFe09gpi1nFJZN1DxbHFR4FGb67kZw5KNXKHQV/u5sidxdFAIjRu8KtgQ7+6MnQ qIXf3JkmafN9eSpE2NP5ARbzAc5hZv8dAnj22oNQDz2mbj3UNkZNb2aOGvdd+faPqXUyxpAKtKk JmKJ9X25nKha3zYnis4PPAc+Baxo2/lGeBErydyAZSMX+8JiQtGf0GE4mW9iMnnXl8lfir+YCqm TYFBn2U/5ybX50Gx3vhDJdQnLXU+h2WltCXLnMWhOmHpTVQJrfGOw+62IzHnPQ/SzXXQckPk27m mfl/cShZf
 7gNGCQ==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

To align the name of the configuration variable and the name of the
command line option, either one should change name. By changing the name
of the option we get the added benefit of having --cover-<TAB> expand to
--cover-letter without ambiguity.

If the user gives the --cover-letter-format option it would be
reasonable to expect that the user wants to generate the cover letter
despite not giving --cover-letter.

Rename --cover-letter-format to --commit-list-format and make it imply
--cover-letter unless --no-cover-letter is given.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/git-format-patch.adoc | 17 ++++++------
 builtin/log.c                       |  4 ++-
 t/t4014-format-patch.sh             | 41 +++++++++++++++--------------
 t/t9902-completion.sh               |  1 -
 4 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 31fa492335..45ca72e670 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -24,7 +24,7 @@ SYNOPSIS
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet]
-		   [--cover-letter-format=<format-spec>]
+		   [--commit-list-format=<format-spec>]
 		   [--[no-]encode-email-headers]
 		   [--no-notes | --notes[=<ref>]]
 		   [--interdiff=<previous>]
@@ -323,16 +323,15 @@ feeding the result to `git send-email`.
 	containing the branch description, shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
 
---cover-letter-format=<format-spec>::
-	Specify the format in which to generate the commit list of the
-	patch series. This option is available if the user wants to use
-	an alternative to the default `shortlog` format. The accepted
-	values for format-spec are "shortlog" or a format string
-	prefixed with `log:`.
+--commit-list-format=<format-spec>::
+	Specify the format in which to generate the commit list of the patch
+	series. The accepted values for format-spec are "shortlog" or a format
+	string prefixed with `log:`.
 	e.g. `log: %s (%an)`
-	If defined, defaults to the `format.commitListFormat` configuration
+	If not given, defaults to the `format.commitListFormat` configuration
 	variable.
-	This option is relevant only if a cover letter is generated.
+	This option implies the use of `--cover-letter` unless
+	`--no-cover-letter` is given.
 
 --encode-email-headers::
 --no-encode-email-headers::
diff --git a/builtin/log.c b/builtin/log.c
index 997bdd608e..a7f129d583 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2014,7 +2014,7 @@ int cmd_format_patch(int argc,
 			    N_("print patches to standard out")),
 		OPT_BOOL(0, "cover-letter", &cover_letter,
 			    N_("generate a cover letter")),
-		OPT_STRING(0, "cover-letter-format", &cover_letter_fmt, N_("format-spec"),
+		OPT_STRING(0, "commit-list-format", &cover_letter_fmt, N_("format-spec"),
 			    N_("format spec used for the commit list in the cover letter")),
 		OPT_BOOL(0, "numbered-files", &just_numbers,
 			    N_("use simple number sequence for output file names")),
@@ -2358,6 +2358,8 @@ int cmd_format_patch(int argc,
 		cover_letter_fmt = cfg.fmt_cover_letter_commit_list;
 		if (!cover_letter_fmt)
 			cover_letter_fmt = "shortlog";
+	} else if (cover_letter == -1) {
+		cover_letter = 1;
 	}
 
 	if (cover_letter == -1) {
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 7c67bdf922..d2a775f78d 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -383,49 +383,50 @@ test_expect_success 'filename limit applies only to basename' '
 test_expect_success 'cover letter with subject, author and count' '
 	rm -rf patches &&
 	test_when_finished "git reset --hard HEAD~1" &&
-	test_when_finished "rm -rf patches result test_file" &&
+	test_when_finished "rm -rf patches test_file" &&
 	touch test_file &&
 	git add test_file &&
 	git commit -m "This is a subject" &&
-	git format-patch --cover-letter \
-	--cover-letter-format="log:[%(count)/%(total)] %s (%an)" -o patches HEAD~1 &&
-	grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch >result &&
-	test_line_count = 1 result
+	git format-patch --commit-list-format="log:[%(count)/%(total)] %s (%an)" \
+	-o patches HEAD~1 &&
+	test_grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch
 '
 
-test_expected_success 'cover letter with author and count' '
+test_expect_success 'cover letter with author and count' '
 	test_when_finished "git reset --hard HEAD~1" &&
-	test_when_finished "rm -rf patches result test_file" &&
+	test_when_finished "rm -rf patches test_file" &&
 	touch test_file &&
 	git add test_file &&
 	git commit -m "This is a subject" &&
-	git format-patch --cover-letter \
-	--cover-letter-format="log:[%(count)/%(total)] %an" -o patches HEAD~1 &&
-	grep "^\[1/1\] A U Thor$" patches/0000-cover-letter.patch >result &&
-	test_line_count = 1 result
+	git format-patch --commit-list-format="log:[%(count)/%(total)] %an" \
+	-o patches HEAD~1 &&
+	test_grep "^\[1/1\] A U Thor$" patches/0000-cover-letter.patch
 '
 
 test_expect_success 'cover letter shortlog' '
 	test_when_finished "git reset --hard HEAD~1" &&
-	test_when_finished "rm -rf patches result test_file" &&
+	test_when_finished "rm -rf expect patches result test_file" &&
+	cat >expect <<-"EOF" &&
+	A U Thor (1):
+	  This is a subject
+	EOF
 	touch test_file &&
 	git add test_file &&
 	git commit -m "This is a subject" &&
-	git format-patch --cover-letter --cover-letter-format=shortlog \
-	-o patches HEAD~1 &&
-	sed -n -e "/^A U Thor/p;" patches/0000-cover-letter.patch >result &&
-	test_line_count = 1 result
+	git format-patch --commit-list-format=shortlog -o patches HEAD~1 &&
+	grep -E -A 1 "^A U Thor \([[:digit:]]+\):$" patches/0000-cover-letter.patch >result &&
+	cat result &&
+	test_cmp expect result
 '
 
-test_expect_success 'cover letter no format' '
+test_expect_success 'no cover letter but with format specified' '
 	test_when_finished "git reset --hard HEAD~1" &&
 	test_when_finished "rm -rf patches result test_file" &&
 	touch test_file &&
 	git add test_file &&
 	git commit -m "This is a subject" &&
-	git format-patch --cover-letter -o patches HEAD~1 &&
-	sed -n -e "/^A U Thor/p;" patches/0000-cover-letter.patch >result &&
-	test_line_count = 1 result
+	git format-patch --no-cover-letter --commit-list-format="[%(count)] %s" -o patches HEAD~1 &&
+	test_path_is_missing patches/0000-cover-letter.patch
 '
 
 test_expect_success 'cover letter config with count, subject and author' '
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 35e20b5351..2f9a597ec7 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2775,7 +2775,6 @@ test_expect_success PERL 'send-email' '
 	test_completion "git send-email --cov" <<-\EOF &&
 	--cover-from-description=Z
 	--cover-letter Z
-	--cover-letter-format=Z
 	EOF
 	test_completion "git send-email --val" <<-\EOF &&
 	--validate Z
-- 
2.53.0.959.g497ff81fa9

