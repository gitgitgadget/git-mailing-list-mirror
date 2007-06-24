From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] transplant: move a series of commits to a different
 parent
Date: Sun, 24 Jun 2007 11:26:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706241123170.4059@racer.site>
References: <1BD13366-B4BD-4630-9046-49567A345CBC@zib.de>
 <11826268772950-git-send-email-prohaska@zib.de>
 <81b0412b0706231404hc8b4bc4xd5bc51c733d8ea69@mail.gmail.com>
 <9C4338DC-0C4A-4981-9EC9-2417513F629D@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jun 24 12:26:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2PIP-0004EY-85
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 12:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762AbXFXK0P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 06:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753828AbXFXK0P
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 06:26:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:40712 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753678AbXFXK0O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 06:26:14 -0400
Received: (qmail invoked by alias); 24 Jun 2007 10:26:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 24 Jun 2007 12:26:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX191jCtrKN11SPzwO+ouSaaz+Cl/OSBYryXPoNHilq
	i+7IGyirwyaLkD
X-X-Sender: gene099@racer.site
In-Reply-To: <9C4338DC-0C4A-4981-9EC9-2417513F629D@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50788>

Hi,

On Sun, 24 Jun 2007, Steffen Prohaska wrote:

> On Jun 23, 2007, at 11:04 PM, Alex Riesen wrote:
> 
> > # detached head
> > git checkout $(git rev-parse onto) && git format-patch --stdout
> > --full-index from..to|git am -3
> 
> No. This one tries to apply the _changes_ between from..to. What I need 
> is the resulting _content_ of files modified between from..to.

Oh! But the commit messages do no longer correspond to their patches, do 
they?

Example:

In "onto", you have a sorely needed bugfix in main.c. In "from", you have 
not. Then you do your transplant, and all of a sudden, the 
first transplanted commit _undoes_ that bugfix (because you take the 
contents at face value), but the commit message _cannot_ say so, or even 
why.

IMHO this makes no sense (and that is why I misunderstood it as being a 
rebase).

Ciao,
Dscho
