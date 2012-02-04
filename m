From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Push from an SSH Terminal
Date: Sat, 04 Feb 2012 00:16:05 -0800
Message-ID: <7vhaz7hv3u.fsf@alter.siamese.dyndns.org>
References: <CAG94OYxX5foffvaFLQv7=wXguGC2TLgccdDFrC+ERzv_gXZ=ug@mail.gmail.com>
 <21607.38.96.167.131.1328286083.squirrel@mail.lo-cal.org>
 <CAG94OYxbOYCjd5qNBh8EF2gyezHWMqX1-R2MYgk8gkFYcrMjuQ@mail.gmail.com>
 <34592.38.96.167.131.1328289027.squirrel@mail.lo-cal.org>
 <20120203213654.GD1890@sigill.intra.peff.net>
 <7vwr83hwg0.fsf@alter.siamese.dyndns.org>
 <20120204080910.GA28317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	Neal Groothuis <ngroot@lo-cal.org>,
	Feanil Patel <feanil@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 04 09:16:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtan8-0006lc-Bb
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 09:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391Ab2BDIQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 03:16:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50696 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751839Ab2BDIQI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 03:16:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFD444085;
	Sat,  4 Feb 2012 03:16:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iAbAL3FRr2wgSu8EDU2Pmin4M2I=; b=kNwrmg
	SfVhZ3dwUD4pa1d4qiuhDIhNPXJtP7NIcAQPhPIPg7bKSp+g0F4NL9lyDxbrGzfU
	o++uhTzTcZ5oOSB4AJnjY5dxj9ww4ScH2qvV2/OoQ/U9sSPaA5JeR3HFEjiWHS/7
	TrfwK2zmdlNUR4PJOl8v7NVSIHLez7MxP5Bkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oU8W7B8TqTxRJQHcQRbfZqRMqS2Wx5vv
	wNqj3KUiyxzkUFCBoGlVaP+tokP1mUNHS5qWAx25sx0HWgf9TU1p7aD2v+L2QG0f
	ngwR/0kXFh5bZrERf7n3EfuxiPfh4TAQyUTsqxb5NueFZ/EJ6yVwXGBc7XoEr3/+
	2eH9j9CzV+8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6F2D4084;
	Sat,  4 Feb 2012 03:16:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 657BB4083; Sat,  4 Feb 2012
 03:16:07 -0500 (EST)
In-Reply-To: <20120204080910.GA28317@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 4 Feb 2012 03:09:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7D12AEAA-4F08-11E1-8BB0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189860>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 03, 2012 at 11:47:11PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>  ...
>> How well would it mesh with the goal of the ss/git-svn-prompt-sans-terminal
>> topic, which is now stalled [*1*]?  I do not mean this change and the other
>> topic textually conflict with each other---but the philosophies of this
>> topic and the other one seem to conflict.
>
> I don't see a conflict in the two series. That one seems to do two
> things for perl programs ...

That is the "[not] textually conflict" part of my message.

> If you look into the original complaint mentioned in the commit
> messages, though, you will see that the some GUIs will appear to hang
> when the terminal is prompted (because the prompt is reading from some
> location invisible to the user). So in that sense, my patches could be a
> regression for those users, as outright failing is better for them.

Yes, that is what I meant by "philosophies conflict".

> But I would argue that the bug is not prompting on the terminal, but
> rather that the terminal-prompting code does not recognize when there is
> no terminal connection to the user (and AFAICT, this is a Windows
> problem). Any solution that doesn't fix that is really just papering
> over the problem, and hurting people[1] on sane systems.
>
> So I'd rather see the version of getpass() in compat/mingw.c better
> learn to realize when we aren't actually connected to a console.

That is a sane diagnosis, I'd have to agree.

Thanks for a dose of sanity.

> [1] The amount of hurt is relatively small, though. It only hurts people
>     who set GIT_ASKPASS but can't use it (e.g., you set it in your
>     .bashrc because you connect via "ssh -X", but this time you happen
>     to be ssh-ing from a Windows box). And you can generally fix that
>     outside of git (e.g., by checking $DISPLAY before setting the
>     variable).
>
>     So one one hand, I don't want to make a decision on behavior for
>     Unix users because we have to cater to Windows shortcomings. On the
>     other hand, while fixing the root problem is preferable, if
>     for whatever reason we can't reliably find out whether the user is
>     actually going to see and respond to the prompt on Windows, it may
>     be practical to just paper over the issue. On the gripping hand,
>     after the Sven's series, TortoiseGit users would see the hang
>     (instead of a failure) _only_ if their askpass command failed. Which
>     is also perhaps not that big a deal.

Wow, you do have many hands ;-).
