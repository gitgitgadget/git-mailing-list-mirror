From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: CRLF problems with Git on Win32
Date: Wed, 9 Jan 2008 18:22:19 +0300
Message-ID: <20080109152219.GD23659@dpotapov.dyndns.org>
References: <C3AA823B.10C50%jefferis@gmail.com> <alpine.LSU.1.00.0801091401101.31053@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gregory Jefferis <jefferis@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 09 16:23:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCclf-0007jL-3W
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 16:22:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613AbYAIPW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 10:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754592AbYAIPW3
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 10:22:29 -0500
Received: from smtp03.mtu.ru ([62.5.255.50]:49408 "EHLO smtp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754504AbYAIPW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 10:22:28 -0500
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id 2EC36187071E;
	Wed,  9 Jan 2008 18:22:27 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-188-167.pppoe.mtu-net.ru [85.141.188.167])
	by smtp03.mtu.ru (Postfix) with ESMTP id 0E10D187057A;
	Wed,  9 Jan 2008 18:22:27 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JCcl1-0000EG-US; Wed, 09 Jan 2008 18:22:19 +0300
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801091401101.31053@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69997>

On Wed, Jan 09, 2008 at 02:03:32PM +0000, Johannes Schindelin wrote:
>
> On Wed, 9 Jan 2008, Gregory Jefferis wrote:
> 
> > crlf=safe [i.e. munging CRLFs only if there are no bare LFs] sounds 
> > appealing to me as well because it looks like munging that is always 
> > reversible.
> 
> There is a bigger problem here, though: As of now, you can add a (loose) 
> object from a big file pretty easily even on a small machine, because you 
> do not need the whole buffer, but you stream it to hash-object.  IIRC 
> Junio wrote a patch to allow this with "git-add", using fast-import, but 
> that patch probably hasn't been applied.

I don't think that crlf=safe requires that the whole file was put into
the buffer. It can work with stream, but it will call die() if a file
that was detected as text has a naked LF.

Dmitry
