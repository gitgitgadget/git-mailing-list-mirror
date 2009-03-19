From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 04/10] test-lib: Replace uses of $(expr ...) by POSIX  
 shell features.
Date: Thu, 19 Mar 2009 11:27:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903191124590.10279@pacific.mpi-cbg.de>
References: <cover.1237410682.git.j6t@kdbg.org> <680eb7fed78dc2ae0268f9b3adcd5978aed3ebcf.1237410682.git.j6t@kdbg.org> <alpine.DEB.1.00.0903182319180.10279@pacific.mpi-cbg.de> <49C1F673.9050500@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 11:27:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkFT2-00082e-H8
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 11:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbZCSKZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 06:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbZCSKZp
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 06:25:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:38047 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752438AbZCSKZo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 06:25:44 -0400
Received: (qmail invoked by alias); 19 Mar 2009 10:25:41 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp017) with SMTP; 19 Mar 2009 11:25:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Z5Np0iEmZVEGOn1HA0LbupkV4FeKWhrwfa9eqAx
	9XXGuN2Bns5nHg
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49C1F673.9050500@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113747>

Hi,

On Thu, 19 Mar 2009, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> 
> > On Wed, 18 Mar 2009, Johannes Sixt wrote:
> > 
> >> In particular:
> >>
> >> - Test case counting can be achieved by arithmetic expansion.
> >>
> >> - The name of the test, e.g. t1234, can be computed with ${0%%} and 
> >>   ${0##}.
> >>
> >> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> > 
> > I guess this makes the tests less slow on Windows?  Do you have 
> > numbers?
> 
> Actually, while reading through test-lib.sh I found those expr 
> expressions quite difficult to understand, and my primary intent was to 
> make the code more readable. Furthermore, as you can see in the hunk 
> that touches test_known_broken_{ok,failure}_ that the $(( )) construct 
> is already in use, so it's also a change to improve consistency.
> 
> The shorter runtime (primarily on Windows) is just a nice side effect, 
> although the gain probably vanishes in the noise.

Actually, I should not have written that mail that late at night: 'expr' 
is a bash builtin.

> > FWIW I run the tests on Windows with -j10 these days, and they take 
> > about 15 minutes on a quad core 3GHz machine (which I may use from 
> > time to time; the machine is not mine, otherwise it would run Linux).
> 
> Last time I tried -j<something> it bailed out early. I didn't try again 
> since then. Sequential tests finish in 30-40 minutes here, but I don't 
> run SVN tests.

In msysGit, I updated the /share/msysGit/run-tests.sh script to make use 
of -j5.  If you work on a newer branch than 'devel', you most probably 
need the changes from 'release-preview', as my 
test-results/<basename>-<pid> patch broke the original assumption of 
run-tests.sh.

Ciao,
Dscho
