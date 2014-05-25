From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] commit: support commit.verbose and --no-verbose
Date: Sun, 25 May 2014 06:23:18 -0400
Message-ID: <CAPig+cSS9_u1zF5Zv2gZ=xbUjuLgk3FgyYzd1yEyQmyeO3gpcg@mail.gmail.com>
References: <20140525062427.GA94219@sirius.att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	James P Howard II <jh@jameshoward.us>,
	Jeff King <peff@peff.net>,
	Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Caleb Thompson <cjaysson@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 25 12:23:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WoVaP-0007aQ-So
	for gcvg-git-2@plane.gmane.org; Sun, 25 May 2014 12:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbaEYKXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2014 06:23:20 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:50245 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbaEYKXT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2014 06:23:19 -0400
Received: by mail-yh0-f54.google.com with SMTP id i57so5565696yha.41
        for <git@vger.kernel.org>; Sun, 25 May 2014 03:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2WCC3s/4llcD2ekjIAx9rLfkUowzreDjGaDhzGflXRo=;
        b=mdU7F4WTRu86/QutkqyNSRVmENWSWeF1CKf9zTv3KJE9i50HyyxipCC6TA2rQ3uWJG
         YXHFNzTbueYBcsjUk9EQJsiH2BiBL+CBabr8Cr5I4Wwvs54rEck2m5sAUdXmQ/u2kdsV
         zPxDisk4Vvm1fVPOYlMaOUJVBCwtYGvq3cqUu9KpNtTNpG6yOZ2Nsrky/cKVBrM0oO8j
         mbznIcONiu0teQ4wX6Y5SrZct49U1ITGLKoH6GbLUttymYn6DYVeiWf6olHxLR/u2rq2
         nfc5K6iy18LJpKA8t9qQlanfyURvuCPwlNKMmSqENzJ5zEEv8fjbn/mZ6GpJ2P1btcmH
         xwHQ==
X-Received: by 10.236.162.130 with SMTP id y2mr25995333yhk.78.1401013398623;
 Sun, 25 May 2014 03:23:18 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Sun, 25 May 2014 03:23:18 -0700 (PDT)
In-Reply-To: <20140525062427.GA94219@sirius.att.net>
X-Google-Sender-Auth: zFYd7nw9fUHYiJnpwNnmbiNr_Gk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250086>

On Sun, May 25, 2014 at 2:24 AM, Caleb Thompson <cjaysson@gmail.com> wrote:
> Incorporated changes from Duy Nguyen and Jeremiah Mahler.

As a courtesy to reviewers, it is helpful to provide a pointer to the
previous submission to give context for the new submission. For
instance, like this [1].

[1]: http://git.661346.n2.nabble.com/commit-support-commit-verbose-and-no-verbose-td7611617.html

> Jeremiah, I didn't make the changes about `<<-EOF` or `test_expect_success`
> because I'm guessing that keeping the local style of the code intact is more
> important than using those. Do you think it makes sense to refactor the rest of
> the test file (t/t7507-commit-verbose.sh) to use those? I could also change the
> other `git config` calls to use `test_config`.

Generally speaking, it is important to respect local style, however,
it is also appropriate to include one or more cleanup patches before
your primary changes in order to bring the code in line with current
practices. Conversion to test_config could be such a cleanup patch.

> Duy, you were right about `-V`. Do you know of a simple way to add that
> shortened flag? `OPT_BOOL('v', "verbose", ...)` gives me `-v`, `--verbose`, and
> `--no-verbose`, but no `-V` as a shortened form of `--no-verbose`.

At this point, after your email commentary but before the actual
patch, you should have a scissor line -->8-- so that "git am" can
extract your patch automatically from the email.

> commit 1a49356b87c9028e68e731f34790c11a3075f736

Drop this line. It has no meaning outside of your local repository.

> Author: Caleb Thompson <caleb@calebthompson.io>
> Date:   Fri May 23 11:47:44 2014 -0500

Ditto for the date.

>     commit: support commit.verbose and --no-verbose
>
>     Add a new configuration variable commit.verbose to implicitly pass
>     `--verbose` to `git-commit`. Add `--no-verbose` to commit to negate that
>     setting.

The commit message would read just as well or better without the backquotes.

>     Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
>     Reviewed-by: Duy Nguyen <pclouds@gmail.com>
>     Reviewed-by: Jeremiah Mahler <jmmahler@gmail.com>

Considering that the code in this patch has changed since v1, it's
probably not appropriate to add these Reviewed-by: lines.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1932e9b..a245928 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1009,6 +1009,11 @@ commit.template::
>         "`~/`" is expanded to the value of `$HOME` and "`~user/`" to the
>         specified user's home directory.
>
> +commit.verbose::
> +       A boolean to enable/disable inclusion of diff information in the
> +       commit message template when using an editor to prepare the commit
> +       message.  Defaults to false.
> +
>  credential.helper::
>         Specify an external helper to be called when a username or
>         password credential is needed; the helper may consult external
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 0bbc8f5..d7b50e2 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -282,7 +282,13 @@ configuration variable documented in linkgit:git-config[1].
>         Show unified diff between the HEAD commit and what
>         would be committed at the bottom of the commit message
>         template.  Note that this diff output doesn't have its
> -       lines prefixed with '#'.
> +       lines prefixed with '#'.  The `commit.verbose` configuration
> +       variable can be set to true to implicitly send this option.
> +
> +--no-verbose::
> +       Do not show the unified diff  at the bottom of the commit message

Already mentioned by Jeremiah: s/diff\s+/diff /

> +       template.  This is the default behavior, but can be used to override
> +       the`commit.verbose` configuration variable.

Also already mentioned: s/the/the /

>  -q::
>  --quiet::
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 9cfef6c..7978d7f 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1417,6 +1417,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
>                 sign_commit = git_config_bool(k, v) ? "" : NULL;
>                 return 0;
>         }
> +       if (!strcmp(k, "commit.verbose")) {
> +               verbose = git_config_bool(k, v);
> +               return 0;
> +       }
>
>         status = git_gpg_config(k, v, NULL);
>         if (status)
> @@ -1484,7 +1488,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>         static struct wt_status s;
>         static struct option builtin_commit_options[] = {
>                 OPT__QUIET(&quiet, N_("suppress summary after successful commit")),
> -               OPT__VERBOSE(&verbose, N_("show diff in commit message template")),
> +               OPT_BOOL('v', "verbose", &verbose, N_("show diff in commit message template")),
>
>                 OPT_GROUP(N_("Commit message options")),
>                 OPT_FILENAME('F', "file", &logfile, N_("read message from file")),
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 2c59a76..b8f4b94 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1976,6 +1976,7 @@ _git_config ()
>                 color.ui
>                 commit.status
>                 commit.template
> +               commit.verbose
>                 core.abbrev
>                 core.askpass
>                 core.attributesfile
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> index 2ddf28c..bea5d88 100755
> --- a/t/t7507-commit-verbose.sh
> +++ b/t/t7507-commit-verbose.sh
> @@ -10,6 +10,12 @@ EOF
>  chmod +x check-for-diff
>  test_set_editor "$PWD/check-for-diff"

This is not a new problem, but since you copied and modified the
test_set_editor invocation for your own test (below), it can be
mentioned that $(pwd) should be used rather than $PWD. See discussion
of $(pwd) in t/README. A preparatory patch which fixes this would not
be unwelcome.

> +cat >check-for-no-diff <<EOF
> +#!$SHELL_PATH
> +exec grep -v '^diff --git' "\$1"
> +EOF
> +chmod +x check-for-no-diff

write_script (from test-lib-functions.sh) would be a more appropriate
and modern way to compose this script. If you're concerned about style
consistency, a cleanup patch before this one could employ write_script
for the check-for-diff script, as well.

Also, since this script is used by only the one test, current practice
suggests that script creation should be done within the test itself.

>  cat >message <<'EOF'
>  subject
>
> @@ -48,6 +54,21 @@ test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
>         check_message message
>  '
>
> +test_expect_success 'commit shows verbose diff with set commit.verbose' '
> +       echo morecontent >file &&

Is your intention to add more content to 'file'? If so, use '>>'.

> +       git add file &&
> +       test_config commit.verbose true &&
> +       check_message message

As Jeremiah pointed out, this test is not actually testing if
commit.verbose=true worked since it's not invoking git-commit. In
fact, check_message is testing something unrelated. You probably meant
"git commit --amend" rather than "check_message message"

> +'
> +
> +test_expect_success 'commit does not show verbose diff with --no-verbose' '

As this is the only test which needs check-for-no-diff, it would be
appropriate to move script creation (via write_script) here into the
test itself (unless you plan on adding more tests which invoke the
script).

> +       echo morecontent >file &&
> +       git add file &&

Again, since you're using '>' rather than '>>', you haven't actually
changed the content of the file since the last test, so this code
serves no purpose.

> +       test_config commit.verbose true &&
> +       test_set_editor "$PWD/check-for-no-diff" &&

As noted above, use $(pwd) rather than $PWD.

This invocation of test_set_editor potentially breaks tests following
this one (including tests which may be added in the future) since it
changes the global state established by test_set_editor near the top
of the script. To avoid such a problem, you could invoke
test_set_editor and git-commit in a subshell.

Alternately, current practice would suggest that each test which
requires a particular editor should be responsible for setting it. As
such, a preparatory patch could drop the global test_set_editor and
invoke it instead in each test which requires it. (In fact, there are
a couple tests which are still setting EDITOR manually, and these
could be converted to test_set_editor.)

> +       git commit --amend --no-verbose
> +'

You're missing some potential tests, such as:

commit.verbose = <unset> (optional)
commit.verbose = false
--verbose overrides commit.verbose=false

>  cat >diff <<'EOF'
>  This is an example commit message that contains a diff.
