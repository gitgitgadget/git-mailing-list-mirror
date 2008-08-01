From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: email address handling
Date: Fri, 1 Aug 2008 15:41:37 -0700
Message-ID: <20080801154137.29c96609.akpm@linux-foundation.org>
References: <20080731194042.a1534b4d.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org>
	<20080801124550.26b9efc0.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org>
	<20080801131127.20b3acfd.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org>
	<20080801132415.0b0314e4.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org>
	<20080801135421.5ca0f6af.akpm@linux-foundation.org>
	<7vvdykqub6.fsf@gitster.siamese.dyndns.org>
	<20080801145804.85041bbd.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011507430.6819@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 00:44:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP3Ln-0003NP-I8
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 00:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758590AbYHAWmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 18:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760865AbYHAWma
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 18:42:30 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39438 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760861AbYHAWm3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2008 18:42:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71Mfci6013337
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Aug 2008 15:41:39 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m71MfbeK007561;
	Fri, 1 Aug 2008 15:41:38 -0700
In-Reply-To: <alpine.LFD.1.10.0808011507430.6819@nehalem.linux-foundation.org>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.824 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91115>

On Fri, 1 Aug 2008 15:23:23 -0700 (PDT) Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Fri, 1 Aug 2008, Andrew Morton wrote:
> > 
> > I preserve the quotes (when present) in signoffs for this exact reason.
> 
> You must be one of the few ones.

Not the only one.  See d67d1c7bf948341fd8678c8e337ec27f4b46b206,
3bf2e77453a87c22eb57ed4926760ac131c84459, ...

> According to the RFC's, you should quote 
> pretty much any punctuation mark, including "." itself. Which means that 
> things like 
> 
> 	Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> should be quoted if they were email addresses.
> 
> That would be very irritating. 

Yeah, it's ugly as sin.  But it has usability benefits.  Few people
actually need this treatment.

> It's even _more_ irritating for things like D'Souza (or Giuseppe D'Eliseo 
> to take a real example from the kernel).  For David, we could just not use 
> the "S." - for others, the special characters are very much part of the 
> name. It would also be very irritating for important messages like
> 
> 	Signed-off-by: Linus "I'm a moron" Torvalds <torvalds@osdl.org>
> 
> etc, where it sure as heck isn't a rfc2822-compliant email address.

It might be.  Look at this guy:

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

Who later did an edit and became

From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>

> So the thing is, "strict email format" is just very annoying. Git does 
> know how to do (well, it _should_) it for "git send-email", but making the 
> human-readable output ugly just because somebody might want to 
> cut-and-paste it sounds really sad.

It didn't make human-readable output ugly.  It was already ugly and it
just left it alone so it was still usable.

> You could cut-and-paste just the stuff inside the angle branckets, though. 
> That should work.

Sure.  I like to include people's names though.

Perhaps a suitable solution to all this would be to teach more things
to use .mailmap transformations and to update that file more.

otoh, if people really want to present themselves to the world in a
name-reversed, comma-stuffed, quote-wrapped form then that was their
choice..
