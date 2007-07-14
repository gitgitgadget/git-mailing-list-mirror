From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] make git-send-email.perl handle email addresses with
	no names when Email::Valid is present
Date: Fri, 13 Jul 2007 21:00:50 -0700
Message-ID: <20070714040050.GA11773@kroah.com>
References: <20070713041749.GA28824@kroah.com> <7vr6ncrh22.fsf@assigned-by-dhcp.cox.net> <20070713063414.GN24317@kroah.com> <20070713182818.fd37372f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-From: git-owner@vger.kernel.org Sat Jul 14 06:01:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9Yoo-00035Z-Qw
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 06:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbXGNEBQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 00:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbXGNEBQ
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 00:01:16 -0400
Received: from canuck.infradead.org ([209.217.80.40]:44345 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbXGNEBP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 00:01:15 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174] helo=localhost)
	by canuck.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1I9Yob-0007r3-01; Sat, 14 Jul 2007 00:01:05 -0400
Content-Disposition: inline
In-Reply-To: <20070713182818.fd37372f.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52437>

On Fri, Jul 13, 2007 at 06:28:18PM +1000, Stephen Rothwell wrote:
> On Thu, 12 Jul 2007 23:34:14 -0700 Greg KH <greg@kroah.com> wrote:
> >
> > On Thu, Jul 12, 2007 at 10:47:17PM -0700, Junio C Hamano wrote:
> > > Greg KH <greg@kroah.com> writes:
> > > 
> > > > When using git-send-email.perl on a changeset that has:
> > > > 	Cc: <stable@kernel.org>
> > > > in the body of the description, and the Email::Valid perl module is
> > > > installed on the system, the email address will be deemed "invalid" for
> > > > some reason (Email::Valid isn't smart enough to handle this?) and
> > > > complain and not send the address the email.
> > > 
> > > That appears to be the case.
> > > 
> > >         bad foo
> > >         bad <foo@bar.baz>
> > >         ok  foo@bar.baz
> > >         ok  Foo <foo@bar.baz>
> 
> This would be a bug in Email::Valid as it complains that the second
> address fails the rfc822 check, however rfc822 says that the "display
> name" before the '<' is optional.

I agree, do you know how to get such a fix made?

thanks,

greg k-h
