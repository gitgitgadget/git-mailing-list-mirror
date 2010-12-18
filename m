From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/8] docs: use <tree> instead of <tree-ish>
Date: Sat, 18 Dec 2010 02:35:16 -0600
Message-ID: <20101218083516.GC6187@burratino>
References: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
 <1292650725-21149-7-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 18 09:36:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTsH2-0003yq-Im
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 09:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848Ab0LRIf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 03:35:29 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33155 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710Ab0LRIf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 03:35:28 -0500
Received: by yxt3 with SMTP id 3so682821yxt.19
        for <git@vger.kernel.org>; Sat, 18 Dec 2010 00:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=1f6hjepMAS0PvVh1vhKgc4IyQTaazzO9GpoJdG7Lgog=;
        b=A+rSHiOhR9i5Gn/UlRdjBHHTF8ZFYTyTXBn4zSvDeKR6WdZPHlHDJymIu5nUZCHx3f
         vlyAk2YdpyucQMStQv18FiupEwRAI/kD8r4NJgGpUIL/VpCSrNhV6y93bsKl3rlDbIHa
         7A+Z+gmMA9oXd8BxfV89N1SuhvJLsNiWIicqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AScn4OA8+qkJywd1wizMB2Ox78twpuGgByYaf/5n8Zz/4ro7zu4UJ+FDqGqu4B/1nA
         BvwNo+GxXQSoi8O7pvZNHmDJJQkIZc66WtErG1Y2pgMYbhQqUXomTqoi2BJt0U0/62YO
         gwqGJgpUNZN42Q6OUTh6vZVlM4KzvMpn3qtZ0=
Received: by 10.236.102.135 with SMTP id d7mr3335466yhg.45.1292661327701;
        Sat, 18 Dec 2010 00:35:27 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id 7sm765888yhl.27.2010.12.18.00.35.25
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 18 Dec 2010 00:35:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1292650725-21149-7-git-send-email-lodatom@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163909>

Mark Lodato wrote:

> The term "tree-ish" was left in the following situations:
>  - all comments in the code
>  - situations where "tree-ish" is being contrasted to "tree"
>  - error messages, to prevent porcelains from changing

Nit: to prevent plumbing from changing?  Or to prevent porcelains
from having to change in response to changes in plumbing?

> --- a/Documentation/RelNotes/1.6.2.4.txt
> +++ b/Documentation/RelNotes/1.6.2.4.txt
> @@ -13,7 +13,7 @@ Fixes since v1.6.2.3
>  * "git-add -p" lacked a way to say "q"uit to refuse staging any hunks for
>    the remaining paths.  You had to say "d" and then ^C.
>  
> -* "git-checkout <tree-ish> <submodule>" did not update the index entry at
> +* "git-checkout <tree> <submodule>" did not update the index entry at
>    the named path; it now does.

Is changing release notes for historical releases like this a good
idea?  (It not clear to me either way.)

> --- a/Documentation/diff-format.txt
> +++ b/Documentation/diff-format.txt
> @@ -7,13 +7,13 @@ The raw output format from "git-diff-index", "git-diff-tree",
>  These commands all compare two sets of things; what is
>  compared differs:
>  
> -git-diff-index <tree-ish>::
> -        compares the <tree-ish> and the files on the filesystem.
> +git-diff-index <tree>::
> +        compares the <tree> and the files on the filesystem.

Unrelated: we ought to remove the dash after "git" here.  (Thanks
for a reminder.)

> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -11,7 +11,7 @@ SYNOPSIS
>  [verse]
>  'git archive' [--format=<fmt>] [--list] [--prefix=<prefix>/] [<extra>]
>  	      [-o | --output=<file>] [--worktree-attributes]
> -	      [--remote=<repo> [--exec=<git-upload-archive>]] <tree-ish>
> +	      [--remote=<repo> [--exec=<git-upload-archive>]] <tree>
>  	      [<path>...]
>  
>  DESCRIPTION
> @@ -70,7 +70,7 @@ OPTIONS
>  	Used with --remote to specify the path to the
>  	'git-upload-archive' on the remote side.
>  
> -<tree-ish>::
> +<tree>::
>  	The tree or commit to produce an archive for.

In this case, it might be less confusing to explicitly say (<commit> |
<tree>), since the behavior is:

 . commit id and timestamp recorded from commit if a commit is
   used
 . no commit id and time of invocation (!) recorded if a tree is
   used directly

meaning "git archive commit" and "git archive commit^{tree}" do not
always have the same behavior.

> --- a/Documentation/git-commit-tree.txt
> +++ b/Documentation/git-commit-tree.txt
> @@ -36,7 +36,8 @@ state was.
>  OPTIONS
>  -------
>  <tree>::
> -	An existing tree object
> +	An existing tree object.  Unlike other git commands, this must
> +	be an actual tree object, not a commit or tag.

Maybe it would be worth dropping that constraint (in the code) for
simplicity?

If not, it would be nice to give a fuller explanation, something to
this effect:

	An existing tree object.  To [reason here], the argument will
	not be automatically dereferenced to a tree if it names a commit
	or tag; you must instead specify the tree explicitly, for
	example by ending the argument with ^{tree}.

Wording could surely be improved.

> --- a/Documentation/git-diff-index.txt
> +++ b/Documentation/git-diff-index.txt
> @@ -8,7 +8,7 @@ git-diff-index - Compares content and mode of blobs between the index and reposi
>  
>  SYNOPSIS
>  --------
> -'git diff-index' [-m] [--cached] [<common diff options>] <tree-ish> [<path>...]
> +'git diff-index' [-m] [--cached] [<common diff options>] <tree> [<path>...]
>  
>  DESCRIPTION
>  -----------
> @@ -22,7 +22,7 @@ OPTIONS
>  -------
>  include::diff-options.txt[]
>  
> -<tree-ish>::
> +<tree>::
>  	The id of a tree object to diff against.

Is an arbitrary tree name okay, or only tree ids?

> --- a/Documentation/git-ls-tree.txt
> +++ b/Documentation/git-ls-tree.txt
> @@ -35,8 +35,8 @@ in the current working directory.  Note that:
>  
>  OPTIONS
>  -------
> -<tree-ish>::
> -	Id of a tree-ish.
> +<tree>::
> +	The id of a tree object.

Likewise.

> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> -Reads three treeish, and output trivial merge results and
> +Reads three <tree>s, and output trivial merge results and

Since the string "<tree>" does not appear in the synopsis, it seems
odd to mention it here.  Maybe it would be clearer to say:

SYNOPSIS
	git merge-tree <base-tree> <branch1> <branch2>

DESCRIPTION
	Reads three trees and outputs trivial merge results and
	conflicting entries to the standard output. This

or (though I like the previous synopsis much more)

SYNOPSIS
	git merge-tree <tree> <tree> <tree>

DESCRIPTION
	Reads three trees and outputs trivial merge results and
	conflicting entries to the standard output.  The arguments
	are in the same order as those for "git read-tree": the
	first represents the original (basis) state and the other
	two represent versions with improvements that need to be
	merged. This

> --- a/Documentation/git-read-tree.txt
> +++ b/Documentation/git-read-tree.txt
> @@ -118,7 +118,7 @@ OPTIONS
>  	Instead of reading tree object(s) into the index, just empty
>  	it.
>  
> -<tree-ish#>::
> +<tree-#>::
>  	The id of the tree object(s) to be read/merged.

Just "The tree objects to be read or merged", not necessarily named
by id, right?

> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -314,8 +314,8 @@ Any other arguments are passed directly to 'git log'
>  'find-rev'::
>  	When given an SVN revision number of the form 'rN', returns the
>  	corresponding git commit hash (this can optionally be followed by a
> -	tree-ish to specify which branch should be searched).  When given a
> -	tree-ish, returns the corresponding SVN revision number.
> +	<tree> to specify which branch should be searched).  When given a
> +	<tree>, returns the corresponding SVN revision number.

The placeholder <tree> sounds odd in descriptive text like this.
Maybe:

	If the first argument is of the form 'rN', prints the
	corresponding git commit id.  An optional second argument can
	name a commit, to limit the search to commits accessible from
	that commit.

	Otherwise, the first (and only) argument is interpreted as a
	git tree name and this subcommand prints the corresponding
	SVN revision number.

> @@ -345,7 +345,7 @@ Any other arguments are passed directly to 'git log'
>  	for use after commands like "git checkout" or "git reset".
>  
>  'commit-diff'::
> -	Commits the diff of two tree-ish arguments from the
> +	Commits the diff of two <tree> arguments from the

Likewise.  "Two trees named on the command line" should be clear.

> --- a/Documentation/git-tar-tree.txt
> +++ b/Documentation/git-tar-tree.txt
> @@ -29,7 +29,7 @@ It can be extracted using 'git get-tar-commit-id'.
>  OPTIONS
>  -------
>  
> -<tree-ish>::
> +<tree>::
>  	The tree or commit to produce tar archive for.  If it is
>  	the object name of a commit object.

Huh?  (Not a problem introduced by this patch, but...)

> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -469,17 +469,14 @@ Identifier Terminology
>  	Indicates a blob object name.
>  
>  <tree>::
> -	Indicates a tree object name.
> +	Indicates a tree object name, or the name of tag or commit that points
> +	at a tree.  A command that takes a <tree> argument ultimately
> +	wants to operate on a tree object but automatically dereferences
> +	tag and commit objects until it finds a tree.
>  
>  <commit>::
>  	Indicates a commit object name.
>  
> -<tree-ish>::
> -	Indicates a tree, commit or tag object name.  A
> -	command that takes a <tree-ish> argument ultimately wants to
> -	operate on a <tree> object but automatically dereferences
> -	<commit> and <tag> objects that point at a <tree>.
> -

I first read the new description as

	Indicates a tree name, or the name of a tag or commit ...

which seemed odd --- this always is a tree name.  Maybe

 <tree>::
	Indicates a parameter specifying a tree, commit, or tag object.
	A command that takes a <tree> argument ultimately wants to
	operate on a tree object so it automatically dereferences
	tag and commit objects until it finds a tree.

Thanks for eliminating the confusing <commit>, <tag>, etc markup.

> --- a/Documentation/gitcli.txt
> +++ b/Documentation/gitcli.txt
> @@ -15,8 +15,8 @@ DESCRIPTION
>  
>  This manual describes the convention used throughout git CLI.
>  
> -Many commands take revisions (most often "commits", but sometimes
> -"tree-ish", depending on the context and command) and paths as their
> +Many commands take revisions (most often <commit>s, but sometimes
> +<tree>s, depending on the context and command) and paths as their

Maybe

 Many commands take revisions (most often commits but sometimes
 trees, depending on the context and command) and paths as their
 arguments.  Here are the rules:

to avoid emphasizing a technicality.

> --- a/Documentation/gittutorial-2.txt
> +++ b/Documentation/gittutorial-2.txt
> @@ -209,10 +209,8 @@ Note, by the way, that lots of commands take a tree as an argument.
>  But as we can see above, a tree can be referred to in many different
>  ways--by the SHA1 name for that tree, by the name of a commit that
>  refers to the tree, by the name of a branch whose head refers to that
> -tree, etc.--and most such commands can accept any of these names.
> -
> -In command synopses, the word "tree-ish" is sometimes used to
> -designate such an argument.
> +tree, etc.--and all such commands can accept any of these names unless
> +otherwise stated.

... otherwise stated in the manual pages?

> --- a/t/t4100/t-apply-3.patch
> +++ b/t/t4100/t-apply-3.patch
[...]
> --- a/t/t4100/t-apply-7.patch
> +++ b/t/t4100/t-apply-7.patch
[...]

These last two aren't worth it, I think. :)

I very much like this change.  Ideally it should be possible to deal
with some of the nontrivial parts first in separate patches before
a last trivial one that does not do much more than change tree-ish ->
tree.
