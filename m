From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] contrib/subtree: add repo url to commit messages
Date: Thu, 25 Feb 2016 17:23:16 -0500
Message-ID: <CAPig+cSwQmbvZYbk3T-XYDfMYaMdJ=bFbDwEUtaR121pBrYJOQ@mail.gmail.com>
References: <20160223102559.GA18668@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Nicola Paolucci <npaolucci@atlassian.com>
To: Mathias Nyman <mathias.nyman@iki.fi>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:23:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4Jf-00049N-A9
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbcBYWXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 17:23:19 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:34742 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbcBYWXR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 17:23:17 -0500
Received: by mail-vk0-f46.google.com with SMTP id e185so61500252vkb.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 14:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=dL4mMaUkLeZf8Qi1qppZoAD9Cs97HXoOT8u+8YY6ekE=;
        b=m+9rtQTkNcf1lTA/378tz/jNQ5lWOhI9dElCiH9iu8PNVIFh5O5ODetqSZgiqhtCfp
         /P9FYiPyG1RmDOtC4cIh8amC2UiFqcArqRBgTU07tuLzj8ubrcDl4STndvVHQKIT+77f
         jP9zE7sWbbeA/Jjbb49CtfjeVjp/l3MpBRwzqfBqCS2kTVWRLBppCl7ixgkUeY6iyS5f
         7phu3/JT0r45k15i/rOgc45+eMtaey2B75t1KpY0Kcb2adVpIt4OAb7Bjq3UvemH4edL
         OB25U8hOFaq6UoYaHJaCWZxh8VlpvJcq9FQ1s18DLbHGS1+yJitiXI3VFlQIJr/iW4Eh
         Zegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=dL4mMaUkLeZf8Qi1qppZoAD9Cs97HXoOT8u+8YY6ekE=;
        b=MySB0g8e1lPrmv2ndsW0jK3ePQHE7ksNsmdFjuM7b7ff2QK5Y8740xw9jec+/OFCT5
         Pm9cZ/fyauucqoDZYkqGMSXDW/eX/wpOr/vyYCoIm7F/9SqUgu2AxuRHYoOHVwA6rxwb
         PYQUXcwUtL/Oi/9Sdr1R/9V33k/y73BlEQ6zsOMkqhlRbI+U1CgrYBvJe07lMA0KnXwn
         dkv7b1T8MbKNTs/KN4coUEh18DFfe6mh/NOWOtTnr0+uwvlGm9vTtw8U5H+kXKUw69M0
         MPSMlvSX47K8Ro13OHpozyDSWVvWlGpcswmYnGsNabYVCWq731nAXYPVn31g6NM0YmEg
         /GLQ==
X-Gm-Message-State: AG10YOSyt5IsRzj/x30mhSNid8Sq/3LNL62r3ggGaz+I78NdbP7jA+veCz1yxwPWrDkkiy7zmZd5WZg5qxWwwQ==
X-Received: by 10.31.182.143 with SMTP id g137mr38367737vkf.45.1456438996520;
 Thu, 25 Feb 2016 14:23:16 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 25 Feb 2016 14:23:16 -0800 (PST)
In-Reply-To: <20160223102559.GA18668@iki.fi>
X-Google-Sender-Auth: 2mb-8QF2-P2oIKoSoF9ZiUmrf2g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287446>

On Tue, Feb 23, 2016 at 5:25 AM, Mathias Nyman <mathias.nyman@iki.fi> wrote:
> For recalling where a subtree came from; git-subtree operations 'add'
> and 'pull', when called with the <repository> parameter add this to the
> commit message:
>     git-subtree-repo: <repo_url>
>
> Other operations that don't have the <repository> information, like
> 'merge' and 'add' without <repository>, are unchanged. Users with such a
> workflow will continue to be on their own with the --message parameter,
> if they'd like to record where the subtree came from.

I'm not a subtree user, so review comments below are superficial...

> Signed-off-by: Mathias Nyman <mathias.nyman@iki.fi>
> Based-on-patch-by: Nicola Paolucci <npaolucci@atlassian.com>
> ---
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> @@ -335,18 +335,21 @@ add_msg()
>         dir="$1"
>         latest_old="$2"
>         latest_new="$3"
> +       repo="$4" # optional
>         if [ -n "$message" ]; then
>                 commit_message="$message"
>         else
>                 commit_message="Add '$dir/' from commit '$latest_new'"
>         fi
> -       cat <<-EOF
> -               $commit_message
> -
> -               git-subtree-dir: $dir
> -               git-subtree-mainline: $latest_old
> -               git-subtree-split: $latest_new
> -       EOF
> +       echo $commit_message
> +       echo
> +       echo git-subtree-dir: $dir
> +       echo git-subtree-mainline: $latest_old
> +       echo git-subtree-split: $latest_new

It's not clear why this code was changed to use a series of echo's in
place of the single cat. Although the net result is the same, this
appears to be mere code churn. If your intention was to make it
similar to how squash_msg() uses a series of echo's, then that might
make sense, however, rejoin_msg() uses the same single 'cat' as
add_msg(), so inconsistency remains. Thus, it's not clear what the
intention is.

> +       if [ -n "$repo" ]; then
> +               repo_url=$(get_repository_url "$repo")
> +               echo "git-subtree-repo: $repo_url"
> +       fi
>  }
>
>  add_squashed_msg()
> @@ -382,8 +385,9 @@ squash_msg()
>         dir="$1"
>         oldsub="$2"
>         newsub="$3"
> +       repo="$4" # optional
>         newsub_short=$(git rev-parse --short "$newsub")
> -
> +

Okay, this change is removing an unnecessary tab. Perhaps the commit
message can say that the patch fixes a few whitespace inconsistencies
while touching nearby code.

More below...

>         if [ -n "$oldsub" ]; then
>                 oldsub_short=$(git rev-parse --short "$oldsub")
>                 echo "Squashed '$dir/' changes from $oldsub_short..$newsub_short"
> @@ -397,6 +401,10 @@ squash_msg()
>         echo
>         echo "git-subtree-dir: $dir"
>         echo "git-subtree-split: $newsub"
> +       if [ -n "$repo" ]; then
> +               repo_url=$(get_repository_url "$repo")
> +               echo "git-subtree-repo: $repo_url"
> +       fi
>  }
>
>  toptree_for_commit()
> @@ -440,12 +448,13 @@ new_squash_commit()
>         old="$1"
>         oldsub="$2"
>         newsub="$3"
> +       repo="$4" # optional
>         tree=$(toptree_for_commit $newsub) || exit $?
>         if [ -n "$old" ]; then
> -               squash_msg "$dir" "$oldsub" "$newsub" |
> +               squash_msg "$dir" "$oldsub" "$newsub" "$repo" |
>                         git commit-tree "$tree" -p "$old" || exit $?
>         else
> -               squash_msg "$dir" "" "$newsub" |
> +               squash_msg "$dir" "" "$newsub" "$repo" |
>                         git commit-tree "$tree" || exit $?
>         fi
>  }
> @@ -517,6 +526,16 @@ ensure_valid_ref_format()
>             die "'$1' does not look like a ref"
>  }
>
> +get_repository_url()
> +{
> +       repo=$1
> +       repo_url=$(git config --get remote.$repo.url)
> +       if [ -z "$repo_url" ]; then
> +               repo_url=$repo
> +       fi
> +       echo $repo_url
> +}
> +
>  cmd_add()
>  {
>         if [ -e "$dir" ]; then
> @@ -548,19 +567,18 @@ cmd_add()
>  cmd_add_repository()
>  {
>         echo "git fetch" "$@"
> -       repository=$1
> +       repo=$1

Hmm, so 'repository' was present already but unused in this function,
and now you're using it. I suppose you renamed it 'repo' for
consistency with other 'repo' variable the patch introduces elsewhere.

>         refspec=$2
>         git fetch "$@" || exit $?
>         revs=FETCH_HEAD
> -       set -- $revs
> +       set -- $revs $repo
>         cmd_add_commit "$@"

The original code intentionally allowed passing a set of revs to
cmd_add_commit(), however, you've repurposed it (below) so that it
accepts one rev and an (optional) repo. Therefore, there doesn't seem
to be much value anymore to using "set --" when you could just do:

    cmd_add_commit $revs $repo

Or am I missing something obvious?

(Of course, the original code unconditionally used "set --" even while
setting 'revs' to hardcoded FETCH_HEAD, so I suppose this isn't any
worse, but still...)

>  }
>
>  cmd_add_commit()
>  {
> -       revs=$(git rev-parse $default --revs-only "$@") || exit $?
> -       set -- $revs
> -       rev="$1"
> +       rev=$(git rev-parse $default --revs-only "$1") || exit $?

An audit of call callers of cmd_add_commit() shows that it was only
ever invoked with a single rev, so this change to make it accept a
single rev plus an optional repo seems safe. However, I wonder if it
would make sense to keep the more flexible interface (in case future
callers might need the functionality) by passing repo in as the first
argument (using an empty string, for instance, for the optional bit)
and then taking all subsequent arguments as revs, but perhaps that's
overkill since it doesn't seem to care about revs other than the first
one.

cmd_merge() still goes through the "set --" dance which you've removed
here, even though an audit of all its callers pass in only a single
rev, so that seems inconsistent...

> +       repo="$2" # optional
>
>         debug "Adding $dir as '$rev'..."
>         git read-tree --prefix="$dir" $rev || exit $?
> @@ -575,12 +593,12 @@ cmd_add_commit()
>         fi
>
>         if [ -n "$squash" ]; then
> -               rev=$(new_squash_commit "" "" "$rev") || exit $?
> +               rev=$(new_squash_commit "" "" "$rev" "$repo") || exit $?
>                 commit=$(add_squashed_msg "$rev" "$dir" |
>                          git commit-tree $tree $headp -p "$rev") || exit $?
>         else
>                 revp=$(peel_committish "$rev") &&
> -               commit=$(add_msg "$dir" "$headrev" "$rev" |
> +               commit=$(add_msg "$dir" "$headrev" "$rev" "$repo" |
>                          git commit-tree $tree $headp -p "$revp") || exit $?
>         fi
>         git reset "$commit" || exit $?
> @@ -609,7 +627,8 @@ cmd_split()
>         else
>                 unrevs="$(find_existing_splits "$dir" "$revs")"
>         fi
> -
> +e

So, you're replacing a line containing a single tab with a line
containing a single 'e'. Seems fishy.

> +       rev="$1"
>         # We can't restrict rev-list to only $dir here, because some of our
>         # parents have the $dir contents the root, and those won't match.
>         # (and rev-list --follow doesn't seem to solve this)
> @@ -683,15 +702,20 @@ cmd_split()
>
>  cmd_merge()
>  {
> -       revs=$(git rev-parse $default --revs-only "$@") || exit $?
> +       revs=$(git rev-parse $default --revs-only "$1") || exit $?

Why is this variable still named 'revs' (plural) since you're only
passing in $1 now rather than $@?

>         ensure_clean
> -
>         set -- $revs

Do you still need this "set --" or am I missing something?

>         if [ $# -ne 1 ]; then
>                 die "You must provide exactly one revision.  Got: '$revs'"
>         fi

Ditto with the conditional, considering that you only ever look at $1
now rather than $@.

> +       do_merge "$@"
> +}
> +
> +do_merge()
> +{
>         rev="$1"
> -
> +       repo="$2" # optional
> +
>         if [ -n "$squash" ]; then
>                 first_split="$(find_latest_squash "$dir")"
>                 if [ -z "$first_split" ]; then
> @@ -704,7 +728,7 @@ cmd_merge()
>                         say "Subtree is already at commit $rev."
>                         exit 0
>                 fi
> -               new=$(new_squash_commit "$old" "$sub" "$rev") || exit $?
> +               new=$(new_squash_commit "$old" "$sub" "$rev" "$repo") || exit $?
>                 debug "New squash commit: $new"
>                 rev="$new"
>         fi
> @@ -730,12 +754,13 @@ cmd_pull()
>         if [ $# -ne 2 ]; then
>             die "You must provide <repository> <ref>"
>         fi
> +       repo=$1
>         ensure_clean
>         ensure_valid_ref_format "$2"
>         git fetch "$@" || exit $?
>         revs=FETCH_HEAD
> -       set -- $revs
> -       cmd_merge "$@"
> +       set -- $revs $repo
> +       do_merge "$@"

Same question as above. Is "set --" still buying you anything over just:

    do_merge $revs $repo

?

>  }
>
>  cmd_push()
> --
> 2.7.1
