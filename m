Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FC221CA03
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743515; cv=none; b=uBlvGLmad0g80VkjPVxmU8Y4+pDLvSqNOLPpBVhHItwLEdeh0rMFgYCZNIjPbtYjTP/dle1kvHEboRVLnLTM2/8AU57MruQc15DS0KsOhgiLp4MMxI78F+z3WmiI33vq+A7oSoBiHWE9+19zXVMuwCjHBKqAYk7lZ1rTguheYMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743515; c=relaxed/simple;
	bh=j2nDaYWpPhb4Cy7S7Zjnw6CabcvfUuUwuLFjLb9m3Sg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tio2uzzFo2gWa58BEND8qVvciFFJw/lKGPu92Jm9y7zNvCiXquhGIl4brwMh6OZ2TJEHkcHd4PmSMnAWN1xQ33fJ6OLTXZQXkYC8C0pIqm9vZTEbLai7AeLuQ3fYxNVhppwAmiA1AMtCjLNmNTCQs+PHeSn4HbA4BQtOcEgBjX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gWGWLwz9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XuSVUTK9; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gWGWLwz9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XuSVUTK9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 01CB0EC0053;
	Wed, 24 Sep 2025 15:51:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 24 Sep 2025 15:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758743511; x=1758829911; bh=Hg5+3Ddgdz
	5Wwr162N/OKtlJQQTpORNasUDjll4zCpc=; b=gWGWLwz9MwQY40o5REHtW9EfrF
	AXp++DJQo+VBW1PvMoWTDSwib5acu2PF3Zxw/UzzMGGgOi+MV44u1BpMZkrCG4eb
	rs8p2qmui5Plg+BAulRP5mSBVgFtXc16jorpnf+yJ4GCaImsQihmgkrcgae4MxZf
	PurELFEQooAedD0sS52qQtcmSBFByj8waE1alOuq/SucFXplBQ3f+iTKuZPweZo7
	n2XKZhKxyWKABatxfi8mu6fUkJ9Ltl4wXLYCP+L+IhO2FFOTSUbgnx1jtdD2S0JZ
	lXHo9tbTLQtQX47sFUMFXdz5x/fwKBfT3yLoADAfCZPsvZ8oKFbqgA1eqwMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758743511; x=1758829911; bh=Hg5+3Ddgdz5Wwr162N/OKtlJQQTpORNasUD
	jll4zCpc=; b=XuSVUTK9jogJgUZXX8Df1s2xQYz5J+wfRdbNk5HNIoKqfEBWa/Z
	6K0l+VsaXqtAF0JwXusqOW80xce8CQC5ORdmpNHzpi0jJiKGDtFRvbHi3nzI7a1k
	YTuHGuqXZDxuCPkg9qvc3UQg2konzQsFxv/bgFWoanNJLWwdqAH3WiiE/Y/rO3Wp
	RlUXOsMksj49VKujs68JBJS7FuSGzusi/GUAOIy2lBH1rulCmH8jfBAkF+rSdXKQ
	M70TO6URs54DKFOcO0lRsniJW6LJpI3qFMfIMKojXr/QeXyRPT4B0LW3O0hI8XYo
	jyLnsWnG/NkRNiKVo5o6bo0gIgw8PSAwoJA==
X-ME-Sender: <xms:10vUaDLFqND4HMixK7xBycagR_x5JoV1PyoYi26B1wF1RhvTnU6GRg>
    <xme:10vUaK0jkJZpsYu65udKn5tf0N4lnqthBkHRux1bc5G6JHtHLcgS3Tb3wVA4ArEc7
    bl2KyidDHxlU3fWQY6Yp-dTvAUrdzRw-bV1rtBxHUgTgswnDBpqvH8>
X-ME-Received: <xmr:10vUaFj5q83cDdGtmFYif8ReHnM-yyqzNrovdialNsvJPMnZ9IE2r-JKHNkX48dwYbc2dQKiCcFqC0aDqCfKdUrW068qQ5DbLx1k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhu
    lhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:10vUaDWqSyVQkGx5bILfR7lxo0TK9eb3Mb3lZks2xjP--qvOEKywBw>
    <xmx:10vUaMXldCFSmUBOuqgFWbWGLWr5qXVoTquGTK97YzXD2qK3_pmnDA>
    <xmx:10vUaLjxAHwzdvlAS5QapVkzCD6SEhzyRP3Z6m6-jbTuYVmnP-UqFg>
    <xmx:10vUaPaxOhn_BiWy4IBqz2XC00Vatmfp57aYh3kyM94MQSeYou_5AA>
    <xmx:10vUaC13oU3aK02wvRuNjXlanGZDfpm6poKjTTyYXDM16oCzgg6RRosr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 15:51:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v3 2/4] doc: add an UPSTREAM BRANCHES section to
 pull/push/fetch
In-Reply-To: <3ecfb5c3a67723f160e8161e212d77f95964539c.1758649472.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Tue, 23 Sep 2025 17:44:30
	+0000")
References: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
	<pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
	<3ecfb5c3a67723f160e8161e212d77f95964539c.1758649472.git.gitgitgadget@gmail.com>
Date: Wed, 24 Sep 2025 12:51:50 -0700
Message-ID: <xmqqwm5nk4rt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Since the `git pull`, `git push`, and `git fetch` man pages already
> include sections on REMOTES and the syntax for URLs, add a section on
> UPSTREAM BRANCHES to `urls-remotes.adoc` and rename it to
> `urls-remotes-upstreams.adoc`. That's an awkward name but at least it's
> clear what's in the file.

You no longer do any such thing ;-) I can locally everyting after
"and rename it ..." and replace it with a single full-stop "." so
unless there are other things you would need to update this topic
with, no need to correct only this part.

> In the new UPSTREAM BRANCHES section, cover the various ways that
> upstreams branches are automatically set in Git, since users may
> mistakenly think that their branch does not have an upstream branch if
> they didn't explicitly set one.
>
> A terminology note: Git uses two terms for this concept:
>
> - "tracking" as in "the current branch is _tracking_ some remote"
>   or the `--track` option to `git branch`

Should we say "tracking some branch at a remote"?  It is not like
the current branch tracks more than one (or all) branches at the
remote as a whole.

> - "upstream" or "upstream branch", as in `git push --set-upstream`.
>   This term is also used in the `git rebase` man page to refer to the
>   first argument to `git rebase`, as well as in `git pull` to refer to
>   the branch which is going to be merged into the current branch ("merge
>   the upstream branch into the current branch")

This side is fine.

> Use "upstream branch" as a heading for this concept even though the term
> "upstream branch" is not always used strictly in the sense of "the
> tracking information for the current branch". "Upstream" is used much
> more often than "tracking" in the Git docs to refer to this concept and
> the goal is to help users understand the docs.

Good.

> diff --git a/Documentation/urls-remotes.adoc b/Documentation/urls-remotes.adoc
> index 9b10151198..1138a5889d 100644
> --- a/Documentation/urls-remotes.adoc
> +++ b/Documentation/urls-remotes.adoc
> @@ -91,6 +91,44 @@ git push uses:
>  	HEAD:refs/heads/<head>
>  ------------
>  
> -
> -
> -
> +UPSTREAM BRANCHES[[UPSTREAM-BRANCHES]]
> +--------------------------------------

Can we have at least two blank lines between these sections to make
it visually distinct from a gap between two paragraphs?  I know it
would not make a difference in the rendered pages, but it would help
those who read the document in the source form.

> +
> +Branches in Git can optionally have an upstream remote branch.
> +Git defaults to using the upstream branch for remote operations, for example:
> +
> +* It's the default for `git pull` or `git fetch` with no arguments

I think you'd want to finish this sentence with a full-stop ".", and
a few lines below, the point beginning with "Various commands".

> +* It's the default for `git push` with no arguments, with some exceptions.
> +  For example, you can use the `branch.<name>.pushRemote` option to push
> +  to a different remote than you pull from, and by default with
> +  `push.default=simple` the upstream branch you configure must have
> +  the same name.
> +* Various commands, including `git checkout` and `git status`, will
> +  show you how many commits have been added to your current branch and
> +  the upstream since you forked from it, for example "Your branch and
> +  'origin/main' have diverged, and have 2 and 3 different commits each
> +  respectively"

Other than these, all changes from the previous version look good to
me.

Thanks.
