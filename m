From: Junio C Hamano <gitster@pobox.com>
Subject: [Administrivia] On ruby and contrib/
Date: Tue, 04 Jun 2013 17:04:39 -0700
Message-ID: <7va9n52zjc.fsf@alter.siamese.dyndns.org>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 05 02:04:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uk1Dc-0006wm-Hm
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 02:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181Ab3FEAEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 20:04:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343Ab3FEAEn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 20:04:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FBDD25A56;
	Wed,  5 Jun 2013 00:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=5X3ZranEn54BOlQKg/TodbJltYI=; b=c/HzlKoyLdz6mcecXNvK
	QROA5zpea8VneveOkx01t+Jj23anLHzI5fcBmDy/AE0Cn3ficetZLfMK03Gbg+jE
	ayD5kEt4xibwNVQGVfZh8csGcnl+XT1/MvyoKoUfGBwhF6IQuM/kaNrNxntuk1si
	rc7PH88cHvYT3VtbwqRJ7qo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=K01gCXOvjX7bn5+tVy5EvyU9iqHHiwD+/BAumTSM1BjQti
	FFaXxI6jcDBxpzIQ8Q28iJKeYgq6gsMvjDvXOB4yZKnsEWOZFYKdEYHqC4iOttP4
	SPX6oCp81eXRyvBaamkVo0i7nddOoHtjxipR66gyJSNqvwkwTjJnchDqrffVQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FD4025A55;
	Wed,  5 Jun 2013 00:04:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B7D725A4F;
	Wed,  5 Jun 2013 00:04:41 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 855CF0A8-CD73-11E2-BFF9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226425>

Junio C Hamano <gitster@pobox.com> writes:

> * fc/contrib-related (2013-06-03) 4 commits
>  - contrib: related: parse committish like format-patch
>  - contrib: related: add option to parse from committish
>  - contrib: related: add support for multiple patches
>  - Add new git-related helper to contrib
>
>  Waiting for the design review to settle.

As people may have seen in the discussion on the earlier iteration,
something like this (there may be a room for bikeshedding the name,
though) that takes either a range of changes or set of patches and
finds people who may be able to review them may be a good addition
to our official toolchest.

  http://thread.gmane.org/gmane.comp.version-control.git/221728/focus=221796

Right now, "related" is in contrib/ primarily because its design
review phase is not yet finished and because it is in Ruby, which
the rest of the system does not depend on.

I have some administrative comments on two issues as the maintainer.

 * Do we want to add Ruby dependency?
 * Do we want to keep expanding contrib/?

These have been triggered by "related", but the comments in this
message are not limited to the specific topic (e.g. you can read it
with s/Ruby/<any language we currently do not depend on>/).


On Ruby:

Assuming "related" is a good idea, to make it as the proper part of
the system out of contrib/ when its design review phase is finished,
one of these things has to happen:

 1. Find a volunteer to rewrite it in one of the languages that we
    know the platforms our current users use already support, which
    means either C (not a good match), POSIX shell (not the best
    match), or Perl.

 2. Promote Ruby to the first-class citizen status, which involves
    making sure people on platforms that matter do not have problem
    adding dependency on it (I am primarily worried about MinGW
    folks), and also making sure core developers do not mind
    reviewing code written in it.

As long as we can get as high quality reviews on changes written in
Ruby as we do for the current codebase, it is OK to go route #2, and
that may hopefully happen in the longer term as and there will be
some people, among competent Ruby programmers, who have understood
how the pieces of entire Git are designed to fit together by the
time it happens.

I however do not know how much extra burden it would place to add
dependencies to platform folks, so obviously the safer approach is 1
at least in the immediate future.  My understanding is that msysgit
folks are already having trouble with Python, and we do not want to
go route #2 at least for now.  Having to ship a variant of Git with
NO_PYTHON is already bad enough.  And that is why the option 1 above
does not list Python as a possible candidate.


On contrib/:

Back when Git was very young, it made sense to bundle third-party
tools in our tree's "contrib/" section to give them visibility and
users convenience.  Now Git ecosystem has grown to have many users
who know Git and who do not necessarily come to this list, and with
easy-to-use hosting sites where anybody can publish their ware and
collaborate with their contributors, "giving more visibility" angle
of contrib/ has outlived its usefulness.  When there are multiple
third-party tools that address similar needs, there is not much
point picking one at random and ship it over others, and shipping
all of them is simply crazy.  In an ecosystem with flourishing
third-party add-ons, their products should and will stand on their
own.

As the maintainer, I've been thinking about closing contrib/ area
for new stuff, and shrinking existing ones, either by moving stuff
that are only useful within the context of Git to main part of the
tree (e.g. "contrib/workdir" may move to a new directory "addons/",
some of remote-helpers in contrib/ may move to "remote-helpers/",
etc.), and removing others from contrib/, for this reason.  Of
course, interested folks can take the last version of the removed
ones and continue improving them as standalone projects.

And that is why the list of possible actions in the previous part
does not have "3. Keep it in contrib/ forever" as an option.

That is all for the "administrative comments" as the maintainer.


The rest is just a personal opinion.

If we were looking at a compelling and sizeable web application that
depends on Rails, it is very likely that it would not make much
sense to rewrite it in other languages only to avoid a new language
dependency on Ruby.

But "related" is "read and extract some info out of text files,
spawn a 'blame' (or two) based on that info, read to collect further
info and summarize", for which Ruby does not especially shine
compared to Perl, which is the language we already depend on.
Because of this, I am moderately reluctant to add Ruby dependency
only for this script.  Unless I know people who regularly give us
high quality reviews, and those who support various platforms, are
fine with it, that is.

In the shorter term (read: up to 2.0), I am inclined to vote that we
should go route #1 (i.e. rewrite in Perl once the design settles).

My "personal opinion" above of course assumes that everybody agrees
that "related" is a good addition.  If not, there is "3. not add it
to contrib/ and leave it as an out-of-tree third-party project"
option.
