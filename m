From: Theodore Tso <tytso@mit.edu>
Subject: Re: [Q] Encrypted GIT?
Date: Thu, 13 Mar 2008 08:58:54 -0400
Message-ID: <20080313125853.GA12927@mit.edu>
References: <c6c947f60803130148w7981a3f0r718c0801343c7b78@mail.gmail.com> <20080313114738.GC2414@genesis.frugalware.org> <alpine.LSU.1.00.0803131254580.1656@racer.site> <20080313121644.GD2414@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Mar 13 14:00:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZn2o-0001hW-Pu
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 14:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbYCMM7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 08:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753474AbYCMM7k
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 08:59:40 -0400
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:32987 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753399AbYCMM7j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 08:59:39 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1JZn2x-0007zZ-QY; Thu, 13 Mar 2008 09:00:35 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JZn1P-0005B6-2e; Thu, 13 Mar 2008 08:58:59 -0400
Content-Disposition: inline
In-Reply-To: <20080313121644.GD2414@genesis.frugalware.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77073>

On Thu, Mar 13, 2008 at 01:16:44PM +0100, Miklos Vajna wrote:
> On Thu, Mar 13, 2008 at 12:55:11PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > The latter can be remedied (somewhat) by encrypting each object 
> > individually.  In that case, .gitattributes can help (you should be able 
> > to find a mail to that extent, which I sent no more than 2 weeks ago).  
> > However, you must make sure that the encryption is repeatable, i.e. two 
> > different encryption runs _must_ result in _identical_ output.
> 
> afaik, this is not the case for gpg.

No, and you wouldn't want to use gpg because of the overhead it adds
around an encrypted message.  You would need to use a raw encryption
algorithm, or one with very minimal wrapping.  It's normally at this
point that that you'd need to bring in a security expert to ask a
whole lot of questions about your exact use scenario, do a formal
threat analysis, since there are all sorts of unanswered questions
about what kind of key management solution you really need for your
situation.

It's usually not as simple as "just encrypt it".  How many people need
to have access to the to the repository?  Do you need to revoke access
to the repository later?  Who is allowed to give a new person access
to the repository?  etc., etc., etc.

						- Ted
