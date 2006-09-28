From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 21:26:55 -0600
Message-ID: <20060928032655.GB3650@socrates.priv>
References: <BAYC1-PASMTP06CEC55B088A0817EB52CBAE1B0@CEZ.ICE>
 <20060928024938.46785.qmail@web51009.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Sep 28 05:23:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSmV8-0008L3-0A
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 05:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245AbWI1DXq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 23:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbWI1DXq
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 23:23:46 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:57056 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S965245AbWI1DXq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 23:23:46 -0400
Received: from pd3mr7so.prod.shaw.ca (pd3mr7so-qfe3.prod.shaw.ca [10.0.141.23])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0J6A007R89FLAH20@l-daemon> for git@vger.kernel.org; Wed,
 27 Sep 2006 21:23:45 -0600 (MDT)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
 by pd3mr7so.prod.shaw.ca (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar
 15 2004)) with ESMTP id <0J6A00H0V9FL1D80@pd3mr7so.prod.shaw.ca> for
 git@vger.kernel.org; Wed, 27 Sep 2006 21:23:45 -0600 (MDT)
Received: from socrates.priv ([68.148.44.50])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0J6A00MDQ9FJLX11@l-daemon> for git@vger.kernel.org; Wed,
 27 Sep 2006 21:23:45 -0600 (MDT)
Received: from socrates.priv (localhost [127.0.0.1])
	by socrates.priv (8.13.4/8.13.4) with ESMTP id k8S3QtqD009531	for
 <git@vger.kernel.org>; Wed, 27 Sep 2006 21:26:55 -0600
Received: (from cougar@localhost)	by socrates.priv (8.13.4/8.13.4/Submit)
 id k8S3Qt2v009530	for git@vger.kernel.org; Wed, 27 Sep 2006 21:26:55 -0600
In-reply-to: <20060928024938.46785.qmail@web51009.mail.yahoo.com>
To: git@vger.kernel.org
Mail-followup-to: git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.11-2006-05-17
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27974>

On Wed, Sep 27, 2006 at 07:49:37PM -0700, Matthew L Foster wrote:
> How does git ensure that the timestamp in a commit records when it was
> actually created?
Git doesn't try. Git would be perfectly happy if time(2) returned a
random value each time. No part of git uses the time in any meaningful
way, it just keeps a record of it to display.

> I am not saying throw away creation time, just that local time is more
> preferable and relevant and git/gitweb.cgi should not in any way
> depend on time being configured correctly on each and every git
> server.
git and gitweb.cgi DO NOT in any way depend on time being configured
correctly. If some machine has incorrectly configured time, then they
will *correctly* display the strange time. 

> I think users of kernel.org's repo (or web interface) care
> more about when change X was commited to it than when an author
> created/emailed change X, but perhaps I am wrong or don't understand
> git or both. 
Based on comments on this list, it appears that most people don't aren't
interested in when exactly a given change hits kernel.org. Several
people have pointed out ways to get at the information you want, but
none of have seen a need for the information, and so haven't the
motivation to implement.

It might help if you gave a use case for the information you want. If
you give us a problem that you think the information will solve, the
list will probably be able to you how to get at the information you
want.

I think you have some misconception of how git works. Git is designed to
not lose information. Once a commit is created it is immutable,
regardless of whether the time is wrong, or the author, or the commit
message, or any bugs in the commit. This is a *feature*. It means you
need to go out of your way to destroy history.

> -Matt

  Tom
