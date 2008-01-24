From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Trying to get GIT running on SCO OpenServer
Date: Wed, 23 Jan 2008 16:25:01 -0800
Message-ID: <7vsl0oax42.fsf@gitster.siamese.dyndns.org>
References: <20080123212613.GN2230@yugib.highrise.ca>
	<alpine.LSU.1.00.0801232346010.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aidan Van Dyk <aidan@highrise.ca>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 24 01:25:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHpuk-0004JC-UB
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 01:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbYAXAZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 19:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752492AbYAXAZX
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 19:25:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55358 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbYAXAZX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 19:25:23 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E84E2FB5;
	Wed, 23 Jan 2008 19:25:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B0502FB4;
	Wed, 23 Jan 2008 19:25:17 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801232346010.5731@racer.site> (Johannes
	Schindelin's message of "Wed, 23 Jan 2008 23:48:16 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71579>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> FWIW we had the same problem in MinGW, and Hannes Sixt solved it:
>
> http://repo.or.cz/w/git/mingw/j6t.git?a=commitdiff;h=b8e84a68f01a2386b2071e1bdc8e24de809a3f6d
>
> That might give you an idea how to solve the issue.  Maybe you even make a 
> git patch out of it?  With a Makefile variable BROKEN_SNPRINTF=YesPlease, 
> maybe?

Hmmm.  Looking at that change makes me wonder if that solution
is Kosher.  The value of the va_list you pass to vsnprintf() is
unspecified after the call.

It may be Ok as mingw-only "compatibility wrapper", but I think
you have to be a bit careful.  It is not a general solution for
any BROKEN_SNPRINTF.
