From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Questions on patch lifecycle
Date: Tue, 22 Apr 2008 00:47:35 -0700
Message-ID: <7vve2a2uw8.fsf@gitster.siamese.dyndns.org>
References: <1208837481.26863.374.camel@goose.sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: "Roman V. Shaposhnik" <rvs@sun.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 09:48:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoDF0-000696-IL
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 09:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756126AbYDVHrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 03:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756344AbYDVHrw
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 03:47:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52870 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755132AbYDVHrv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 03:47:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 328331F30;
	Tue, 22 Apr 2008 03:47:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 34BF71F24; Tue, 22 Apr 2008 03:47:43 -0400 (EDT)
In-Reply-To: <1208837481.26863.374.camel@goose.sun.com> (Roman V.
 Shaposhnik's message of "Mon, 21 Apr 2008 21:11:21 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80075>

"Roman V. Shaposhnik" <rvs@sun.com> writes:

> Anyway, here are the questions:
>
>    0. Junio, are you the only Git maintainer or are there others
>    responsible for particular subsystems of Git?

I delegate some parts of the git.git tree to others to different degrees,
but the overall idea is this.

I do not do this as a full time job (is there a big pocket Open Source
company who wants to buy bragging rights to say "we support git" by
employing me and letting me do git and nothing else? ;-).

There are many occasions that I would say "I do not see this patch helping
my use of git personally, neither I see how this would help people. I
might find a valid use case for some workflows other people may use _if_ I
think about it long enough, but I am pressed on time, so I'll pass and see
what others on the list say".

"What others on the list say" does not mean simply majority for several
reasons.  Judgement of some people I trust more than others, simply
because I worked with them longer and know their strength and weakness
well, but more importantly, a single convincing argument explaining why it
is a bad (or good) idea clearly far outweighs a dozen mee-too's that
without stating their reasoning well enough to make people with other
opinions reconsider their positions.

The strongest trust comes from trees I pull from others, such as gitk and
git-gui.  Unless I have a very strong reason to judge their newly added
history as a crap that needs to be rebuilt (luckily which never happened
as far as I recall so far), I honor the subsystem maintainer's
judgements.  The same applies to various pieces and people, such as Eric
on git-svn, Nico on pack generation, etc (see "A note from the
maintainer").

>    1. What's the official way of submitting a patch?  Is
>    git-send-email(1) to this mailing list good enough? Does a submitter
>    have to have a public tree that maintainer(s) can pull from?

Currently a review on the list is considered mandatory, even if you
maintain a clean history people (not limited to me) can pull from.

My preference of the patch flow is that the initial round of the series
(unless it is unarguably correct bugfix and/or a pure enhancement that is
unarguably a good thing to do --- the latter is almost never true, though)
is sent to the list, with people who have been involved in the part of the
system in the past CC'ed, and after some discussion and improvements if
and when the list reaches concensus that it is a good thing to do, a final
submission is made To: me with list CC'ed.

>    2. Once the patch is submitted how does the author get notified
>    whether it is accepted, rejected or needs additional work.

You forgot two more important cases.  "Nobody seemed to be interested in
it." and "Objections and/or improvement suggestions have been raised".

I try to send a single-liner "applied" message (often off-list) to the
submitter but again I am not doing this full-time, so I often omit this
when I know I am soon going to send out "What's cooking".

Objections and suggestions can come from me or more often from list
members.  That's review process.  I may or may not pick it up while a such
patch is "in flight".

> What's confusing to me with Git, are the examples like some patches from
> Ping Yin not receiving any public acknowledgment at all and some of the
> patches from other submitters (Dmitry Potapov) getting sort of lost.

Patches that do get negative reviews and left as initially posted without
improvement tend to get dropped, but obviously good ones can also get lost
when there is not much interest from the list.  Be persistent and patient.

I still remember that it took me more than half a dozen tries to get
format-patch in when Linus was running the show ;-)
