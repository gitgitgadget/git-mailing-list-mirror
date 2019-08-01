Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDF5C1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 00:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfHAAV3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 20:21:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34881 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbfHAAV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 20:21:29 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so31190693plp.2
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 17:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aaes6wxceHboqNmxKRVs99B70IA6zS0ovASAH+N3OfY=;
        b=SbIZHsAfkqwjvSfTgUMmpnecR2cZfOt3TT4j6zUM+pZxgdZJzhJLBbv19HTLCTZ/Ho
         YFnzPHhIyq0uTeA3VnApdWq/I2Wcw86NK+33ACMSWWggZNKYNJb+9cME384YXDzcPsb/
         G+ZVwwQKhwWQPRs9qoCRsfx4G0xAz0WX0AIXUnJGB2LGFXnDnzkhOlz6Y+HrgujMYxAw
         7iNNOCMsIHPbQwndr7wvg1vUJ5+DAyh4B6RxrSQevWxmW/ds6b1iT5K2zbk3FjLELgGn
         oiWV9Y20s5TW4HkBomJnNGMPpW7BZAXuj9dqbi7Sh18bolHNN5O0cK5xF5Anz/Zvrv96
         K+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aaes6wxceHboqNmxKRVs99B70IA6zS0ovASAH+N3OfY=;
        b=rSBldv4jambiTNYBooD2bNiPUP2owZ2ZI4nsu6uBeT4A2MnTGxQtWz/nTEUti/9ios
         tFjFoWh117ujXF9sWHZ5I/gPAI/b86xAamWhyrAQX/RCgs4S9W6wGS42VnsYMtD1kWff
         yIxecEt2vo8oDcalGqWsFIPXhjt4qrf3neLSUGwkVskJ3eocS2SF1Zk1VscIM1tQXnFy
         9AkZ7KkfOwyJOYNH9UKLzQVOarX5F6stvSa6ZPtBSGxnOm8eWv9qAMXn7sdgnqRLqpLO
         mg7uZ7HH7IJVWHWncJbmYNOAbJQfD87+88YImndj+uiXl8bxvS45FCWCcvLwUNdHCIdY
         ZzoA==
X-Gm-Message-State: APjAAAVSLAAKckfpR74gb+sWcKzSfRiwy1rafYfGBKTYRStb1GS8DKq3
        Xp7ahQP7S49b8e0u4DKxIgM=
X-Google-Smtp-Source: APXvYqzdLQQLEXScx3mC8bGZNpadXyeB5GimWc+4o64QYglvx0ErmNUyFHS4/TS8VP1N63FHWX64MQ==
X-Received: by 2002:a17:902:8b88:: with SMTP id ay8mr118916098plb.139.1564618888257;
        Wed, 31 Jul 2019 17:21:28 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id b6sm60977753pgq.26.2019.07.31.17.21.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 17:21:27 -0700 (PDT)
Date:   Wed, 31 Jul 2019 17:21:25 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com,
        Ariadne Conill <ariadne@dereferenced.org>
Subject: Re: Git for Windows v2.23.0-rc0, was Re: [ANNOUNCE] Git v2.23.0-rc0
Message-ID: <20190801002125.GA176307@google.com>
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet>
 <20190731231848.GC1933@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731231848.GC1933@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> I think part of what my annoyance is responding to (and your willingness
> to just squelch this for everybody) is that switching this particular
> default isn't really that big a deal, that it requires annoying people
> on every single "git log" invocation. Perhaps we would be better
> squelching it entirely and just putting a mention in the release notes.

Yes.

Although as Dscho mentions, it's particularly irritating because it is
not part of the paginated output.

I wonder if the ideal might not be to trigger it more selectively, when
the output actually changed due to a reflog entry.  I mean something
like

	commit 393a9dd0f9762c69f753a8fa0bc89c203c6b4e9e (HEAD, origin/foo, other/pu)
	Merge: 18598e40e6 1eba6eb1c2
	Author: A U Thor <author@example.com> (see "git help mailmap")
	Date:   Tue Jul 30 15:05:41 2019 -0700

	    Merge branch 'jt/fetch-cdn-offload' into foo

The message

	warning: log.mailmap is not set; its implicit value will change in an
	upcoming release. To squelch this message and preserve current
	behaviour, set the log.mailmap configuration value to false.

	To squelch this message and adopt the new behaviour now, set the
	log.mailmap configuration value to true.

is *particularly* unactionable in the current state where we're not
rewriting authors.  I think we should bite the bullet and just flip
the default to "true", with the config as an escape hatch to allow
going back to the old behavior.

Is it too late in the release cycle to do that?  If not, we can do

-- >8 --
Subject: log: use mailmap by default in interactive use

In f0596ecc8de9 (log: add warning for unspecified log.mailmap setting,
2019-07-15), we prepared for a future where "git log" uses the mailmap
by default, using the following conditions:

 1. If log.mailmap or --[no-]use-mailmap is set explicitly explicitly,
    respect that.  Otherwise:

 2. If output is not going to a terminal or pager, we might be in a
    script.  Match historical behavior by not using the mailmap.
    Otherwise:

 3. If the output format was specified using --pretty, we might be in
    a script that produces output intended for copy/paste.  Match
    historical behavior by not using the mailmap.  Otherwise:

 4. This is an interactive use, where we will be able to change the
    default behavior.  Print a warning about the upcoming change
    but don't use the mailmap yet.

In practice, the case (4) turns out to be irritating.  It prints
before pager setup, so it just flashes on the screen.  It appears on
every "git log" invocation, even when the mailmap would not result in
the output changing.  The change is not meaningful to most people, and
the new default of --use-mailmap is likely to be preferable for all of
them.

Let's bite the bullet and jump straight to --use-mailmap in case (4).

While at it, add a new log.mailmap setting "auto" that can be used to
explicitly request the new automatic behavior (so that e.g. if
log.mailmap is set to "true" system-side, I can set it to "auto" in my
per-user configuration).

Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/RelNotes/2.23.0.txt |  6 ++----
 Documentation/config/log.txt      |  4 +++-
 builtin/log.c                     | 23 ++++++-----------------
 t/t4203-mailmap.sh                | 20 ++++++++++++++++++++
 t/t7006-pager.sh                  |  2 --
 5 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/Documentation/RelNotes/2.23.0.txt b/Documentation/RelNotes/2.23.0.txt
index 9896599b2f..b4765a5472 100644
--- a/Documentation/RelNotes/2.23.0.txt
+++ b/Documentation/RelNotes/2.23.0.txt
@@ -91,10 +91,8 @@ UI, Workflows & Features
    commit-graph files now, which allows the commit-graph files to be
    updated incrementally.
 
- * The "git log" command learns to issue a warning when log.mailmap
-   configuration is not set and --[no-]mailmap option is not used, to
-   prepare users for future versions of Git that uses the mailmap by
-   default.
+ * The "git log" command learned to use --mailmap by default when
+   used interactively without a --pretty format option.
 
  * "git range-diff" output has been tweaked for easier identification
    of which part of what file the patch shown is about.
diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 7798e10cb0..739ea298aa 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -41,4 +41,6 @@ log.showSignature::
 log.mailmap::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--use-mailmap`, otherwise
-	assume `--no-use-mailmap`. False by default.
+	assume `--no-use-mailmap`. The default is `auto`, which means
+	to use mailmap if the output is going to a terminal and no
+	`--pretty` format has been specified.
diff --git a/builtin/log.c b/builtin/log.c
index 1cf9e37736..bafce51d01 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -156,16 +156,6 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 		parse_date_format(default_date_mode, &rev->date_mode);
 }
 
-static char warn_unspecified_mailmap_msg[] =
-N_("log.mailmap is not set; its implicit value will change in an\n"
-   "upcoming release. To squelch this message and preserve current\n"
-   "behaviour, set the log.mailmap configuration value to false.\n"
-   "\n"
-   "To squelch this message and adopt the new behaviour now, set the\n"
-   "log.mailmap configuration value to true.\n"
-   "\n"
-   "See 'git help config' and search for 'log.mailmap' for further information.");
-
 static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
@@ -214,12 +204,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	memset(&w, 0, sizeof(w));
 	userformat_find_requirements(NULL, &w);
 
-	if (mailmap < 0) {
-		if (session_is_interactive() && !rev->pretty_given)
-			warning("%s\n", _(warn_unspecified_mailmap_msg));
-
-		mailmap = 0;
-	}
+	if (mailmap < 0)
+		mailmap = session_is_interactive() && !rev->pretty_given;
 
 	if (!rev->show_notes_given && (!rev->pretty_given || w.notes))
 		rev->show_notes = 1;
@@ -477,7 +463,10 @@ static int git_log_config(const char *var, const char *value, void *cb)
 	if (skip_prefix(var, "color.decorate.", &slot_name))
 		return parse_decorate_color_config(var, slot_name, value);
 	if (!strcmp(var, "log.mailmap")) {
-		use_mailmap_config = git_config_bool(var, value);
+		if (value && !strcasecmp(value, "auto"))
+			use_mailmap_config = -1;
+		else
+			use_mailmap_config = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "log.showsignature")) {
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 43b1522ea2..e398bc803a 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -3,6 +3,7 @@
 test_description='.mailmap configurations'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 fuzz_blame () {
 	sed "
@@ -442,6 +443,25 @@ test_expect_success 'Log output with log.mailmap' '
 	test_cmp expect actual
 '
 
+test_expect_success TTY 'Use mailmap by default when writing to terminal' '
+	test_terminal git log | grep Author >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success TTY 'Config overrides terminal' '
+	cat >expect <<-\EOF &&
+	Author: CTO <cto@coompany.xx>
+	Author: claus <me@company.xx>
+	Author: santa <me@company.xx>
+	Author: nick2 <nick2@company.xx>
+	Author: nick2 <bugs@company.xx>
+	Author: nick1 <bugs@company.xx>
+	Author: A U Thor <author@example.com>
+	EOF
+	test_terminal git -c log.mailmap=False log | grep Author >actual &&
+	test_cmp expect actual
+'
+
 cat >expect <<\EOF
 Author: Santa Claus <santa.claus@northpole.xx>
 Author: Santa Claus <santa.claus@northpole.xx>
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 7976fa7bcc..00e09a375c 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -7,8 +7,6 @@ test_description='Test automatic use of a pager.'
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
 test_expect_success 'setup' '
-	: squelch advice messages during the transition &&
-	git config --global log.mailmap false &&
 	sane_unset GIT_PAGER GIT_PAGER_IN_USE &&
 	test_unconfig core.pager &&
 
-- 
2.22.0.770.g0f2c4a37fd

