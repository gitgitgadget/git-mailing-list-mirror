From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 15:59:10 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702101554170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com> 
 <Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com> 
 <Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, GIT list <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 10 15:59:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFth7-0006M9-3Y
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 15:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbXBJO7N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 09:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbXBJO7N
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 09:59:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:54482 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932583AbXBJO7L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 09:59:11 -0500
Received: (qmail invoked by alias); 10 Feb 2007 14:59:10 -0000
X-Provags-ID: V01U2FsdGVkX18vsrsSNXcvdlBX6rPLfV+i2pEJoOFw/XUcHV/cUQ
	JLGQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39228>

Hi,

On Sat, 10 Feb 2007, Marco Costalba wrote:

> On 2/10/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Sat, 10 Feb 2007, Marco Costalba wrote:
> > > On 2/10/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > On Fri, 9 Feb 2007, Marco Costalba wrote:
> > > >
> > > > > I just need to know if current working directory is clean and report
> > > > > back to qgit user, so read-only access would be ok for me.
>
> [... talking about a patch to introduce --refresh to git-status ...]
>
> Well, I tested the patch and indeed it helps a lot ;-)

Not really. The thing is, git-status does a lot more than what you need. 
And what you need is _only_ what "git diff --name-only HEAD" does already!

It _also_ checks the index, it _also_ only checks the files with different 
stat information, but it does _not_ try to update the index and prepare a 
message to be displayed when committing.

So, what is the big problem about accepting that patching git-status for 
one obscure use is wrong, wrong, wrong, when git-diff already does what is 
needed???

Ciao,
Dscho
