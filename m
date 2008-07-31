From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: Compile fix for SCO OPenServer
Date: Wed, 30 Jul 2008 18:00:23 -0600
Message-ID: <alpine.LNX.1.10.0807301747160.13032@xenau.zenez.com>
References: <20071205172125.GF12636@yugib.highrise.ca> <20080730184956.GF10399@yugib.highrise.ca> <7vtze73zwg.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0807301403360.13032@xenau.zenez.com> <20080730204339.GJ10399@yugib.highrise.ca>
 <alpine.LNX.1.10.0807301522140.13032@xenau.zenez.com> <20080730225635.GM10399@yugib.highrise.ca> <alpine.LNX.1.10.0807301700500.13032@xenau.zenez.com> <20080730234455.GN10399@yugib.highrise.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Aidan Van Dyk <aidan@highrise.ca>
X-From: git-owner@vger.kernel.org Thu Jul 31 02:01:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOLbk-0003Rl-I0
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 02:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699AbYGaAAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 20:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753781AbYGaAAZ
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 20:00:25 -0400
Received: from zenez.com ([166.70.62.2]:15987 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753594AbYGaAAY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 20:00:24 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 6FCF53F97F; Wed, 30 Jul 2008 18:00:23 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id 5952A3F97D;
	Wed, 30 Jul 2008 18:00:23 -0600 (MDT)
In-Reply-To: <20080730234455.GN10399@yugib.highrise.ca>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90880>

On Wed, 30 Jul 2008, Aidan Van Dyk wrote:
> * Boyd Lynn Gerber <gerberb@zenez.com> [080730 19:30]:
> > I have m4-1.4.3 at 
> > 
> > ftp://ftp.zenez.com/pub/zenez/prgms/m4-1.4.3-osr6-all.tar.gz
> > 
> > I really have to be able to use configure for most of my OpenSource 
> > Projects for SCO OS's.
> > 
> > I made the changes so that most things work with the auto tools.  
> 
> I'm not a SCO guru by any means...
> 
> I'm just a user on someone else's SCO machine, just trying to make sure
> that the software I write is "fairly portable"...
> 
> I'm willing to carry a good and useful tool (like git) in my home
> directory in that endeavour, but I'm not carrying all of the GNU stack
> in my home directory so I can run configure git is a bit much ;-)

That make sense.  All though m4 is

test5 > l /usr/local/bin/m4
-rwxr-xr-x    1 gerberb  zenez    280524 Jul 23  2005 /usr/local/bin/m4

Which is not that big.  I have it in my ~/.bin/ on my clients machines.  
You really need a good m4 for most things.  Sendmail expecially.  Also for 
the latest bind with the DNS security fix.  I some times need bc as well.

test5 > l /usr/local/bin/bc
-rwxr-xr-x    1 bin      bin      85088 May 19 17:20 /usr/local/bin/bc

> > I did a VM install of OpenServer 6 to try things out.  I was able to get 
> > your -Wall failure, but once I ran the CC=cc CXX=CC ./configure I was able 
> > to run gmake without any errors. I did have to install the M4 from above 
> > to get configure to work.  So, the straight out of the box install has to 
> > have gnu m4 to run configure. 
> 
> So configure.ac must have some magic in it that allows configure to
> notice -Wall doesn't work.  You can see what it choose in
> config.mak.autogen I think.  But I'm pretty glad for the kbuild style
> Makefile in git not requiring autoconf/automake/etc.

I do not see anything really obvious, but below is config.mak.autogen

test5 > cat config.mak.autogen
# git Makefile configuration, included in main Makefile
# config.mak.autogen.  Generated from config.mak.in:config.mak.append by 
configure.

CC = cc
CFLAGS = -Kalloca -Kthread
AR = gar
TAR = gtar
#INSTALL = @INSTALL@            # needs install-sh or install.sh in 
sources
TCLTK_PATH = wish

prefix = /usr/local
exec_prefix = ${prefix}
bindir = ${exec_prefix}/bin
#gitexecdir = ${exec_prefix}/libexec/git-core/
datarootdir = @datarootdir@
template_dir = ${prefix}/share/git-core/templates/

mandir=${prefix}/man

srcdir = .


export exec_prefix mandir
export srcdir VPATH

ASCIIDOC8=
NEEDS_SSL_WITH_CRYPTO=
NO_OPENSSL=
NO_CURL=
NO_EXPAT=
NEEDS_LIBICONV=
NEEDS_SOCKET=YesPlease
NO_SYS_SELECT_H=
NO_D_INO_IN_DIRENT=
NO_D_TYPE_IN_DIRENT=YesPlease
NO_SOCKADDR_STORAGE=
NO_IPV6=
NO_C99_FORMAT=
NO_STRCASESTR=YesPlease
NO_MEMMEM=YesPlease
NO_STRLCPY=
NO_STRTOUMAX=
NO_SETENV=
NO_UNSETENV=
NO_MKDTEMP=YesPlease
NO_ICONV=
OLD_ICONV=
NO_DEFLATE_BOUND=
FREAD_READS_DIRECTORIES=UnfortunatelyYes
SNPRINTF_RETURNS_BOGUS=UnfortunatelyYes
# config.mak.append.  Generated by configure.


> > -g and -O2 are mutually exclusive.  You can have either one but not both.
> 
> Yes, and I think the default to cc matches -g, not -O2, hence my
> failures unless setting -O2.
> 
> > I do have tcl and tk
> 
> I'm sure... I might even find it burried somewhere on this machine too,
> but I have no real need for it.

OK.

So what do you think we need to have.  I really do not see the need for 
__OPENSERVER__.  Do you?

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
