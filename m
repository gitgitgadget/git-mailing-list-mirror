From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Minor annoyance with git push
Date: Sun, 10 Feb 2008 14:59:18 -0800
Message-ID: <7vzlu8cta1.fsf@gitster.siamese.dyndns.org>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
	<20080209030046.GA10470@coredump.intra.peff.net>
	<6B804F0D-9C3B-46F3-B922-7A5CBEF55522@zib.de>
	<alpine.LSU.1.00.0802091307160.11591@racer.site>
	<7v7ihd7ee1.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0802100213330.11591@racer.site>
	<0DE4061C-7189-4932-AA3D-D09009F753F2@wincent.com>
	<alpine.LSU.1.00.0802101625200.11591@racer.site>
	<07136779-23EB-4DAA-84C3-D54B7AC029AB@wincent.com>
	<20080210223440.GA15051@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 00:01:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOLA9-0002KJ-Db
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 00:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbYBJW7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 17:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752971AbYBJW7m
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 17:59:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54390 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbYBJW7l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 17:59:41 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A5462FCF;
	Sun, 10 Feb 2008 17:59:36 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D9F8C2FCE;
	Sun, 10 Feb 2008 17:59:25 -0500 (EST)
In-Reply-To: <20080210223440.GA15051@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 10 Feb 2008 17:34:40 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73432>

Jeff King <peff@peff.net> writes:

> ... Are there any
> other git commands which use non-HEAD branches that have not been
> explicitly mentioned by the user?  I can think only of query-type
> commands (like show-branch, or describe) that are non-state-changing.

That's an irrelevant comparison.  push and fetch have always
been multi-branch operations by default from day one.  The issue
is not HEAD vs non-HEAD.

You can argue that historically established practices do not
matter at all (at least to new people), and I'd grant that it
may be a valid argument.  But a change that breaks existing
practices needs to be sold much more carefully.  I still do not
understand what the opposition is to keep the current behaviour
as the default and have a shorthand for the single head push
accessible with a short and sweet "git push $there HEAD" (and
default $there to 'origin' when missing).

If you are introducing a new behaviour, there is no way the new
behaviour can start out by replacing the longtime default.  It
should start out as an option, and if it is a commonly useful
option then make it an _easily accessible_ option.  And accept
such an _enhancement_ sooner to help people who want such a
behaviour sooner.  That would not hurt anybody but help
(hopefully) many people, without downside.

Switching the default behaviour is a much longer term thing.  It
definitely has downside people mentioned in this thread.
