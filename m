From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make 'git fsck' complain about non-commit branches
Date: Wed, 16 Jan 2008 11:59:41 -0800
Message-ID: <7vk5m9pmmq.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801151618300.2806@woody.linux-foundation.org>
	<7v8x2qd2hu.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801151654050.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 21:00:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFERE-0005jd-Je
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 21:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbYAPT7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 14:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbYAPT7s
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 14:59:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63587 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbYAPT7r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 14:59:47 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D7273439A;
	Wed, 16 Jan 2008 14:59:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5978D4399;
	Wed, 16 Jan 2008 14:59:43 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801151654050.2806@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 15 Jan 2008 17:01:57 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70734>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 15 Jan 2008, Junio C Hamano wrote:
>> 
>> So far, the plumbing level did not care much about the Porcelain
>> convention, such as refs/heads and refs/remotes (you seem to
>> have forgot) are about "branches" and must point at commit
>> objects.
>
> Yeah. I'm not sure this is all a great idea, but I think they are correct 
> (and no, "refs/remotes/" would *not* have been correct). 

If we take that "plumbing knows much more about Porcelain
convention" shift-of-paradigm all the way, refs/remotes/ would
contain what are copied from refs/heads/ elsewhere, so checking
would have been correct.  If you are saying that we are not
prepared to take the change that far (which I tend to agree
with, as I like to keep the door open for people to do things
that at the first sight seem insane but later turns out to be
useful in workflows we haven't imagined so far), I'd agree that
not insisting on commitness under refs/remotes/ is correct.

Is that where your "refs/remotes would *not* have been correct"
comes from, or did I miss something more fundamental?
