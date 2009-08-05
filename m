From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/3 v3] Use an external program to implement fetching
 with curl
Date: Wed, 5 Aug 2009 11:45:12 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908051135080.2147@iabervon.org>
References: <alpine.LNX.2.00.0907310112400.2147@iabervon.org> <alpine.DEB.1.00.0908051203550.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 05 17:45:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYigR-0004ea-8R
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 17:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933895AbZHEPpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 11:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933340AbZHEPpN
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 11:45:13 -0400
Received: from iabervon.org ([66.92.72.58]:40258 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933886AbZHEPpM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 11:45:12 -0400
Received: (qmail 13117 invoked by uid 1000); 5 Aug 2009 15:45:12 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2009 15:45:12 -0000
In-Reply-To: <alpine.DEB.1.00.0908051203550.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124918>

On Wed, 5 Aug 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Fri, 31 Jul 2009, Daniel Barkalow wrote:
> 
> > Use the transport native helper mechanism to fetch by http (and ftp, etc).
> > 
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > ---
> > Note that the bulk of remote-curl is code moved verbatim from transport.c; 
> > cleaning it up is a separate topic.
> > 
> >  Makefile      |    5 ++
> >  remote-curl.c |  139 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  transport.c   |  136 +-------------------------------------------------------
> >  3 files changed, 145 insertions(+), 135 deletions(-)
> >  create mode 100644 remote-curl.c
> 
> I wanted to suggest using the -C option so that the patch would consist of 
> mostly deleted lines (easier to verify then that it was a code move), but 
> transport.c is over 1000 lines, so that would not have worked!

Yeah; I did use -C (so patch 3 was an obvious move), but git was wiser 
than to produce a copy-and-delete-85% version anyway. Someday, I want to 
have a diff output format that makes these things clear somehow. I think 
it would be not-too-hard to get the diff code to determine that an 
addition matches or almost matches a deletion (or some unchanged code), 
and provide library access to this information, but representing it to 
humans (and getting patch to still work) is hard.

	-Daniel
*This .sig left intentionally blank*
