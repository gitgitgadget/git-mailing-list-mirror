Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F6A143888
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 22:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723675500; cv=none; b=HoOqcMRoykUM926IwhOb4eDvFjcoM5/08RGRP0HYMnCE9W2wA3YZH3g/LjwXvOseFWJuIe3Znzrsu6XBifPmHjcGrcXaGYgbBqpuIj4d9AW34Nna/V2l6C47lCh9o72l+zZTN7ek96Is1NeMPHG1dXW+8FYTk1YM7+CmHucBgjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723675500; c=relaxed/simple;
	bh=4MVs6qBleatSjtGYm4Ltf1KUKJ+GjGayjSkrGuMo7a8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PZqoMc4yXZmLR1YEWrUzPAhqWmRH6SFdqakDX93SU9sLO3gj2phU3Qv/hU6b1T7rpdSFiVFknKCKrpHfCcwS1k4gww577/9HxrKT/8435oxvQ1MNff07WMQPQ4At+ATwOGUaH01XthkDdOQkoq96uw8YfvbLath9nU17RyywaZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=k7HYlMMf; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k7HYlMMf"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DEF742C04A;
	Wed, 14 Aug 2024 18:44:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=4
	MVs6qBleatSjtGYm4Ltf1KUKJ+GjGayjSkrGuMo7a8=; b=k7HYlMMfk86Xf5izN
	pc4aEtSfM0b5xpt/yBU0cZcNL5jF4NXVC9hLSzP9gvu2VEhc4/5v3LiDkJMSHEgt
	yLVQ72tw+ouh6mA2BMm0lX00Jhu5A4Xi8ggkvH+N+0nwB6/mu1isvnBWbEzhWQRq
	ElRcX7zeng1jEzn7BDvIoXOZlA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D74952C049;
	Wed, 14 Aug 2024 18:44:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4B18B2C048;
	Wed, 14 Aug 2024 18:44:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: A note from the maintainer
Date: Wed, 14 Aug 2024 15:44:51 -0700
Message-ID: <xmqqmslewwpo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D2617F54-5A8E-11EF-964E-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Welcome to the Git development community.

This message is written by the maintainer and talks about how Git
project is managed, and how you can work with it.

The current maintainer is Junio C Hamano <gitster@pobox.com>.  Spam
filters learned that legitimate messages come only from a very few
sender addresses that are known to be good to this address, and all
other messages are likely to be spam unless they are also sent to the
mailing list at the same time (i.e. "Reply-all" to the list message
would reach the mailbox, but "Reply" will likely be thrown into the
spam folder), so please do not send a message to this address unless
it is also sent to the mailing list as well.


* Mailing list and the community

The development is primarily done on the Git mailing list. Help
requests, feature proposals, bug reports and patches should be sent to
the list address <git@vger.kernel.org>.  You don't have to be
subscribed to send messages.  The convention on the list is to keep
everybody involved on Cc:, so it is unnecessary to say "Please Cc: me,
I am not subscribed".

As an anti-spam measure, the mailing list software rejects messages
that are not text/plain and drops them on the floor.  If you are a
GMail user, you'd want to make sure "Plain text mode" is checked.

Before sending patches, please read Documentation/SubmittingPatches
and Documentation/CodingGuidelines to familiarize yourself with the
project convention.

If you sent a patch and you did not hear any response from anybody for
several days, it does not necessarily mean that your patch was totally
uninteresting; it may merely mean that it was lost in the noise.  Please
do not hesitate to send a reminder message in such a case.  Messages
getting lost in the noise may be a sign that those who can evaluate
your patch don't have enough mental/time bandwidth to process them
right at the moment, and it often helps to wait until the list traffic
becomes calmer before sending such a reminder.

The list archive is available at a few public sites:

        https://lore.kernel.org/git/
        https://marc.info/?l=git
        https://www.spinics.net/lists/git/

For those who prefer to read it over NNTP:

	nntp://nntp.lore.kernel.org/org.kernel.vger.git
        nntp://news.public-inbox.org/inbox.comp.version-control.git

are available.

When you point at a message in a mailing list archive, using its
message ID is often the most robust (if not very friendly) way to do
so, like this:

	https://lore.kernel.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org

Often these web interfaces accept the message ID with enclosing <>
stripped (like the above example to point at one of the most important
message in the Git list).

Some members of the development community can sometimes be found on
the #git and #git-devel IRC channels on Libera Chat.  Their logs are
available at:

        https://colabti.org/ircloggy/git/last
        https://colabti.org/ircloggy/git-devel/last

There is a volunteer-run newsletter to serve our community ("Git Rev
News" https://git.github.io/rev_news/).

Git is a member project of software freedom conservancy, a non-profit
organization (https://sfconservancy.org/).  To reach a committee of
liaisons to the conservancy, contact them at <git@sfconservancy.org>.

For our expectations on the behaviour of the community participants
towards each other, see CODE_OF_CONDUCT.md at the top level of the source
tree, or:

    https://github.com/git/git/blob/master/CODE_OF_CONDUCT.md


* Reporting bugs

When you think git does not behave as you expect, please do not stop
your bug report with just "git does not work".  "I used git in this
way, but it did not work" is not much better, neither is "I used git
in this way, and X happend, which is broken".  It often is that git is
correct to cause X happen in such a case, and it is your expectation
that is broken.  People would not know what other result Y you
expected to see instead of X, if you left it unsaid.

Please remember to always state

 - what you wanted to achieve;

 - what you did (the version of git and the command sequence to reproduce
   the behavior);

 - what you saw happen (X above);

 - what you expected to see (Y above); and

 - how the last two are different.

See https://www.chiark.greenend.org.uk/~sgtatham/bugs.html for further
hints.  Our `git bugreport` tool gives you a handy way you can use to
make sure you do not forget these points when filing a bug report.

If you think you found a security-sensitive issue and want to disclose
it to us without announcing it to wider public, please contact us at
our security mailing list <git-security@googlegroups.com>.  This is
a closed list that is limited to people who need to know early about
vulnerabilities, including:

  - people triaging and fixing reported vulnerabilities
  - people operating major git hosting sites with many users
  - people packaging and distributing git to large numbers of people

where these issues are discussed without risk of the information
leaking out before we're ready to make public announcements.


* Repositories and documentation.

My public git.git repositories are (mirrored) at:

  https://git.kernel.org/pub/scm/git/git.git/
  https://kernel.googlesource.com/pub/scm/git/git
  https://repo.or.cz/alt-git.git/
  https://github.com/git/git/
  https://gitlab.com/git-scm/git/

This one shows not just the main integration branches, but also
individual topics broken out:

  https://github.com/gitster/git/

A few web interfaces are found at:

  https://git.kernel.org/pub/scm/git/git.git
  https://kernel.googlesource.com/pub/scm/git/git
  https://repo.or.cz/w/alt-git.git

Preformatted documentation from the tip of the "master" branch can be
found in:

  https://git.kernel.org/pub/scm/git/git-{htmldocs,manpages}.git/
  https://repo.or.cz/git-{htmldocs,manpages}.git/
  https://github.com/gitster/git-{htmldocs,manpages}.git/

The manual pages formatted in HTML for the tip of 'master' can be
viewed online at:

  https://git.github.io/htmldocs/git.html


* How various branches are used.

There are four "integration" branches in git.git repository that track
the source tree of git: "master", "maint", "next", and "seen".  They
however almost never get new commits made directly on them.  Instead,
a branch is forked from either "master" or "maint" for each "topic",
whether it is a new feature or a fix for a bug, and holds a set of
commits that belong to the same theme.  Such a "topic branch" is then
merged to these integration branches.

The "master" branch is meant to contain what are very well tested and
ready to be used in a production setting.  Every now and then, a
"feature release" is cut from the tip of this branch.  They used to be
named with three dotted decimal digits (e.g., "1.8.5"), but we have
switched the versioning scheme and "feature releases" are named with
three-dotted decimal digits that ends with ".0" (e.g., "1.9.0").

The last such release was 2.46 done on Jul 29th, 2024.  We aim to keep
that the tip of the "master" branch is always more stable than any of
the released versions.

Whenever a feature release is made, "maint" branch is forked off from
"master" at that point.  Obvious and safe fixes after a feature
release are merged to this branch and maintenance releases are cut
from it.  Usually the topic branches that contain these fixes are
merged to the "master" branch first, before getting merged to the
"maint" branch, to reduce the chance of last-minute issues, but
things like embargoed security fixes may first appear in the "maint"
and merged up to "master" at the same time.  The maintenance releases
used to be named with four dotted decimal, named after the feature
release they are updates to (e.g., "1.8.5.1" was the first maintenance
release for "1.8.5" feature release).  These days, maintenance releases
are named by incrementing the last digit of three-dotted decimal name
(e.g., "2.43.2" was the second maintenance release for the "2.43" series).

New features almost never go to the "maint" branch.  It is merged into
"master" primarily to propagate the description in the release notes
forward.

When you send a series of patches, after review discussions on the
mailing list, a separate topic branch is forked from the tip of
"master" (or somewhere older, especially when the topic is about
fixing an earlier bug) and your patches are applied on that topic
branch, and kept out of "master" while people test it out.  The
quality of topic branches are judged primarily by the mailing list
discussions.

Topic branches that are in good shape are merged to the "next" branch.
The "next" branch is where new and exciting things take place.  In
general, the "next" branch always contains the tip of "master".  It
might not be quite rock-solid, but is expected to work more or less
without major breakage.  A topic that is in "next" is expected to be
polished to perfection before it is merged to "master".  Please help
this process by building & using the "next" branch for your daily
work, and reporting any new bugs you find to the mailing list, before
the breakage is merged down to the "master".

The "seen" (formerly "pu", proposed updates) branch bundles the
remaining topic branches the maintainer happens to have seen to remind
the maintainer that the topics in them might become interesting when
they are polished.

The contributors can use it to anticipate what topics from others
may cause conflict with their own work, and find people who are
working on these topics to talk to before the potential conflicts
get out of control.  It would be a good idea to fork from maint or
master to grow a topic and to test (1) it by itself, (2) a temporary
merge of it to 'next' and (3) a temporary merge to it to 'seen',
before publishing it.

Consider that a topic only in "seen" is not part of "git" yet.  When a
topic that was in "seen" proves to be in a testable shape, it is
merged to "next".

You can run "git log --first-parent master..seen" to see what topics
are currently in flight.  Sometimes, a topic that looked promising
proves to be a bad idea and the topic gets dropped from "seen" in such
a case.  The output of the above "git log" talks about a "jch" branch,
which is an early part of the "seen" branch; that branch contains all
topics that are in "next" and a bit more (but not all of "seen") and
is used by the maintainer for his daily work.

The two branches "master" and "maint" are never rewound, and "next"
usually will not be either.  After a feature release is made from
"master", however, "next" will be rebuilt from the tip of "master"
using the topics that didn't make the cut in the feature release.
Some topics that used to be in "next" during the previous cycle may
get ejected from "next" when this happens.

A natural consequence of how "next" and "seen" bundles topics together
is that until a topic is merged to "next", updates to it is expected
by replacing the patch(es) in the topic with an improved version, and
once a topic is merged to "next", updates to it needs to come as
incremental patches, pointing out what was wrong in the previous
patches and how the problem was corrected.  The idea is that if many
reviewers thought it has seen enough eyeballs and is good enough for
"next", yet we later find that there was something we all missed, that
is worth a separate explanation, e.g., "The primary motivation behind
the series is still good, but for such and such reasons we missed this
case we are fixing.", hence we prefer follow-up incremental patches.

Note that being in "next" is not a guarantee to appear in the next
release, nor even in any future release.  There were cases that topics
needed reverting a few commits in them before graduating to "master",
or a topic that already was in "next" was reverted from "next" because
fatal flaws were found in it after it was merged to "next".


* Other people's trees.

Documentation/SubmittingPatches outlines to whom your proposed changes
should be sent.  As described in contrib/README, I would delegate fixes
and enhancements in contrib/ area to the primary contributors of them.

Although the following are included in git.git repository, they have their
own authoritative repository and maintainers:

 - git-gui/ comes from git-gui project, maintained by Johannes Sixt:

        https://github.com/j6t/git-gui

 - gitk-git/ comes from Paul Mackerras's gitk project:

        git://ozlabs.org/~paulus/gitk

 - po/ comes from the localization coordinator, Jiang Xin:

	https://github.com/git-l10n/git-po/

When sending proposed updates and fixes to these parts of the system,
please base your patches on these trees, not git.git (the former two
even have different directory structures).
