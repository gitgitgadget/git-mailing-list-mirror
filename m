Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2B712E1DA
	for <git@vger.kernel.org>; Fri, 24 May 2024 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716571638; cv=none; b=KOj8aPMjF20qcNTNhKBF+YFmIaV+uTZSfJF2vQQzELuaRwYcozlsB994z1gQ7vXsX26WcS0qid2cOOGGkZ0oODUEjAICLA1vKv6lKUafAQjnbDyJ9VLwYP6am2hEz1uzbB7fYAMCBX0rlX7AU+vwxCnwEt4Upsh/W0B6ZA1IFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716571638; c=relaxed/simple;
	bh=xz0T0fihLh05uWdKTrKSj2IgUvrzWgj3NRXD6mUvmgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h7YvkhlY2HxPcCs2JNcbQPJrVVpf9hQnM6A8SrKj70ERSKkhK0XS1XvjM+rMR3rQ0mtC6893ePi20iXzNf3vpXmS1Yd6k+9SsIfr0XFdGV76IfOhCFndKQ+hJDaH6uQHs5pzAQ5/bBIv49da2hwNukYqZ2gIxYQ4Z9tGu1nZEi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bTyhmkCp; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bTyhmkCp"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6471F1AE06;
	Fri, 24 May 2024 13:27:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xz0T0fihLh05uWdKTrKSj2IgUvrzWgj3NRXD6m
	Uvmgo=; b=bTyhmkCpiZ4/cTakgaQjlciVxGXfA/d/S9V2dzwZ7zpPPawvr+deLq
	4gXx5H1viYG79au2ZYZlA6Do9Hu+ddswG+gTcDIxVSWNAs0f6CKe2ei3LkG9GfQe
	ipRT3bTrlyplVaApm/QdsYHhQQViA1YGDPFnbN7LPbfKoBHlDQwZU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5BC6F1AE05;
	Fri, 24 May 2024 13:27:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BBEA71AE04;
	Fri, 24 May 2024 13:27:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Phillip Wood <phillip.wood123@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Dragan Simic <dsimic@manjaro.org>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v3] docs: document upcoming breaking changes
In-Reply-To: <84c01f1b0a2d24d7de912606f548623601c0d715.1716555034.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 24 May 2024 14:54:48 +0200")
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
	<84c01f1b0a2d24d7de912606f548623601c0d715.1716555034.git.ps@pks.im>
Date: Fri, 24 May 2024 10:27:13 -0700
Message-ID: <xmqqsey7ktn2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DCBC29A4-19F2-11EF-97AD-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> case, most of the proposed deprecations didn't get much pushback. I'm
> less sure whether this is because people didn't look, or because they
> silently agree with what I propose for deprecation.

Or because I explicitly said that first we'll brainstorm, in order
to encourage generation of more ideas, without shooting other
people's ideas down?

>  Documentation/UpcomingBreakingChanges.md | 122 +++++++++++++++++++++++
>  1 file changed, 122 insertions(+)
>  create mode 100644 Documentation/UpcomingBreakingChanges.md
>
> diff --git a/Documentation/UpcomingBreakingChanges.md b/Documentation/UpcomingBreakingChanges.md
> new file mode 100644
> index 0000000000..d057ef7cb3
> --- /dev/null
> +++ b/Documentation/UpcomingBreakingChanges.md
> @@ -0,0 +1,122 @@
> +# Upcoming breaking changes
> +
> +The Git project aims to ensure backwards compatibility to the best extent
> +possible. Minor releases will not break backwards compatibility unless there is
> +a very strong reason to do so, like for example a security vulnerability.
> +
> +Regardless of that, due to the age of the Git project, it is only natural to
> +accumulate a backlog of backwards-incompatible changes that will eventually be
> +required to keep the project aligned with a changing world. These changes fall
> +into several categories:
> +
> +  - Changes to long established defaults.
> +
> +  - Concepts that have been replaced with a superior design.
> +
> +  - Concepts, commands, configuration or options that have been lacking in major
> +    ways and that cannot be fixed.
> +
> +The Git project will thus irregularly release major versions that deliberately
> +break backwards compatibility with older versions. This is done to ensure that
> +Git remains relevant, safe and maintainable going forward. The release cadence
> +of major versions is typically measured in multiple years.
> +
> +The intent of this document is to track upcoming deprecations for the next major
> +Git release. Furthermore, this document also tracks what will _not_ be
> +deprecated. This is done such that the outcome of discussions documente both
> +when the discussion favors deprecation, but also when it rejects a deprecation.
> +
> +It is supposed to be a living document where proposed changes and
> +deprecations are up for discussion.

OK.

> +## Git 3.0

Question.  

Will we have "## Git 4.0" etc., to indicate the timelines (some
stuff we might eventually replace/change, but we may not ready yet
by the time 3.0 comes)?  Or do we assme that an idea we agree enough
on to add to this document would all be ready to be implemented by
3.0?

> +### Changes
> +
> +  - The default initial branch name will be changed from "master" to "main".
> +
> +    Cf. <pull.762.git.1605221038.gitgitgadget@gmail.com>,
> +    <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>.

Forcing readers to read entire threads for these two discussions
somehow feels brutal at least to me.  And reading only these two
individual messages does not give readers much insight.

Saying "this was discussed in the past in late 2020, and because
major hosting sites give 'main' as the initial branch by default for
new users unless configured these days, we will match to avoid end
user confusion", if we want to explain why we are changing it,
should be sufficient.  But seeing that the other two items below do
not have any such explanation, we may be better of not having it
here, perhaps?

I take this iteration to illustrate the format of items (and what
kinds of items) we want to have in the document.  If the proposal
made by the above item is:

    Once we have a discussion thread that shows clear concensus
    (neither of the above two are not), we'd record the decision and
    have a reference to the thread.

then I 100% agree with the plan for this document.

> +  - The default hash function for new repositories will be changed from "sha1"
> +    to "sha256".
> +
> +  - The default ref backend for new repositories will be changed from "files" to
> +    "reftable".
> +
> +### Removals
> +
> + - git-http-push(1) can be used to push objects to a remote repository via
> +   HTTP/DAV. Support for write support via WebDAV is not in widespread use
> +   nowadays anymore and will be removed together with the command.
> +
> + - The dumb HTTP protocol can be used to serve repositories via a plain HTTP
> +   server like Apache. The protocol has not seen any updates recently and is
> +   neither compatible with alternative hash functions nor with alternative ref
> +   backends. It will thus be removed.
> +
> + - git-update-server-info(1) generates data required when serving data via the
> +   dumb HTTP protocol. Given the removal of that protocol, it serves no purpose
> +   anymore and will be removed together with the protocol. This includes the
> +   "receive.updateServerInfo" and "repack.updateServerInfo" config keys and the
> +   `git repack -n` flag.
> +
> + - `$GIT_DIR/branches/` and `$GIT_DIR/remotes/` can be used to specify
> +   shorthands for URLs for git-fetch(1), git-pull(1) and git-push(1). This
> +   concept has long been replaced by remotes and will thus be removed.

"remotes" -> "the 'remotes.*.*' configuration variables", perhaps?

> + - "gitweb" and git-instaweb(1) can be used to browse Git repositories via an
> +   HTTP server. These scripts have been unmaintained for a significant amount of
> +   time and will be removed.

Do we want to give plausible alternatives (or merely hinting
existence of alternatives might be sufficient)?

> + - git-filter-branch(1) can be used to rewrite history of a repository. It is
> +   very slow, hard to use and has many gotchas. It will thus be removed in favor
> +   of [git-filter-repo](https://github.com/newren/git-filter-repo).
> +
> + - The "dashed form", i.e. support for calling `git-<command>` instead of
> +   `git <command>` in scripts, has been deprecated for a long time and will be
> +   removed.

I find this questionable but as you said, we'll start from skeletal
form of this document (without any items), have discussion thread on
each of these items, and add back those we have concensus on, so
I'll not further talk about this item in this message.

> + - The command to import patches from Quilt seems to be used rarely, if
> +   ever, and will be removed.

Not limited to this item, but do we want to mention in this document
how we measured the actual usage, which we base our deprecation
decision on?  I do not think such a comment should be attached to
each of these items (this one and the next one are proposed for the
same reason),...

> + - Support for importing repositories from GNU Arch will be removed because
> +   it would not appear to have any users.

... but in a preamble of the document, e.g., "methodology and
criteria we used to propose these removals".  Random ideas that may
or may not work:

 - debian popcon?
 - google trends, counting the appearance of queries?
 - telemetry from commands that call home (we do not have any)?

> + - git-config(1) has learned to use subcommands that replace implicit actions
> +   (e.g. `git config foo.bar baz`) as well as the action flags (e.g. `git config
> +   --unset-all`). The action flags will not be removed in the next major Git
> +   release as there likely exist a lot of scripts out there that use the old
> +   syntax.
> +
> +   Cf. <ZjiL7vu5kCVwpsLd@tanuki>.

This is a good example of "we had a concensus back when this was
discussed; see the thread this message is on".  I think it would be
beneficial to write down what these references _mean_ at the beginning
of the document, e.g.

    When this document refers to a message-ID, you can visit

      https://lore.kernel.org/git/$message_id/

    to see the message and its surrounding discussion.  Such a
    reference is there to make it easier for you to find that the
    project reached concensus on the described item back then.  As
    this is a living document, and the environment surrounding the
    project changes over time, an earlier decision to deprecate or
    change something may need to be revisited from time to time, so
    do not take these references to mean "it is settled, do not
    waste our time bringing it up again".

or something like that.

Thanks.

