From: Ben Clifford <benc@hawaga.org.uk>
Subject: Re: git /objects directory created 755 by default?
Date: Thu, 22 Dec 2005 13:16:16 +0930 (CST)
Message-ID: <Pine.OSX.4.64.0512221248260.6087@piva.local>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com> 
 <7vacevgwqr.fsf@assigned-by-dhcp.cox.net>  <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
  <46a038f90512201828w618a64dexc22a64b8b6bc2b70@mail.gmail.com> 
 <7vacevdoti.fsf@assigned-by-dhcp.cox.net> <46a038f90512202115o652d8e00v86182302513d1319@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 23 02:23:10 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Epbe9-0001WU-40
	for gcvg-git@gmane.org; Fri, 23 Dec 2005 02:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbVLWBWm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 20:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVLWBWm
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 20:22:42 -0500
Received: from mundungus.clifford.ac ([81.187.211.39]:34067 "EHLO
	mundungus.clifford.ac") by vger.kernel.org with ESMTP
	id S1751223AbVLWBWm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 20:22:42 -0500
Received: from piva.local (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id jBN1KMso022720;
	Fri, 23 Dec 2005 01:20:24 GMT
Received: by piva.local (Postfix, from userid 501)
	id 4D8F4C7A488; Thu, 22 Dec 2005 13:16:16 +0930 (CST)
Received: from localhost (localhost [127.0.0.1])
	by piva.local (Postfix) with ESMTP id 9CA7AC7A468;
	Thu, 22 Dec 2005 13:16:16 +0930 (CST)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90512202115o652d8e00v86182302513d1319@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13980>


> Could git-shell also be used by a SourceForge-like project, offering
> per-developer git repositories? If they are using the (BSDish?)
> convention of not having a group per user this could backfire.
>
> Does any unix these days _not_ use a group per user?

At least two reasonably sized shops that I have worked with previously do 
not have group-per-user (and I think two others but I cannot remember 
about those) - they have centrally administered user accounts and just 
have groups like 'i am in department X', or 'I am allowed to write into 
$SOMEPROJECT cvs'.

But that's not a per-unix decision, its a per-organisation administrative 
decision.

In any case, their usage of groups wrt shared CVS would not have a problem 
with a 77x mask, though there might be problems (I haven't thought about 
it enough) with the setgid(?) bit on directories - we used to hit this 
occasionally in CVS when a directory would end up being created with a 
user's primary group rather than the 'I am allowed to write into CVS' 
group. There is too much wine in me at the moment to work out if its also 
a problem for git...

-- 
