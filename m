From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/subtree: Remove --annotate
Date: Sun, 17 Jan 2016 17:29:59 -0800
Message-ID: <xmqq60yrektk.fsf@gitster.mtv.corp.google.com>
References: <1451963101-4901-1-git-send-email-greened@obbligato.org>
	<1451963101-4901-2-git-send-email-greened@obbligato.org>
	<xmqqsi2cj5hu.fsf@gitster.mtv.corp.google.com>
	<87oaczwvz8.fsf@waller.obbligato.org>
	<xmqqbn8mish5.fsf@gitster.mtv.corp.google.com>
	<87oacjaint.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, techlivezheng@gmail.com,
	alex.crezoff@gmail.com, davvid@gmail.com, cbailey32@bloomberg.net,
	danny0838@gmail.com, prohaska@zib.de, th.acker@arcor.de,
	sschuberth@gmail.com, peff@peff.net, gitter.spiros@gmail.com,
	nod.helm@gmail.com
To: greened@obbligato.org (David A. Greene)
X-From: git-owner@vger.kernel.org Mon Jan 18 02:30:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKye4-0005mb-Eu
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 02:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbcARBaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 20:30:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753173AbcARBaG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 20:30:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0A5383C358;
	Sun, 17 Jan 2016 20:30:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v+qLuAdeYUGKysbyOfzgeO7GLCw=; b=H3KEGo
	9fZVdsXV9BcEQJCG/u68Gj/oFQY8hEIn9K9M5TnEvHA7sXktw1wgU12ogbFNg2lS
	EhMICGGsEtOcfSMW9cRzSkmRkMVdNVoWw1jiOHJhNoSI50/6mkGl+YgSDxFvgDOX
	mJc1yY+w0lmoe89l5zbneSSB8AlvVQtt84pQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=evulxQ3xoAbBTqcfiHdINPP6xC057Ekc
	BbZ8CkM8EoC/+gpis/xR/ecJizBv4DsewCTNnzz0D/cEnG04kka3PDxtk8RPhSCi
	yy9nkziWt17o40XSMHEmqVeQPRJELBViQaqVvvErzNT1F9X3Jqo0d7H5YikVRXyn
	LiePxD+5GcY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8D5243C354;
	Sun, 17 Jan 2016 20:30:03 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 78DCD3C350;
	Sun, 17 Jan 2016 20:30:00 -0500 (EST)
In-Reply-To: <87oacjaint.fsf@waller.obbligato.org> (David A. Greene's message
	of "Sun, 17 Jan 2016 17:30:14 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FDBE8AC8-BD82-11E5-99DD-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284279>

greened@obbligato.org (David A. Greene) writes:

> Just to clarify, what is the expectation of things in contrib?
> Basically the same as other code?

That heavily depends on your exit strategy.

The contrib/ area was created back when Git was still young and we
felt that it would be beneficial for building the community if
contributions to non-core part were also included, encouraging
developers whose strength are not necessarily in the core part to
participate in various design-level discussions to grow the
community faster.  Back then, we felt that an obscure standalone
project outside Git that would help the Git-life of users have a
much better chance of surviving (and eventually be polished) if we
had them bundled, even if the code quality and stability were
sub-par.

Those young days are long gone.  A standalone tool that aims to help
users' Git-life would not just survive but flourish with much more
certainty, as long as the tool is good.  We have enough Git users to
rely on words-of-mouth these days to ensure their success.

That is why I am very hesitant to add new things to contrib/ these
days.  It is very welcome thought that you are working on improving
subtree, and eventually moving it out of contrib/.  From the point
of view of the project, either moving up (to be part of the git core
proper) or moving out (to become an independent project) is far more
preferreable than the status quo so far that was staying in contrib/
(without seeing much changes and slowly but steadily bitrotting).

If the aspiration is to move up to exit, then the quality and
stability expectation is basically the same as stuff in core, and we
need to strive to keep it stable and high quality.

On the other hand, if it is exiting by moving out, then Git-core
developers wouldn't have much say in how you would run your project.

There are obvious pros-and-cons from various points of view when
choosing between moving up and moving out:

 * If the integration between "git subtree" and the rest of the
   system is loose (in other words, if your improved version of "git
   subtree" taken from Git 2.8 is dropped into an even newer version
   of Git 2.13, or an older version like Git 2.4 for that matter, is
   it expected to work, given the promise of interface stability git
   core gives you?), there is not much technical reason why it must
   stay in core.  Of course, your improvements may need to take
   advantage of improvements on the core side and your new "git
   subtree" may start to require at least Git 2.8, or you may even
   send patches to the core side to extend and enhance the services
   you use from the core side, but as long as that happens only
   occasionally and the dependency does not require lock-step
   upgrade, we can still call such an integration "loose" and moving
   out will still be a viable possibility.

 * If there are many existing users who expect their Git to come
   with "git subtree", unbundling may inconvenience them unless we
   work closely with Distros, from which most of these users get
   their Git.

 * If you expect the pace of improvement would be far faster than
   the release schedule of git core (usually a cycle lasts for 8 to
   12 weeks), moving out would give users a shorter turnaround for
   getting new and improved "git subtree".

 * It may even turn out that the users are a lot more tolerant for
   instability (e.g. removal of rarely used features) in "git
   subtree" than they require the git core proper to be stable, in
   which case moving up (rather than moving out) to apply the same
   stability requirement to "git subtree" as the rest of the system
   would be undesirable.

 * Moving up and staying in has a big social implication. It gives
   the version that comes with git core an appearance of being
   authoritative, even when other people fork the project.

   - This discourages incompatible forks (e.g. when one such fork
     finds the need to improve the "metadata" left by merge
     operation and used by split, the resulting repository managed
     by it may no longer usable by other variants of "git subtree",
     and if there is one in-tree "authoritative" one that is
     maintained, such a fork will not get wide adoption without
     taking compatibility issues into account).

   - On the other hand, if the "authoritative" one moves too slowly,
     that may hinder progress.  An exit by "moving out" to become
     one of the projects that help people's Git-life would result in
     two or more honestly competing forks of "git subtree", which
     might give users a better end-result after a few years, even
     though the users who happened to have picked the losing side
     during these few years may end up having to rewrite the
     history.
