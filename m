From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: To page or not to page
Date: Fri, 16 May 2008 11:29:17 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805161129010.30431@racer>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org> <20080502054508.GA28506@sigill.intra.peff.net> <20080502060930.GA1079@sigill.intra.peff.net> <7vd4o5xm62.fsf@gitster.siamese.dyndns.org> <20080502125553.GB2923@sigill.intra.peff.net>
 <7v1w4ky3hh.fsf@gitster.siamese.dyndns.org> <20080506055128.GA26311@sigill.intra.peff.net> <20080516044238.GA6784@sigill.intra.peff.net> <20080516045139.GA10858@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 16 12:30:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwxCQ-0003pG-Py
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 12:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518AbYEPK3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 06:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754356AbYEPK3P
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 06:29:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:36627 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754286AbYEPK3P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 06:29:15 -0400
Received: (qmail invoked by alias); 16 May 2008 10:29:12 -0000
Received: from R4f5c.r.pppool.de (EHLO racer.local) [89.54.79.92]
  by mail.gmx.net (mp045) with SMTP; 16 May 2008 12:29:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18kYclPN4wk2U9Cw9V1Ns1HmvF7GReeTdtWX8Zr/q
	hd/Ee+8kN+0g2y
X-X-Sender: gene099@racer
In-Reply-To: <20080516045139.GA10858@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82269>

Hi,

On Fri, 16 May 2008, Jeff King wrote:

> On Fri, May 16, 2008 at 12:42:38AM -0400, Jeff King wrote:
> 
> > So the logic in setup_git_env seems bogus, but should basically never 
> > be invoked because we do generally call setup_git_directory_gently 
> > before then. Either it should probably call setup_git_directory_gently 
> > (though I am afraid of what awful side effects that could have), or it 
> > should just barf, and people should do setup_git_directory beforehand 
> > (and I'm sure that will break something too).
> 
> Hrm. So there are lots of programs that actually _do_ end up needing 
> this lazy load of the git_dir, but it's just that we have 
> setup_git_directory'd ourselves into the top of the work tree by then.
> 
> So it would be nice if we could move that earlier so that the wrapper 
> could do useful things like look at the proper config. But I think that 
> opens a whole can of worms with running setup_git_directory twice, IIRC.

Yes.  There be dragons.

Ciao,
Dscho
