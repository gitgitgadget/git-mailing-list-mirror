From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: Compile fix for SCO OPenServer
Date: Wed, 30 Jul 2008 14:13:49 -0600
Message-ID: <alpine.LNX.1.10.0807301410220.13032@xenau.zenez.com>
References: <20071205172125.GF12636@yugib.highrise.ca> <20080730184956.GF10399@yugib.highrise.ca> <7vtze73zwg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Aidan Van Dyk <aidan@highrise.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 22:15:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOI4g-0000W1-VP
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 22:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759009AbYG3UNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 16:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759008AbYG3UNv
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 16:13:51 -0400
Received: from zenez.com ([166.70.62.2]:26842 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758991AbYG3UNu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 16:13:50 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 614F73F969; Wed, 30 Jul 2008 14:13:49 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id 499AA3F95D;
	Wed, 30 Jul 2008 14:13:49 -0600 (MDT)
In-Reply-To: <7vtze73zwg.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90848>

On Wed, 30 Jul 2008, Junio C Hamano wrote:
> Aidan Van Dyk <aidan@highrise.ca> writes:
> 
> > SCO OpenServer also hides the definitions of (at least) u_short and
> > friends if _XOPEN_SOURCE is defined.
> 
> I thought that was covered by 457bb45 (Port to 12 other Platforms., 2008-06-08).
> 
> Boyd, does this make any of the earlier symbols you added redundant?

On my machine !defined(__USLC__) covers both UnixWare 7.1.4 and OpenServer 
6.0.0.  !defined(_M_UNIX) covers my OpenServer 5.0.7 machine.  The 
!defined(__USLC__) also covers my Novell OS's and others that use the 
USLC (Unix System Labotories Compiler).

> >  git-compat-util.h |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index cf89cdf..42e3e0b 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -39,7 +39,7 @@
> >  /* Approximation of the length of the decimal representation of this type. */
> >  #define decimal_length(x)      ((int)(sizeof(x) * 2.56 + 0.5) + 1)
> >
> > -#if !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX)
> > +#if !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX) && !defined(__OPENSERVER__)
> >  #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
> >  #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
> >  #endif
> > --
> > 1.6.0.rc1.dirty
> 

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
