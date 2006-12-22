From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: warning merge message
Date: Fri, 22 Dec 2006 23:49:54 +0100
Message-ID: <200612222349.54363.Josef.Weidendorfer@gmx.de>
References: <867728.44872.qm@web31814.mail.mud.yahoo.com> <200612222142.15489.Josef.Weidendorfer@gmx.de> <7vodpvy6sf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 23:50:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxtDS-0005FR-No
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 23:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148AbWLVWuG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 17:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753172AbWLVWuG
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 17:50:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:48682 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753148AbWLVWuF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 17:50:05 -0500
Received: (qmail invoked by alias); 22 Dec 2006 22:50:03 -0000
Received: from p5496B9D3.dip0.t-ipconnect.de (EHLO noname) [84.150.185.211]
  by mail.gmx.net (mp053) with SMTP; 22 Dec 2006 23:50:03 +0100
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.5
In-Reply-To: <7vodpvy6sf.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35242>

On Friday 22 December 2006 22:12, Junio C Hamano wrote:
> People for a long time observed "the first set of branches" rule
> was often a wrong thing to do while on a branch other than
> 'master' (but we do not want to add hardcoded 'master'
> unnecessarily), and I recently screwed up by changing the logic
> in such a way that everything is marked as not-for-merge unless
> branches.*.merge is not set when pulling from the default
> remote,

Ah, yes.

I saw your patch and thought: Wow, that means to fully throw
away the previous behavior, which could upset people ;-)
But then I thought: Hmm... probably on purpose, as this
"the first set of branches" rule really was strange.

> which was completely bogus and bitten Luben. 

So I see you actually _wanted_ to keep old behavior
for existing repositories.

In a previous discussion, you talked about switching to
the new behavior (ie. getting rid of this "first set of
branches" rule) when there is at least one branch.*.merge
setting in the config file.

Unfortunately I can not see an easy way to check this with
repo-config, as there is no wildcard support for keys
(Ok, I can do a list of keys and grep).

I think it is better to provide an option
"pull.do-not-follow-the-first-set-of-branches-rule".
And we should make this the default after init-db or clone.

Josef
