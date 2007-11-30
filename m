From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 16:49:26 -0800
Message-ID: <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org>
References: <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
	<fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
	<7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
	<20071129150849.GA32296@coredump.intra.peff.net>
	<fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com>
	<20071129211409.GA16625@sigill.intra.peff.net>
	<Pine.LNX.4.64.0711292218240.27959@racer.site>
	<20071129231444.GA9616@coredump.intra.peff.net>
	<alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org>
	<7veje8twt2.fsf@gitster.siamese.dyndns.org>
	<20071130003512.GB11683@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 30 01:49:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixu4p-0006GI-Eo
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 01:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763135AbXK3Atg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 19:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762828AbXK3Atf
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 19:49:35 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:38198 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758684AbXK3Atf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 19:49:35 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 6162C2EF;
	Thu, 29 Nov 2007 19:49:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 8B89B9A27F;
	Thu, 29 Nov 2007 19:49:49 -0500 (EST)
In-Reply-To: <20071130003512.GB11683@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 29 Nov 2007 19:35:12 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66582>

Jeff King <peff@peff.net> writes:

> On Thu, Nov 29, 2007 at 04:13:29PM -0800, Junio C Hamano wrote:
>
>>  - Post v1.5.5, start cooking the change that does not install hardlinks
>>    for built-in commands, aiming for inclusion in v1.5.6, in May-Jun
>>    2008 timeframe.
>
> I am still against this step, for the reasons mentioned in the mails
> leading up to the one you just quoted. I am fine with "does not install
> hardlinks for builtin-commands on systems that don't support hardlinks"
> (and of course all such hardlinks are in $(libexecdir)/git-core at this
> point).

I understand your point was primarily "git-a<tab>".  I think it has been
solved for bash and zsh but not for other shells.  I think possible and
sensible avenues are (1) punt -- cvs, svn nor hg people do not seem to
have problem with it, or (2) implement completion in your other favorite
shells.

And I think the following from Linus makes sense.

> And from a consistency standpoint, that would be a *good* thing. There are 
> many reasons why the git-xyz format *cannot* be the "consistent" form
> (ranging from the flags like --bare and -p to just aliases), so 
> encouraging people to move to "git xyz" is just a good idea.
>
> Yeah, yeah, the man-pages need the "git-xyz" form, but on the other hand, 
> rather than "man git-xyz", you can just do "git help xyz" instead, and now 
> you're consistently avoiding the dash again!

but I am feeling quite feverish today so I may be missing something
obvious.
