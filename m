From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mmap implementation for mingw.
Date: Fri, 21 Nov 2008 11:48:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811211143550.30769@pacific.mpi-cbg.de>
References: <loom.20081121T024302-370@post.gmane.org> <49266A59.4010404@viscovery.net> <gg5t5s$qc8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 11:42:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3TT0-0003vF-Qr
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 11:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880AbYKUKkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 05:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755870AbYKUKkt
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 05:40:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:47867 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755722AbYKUKkr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 05:40:47 -0500
Received: (qmail invoked by alias); 21 Nov 2008 10:40:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp054) with SMTP; 21 Nov 2008 11:40:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+o6Ud9ke2oFUkPEMoCdyT7sq9ldealLEj8c1Ko/+
	sHzoOyMnFPPdBT
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <gg5t5s$qc8$1@ger.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101508>

Hi,

[re-Cc:ed j6t]

On Fri, 21 Nov 2008, Vasyl' Vavrychuk wrote:

> [Dscho knows that j6t wrote this:]
> 
> > It doesn't pass the test suite, for example t5301-sliding-window.sh 
> > fails.
>
> I will investigate.

Note that I quickly discarded the idea of mmap() on MinGW because at least 
in the past, we used to rename files that were mmap()ed.  That is a no-go 
with CreateFile().

And I'd really like to see speed comparisons; AFAIR we had major issues 
with mmap() performance on MacOSX, and use lseek() && pread() for 
that particular code instead now.

Note that I find your work valuable, even if it should turn out that 
CreateFile() is slower, because at least we will know.

Thanks,
Dscho
