From: Junio C Hamano <gitster@pobox.com>
Subject: Re: v1.5.4 plans
Date: Mon, 10 Dec 2007 17:27:17 -0800
Message-ID: <7vtzmqhvgq.fsf@gitster.siamese.dyndns.org>
References: <7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
	<7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
	<7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>
	<7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>
	<7v63zjgoel.fsf@gitster.siamese.dyndns.org>
	<7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
	<7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
	<7vve78qhtf.fsf@gitster.siamese.dyndns.org>
	<7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org>
	<20071210234941.GE22254@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 11 02:27:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1tuW-0005Jr-OZ
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 02:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbXLKB11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 20:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbXLKB11
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 20:27:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbXLKB10 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 20:27:26 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B08B520A5;
	Mon, 10 Dec 2007 20:27:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1442820A2;
	Mon, 10 Dec 2007 20:27:18 -0500 (EST)
In-Reply-To: <20071210234941.GE22254@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 10 Dec 2007 18:49:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67775>

Jeff King <peff@peff.net> writes:

> A few regressions that you did not mention, but I think should be
> addressed before 1.5.4:
>
>  - extra newline in builtin-commit output. You found a case that
>    needs it, but fixing it is non-trivial, and I wanted to get your
>    input before preparing a patch. See
>
>      http://mid.gmane.org/20071203075357.GB3614@sigill.intra.peff.net

I am actually becoming somewhat fond of the newline that makes the end
of a session that led to a commit stand out ;-). IOW, I was wondering if
we can have another for a merge commit case.

But I suspect that it amounts to the change in the same area and of
similar complexity.

>  - git-clean's handling of directory wildcards. I didn't get a response
>    to
>
>      http://mid.gmane.org/20071206043247.GC5499@coredump.intra.peff.net
>
>    I suspect there are still some bugs lurking in there, but it's hard
>    to say because I don't know what the behavior _should_ be (there are
>    some test cases in that email).

The last time I looked at the "directory" side of builtin-clean.c, I had
to quickly reach for my barf bag.  I never use "git clean" without "-n"
and I never ever use "git clean" with "-d"; I do not have any idea what
behaviour when given "-d" would be useful.  AFAIU, the scripted version
did not have clear semantics either.

Another thing that irritates me is it talks about not removing a
directory when run "git clean -n" (without -d).  I did not ask it to
remove directories, so I did not expect it to talk about it not doing
what I did not ask it to.

> And perhaps not a regression, but I think we should bring git-svn's
> handling of color.* in line with the changes to the rest of the code
> before 1.5.4. I posted a "last resort" patch, but I think with your
> changes to "git config --colorbool" it might be possible to use that.
> I'll try to work up a new patch.

Thanks for a reminder.  Anything else?
