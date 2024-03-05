Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D07913AEE
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670669; cv=none; b=kIY8w5Iyvy98pJRv10Dh4NInU+pgeC36pzdnOsNbdYxx404IIZFCYI+pEJ8xvhJQoov6qzZ4WYDU+WhBptJrNqzz8LNAkZjBj55pwIvgUCuKLKNSjI8AYettGCl3lyqanJzQoY6s8FF492mBu6o687T7qe9BbLi2qg8R7oPjws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670669; c=relaxed/simple;
	bh=FfgfCI9WPjP5TBKurj/YNllHNEDfCnhMc1AJFjCNoas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ew9s0QYbmhL1HwdTdkLOBP66bTfAAYHwW06iXrdDBISdN0U48S2p4e+vPWWhj4EuADjb4sLMoAcHCT1Ik3McwiS/6VGGEHpy6huVtYhpa4WYwy8esDO3EMhHAMdo2VbhXvhaspHE6BVfGaprYWWC2gh9DzKdD1aUnjnCsDFZjog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=ynvozkD3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d4YoigxZ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="ynvozkD3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d4YoigxZ"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 54C821380157;
	Tue,  5 Mar 2024 15:31:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 05 Mar 2024 15:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709670666; x=1709757066; bh=smTu+nKf9yy3eaePT/50ftaKWvg77rUX
	Wpb4w6osiZY=; b=ynvozkD3tuLhGJ3Tl4ocqk600uDgk9a/DAozB8xHxXwocJZy
	qEgRdaaO+/2/mchFnrgDnoGGjoREzedD1QnSfhtacUbutBIxOlwgWX5xvMLSI1/Q
	/cdhpOmBLOWbMImhrIVF1i5lFNGL9nVhvvIF/1vknefrhW1inA/0Re/hTmlT4D1I
	Uxip7Y/lnL9YD2cEC16xThjxL9M8Bw9aL/Y1J+u0FPyQkKlvPlU6L51qmBcp90da
	uyuiqctG3iEJ9euL1Mh3fn2ftmNrqA02XW54KkJyA/rgvgPs1D0JRrzXRqOrGZ9b
	+CM94QAJzJUBun6RpX4T6uEXGS28uJWF2kHnlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709670666; x=
	1709757066; bh=smTu+nKf9yy3eaePT/50ftaKWvg77rUXWpb4w6osiZY=; b=d
	4YoigxZGXDt97XVE4y9SdZWOcgBZgRk6oPDc9QoGPJ2mdqqTplW1j/bvdVJzELtF
	eHuBGZYySMDPAEbrMekwefEWpq6ElkYbJNvzUngAOwpugMFUE6aDwO3TRMebpgYz
	l/aRRNiJ0ucxvkZ4HL+79byr+eIVsoHxvRsokZM7Q4npD2+iX/CFsaHE1z36s75E
	eaDQwWmsHR3+uX0g1i5d5pkoFEXYXwuPbx7j8HH2ViaC+J69lFAEziY5vNtD4ldy
	YkA/ca30Y4zW9ZyiAJwq3QxerWqWam99FNzYOyYUXPgqWl422WKppbvyWm1SGkr3
	2XzJRS4Yo2XhYDJF3xu2Q==
X-ME-Sender: <xms:CoHnZcZwPSJTVDFNaGR3JACFCskLI1WNdAnFGk_yjeyFnMQ5uBwG5Ag>
    <xme:CoHnZXYE-bnU6Ok5nvGWnce934nZRINYDNdG1QPA7J2yP79lcrKM0kb8ixCEo4eEI
    EZw4ulOSCyFXdHG8w>
X-ME-Received: <xmr:CoHnZW9CMVGH8CzHF8UfesktaUpmkVduex3uL2InVxceowTgMEJI0Y5hYgHDqbhAOdb0bDEPIhhFkcat0fEJJG8HGF-Y5CQPA-ze2qzvGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgf
    elveeikeegjeeikeeuvefhleeiuddvleegfeekjedtkeevtdetgfffveettdenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:CoHnZWpv4JibX4UB0kieX-146BKRflB4xM3tWasLUwKYRzatc6De8A>
    <xmx:CoHnZXpwpJnA_tYN4Jkhv7YiDomUI6vHzvzsWzVb0mRHfpok_jMTvw>
    <xmx:CoHnZUQccCVXe2ZoDISBEkF79mwPgvQF-wHsVtayxd0Fhui7ATP0CA>
    <xmx:CoHnZe1Se7TWQg6RQvleKYo7VFgVg7XyTjNw3md_ayM5GjvoIJPJPA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Mar 2024 15:31:05 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v4 2/5] advice: make all entries stylistically consistent
Date: Tue,  5 Mar 2024 21:29:40 +0100
Message-ID: <7017ff3fff773412e8c472d8e59a132b0e8faae7.1709670287.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.64.g52b67adbeb2
In-Reply-To: <cover.1709670287.git.code@khaugsbakk.name>
References: <cover.1709590037.git.code@khaugsbakk.name> <cover.1709670287.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 7017ff3fff773412e8c472d8e59a132b0e8faae7
X-Previous-Commits: d48b4719c275ef06da014b6d22983db9ae484db2
Content-Transfer-Encoding: 8bit

In general, rewrite entries to the following form:

1. Clause or sentence describing when the advice is shown
2. Optional “to <verb>” clause which says what the advice is
   about (e.g. for resetNoRefresh: tell the user that they can use
   `--no-refresh`)

Concretely:

1. Use “shown” instead of “advice shown”
   • “advice” is implied and a bit repetitive
2. Use “when” instead of “if”
3. Lead with “Shown when” and end the entry with the effect it has,
   where applicable
4. Use “the user” instead of “a user” or “you”
5. implicitIdentity: rewrite description in order to lead with *when*
   the advice is shown (see point (3))
6. Prefer the present tense (with the exception of pushNonFFMatching)
7. waitingForEditor: give example of relevance in this new context
8. pushUpdateRejected: exception to the above principles

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4:
    • Drop trailer since this took on a life of its own
    • Drop uses of colons and semicolons in favor of a “to <verb>”
      clause (mostly “to tell”)
    • Simplify some of the “effect clauses” by using “to tell” instead of
      verbs like “instruct”
    v3:
    • Comment: Maybe the style that we eventually agree on should be
      documented outside the commit log?

 Documentation/config/advice.txt | 82 ++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index c7ea70f2e2e..72cd9f9e9d9 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -6,23 +6,23 @@ advice.*::
 +
 --
 	addEmbeddedRepo::
-		Advice on what to do when you've accidentally added one
+		Shown when the user accidentally adds one
 		git repo inside of another.
 	addEmptyPathspec::
-		Advice shown if a user runs the add command without providing
+		Shown when the user runs the add command without providing
 		the pathspec parameter.
 	addIgnoredFile::
-		Advice shown if a user attempts to add an ignored file to
+		Shown when the user attempts to add an ignored file to
 		the index.
 	amWorkDir::
-		Advice that shows the location of the patch file when
-		linkgit:git-am[1] fails to apply it.
+		Shown when linkgit:git-am[1] fails to apply a patch
+		file, to tell the user the location of the file.
 	ambiguousFetchRefspec::
-		Advice shown when a fetch refspec for multiple remotes maps to
+		Shown when a fetch refspec for multiple remotes maps to
 		the same remote-tracking branch namespace and causes branch
 		tracking set-up to fail.
 	checkoutAmbiguousRemoteBranchName::
-		Advice shown when the argument to
+		Shown when the argument to
 		linkgit:git-checkout[1] and linkgit:git-switch[1]
 		ambiguously resolves to a
 		remote tracking branch on more than one remote in
@@ -33,31 +33,31 @@ advice.*::
 		to be used by default in some situations where this
 		advice would be printed.
 	commitBeforeMerge::
-		Advice shown when linkgit:git-merge[1] refuses to
+		Shown when linkgit:git-merge[1] refuses to
 		merge to avoid overwriting local changes.
 	detachedHead::
-		Advice shown when you used
+		Shown when the user uses
 		linkgit:git-switch[1] or linkgit:git-checkout[1]
-		to move to the detached HEAD state, to instruct how to
-		create a local branch after the fact.
+		to move to the detached HEAD state, to tell the user how
+		to create a local branch after the fact.
 	diverging::
-		Advice shown when a fast-forward is not possible.
+		Shown when a fast-forward is not possible.
 	fetchShowForcedUpdates::
-		Advice shown when linkgit:git-fetch[1] takes a long time
+		Shown when linkgit:git-fetch[1] takes a long time
 		to calculate forced updates after ref updates, or to warn
 		that the check is disabled.
 	forceDeleteBranch::
-		Advice shown when a user tries to delete a not fully merged
+		Shown when the user tries to delete a not fully merged
 		branch without the force option set.
 	ignoredHook::
-		Advice shown if a hook is ignored because the hook is not
+		Shown when a hook is ignored because the hook is not
 		set as executable.
 	implicitIdentity::
-		Advice on how to set your identity configuration when
-		your information is guessed from the system username and
-		domain name.
+		Shown when the user's information is guessed from the
+		system username and domain name, to tell the user how to
+		set their identity configuration.
 	nestedTag::
-		Advice shown if a user attempts to recursively tag a tag object.
+		Shown when a user attempts to recursively tag a tag object.
 	pushAlreadyExists::
 		Shown when linkgit:git-push[1] rejects an update that
 		does not qualify for fast-forwarding (e.g., a tag.)
@@ -71,12 +71,12 @@ advice.*::
 		object that is not a commit-ish, or make the remote
 		ref point at an object that is not a commit-ish.
 	pushNonFFCurrent::
-		Advice shown when linkgit:git-push[1] fails due to a
+		Shown when linkgit:git-push[1] fails due to a
 		non-fast-forward update to the current branch.
 	pushNonFFMatching::
-		Advice shown when you ran linkgit:git-push[1] and pushed
-		'matching refs' explicitly (i.e. you used ':', or
-		specified a refspec that isn't your current branch) and
+		Shown when the user ran linkgit:git-push[1] and pushed
+		'matching refs' explicitly (i.e. used ':', or
+		specified a refspec that isn't the current branch) and
 		it resulted in a non-fast-forward error.
 	pushRefNeedsUpdate::
 		Shown when linkgit:git-push[1] rejects a forced update of
@@ -95,17 +95,17 @@ advice.*::
 		'pushFetchFirst', 'pushNeedsForce', and 'pushRefNeedsUpdate'
 		simultaneously.
 	resetNoRefresh::
-		Advice to consider using the `--no-refresh` option to
-		linkgit:git-reset[1] when the command takes more than 2 seconds
-		to refresh the index after reset.
+		Shown when linkgit:git-reset[1] takes more than 2
+		seconds to refresh the index after reset, to tell the user
+		that they can use the `--no-refresh` option.
 	resolveConflict::
-		Advice shown by various commands when conflicts
+		Shown by various commands when conflicts
 		prevent the operation from being performed.
 	rmHints::
-		In case of failure in the output of linkgit:git-rm[1],
-		show directions on how to proceed from the current state.
+		Shown on failure in the output of linkgit:git-rm[1], to
+		give directions on how to proceed from the current state.
 	sequencerInUse::
-		Advice shown when a sequencer command is already in progress.
+		Shown when a sequencer command is already in progress.
 	skippedCherryPicks::
 		Shown when linkgit:git-rebase[1] skips a commit that has already
 		been cherry-picked onto the upstream branch.
@@ -123,27 +123,27 @@ advice.*::
 		by linkgit:git-switch[1] or
 		linkgit:git-checkout[1] when switching branches.
 	statusUoption::
-		Advise to consider using the `-u` option to linkgit:git-status[1]
-		when the command takes more than 2 seconds to enumerate untracked
-		files.
+		Shown when linkgit:git-status[1] takes more than 2
+		seconds to enumerate untracked files, to tell the user that
+		they can use the `-u` option.
 	submoduleAlternateErrorStrategyDie::
-		Advice shown when a submodule.alternateErrorStrategy option
+		Shown when a submodule.alternateErrorStrategy option
 		configured to "die" causes a fatal error.
 	submodulesNotUpdated::
-		Advice shown when a user runs a submodule command that fails
+		Shown when a user runs a submodule command that fails
 		because `git submodule update --init` was not run.
 	suggestDetachingHead::
-		Advice shown when linkgit:git-switch[1] refuses to detach HEAD
+		Shown when linkgit:git-switch[1] refuses to detach HEAD
 		without the explicit `--detach` option.
 	updateSparsePath::
-		Advice shown when either linkgit:git-add[1] or linkgit:git-rm[1]
+		Shown when either linkgit:git-add[1] or linkgit:git-rm[1]
 		is asked to update index entries outside the current sparse
 		checkout.
 	waitingForEditor::
-		Print a message to the terminal whenever Git is waiting for
-		editor input from the user.
+		Shown when Git is waiting for editor input. Relevant
+		when e.g. the editor is not launched inside the terminal.
 	worktreeAddOrphan::
-		Advice shown when a user tries to create a worktree from an
-		invalid reference, to instruct how to create a new unborn
+		Shown when the user tries to create a worktree from an
+		invalid reference, to tell the user how to create a new unborn
 		branch instead.
 --
-- 
2.44.0.64.g52b67adbeb2

