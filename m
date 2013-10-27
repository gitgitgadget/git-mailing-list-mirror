From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes:
 line
Date: Sun, 27 Oct 2013 06:42:44 +0100
Message-ID: <526CA7D4.1070904@alum.mit.edu>
References: <20131024122255.GI9378@mwanda> <20131024122512.GB9534@mwanda> <20131026181709.GB10488@kroah.com> <20131027013402.GA7146@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Greg KH <greg@kroah.com>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	ksummit-attendees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 27 06:50:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaJFG-000656-MT
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 06:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104Ab3J0Ftv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 01:49:51 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:49408 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750993Ab3J0Ftu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Oct 2013 01:49:50 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Oct 2013 01:49:50 EDT
X-AuditID: 1207440c-b7f566d000004272-48-526ca7d8aebe
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id DD.22.17010.8D7AC625; Sun, 27 Oct 2013 01:42:48 -0400 (EDT)
Received: from [192.168.69.9] (p57A242CF.dip0.t-ipconnect.de [87.162.66.207])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9R5giJ0027726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 27 Oct 2013 01:42:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <20131027013402.GA7146@leaf>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsUixO6iqHtjeU6QweGPYhav/01nsei60s1k
	cW7BDEaL/wvyLW79mMtk8erRJSaLy7vmsDmwe9x6bevx9mGAx+8fkxk9Pj69xeLxeZNcAGsU
	t01SYklZcGZ6nr5dAnfG4tVfmQoe51bsuyjZwLg/vIuRk0NCwETi1p5b7BC2mMSFe+vZuhi5
	OIQELjNK/HkE4nACOWeZJGY1hYHYvALaElsXnQCLswioSkw918QEYrMJ6Eos6mkGs0UFQiQW
	rjrODlEvKHFy5hMWEFtEwE7i+qsdzCA2s8AdRolti81BbGGBQIneK/NYIBZ3Mkqc274LbBCn
	gKbE8d6nbBANOhLv+h5ANctLbH87h3kCo8AsJDtmISmbhaRsASPzKka5xJzSXN3cxMyc4tRk
	3eLkxLy81CJdQ73czBK91JTSTYyQkOfZwfhtncwhRgEORiUe3gtBOUFCrIllxZW5hxglOZiU
	RHl95wCF+JLyUyozEosz4otKc1KLDzFKcDArifDu6gDK8aYkVlalFuXDpKQ5WJTEeVWXqPsJ
	CaQnlqRmp6YWpBbBZGU4OJQkeN8uA2oULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmI
	B0VqfDEwVkFSPEB7T4C08xYXJOYCRSFaTzHqcsz78uEboxBLXn5eqpQ4726QIgGQoozSPLgV
	sAT3ilEc6GNh3isgVTzA5Ag36RXQEiagJX+vZIEsKUlESEk1MBZ9u2fxNufnyR72A09Nt6vv
	52S9rVy38PWs3/+DDywWcFh42a+kX7bQsCo29na/XMwjxg8irhdP3H1x6vmMTY7a 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236775>

On 10/27/2013 02:34 AM, Josh Triplett wrote:
> Linux Kernel Summit 2013 decided on a commit message convention to
> identify commits containing bugs fixed by a commit: a "Fixes:" line,
> included in the standard commit footer (along with "Signed-off-by:" if
> present), containing an abbreviated commit hash (at least 12 characters
> to keep it valid for a long time) and the subject of the commit (for
> human readers).  This helps people (or automated tools) determine how
> far to backport a commit.
> 
> Add a command line option for git commit to automatically construct the
> "Fixes:" line for a commit.  This avoids the need to manually construct
> that line by copy-pasting the commit hash and subject.
> 
> Also works with --amend to modify an existing commit's message.  To add
> a Fixes line to an earlier commit in a series, use rebase -i and add the
> following line after the existing commit:
> x git commit --amend --no-edit -f $commit_containing_bug
> 
> Generalize append_signoff to support appending arbitrary extra lines to
> a commit in the signoff block; this avoids duplicating the logic to find
> or construct that block.

I have a few comments and questions about the design of this feature:

First of all, let me show my ignorance.  How formalized is the use of
metadata lines at the end of a commit message?  I don't remember seeing
documentation about such lines in general (as opposed to documentation
about particular types of lines).  Is the format defined well enough
that tools that don't know about a particular line could nonetheless
preserve it correctly?  Is there/should there be a standard recommended
order of metadata lines?  (For example, should "Fixes:" lines always
appear before "Signed-off-by" lines, or vice versa?)  If so, is it
documented somewhere and preserved by tools when such lines are
added/modified?  Should there be support for querying such lines?

There is another thread [1] proposing the addition of a "Change-Id:"
metadata line, so maybe now would be a good time to discuss such lines
in general.


Too bad your proposed new option sounds so similar to --fixup, which
does something conceptually similar albeit very different in effect.
This will likely lead to confusion.  I wonder if the two features could
be combined in some way?

The main difference between the two features is how they are intended to
be used: --fixup is to fix a commit that hasn't been pushed yet (where
the user intends to squash the commits together), whereas --fixes is to
mark a commit as a fix to a commit that has already been pushed (where
the commits will remain separate).  But there seems to be a common
concept here.

For example, what happens if a --fixes commit is "rebase -i"ed at the
same time as the commit that it fixes?  It might make sense to do the
autosquash thing just like with a --fixup/--squash commit.  (Otherwise
the SHA-1 in the "Fixes:" line will become invalid anyway.)

Conversely, I suppose one could ask whether there should be some way to
prevent "fixup!" or "squash!" commits from being pushed, at least
without some kind of --force option.  This could of course be enforced
by a hook but it might be nice to have some protection by default.


I see that there a consistency check that the --fixes argument is a
valid commit.  But is there/should there be a check that it is an
ancestor of the commit being created?  Is there/should there be a check
that both of these facts remain true if the the commit containing it is
rebased, cherry-picked, etc?

In workflows that make more use of cherry-picking, it could be that the
original buggy commit was cherry-picked to a different branch.  In this
case the user would probably want to cherry-pick the fixing commit to
the other branch, too.  But then the commit that it would be fixing
would have a different SHA-1 than it did on the original branch.  A
check that the "Fixes:" line refers to an ancestor of the current commit
could warn against such errors.  (In some cases it might be possible to
use cherry-pick's "-x" lines to figure out how to rewrite the "Fixes:"
line, but I doubt that would work often enough to be worthwhile.)


> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> ---
>  Documentation/git-commit.txt | 12 ++++++++++--
>  builtin/commit.c             | 29 +++++++++++++++++++++++++++--
>  sequencer.c                  | 31 +++++++++++++++++++++++--------
>  sequencer.h                  |  3 +++
>  t/t7502-commit.sh            | 39 ++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 101 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 1a7616c..fcc6ed2 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -8,8 +8,8 @@ git-commit - Record changes to the repository
>  SYNOPSIS
>  --------
>  [verse]
> -'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
> -	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
> +'git commit' [-a | --interactive | --patch] [-s] [-f <commit>] [-v] [-u<mode>]
> +	   [--amend] [--dry-run] [(-c | -C | --fixup | --squash) <commit>]

You mention only "-f", not "--fixes" here.

But I don't think that this feature should be given the "-f" short
option, as (a) -f often means "force"; (b) it will increase the
confusion with --fixup; (c) it just doesn't strike me as being likely to
be such a frequently-used option (though if this changes over time the
"-f" option could always be granted to it later).

>  	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
>  	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
>  	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
> @@ -156,6 +156,14 @@ OPTIONS
>  	Add Signed-off-by line by the committer at the end of the commit
>  	log message.
>  
> +-f <commit>::
> +--fixes=<commit>::
> +	Add Fixes line for the specified commit at the end of the commit
> +	log message.  This line includes an abbreviated commit hash for
> +	the specified commit; the `core.abbrev` option determines the
> +	length of the abbreviated commit hash used, with a minimum length
> +	of 12 hex digits.
> +

You might also mention that the "Fixes:" line includes the old commit's
subject line.

>  -n::
>  --no-verify::
>  	This option bypasses the pre-commit and commit-msg hooks.
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 6ab4605..9bbcd8a 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -123,6 +123,7 @@ static int use_editor = 1, include_status = 1;
>  static int show_ignored_in_status, have_option_m;
>  static const char *only_include_assumed;
>  static struct strbuf message = STRBUF_INIT;
> +static struct strbuf fixes = STRBUF_INIT;
>  
>  static enum status_format {
>  	STATUS_FORMAT_NONE = 0,
> @@ -133,6 +134,28 @@ static enum status_format {
>  	STATUS_FORMAT_UNSPECIFIED
>  } status_format = STATUS_FORMAT_UNSPECIFIED;
>  
> +static int opt_parse_f(const struct option *opt, const char *arg, int unset)
> +{
> +	struct strbuf *sb = opt->value;
> +	if (unset) {
> +		strbuf_setlen(sb, 0);
> +	} else {
> +		struct pretty_print_context ctx = {0};
> +		struct commit *commit;
> +
> +		commit = lookup_commit_reference_by_name(arg);
> +		if (!commit)
> +			die(_("could not lookup commit %s"), arg);
> +		ctx.output_encoding = get_commit_output_encoding();
> +		ctx.abbrev = DEFAULT_ABBREV;
> +		if (ctx.abbrev < 12)
> +			ctx.abbrev = 12;
> +		format_commit_message(commit, "Fixes: %h ('%s')\n", sb, &ctx);
> +	}
> +
> +	return 0;
> +}
> +
>  static int opt_parse_m(const struct option *opt, const char *arg, int unset)
>  {
>  	struct strbuf *buf = opt->value;
> @@ -718,7 +741,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	if (clean_message_contents)
>  		stripspace(&sb, 0);
>  
> -	if (signoff) {
> +	if (signoff || fixes.len) {
>  		/*
>  		 * See if we have a Conflicts: block at the end. If yes, count
>  		 * its size, so we can ignore it.
> @@ -742,7 +765,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  			previous = eol;
>  		}
>  
> -		append_signoff(&sb, ignore_footer, 0);
> +		append_signoff_extra(&sb, ignore_footer,
> +				     signoff ? 0 : APPEND_EXTRA_ONLY, &fixes);
>  	}
>  
>  	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
> @@ -1463,6 +1487,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
>  		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
>  		OPT_BOOL('s', "signoff", &signoff, N_("add Signed-off-by:")),
> +		OPT_CALLBACK('f', "fixes", &fixes, N_("commit"), N_("add Fixes: for the specified commit"), opt_parse_f),
>  		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
>  		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
>  		OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message")),
> diff --git a/sequencer.c b/sequencer.c
> index 06e52b4..f4cf0e1 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1135,26 +1135,33 @@ int sequencer_pick_revisions(struct replay_opts *opts)
>  	return pick_commits(todo_list, opts);
>  }
>  
> -void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
> +void append_signoff_extra(struct strbuf *msgbuf, int ignore_footer,
> +			  unsigned flag, struct strbuf *extrabuf)
>  {
>  	unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
> +	unsigned append_sob = !(flag & APPEND_EXTRA_ONLY);
>  	struct strbuf sob = STRBUF_INIT;
>  	int has_footer;
>  
> -	strbuf_addstr(&sob, sign_off_header);
> -	strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
> -				getenv("GIT_COMMITTER_EMAIL")));
> -	strbuf_addch(&sob, '\n');
> +	if (append_sob) {
> +		strbuf_addstr(&sob, sign_off_header);
> +		strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
> +					getenv("GIT_COMMITTER_EMAIL")));
> +		strbuf_addch(&sob, '\n');
> +	}
>  
>  	/*
>  	 * If the whole message buffer is equal to the sob, pretend that we
>  	 * found a conforming footer with a matching sob
>  	 */
> -	if (msgbuf->len - ignore_footer == sob.len &&
> +	if (append_sob &&
> +	    msgbuf->len - ignore_footer == sob.len &&
>  	    !strncmp(msgbuf->buf, sob.buf, sob.len))
>  		has_footer = 3;
>  	else
> -		has_footer = has_conforming_footer(msgbuf, &sob, ignore_footer);
> +		has_footer = has_conforming_footer(msgbuf,
> +						   append_sob ? &sob : NULL,
> +						   ignore_footer);
>  
>  	if (!has_footer) {
>  		const char *append_newlines = NULL;
> @@ -1193,9 +1200,17 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
>  				append_newlines, strlen(append_newlines));
>  	}
>  
> -	if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
> +	if (append_sob && has_footer != 3 && (!no_dup_sob || has_footer != 2))
>  		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
>  				sob.buf, sob.len);
> +	if (extrabuf)
> +		strbuf_insert(msgbuf, msgbuf->len - ignore_footer,
> +				extrabuf->buf, extrabuf->len);
>  
>  	strbuf_release(&sob);
>  }
> +
> +void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
> +{
> +	append_signoff_extra(msgbuf, ignore_footer, flag, NULL);
> +}
> diff --git a/sequencer.h b/sequencer.h
> index 1fc22dc..8716ad0 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -7,6 +7,7 @@
>  #define SEQ_OPTS_FILE	"sequencer/opts"
>  
>  #define APPEND_SIGNOFF_DEDUP (1u << 0)
> +#define APPEND_EXTRA_ONLY (1u << 1)
>  
>  enum replay_action {
>  	REPLAY_REVERT,
> @@ -51,5 +52,7 @@ int sequencer_pick_revisions(struct replay_opts *opts);
>  extern const char sign_off_header[];
>  
>  void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
> +void append_signoff_extra(struct strbuf *msgbuf, int ignore_footer,
> +			  unsigned flag, struct strbuf *extrabuf);
>  
>  #endif
> diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
> index 6313da2..12b123a 100755
> --- a/t/t7502-commit.sh
> +++ b/t/t7502-commit.sh
> @@ -137,13 +137,50 @@ test_expect_success 'partial removal' '
>  
>  '
>  
> +signoff_ident () {
> +	git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/"
> +}
> +
>  test_expect_success 'sign off' '
>  
>  	>positive &&
>  	git add positive &&
>  	git commit -s -m "thank you" &&
>  	actual=$(git cat-file commit HEAD | sed -ne "s/Signed-off-by: //p") &&
> -	expected=$(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/") &&
> +	expected=$(signoff_ident) &&
> +	test "z$actual" = "z$expected"
> +
> +'
> +
> +fixes_for_commits () {
> +	for commit in "$@"; do
> +		git -c core.abbrev=12 log -1 --pretty=format:"Fixes: %h ('%s')%n" "$commit"
> +	done
> +}
> +
> +test_expect_success '--fixes' '
> +
> +	echo >>positive &&
> +	git add positive &&
> +	git commit -f HEAD -m "fix bug" &&
> +	actual=$(git cat-file commit HEAD | sed -e "1,/^\$/d") &&
> +	expected=$(echo fix bug; echo; fixes_for_commits HEAD^) &&
> +	test "z$actual" = "z$expected"
> +
> +'
> +
> +test_expect_success 'multiple --fixes with signoff' '
> +
> +	echo >>positive &&
> +	git add positive &&
> +	git commit -f HEAD^ -f HEAD -s -m "signed bugfix" &&
> +	actual=$(git cat-file commit HEAD | sed -e "1,/^\$/d") &&
> +	expected=$(
> +		echo signed bugfix
> +		echo
> +		echo "Signed-off-by: $(signoff_ident)"
> +		fixes_for_commits HEAD^^ HEAD^
> +	) &&
>  	test "z$actual" = "z$expected"
>  
>  '
> 

Michael

[1]
http://thread.gmane.org/gmane.comp.version-control.git/236429/focus=236582

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
