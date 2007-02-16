From: Bill Lear <rael@zopyra.com>
Subject: Re: Dangers of working on a tracking branch
Date: Fri, 16 Feb 2007 09:27:45 -0600
Message-ID: <17877.52593.509791.685008@lisa.zopyra.com>
References: <17876.51013.561979.431717@lisa.zopyra.com>
	<Pine.LNX.4.64.0702151557410.1757@xanadu.home>
	<17876.52962.662946.582507@lisa.zopyra.com>
	<17876.53654.426022.454712@lisa.zopyra.com>
	<er333i$787$1@sea.gmane.org>
	<17877.51730.418633.750922@lisa.zopyra.com>
	<20070216152130.GA7086@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 16:27:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI502-0000or-FV
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 16:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945925AbXBPP1r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 10:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945922AbXBPP1r
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 10:27:47 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61182 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945925AbXBPP1r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 10:27:47 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1GFRjb16283;
	Fri, 16 Feb 2007 09:27:45 -0600
In-Reply-To: <20070216152130.GA7086@coredump.intra.peff.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39921>

On Friday, February 16, 2007 at 10:21:30 (-0500) Jeff King writes:
>On Fri, Feb 16, 2007 at 09:13:22AM -0600, Bill Lear wrote:
>
>> % git pull ../peer_repo topic:topic
>> [...]
>> * refs/heads/topic: not updating to non-fast forward branch 'topic' of ../peer_repo
>> [...]
>> So, why does it say "not updating to non-fast forward branch", yet
>> it does the merge and gets the changes anyway?
>
>Because your pull command really means "merge in the topic branch from
>peer_repo, and while you're at it, store it in my local tracking branch
>topic". Remember that pull is really a fetch+merge. But the fetch is
>actually doing _two_ things: putting the fetched branch into FETCH_HEAD,
>and putting it in into refs/heads/topic. The latter fails (because of a
>non-fastforward), but pull actually uses the FETCH_HEAD results to
>do the merge.
>
>Yes, this seems overly complex for what you're doing, but the reason for
>FETCH_HEAD is to support pulls when you _don't_ have a tracking branch
>at all (i.e., 'git pull ../peer_repo topic').

Ok, fair enough, but then I guess I'm back to my original question:
how can I give a concrete demonstration to our developers that this is
a bad thing?

This is not 100% required, so if you are tired of answering my
incessant questions, feel free to decline.  I will be able to get our
group to move forward, simply because we need to try to stay current,
and there are lots of improvements in git besides this issue.


Bill
