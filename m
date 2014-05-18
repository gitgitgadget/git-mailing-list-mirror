From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Sun, 18 May 2014 16:05:58 -0700
Message-ID: <xmqq7g5i4r48.fsf@gitster.dls.corp.google.com>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
	<20140516084126.GB21468@sigill.intra.peff.net>
	<xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
	<537693aee4fdd_3e4812032fcc@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 01:14:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmAHa-0003xF-G3
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 01:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbaERXOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 19:14:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52923 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152AbaERXOK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 19:14:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 881DB19055;
	Sun, 18 May 2014 19:14:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=mZYv+X8ZKTQ3t17ovJgRCompOlA=; b=Tx/MyVecsni56ruwv5/C
	TCibrCJnVlywLEtJA7oh78lawzVi4/mLpesCietpsfF1Xh7wpPHu8n3728nTT3PN
	roftOlQA5h8IlAaGy2Zx3BBbp19a28eYokAmvimZrJEXwEsZLcJRrULqWkUN1r9H
	I0CsGJl9u2hLtgaSdP15VV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=L0ZwYzlrbcFYt1xiNuS7e+RVk4eGc+UTR57lDBjoxMOVCn
	FYdSRhxLDBPxQDqIYzzoAjfqSSzpz0LE+g0tdKLuexKc3c2ek3gYEn42hUR/SkPM
	AOqiWFlu4PsO9IMjswhA7+VW+qGb1XcqHrxuykK8mGYSCPrMVPndZ8u9andLQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7E9F319054;
	Sun, 18 May 2014 19:14:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9DBE219051;
	Sun, 18 May 2014 19:14:01 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 191D68C4-DEE2-11E3-A55E-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249551>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> > But that being said, this is Felipe's code. While we have a legal right
>> > to distribute it in v2.0, if he would really prefer it out for v2.0, I
>> > would respect that.
>> 
>> I am fine with that.
>
> Are you? Because in two of the three options you list below you wouldn't
> be doing that.

"that" does not refer to "remove them at v2.0 (unconditional)".  It
refers to "If Felipe really wants for the removal for v2.0, I would
respect that".  And I saw you said you did not want to disrupt v2.0.

If the options I listed all meant removal at v2.0, then I would
understand your complaints, but that is not the case, so I am not
sure what to make of that.

> The fact of the matter is that users cannot depend on packages any more.
> Maybe they'll be packaged, maybe not. If they are it will take a long
> time before they do. In the meantime they'll have to manually install
> them all all out-of-tree tools.

I have always thought that distro packagers are the biggest ally us
project leaders have.  They locate useful pieces of software,
massage them into a shape that fit their distro well and deliver
what we write to their audience.  Packaging stuff that are useful to
their end-users is what they do best, and not leaving useful stuff
unpackaged is in their best interest.

Your statement makes it sound like they are incompetent lazy fools
who do not know what is useful for their users.

I find it disturbing to see such a distrust.  Or am I being too
naive to have too much faith in packaging folks?

I checked the list of packages that depend on "git" on one of my
boxes (it is a bit old Ubuntu).  I of course expected that many of
them are what comes from our tree split into their own "niche tool"
packages (e.g. git-svn, git-gui, gitweb...), but I was pleasantly
surprised to see many that I haven't even aware of being packaged.
Of course, "tig" is among the packages that depend on us which I am
happy to see.

There are things of somewhat questionable value I saw in the list,
of course.  It is already 2014, and I feel fairly safe to feel that
I can say without offending too many people that I doubt "git-arch"
would be on such a list of packages distros offer to their users, if
it were written as a third-party plug-in today.

It is an (odd) example of a package that is still there mostly by
inertia at this point, and that inertia comes from many things.  It
is in our tree outside contrib/, it was found useful once in the
past and was packaged, the packager already has infrastructure to
cut a separate package out of our tree, and it is more trouble to
retire it and risk breaking minority users than just keep shipping
it.

But hg is not in a situation similar to tla, is it?  I simply cannot
imagine "there is no history worthwhile to salvage out of Mercurial
repositories" coming anytime in the near future.

After looking at the reverse-depends list of packages, my faith is
strengthened in that the Git ecosystem is truly maturing and useful
third-party plug-ins will be picked up by distro packagers.

Am I delusional?
