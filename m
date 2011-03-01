From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rebase: define options in OPTIONS_SPEC
Date: Mon, 28 Feb 2011 20:59:26 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102272055320.5025@debian>
References: <4D5BE49D.1040402@viscovery.net> <1298516875-10765-1-git-send-email-martin.von.zweigbergk@gmail.com> <7v7hcl4uan.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 02:59:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuEsH-0008Jk-O2
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 02:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837Ab1CAB7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 20:59:36 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38455 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406Ab1CAB7f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 20:59:35 -0500
Received: by qwd7 with SMTP id 7so3326910qwd.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 17:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=/cibFs51n09IVxM/tIykgdEC7NfPOT05sD/MoFLtw0g=;
        b=llcXzJMFaNAJQ6kfI7uzKKwGvnKgSBbfAB8F7IMHH26nlz5JuKKSXCpYBpGxZcMnYV
         ehRbugQagCdXAaE5tias5JnHwrzz5OQf8Ho9iyq0sSs83MuMQddaweVnfIv1Ld9N4LUX
         A4n50oV39lBoA/+OcsMNZjUFU6qNBD8lJNiyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=P4LcvnsUuHWcDZk0G53RTiSmgcXa1zoGD1wRhwskNjaLntN179PRwHMJ6XA69nexH7
         pBbdiRuod8flLx9zO4esUflV9yyPZ30gF6njcZ5M/U4LeDnn7ooCF+0La1IM5HZsu3qQ
         uvV4qKpOQxvzNUnOrYPzmRh221UjO+J+snats=
Received: by 10.224.74.75 with SMTP id t11mr5235750qaj.146.1298944773753;
        Mon, 28 Feb 2011 17:59:33 -0800 (PST)
Received: from [192.168.1.104] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id g32sm3634162qck.22.2011.02.28.17.59.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Feb 2011 17:59:32 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <7v7hcl4uan.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168181>

On Sun, 27 Feb 2011, Junio C Hamano wrote:

> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
> 
> > What is the difference between the "options" and "actions" sections?
> 
> For historical reasons, "git rebase" does not take subcommands in the way
> many other commands do (e.g. "git bisect start", "git rerere remaining",
> "git stash save").  Some --option to the command are used for specifying
> the subcommand.  "git rebase --continue", if it were designed to be
> consistent with the other commands, would have been "git rebase continue"
> instead.  "Actions" part lists them.
> 
> This is somewhat unfortunate, but is understandable given that "rebase"
> didn't have its own options at all, and there was only one mode of
> operation, namely, to start the rebase process.  It allowed the user to be
> terse, i.e. instead off having to say "git rebase onto master", it was
> sufficient to say "git rebase master".
> 
> When "git rebase --continue" was introduced (before, you were supposed to
> say "git am --resolved", which was nonsense from the UI point of view),
> somebody should have noticed this as a problem and started a process to
> deprecate the "git rebase <branchname>" and to require explicit subcommand
> names, just like we did to "git stash [save]", but that didn't happen.
> 
> Perhaps this is something to consider at 2.0 boundary.
> 

Thanks for the explanation. It sounds like I should leave only
--continue, --skip and --abort in the "Actions" section.

I just noticed another problem with my patch. I had assumed that
specifying 'n,no-stat ...' on one line would give me a '-n' argument
to handle if e.g. '-n', '--no-stat' or '--no-sta' was passed. To my
surprise, when passing '--no-stat' on the command line, parse-options
gives me the long form back. If I pass '--no-sta', I get the curious

error: Ambiguous option: no-sta (could be --no-stat or --no-stat)

I figured these are related to the automatic support for negative
options (now I understand what you were talking about when you
mentioned that to someone a few days ago). So here comes an updated
patch where I have marked all of the options except for a few
(e.g. 'autosquash') with a '!' to tell parse-options that they have no
negative forms.


And thanks for fixing up my patch that moved the rebase scripts to
SCRIPT_LIB.


-- 8< --
Subject: [PATCH v2] rebase: define options in OPTIONS_SPEC

Interactive rebase used to have its own command line processing. Since
it used the 'git rev-parse --parseopt' functionality exposed through
git-sh-setup, it had some flexibility, like matching prefixes of long
options, that non-interactive rebase didn't. When interactive rebase's
command line processing was factored out into git-rebase.sh in cf432ca
(rebase: factor out command line option processing, 2011-02-06), this
flexibility was lost. Give back that flexibility to interactive and
non-interactive by defining its options in OPTIONS_SPEC.

Also improve the usage message to contain the --continue, --skip and
--abort sub commands.

Reported-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
Applies on top of mz/rebase.

Are USAGE and LONG_USAGE still needed?

I based the definitions on the now-lost OPTIONS_SPEC from interactive
rebase and on Documentation/git-rebase.txt.

 git-rebase.sh |  101 +++++++++++++++++++++++++++++++-------------------------
 1 files changed, 56 insertions(+), 45 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index a040ab5..7a54bfc 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -28,7 +28,39 @@ Example:       git-rebase master~1 topic
 '
 
 SUBDIRECTORY_OK=Yes
-OPTIONS_SPEC=
+OPTIONS_KEEPDASHDASH=
+OPTIONS_SPEC="\
+git rebase [-i] [options] [--onto <newbase>] [<upstream>] [<branch>]
+git rebase [-i] [options] --onto <newbase> --root [<branch>]
+git-rebase [-i] --continue | --abort | --skip
+--
+ Available options are
+v,verbose!         display a diffstat of what changed upstream
+q,quiet!           be quiet. implies --no-stat
+onto=!             rebase onto given branch instead of upstream
+p,preserve-merges! try to recreate merges instead of ignoring them
+s,strategy=!       use the given merge strategy
+no-ff!             cherry-pick all commits, even if unchanged
+m,merge!           use merging strategies to rebase
+i,interactive!     let the user edit the list of commits to rebase
+f,force-rebase!    force rebase even if branch is up to date
+X,strategy-option=! pass the argument through to the merge strategy
+stat!              display a diffstat of what changed upstream
+n,no-stat!         do not show diffstat of what changed upstream
+verify             allow pre-rebase hook to run
+rerere-autoupdate  allow rerere to update index with resolved conflicts
+root!              rebase all reachable commits up to the root(s)
+autosquash         move commits that begin with squash!/fixup! under -i
+committer-date-is-author-date! passed to 'git am'
+ignore-date!       passed to 'git am'
+whitespace=!       passed to 'git apply'
+ignore-whitespace! passed to 'git apply'
+C=!                passed to 'git apply'
+ Actions:
+continue!          continue rebasing process
+abort!             abort rebasing process and restore original branch
+skip!              skip current patch and continue rebasing process
+"
 . git-sh-setup
 set_reflog_action rebase
 require_work_tree
@@ -175,7 +207,7 @@ do
 		ok_to_skip_pre_rebase=
 		;;
 	--continue|--skip|--abort)
-		test $total_argc -eq 1 || usage
+		test $total_argc -eq 2 || usage
 		action=${1##--}
 		;;
 	--onto)
@@ -183,10 +215,10 @@ do
 		onto="$2"
 		shift
 		;;
-	-i|--interactive)
+	-i)
 		interactive_rebase=explicit
 		;;
-	-p|--preserve-merges)
+	-p)
 		preserve_merges=t
 		test -z "$interactive_rebase" && interactive_rebase=implied
 		;;
@@ -196,62 +228,42 @@ do
 	--no-autosquash)
 		autosquash=
 		;;
-	-M|-m|--m|--me|--mer|--merg|--merge)
+	-M|-m)
 		do_merge=t
 		;;
-	-X*|--strategy-option*)
-		case "$#,$1" in
-		1,-X|1,--strategy-option)
-			usage ;;
-		*,-X|*,--strategy-option)
-			newopt="$2"
-			shift ;;
-		*,--strategy-option=*)
-			newopt="$(expr " $1" : ' --strategy-option=\(.*\)')" ;;
-		*,-X*)
-			newopt="$(expr " $1" : ' -X\(.*\)')" ;;
-		1,*)
-			usage ;;
-		esac
-		strategy_opts="$strategy_opts $(git rev-parse --sq-quote "--$newopt")"
+	-X)
+		shift
+		strategy_opts="$strategy_opts $(git rev-parse --sq-quote "--$1")"
 		do_merge=t
 		test -z "$strategy" && strategy=recursive
 		;;
-	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
-		--strateg=*|--strategy=*|\
-	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
-		case "$#,$1" in
-		*,*=*)
-			strategy=`expr "z$1" : 'z-[^=]*=\(.*\)'` ;;
-		1,*)
-			usage ;;
-		*)
-			strategy="$2"
-			shift ;;
-		esac
+	-s)
+		shift
+		strategy="$1"
 		do_merge=t
 		;;
-	-n|--no-stat)
+	-n)
 		diffstat=
 		;;
 	--stat)
 		diffstat=t
 		;;
-	-v|--verbose)
+	-v)
 		verbose=t
 		diffstat=t
 		GIT_QUIET=
 		;;
-	-q|--quiet)
+	-q)
 		GIT_QUIET=t
 		git_am_opt="$git_am_opt -q"
 		verbose=
 		diffstat=
 		;;
-	--whitespace=*)
-		git_am_opt="$git_am_opt $1"
+	--whitespace)
+		shift
+		git_am_opt="$git_am_opt --whitespace=$1"
 		case "$1" in
-		--whitespace=fix|--whitespace=strip)
+		fix|strip)
 			force_rebase=t
 			;;
 		esac
@@ -263,22 +275,21 @@ do
 		git_am_opt="$git_am_opt $1"
 		force_rebase=t
 		;;
-	-C*)
-		git_am_opt="$git_am_opt $1"
+	-C)
+		shift
+		git_am_opt="$git_am_opt -C$1"
 		;;
 	--root)
 		rebase_root=t
 		;;
-	-f|--f|--fo|--for|--forc|--force|--force-r|--force-re|--force-reb|--force-reba|--force-rebas|--force-rebase|--no-ff)
+	-f|--no-ff)
 		force_rebase=t
 		;;
 	--rerere-autoupdate|--no-rerere-autoupdate)
 		allow_rerere_autoupdate="$1"
 		;;
-	-*)
-		usage
-		;;
-	*)
+	--)
+		shift
 		break
 		;;
 	esac
-- 
1.7.4.79.gcbe20
