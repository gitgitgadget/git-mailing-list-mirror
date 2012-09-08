From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH] Document MKDIR_WO_TRAILING_SLASH in Makefile
Date: Sat, 8 Sep 2012 17:23:00 +0200
Message-ID: <001c01cd8dd5$d58eabe0$80ac03a0$@schmitz-digital.de>
References: <003301cd8cf1$d26258c0$77270a40$@schmitz-digital.de> <7vliglyc5g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 17:23:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAMsS-0007zf-Bs
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 17:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070Ab2IHPXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 11:23:12 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:52242 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754904Ab2IHPXL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 11:23:11 -0400
Received: from DualCore (dsdf-4db5dae6.pool.mediaWays.net [77.181.218.230])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0LodXq-1TlNNU1Kos-00g1PM; Sat, 08 Sep 2012 17:23:10 +0200
In-Reply-To: 
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJbvPTxgq9VY0aKseKOSN8udhBM+AE55ebmllkDwTCAAV2yoA==
Content-Language: de
X-Provags-ID: V02:K0:n8CS1syX3TWPhaGsKL1yfNkTLdwm//XVI+kMhfx7lO4
 JK6S0KZ1uPJr2Vy8wjamwR1IM9LHJ7+cf6wj1T5ovglcCnzxbj
 8rS/05GKknixRvAtUF3f1zcRBHP2RM7FmfPzhEOILyF9Zal0Ef
 1wFWgSJHqWjNWPDfY6k2ugZA/GbOYxDZg2brZA0m3SewO2KrQn
 2DY9JSaz8YfcHMaBofUL8y+AcAekHXj5nnlS6oA3a5aw4AdBii
 qhdJEiuxGRfpixCSC1YkHmiuvA7WyxnUzvlgbTGT9m4DDFo32K
 UYTg9ABOCxNsHwoOQm+86TAQ+X9+UlL/3RH77gSEh9ziYKSch1
 evz59VFfXFkeQjS9kwMiOjU3jIOQ2EISn4ltoCVBAzZPSnmqFb
 fkCvzewzxeRAQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205014>

> From: Joachim Schmitz [mailto:jojo@schmitz-digital.de]
> Sent: Friday, September 07, 2012 8:28 PM
> To: 'Junio C Hamano'
> Cc: 'git@vger.kernel.org'
> Subject: RE: [PATCH] Document MKDIR_WO_TRAILING_SLASH in Makefile
> 
> 
> 
> > -----Original Message-----
> > From: Junio C Hamano [mailto:gitster@pobox.com]
> > Sent: Friday, September 07, 2012 7:30 PM
> > To: Joachim Schmitz
> > Cc: git@vger.kernel.org
> > Subject: Re: [PATCH] Document MKDIR_WO_TRAILING_SLASH in Makefile
> >
> > "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> >
> > > Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> > > ---
> > >  Makefile | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index ac49320..03e245a 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -90,6 +90,8 @@ all::
> > >  #
> > >  # Define NO_MKDTEMP if you don't have mkdtemp in the C library.
> > >  #
> > > +# Define MKDIR_WO_TRAILING_SLASH if your mkdir() can't deal with trailing slash.
> > > +#
> > >  # Define NO_MKSTEMPS if you don't have mkstemps in the C library.
> > >  #
> > >  # Define NO_STRTOK_R if you don't have strtok_r in the C library.
> >
> > Not really.  "make MKDIR_WO_TRAILING_SLASH=YesPlease" won't do
> > anything.
> >
> > You would need at least something like this, no?
> >
> 
> Yes, that is better, thanks

There's something missing though, to make it fully usable, see below
> 
> >  Makefile | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git c/Makefile w/Makefile
> > index 66e8216..21b4816 100644
> > --- c/Makefile
> > +++ w/Makefile
> > @@ -90,6 +90,8 @@ all::
> >  #
> >  # Define NO_MKDTEMP if you don't have mkdtemp in the C library.
> >  #
> > +# Define MKDIR_WO_TRAILING_SLASH if your mkdir() can't deal with trailing slash.
> > +#
> >  # Define NO_MKSTEMPS if you don't have mkstemps in the C library.
> >  #
> >  # Define NO_STRTOK_R if you don't have strtok_r in the C library.
> > @@ -1639,6 +1641,9 @@ ifdef NO_MKDTEMP
> >  	COMPAT_CFLAGS += -DNO_MKDTEMP
> >  	COMPAT_OBJS += compat/mkdtemp.o
> >  endif
> > +ifdef MKDIR_WO_TRAILING_SLASH
> > +	COMPAT_CFLAGS += -DMKDIR_WO_TRAILING_SLASH

+	COMPAT_OBJS += compat/mkdir.o

> > +endif
> >  ifdef NO_MKSTEMPS
> >  	COMPAT_CFLAGS += -DNO_MKSTEMPS
> >  endif

Bye, Jojo
