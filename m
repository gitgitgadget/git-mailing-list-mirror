From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH] Document MKDIR_WO_TRAILING_SLASH in Makefile
Date: Fri, 7 Sep 2012 20:28:02 +0200
Message-ID: <004601cd8d26$8475f8d0$8d61ea70$@schmitz-digital.de>
References: <003301cd8cf1$d26258c0$77270a40$@schmitz-digital.de> <7vliglyc5g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 20:28:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA3Hx-0002rk-Mi
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 20:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263Ab2IGS2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 14:28:14 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:59407 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833Ab2IGS2N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 14:28:13 -0400
Received: from DualCore (dsdf-4d0a1723.pool.mediaWays.net [77.10.23.35])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0M5rAH-1TUJ5W3UhF-00yGzl; Fri, 07 Sep 2012 20:28:12 +0200
In-Reply-To: <7vliglyc5g.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJbvPTxgq9VY0aKseKOSN8udhBM+AE55ebmllkDwTA=
Content-Language: de
X-Provags-ID: V02:K0:usG/fwfPurcY6LpOtqeI4sytyxizWWIy0MTiJjI79Wy
 fcCl6iqCzuJBJXuOtyAIqZs90MTgBHHv755Syr0Sn2ocHVOHqs
 gOzwjJSPlt8x4dF7uVqaqs1yL1q3u0tl3evocUlb4RvcSIDoIV
 4ci3NjanUxDAeNuSRg5B6n4zHy3ZS+mq97LRP23WMAaggaTk/n
 SuwiU4y9CFOaRzhc++chpvi42OPFRD1xxFNpJ+CGdKkoUAgxni
 e2MmuwbRTqCeowffq0v4ESaQpIms5fq0IHYulHe2vgVW0ckuYU
 iyz4sKA1NC2o8zub5pwHfHrBo+80M0SGOIFsVDvQvMPlFjV5EV
 P8fjtOisRjne2GMDWht3n/Pxv+dp/T/V+HFpXWuiAOrKkH0BwO
 KKWzxEgaWE1kA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204984>



> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Friday, September 07, 2012 7:30 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH] Document MKDIR_WO_TRAILING_SLASH in Makefile
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> > ---
> >  Makefile | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Makefile b/Makefile
> > index ac49320..03e245a 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -90,6 +90,8 @@ all::
> >  #
> >  # Define NO_MKDTEMP if you don't have mkdtemp in the C library.
> >  #
> > +# Define MKDIR_WO_TRAILING_SLASH if your mkdir() can't deal with trailing slash.
> > +#
> >  # Define NO_MKSTEMPS if you don't have mkstemps in the C library.
> >  #
> >  # Define NO_STRTOK_R if you don't have strtok_r in the C library.
> 
> Not really.  "make MKDIR_WO_TRAILING_SLASH=YesPlease" won't do
> anything.
> 
> You would need at least something like this, no?
>

Yes, that is better, thanks

>  Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git c/Makefile w/Makefile
> index 66e8216..21b4816 100644
> --- c/Makefile
> +++ w/Makefile
> @@ -90,6 +90,8 @@ all::
>  #
>  # Define NO_MKDTEMP if you don't have mkdtemp in the C library.
>  #
> +# Define MKDIR_WO_TRAILING_SLASH if your mkdir() can't deal with trailing slash.
> +#
>  # Define NO_MKSTEMPS if you don't have mkstemps in the C library.
>  #
>  # Define NO_STRTOK_R if you don't have strtok_r in the C library.
> @@ -1639,6 +1641,9 @@ ifdef NO_MKDTEMP
>  	COMPAT_CFLAGS += -DNO_MKDTEMP
>  	COMPAT_OBJS += compat/mkdtemp.o
>  endif
> +ifdef MKDIR_WO_TRAILING_SLASH
> +	COMPAT_CFLAGS += -DMKDIR_WO_TRAILING_SLASH
> +endif
>  ifdef NO_MKSTEMPS
>  	COMPAT_CFLAGS += -DNO_MKSTEMPS
>  endif
