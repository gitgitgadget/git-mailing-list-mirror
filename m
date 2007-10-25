From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach 'git pull' the '--rebase' option
Date: Thu, 25 Oct 2007 16:54:58 -0700
Message-ID: <7v3avy21il.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0710252351130.4362@racer.site>
	<alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org>
	<Pine.LNX.4.64.0710260007450.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 26 01:55:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlCXr-0000Br-3Q
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 01:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756372AbXJYXzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 19:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756406AbXJYXzJ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 19:55:09 -0400
Received: from rune.pobox.com ([208.210.124.79]:34205 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756296AbXJYXzI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 19:55:08 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 558BD15015B;
	Thu, 25 Oct 2007 19:55:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7340C14FBA3;
	Thu, 25 Oct 2007 19:55:22 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0710260007450.4362@racer.site> (Johannes
	Schindelin's message of "Fri, 26 Oct 2007 00:10:08 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62387>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 25 Oct 2007, Linus Torvalds wrote:
>
>> On Thu, 25 Oct 2007, Johannes Schindelin wrote:
>> > 
>> > This behavior is more desirable than fetch + pull when a topic branch
>> > is ready to be submitted.
>> 
>> I'd like there to be some *big*warning* about how this destroys history 
>> and how you must not do this if you expose your history anywhere else.
>> 
>> I think it's a perfectly fine history, but if you have already pushed out 
>> your history somewhere else, you're now really screwed. In ways that a 
>> *real* merge will never screw you.
>> 
>> So the "--rebase" option really is only good for the lowest-level 
>> developers. And that should be documented.
>
> Fair enough.
>
> How about this in the man page:
>
> \--rebase::
> 	Instead of a merge, perform a rebase after fetching.
> 	*NOTE:* Never do this on branches you plan to publish!  This
> 	command will _destroy_ history, and is thus only suitable for
> 	topic branches to be submitted to another committer.

Nits.

(1) This "operation" will "rewrite"  history.

    You are not describing a command, but just one mode of operation
    of a command, whose other modes of operation do not share this
    history altering behaviour.

    The history is rewritten and made hard to work with for others
    who have previous incarnation of that history.  If it happens
    that nobody shared that previously published history nobody
    needs to suffer.  In that sense, there is something _usable_
    depending on who you are.  Destroy feels a bit too strong a
    word.

(2) This is not suitable for people who publish their trees and
    let others fetch and work off of them.

    Rebase is fine for e-mail submitting contributors as your
    description above suggests, but as your proposed commit log
    message said, it is also perfectly appropriate if your
    interaction with the outside world is "fetch + rebase +
    push".  You are not limited to "submitted to another
    committer".
