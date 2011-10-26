From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH] git grep: be careful to use mutices only when
 they are initialized
Date: Wed, 26 Oct 2011 10:42:11 -0500 (CDT)
Message-ID: <alpine.DEB.1.00.1110261040520.32316@s15462909.onlinehome-server.info>
References: <alpine.DEB.1.00.1110251223500.32316@s15462909.onlinehome-server.info> <CALUzUxpVWHL8LyqYkYazxSxDr6i=kitACFfVRQsTxQHHYjiOyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, gitster@pobox.com, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 26 17:42:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ5cS-0001rx-Pd
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 17:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933331Ab1JZPmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 11:42:15 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:58249 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933043Ab1JZPmP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 11:42:15 -0400
Received: (qmail invoked by alias); 26 Oct 2011 15:42:12 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp013) with SMTP; 26 Oct 2011 17:42:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18DznU3Q8UDbh5x7Kre1nlwBk+wmyJvx7w7xswSr2
	IAW4xod5OT5O2v
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CALUzUxpVWHL8LyqYkYazxSxDr6i=kitACFfVRQsTxQHHYjiOyA@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184264>

Hi Tay,

On Wed, 26 Oct 2011, Tay Ray Chuan wrote:

> On Wed, Oct 26, 2011 at 1:25 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Rather nasty things happen when a mutex is not initialized but locked 
> > nevertheless. Now, when we're not running in a threaded manner, the 
> > mutex is not initialized, which is correct. But then we went and used 
> > the mutex anyway, which -- at least on Windows -- leads to a hard 
> > crash (ordinarily it would be called a segmentation fault, but in 
> > Windows speak it is an access violation).
> >
> > This problem was identified by our faithful tests when run in the 
> > msysGit environment.
> 
> May I ask which test are you talking about specifically?

It is t7810.

> I ask as I'm curious how this is triggered; git-grep works fine for me 
> so far (1.7.6.msysgit.0.584.g2cbf)

That did not expose the error. The problem is exposed in msysGit's 'devel' 
branch, though.

Ciao,
Johannes
