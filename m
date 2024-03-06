Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6465913DBB2
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740872; cv=none; b=mDc1HrChzQpmzacvAc+r6W6A1yS1FRv/iGhOAeATq/811anX8VHo0BXNwfuUUh7uQcS2qiF3tcGz2B871PAgb9F4WS7bEqWdnzB51JXicQ/sgFgHnhEt32RtfrsXWX3ysxSddf82KJ51wZP+z3XEMrQb4Gkvbuu+7Q61NPGFfGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740872; c=relaxed/simple;
	bh=GgWzL2ksyoII2622193bjWmKEIXrphE+lVUsVAGu3+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T/ZeKkRt/PJ/2fv8XyFqr0frlZ67z929ipV98Bj1iXtr4qVjjTj8MZVvF6j0DcOATnedXpFgr1IxJpRtytfZ/xHZ17HUVPJygJN3wg5c0HKS54Pos6bTWFqrOe/mzfO8s3dPbPXBOmstBEuVxJdVYWagon79IWueKLds4vwAB8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yFAJDhqI; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yFAJDhqI"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 342681E37D7;
	Wed,  6 Mar 2024 11:01:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GgWzL2ksyoII2622193bjWmKEIXrphE+lVUsVA
	Gu3+g=; b=yFAJDhqI+gCapE6rKjDIhWJe+PQ8aHjt2iadACTgStDXbOrh8AwC0+
	qQeoAdrh78SnnXoEh05dheP7WW6DGAV2Q02aqrmekcgvDU6PKgJKihd7K7LhABix
	XSEK2fKT0p/U+UqVxGznujh0r1f0aXRiEv3weFVK7Hs8ZqXppjU7M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9995B1E37D6;
	Wed,  6 Mar 2024 11:01:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B3BEA1E37D4;
	Wed,  6 Mar 2024 11:01:04 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Ralph Seichter via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ralph Seichter <github@seichter.de>
Subject: Re: [PATCH] Allow git-config to append a comment
In-Reply-To: <pull.1681.git.1709532018372.gitgitgadget@gmail.com> (Ralph
	Seichter via GitGitGadget's message of "Mon, 04 Mar 2024 06:00:17
	+0000")
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
X-Gnus-Delayed: Wed, 06 Mar 2024 21:08:04 -0800
Date: Wed, 06 Mar 2024 08:01:03 -0800
Message-ID: <xmqqttljtkn4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BC85574A-DBD2-11EE-8AED-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Ralph Seichter via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ralph Seichter <github@seichter.de>
> Subject: Re: [PATCH] Allow git-config to append a comment

Thanks for a patch.

Make sure your title will mix well in "git shortlog --no-merges"
output from recent commits by other contributors.  See
Documentation/SubmittingPatches[[describe-changes]].  Perhaps

    Subject: [PATCH] config: add --comment option to add a comment

> Introduce the ability to append comments to modifications
> made using git-config. Example usage:
>
>   git config --comment "I changed this. --A. Script" \
>     --add safe.directory /home/alice/somerepo.git

If you are illustrating a sample input, please also explain what
output it produces.  What do the resulting lines in the config file
look like after you run this command?

I find the overall idea somewhat incomplete.  Perhaps stepping back
a bit and thinking through the _whole_ use case of "comment" in the
configuration files is in order, before thinking about an easier way
to add one.  Why are you adding "# comment" to your config file?
Who reads these comments, with what tool, and for what purpose?
What will they do after they learn something from what their former
selves wrote as comments?

Let's imagine we had this in our global configuration file in the
beginning:

    $ cat ~/.gitconfig
	...
    [safe]
	directory = /home/bob/otherrepo.git
	...

and then we run this:

    $ git config --global --comment 'the reason why I added ~alice/
    is because ...' --add safe.directory /home/alice/somerepo.git
    $ git config --global --add safe.directory /home/charlie/somerepo.git

which may modify the configuration file with the new entry with a
comment.  The part about safe.directory might now read like so:

    [safe]
	directory = /home/bob/otherrepo.git
        # the reason why I added ~alice/
        # is because ...
	directory = /home/alice/somerepo.git
	directory = /home/charlie/somerepo.git

Now how do we find out about this comment?  "git config -l" would
not give us that.  Are we expected to look at it in our editor or
pager?

    $ vi ~/.gitconfig
    $ less ~/.gitconfig

Why are we interested in looking at these comments in the first
place [*]?

    Side note: I do not ask "why are we interested in leaving
    these comments in the file"---it goes without saying that
    it is because we want to be able to later read them.

Presumably, we are trying to remind ourselves why we added a
particular variable=value.  By learning that, what are we going to
do next?  Perhaps once the reason to mark /home/alice/somerepo.git
as a safe.directory disappears, we would want to remove this entry?

But then, after running

    $ less ~/.gitconfig

and then learning that we no longer need /home/alice/somerepo.git
marked as a safe.directory, how would we remove it from the
configuration file, and what happens to the comment?

    $ git config --global --unset safe.directory /home/alice/somerepo.git

may remove the value, but it would not remove the comment, and
you'll be left with something like this:

    [safe]
	directory = /home/bob/otherrepo.git
        # the reason why I added ~alice/
        # is because ...
	directory = /home/charlie/somerepo.git

The remaining comment looks as if it talks about "charlie", but it
simply is stale.

Should it have removed the comment, then?  I actually do not think
so.  A comment before a particular variable definition may not be
the result of the use of this new "config --comment" option, but
perhaps the user added it manually.  Or even worse, the comment may
not even be about an individual entry.  Imagine

    [section]
	# definitions for per-user stuff begin here
	var = /home/alice
	# these two directories are actually charlie's
	var = /home/bob
	var = /home/charlie

	# definitions for per-project stuff
	var = /project/a
	var = /project/b

Can we come up with a code that reliably decides when to remove the
first comment we see above?  The answer given by human might be
"when all the entries about /home/alice, /home/bob, and
/home/charlie get removed", but can we implement that in code
without interpreting the natural language?  I doubt it.  We may even
be better off to keep the comment to remind ourselves where to add
the per-user stuff in the section when we hire a new user the next
time.

With the new "--comment" thing might be able to add comments without
using an editor, but the user would need to view the configuration
file with a pager or an editor bypassing Git to make use of what was
recorded in there.  And it is likely that these comments will need
to be edited or removed using an editor because "git config" command
would not be usable for maintaining them. For that matter, if you
made a typo in your "--comment" option from the command line, you
would have to resort to your editor to fix that typo.

The above is an illustration of what I want to see the author, who
comes up with this "wouldn't it be wonderful to teach git-config to
add comment?" idea, thinks through.  The first patch might be to
just add a comment when a variable=value is added, but we want to
see the vision of how the whole end-user experience should look
like, in which this first small piece will fit.

Identify the whole life cycle of the result of using the feature,
what the end-user experience of using the result of using the
feature would look like, etc.  In this case, "the result of using
the feature" is the comments that are initially placed next to a
newly defined variable-value pair, and at least to me, the end-user
experience to manage the life cycle of these comments is not all
that improved from the status quo, which is that you need your pager
and editor to view them, edit them, typofix them, and remove them.

I am somewhat negative on the idea to make the initial addition of
the comment vastly different from all other uses of the comment by
introducing this "--comment" option.  If we have a vision, if not
design and/or code, to help managing other parts of the lifecycle,
not just adding in the beginning, it might be a different story, but
I cannot quite see it.

>  Documentation/git-config.txt | 10 +++++++---
>  builtin/config.c             | 21 ++++++++++++++-------
>  builtin/gc.c                 |  4 ++--
>  builtin/submodule--helper.c  |  2 +-
>  builtin/worktree.c           |  4 ++--
>  config.c                     | 21 +++++++++++++--------
>  config.h                     |  4 ++--
>  sequencer.c                  | 28 ++++++++++++++--------------
>  submodule-config.c           |  2 +-
>  submodule.c                  |  2 +-
>  t/t1300-config.sh            |  9 +++++++--
>  worktree.c                   |  4 ++--
>  12 files changed, 66 insertions(+), 45 deletions(-)

And the amount of the change required for that tiny bit of
"improvement" (if we can call it, which is dubious) does not seem
worth it.

Thanks.
