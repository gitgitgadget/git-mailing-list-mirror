From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] allow setting GIT_WORK_TREE to "no work tree"
Date: Thu, 7 Feb 2008 12:33:16 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802071231540.8543@racer.site>
References: <20080206102608.GA1007@coredump.intra.peff.net>  <47A98F07.4000402@viscovery.net>  <20080206110131.GA4167@coredump.intra.peff.net>  <7v4pclvmae.fsf@gitster.siamese.dyndns.org>  <7vwsphu7gr.fsf@gitster.siamese.dyndns.org> 
 <20080207051317.GA32296@sigill.intra.peff.net> <76718490802062313jdbd0e84xc9f36d703bb86c44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>
To: Jay Soffian <jaysoffian+git@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 13:34:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN5xe-00011d-Vj
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 13:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755868AbYBGMeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 07:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755800AbYBGMeF
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 07:34:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:49492 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754773AbYBGMeE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 07:34:04 -0500
Received: (qmail invoked by alias); 07 Feb 2008 12:34:01 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp017) with SMTP; 07 Feb 2008 13:34:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ci3sErEhcz4lQw53grJ1Mj/8zKdIk0F+Ozdlkbh
	y8rqZ3R90M8Nyi
X-X-Sender: gene099@racer.site
In-Reply-To: <76718490802062313jdbd0e84xc9f36d703bb86c44@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72928>

Hi,

On Thu, 7 Feb 2008, Jay Soffian wrote:

> On Feb 7, 2008 12:13 AM, Jeff King <peff@peff.net> wrote:
> >
> > On Wed, Feb 06, 2008 at 12:59:32PM -0800, Junio C Hamano wrote:
> > >
> > > I was tempted to suggest GIT_WORK_TREE=/dev/null because that is
> > > what "diff" uses to mark "this does not even exist", but that
> > > feels dirty.
> >
> > It feels dirty to me, too. I would rather choose something that doesn't
> > even look like a path. I think GIT_WORK_TREE=" " is too ugly, too.
> 
> Is using something like "__GIT_WORK_TREE_NOT_SET__" that terrible?

Yes.  First: it looks more like a C constant than a proper environment 
variable.  Second: what to do _sanely_, when both GIT_WORK_TREE and 
GIT_WORK_TREE_NOT_SET are true?

Of course, you could argue that one should override the other.  But the 
consequence will be user errors that could be prevented, thus it is a 
design error.

Ciao,
Dscho
