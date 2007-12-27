From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Anomalous conflicts during git rebase
Date: Thu, 27 Dec 2007 18:45:29 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0712271840030.13593@iabervon.org>
References: <m3ir2ju5ce.fsf@euroclydon.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: adr3nald0s@gmail.com
X-From: git-owner@vger.kernel.org Fri Dec 28 00:46:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J82QI-0001dg-PG
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 00:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543AbXL0Xpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2007 18:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753508AbXL0Xpa
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Dec 2007 18:45:30 -0500
Received: from iabervon.org ([66.92.72.58]:51389 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753303AbXL0Xpa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2007 18:45:30 -0500
Received: (qmail 21516 invoked by uid 1000); 27 Dec 2007 23:45:29 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Dec 2007 23:45:29 -0000
In-Reply-To: <m3ir2ju5ce.fsf@euroclydon.lan>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69273>

On Thu, 27 Dec 2007, adr3nald0s@gmail.com wrote:

> 
> On a clone of linux-2.6:
> 
>     git checkout -b topic/test v2.6.15
>     touch drivers/a-file.c
>     git add drivers/a-file.c
>     git commit -m 'Add a file'
>     git checkout -b temp0 v2.6.16
>     git rebase topic/test

This will rebase temp0 (= v2.6.16) onto topic/test. This process 
linearizes the history being rebased, and conflicts in that history (that 
were resolved in the merges) show up when the second change to those lines 
gets introduced.

What you probably want is

...
 git commit -m 'Add a file'
 git checkout -b temp0
 git rebase v2.6.16

	-Daniel
*This .sig left intentionally blank*
