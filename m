From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: builtin command's prefix question
Date: Thu, 6 Dec 2007 15:48:02 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712061547070.27959@racer.site>
References: <fcaeb9bf0712050856t5d730779q82783fdb9876f41@mail.gmail.com> 
 <7vlk88n648.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0712060726r383c3a36j798a439b9dbb0cae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 16:49:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0IyC-00072j-S6
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 16:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbXLFPsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 10:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbXLFPsd
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 10:48:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:53171 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751392AbXLFPsc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 10:48:32 -0500
Received: (qmail invoked by alias); 06 Dec 2007 15:48:30 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 06 Dec 2007 16:48:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XgDs7ha7XZK9+RkcqHKFLZdsa/E2/WgdcOKqMUX
	nrW0Melu8/9Y1/
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0712060726r383c3a36j798a439b9dbb0cae@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67296>

Hi,

On Thu, 6 Dec 2007, Nguyen Thai Ngoc Duy wrote:

> On Dec 6, 2007 6:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > However, if we define setup() to behave this way when GIT_DIR is not 
> > defined and GIT_WORK_TREE is:
> >
> >  (1) internally pretend as if GIT_DIR was specified to be the
> >      directory where the command was started from (iow, do getcwd()
> >      once upon startup);
> >
> >  (2) chdir to GIT_WORK_TREE (which means "callers of setup() always
> >      run from the top of the work tree");
> >
> >  (3) set prefix to NULL;
> 
> (1) is fine by me, even if it goes up to find a gitdir. But (3), no, 
> prefix should be set as relative path from worktree top directory to 
> user current directory, not NULL.

If you expect "git <command> <filespec>" to work correctly from GIT_DIR, 
you will _have_ to set the prefix to NULL.

Ciao,
Dscho
