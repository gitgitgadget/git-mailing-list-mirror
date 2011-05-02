From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] git-add.txt: document 'interactive.singlekey'
Date: Mon, 02 May 2011 10:22:04 -0700
Message-ID: <7v1v0hngs9.fsf@alter.siamese.dyndns.org>
References: <20110501045140.GA13387@sigill.intra.peff.net>
 <1304343872-1654-3-git-send-email-valentin.haenel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git-List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Valentin Haenel <valentin.haenel@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 02 19:39:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGx5u-0000SE-Sx
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 19:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163Ab1EBRje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 13:39:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65404 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748Ab1EBRjc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 13:39:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D755E56AD;
	Mon,  2 May 2011 13:41:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=5dz8OLCVd7rzyRnwUkyw3/FxLbc=; b=GvI7RINVF4CHIIah/w5F
	S+uimxF3Uxx/JMPsXyopbth9U8Vk8JqginlJFzK9+nQXH3AZallMvaRERcVmMD8J
	drDyXY5aoOxSql/wE9GLEaoyN3d7d8nGy2bzzmGbdUkZBO8+43hoVdx9DiGaM5Tu
	EYCcg29lyf0MTHYf4Ya4P1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=IpdEe8oTotOLCoOZlE98GC+xX2W10t2NR3Gst5wnXo/U0o
	lzwJIP1IUAeJnkvyvaHkSd/qNGzFkpuV/NSaMAyVRdsJBbowhMENkZD12eZxi803
	EwrzF5MQ91mUuxsI3SFY5QWoljBN23MyJCqaEQA0CD+l3sqj/khalKwQH9nsE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 84D1B56AA;
	Mon,  2 May 2011 13:41:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9E33656A6; Mon,  2 May 2011
 13:41:23 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 69ED172A-74E3-11E0-9079-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172607>

Valentin Haenel <valentin.haenel@gmx.de> writes:

> Signed-off-by: Valentin Haenel <valentin.haenel@gmx.de>
> Helped-by: Jeff King <peff@peff.net>
> ---
>  Documentation/git-add.txt |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 7eebbef..c172989 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -86,6 +86,9 @@ OPTIONS
>  This effectively runs `add --interactive`, but bypasses the
>  initial command menu and directly jumps to the `patch` subcommand.
>  See ``Interactive mode'' for details.
> ++
> +The configuration `interactive.singlekey` allows the user to provide
> +one-letter input with a single key in this mode (i.e., without hitting enter).

I do not think this belongs here.  For one thing, as the text in the
pre-context in your patch says, this also applies to "-i".  Since they
both refer to the "Interactive mode" section for further details, I think
that would be more appropriate place to mention the variable, which after
all is a tiny part of the detail (think: if somebody does not know how to
operate the interactive mode, "singlekey does not require enter" is not
very helpful).

Not all the configuration variables "git-add" pays attention to are
mentioned in this manual page (e.g. color.interactive.<slot> and
add.ignoreerrors are not mentioned).  I also do not think duplicating
everything "git add" pays attention to in this manual page is necessarily
a good thing.  I'd prefer to mention only the important ones (e.g. the
ones that give default values for their corresponding command line
options) in the main part of the documentation.

For the other commands that internally invoke "add -p", the text before
your patch is unhelpful to people who have not seen "git add -p" in
action.  Some of them do not even mention where the interactive mode is
explained.  The result of your patch does not help the situation, and
abruptly start talking about interactive.singlekey, still without teaching
how to operate the interactive mode at all.

I think the end result of the series should look something like this patch,
after applying your [PATCH 1/5], but discarding 2 thru 5.


 Documentation/git-add.txt      |    5 ++++-
 Documentation/git-checkout.txt |    4 +++-
 Documentation/git-reset.txt    |    4 +++-
 Documentation/git-stash.txt    |    4 +++-
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 7eebbef..27e0160 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -134,6 +134,8 @@ subdirectories.
 	If some files could not be added because of errors indexing
 	them, do not abort the operation, but continue adding the
 	others. The command shall still exit with non-zero status.
+	The configuration variable `add.ignoreErrors` can be set to
+	true to make this the default behaviour.
 
 --ignore-missing::
 	This option can only be used together with --dry-run. By using
@@ -189,7 +191,8 @@ interactive command loop.
 The command loop shows the list of subcommands available, and
 gives a prompt "What now> ".  In general, when the prompt ends
 with a single '>', you can pick only one of the choices given
-and type return, like this:
+and type return (the configuration variable `interactive.singlekey`
+can be set to true to omit hitting return, by the way), like this:
 
 ------------
     *** Commands ***
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 1063f69..7c58028 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -179,7 +179,9 @@ the conflicted merge in the specified paths.
 --patch::
 	Interactively select hunks in the difference between the
 	<tree-ish> (or the index, if unspecified) and the working
-	tree.  The chosen hunks are then applied in reverse to the
+	tree (see the ``Interactive Mode`` section of gitlink:git-add[1]
+	to learn how to operate the interactive mode).  The chosen
+	hunks are then applied in reverse to the
 	working tree (and if a <tree-ish> was specified, the index).
 +
 This means that you can use `git checkout -p` to selectively discard
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 8481f9d..37f487e 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -36,7 +36,9 @@ working tree in one go.
 
 'git reset' --patch|-p [<commit>] [--] [<paths>...]::
 	Interactively select hunks in the difference between the index
-	and <commit> (defaults to HEAD).  The chosen hunks are applied
+	and <commit> (see the ``Interactive Mode``
+	section of gitlink:git-add[1] to learn how to operate the interactive
+	mode).  Missing <commit> defaults to HEAD.  The chosen hunks are applied
 	in reverse to the index.
 +
 This means that `git reset -p` is the opposite of `git add -p` (see
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 79abc38..281bd35 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -55,7 +55,9 @@ If the `--keep-index` option is used, all changes already added to the
 index are left intact.
 +
 With `--patch`, you can interactively select hunks from in the diff
-between HEAD and the working tree to be stashed.  The stash entry is
+between HEAD and the working tree to be stashed (see the ``Interactive Mode``
+section of gitlink:git-add[1] to learn how to operate the interactive
+mode).  The stash entry is
 constructed such that its index state is the same as the index state
 of your repository, and its worktree contains only the changes you
 selected interactively.  The selected changes are then rolled back
