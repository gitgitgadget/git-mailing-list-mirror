From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Sun, 6 May 2007 18:51:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705061851411.4015@racer.site>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun May 06 18:52:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkjy3-0002nM-Nr
	for gcvg-git@gmane.org; Sun, 06 May 2007 18:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbXEFQwM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 12:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753253AbXEFQwL
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 12:52:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:47085 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753154AbXEFQwL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 12:52:11 -0400
Received: (qmail invoked by alias); 06 May 2007 16:52:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 06 May 2007 18:52:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ihzlx97xioz0yudgRStAtsfwX3QnIuKs9+zy/e7
	SQ1x5kIhhkzJCd
X-X-Sender: gene099@racer.site
In-Reply-To: <vpqwszm9bm9.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46346>

Hi,

On Sun, 6 May 2007, Matthieu Moy wrote:

> [...]
>
> % git satus -a
> % git commit -a -m "..."
> 
> In the former case, I have more commands to type, and in the second
> case, I loose part of the stat-cache benefit: If I run "git status -a"
> twice, the second run will actually diff all the files touched since
> the last run, since "git status -a" actually updated a temporary
> index, and discarded it afterwards, so it doesn't update the stat
> information in the index (while "git status" would have).

Have you tried "git status" _without "-a"?

> In both cases, I can't really see the benefit.

The benefit is a clear distinguishing between DWIM and low level. The 
index contains _exactly_ what you told it to contain. By forcing users to 
use "-a" with "git commit", you make it clear that a separate update 
steo is involved, and if you made an error (which you see from the file 
list), you can abort, and start over with the original index.

Hth,
Dscho
