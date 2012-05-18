From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-sh-setup: work around Cygwin path handling
 gotchas
Date: Thu, 17 May 2012 19:34:03 -0700
Message-ID: <7vehqib4kk.fsf@alter.siamese.dyndns.org>
References: <4FB09FF2.70309@viscovery.net>
 <1337191208-21110-1-git-send-email-gitster@pobox.com>
 <1337191208-21110-3-git-send-email-gitster@pobox.com>
 <CAAXzdLW5VYnHc41WZ0id=4Qe17dHSj4+J9tqVvG-PvtpXLmh+Q@mail.gmail.com>
 <7vd364c5kt.fsf@alter.siamese.dyndns.org>
 <4FB58678.1050009@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Penny <svnpenn@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri May 18 04:35:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVD2S-0003Le-Ti
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 04:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030664Ab2ERCf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 May 2012 22:35:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48188 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030509Ab2ERCfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2012 22:35:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E42B88B5A;
	Thu, 17 May 2012 22:35:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bteJZ4YufML75HAH+9nvymvFU5Y=; b=cml5l1
	935abZzDauFq4vJo4JSiybXcSK3lYr6obHIqeTrnJXc1W7A7MBj8YJ6o6W/8wCYx
	d+E6NjjoiBOyszHsyNzX+gsG6zQJ5/g51IJ6CtLx8k58fEz2SK4vszD1ExeE4ycn
	rAbGiobLlzlyLVj/G3FE7gpzbYR0ZBtjfUHos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DomhawYgGYn+KyV6oRsBzoli4r8P5wLz
	GRXec+2dAjVjXp79VV6CiZx72qWKVhc08NoQ+U+3XqferEW2+1u9J4DzJ4kwshG+
	P4KLwArKucNPL1DHeA8iDVxWX651nukBNq6Q9pV6WIGFhn6UUcXjeLD0mZwjCX9W
	FzzlYMOiBLc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9F8D8B59;
	Thu, 17 May 2012 22:35:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 726678B3E; Thu, 17 May 2012
 22:34:57 -0400 (EDT)
In-Reply-To: <4FB58678.1050009@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Fri, 18 May 2012 00:15:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F9313CA-A092-11E1-8094-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197935>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> I guess you won't be shocked to hear that I don't think this patch is
> necessary. :-P

That is more or less irrelevant, not in the sense that what you say is
irrelevant, but in the sense that something can be worked around in a
different way alone is not a good reason to reject a patch, if its benefit
outweigh its costs.

The more important message for you to respond to is this one:

    Subject: Re: Git commit path vs rebase path
    To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
    Cc: Johannes Sixt <j.sixt@viscovery.net>,
            Steven Penny <svnpenn@gmail.com>,
            Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
    Date: Thu, 17 May 2012 12:19:33 -0700
    Message-ID: <xmqqfwayobsq.fsf@junio.mtv.corp.google.com>

> My concerns about this patch include:
>
>     - the additional fork+exec overhead associated with calling cygpath.
>       I'm not actually claiming there is any substantial increase; I
>       haven't tried it, so I don't know how "hot" the pwd() function is.
>
>     - this is a "big hammer" which will affect much more code that is
>       required to fix this problem.

If I speculated in the other message is correct (in short, "In Cygwin
world, Git is compiled to use POSIX paths and would not work with Windows
paths."), I think this "problem" is fundamentally un"fix"able.

And from Cygwin Git, your programs (like $EDITOR and hooks) will get POSIX
paths.  It is your programs' responsibility to turn them into Windows
paths if/as necessary.

> Anyway, I applied this patch tonight to give it a go. The very first test
> I tried failed. I've attached the log of the failing test below.
> Note that it is attempting to use "ssh" to a "host" that ends in ".../C:".

Of course.  That is one typical symptom that suggests my speculation was
correct.

So "I don't think this patch is necessary" is irrelevant, but "This patch
is harmful; Git on Cygwin is never supposed to use Windows paths" is very
relevant ;-)
