Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B497554BD2
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 22:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710541136; cv=none; b=pu9Rpuu1Ifm4C/zTMq7GMprDRiFmt76HtlDJ4xJXGwXnPLYWoHaI49uDo+fZQSUQcwHcw58t4lpU6kPO4jucbMU8l8JKd9I5/y1HT6yMUf1nx9cpuLJjFxKLMa/lh5tLboN8Vw75NHfPt5VJeQXivru4SOJlxPjGQEVvZhZEgLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710541136; c=relaxed/simple;
	bh=foR26rGhuaJpJ/6AkEur+6e35QHF8PjnGkqUU2btkPQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E9RbvSFXI1mxm54NsiOX/TloKYEZIXIAif+goqpZ8tc2ryqKUufNvpQ2tuW8vYdeewfsIumnoFL3Zb271K8i1o3YcWPdJj96+0+BewC6iIydFy65OcxGrxpNz2+do+L+THAObRna9zzjSiXv/3fu/iAK+5P1pj7ljRQ0Ay9LCeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QSCz+CL4; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QSCz+CL4"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E52E72DEF0;
	Fri, 15 Mar 2024 18:15:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=foR26rGhuaJpJ/6AkEur+6e35QHF8PjnGkqUU2
	btkPQ=; b=QSCz+CL4BuzonjSLuGbv2gD8ciJ61TtrMcgTkFKeYwGCKHDh6DbmHw
	Jfy5XuhS2EQI/1UNzbGYFuD89Bmk1aK2vSnrZD16MzHTr62tyATT5NV5l2l3d80k
	k1BGDMa7lJEm0aztKJFKUtKHt/qk9BseXsk5umz4mcpxHQCAMdyO0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DCD032DEEF;
	Fri, 15 Mar 2024 18:15:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6F3562DEEE;
	Fri, 15 Mar 2024 18:15:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Ralph Seichter via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  rsbecker@nexbridge.com,  Dragan Simic
 <dsimic@manjaro.org>,  Chris Torek <chris.torek@gmail.com>,  Ralph
 Seichter <github@seichter.de>
Subject: Re: [PATCH v3] config: add --comment option to add a comment
In-Reply-To: <pull.1681.v3.git.1710280020508.gitgitgadget@gmail.com> (Ralph
	Seichter via GitGitGadget's message of "Tue, 12 Mar 2024 21:47:00
	+0000")
References: <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
	<pull.1681.v3.git.1710280020508.gitgitgadget@gmail.com>
Date: Fri, 15 Mar 2024 15:15:41 -0700
Message-ID: <xmqq8r2jp2eq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 90997D20-E319-11EE-9502-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Ralph Seichter via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ralph Seichter <github@seichter.de>

Thanks for updating.  The proposed commit log message reads much
smoother.

> Users need to be able to distinguish between config entries made
> using automation and entries made by a human. Automation can add
> comments containing a URL pointing to explanations for the change
> made, avoiding questions from users as to why their config file
> was changed by a third party.

While I can understand what you want to say, primarily because we
were both on this topic for some time by now, a casual reader of the
above would say:

    Sure, but a human also would add comment to clarify what
    motivated the setting to be added. The fact that one entry has
    comment does not help distinguishing between automation and
    human input all that much.

More importantly, the reason why users would want to mark entries is
not limited to telling automation vs human.  So, it seems to me that
the paragraph needs a bit more work.  Here is my attempt.

    While the subcommands (including "git config") of "git" all can
    skip comment strings in the configuration files, and users do
    write comments in the configuration files with editors, there is
    no easy way that can be used by scripts and automation to leave
    comments when they add/modify configuration entries.

    Introduce a "--comment" option that can be used with the "git
    config" command when it is used for writing, so that each
    affected entry can be annotated with a comment that comes after
    the "variable = value" on the same line.  The option argument is
    deliberately limited to a single-line comment to match the line
    oriented nature of the configuration file, and "git config" will
    error out early when fed a multi-line string.  This way, removal
    of the variable will also remove the comment given to it by this
    mechanism.

> The implementation ensures that a # character is unconditionally
> prepended to the provided comment string, and that

I thought we already discussed this and unconditional "#comment" has
already been declared a non starter.  I'll follow this review
response with a few patches that are designed to apply on top to
show a more ergonomic way to do this.

> the comment
> text is appended as a suffix to the changed key-value-pair in the
> same line of text. Multi-line comments (i.e. comments containing
> linefeed) are rejected as errors, causing Git to exit without
> making changes.

These will become redundant if we rewrite the earlier paragraph like
illustrated above.

> Comments are aimed at humans who inspect or change their Git
> config using a pager or editor. Comments are not meant to be
> read or displayed by git-config at a later time.

As we sold why comments are useful and lack of mechanical way to add
one hurts earlier in the proposed log message, if we rewrite the
earlier paragraph like illustrated above, this would become
redundant.  I also do not think we need to limit future direction
with the last sentence.  I do not foresee a reason to forbid other
developers from adding an option to the "get" subcommand, e.g.

	$ git config --get --with-comments vari.able
	vari.able = value # added on Fri Mar 15 15:02:37 2024

> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index dff39093b5e..e608d5ffef2 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -9,9 +9,9 @@ git-config - Get and set repository or global options
>  SYNOPSIS
>  --------
>  [verse]
> -'git config' [<file-option>] [--type=<type>] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] <name> [<value> [<value-pattern>]]
> -'git config' [<file-option>] [--type=<type>] --add <name> <value>
> -'git config' [<file-option>] [--type=<type>] [--fixed-value] --replace-all <name> <value> [<value-pattern>]
> +'git config' [<file-option>] [--type=<type>] [--comment=<value>] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] <name> [<value> [<value-pattern>]]
> +'git config' [<file-option>] [--type=<type>] [--comment=<value>] --add <name> <value>
> +'git config' [<file-option>] [--type=<type>] [--comment=<value>] [--fixed-value] --replace-all <name> <value> [<value-pattern>]
>  'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get <name> [<value-pattern>]
>  'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get-all <name> [<value-pattern>]
>  'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] [--name-only] --get-regexp <name-regex> [<value-pattern>]

"--comment=<value>" will become awkward when we write about how the
comment message is placed after the value in the description.
You'll see, in the patch I promised to follow this review with,
I've used --comment=<message> instead to avoid that issue.

> @@ -87,6 +87,11 @@ OPTIONS
>  	values.  This is the same as providing '^$' as the `value-pattern`
>  	in `--replace-all`.
>  
> +--comment <value>::
> +	Append a comment to new or modified lines. A '#' character will be
> +	unconditionally prepended to the value. The value must not contain
> +	linefeed characters (no multi-line comments are permitted).

About the "unconditional" part I won't repeat.  As to the formatting
style, the recent trend is to write placeholder emphasized and
inside angle bracket, e.g.

	--comment <message>::
		Append a comment _<message>_ after the value on the
		same line. ...

This illustration is only to show the formatting, and not what the
description says.

>  [section]
> -	penguin = very blue
>  	Movie = BadPhysics
>  	UPPERCASE = true
> -	penguin = kingpin
> +	penguin = gentoo #Pygoscelis papua
> +	disposition = peckish #find fish
> +	foo = bar ## abc

The first one, "very blue", will be gone, which I found a bit
surprising, but it is OK.  This is because "--replace-all" used
first will eat all the "penguin" and leaves only a single one.

>  [Sections]
>  	WhatEver = Second
>  EOF
> +test_expect_success 'append comments' '
> +	git config --replace-all --comment="Pygoscelis papua" section.penguin gentoo &&
> +	git config --comment="find fish" section.disposition peckish &&
> +	git config --comment="# abc" section.foo bar &&
> +	test_cmp expect .git/config
> +'

Notice that none of these would produce the most natural (at least
in the context of Git command set)

	variable = value # comment

You would have to say --comment=" comment" which is rather
unfortunate.

-------- >8 --------------- >8 --------------- >8 --------------- >8 --------
From: Junio C Hamano <gitster@pobox.com>
Date: Fri, 15 Mar 2024 12:43:58 -0700
Subject: [PATCH] config: fix --comment formatting

When git adds comments itself (like "rebase -i" todo list and
"commit -e" log message editor), it always gives a comment
introducer "#" followed by a Space before the message, except for
the recently introduced "git config --comment", where the users are
forced to say " this is my comment" if they want to add their
comment in this usual format; otherwise their comment string will
end up without a space after the "#".

Make it more ergonomic, while keeping it possible to also use this
unusual style, by massaging the comment string at the UI layer with
a set of simple rules:

 * If the given comment string begins with '#', it is passed intact.
 * Otherwise, "# " is prefixed.
 * A string with LF in it cannot be used as a comment string.

Right now there is only one "front-end" that accepts end-user
comment string and calls the underlying machinery to add or modify
configuration file with comments, but to make sure that the future
callers perform similar massaging as they see fit, add a sanity
check logic in git_config_set_multivar_in_file_gently(), which is
the single choke point in the codepaths that consumes the comment
string.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Even with this fix, the code unconditionally places a single Space
character after the value before the '#' comment introducer.  If we
wanted to allow it to be replaced with other kind of whitespaces,
we could tweak the massaging logic further.

The updated tweaking rule may become

 * If the given comment string begins with one or more whitespace
   characters followed by '#', it is passed intact.
 * If the given comment string begins with '#', then a SP is
   prefixed.
 * Otherwise, " # " (Space, '#', Space) is prefixed.
 * A string with LF in it cannot be used as a comment string.

And the sanity checking rule may become

 * comment string after the above massaging that comes into
   git_config_set_multivar_in_file_gently() must

   - begin with one or more whitespace characters followed by '#'.
   - not have a LF in it.

Finally the code to add the massaged comment will simply become:

	strbuf_addf(&sb, "%s%s\n", quote, comment);

I personally think that is over-engineered, so this commit stops
short of doing any of that.  If we were to do so, the tweaking logic
must be encapsulated into a helper function, so that the second and
subsequent "front-end" can reuse it.

 Documentation/git-config.txt | 15 ++++++++-------
 builtin/config.c             | 15 +++++++++++----
 config.c                     | 20 ++++++++++++++------
 t/t1300-config.sh            |  9 +++++----
 4 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index e608d5ffef..af374ee2e0 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,9 +9,9 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git config' [<file-option>] [--type=<type>] [--comment=<value>] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] <name> [<value> [<value-pattern>]]
-'git config' [<file-option>] [--type=<type>] [--comment=<value>] --add <name> <value>
-'git config' [<file-option>] [--type=<type>] [--comment=<value>] [--fixed-value] --replace-all <name> <value> [<value-pattern>]
+'git config' [<file-option>] [--type=<type>] [--comment=<message>] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] <name> [<value> [<value-pattern>]]
+'git config' [<file-option>] [--type=<type>] [--comment=<message>] --add <name> <value>
+'git config' [<file-option>] [--type=<type>] [--comment=<message>] [--fixed-value] --replace-all <name> <value> [<value-pattern>]
 'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get <name> [<value-pattern>]
 'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get-all <name> [<value-pattern>]
 'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] [--name-only] --get-regexp <name-regex> [<value-pattern>]
@@ -87,10 +87,11 @@ OPTIONS
 	values.  This is the same as providing '^$' as the `value-pattern`
 	in `--replace-all`.
 
---comment <value>::
-	Append a comment to new or modified lines. A '#' character will be
-	unconditionally prepended to the value. The value must not contain
-	linefeed characters (no multi-line comments are permitted).
+--comment <message>::
+	Append a comment at the end of new or modified lines.
+	Unless _<message>_ begins with "#", a string "# " (hash
+	followed by a space) is prepended to it. The _<message>_ must not
+	contain linefeed characters (no multi-line comments are permitted).
 
 --get::
 	Get the value for a given key (optionally filtered by a regex
diff --git a/builtin/config.c b/builtin/config.c
index c54e9941a5..e859a659f4 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -174,7 +174,7 @@ static struct option builtin_config_options[] = {
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
 	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree, local, global, system, command)")),
 	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use default value when missing entry")),
-	OPT_STRING(0, "comment", &comment, N_("value"), N_("human-readable comment string (# will be prepended automatically)")),
+	OPT_STRING(0, "comment", &comment, N_("value"), N_("human-readable comment string (# will be prepended as needed)")),
 	OPT_END(),
 };
 
@@ -800,9 +800,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 
 	if (comment &&
-		!(actions & (ACTION_ADD|ACTION_SET|ACTION_SET_ALL|ACTION_REPLACE_ALL))) {
-			error(_("--comment is only applicable to add/set/replace operations"));
-			usage_builtin_config();
+	    !(actions & (ACTION_ADD|ACTION_SET|ACTION_SET_ALL|ACTION_REPLACE_ALL))) {
+		error(_("--comment is only applicable to add/set/replace operations"));
+		usage_builtin_config();
 	}
 
 	/* check usage of --fixed-value */
@@ -841,6 +841,13 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		flags |= CONFIG_FLAGS_FIXED_VALUE;
 	}
 
+	if (comment) {
+		if (strchr(comment, '\n'))
+			die(_("no multi-line comment allowed: '%s'"), comment);
+		if (comment[0] != '#')
+			comment = xstrfmt("# %s", comment);
+	}
+
 	if (actions & PAGING_ACTIONS)
 		setup_auto_pager("config", 1);
 
diff --git a/config.c b/config.c
index 2f3f6d123c..15019cb9a5 100644
--- a/config.c
+++ b/config.c
@@ -3043,12 +3043,9 @@ static ssize_t write_pair(int fd, const char *key, const char *value,
 			break;
 		}
 
-	if (comment) {
-		if (strchr(comment, '\n'))
-			die(_("multi-line comments are not permitted: '%s'"), comment);
-		else
-			strbuf_addf(&sb, "%s #%s\n", quote, comment);
-	} else
+	if (comment)
+		strbuf_addf(&sb, "%s %s\n", quote, comment);
+	else
 		strbuf_addf(&sb, "%s\n", quote);
 
 	ret = write_in_full(fd, sb.buf, sb.len);
@@ -3214,6 +3211,17 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	size_t contents_sz;
 	struct config_store_data store = CONFIG_STORE_INIT;
 
+	if (comment) {
+		/*
+		 * The front-end must have massaged the comment string
+		 * properly before calling us.
+		 */
+		if (strchr(comment, '\n'))
+			BUG("multi-line comments are not permitted: '%s'", comment);
+		if (comment[0] != '#')
+			BUG("comment should begin with '#': '%s'", comment);
+	}
+
 	/* parse-key returns negative; flip the sign to feed exit(3) */
 	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
 	if (ret)
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index ac7b02e6b0..d5dfb45877 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -71,16 +71,17 @@ cat > expect << EOF
 [section]
 	Movie = BadPhysics
 	UPPERCASE = true
-	penguin = gentoo #Pygoscelis papua
-	disposition = peckish #find fish
-	foo = bar ## abc
+	penguin = gentoo # Pygoscelis papua
+	disposition = peckish # find fish
+	foo = bar #abc
 [Sections]
 	WhatEver = Second
 EOF
+
 test_expect_success 'append comments' '
 	git config --replace-all --comment="Pygoscelis papua" section.penguin gentoo &&
 	git config --comment="find fish" section.disposition peckish &&
-	git config --comment="# abc" section.foo bar &&
+	git config --comment="#abc" section.foo bar &&
 	test_cmp expect .git/config
 '
 
-- 
2.44.0-248-g4f9b731bde

