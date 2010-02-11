From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [RFC] submodule+shallow clone feature request
Date: Wed, 10 Feb 2010 22:19:42 -0800
Message-ID: <7v8wb0l2f5.fsf@alter.siamese.dyndns.org>
References: <4B73277C.9010801@columbia.edu>
 <7vsk983fi4.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1002102354010.20986@pacific.mpi-cbg.de>
 <7v1vgszo16.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1002110057180.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Schuyler Duveen <sky@columbia.edu>, git@vger.kernel.org,
	Peter Hutterer <peter.hutterer@who-t.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 11 07:20:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfSPH-0005eJ-Iy
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 07:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513Ab0BKGT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 01:19:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63280 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab0BKGT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 01:19:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 939DC981D9;
	Thu, 11 Feb 2010 01:19:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=r8SGNAd+jcJiQcAVIBAPZh/tKyc=; b=U68aHCeJ067fsZe6LfOlaVB
	QiK5T1iFjA1XkV2A7UZVOdxVoxfiaYrTcbgv1zFCYSxWb7KNC6iOXEKqkgkKnWH6
	FZRa7byl/N9PVbnqNk8G4OtI3sTeh7lqz6Da5D+ljtMnKgTr6ZPgdXKeE6HZTgw8
	gC4SRcHRCGnv/5zhNZss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=OoJfz8FHV880KUpSJqhcLja/8uRxOLtoL5zh8StL1QSI3yYEO
	QZAgk1iMs0TTmQh1MLIIYV+VOiI5mK1KgIT9NF82JnH/+phKtWU3G0WomA1N+7a9
	KMCUinq7QxBnCYTA5PPFVm+Cm1UQhZ0ehyHQzWsgjcX6AnN2rn4ocO3ZDs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 46F3F981D7;
	Thu, 11 Feb 2010 01:19:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCA49981D3; Thu, 11 Feb
 2010 01:19:43 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7515F29C-16D5-11DF-BA38-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139574>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 10 Feb 2010, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > Yes. Note, though, that the problems of enhancing git-submodule are 
>> > not technical, as we can learn from the recent history, including the 
>> > lack of support for rebasing submodules (there _were_ patches!).
>> 
>> Sorry I don't recall.  Were they of 'next' quality?  How well were they 
>> reviewed?
>
> Obviously not, otherwise you would have applied them, no?
>
> OTOH I found the technical details rather trivial, so maybe they were 
> 'next' quality, but there was another reason you did not apply them.

Well, I spent some time digging the mail archive myself.  I think you were
talking about this thread:

    http://thread.gmane.org/gmane.comp.version-control.git/116918

If this is not the thread you were talking about, please discard/disregard
the remainder of this message, and give me a better pointer instead.

The thread ends with you asking me:

    Junio, how about it? post 1.6.3 or not?  It is a well contained change, 
    with little chance of breaking something, but offers a more sensible 
    workflow here.

and I said:

    I am afraid it is a bit too late for "improvements" after -rc1.
    People survived without the new feature until now, and they can wait a
    bit longer for the next one....

Obviously, after that nothing happened.  We have some people who send
reminders for good topics after the original thread died without producing
a visible result.  I'd ask you to do the same (when you can---as everybody
else, you don't work full time on git; neither do I).

An honest answer to my question would have been "Yes, I reviewed it and
mentored the original author through a few cycles of revisions.  After
that process the patch was of 'next' quality.  This however happened
during the pre-release freeze, and unfortunately nobody (including you or
I) rememebered to bring up the issue again after the release to move
things forward.  It fell through cracks."

Instead, what you wrote makes it sounds as if I blocked a technically
correct solution to a real problem on some political grounds, doesn't it?
What effect did you hope your insinuation to have on readers of this list?

It does not help to give a new person a false impression that it takes
more than producing a good solution to a real problem to contribute to the
project.  Especially, the "falling through the crack" didn't have anything
to do with it being submodule changes.  Please stop spreading FUD and try
to be constructive as others do.

To restart the discussion so that we can have it (if it is a good change)
after 1.7.0 ships, here is a pointer to the last revision of the patch.

    http://article.gmane.org/gmane.comp.version-control.git/117394/raw

I didn't check if it needs rebasing to the recent codebase, but I expect
people who work with submodules in real life (I don't count) to comment on
it, and re-polish it into an applicable shape if necessary, by the time
post 1.7.0 cycle opens.

-- >8 --
From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH/RESEND] git-submodule: add support for --rebase.
Date: Fri, 24 Apr 2009 09:06:38 +1000

'git submodule update --rebase' rebases your local branch on top of what
would have been checked out to a detached HEAD otherwise.

In some cases, detaching the HEAD when updating a submodule complicates
the workflow to commit to this submodule (checkout master, rebase, then
commit).  For submodules that require frequent updates but infrequent
(if any) commits, a rebase can be executed directly by the git-submodule
command, ensuring that the submodules stay on their respective branches.

git-config key: submodule.$name.rebase (bool)

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

> With this squashed in, I actually would not be too opposed to put this 
> into 1.6.3, as it _is_ an improvement.
> 
> -- snipsnap --
> [PATCH] To be squashed in
> 
> This does three things:
> 
> - add .gitmodules support for rebase,
> - use --bool for the git config calls for type checking, and
> - rename ambiguous t7404 to t7406.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Squashed in, thank you. One typo fixed in last testcase (does-not-mater ->
does-not-matter).

 Documentation/git-submodule.txt |   14 ++++-
 Documentation/gitmodules.txt    |    3 +
 git-submodule.sh                |   33 ++++++++-
 t/t7406-submodule-update.sh     |  140 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 184 insertions(+), 6 deletions(-)
 create mode 100755 t/t7406-submodule-update.sh

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 3b8df44..0286409 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git submodule' [--quiet] add [-b branch] [--] <repository> <path>
 'git submodule' [--quiet] status [--cached] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
-'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--] [<path>...]
+'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase] [--] [<path>...]
 'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach <command>
 'git submodule' [--quiet] sync [--] [<path>...]
@@ -113,7 +113,8 @@ init::
 update::
 	Update the registered submodules, i.e. clone missing submodules and
 	checkout the commit specified in the index of the containing repository.
-	This will make the submodules HEAD be detached.
+	This will make the submodules HEAD be detached unless '--rebase' is
+	specified or the key `submodule.$name.rebase` is set to `true`.
 +
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
@@ -177,6 +178,15 @@ OPTIONS
 	This option is only valid for the update command.
 	Don't fetch new objects from the remote site.
 
+--rebase::
+	This option is only valid for the update command.
+	Rebase the current branch onto the commit recorded in the
+	superproject. If this option is given, the submodule's HEAD will not
+	be detached. If a a merge failure prevents this process, you will have
+	to resolve these failures with linkgit:git-rebase[1].
+	If the key `submodule.$name.rebase` is set to `true`, this option is
+	implicit.
+
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
 	to only operate on the submodules found at the specified paths.
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index d1a17e2..7c22c40 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -30,6 +30,9 @@ submodule.<name>.path::
 submodule.<name>.url::
 	Defines an url from where the submodule repository can be cloned.
 
+submodule.<name>.rebase::
+	Defines that the submodule should be rebased by default.
+
 
 EXAMPLES
 --------
diff --git a/git-submodule.sh b/git-submodule.sh
index 7c2e060..b7c9bdc 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -17,6 +17,7 @@ branch=
 quiet=
 cached=
 nofetch=
+rebase=
 
 #
 # print stuff on stdout unless -q was specified
@@ -287,6 +288,11 @@ cmd_init()
 		git config submodule."$name".url "$url" ||
 		die "Failed to register url for submodule path '$path'"
 
+		test true != "$(git config -f .gitmodules --bool \
+			submodule."$name".rebase)" ||
+		git config submodule."$name".rebase true ||
+		die "Failed to register submodule path '$path' as rebasing"
+
 		say "Submodule '$name' ($url) registered for path '$path'"
 	done
 }
@@ -314,6 +320,10 @@ cmd_update()
 			shift
 			nofetch=1
 			;;
+		-r|--rebase)
+			shift
+			rebase=true
+			;;
 		--)
 			shift
 			break
@@ -332,6 +342,7 @@ cmd_update()
 	do
 		name=$(module_name "$path") || exit
 		url=$(git config submodule."$name".url)
+		rebase_module=$(git config --bool submodule."$name".rebase)
 		if test -z "$url"
 		then
 			# Only mention uninitialized submodules when its
@@ -352,6 +363,11 @@ cmd_update()
 			die "Unable to find current revision in submodule path '$path'"
 		fi
 
+		if test true = "$rebase"
+		then
+			rebase_module=true
+		fi
+
 		if test "$subsha1" != "$sha1"
 		then
 			force=
@@ -367,11 +383,20 @@ cmd_update()
 				die "Unable to fetch in submodule path '$path'"
 			fi
 
-			(unset GIT_DIR; cd "$path" &&
-				  git-checkout $force -q "$sha1") ||
-			die "Unable to checkout '$sha1' in submodule path '$path'"
+			if test true = "$rebase_module"
+			then
+				command="git-rebase"
+				action="rebase"
+				msg="rebased onto"
+			else
+				command="git-checkout $force -q"
+				action="checkout"
+				msg="checked out"
+			fi
 
-			say "Submodule path '$path': checked out '$sha1'"
+			(unset GIT_DIR; cd "$path" && $command "$sha1") ||
+			die "Unable to $action '$sha1' in submodule path '$path'"
+			say "Submodule path '$path': $msg '$sha1'"
 		fi
 	done
 }
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
new file mode 100755
index 0000000..3442c05
--- /dev/null
+++ b/t/t7406-submodule-update.sh
@@ -0,0 +1,140 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Red Hat, Inc.
+#
+
+test_description='Test updating submodules
+
+This test verifies that "git submodule update" detaches the HEAD of the
+submodule and "git submodule update --rebase" does not detach the HEAD.
+'
+
+. ./test-lib.sh
+
+
+compare_head()
+{
+    sha_master=`git-rev-list --max-count=1 master`
+    sha_head=`git-rev-list --max-count=1 HEAD`
+
+    test "$sha_master" = "$sha_head"
+}
+
+
+test_expect_success 'setup a submodule tree' '
+	echo file > file &&
+	git add file &&
+	test_tick &&
+	git commit -m upstream
+	git clone . super &&
+	git clone super submodule &&
+	(cd super &&
+	 git submodule add ../submodule submodule &&
+	 test_tick &&
+	 git commit -m "submodule" &&
+	 git submodule init submodule
+	) &&
+	(cd submodule &&
+	echo "line2" > file &&
+	git add file &&
+	git commit -m "Commit 2"
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  git pull --rebase origin
+	 ) &&
+	 git add submodule &&
+	 git commit -m "submodule update"
+	)
+'
+
+test_expect_success 'submodule update detaching the HEAD ' '
+	(cd super/submodule &&
+	 git reset --hard HEAD~1
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update submodule &&
+	 cd submodule &&
+	 ! compare_head
+	)
+'
+
+test_expect_success 'submodule update --rebase staying on master' '
+	(cd super/submodule &&
+	  git checkout master
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update --rebase submodule &&
+	 cd submodule &&
+	 compare_head
+	)
+'
+
+test_expect_success 'submodule update - rebase true in .git/config' '
+	(cd super &&
+	 git config submodule.submodule.rebase true
+	) &&
+	(cd super/submodule &&
+	  git reset --hard HEAD~1
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update submodule &&
+	 cd submodule &&
+	 compare_head
+	)
+'
+
+test_expect_success 'submodule update - rebase false in .git/config but --rebase given' '
+	(cd super &&
+	 git config submodule.submodule.rebase false
+	) &&
+	(cd super/submodule &&
+	  git reset --hard HEAD~1
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update --rebase submodule &&
+	 cd submodule &&
+	 compare_head
+	)
+'
+
+test_expect_success 'submodule update - rebase false in .git/config' '
+	(cd super &&
+	 git config submodule.submodule.rebase false
+	) &&
+	(cd super/submodule &&
+	  git reset --hard HEAD^
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update submodule &&
+	 cd submodule &&
+	 ! compare_head
+	)
+'
+
+test_expect_success 'submodule init picks up rebase' '
+	(cd super &&
+	 git config submodule.rebasing.url git://non-existing/git &&
+	 git config submodule.rebasing.path does-not-matter &&
+	 git config submodule.rebasing.rebase true &&
+	 git submodule init rebasing &&
+	 test true = $(git config --bool submodule.rebasing.rebase)
+	)
+'
+
+test_done
-- 
1.6.3.rc1.2.gfa66a
