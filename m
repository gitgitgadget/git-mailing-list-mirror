From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: how to backup git
Date: Mon, 12 May 2008 16:08:21 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805121606010.30431@racer>
References: <4827DEF6.1050005@gmail.com> <87ej87is50.fsf@offby1.atm01.sea.blarg.net> <alpine.DEB.1.00.0805121428310.30431@racer> <48285087.3090402@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 17:09:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvZeM-0006iG-SX
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 17:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbYELPI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 11:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbYELPI0
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 11:08:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:42877 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751797AbYELPIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 11:08:25 -0400
Received: (qmail invoked by alias); 12 May 2008 15:08:23 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp023) with SMTP; 12 May 2008 17:08:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19wI/ckstVwa3/HrBdIL1RlsqxqHrhLaxFULLpF7S
	1GkYHCjAjhOyAB
X-X-Sender: gene099@racer
In-Reply-To: <48285087.3090402@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81871>

Hi,

[please do not cull the Cc: list]

On Mon, 12 May 2008, bill lam wrote:

> Johannes Schindelin wrote:
> > > I'd rsync just the .git directory.
> 
> Thanks to all responders for quick reply. I still have a related 
> question. svn has a hotcopy command to ensure integrity so that it is 
> possible to backup without shutting down the svn server. If someone 
> update the .git while I am performing backup using tar or rsync? Will 
> the atomicity of that commit still preserve in my backup copy?

No, rsync is particularly dumb in that respect.  The safest thing would be 
to back up the reflogs first (e.g. with rsync), then repack and then clone 
(the clone will transmit the objects referenced by the reflogs, too).  
Note: the same holds _not_ true for a simple fetch.

But then, you usually do not want to back up reflogs anyway, since they 
are purely local and not visible to anybody else.

Ciao,
Dscho
