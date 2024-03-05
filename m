Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E554A134BD
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670667; cv=none; b=KNKNcq6KGgV6LeRKf+vw5EGQHmi0ng1xYsUnw8efBQS6ro89C9SD4xm0GIf2i9MqjsUoLtJ+rek7tfLAeug6X4FP92C1QNKkSZP9uKFgdMBGUMvOis30ISyYjEuf3xDX8J47UE0NiKibbqlq69uwXwHG5GF4nRn9etrkW7/4k5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670667; c=relaxed/simple;
	bh=/ce9Vm4Gyoy1Pvs1ptDZON/tUkkgDWsIkwci08JDhmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8wrwYDRRRRoyYjR7lxdKEiNCNwkuMhX5PTqQ+eex1vgO2wWujEENRkhg3gP2Nw99VTqdhgbNZiU8XzH2SHTRA6leD3DupSwFetTlf/vBFnB6LRUFcjM1bdHyb2f4YDshGEnKPsw4rhmi1BkaSKNuwxxwgPOt5h7p5lsQXo3w9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=H8Nbg7Qp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kcVmQBKA; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="H8Nbg7Qp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kcVmQBKA"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id E9F03138012C;
	Tue,  5 Mar 2024 15:31:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 05 Mar 2024 15:31:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709670663; x=1709757063; bh=8MXaT/OVksqV05ZKW/AAQumPcoviJlpd
	KnxFGBtSO9k=; b=H8Nbg7QpMw8imDTwLB+K2xQOBtk6TsUCXg7NlZn9xrji6MDK
	aTY6oFDWRKe7ZR3LmpK2pcahRoEnv08kVEPvabxXYm0vWr6/gXqM9Vufzq1vRDHX
	aUU2Z+YQpiyIUR7KVJY7Pu9Aw21z6fpTQ/QZEqoqUWGKj6arHCRtaSg8bsawH8Up
	6mnzjAoDVxSWbePjt3Bn05yMGDqYyy3pz+hEXMbqpukXq+eupIV+20XqXQ554BaZ
	t+U6ImZ7XN6b5FlnVo7WEem9OEcWvqGG0YSnLgFrThFM0Ipu8CZQ1nkHSw9ffc7c
	x4HKOPAG040BqOmrt4De5VWrbX2MTZ6yJeyu0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709670663; x=
	1709757063; bh=8MXaT/OVksqV05ZKW/AAQumPcoviJlpdKnxFGBtSO9k=; b=k
	cVmQBKAJ5es6yaDGLWM66rEPzGT0v112HbOm9PrQygQMaY0GZMbP1iTi316sXHFs
	TXMkXx8cG/DAMzRvMupJIWcpK/gL/d6Hgfbm3ws04C1y2ZK3vi9vWYN6SqcrHW09
	69wrQy0Wwc5+fjqDkbvo2xYpvD6U/klLl6pGSvu0oEPOfvdnt0fUhQeI7CK1esL1
	+K7Lm3dA0EyqbwzIsq5/sSW6n2Ty6U31rjqxOJo3oPNeHqvoVCGLzdoAZRe9nAEK
	M/bbNLIfiN+lwHk5ROsHp7aWMt1yHSSeGXq+ijyZrmgaw+COaSYDVXWKYZ08mPHT
	m33G7rmHIp0BBKzp+cVxQ==
X-ME-Sender: <xms:B4HnZTRPdglml1s8TF5kU_CwRYM0-O6_fJXzRkdlzs1ZsaIpju6ASIQ>
    <xme:B4HnZUyNbrafVH0v-Coh-c7qEWQ8yZY07BnM6_b07wIuQUtDKDCCiui9n1-FCyjWb
    6fF5lCDF_1Q1YCNsw>
X-ME-Received: <xmr:B4HnZY3JdCGZgewpqynoi3m6dmf0xkR_1aZdywz-lJIoxPIAq_w5qc8gW0D5OybM5GhUXuxT1iUllv0S6CVQi9xi3vUXb4DwpJHf-MDcLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepvefgleevieekgeejieekueevhfelieduvdel
    geefkeejtdekvedttefgffevtedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:B4HnZTDrrYR01issu8SWeawTXGtjsMf4l8VJHqj3UoAIQL2K25umOg>
    <xmx:B4HnZcgH3mvlzCaZQCbfppScL2ubtxhpJceh1miYGMNq_UvVPPihXA>
    <xmx:B4HnZXqczYV_XLlyusjM8GFwwrhSM-rvF-59TadM6LE0fOvy0-kyiw>
    <xmx:B4HnZUeT9xHJDPMHtuQu4mA7prxoC0AKsMNfDsrHvSj1qREa-ttzXQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Mar 2024 15:31:01 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>
Subject: [PATCH v4 0/5] advise about ref syntax rules
Date: Tue,  5 Mar 2024 21:29:38 +0100
Message-ID: <cover.1709670287.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.64.g52b67adbeb2
In-Reply-To: <cover.1709590037.git.code@khaugsbakk.name>
References: <cover.1709590037.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Point the user towards the ref/branch name syntax rules if they give an
invalid name.

Also make some spatially-appropriate improvements:

• Test style
• `advice.txt`

§ git-replace(1)

(see cover letter for v2)

§ Alternatives (to this change)

While working on this I also thought that it might be nice to have a
man page `gitrefsyntax`. That one could use a lot of the content from
`man git check-ref-format` verbatim. Then the hint could point towards
that man page. And it seems that AsciiDoc supports _includes_ which
means that the rules don’t have to be duplicated between the two man
pages.

§ CC

For changes to `advice.txt`:

Cc: Elijah Newren <newren@gmail.com>
Cc: Jean-Noël Avila <avila.jn@gmail.com>

§ Changes in v4

Mostly about the style rewrite in `advice.txt`.

• Patch 1:
  • Drop `(setup)` change
  • Drop superflouos bullet point
  • Don’t use period to end bullet point
• Patch 2:
  • Drop trailer since this took on a life of its own
  • Drop uses of colons and semicolons in favor of a “to <verb>”
    clause (mostly “to tell”)
  • Simplify some of the “effect clauses” by using “to tell” instead of
    verbs like “instruct”
• Patch 3:
  • Also quote ref globs
• Patch 5:
  • Update refSyntax entry for consistency with the rest of the entries

Kristoffer Haugsbakk (5):
  t3200: improve test style
  advice: make all entries stylistically consistent
  advice: use backticks for verbatim
  advice: use double quotes for regular quoting
  branch: advise about ref syntax rules

 Documentation/config/advice.txt |  95 ++++++++++++------------
 advice.c                        |   1 +
 advice.h                        |   1 +
 branch.c                        |   8 ++-
 builtin/branch.c                |   8 ++-
 t/t3200-branch.sh               | 123 +++++++++++++++++---------------
 6 files changed, 128 insertions(+), 108 deletions(-)

Range-diff against v3:
1:  e6a2628ce57 ! 1:  ad101c72a60 t3200: improve test style
    @@ Commit message
         Also:
     
         • Remove a now-irrelevant comment about test placement and switch back
    -      to `main` post-test.
    +      to `main` post-test
         • Prefer indented literal heredocs (`-\EOF`) except for a block which
           says that this is intentional
    -    • Move a `git config` command into the test and mark it as `setup` since
    -      the next test depends on it
     
         Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    +
    + ## Notes (series) ##
    +    v4:
    +    • Drop `(setup)` change
    +    • Drop superflouos bullet point
    +    • Don’t use period to end bullet point
    +
      ## t/t3200-branch.sh ##
     @@ t/t3200-branch.sh: test_expect_success 'git branch HEAD should fail' '
      	test_must_fail git branch HEAD
    @@ t/t3200-branch.sh: test_expect_success 'git branch -v with column.ui ignored' '
     -
     -git config branch.s/s.dummy Hello
     -
    --test_expect_success 'git branch -m s/s s should work when s/t is deleted' '
    -+test_expect_success '(setup) git branch -m s/s s should work when s/t is deleted' '
    + test_expect_success 'git branch -m s/s s should work when s/t is deleted' '
     +	git config branch.s/s.dummy Hello &&
      	git branch --create-reflog s/s &&
      	git reflog exists refs/heads/s/s &&
2:  d48b4719c27 ! 2:  7017ff3fff7 advice: make all entries stylistically consistent
    @@ Metadata
      ## Commit message ##
         advice: make all entries stylistically consistent
     
    +    In general, rewrite entries to the following form:
    +
    +    1. Clause or sentence describing when the advice is shown
    +    2. Optional “to <verb>” clause which says what the advice is
    +       about (e.g. for resetNoRefresh: tell the user that they can use
    +       `--no-refresh`)
    +
    +    Concretely:
    +
         1. Use “shown” instead of “advice shown”
            • “advice” is implied and a bit repetitive
         2. Use “when” instead of “if”
         3. Lead with “Shown when” and end the entry with the effect it has,
            where applicable
         4. Use “the user” instead of “a user” or “you”
    -    5. detachedHead: connect clause with a semicolon to make the sentence
    -       flow better in this new context
    -    6. implicitIdentity: rewrite description in order to lead with *when*
    +    5. implicitIdentity: rewrite description in order to lead with *when*
            the advice is shown (see point (3))
    -    7. Prefer the present tense (with the exception of pushNonFFMatching)
    -    8. Use a colon to connect the last clause instead of a comma
    -    9. waitingForEditor: give example of relevance in this new context
    -    10. pushUpdateRejected: exception to the above principles
    +    6. Prefer the present tense (with the exception of pushNonFFMatching)
    +    7. waitingForEditor: give example of relevance in this new context
    +    8. pushUpdateRejected: exception to the above principles
     
    -    Suggested-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    -    Maybe the style that we eventually agree on should be documented outside the
    -    commit log?
    +    v4:
    +    • Drop trailer since this took on a life of its own
    +    • Drop uses of colons and semicolons in favor of a “to <verb>”
    +      clause (mostly “to tell”)
    +    • Simplify some of the “effect clauses” by using “to tell” instead of
    +      verbs like “instruct”
    +    v3:
    +    • Comment: Maybe the style that we eventually agree on should be
    +      documented outside the commit log?
     
      ## Documentation/config/advice.txt ##
     @@ Documentation/config/advice.txt: advice.*::
    @@ Documentation/config/advice.txt: advice.*::
     -		Advice that shows the location of the patch file when
     -		linkgit:git-am[1] fails to apply it.
     +		Shown when linkgit:git-am[1] fails to apply a patch
    -+		file: tell the location of the file.
    ++		file, to tell the user the location of the file.
      	ambiguousFetchRefspec::
     -		Advice shown when a fetch refspec for multiple remotes maps to
     +		Shown when a fetch refspec for multiple remotes maps to
    @@ Documentation/config/advice.txt: advice.*::
     +		Shown when the user uses
      		linkgit:git-switch[1] or linkgit:git-checkout[1]
     -		to move to the detached HEAD state, to instruct how to
    -+		to move to the detached HEAD state; instruct how to
    - 		create a local branch after the fact.
    +-		create a local branch after the fact.
    ++		to move to the detached HEAD state, to tell the user how
    ++		to create a local branch after the fact.
      	diverging::
     -		Advice shown when a fast-forward is not possible.
     +		Shown when a fast-forward is not possible.
    @@ Documentation/config/advice.txt: advice.*::
     -		your information is guessed from the system username and
     -		domain name.
     +		Shown when the user's information is guessed from the
    -+		system username and domain name: tell the user how to
    ++		system username and domain name, to tell the user how to
     +		set their identity configuration.
      	nestedTag::
     -		Advice shown if a user attempts to recursively tag a tag object.
    @@ Documentation/config/advice.txt: advice.*::
     -		linkgit:git-reset[1] when the command takes more than 2 seconds
     -		to refresh the index after reset.
     +		Shown when linkgit:git-reset[1] takes more than 2
    -+		seconds to refresh the index after reset: tell the user
    ++		seconds to refresh the index after reset, to tell the user
     +		that they can use the `--no-refresh` option.
      	resolveConflict::
     -		Advice shown by various commands when conflicts
    @@ Documentation/config/advice.txt: advice.*::
      	rmHints::
     -		In case of failure in the output of linkgit:git-rm[1],
     -		show directions on how to proceed from the current state.
    -+		Shown on failure in the output of linkgit:git-rm[1]:
    ++		Shown on failure in the output of linkgit:git-rm[1], to
     +		give directions on how to proceed from the current state.
      	sequencerInUse::
     -		Advice shown when a sequencer command is already in progress.
    @@ Documentation/config/advice.txt: advice.*::
     -		when the command takes more than 2 seconds to enumerate untracked
     -		files.
     +		Shown when linkgit:git-status[1] takes more than 2
    -+		seconds to enumerate untracked files: consider using the
    -+		`-u` option.
    ++		seconds to enumerate untracked files, to tell the user that
    ++		they can use the `-u` option.
      	submoduleAlternateErrorStrategyDie::
     -		Advice shown when a submodule.alternateErrorStrategy option
     +		Shown when a submodule.alternateErrorStrategy option
    @@ Documentation/config/advice.txt: advice.*::
     -		Advice shown when a user tries to create a worktree from an
     -		invalid reference, to instruct how to create a new unborn
     +		Shown when the user tries to create a worktree from an
    -+		invalid reference: instruct how to create a new unborn
    ++		invalid reference, to tell the user how to create a new unborn
      		branch instead.
      --
3:  30d662a04c7 ! 3:  df9b872afd1 advice: use backticks for code
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    advice: use backticks for code
    +    advice: use backticks for verbatim
     
    -    Use backticks for quoting code rather than single quotes.
    +    Use backticks for inline-verbatim rather than single quotes. Also quote
    +    the unquoted ref globs.
     
         Also replace “the add command” with “`git add`”.
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    +
    + ## Notes (series) ##
    +    v4:
    +    • Also quote ref globs
    +
      ## Documentation/config/advice.txt ##
     @@ Documentation/config/advice.txt: advice.*::
      	These variables control various optional help messages designed to
    @@ Documentation/config/advice.txt: advice.*::
      		it resulted in a non-fast-forward error.
      	pushRefNeedsUpdate::
     @@ Documentation/config/advice.txt: advice.*::
    - 		refs/heads/* or refs/tags/* based on the type of the
    + 		guess based on the source and destination refs what
    + 		remote ref namespace the source belongs in, but where
    + 		we can still suggest that the user push to either
    +-		refs/heads/* or refs/tags/* based on the type of the
    ++		`refs/heads/*` or `refs/tags/*` based on the type of the
      		source object.
      	pushUpdateRejected::
     -		Set this variable to 'false' if you want to disable
4:  3028713357f = 4:  15594b2a3a8 advice: use double quotes for regular quoting
5:  402b7937951 ! 5:  97b53c04894 branch: advise about ref syntax rules
    @@ Commit message
     
     
      ## Notes (series) ##
    +    v4:
    +    • Update refSyntax entry for consistency with the rest of the entries
         v3:
         • Tweak advice doc for the new entry
         • Better test style
    @@ Documentation/config/advice.txt: advice.*::
      		`pushFetchFirst`, `pushNeedsForce`, and `pushRefNeedsUpdate`
      		simultaneously.
     +	refSyntax::
    -+		Shown when the user provides an illegal ref name: point
    -+		towards the ref syntax documentation.
    ++		Shown when the user provides an illegal ref name, to
    ++		tell the user about the ref syntax documentation.
      	resetNoRefresh::
      		Shown when linkgit:git-reset[1] takes more than 2
    - 		seconds to refresh the index after reset: tell the user
    + 		seconds to refresh the index after reset, to tell the user
     
      ## advice.c ##
     @@ advice.c: static struct {
-- 
2.44.0.64.g52b67adbeb2

