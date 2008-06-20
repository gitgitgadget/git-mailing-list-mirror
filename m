From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/11] Introduce filter_independent() in commit.c
Date: Fri, 20 Jun 2008 13:37:23 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806201336470.6439@racer>
References: <45f73cd0355a5375dcd8a123dd0facf5cad99061.1213917600.git.vmiklos@frugalware.org> <f41fbf4630e6341ae89eacad52c465cecc605e42.1213917600.git.vmiklos@frugalware.org> <702cfa09fdf6203e1199415af21de787c4a19ead.1213917600.git.vmiklos@frugalware.org>
 <adba33a239d99b30fcccedc0638b060daec1016e.1213917600.git.vmiklos@frugalware.org> <6323597c45d409498ce231b063737bb36c52ef9f.1213917600.git.vmiklos@frugalware.org> <172740d7c998269dd0c454a1365a429acdf7cae2.1213917600.git.vmiklos@frugalware.org>
 <c83288c0995a7b4463b66e2f45d1a14839f0901c.1213917600.git.vmiklos@frugalware.org> <0d95a099ad6e47c60894983ab7bfd94a3aeddce7.1213917600.git.vmiklos@frugalware.org> <7vabhgq02p.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0806201350000.32725@wbgn129.biozentrum.uni-wuerzburg.de>
 <20080620120643.GX29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jun 20 14:40:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9fuk-0001p3-Je
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 14:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbYFTMi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 08:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbYFTMi7
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 08:38:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:54248 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752404AbYFTMi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 08:38:58 -0400
Received: (qmail invoked by alias); 20 Jun 2008 12:38:56 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp021) with SMTP; 20 Jun 2008 14:38:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19EhhEIPzpEnrBQaKKqRqxRFmKzPGaeRvM+c46BBV
	EXIv8Q0uFaXQcY
X-X-Sender: gene099@racer
In-Reply-To: <20080620120643.GX29404@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85629>

Hi,

On Fri, 20 Jun 2008, Miklos Vajna wrote:

> On Fri, Jun 20, 2008 at 01:53:06PM +0200, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > More worryingly, the flag is supposed to be cleaned from the objects 
> > > after get_merge_bases() returns.  I am not sure what you'll learn by 
> > > looking at the flag here.
> > 
> > That is a valid point, methinks.  Probably the octopus_merge_base and 
> > the cleanup have to be decoupled here.  The cleanup should be nothing 
> > more than calling clear_commit_marks() for every head.
> 
> Actually get_octopus_merge_bases() _needs_ to clean up the flags as it 
> calls get_merge_bases() multiple times and get_merge_bases() expects 
> empty flags.

Oh darn, you are right.

> > A test case would be desirable, but probably pretty complicated.  
> > Hmm.  I like tests when they are simple, because they are easy to 
> > verify by a human.  Miklos, any chance for such a test case?
> 
> Sure, I'll write one.

Thanks,
Dscho
