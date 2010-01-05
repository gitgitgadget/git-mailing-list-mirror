From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: submodules' shortcomings, was Re: RFC: display dirty submodule
 working directory in git gui and gitk
Date: Tue, 5 Jan 2010 16:30:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001051627250.3361@intel-tinevez-2-302>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de> <4B421F90.4090402@web.de> <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de> <4B42F425.4010901@web.de> <alpine.DEB.1.00.1001051032440.4985@pacific.mpi-cbg.de>
 <20100105142727.GA83546@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Jan 05 16:31:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSBN6-0008Co-AF
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 16:31:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671Ab0AEPay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 10:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754572Ab0AEPay
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 10:30:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:52630 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754535Ab0AEPax (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 10:30:53 -0500
Received: (qmail invoked by alias); 05 Jan 2010 15:30:50 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp021) with SMTP; 05 Jan 2010 16:30:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18YnA9fkXQY2BDS5zvaR2C+nox6UQQaj/Qq02ktio
	xDX4v0joUTKtC/
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20100105142727.GA83546@book.hvoigt.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136193>

Hi,

On Tue, 5 Jan 2010, Heiko Voigt wrote:

> On Tue, Jan 05, 2010 at 10:46:11AM +0100, Johannes Schindelin wrote:
> > On Tue, 5 Jan 2010, Jens Lehmann wrote:
> > > Yes. This synchronization could be either obsoleted by only using
> > > .gitmodules or automated.
> > 
> > I start to wonder whether the insistence that .gitmodules' settings must 
> > be overrideable makes any sense in practice.
> 
> I just read this and felt the need to comment.
> 
> Yes, it definitely makes sense in practise to have it overrideable
> otherwise we loose the distributed nature of git for submodules.

AFAICT you can use url.<base>.insteadOf for that.

Or maybe even better use a different remote for that, as you are likely 
wanting to stay up-to-date with the upstream projects even if you work on 
the stuff locally.

> But I know what you mean by the general confusion about manual updates.
> So how about an approach like this:
> 
> * clone will initialise all submodules in .git/config from .gitmodules
> 
> * if a change in .gitmodules happens git scans .git/config for that
>   entry and in case nothing is there it syncronises the new one and
>   notifies the user.
> 
> * if a change in .gitmodules happens and the entry before was the same
>   in .git/config we also automatically update that entry there.
> 
> * In every other case we just leave .git/config alone.

I'm sorry, but this is the kind of stuff I am seeing in Git: a lot of 
really complicated design with a lot of corner cases, put on top of a 
really simple and elegant design.

So I'd like to see a solution that is obviously superior by being 
plain simple.

Ciao,
Dscho
