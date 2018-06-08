Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B9881F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbeFHWmR (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:42:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54559 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753253AbeFHWmP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:42:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id o13-v6so5695665wmf.4
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BsRFNSgLfTdhWAOdf9pqF/cqY8ElLIVmoVq06/OT5+A=;
        b=kV364QpfCg1cLI21yGVZCbdJZ/keShQyuGgXm2OQ6Xpx7Ef89RTswmvUqMkbquDjDP
         MkIopvyjLRpyKH+VAS3EF6Jc/kFv8a/e7ZeSZUgLz3n5GYhRntenzfZRYQxCbESJ1tG/
         R8ZEUtsZMHYerhaEZLji7eu+GhDGGy+3eCKTRf0NkBiJ1slvjB2cLlJxLSFCH0RAGrgL
         NCozB88G8o5HXOvnpv0UwNjlh7sbuOCzTykGewa7/1CL7p+kWdogdMKii7gqbD1mOLjc
         Y68zSloLB6ykRmY+Nnh6njrP4XVGpkzevD8q69Ik7OPIZUrT3fHcOtprEawo0BQnBZg+
         Ctqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BsRFNSgLfTdhWAOdf9pqF/cqY8ElLIVmoVq06/OT5+A=;
        b=TSLBQg08H7+vRZsjl1dxWwF67CZryJty3+JmLTjF6KM5dqXoamYPFHtSq9qDWy5d4s
         K32grfHoH0mdhGc0XeyVbDtFelqt+H9xzOZRb9N4SN/xDrXX0nWMZrp8hjak/CQ3kmSx
         sdONQsFNYE8hzlOsve6TaMuz3PC5lpUxZzcxgXpAUQe+b88h+nOqsJcZbSrLJTzBgJB+
         IsdICP+QI29x+C0p37sB8GevjGG4eKMTwEQrdVTP3MoavKyvslBwZH+yBtfZ6dJw9mX9
         FQwlH1coisOObY6bNc5/2oTSVZs8Fo31rClO94PF/CeSYw4H7qsmi4l3wdqcdQ1tGfTb
         flLQ==
X-Gm-Message-State: APt69E2LdQpqOO35OxmLCly3Q/VvySvl+OmCZzk7BiVESeaUvmR1gqjS
        /abJtJf+XW46dhKzhgcGZ2bokk4+
X-Google-Smtp-Source: ADUXVKIF4yQRYS47WoN5YRm162gsqRooiVOAFf9KOnhZmsLVT0tra+xONqHpY0/0XQCi330Ofis4hg==
X-Received: by 2002:a1c:bfce:: with SMTP id o75-v6mr2464856wmi.122.1528497733182;
        Fri, 08 Jun 2018 15:42:13 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w15-v6sm36350010wro.52.2018.06.08.15.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:42:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 19/20] abbrev: support relative abbrev values
Date:   Fri,  8 Jun 2018 22:41:35 +0000
Message-Id: <20180608224136.20220-20-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180608224136.20220-1-avarab@gmail.com>
References: <20180608224136.20220-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the core.abbrev config variable and the corresponding --abbrev
command-line option to support relative values such as +1 or -1.

Before Linus's e6c587c733 ("abbrev: auto size the default
abbreviation", 2016-09-30) git would default to abbreviating object
names to 7-hexdigits, and only picking longer SHA-1s as needed if that
was ambiguous.

That change instead set the default length as a function of the
estimated current count of objects:

    Based on the expectation that we would see collision in a
    repository with 2^(2N) objects when using object names shortened
    to first N bits, use sufficient number of hexdigits to cover the
    number of objects in the repository.  Each hexdigit (4-bits) we
    add to the shortened name allows us to have four times (2-bits) as
    many objects in the repository.

By supporting relative values for core.abbrev we can allow users to
consistently opt-in for either a higher or lower probability of
collision, without needing to hardcode a given numeric value like
"10", which would be overkill on some repositories, and far to small
on others.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt       |   6 ++
 Documentation/diff-options.txt |   3 +
 Documentation/git-blame.txt    |   3 +
 Documentation/git-branch.txt   |   3 +
 Documentation/git-describe.txt |   3 +
 Documentation/git-ls-files.txt |   3 +
 Documentation/git-ls-tree.txt  |   3 +
 Documentation/git-show-ref.txt |   3 +
 cache.h                        |   1 +
 config.c                       |  11 +++
 diff.c                         |  18 +++-
 environment.c                  |   1 +
 parse-options-cb.c             |  12 ++-
 revision.c                     |  18 +++-
 sha1-name.c                    |  11 +++
 t/t0014-abbrev.sh              | 170 ++++++++++++++++++++++-----------
 16 files changed, 204 insertions(+), 65 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab641bf5a9..abf07be7b6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -919,6 +919,12 @@ core.abbrev::
 	in your repository, which hopefully is enough for
 	abbreviated object names to stay unique for some time.
 	The minimum length is 4.
++
+This can also be set to relative values such as `+2` or `-2`, which
+means to add or subtract N characters from the SHA-1 that Git would
+otherwise print, this allows for producing more future-proof SHA-1s
+for use within a given project, while adjusting the value for the
+current approximate number of objects.
 
 add.ignoreErrors::
 add.ignore-errors (deprecated)::
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index f466600972..f1114a7b8d 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -384,6 +384,9 @@ endif::git-format-patch[]
 	independent of the `--full-index` option above, which controls
 	the diff-patch output format.  Non default number of
 	digits can be specified with `--abbrev=<n>`.
++
+Can also be set to a relative value, see `core.abbrev` in
+linkgit:git-diff[1].
 
 -B[<n>][/<m>]::
 --break-rewrites[=[<n>][/<m>]]::
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index d6cddbcb2e..8559d3b0c7 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -99,6 +99,9 @@ requested, resulting in unaligned output.
 Before 2.19, setting `core.abbrev=40` wouldn't apply the above rule
 and would cause blame to emit output that was unaligned. This bug has
 since been fixed.
++
+Can also be set to a relative value, see `core.abbrev` in
+linkgit:git-diff[1].
 
 
 THE PORCELAIN FORMAT
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 02eccbb931..0f8032cec6 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -182,6 +182,9 @@ See `--create-reflog` above for details.
 	Alter the sha1's minimum display length in the output listing.
 	The default value is 7 and can be overridden by the `core.abbrev`
 	config option.
++
+Can also be set to a relative value, see `core.abbrev` in
+linkgit:git-diff[1].
 
 --no-abbrev::
 	Display the full sha1s in the output listing rather than abbreviating them.
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index e027fb8c4b..a3d5c7e817 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -65,6 +65,9 @@ OPTIONS
 	abbreviated object name, use <n> digits, or as many digits
 	as needed to form a unique object name.  An <n> of 0
 	will suppress long format, only showing the closest tag.
++
+Can also be set to a relative value, see `core.abbrev` in
+linkgit:git-diff[1].
 
 --candidates=<n>::
 	Instead of considering only the 10 most recent tags as
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 5298f1bc30..f9af2b23bf 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -153,6 +153,9 @@ a space) at the start of each line:
 	Instead of showing the full 40-byte hexadecimal object
 	lines, show only a partial prefix.
 	Non default number of digits can be specified with --abbrev=<n>.
++
+Can also be set to a relative value, see `core.abbrev` in
+linkgit:git-diff[1].
 
 --debug::
 	After each line that describes a file, add more data about its
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 9dee7bef35..bcba39eed8 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -64,6 +64,9 @@ OPTIONS
 	Instead of showing the full 40-byte hexadecimal object
 	lines, show only a partial prefix.
 	Non default number of digits can be specified with --abbrev=<n>.
++
+Can also be set to a relative value, see `core.abbrev` in
+linkgit:git-diff[1].
 
 --full-name::
 	Instead of showing the path names relative to the current working
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index d28e6154c6..05c5579075 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -66,6 +66,9 @@ OPTIONS
 
 	Abbreviate the object name.  When using `--hash`, you do
 	not have to say `--hash --abbrev`; `--hash=n` would do.
++
+Can also be set to a relative value, see `core.abbrev` in
+linkgit:git-diff[1].
 
 -q::
 --quiet::
diff --git a/cache.h b/cache.h
index 89a107a7f7..0fb4211804 100644
--- a/cache.h
+++ b/cache.h
@@ -772,6 +772,7 @@ extern int check_stat;
 extern int quote_path_fully;
 extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
+extern int default_abbrev_relative;
 extern int ignore_case;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
diff --git a/config.c b/config.c
index 12f762ad92..cd95c6bdfb 100644
--- a/config.c
+++ b/config.c
@@ -1151,6 +1151,17 @@ static int git_default_core_config(const char *var, const char *value)
 			return config_error_nonbool(var);
 		if (!strcasecmp(value, "auto")) {
 			default_abbrev = -1;
+		} else if (*value == '+' || *value == '-') {
+			int relative = git_config_int(var, value);
+			if (relative == 0)
+				die(_("bad core.abbrev value %s. "
+				      "relative values must be non-zero"),
+				    value);
+			if (abs(relative) > GIT_SHA1_HEXSZ)
+				die(_("bad core.abbrev value %s. "
+				      "impossibly out of range"),
+				    value);
+			default_abbrev_relative = relative;
 		} else {
 			int abbrev = git_config_int(var, value);
 			if (abbrev < minimum_abbrev || abbrev > 40)
diff --git a/diff.c b/diff.c
index e0141cfbc0..f7861b8472 100644
--- a/diff.c
+++ b/diff.c
@@ -4801,16 +4801,28 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "--abbrev"))
 		options->abbrev = DEFAULT_ABBREV;
 	else if (skip_prefix(arg, "--abbrev=", &arg)) {
+		int v;
 		char *end;
 		if (!strcmp(arg, ""))
 			die("--abbrev expects a value, got '%s'", arg);
-		options->abbrev = strtoul(arg, &end, 10);
+		v = strtoul(arg, &end, 10);
 		if (*end)
 			die("--abbrev expects a numerical value, got '%s'", arg);
-		if (options->abbrev < MINIMUM_ABBREV) {
+		if (*arg == '+' || *arg == '-') {
+			if (v == 0) {
+				die("relative abbrev must be non-zero");
+			} else if (abs(v) > the_hash_algo->hexsz) {
+				die("relative abbrev impossibly out of range");
+			} else {
+				default_abbrev_relative = v;
+				options->abbrev = DEFAULT_ABBREV;
+			}
+		} else if (v < MINIMUM_ABBREV) {
 			options->abbrev = MINIMUM_ABBREV;
-		} else if (the_hash_algo->hexsz < options->abbrev) {
+		} else if (the_hash_algo->hexsz < v) {
 			options->abbrev = the_hash_algo->hexsz;
+		} else {
+			options->abbrev = v;
 		}
 	}
 	else if ((argcount = parse_long_opt("src-prefix", av, &optarg))) {
diff --git a/environment.c b/environment.c
index 2a6de2330b..0d48d52fba 100644
--- a/environment.c
+++ b/environment.c
@@ -22,6 +22,7 @@ int trust_ctime = 1;
 int check_stat = 1;
 int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = -1;
+int default_abbrev_relative = 0;
 int ignore_case;
 int assume_unchanged;
 int prefer_symlink_refs;
diff --git a/parse-options-cb.c b/parse-options-cb.c
index aa9984f164..2a1ab449bf 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -16,12 +16,22 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
 	if (!arg) {
 		v = unset ? 0 : DEFAULT_ABBREV;
 	} else {
+		const char *origarg = arg;
 		if (!strcmp(arg, ""))
 			return opterror(opt, "expects a value", 0);
 		v = strtol(arg, (char **)&arg, 10);
 		if (*arg)
 			return opterror(opt, "expects a numerical value", 0);
-		if (v && v < MINIMUM_ABBREV) {
+		if (*origarg == '+' || *origarg == '-') {
+			if (v == 0) {
+				return opterror(opt, "relative abbrev must be non-zero", 0);
+			} else if (abs(v) > GIT_SHA1_HEXSZ) {
+				return opterror(opt, "relative abbrev impossibly out of range", 0);
+			} else {
+				default_abbrev_relative = v;
+				v = -1;
+			}
+		} else if (v && v < MINIMUM_ABBREV) {
 			v = MINIMUM_ABBREV;
 		} else if (v > GIT_SHA1_HEXSZ) {
 			v = GIT_SHA1_HEXSZ;
diff --git a/revision.c b/revision.c
index 2a75fef22d..c858d32da7 100644
--- a/revision.c
+++ b/revision.c
@@ -2047,16 +2047,28 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--abbrev")) {
 		revs->abbrev = DEFAULT_ABBREV;
 	} else if (skip_prefix(arg, "--abbrev=", &optarg)) {
+		int v;
 		char *end;
 		if (!strcmp(optarg, ""))
 			die("--abbrev expects a value, got '%s'", optarg);
-		revs->abbrev = strtoul(optarg, &end, 10);
+		v = strtoul(optarg, &end, 10);
 		if (*end)
 			die("--abbrev expects a numerical value, got '%s'", optarg);
-		if (revs->abbrev < MINIMUM_ABBREV) {
+		if (*optarg == '+' || *optarg == '-') {
+			if (v == 0) {
+				die("relative abbrev must be non-zero");
+			} else if (abs(v) > hexsz) {
+				die("relative abbrev impossibly out of range");
+			} else {
+				default_abbrev_relative = v;
+				revs->abbrev = DEFAULT_ABBREV;
+			}
+		} else if (v < MINIMUM_ABBREV) {
 			revs->abbrev = MINIMUM_ABBREV;
-		} else if (revs->abbrev > hexsz) {
+		} else if (v > hexsz) {
 			revs->abbrev = hexsz;
+		} else {
+			revs->abbrev = v;
 		}
 	} else if (!strcmp(arg, "--abbrev-commit")) {
 		revs->abbrev_commit = 1;
diff --git a/sha1-name.c b/sha1-name.c
index 60d9ef3c7e..75f1bef7d1 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -602,6 +602,17 @@ int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len)
 	if (len == GIT_SHA1_HEXSZ || !len)
 		return GIT_SHA1_HEXSZ;
 
+	if (default_abbrev_relative) {
+		int dar = default_abbrev_relative;
+		if (len + dar > GIT_SHA1_HEXSZ) {
+			return GIT_SHA1_HEXSZ;
+		} else if (len + dar < MINIMUM_ABBREV) {
+			len = MINIMUM_ABBREV;
+			dar = 0;
+		}
+		len += dar;
+	}
+
 	mad.init_len = len;
 	mad.cur_len = len;
 	mad.hex = hex;
diff --git a/t/t0014-abbrev.sh b/t/t0014-abbrev.sh
index 8448f78560..73d990ecc1 100755
--- a/t/t0014-abbrev.sh
+++ b/t/t0014-abbrev.sh
@@ -68,23 +68,33 @@ test_expect_success 'abbrev non-integer value handling differs ' '
 	test_i18ngrep "expects a numerical value" stderr
 '
 
-for i in -41 -20 -10 -1 -0 +0 0 1 2 3 41
+for i in -41 +41
 do
 	test_expect_success "core.abbrev value $i out of range errors out" "
 		test_must_fail git -c core.abbrev=$i log -1 --pretty=format:%h 2>stderr &&
-		test_i18ngrep 'abbrev length out of range' stderr
+		test_i18ngrep 'impossibly out of range' stderr
 	"
 done
 
-for i in -41 -20 -10 -1
+for i in -39 -20 -10 -3
 do
-	test_expect_success "negative --abbrev=$i value out of range means --abbrev=40" "
+	test_expect_success "negative -31..-3 --abbrev=$i mean --abbrev=4" "
 		git log --abbrev=$i -1 --pretty=format:%h >log &&
-		test_byte_count = 40 log
+		test_byte_count = 4 log
+	"
+done
+
+for i in -9001 -41 +41 +9001
+do
+	test_expect_success "core.abbrev=$i and --abbrev=$i values out of range error out" "
+		test_must_fail git -c core.abbrev=$i branch -v 2>stderr &&
+		test_i18ngrep 'impossibly out of range' stderr &&
+		test_must_fail git branch -v --abbrev=$i 2>stderr &&
+		test_i18ngrep 'impossibly out of range' stderr
 	"
 done
 
-for i in 0 1 2 3 4 -0 +0 +1 +2 +3 +4
+for i in 0 1 2 3 4
 do
 	test_expect_success "non-negative --abbrev=$i value <MINIMUM_ABBREV falls back on MINIMUM_ABBREV" "
 		git log --abbrev=$i -1 --pretty=format:%h >log &&
@@ -92,7 +102,7 @@ do
 	"
 done
 
-for i in 41 9001 +41 +9001
+for i in 41 9001
 do
 	test_expect_success "non-negative --abbrev=$i value >MINIMUM_ABBREV falls back on 40" "
 		git log --abbrev=$i -1 --pretty=format:%h >log &&
@@ -110,9 +120,23 @@ do
 		git log --abbrev=$i -1 --pretty=format:%h >log &&
 		test_byte_count = $i log &&
 
-		# core.abbrev=+N is the same as core.abbrev=N
+		# core.abbrev=+N is the same as core.abbrev=7+N
 		git -c core.abbrev=+$i log -1 --pretty=format:%h >log &&
-		test_byte_count = $i log &&
+		if test \$((7 + $i)) -gt 40
+		then
+			test_byte_count = 40 log
+		else
+			test_byte_count = \$((7 + $i)) log
+		fi &&
+
+		# --abbrev=+N is the same as --abbrev=7+N
+		git log --abbrev=+$i -1 --pretty=format:%h >log &&
+		if test \$((7 + $i)) -gt 40
+		then
+			test_byte_count = 40 log
+		else
+			test_byte_count = \$((7 + $i)) log
+		fi &&
 
 		# The --abbrev option should take priority over
 		# core.abbrev
@@ -171,14 +195,17 @@ do
 done
 
 test_expect_success 'blame core.abbrev=[-+]1 and --abbrev=[-+]1' '
-	test_must_fail git -c core.abbrev=+1 blame A.t | cut_tr_d_n_field_n 1 >blame &&
-	test_must_fail git -c core.abbrev=-1 blame A.t | cut_tr_d_n_field_n 1 >blame &&
+	git -c core.abbrev=+1 blame A.t | cut_tr_d_n_field_n 1 >blame &&
+	test_byte_count = 9 blame &&
 
-	git blame --abbrev=-1 A.t | cut_tr_d_n_field_n 1 >blame &&
-	test_byte_count = 5 blame &&
+	git -c core.abbrev=-1 blame A.t | cut_tr_d_n_field_n 1 >blame &&
+	test_byte_count = 7 blame &&
 
 	git blame --abbrev=+1 A.t | cut_tr_d_n_field_n 1 >blame &&
-	test_byte_count = 5 blame
+	test_byte_count = 9 blame &&
+
+	git blame --abbrev=-1 A.t | cut_tr_d_n_field_n 1 >blame &&
+	test_byte_count = 7 blame
 '
 
 for i in $(test_seq 4 40)
@@ -193,14 +220,17 @@ do
 done
 
 test_expect_success 'branch core.abbrev=[-+]1 and --abbrev=[-+]1' '
-	test_must_fail git -c core.abbrev=+1 branch -v | cut_tr_d_n_field_n 3 >branch &&
-	test_must_fail git -c core.abbrev=-1 branch -v | cut_tr_d_n_field_n 3 >branch &&
+	git -c core.abbrev=+1 branch -v | cut_tr_d_n_field_n 3 >branch &&
+	test_byte_count = 8 branch &&
 
-	git branch --abbrev=-1 -v | cut_tr_d_n_field_n 3 >branch &&
-	test_byte_count = 4 branch &&
+	git -c core.abbrev=-1 branch -v | cut_tr_d_n_field_n 3 >branch &&
+	test_byte_count = 6 branch &&
 
-	git branch --abbrev=+1 -v | cut_tr_d_n_field_n 3 >branch &&
-	test_byte_count = 4 branch
+	git branch -v --abbrev=+1 | cut_tr_d_n_field_n 3 >branch &&
+	test_byte_count = 8 branch &&
+
+	git branch -v --abbrev=-1 | cut_tr_d_n_field_n 3 >branch &&
+	test_byte_count = 6 branch
 '
 
 test_expect_success 'describe core.abbrev and --abbrev special cases' '
@@ -225,14 +255,17 @@ do
 done
 
 test_expect_success 'describe core.abbrev=[-+]1 and --abbrev=[-+]1' '
-	test_must_fail git -c core.abbrev=+1 describe | sed_g_tr_d_n >describe &&
-	test_must_fail git -c core.abbrev=-1 describe | sed_g_tr_d_n >describe &&
+	git -c core.abbrev=-1 describe | sed_g_tr_d_n >describe &&
+	test_byte_count = 6 describe &&
+
+	git -c core.abbrev=+1 describe | sed_g_tr_d_n >describe &&
+	test_byte_count = 8 describe &&
 
 	git describe --abbrev=-1 | sed_g_tr_d_n >describe &&
-	test_byte_count = 4 describe &&
+	test_byte_count = 6 describe &&
 
 	git describe --abbrev=+1 | sed_g_tr_d_n >describe &&
-	test_byte_count = 4 describe
+	test_byte_count = 8 describe
 '
 
 for i in $(test_seq 4 40)
@@ -246,17 +279,17 @@ do
 done
 
 test_expect_success 'log core.abbrev=[-+]1 and --abbrev=[-+]1' '
-	test_must_fail git -c core.abbrev=+1 log --pretty=format:%h -1 2>stderr &&
-	test_i18ngrep "abbrev length out of range" stderr &&
+	git -c core.abbrev=+1 log --pretty=format:%h -1 >log &&
+	test_byte_count = 8 log &&
 
-	test_must_fail git -c core.abbrev=-1 log --pretty=format:%h -1 2>stderr &&
-	test_i18ngrep "abbrev length out of range" stderr &&
+	git -c core.abbrev=-1 log --pretty=format:%h -1 >log &&
+	test_byte_count = 6 log &&
 
 	git log --abbrev=+1 --pretty=format:%h -1 | tr_d_n >log &&
-	test_byte_count = 4 log &&
+	test_byte_count = 8 log &&
 
 	git log --abbrev=-1 --pretty=format:%h -1 | tr_d_n >log &&
-	test_byte_count = 40 log
+	test_byte_count = 6 log
 '
 
 for i in $(test_seq 4 40)
@@ -291,43 +324,55 @@ do
 done
 
 test_expect_success 'diff --no-index --raw core.abbrev=[-+]1 and --abbrev=[-+]1' '
-	test_must_fail git -c core.abbrev=+1 diff --no-index --raw X Y 2>stderr &&
-	test_i18ngrep "abbrev length out of range" stderr &&
+	test_must_fail git -c core.abbrev=+1 diff --no-index --raw X Y >diff &&
+	cut_tr_d_n_field_n 3 <diff >diff.3 &&
+	test_byte_count = 8 diff.3 &&
+	cut_tr_d_n_field_n 4 <diff >diff.4 &&
+	test_byte_count = 8 diff.4 &&
 
-	test_must_fail git -c core.abbrev=-1 diff --no-index --raw X Y 2>stderr &&
-	test_i18ngrep "abbrev length out of range" stderr &&
+	test_must_fail git -c core.abbrev=-1 diff --no-index --raw X Y >diff &&
+	cut_tr_d_n_field_n 3 <diff >diff.3 &&
+	test_byte_count = 6 diff.3 &&
+	cut_tr_d_n_field_n 4 <diff >diff.4 &&
+	test_byte_count = 6 diff.4 &&
 
 	test_must_fail git diff --no-index --raw --abbrev=+1 X Y >diff &&
 	cut_tr_d_n_field_n 3 <diff >diff.3 &&
-	test_byte_count = 4 diff.3 &&
+	test_byte_count = 8 diff.3 &&
 	cut_tr_d_n_field_n 4 <diff >diff.4 &&
-	test_byte_count = 4 diff.4 &&
+	test_byte_count = 8 diff.4 &&
 
 	test_must_fail git diff --no-index --raw --abbrev=-1 X Y >diff &&
 	cut_tr_d_n_field_n 3 <diff >diff.3 &&
-	test_byte_count = 4 diff.3 &&
+	test_byte_count = 6 diff.3 &&
 	cut_tr_d_n_field_n 4 <diff >diff.4 &&
-	test_byte_count = 4 diff.4
+	test_byte_count = 6 diff.4
 '
 
 test_expect_success 'diff --raw core.abbrev=[-+]1 and --abbrev=[-+]1' '
-	test_must_fail git -c core.abbrev=+1 diff HEAD~ 2>stderr &&
-	test_i18ngrep "abbrev length out of range" stderr &&
+	git -c core.abbrev=+1 diff --raw HEAD~ >diff &&
+	cut_tr_d_n_field_n 3 <diff >diff.3 &&
+	test_byte_count = 8 diff.3 &&
+	cut_tr_d_n_field_n 4 <diff >diff.4 &&
+	test_byte_count = 8 diff.4 &&
 
-	test_must_fail git -c core.abbrev=-1 diff HEAD~ 2>stderr &&
-	test_i18ngrep "abbrev length out of range" stderr &&
+	git -c core.abbrev=-1 diff --raw HEAD~ >diff &&
+	cut_tr_d_n_field_n 3 <diff >diff.3 &&
+	test_byte_count = 6 diff.3 &&
+	cut_tr_d_n_field_n 4 <diff >diff.4 &&
+	test_byte_count = 6 diff.4 &&
 
-	git diff --raw --abbrev=+1 HEAD~ >diff &&
+	git diff --raw --abbrev=+1 --raw HEAD~ >diff &&
 	cut_tr_d_n_field_n 3 <diff >diff.3 &&
-	test_byte_count = 4 diff.3 &&
+	test_byte_count = 8 diff.3 &&
 	cut_tr_d_n_field_n 4 <diff >diff.4 &&
-	test_byte_count = 4 diff.4 &&
+	test_byte_count = 8 diff.4 &&
 
-	git diff --raw --abbrev=-1 HEAD~ >diff &&
+	git diff --raw --abbrev=-1 --raw HEAD~ >diff &&
 	cut_tr_d_n_field_n 3 <diff >diff.3 &&
-	test_byte_count = 40 diff.3 &&
+	test_byte_count = 6 diff.3 &&
 	cut_tr_d_n_field_n 4 <diff >diff.4 &&
-	test_byte_count = 40 diff.4
+	test_byte_count = 6 diff.4
 '
 
 for i in $(test_seq 4 40)
@@ -342,13 +387,16 @@ done
 
 test_expect_success 'ls-files core.abbrev=[-+]1 and --abbrev=[-+]1' '
 	test_must_fail git -c core.abbrev=+1 ls-files --stage A.t | cut_tr_d_n_field_n 2 >ls-files &&
+	test_byte_count = 40 ls-files &&
+
 	test_must_fail git -c core.abbrev=-1 ls-files --stage A.t | cut_tr_d_n_field_n 2 >ls-files &&
+	test_byte_count = 40 ls-files &&
 
 	git ls-files --abbrev=-1 --stage A.t | cut_tr_d_n_field_n 2 >ls-files &&
-	test_byte_count = 4 ls-files &&
+	test_byte_count = 6 ls-files &&
 
 	git ls-files --abbrev=+1 --stage A.t | cut_tr_d_n_field_n 2 >ls-files &&
-	test_byte_count = 4 ls-files
+	test_byte_count = 8 ls-files
 '
 
 for i in $(test_seq 4 40)
@@ -362,14 +410,17 @@ do
 done
 
 test_expect_success 'ls-tree core.abbrev=[-+]1 and --abbrev=[-+]1' '
-	test_must_fail git -c core.abbrev=+1 ls-tree HEAD A.t | cut -f 1 | cut_tr_d_n_field_n 3 >ls-tree &&
-	test_must_fail git -c core.abbrev=-1 ls-tree HEAD A.t | cut -f 1 | cut_tr_d_n_field_n 3 >ls-tree &&
+	git -c core.abbrev=+1 ls-tree HEAD A.t | cut -f 1 | cut_tr_d_n_field_n 3 >ls-tree &&
+	test_byte_count = 40 ls-tree &&
+
+	git -c core.abbrev=-1 ls-tree HEAD A.t | cut -f 1 | cut_tr_d_n_field_n 3 >ls-tree &&
+	test_byte_count = 40 ls-tree &&
 
 	git ls-tree --abbrev=-1 HEAD A.t | cut -f 1 | cut_tr_d_n_field_n 3 >ls-tree &&
-	test_byte_count = 4 ls-tree &&
+	test_byte_count = 6 ls-tree &&
 
 	git ls-tree --abbrev=+1 HEAD A.t | cut -f 1 | cut_tr_d_n_field_n 3 >ls-tree &&
-	test_byte_count = 4 ls-tree
+	test_byte_count = 8 ls-tree
 '
 
 for i in $(test_seq 4 40)
@@ -385,14 +436,17 @@ do
 done
 
 test_expect_success 'show-ref core.abbrev=[-+]1 and --abbrev=[-+]1' '
-	test_must_fail git -c core.abbrev=+1 show-ref --hash refs/heads/master | tr_d_n >show-ref &&
-	test_must_fail git -c core.abbrev=-1 show-ref --hash refs/heads/master | tr_d_n >show-ref &&
+	git -c core.abbrev=+1 show-ref --hash refs/heads/master | tr_d_n >show-ref &&
+	test_byte_count = 40 show-ref &&
+
+	git -c core.abbrev=-1 show-ref --hash refs/heads/master | tr_d_n >show-ref &&
+	test_byte_count = 40 show-ref &&
 
 	git show-ref --abbrev=-1 --hash refs/heads/master | tr_d_n >show-ref &&
-	test_byte_count = 4 show-ref &&
+	test_byte_count = 6 show-ref &&
 
 	git show-ref --abbrev=+1 --hash refs/heads/master | tr_d_n >show-ref &&
-	test_byte_count = 4 show-ref
+	test_byte_count = 8 show-ref
 '
 
 test_done
-- 
2.17.0.290.gded63e768a

