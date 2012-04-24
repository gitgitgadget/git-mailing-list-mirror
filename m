From: <dag@cray.com>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 24 Apr 2012 18:21:10 -0500
Message-ID: <nngobqg1ztl.fsf@transit.us.cray.com>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
	<m3hawjagw9.fsf@localhost.localdomain>
	<nng3983phhc.fsf@transit.us.cray.com>
	<CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com>
	<201204171837.q3HIbbcW013784@no.baka.org>
	<CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com>
	<nng1unmnksx.fsf@transit.us.cray.com> <4F8EB157.5060707@web.de>
	<nngbomh3uz0.fsf@transit.us.cray.com>
	<201204241759.q3OHxSbH017287@no.baka.org> <4F970C92.3030704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Seth Robertson <in-gitvger@baka.org>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, <greened@obbligato.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 25 01:21:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMp36-0007hO-8o
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 01:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660Ab2DXXV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 19:21:27 -0400
Received: from exprod6og112.obsmtp.com ([64.18.1.29]:34593 "EHLO
	exprod6og112.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755504Ab2DXXV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 19:21:26 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob112.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT5c1akeXU6Evv6sk2C/Q7UYEIaBaFbsz@postini.com; Tue, 24 Apr 2012 16:21:25 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 24 Apr
 2012 18:21:13 -0500
In-Reply-To: <4F970C92.3030704@web.de> (Jens Lehmann's message of "Tue, 24 Apr
	2012 22:26:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196288>

Jens Lehmann <Jens.Lehmann@web.de> writes:

[Thanks for working this!  I have a few comments inlined below to
hopefully help make this even better.]

> In the end I'd like to see a document people can use to decide what
> subproject support suits their needs best. Maybe it should start with
> the basic concept behind each of them:

Exactly.

> submodules: A submodule is a full fledged repository of which a certain
> commit is recorded in a gitlink entry in each of the the superproject's
> commits.

That's far too technical.  I don't even know what that means.  :) I
think we want to go for the average user who just wants to make an
informed decision among the various models available.

> The emphasis lies on tightly coupling versions of both while keeping the
> boundaries between superproject and submodules visible.

The above is good but could use some expanding.  What exactly does
"tightly coupling" mean?  It's kind of a generic phrase.

> This leads to some extra cost when doing changes in a submodule but makes
> it easy to evaluate and select new changes from upstream and push back
> local changes to their respective upstream.

This, I think is a key differentiator for submodules and should be
emphasized.

> subtree: All subprojects become an integral part of the history of the
> superproject.
> The emphasis lies on incorporating the subtree and its history into the
> superproject.
> That adds some extra cost when it comes to pushing subtree changes back
> to their upstream (starting with the need for careful commit planning for
> local commits intended to be pushed out again) and less fine grained
> control over importing changes from the subtrees upstream.

That's a good start.  I'll add some text to this later as I think there
are some advantages to the approach that should be called out.

> gitslave: This creates a federation of full fledged git repositories which
> are operated on by the gits commands together (where a git command would
> only operate on the superproject).
> The emphasis lies on the simultaneous operation of gits commands on all
> git repositories.
> It does not provide any coupling of the commits in the superproject and the
> slave repositories (but you can use tags to have that at some points in the
> history).

Should gitslave be covered in this document if gitslave is not in the
upstream git repository?  I'm not knocking gitslave, in fact I think
it's cool technology and probably _should_ be contributed upstream.  I'm
just asking the question about whether stuff in Documentation/ is or
should be limited to things in the upstream repository.

That said, the above is good but as a user I would want more
clarification on how submodules and gitslave differ.  The same is true
for subtrees but I'm assuming I'll handle that.  :)

> What do you think? (Please point out anything I misrepresented in the last
> two paragraphs, they are based solely on what I picked up on this list and
> are not based on any actual experience ;-)

It looks very good as a starting point.  Thanks!

> Then we could describe in a table what to do when to fetch new subproject
> commits, how to "select" them in the superproject and how to push them
> back to their respective upstream. Another interesting question could be
> how a bug in a subproject that affects the superproject is handled in each
> of the scenarios.

Yes, I was imagining exactly this sort of table.

How about creating a topic branch for this and publishing it so several
of us can collaborate?  I think that would make things a bit easier
moving forward.

                                 -Dave
