From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 01/10] Add support for -i/--interactive to git-clean
Date: Wed, 08 May 2013 09:57:53 -0700
Message-ID: <7vr4hhflym.fsf@alter.siamese.dyndns.org>
References: <cover.1368011946.git.worldhello.net@gmail.com>
	<ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 08 18:58:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua7go-0000km-NX
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 18:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756575Ab3EHQ56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 12:57:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62482 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846Ab3EHQ55 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 12:57:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 769E31A84E;
	Wed,  8 May 2013 16:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MlgESpktibV3P4RrzVDkYBoznZw=; b=fwb6uv
	RIMxWofqusqrxtsVBUGXjYTvzVAMwG48H6ByAsoA9OyoGCswSUPqr1mqqs4vj8Wy
	FNlsBiK8MPzfMbzML5pptsG1aPpuFt9Zom9sf29KIBi3r7QxO0TtLXp4VvtLpqsG
	5mbJZNN75W4HE2NeiMLe1HZXx137l8ukeoZTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q0uaHHsozO6i7F3rzGStfVFFmflxLvoP
	V/JVHCOpQnX8GqP2tgClZfio63XDPFPVe8SmgIz6cDCJTn7PYVCdYkX0tkjgiEYB
	WEM7DQkTh9kKvUTDKRclqJurz7sFxmANttnVTJqelWYA/dc3A7m/HxLiPymNjpaQ
	i+cJARdfzTQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DFE41A84D;
	Wed,  8 May 2013 16:57:56 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 583AC1A845;
	Wed,  8 May 2013 16:57:55 +0000 (UTC)
In-Reply-To: <ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Wed, 8 May 2013 19:38:46 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6DA79018-B800-11E2-B407-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223677>

Jiang Xin <worldhello.net@gmail.com> writes:

> Show what would be done and the user must confirm before actually
> cleaning. In the confirmation dialog, the user has three choices:
>
>  * y/yes:  Start to do cleaning.
>  * n/no:   Nothing will be deleted.
>  * e/edit: Exclude items from deletion using ignore patterns.
>
> When the user chooses the edit mode, the user can input space-
> separated patterns (the same syntax as gitignore), and each clean
> candidate that matches with one of the patterns will be excluded
> from cleaning. When the user feels it's OK, presses ENTER and back
> to the confirmation dialog.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Spelling-checked-by: Eric Sunshine <sunshine@sunshineco.com>
> Comments-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> Suggested-by: Eric Sunshine <sunshine@sunshineco.com>

Listing everybody who has ever said anything in the review thread?
I can understand that you may want to give credit to those who
significantly helped, but please do not overdo it.

In any case, with the help of their inputs, you brought the patch
into its final shape.  Please sign-off at the _end_.

> ---
>  Documentation/git-clean.txt |  15 +++-
>  builtin/clean.c             | 198 +++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 192 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
> index bdc3a..f5572 100644
> --- a/Documentation/git-clean.txt
> +++ b/Documentation/git-clean.txt
> @@ -8,7 +8,7 @@ git-clean - Remove untracked files from the working tree
>  SYNOPSIS
>  --------
>  [verse]
> -'git clean' [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...
> +'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...
>  
>  DESCRIPTION
>  -----------
> @@ -34,7 +34,18 @@ OPTIONS
>  -f::
>  --force::
>  	If the Git configuration variable clean.requireForce is not set
> -	to false, 'git clean' will refuse to run unless given -f or -n.
> +	to false, 'git clean' will refuse to run unless given -f, -n or
> +	-i.
> +
> +-i::
> +--interactive::
> +	Show what would be done and the user must confirm before actually
> +	cleaning. In the confirmation dialog, the user can choose to abort
> +	the cleaning, or enter into an edit mode. In the edit mode, the
> +	user can input space-separated patterns (the same syntax as
> +	gitignore), and each clean candidate that matches with one of the
> +	patterns will be excluded from cleaning. When the user feels it's
> +	OK, presses ENTER and back to the confirmation dialog.
>  
>  -n::
>  --dry-run::
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 04e39..49aab 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -15,9 +15,12 @@
>  #include "quote.h"
>  
>  static int force = -1; /* unset */
> +static int interactive;
> +static struct string_list del_list = STRING_LIST_INIT_DUP;
> +static const char **the_prefix;

Ehh, why?

>  static const char *const builtin_clean_usage[] = {
> -	N_("git clean [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>..."),
> +	N_("git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>..."),
>  	NULL
>  };
>  
> @@ -142,6 +145,139 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
>  	return ret;
>  }
>  
> +static void edit_by_patterns_cmd()

static void edit_by_patterns_cmd(void)

> +{
> +	struct dir_struct dir;
> +	struct strbuf confirm = STRBUF_INIT;
> +	struct strbuf buf = STRBUF_INIT;
> +	struct strbuf **ignore_list;
> +	struct string_list_item *item;
> +	struct exclude_list *el;
> +	const char *qname;
> +	int changed = -1, i;
> +
> +	while (1) {
> +		/* dels list may become empty when we run string_list_remove_empty_items later */

An unnecessary and overlong comment.  The message shown already
tells the reader what is going on anyway, no?

> +		if (!del_list.nr) {
> +			printf_ln(_("No more files to clean, exiting."));
> +			break;
> +		}
> +
> +		if (changed) {
> +			putchar('\n');
> +
> +			/* Display dels in "Would remove ..." format */
> +			for_each_string_list_item(item, &del_list) {
> +				qname = quote_path_relative(item->string, -1, &buf, *the_prefix);
> +				printf(_(msg_would_remove), qname);
> +			}
> +			putchar('\n');
> +		}
> +
> +		printf(_("Input ignore patterns>> "));
> +		if (strbuf_getline(&confirm, stdin, '\n') != EOF) {
> +			strbuf_trim(&confirm);
> +		} else {
> +			putchar('\n');
> +			break;

Why break here?  If we got nothing, wouldn't confirm.len be zero?
If we did get something but the input got flushed without line-end,
sending '\n' to the terminal may be justified, but in that case you
would may have something useful, and asking confirm.len if it is
empty would be the consistent way to check between two cases, no?

> +		}
> +
> +		/* Quit edit mode */
> +		if (!confirm.len)
> +			break;
> +
> +		memset(&dir, 0, sizeof(dir));
> +		el = add_exclude_list(&dir, EXC_CMDL, "manual exclude");
> +		ignore_list = strbuf_split_max(&confirm, ' ', 0);
> +
> +		for (i = 0; ignore_list[i]; i++) {
> +			strbuf_trim(ignore_list[i]);
> +			if (!ignore_list[i]->len)
> +				continue;
> +
> +			add_exclude(ignore_list[i]->buf, "", 0, el, -(i+1));
> +		}
> +
> +		changed = 0;
> +		for_each_string_list_item(item, &del_list) {
> +			int dtype = DT_UNKNOWN;
> +			const char *qname;
> +
> +			qname = quote_path_relative(item->string, -1, &buf, *the_prefix);
> +
> +			if (is_excluded(&dir, qname, &dtype)) {
> +				*item->string = '\0';
> +				changed++;
> +			}

A few points:

 * Pass prefix as a parameter to this function, just like how
   remove_dirs() gets called, and get rid of the_prefix.

 * The result of quote_* is designed to avoid ambiguities, by
   applying C-style quotes like HT => \t and adding "" pair around
   it as necessary.  I doubt feeding it to is_excluded() makes any
   sense.  You probably meant path_relative(), but I am not sure.

> +		}
> +
> +		if (changed) {
> +			string_list_remove_empty_items(&del_list, 0);
> +		} else {
> +			printf_ln(_("WARNING: Cannot find items matched by: %s"), confirm.buf);
> +		}
> +
> +		strbuf_list_free(ignore_list);
> +		clear_directory(&dir);
> +	}
> +
> +	strbuf_release(&buf);
> +	strbuf_release(&confirm);
> +}
> +
> +static void interactive_main_loop()
> +{
> +	struct strbuf confirm = STRBUF_INIT;
> +	struct strbuf buf = STRBUF_INIT;
> +	struct string_list_item *item;
> +	const char *qname;
> +
> +	/* dels list may become empty after return back from edit mode */
> +	while (del_list.nr) {
> +		printf_ln(Q_("Would remove the following item:",
> +			     "Would remove the following items:",
> +			     del_list.nr));
> +		putchar('\n');
> +
> +		/* Display dels in "Would remove ..." format */
> +		for_each_string_list_item(item, &del_list) {
> +			qname = quote_path_relative(item->string, -1, &buf, *the_prefix);
> +			printf(_(msg_would_remove), qname);
> +		}
> +		putchar('\n');
> +
> +		/* Confirmation dialog */
> +		printf(_("Remove ([y]es/[n]o/[e]dit) ? "));
> +		if (strbuf_getline(&confirm, stdin, '\n') != EOF) {
> +			strbuf_trim(&confirm);
> +		} else {
> +			/* Ctrl-D is the same as "quit" */
> +			string_list_clear(&del_list, 0);
> +			putchar('\n');
> +			printf_ln("Bye.");
> +			break;
> +		}
> +
> +		if (confirm.len) {
> +			if (!strncasecmp(confirm.buf, "yes", confirm.len)) {
> +				break;
> +			} else if (!strncasecmp(confirm.buf, "no", confirm.len) ||
> +				   !strncasecmp(confirm.buf, "quit", confirm.len)) {
> +				string_list_clear(&del_list, 0);
> +				printf_ln("Bye.");
> +				break;
> +			} else if (!strncasecmp(confirm.buf, "edit", confirm.len)) {
> +				edit_by_patterns_cmd();
> +			} else {
> +				continue;
> +			}
> +		}
> +	}
> +
> +	strbuf_release(&buf);
> +	strbuf_release(&confirm);
> +}
> +
>  int cmd_clean(int argc, const char **argv, const char *prefix)
>  {
>  	int i, res;
> @@ -154,12 +290,14 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  	struct strbuf buf = STRBUF_INIT;
>  	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
>  	struct exclude_list *el;
> +	struct string_list_item *item;
>  	const char *qname;
>  	char *seen = NULL;
>  	struct option options[] = {
>  		OPT__QUIET(&quiet, N_("do not print names of files removed")),
>  		OPT__DRY_RUN(&dry_run, N_("dry run")),
>  		OPT__FORCE(&force, N_("force")),
> +		OPT_BOOL('i', "interactive", &interactive, N_("interactive cleaning")),
>  		OPT_BOOLEAN('d', NULL, &remove_directories,
>  				N_("remove whole directories")),
>  		{ OPTION_CALLBACK, 'e', "exclude", &exclude_list, N_("pattern"),
> @@ -176,7 +314,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  	else
>  		config_set = 1;
>  
> -	argc = parse_options(argc, argv, prefix, options, builtin_clean_usage,
> +	the_prefix = &prefix;
> +	argc = parse_options(argc, argv, *the_prefix, options, builtin_clean_usage,
>  			     0);

None of these changes s/prefix/*the_prefix/ looks remotely
justifiable.  Does anybody change *the_prefix after it is set and if
so how?

>  	memset(&dir, 0, sizeof(dir));
> @@ -186,12 +326,16 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  	if (ignored && ignored_only)
>  		die(_("-x and -X cannot be used together"));
>  
> -	if (!dry_run && !force) {
> +	if (interactive) {
> +		if (!isatty(0) || !isatty(1))
> +			die(_("interactive clean can not run without a valid tty; "
> +				  "refusing to clean"));
> +	} else if (!dry_run && !force) {
>  		if (config_set)
> -			die(_("clean.requireForce set to true and neither -n nor -f given; "
> +			die(_("clean.requireForce set to true and neither -i, -n nor -f given; "
>  				  "refusing to clean"));
>  		else
> -			die(_("clean.requireForce defaults to true and neither -n nor -f given; "
> +			die(_("clean.requireForce defaults to true and neither -i, -n nor -f given; "
>  				  "refusing to clean"));
>  	}
>  
> @@ -210,7 +354,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  	for (i = 0; i < exclude_list.nr; i++)
>  		add_exclude(exclude_list.items[i].string, "", 0, el, -(i+1));
>  
> -	pathspec = get_pathspec(prefix, argv);
> +	pathspec = get_pathspec(*the_prefix, argv);
>  
>  	fill_directory(&dir, pathspec);
>  
> @@ -257,26 +401,41 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  		}
>  
>  		if (S_ISDIR(st.st_mode)) {
> -			strbuf_addstr(&directory, ent->name);
> -			if (remove_directories || (matches == MATCHED_EXACTLY)) {
> -				if (remove_dirs(&directory, prefix, rm_flags, dry_run, quiet, &gone))
> -					errors++;
> -				if (gone && !quiet) {
> -					qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
> -					printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
> -				}
> -			}
> -			strbuf_reset(&directory);
> +			if (remove_directories || (matches == MATCHED_EXACTLY))
> +				string_list_append(&del_list, ent->name);
>  		} else {
>  			if (pathspec && !matches)
>  				continue;
> -			res = dry_run ? 0 : unlink(ent->name);
> +			string_list_append(&del_list, ent->name);
> +		}
> +	}
> +
> +	if (interactive && !dry_run && del_list.nr > 0)
> +		interactive_main_loop();
> +
> +	for_each_string_list_item(item, &del_list) {
> +		struct stat st;
> +
> +		if (lstat(item->string, &st))
> +			continue;

Ignoring errors silently?

With the "interactive" stuff, can you get into a situation where you
originally propose to remove D and D/F but the user tells you to
remove D (editing D/F away), or vice versa?

I think this patch should be in at least two parts:

 - Introduce the two-phase "collect in del_list, remove in a
   separate loop at the end" restructuring.

 - (optional, if you are feeling ambitious) Change the path that is
   stored in del_list relative to the prefix, so that all functions
   that operate on the string in the del_list do not have to do
   *_relative() thing.  Some functions may instead have to prepend
   prefix but if they are minority compared to the users of
   *_relative(), it may be an overall win from the readability's
   point of view.

 - Add the "interactively allow you to reduce the del_list" bit
   between the two phases.

> +		if (S_ISDIR(st.st_mode)) {
> +			strbuf_addstr(&directory, item->string);
> +			if (remove_dirs(&directory, *the_prefix, rm_flags, dry_run, quiet, &gone))
> +				errors++;
> +			if (gone && !quiet) {
> +				qname = quote_path_relative(directory.buf, directory.len, &buf, *the_prefix);
> +				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
> +			}
> +			strbuf_reset(&directory);
> +		} else {
> +			res = dry_run ? 0 : unlink(item->string);
>  			if (res) {
> -				qname = quote_path_relative(ent->name, -1, &buf, prefix);
> +				qname = quote_path_relative(item->string, -1, &buf, *the_prefix);
>  				warning(_(msg_warn_remove_failed), qname);
>  				errors++;
>  			} else if (!quiet) {
> -				qname = quote_path_relative(ent->name, -1, &buf, prefix);
> +				qname = quote_path_relative(item->string, -1, &buf, *the_prefix);
>  				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
>  			}
>  		}
> @@ -285,5 +444,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  
>  	strbuf_release(&directory);
>  	string_list_clear(&exclude_list, 0);
> +	string_list_clear(&del_list, 0);
>  	return (errors != 0);
>  }
