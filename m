From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-status producing incorrect results
Date: Thu, 14 Feb 2008 17:02:29 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802141700450.30505@racer.site>
References: <20080214164505.GA21932@coredump.intra.peff.net> <alpine.LSU.1.00.0802141650080.30505@racer.site> <20080214165432.GA28059@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 14 18:03:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPhUO-0003Qu-6c
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 18:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbYBNRCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 12:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbYBNRCd
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 12:02:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:38931 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751763AbYBNRCc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 12:02:32 -0500
Received: (qmail invoked by alias); 14 Feb 2008 17:02:31 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp027) with SMTP; 14 Feb 2008 18:02:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xtTUGcuvxFbVT5BRhvTZC+mPrSbW2d//At+K/sG
	hH039EJWer7wmO
X-X-Sender: gene099@racer.site
In-Reply-To: <20080214165432.GA28059@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73891>

Hi,

On Thu, 14 Feb 2008, Jeff King wrote:

> On Thu, Feb 14, 2008 at 04:51:04PM +0000, Johannes Schindelin wrote:
> 
> > I experienced the same bug, but when I looked in the tests, I had the 
> > impression that it tested for that very bug, and succeeded.  And I did 
> > not have time to look into it further.
> 
> Which test did you think was checking for it?

Well, I was looking at t7501-commit.sh, since I assumed that it not only 
_showed_ this status, but also _committed_ it.  I did not even bother to 
try, but aborted the commit by deleting the whole commit message.

> diff --git a/t/t7502-status.sh b/t/t7502-status.sh
> index b64ce30..11e5655 100755
> --- a/t/t7502-status.sh
> +++ b/t/t7502-status.sh
> @@ -128,4 +128,8 @@ test_expect_success 'status without relative paths' '
>  
>  '
>  
> +test_expect_success 'status of partial commit excluding new file in index' '
> +	git status modified
> +'
> +

That would need a redirection to "> output", and a known-good "expect", to 
make sure that it indeed works as expected.

Ciao,
Dscho
