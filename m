From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/2] Allow git-apply to ignore the hunk headers (AKA
 recountdiff)
Date: Fri, 6 Jun 2008 15:00:59 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806061500290.1783@racer>
References: <alpine.DEB.1.00.0806051115570.21190@racer>  <4847F49F.8090004@viscovery.net>  <alpine.DEB.1.00.0806051548140.21190@racer>  <48480123.7030903@viscovery.net>  <alpine.DEB.1.00.0806051719170.21190@racer>  <alpine.DEB.1.00.0806051720070.21190@racer>
  <7vabhz1t2f.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0806052304300.21190@racer>  <alpine.DEB.1.00.0806060005581.21190@racer>  <alpine.DEB.1.00.0806060006370.21190@racer> <5d46db230806052218r67e79a46rd0150cd9fe2af970@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Govind Salinas <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 16:03:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4cXG-0005VE-Q0
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 16:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754822AbYFFOC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 10:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbYFFOCZ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 10:02:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:45272 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755365AbYFFOCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 10:02:25 -0400
Received: (qmail invoked by alias); 06 Jun 2008 14:02:23 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 06 Jun 2008 16:02:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+J3XoJWlmJ/WK9Uo/r8HQaWJEhI4k9LlIIVteBYa
	/xtbNiZCkuCFD9
X-X-Sender: gene099@racer
In-Reply-To: <5d46db230806052218r67e79a46rd0150cd9fe2af970@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84070>

Hi,

On Fri, 6 Jun 2008, Govind Salinas wrote:

> On Thu, Jun 5, 2008 at 6:06 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > +
> > +               switch (*line) {
> > +               case ' ': case '\n':
> > +                       fragment->newlines++;
> > +                       /* fall through */
> > +               case '-':
> > +                       fragment->oldlines++;
> > +                       break;
> > +               case '+':
> > +                       fragment->newlines++;
> > +                       if (line_nr == 0) {
> > +                               fragment->leading = 1;
> > +                               fragment->oldpos = 1;
> > +                       }
> > +                       fragment->trailing = 1;
> > +                       break;
> > +               case '@':
> > +                       return size < 3 || prefixcmp(line, "@@ ");
> > +               case 'd':
> > +                       return size < 5 || prefixcmp(line, "diff ");
> > +               default:
> > +                       return -1;
> > +               }
> > +               line_nr++;
> > +       }
> > +}
> 
> Perhaps this is accounted for and I did not see, but I believe that
> a backslash is used for the "no newline at end of file" line.  Does that
> need to be allowed here?

Will change.

Ciao,
Dscho
