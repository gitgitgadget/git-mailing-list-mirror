From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/1] MSVC: port pthread code to native Windows threads
Date: Wed, 4 Nov 2009 12:02:20 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911041201380.2788@felix-maschine>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com> <1257283802-29726-2-git-send-email-ahaczewski@gmail.com> <alpine.DEB.1.00.0911040031210.4985@pacific.mpi-cbg.de> <4AF0E842.2010201@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 12:03:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5ddM-0000Sb-EJ
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 12:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755293AbZKDLCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 06:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755290AbZKDLCZ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 06:02:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:45639 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753723AbZKDLCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 06:02:25 -0500
Received: (qmail invoked by alias); 04 Nov 2009 11:02:28 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO [10.1.35.45]) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 04 Nov 2009 12:02:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/WzURm83LWaQpHFzkyuPejXZz5lrp5BVcyyb3Nvm
	guNNJVO3nd2y33
X-X-Sender: johannes@felix-maschine
In-Reply-To: <4AF0E842.2010201@workspacewhiz.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132077>

Hi,

I do not appreciate at all that you culled me from the Cc: list.

On Tue, 3 Nov 2009, Joshua Jensen wrote:

> ----- Original Message -----
> From: Johannes Schindelin
> Date: 11/3/2009 4:38 PM
> > >   #ifdef THREADED_DELTA_SEARCH
> > > -#include "thread-utils.h"
> > > -#include<pthread.h>
> > > +# include "thread-utils.h"
> > > +# ifndef _WIN32
> > > +#  include<pthread.h>
> > > +# else
> > > +#  include<winthread.h>
> > > +# endif
> > >   #endif
> > >
> > >      
> > It is unlikely that an #ifdef "contamination" of this extent will go 
> > through easily, but I have a suggestion that may make your patch both 
> > easier to read and more likely to be accepted into git.git: Try to 
> > wrap the win32 calls into pthread-compatible function signatures.  
> > Then you can add a compat/win32/pthread.h and not even touch core 
> > files of git.git at all.
> >    
> Pardon my ignorance, but is there a reason to not use Pthreads for 
> Win32? http://sourceware.org/pthreads-win32/

Pthreads is a rather large dependency we do not really need.

Ciao,
Dscho
