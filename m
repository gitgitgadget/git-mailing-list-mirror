Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B5CB201A0
	for <e@80x24.org>; Thu, 11 May 2017 21:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753208AbdEKVUZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 17:20:25 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:35275 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752459AbdEKVUX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 17:20:23 -0400
Received: by mail-qt0-f170.google.com with SMTP id v27so15687455qtg.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 14:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YnOPNtEf9txXNIC7sYzJGGPoY3W+LJZbMKzvnEHjU5o=;
        b=gBfnVUSEY0Dz4osvt5I4XeGP5ADGHA79/Mw70Ds+8RlyJjVgTOmvDnvHQAU3OKQQfc
         czjiYreyLuIYaIdfgp7pAqhqRkOvPT4+2Hrl1e5XTempHYjwAY2azmE7Xdj9MTOtMMQ5
         7Hn7EPjvxAc9JV8qAJcTb67hHvFnpBWYjv+BtlDVboXmCpOym9yya0UnIKuiKRjllX+2
         eocRcqCtTnFZRJyxgjTMlZrXSmFSkN+DtoDcglOpFs3r6s6YTdN69KP8h/BzIUFqUn2r
         J/r8MF+I7EAwXaU4bWSUV65L+Lza0YSaLspr8sETwteCkLEtyW9NNmNPmfqs2YgGCbpn
         TkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YnOPNtEf9txXNIC7sYzJGGPoY3W+LJZbMKzvnEHjU5o=;
        b=T3L4NvbFwEze88aahp8bEwbNEweolXif1Td92/n4zlTsBafywlS+Jy4Pp7b2WEdMrn
         hbDFGQe1RqQ5u3MLlctu27at00GKKEEmn3vxgKssYpBqx4ZWZWjzbz3siH24cPS3JuIZ
         XAUMJEgweABkb910G9O3TQyB74N57rh18CFLYDBs4h3ST157XU7RXWYjg+9Cjj2Oei5W
         FjJ0VA0Jok5bzy/S0SZ6VVOXCLYD0rmYWvVrMdFoXvJwH41oz9GxpBOlWAG3AjmUOePr
         qzQCler+4L4b+2SS2+iffeLgtQblbLWeiq2fU1v/k+lox6LMq81yYooknpTWTU1S+uto
         kEEg==
X-Gm-Message-State: AODbwcB86tCzOZ8StNb/O4xSjd3x+Srf7JI50i9MThauo7zEkt/nrZx+
        Gv/OOuwYSSk7Pg==
X-Received: by 10.200.53.187 with SMTP id k56mr704548qtb.104.1494537622146;
        Thu, 11 May 2017 14:20:22 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id t20sm942319qtb.22.2017.05.11.14.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 14:20:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] C style: use standard style for "TRANSLATORS" comments
Date:   Thu, 11 May 2017 21:20:12 +0000
Message-Id: <20170511212012.6782-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511204334.GM83655@google.com>
References: <20170511204334.GM83655@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change all the "TRANSLATORS: [...]" comments in the C code to use the
regular Git coding style, and amend the style guide so that the
example there uses that style.

This custom style was necessary back in 2010 when the gettext support
was initially added, and was subsequently documented in commit
cbcfd4e3ea ("i18n: mention "TRANSLATORS:" marker in
Documentation/CodingGuidelines", 2014-04-18).

GNU xgettext hasn't had the parsing limitation that necessitated this
exception for almost 3 years. Since its 0.19 release on 2014-06-02
it's been able to recognize TRANSLATOR comments in the standard Git
comment syntax[1].

Usually we'd like to keep compatibility with software that's that
young, but in this case literally the only person who needs to be
using a gettext newer than 3 years old is Jiang Xin (the only person
who runs & commits "make pot" results), so I think in this case we can
make an exception.

This xgettext parsing feature was added after a thread on the Git
mailing list[2] which continued on the bug-gettext[3] list, but we
never subsequently changed our style & styleguide, do so.

There are already longstanding changes in git that use the standard
comment style & have their TRANSLATORS comments extracted properly
without getting the literal "*"'s mixed up in the text, as would
happen before xgettext 0.19.

Commit 7ff2683253 ("builtin-am: implement -i/--interactive",
2015-08-04) added one such comment, which in commit df0617bfa7 ("l10n:
git.pot: v2.6.0 round 1 (123 new, 41 removed)", 2015-09-05) got picked
up in the po/git.pot file with the right format, showing that Jiang
already runs a modern xgettext.

The xgettext parser does not handle the sort of non-standard comment
style that I'm amending here in sequencer.c, but that isn't standard
Git comment syntax anyway. With this change to sequencer.c & "make
pot" the comment in the pot file is now correct:

     #. TRANSLATORS: %s will be "revert", "cherry-pick" or
    -#. * "rebase -i".
    +#. "rebase -i".

1. http://git.savannah.gnu.org/cgit/gettext.git/commit/?id=10af7fe6bd
2. <2ce9ec406501d112e032c8208417f8100bed04c6.1397712142.git.worldhello.net@gmail.com>
   (https://public-inbox.org/git/2ce9ec406501d112e032c8208417f8100bed04c6.1397712142.git.worldhello.net@gmail.com/)
3. https://lists.gnu.org/archive/html/bug-gettext/2014-04/msg00016.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Thu, May 11, 2017 at 10:43 PM, Brandon Williams <bmwill@google.com> wrote:
> On 05/11, Ævar Arnfjörð Bjarmason wrote:
>> On Thu, May 11, 2017 at 10:21 PM, Brandon Williams <bmwill@google.com> wrote:
>> > On 05/11, Ævar Arnfjörð Bjarmason wrote:
>> >> [...]
>> >> +#ifdef NO_PTHREADS
>> >> +             else if (num_threads && num_threads != 1) {
>> >> +                     /* TRANSLATORS: %s is the configuration
>> >> +                        variable for tweaking threads, currently
>> >> +                        grep.threads */
>> >
>> > nit: this comment isn't formatted properly:
>> >   /*
>> >    * ... comment ...
>> >    */
>>
>> Comments for translators use a different style, see cbcfd4e3ea ("i18n:
>> mention "TRANSLATORS:" marker in Documentation/CodingGuidelines",
>> 2014-04-18). Otherwise the "*" gets interpolated into the string the
>> translators see in their UI.
>>
>
> Ah got it, I wasn't aware of that.

As it turns out this is just something we've been cargo-culting for
years for no reason. Will fix this comment in my v2, but first let's
do this.

 Documentation/CodingGuidelines | 10 +++++-----
 bisect.c                       |  6 ++++--
 builtin/blame.c                | 15 +++++++++------
 builtin/notes.c                |  6 ++++--
 builtin/remote.c               |  7 +++++--
 notes-utils.c                  |  7 +++++--
 parse-options.c                |  6 ++++--
 ref-filter.c                   | 12 ++++++++----
 sequencer.c                    |  3 ++-
 9 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index a4191aa388..9fd7383819 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -256,12 +256,12 @@ For C programs:
 
    Note however that a comment that explains a translatable string to
    translators uses a convention of starting with a magic token
-   "TRANSLATORS: " immediately after the opening delimiter, even when
-   it spans multiple lines.  We do not add an asterisk at the beginning
-   of each line, either.  E.g.
+   "TRANSLATORS: ", e.g.
 
-	/* TRANSLATORS: here is a comment that explains the string
-	   to be translated, that follows immediately after it */
+	/*
+	 * TRANSLATORS: here is a comment that explains the string to
+	 * be translated, that follows immediately after it.
+	 */
 	_("Here is a translatable string explained by the above.");
 
  - Double negation is often harder to understand than no negation
diff --git a/bisect.c b/bisect.c
index 08c9fb7266..c5d5a2b64b 100644
--- a/bisect.c
+++ b/bisect.c
@@ -995,8 +995,10 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	steps_msg = xstrfmt(Q_("(roughly %d step)", "(roughly %d steps)",
 		  steps), steps);
-	/* TRANSLATORS: the last %s will be replaced with
-	   "(roughly %d steps)" translation */
+	/*
+	 * TRANSLATORS: the last %s will be replaced with "(roughly %d
+	 * steps)" translation.
+	 */
 	printf(Q_("Bisecting: %d revision left to test after this %s\n",
 		  "Bisecting: %d revisions left to test after this %s\n",
 		  nr), nr, steps_msg);
diff --git a/builtin/blame.c b/builtin/blame.c
index 07506a3e45..ca9ebe40e7 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2688,12 +2688,15 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		blame_date_width = sizeof("2006-10-19");
 		break;
 	case DATE_RELATIVE:
-		/* TRANSLATORS: This string is used to tell us the maximum
-		   display width for a relative timestamp in "git blame"
-		   output.  For C locale, "4 years, 11 months ago", which
-		   takes 22 places, is the longest among various forms of
-		   relative timestamps, but your language may need more or
-		   fewer display columns. */
+		/*
+		 * TRANSLATORS: This string is used to tell us the
+		 * maximum display width for a relative timestamp in
+		 * "git blame" output.  For C locale, "4 years, 11
+		 * months ago", which takes 22 places, is the longest
+		 * among various forms of relative timestamps, but
+		 * your language may need more or fewer display
+		 * columns.
+		 */
 		blame_date_width = utf8_strwidth(_("4 years, 11 months ago")) + 1; /* add the null */
 		break;
 	case DATE_NORMAL:
diff --git a/builtin/notes.c b/builtin/notes.c
index 7b891471c4..fb856e53b6 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -340,8 +340,10 @@ static struct notes_tree *init_notes_check(const char *subcommand,
 
 	ref = (flags & NOTES_INIT_WRITABLE) ? t->update_ref : t->ref;
 	if (!starts_with(ref, "refs/notes/"))
-		/* TRANSLATORS: the first %s will be replaced by a
-		   git notes command: 'add', 'merge', 'remove', etc.*/
+		/*
+		 * TRANSLATORS: the first %s will be replaced by a git
+		 * notes command: 'add', 'merge', 'remove', etc.
+		 */
 		die(_("refusing to %s notes in %s (outside of refs/notes/)"),
 		    subcommand, ref);
 	return t;
diff --git a/builtin/remote.c b/builtin/remote.c
index addf97ad29..9054e2858e 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1151,8 +1151,11 @@ static int show(int argc, const char **argv)
 			url_nr = states.remote->url_nr;
 		}
 		for (i = 0; i < url_nr; i++)
-			/* TRANSLATORS: the colon ':' should align with
-			   the one in "  Fetch URL: %s" translation */
+			/*
+			 * TRANSLATORS: the colon ':' should align
+			 * with the one in " Fetch URL: %s"
+			 * translation.
+			 */
 			printf_ln(_("  Push  URL: %s"), url[i]);
 		if (!i)
 			printf_ln(_("  Push  URL: %s"), _("(no URL)"));
diff --git a/notes-utils.c b/notes-utils.c
index 24a33616a4..8f9ad7d1f8 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -132,8 +132,11 @@ struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
 		c->mode_from_env = 1;
 		c->combine = parse_combine_notes_fn(rewrite_mode_env);
 		if (!c->combine)
-			/* TRANSLATORS: The first %s is the name of the
-			   environment variable, the second %s is its value */
+			/*
+			 * TRANSLATORS: The first %s is the name of
+			 * the environment variable, the second %s is
+			 * its value.
+			 */
 			error(_("Bad %s value: '%s'"), GIT_NOTES_REWRITE_MODE_ENVIRONMENT,
 					rewrite_mode_env);
 	}
diff --git a/parse-options.c b/parse-options.c
index a23a1e67f0..e5ad34a2c3 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -589,8 +589,10 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 
 	fprintf_ln(outfile, _("usage: %s"), _(*usagestr++));
 	while (*usagestr && **usagestr)
-		/* TRANSLATORS: the colon here should align with the
-		   one in "usage: %s" translation */
+		/*
+		 * TRANSLATORS: the colon here should align with the
+		 * one in "usage: %s" translation.
+		 */
 		fprintf_ln(outfile, _("   or: %s"), _(*usagestr++));
 	while (*usagestr) {
 		if (**usagestr)
diff --git a/ref-filter.c b/ref-filter.c
index 3a640448fd..5632841753 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1251,13 +1251,17 @@ char *get_head_description(void)
 			    state.branch);
 	else if (state.detached_from) {
 		if (state.detached_at)
-			/* TRANSLATORS: make sure this matches
-			   "HEAD detached at " in wt-status.c */
+			/*
+			 * TRANSLATORS: make sure this matches "HEAD
+			 * detached at " in wt-status.c
+			 */
 			strbuf_addf(&desc, _("(HEAD detached at %s)"),
 				state.detached_from);
 		else
-			/* TRANSLATORS: make sure this matches
-			   "HEAD detached from " in wt-status.c */
+			/*
+			 * TRANSLATORS: make sure this matches "HEAD
+			 * detached from " in wt-status.c
+			 */
 			strbuf_addf(&desc, _("(HEAD detached from %s)"),
 				state.detached_from);
 	}
diff --git a/sequencer.c b/sequencer.c
index 10c3b4ff81..b77f359ca2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -464,7 +464,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
-		/* TRANSLATORS: %s will be "revert", "cherry-pick" or
+		/*
+		 * TRANSLATORS: %s will be "revert", "cherry-pick" or
 		 * "rebase -i".
 		 */
 		return error(_("%s: Unable to write new index file"),
-- 
2.11.0

