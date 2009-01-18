From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH/RFC] git-am: Make it easier to see which patch failed
Date: Sun, 18 Jan 2009 10:41:13 +0100
Message-ID: <20090118094113.GE11992@leksak.fem-net>
References: <636ecac0901160518o16706bbia9acaf09fdf92946@mail.gmail.com> <alpine.DEB.1.00.0901161513400.3586@pacific.mpi-cbg.de> <636ecac0901160634r586c72a0r9bb63c6f019f5bff@mail.gmail.com> <7vhc3x1874.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas =?iso-8859-1?Q?Flod=E9n?= <jonas@floden.nu>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 10:42:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOUB7-0006S3-62
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 10:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758147AbZARJlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 04:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755293AbZARJlZ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 04:41:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:39527 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757450AbZARJlX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 04:41:23 -0500
Received: (qmail invoked by alias); 18 Jan 2009 09:41:21 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp009) with SMTP; 18 Jan 2009 10:41:21 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18XXcxy1B4XOSWnq14LQtaAF91OBqCwyY3hpsEDTE
	5i+4sdOi95wjNi
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LOU9Z-0003Uz-7z; Sun, 18 Jan 2009 10:41:13 +0100
Content-Disposition: inline
In-Reply-To: <7vhc3x1874.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106164>

> > diff --git a/git-am.sh b/git-am.sh
> > index 4b157fe..09c2f9c 100755
> > --- a/git-am.sh
> > +++ b/git-am.sh
> > @@ -501,7 +501,7 @@ do
> >  	fi
> >  	if test $apply_status != 0
> >  	then
> > -		echo Patch failed at $msgnum.
> > +		printf '\nPatch failed at %s (%s)\n' "$msgnum" "$FIRSTLINE"
> >  		stop_here_user_resolve $this
> >  	fi
> 
> Looks sane except that I do not think you need printf nor the leading
> blank line, i.e.
> 
> 	echo "Patch failed at $msgnum ($FIRSTLINE)"

Hmm, IIRC if $FIRSTLINE contains \n or something like that, it will
interpret this as newline in some shell/echo implementations.

So printf "...%s..." "$FOO" is always sane for user input.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
