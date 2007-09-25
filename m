From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: commit when continuing after "edit"
Date: Tue, 25 Sep 2007 15:31:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709251528560.28395@racer.site>
References: <20070923224502.GB7249@potapov> <Pine.LNX.4.64.0709240121080.28395@racer.site>
 <7vlkav71bv.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709251249450.28395@racer.site>
 <46F90C95.5060903@viscovery.net> <Pine.LNX.4.64.0709251439070.28395@racer.site>
 <46F91879.6030301@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 25 16:33:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaBT4-0005ig-2v
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 16:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366AbXIYOc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 10:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753347AbXIYOcZ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 10:32:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:60460 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753295AbXIYOcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 10:32:25 -0400
Received: (qmail invoked by alias); 25 Sep 2007 14:32:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 25 Sep 2007 16:32:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19JpQxqglFJ7eo0kT1dEe7KVKnjJp/m2Np3uDChgb
	jaFDmK7Vo+isDi
X-X-Sender: gene099@racer.site
In-Reply-To: <46F91879.6030301@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59127>

Hi,

On Tue, 25 Sep 2007, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> 
> > On Tue, 25 Sep 2007, Johannes Sixt wrote:
> > > How about:
> > > 
> > > 	eval "$author_script"
> > > 	GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
> > > 	GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
> > > 	GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
> > > 	$USE_OUTPUT git commit -F "$MSG" $EDIT_COMMIT
> > > 
> > > and if you dislike that, put the two questionable lines in parenthesis.
> > 
> > That looks ugly.  I'd rather have something like
> > 
> > 	eval "$USE_OUTPUT $author_script git commit -F \"$MSG\" $EDIT_COMMIT"
> > 
> > but I'm not quite certain if that is enough, what with the funny 
> > characters people put into path names these days ($MSG points to 
> > "$DOTEST"/message).
> 
> I, too, find it ugly, but I think it's the most readable way to do it. 
> Your version is certainly underquoted.
> 
> I poked around a bit, but one major obstacle is that the assignments in 
> $author_script are on separate lines, which you would have to splice 
> into a single line before you can insert them in the eval.

But is your version not underquoted, too?  For example, if the author name 
is, say 'Johannes "Dscho" Schindelin', would your version still get the \" 
in the name?

Ciao,
Dscho
