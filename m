From: Greg KH <greg@kroah.com>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Tue, 19 Apr 2005 15:33:03 -0700
Message-ID: <20050419223303.GB25966@kroah.com>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com> <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <20050419194728.GA24367@kroah.com> <Pine.LNX.4.58.0504191316180.19286@ppc970.osdl.org> <20050419214009.GA25681@kroah.com> <Pine.LNX.4.58.0504191449270.2274@ppc970.osdl.org> <20050419222738.GA14566@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 00:29:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1De-00061C-UB
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVDSWdd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 18:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVDSWdd
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 18:33:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:26316 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261703AbVDSWda (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 18:33:30 -0400
Received: from [192.168.0.10] (c-24-22-118-199.hsd1.or.comcast.net [24.22.118.199])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j3JMXPi31570;
	Tue, 19 Apr 2005 15:33:25 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DO1HE-5bq-00; Tue, 19 Apr 2005 15:33:04 -0700
To: Daniel Jacobowitz <dan@debian.org>
Content-Disposition: inline
In-Reply-To: <20050419222738.GA14566@nevyn.them.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2005 at 06:27:38PM -0400, Daniel Jacobowitz wrote:
> On Tue, Apr 19, 2005 at 03:00:04PM -0700, Linus Torvalds wrote:
> > 
> > 
> > On Tue, 19 Apr 2005, Greg KH wrote:
> > > 
> > > It looks like your domain name isn't set up properly for your box (which
> > > is why it worked for you, but not me before, causing that patch).
> > 
> > No, I think it's a bug in your domainname changes. I don't think you
> > should do the domainname at all if the hostname has a dot in it.
> > 
> > Most machines I have access to (and that includes machines that are
> > professionally maintained, not just my own cruddy setup) says "(none)" to
> > domainname and have the full hostname in hostname.
> > 
> > And even the ones that use domainname tend to not have a fully qualified 
> > DNS domain there. You need to use dnsdomainname to get that, and I don't 
> > even know how to do it with standard libc.
> > 
> > So how about something like this?
> > 
> > (Somebody who actually knows how these things should be done - please feel 
> > free to pipe up).
> 
> The glibc documentation blows for this, but what getdomainname comes
> from uname(2), not from any DNS-related configuration.  Debian only
> ever sets this if you're using NIS.

Well, somehow Gentoo sets this up properly, and I'm not using NIS.  Hm,
my SuSE boxes on the other hand...

> There's no real great way to get the current hostname; a lot of
> applications do a reverse DNS lookup on the primary network interface,
> with appropriate handwaving to define primary.
> 
> Easiest might be to punt to hostname --fqdn, or an equivalent to its
> algorithm - which appears to be fetch the hostname from uname, do a DNS
> lookup on that, and a reverse DNS lookup on the result.

Ick.  Let's stick with Linus's patch for now...

thanks,

greg k-h
