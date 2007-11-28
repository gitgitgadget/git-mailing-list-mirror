From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Teach 'git pull' about --rebase
Date: Wed, 28 Nov 2007 15:32:49 -0800
Message-ID: <7v1waa2bfi.fsf@gitster.siamese.dyndns.org>
References: <7v3avy21il.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0710261047450.4362@racer.site>
	<7v3aurcjpq.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711281307420.27959@racer.site>
	<27E5EF3C-19EF-441C-BB12-0F5B29BEAEDB@midwinter.com>
	<Pine.LNX.4.64.0711282039430.27959@racer.site>
	<8c5c35580711281310h8764a33pba48e65010abf859@mail.gmail.com>
	<7vhcj63uhw.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711282156520.27959@racer.site>
	<20071128223339.GF7376@fieldses.org>
	<20071128224717.GG7376@fieldses.org>
	<Pine.LNX.4.64.0711282309030.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Lars Hjemli <hjemli@gmail.com>,
	Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 29 00:33:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxWPA-0006nP-Cr
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 00:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758403AbXK1Xc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 18:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758325AbXK1Xc7
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 18:32:59 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:52406 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758280AbXK1Xc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 18:32:58 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 71DD72EF;
	Wed, 28 Nov 2007 18:33:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id BF8FC9AD04;
	Wed, 28 Nov 2007 18:33:12 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711282309030.27959@racer.site> (Johannes
	Schindelin's message of "Wed, 28 Nov 2007 23:12:32 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66462>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So my rationale was: if we already have an existing framework to integrate 
> remote changes with our current branch, why not just go ahead and use it?  
> That's the reason BTW why I originally wanted a "rebase" merge stragegy.  
> Even if it is not technically a merge.
>
> I really rather have no user-friendly support for fetch+rebase (and utter 
> a friendly, but loud curse everytime I made a "git pull" by mistake) than 
> yet another command.

I suspect that people who do not like the two modes of checkout will
certainly not appreciate the overloading two behaviours to create
different kind of histories and two different ways to continue when the
integration do not go smoothly upon conflicts these two behaviours have.

However, I agree very much with an earlier comment made by Daniel about
our UI being task oriented instead of being command oriented, and I
actually consider it a good thing.  So it does not bother me too much
that "git pull --rebase" has a quite different workflow from the regular
"merge" kind of pull.

So let's queue "pull --rebase" and see what happens.
