Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2847CF1F
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590114; cv=none; b=Psrj/gnn8YMTsBonVtwOjregC51DGUMREAlldHRhKxiD0e02EXjS+O8UvhVawkRWxTVQWPZ2dpH1tYIEOGVy/TJu3F40EVO+XWs+cCEsA3aVAwXvJJAAgxSdt56yC17+cGY5WgxTFI15UYGYVA80loj/np2r2pkgvtpdj6Y5nbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590114; c=relaxed/simple;
	bh=YRvOwAZ2ttdsEoS3wi4Ds1ch9PxQWz5LT07Ui6DkUUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWPfrVY7A1Q0+TuY5X39yYKR25BAndRmm1NGe7t1YixzYMHOwe3fo/w0Kkcka19RKBvnMHg5tvr6Qud5Fe9lYyzupEWi1WtVA/6xA2AUVYrQ6JLJxt/9gcb1BZQDX1ThlolzhqBsk3CoKB6U9ITQnkrTjxADjqF4z/0WjPdz820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=QJhgxLV6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CfwcmZHE; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="QJhgxLV6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CfwcmZHE"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 01D7613800DB;
	Mon,  4 Mar 2024 17:08:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 04 Mar 2024 17:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709590110; x=1709676510; bh=N5U5Gldpudyii+FiklxfsUqBOnEVbbyi
	5H+udzI0X3Y=; b=QJhgxLV6yU4AgQdCRu6E8qf1RTWX6iEVvq4xNt+NKB25Flmg
	oB3kzdWXf6H/6UN+mHdfNLjRYlqjnZqsuR8qcEWQCLwlk1v4VDuC8iBI0K0kmk5r
	gkiQgJii3OE6B/N46DFEIiDeanSj02vkenuNaMhQPcdNGJjZmVsAYfQalnOwgIOu
	k+cuV+HpAzHqj5ccLkadiA2bxy4gw0v+/z7oGudTnqBU4O07H9Wsu9ZnDQhksVRX
	rU+sg0Lq+eNJcs/IC4HxhXd6MlMeXqWq4Xnat5OmXj2qJX29GZf90a8xZIB6dnfr
	lHSQMEG1OjIuSaKIF+HzmmXjEBBlq7mPUAw1lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709590110; x=
	1709676510; bh=N5U5Gldpudyii+FiklxfsUqBOnEVbbyi5H+udzI0X3Y=; b=C
	fwcmZHEtxFr2x0jrMAas3bWWe6DxDOXcLXGLXFDxaBaJzuPFoBlo8qDFZHmkMXhQ
	Zss5SXh43F4cnlmyT1tRc8KvhPjaUD3JOF8eUnfaUgQU1p3TMdtO0NuUszuRdOp/
	Ovp0GugQKWBmklWkS09MMWCL86CB1myDHW2YWH8b9AbHZNssj88F+7P67S+2FtGu
	lTjaEHW9nVIFDt0f8hgQ3Qeewt0v1vRqB+nBRUkLapNVc9l+0flUCczYEfQAq31j
	20Ryb5GoJlu11LtJXl+XQPOo4ITKwnJupUde81ZtrUqDNPW+EfIE8G9phbYVBxzP
	CSvX5Ces03mdFBu1c06XA==
X-ME-Sender: <xms:XkbmZZtxYytKVfKQF5FyiLKxyccCFgmnRU0gWp9yhKe1idG8_RNBH_k>
    <xme:XkbmZSe9Qj7IErarzkyxdh3qPO7Lmwx_rudyodbvHCbCndtkeMx1lSKgzlY7l9rJB
    LmSy8IwdBqbcsWCug>
X-ME-Received: <xmr:XkbmZczrr6FZXSUBt4qNcN9qGOQnDL-aJWWsex7LXD78wlTVjxuL4b8o8F3E4NqmsAvsInOSr0XAWchuZJQc_1DaTm0_GQhPVl8oEI2hfBQ-PPi2X7K5QtBR1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgf
    elveeikeegjeeikeeuvefhleeiuddvleegfeekjedtkeevtdetgfffveettdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:XkbmZQMatHJLW5uFC7EDgp9n83Mq2hI-zed75RJXltr7XABQSsAgZw>
    <xmx:XkbmZZ-JFXc5cvpqMHE4lUfSxnoOys2PWdtn_-CnQ6iE4c93XuJZlA>
    <xmx:XkbmZQUPS08XgkpS2-JEWoJ7N3b4wOmCKtnmZX5Ji4k0qSREQN4qbQ>
    <xmx:XkbmZUZwYgPrketRjxIbl0pcJKFq71LRjloa0Yr3wMkpZ4sA_AV17g>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 17:08:29 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/5] advice: make all entries stylistically consistent
Date: Mon,  4 Mar 2024 23:07:27 +0100
Message-ID: <d48b4719c275ef06da014b6d22983db9ae484db2.1709590037.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.64.g52b67adbeb2
In-Reply-To: <cover.1709590037.git.code@khaugsbakk.name>
References: <4ad5d4190649dcb5f26c73a6f15ab731891b9dfd.1709491818.git.code@khaugsbakk.name> <cover.1709590037.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: d48b4719c275ef06da014b6d22983db9ae484db2
Content-Transfer-Encoding: 8bit

1. Use “shown” instead of “advice shown”
   • “advice” is implied and a bit repetitive
2. Use “when” instead of “if”
3. Lead with “Shown when” and end the entry with the effect it has,
   where applicable
4. Use “the user” instead of “a user” or “you”
5. detachedHead: connect clause with a semicolon to make the sentence
   flow better in this new context
6. implicitIdentity: rewrite description in order to lead with *when*
   the advice is shown (see point (3))
7. Prefer the present tense (with the exception of pushNonFFMatching)
8. Use a colon to connect the last clause instead of a comma
9. waitingForEditor: give example of relevance in this new context
10. pushUpdateRejected: exception to the above principles

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Maybe the style that we eventually agree on should be documented outside the
    commit log?

 Documentation/config/advice.txt | 80 ++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index c7ea70f2e2e..cfca87a6aa2 100644
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
+		file: tell the location of the file.
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
+		to move to the detached HEAD state; instruct how to
 		create a local branch after the fact.
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
+		system username and domain name: tell the user how to
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
+		seconds to refresh the index after reset: tell the user
+		that they can use the `--no-refresh` option.
 	resolveConflict::
-		Advice shown by various commands when conflicts
+		Shown by various commands when conflicts
 		prevent the operation from being performed.
 	rmHints::
-		In case of failure in the output of linkgit:git-rm[1],
-		show directions on how to proceed from the current state.
+		Shown on failure in the output of linkgit:git-rm[1]:
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
+		seconds to enumerate untracked files: consider using the
+		`-u` option.
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
+		invalid reference: instruct how to create a new unborn
 		branch instead.
 --
-- 
2.44.0.64.g52b67adbeb2

