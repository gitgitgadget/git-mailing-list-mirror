From: Chirayu Desai <chirayudesai1@gmail.com>
Subject: Re: [PATCH/GSoC] pull: implement --[no-]autostash for usage when rebasing
Date: Sat, 19 Mar 2016 19:38:17 +0530
Message-ID: <CAJj6+1ECzKw9jnO1wGZqSyrJ0V=G3TzzE5YKhSKzVO1kqXpXPw@mail.gmail.com>
References: <1458395862-5113-1-git-send-email-chirayudesai1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 19 15:11:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahHb8-000817-UQ
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 15:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbcCSOIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 10:08:19 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:34101 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbcCSOIS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 10:08:18 -0400
Received: by mail-ig0-f169.google.com with SMTP id av4so57663823igc.1
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 07:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to;
        bh=jsxgf6hpHJ/MXJnM94GFq5ilSco0U7jMPviEn57I6xk=;
        b=YFfpE5gWODRVOV6oM8Ue96gXrmcGuqM+76ixsESrqK3BLjWSPkFg1H2pRffaiw2/Yh
         KFjHD0ET6aXnUT98LVeS81FS4x3lYwQTQkUE/heeV/twbqn6d2vht+q7Pa6JQo2aa3AL
         0cnuQvYa2ZuB124Wi+/hzrQ18qsEMHp9JHSWdymfps9dNWOnZTIPqMkZnjqZdFJh4JWi
         9Gw2rZN3XZ3QNVTl1yveFo3kj2thubGAIuDO+O+D4QfLH1efxIrJFW3V1ZPmKFWAE9yL
         CRKRLk5D86Jc4QvrgKOpDTI4fJ145WKGzuoV/m4e9uhzDMAr48OahB93mNF5EuuxwWUt
         W7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to;
        bh=jsxgf6hpHJ/MXJnM94GFq5ilSco0U7jMPviEn57I6xk=;
        b=mVgX+UV15MIWZn00qvIZDycJfXulYKnqZrM2qWJxByKSzAFfPACL9KPzv+oa/ouZ33
         yd3gttV5tRBv/bHX8axRmpQ3qlhNAgjZ43O31rmojkP9XfLSS2yZHboF0K0Xb9VJqzFZ
         wRsyFFN7jk/cYQJY6L04x/C6iaPFP3piIRDU+q9Ps5sxx470ThLBcnSW4GaYkEb3hp7I
         fWnAEuCbQFlPER8hw5cxRrtzITUiMuCAj6C6Cm9SHDPdpEbavELcGr9PE6rt4/esbmXH
         DaJNVxqTb3XcfIxxaykCkwmCVLBUXfBs77dKycwPhuz0X3gi3RePTqdh/HNFg/RiukCu
         aWmw==
X-Gm-Message-State: AD7BkJKW1AMAtwVAOi8GiWNAnGNSoWcS3oaGoJD6AN4BXR9Qm4Yz8PetkPeckT8grwBoIjVz+EgrYh/wRvpF1A==
X-Received: by 10.50.1.6 with SMTP id 6mr4295650igi.28.1458396497447; Sat, 19
 Mar 2016 07:08:17 -0700 (PDT)
Received: by 10.79.31.7 with HTTP; Sat, 19 Mar 2016 07:08:17 -0700 (PDT)
In-Reply-To: <1458395862-5113-1-git-send-email-chirayudesai1@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289307>

Hello everyone,

I want to participate in GSoC, and this is my microproject to get familiar
with git development.

I am a first year student, enrolled in the Computer Engineering program at
Silver Oak College of Engineering and Technology, Ahmedabad, India.
I have worked on open source software in the past, and have used git quite
a bit during that time. I'll include more details in my proposal, which
I'll send here when done.
I understand that this might be a bit late to get started, and I'll try my
best to get this patch in a good state and get the proposal ready ASAP.

As for the change, I spent a lot more time trying to get the test right
than doing the actual change, most of it trying to get familiar with the
test framework and figuring out what to use. It didn't take much time
though, overall.

I'm adding a few inline comments as I have a few questions.

On Sat, Mar 19, 2016 at 7:28 PM Chirayu Desai <chirayudesai1@gmail.com>
wrote:


Since 53c76dc0 pull understands the "rebase.autoStash" configuration
option, which was added to rebase in 58794775

This allows usage of the same option when running 'git pull --rebase',
passing it on to 'git rebase'

Signed-off-by: Chirayu Desai <chirayudesai1@gmail.com>
---
Documentation/git-pull.txt | 7 +++++++
builtin/pull.c | 10 ++++++++++
t/t5544-pull-autostash.sh | 37 +++++++++++++++++++++++++++++++++++++
3 files changed, 54 insertions(+)
create mode 100755 t/t5544-pull-autostash.sh

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index a62a2a615d..24db186c50 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -128,6 +128,13 @@ unless you have read linkgit:git-rebase[1] carefully.
--no-rebase::
Override earlier --rebase.

+--[no-]autostash::
+ Automatically create a temporary stash before the operation
+ begins, and apply it after the operation ends. This means
+ that you can run pull & rebase on a dirty worktree. However,
+ use with care: the final stash application after a successful
+ rebase might result in non-trivial conflicts.
+
Options related to fetching
~~~~~~~~~~~~~~~~~~~~~~~~~~~

diff --git a/builtin/pull.cb/builtin/pull.c
index 10eff03967..c22ce737ce 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -89,6 +89,7 @@ static char *opt_verify_signatures;
static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
static char *opt_gpg_sign;
+static char *opt_autostash;

/* Options passed to git-fetch */
static char *opt_all;
@@ -159,6 +160,8 @@ static struct option pull_options[] = {
OPT_PASSTHRU('S', "gpg-sign", &opt_gpg_sign, N_("key-id"),
N_("GPG sign commit"),
PARSE_OPT_OPTARG),
+ OPT_PASSTHRU(0, "autostash", &opt_autostash, NULL,
+ N_("automatically stash before pull, and apply it after rebase"),
PARSE_OPT_NOARG),


This shows only "--autostash" when you run 'git pull -help'

Any suggestions?


/* Options passed to git-fetch */
OPT_GROUP(N_("Options related to fetching")),
@@ -798,6 +801,9 @@ static int run_rebase(const unsigned char *curr_head,
else
argv_array_push(&args, sha1_to_hex(merge_head));

+ if (opt_autostash)
+ argv_array_push(&args, opt_autostash);
+
ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
argv_array_clear(&args);
return ret;
@@ -841,6 +847,10 @@ int cmd_pull(int argc, const char **argv, const char
*prefix)
die(_("Updating an unborn branch with changes added to the index."));

git_config_get_bool("rebase.autostash", &autostash);
+ if (!strcmp(opt_autostash, "--autostash"))
+ autostash = 1;
+ if (!strcmp(opt_autostash, "--no-autostash"))
+ autostash = 0;
if (!autostash)
die_on_unclean_work_tree(prefix);

diff --git a/t/t5544-pull-autostash.sh b/t/t5544-pull-autostash.sh
new file mode 100755
index 0000000000..7f8309ef43
--- /dev/null
+++ b/t/t5544-pull-autostash.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='git pull --[no-]autostash tests'
+. ./test-lib.sh
+
+test_expect_success setup '
+ echo file >file &&
+ git add file &&
+ git commit -a -m original &&
+ git checkout -b test master &&
+ echo modified file >file &&
+ git commit -m file file
+'
+
+test_expect_success 'pull --rebase --autostash succeeds with dirty working
directory' '
+ git checkout -b test1 master &&
+ git reset --hard master &&
+ git log -1 &&
+ echo dirty >new_file &&
+ git add new_file &&
+ git pull --rebase --autostash . test &&


Would a test_comp_rev be needed / good here?

+ test "$(cat new_file)" = dirty &&
+ test "$(cat file)" = "modified file"
+'
+
+test_expect_success 'pull --rebase --no-autostash fails with dirty working
directory' '
+ git checkout -b test2 master &&
+ git reset --hard master &&
+ git log -1 &&
+ echo dirty >new_file &&
+ git add new_file &&
+ test_must_fail git pull --rebase --no-autostash . test &&


Same as above, test_comp_rev

+ test "$(cat new_file)" = dirty &&
+ test "$(cat file)" = "file"
+'
+
+test_done
\ No newline at end of file
--
2.7.4




Regards,

Chirayu Desai


On Sat, Mar 19, 2016 at 7:27 PM, Chirayu Desai <chirayudesai1@gmail.com> wrote:
> Since 53c76dc0 pull understands the "rebase.autoStash" configuration
> option, which was added to rebase in 58794775
>
> This allows usage of the same option when running 'git pull --rebase',
> passing it on to 'git rebase'
>
> Signed-off-by: Chirayu Desai <chirayudesai1@gmail.com>
> ---
>  Documentation/git-pull.txt |  7 +++++++
>  builtin/pull.c             | 10 ++++++++++
>  t/t5544-pull-autostash.sh  | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 54 insertions(+)
>  create mode 100755 t/t5544-pull-autostash.sh
>
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index a62a2a615d..24db186c50 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -128,6 +128,13 @@ unless you have read linkgit:git-rebase[1] carefully.
>  --no-rebase::
>         Override earlier --rebase.
>
> +--[no-]autostash::
> +       Automatically create a temporary stash before the operation
> +       begins, and apply it after the operation ends.  This means
> +       that you can run pull & rebase on a dirty worktree.  However,
> +       use with care: the final stash application after a successful
> +       rebase might result in non-trivial conflicts.
> +
>  Options related to fetching
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 10eff03967..c22ce737ce 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -89,6 +89,7 @@ static char *opt_verify_signatures;
>  static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
>  static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
>  static char *opt_gpg_sign;
> +static char *opt_autostash;
>
>  /* Options passed to git-fetch */
>  static char *opt_all;
> @@ -159,6 +160,8 @@ static struct option pull_options[] = {
>         OPT_PASSTHRU('S', "gpg-sign", &opt_gpg_sign, N_("key-id"),
>                 N_("GPG sign commit"),
>                 PARSE_OPT_OPTARG),
> +       OPT_PASSTHRU(0, "autostash", &opt_autostash, NULL,
> +               N_("automatically stash before pull, and apply it after rebase"), PARSE_OPT_NOARG),
>
>         /* Options passed to git-fetch */
>         OPT_GROUP(N_("Options related to fetching")),
> @@ -798,6 +801,9 @@ static int run_rebase(const unsigned char *curr_head,
>         else
>                 argv_array_push(&args, sha1_to_hex(merge_head));
>
> +       if (opt_autostash)
> +               argv_array_push(&args, opt_autostash);
> +
>         ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
>         argv_array_clear(&args);
>         return ret;
> @@ -841,6 +847,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>                         die(_("Updating an unborn branch with changes added to the index."));
>
>                 git_config_get_bool("rebase.autostash", &autostash);
> +               if (!strcmp(opt_autostash, "--autostash"))
> +                       autostash = 1;
> +               if (!strcmp(opt_autostash, "--no-autostash"))
> +                       autostash = 0;
>                 if (!autostash)
>                         die_on_unclean_work_tree(prefix);
>
> diff --git a/t/t5544-pull-autostash.sh b/t/t5544-pull-autostash.sh
> new file mode 100755
> index 0000000000..7f8309ef43
> --- /dev/null
> +++ b/t/t5544-pull-autostash.sh
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +
> +test_description='git pull --[no-]autostash tests'
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +       echo file >file &&
> +       git add file &&
> +       git commit -a -m original &&
> +       git checkout -b test master &&
> +       echo modified file >file &&
> +       git commit -m file file
> +'
> +
> +test_expect_success 'pull --rebase --autostash succeeds with dirty working directory' '
> +       git checkout -b test1 master &&
> +       git reset --hard master &&
> +       git log -1 &&
> +       echo dirty >new_file &&
> +       git add new_file &&
> +       git pull --rebase --autostash . test &&
> +       test "$(cat new_file)" = dirty &&
> +       test "$(cat file)" = "modified file"
> +'
> +
> +test_expect_success 'pull --rebase --no-autostash fails with dirty working directory' '
> +       git checkout -b test2 master &&
> +       git reset --hard master &&
> +       git log -1 &&
> +       echo dirty >new_file &&
> +       git add new_file &&
> +       test_must_fail git pull --rebase --no-autostash . test &&
> +       test "$(cat new_file)" = dirty &&
> +       test "$(cat file)" = "file"
> +'
> +
> +test_done
> \ No newline at end of file
> --
> 2.7.4
>
