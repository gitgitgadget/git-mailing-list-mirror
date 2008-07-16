From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use SHELL_PATH
Date: Wed, 16 Jul 2008 13:00:59 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807161259150.8503@eeepc-johanness>
References: <g5jj21$bsp$1@ger.gmane.org> <bd6139dc0807160347n2ebcd64fy7a15fe94bfabe580@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: namsh@posdata.co.kr, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Wed Jul 16 13:01:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ4l8-0000iH-VZ
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 13:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106AbYGPLAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 07:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752570AbYGPLAW
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 07:00:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:44184 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751693AbYGPLAV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 07:00:21 -0400
Received: (qmail invoked by alias); 16 Jul 2008 11:00:19 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness) [88.107.142.10]
  by mail.gmx.net (mp020) with SMTP; 16 Jul 2008 13:00:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19xb5tjvslxs7doapi1G4eYm7h2FU7vl+IoQZekZ0
	UEUtkIG1PP5lPS
X-X-Sender: user@eeepc-johanness
In-Reply-To: <bd6139dc0807160347n2ebcd64fy7a15fe94bfabe580@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88667>

Hi,

On Wed, 16 Jul 2008, Sverre Rabbelier wrote:

> On Wed, Jul 16, 2008 at 3:31 AM, SungHyun Nam <goweol@gmail.com> wrote:
> >
> > Signed-off-by: SungHyun Nam <goweol@gmail.com>
> > ---
> >  t/Makefile |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/t/Makefile b/t/Makefile
> > index a778865..0d65ced 100644
> > --- a/t/Makefile
> > +++ b/t/Makefile
> > @@ -26,7 +26,7 @@ clean:
> >        $(RM) -r 'trash directory' test-results
> >
> >  aggregate-results:
> > -       ./aggregate-results.sh test-results/t*-*
> > +       '$(SHELL_PATH_SQ)' ./aggregate-results.sh test-results/t*-*
> >
> >  # we can test NO_OPTIMIZE_COMMITS independently of LC_ALL
> >  full-svn-test:
> > --
> > 1.5.6.3.350.g6c11a
> 
> It is not clear to me what this patch does, there is no justification
> in the commit msg either. Instead you say what is being done, which we
> can see from the commit diff. Please clarify?

My _guess_ is that this comes from a platform like Solaris, where /bin/sh 
is not even POSIX.  And I'd expect aggregate-results to use some 
non-trivial shell constructs which break with such a broken shell.

But I completely agree, the commit message desperately wants to include 
some justification.

Ciao,
Dscho
