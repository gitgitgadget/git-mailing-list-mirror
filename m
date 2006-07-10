From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: [PATCH] Avoid C++ comments, use C comments instead
Date: Tue, 11 Jul 2006 02:25:44 +0300
Message-ID: <f36b08ee0607101625y6eaec83ck22dd20b4f27a1846@mail.gmail.com>
References: <20060710065751.22902.43316.stgit@dv.roinet.com>
	 <7vzmfhdhrf.fsf@assigned-by-dhcp.cox.net>
	 <20060710094653.GA52962@dspnet.fr.eu.org>
	 <Pine.LNX.4.63.0607101306030.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060710114117.GA62514@dspnet.fr.eu.org>
	 <44B2A709.8020500@serice.net> <20060710202412.GA8189@dspnet.fr.eu.org>
	 <Pine.LNX.4.63.0607110049470.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 01:25:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G058Q-0000IR-M0
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 01:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965327AbWGJXZs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 19:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965325AbWGJXZr
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 19:25:47 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:33908 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965328AbWGJXZp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 19:25:45 -0400
Received: by py-out-1112.google.com with SMTP id x31so881072pye
        for <git@vger.kernel.org>; Mon, 10 Jul 2006 16:25:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gb4+ECE4iqI0Z0QY8KnYYrsEakvYIVnxl5owtldLRZLaL6JeUib8zL+wIA0ch4Ey9oFO+QJI2XaTD1yjn073FcjY6Xk46AZ81qLh+YbqtaBJpB4fCP0W167dVUBTwwIm4Xauil30SXzPZuWEghKFbePgDlTRcSVo0Z5dntFCQzY=
Received: by 10.35.41.14 with SMTP id t14mr5692149pyj;
        Mon, 10 Jul 2006 16:25:45 -0700 (PDT)
Received: by 10.35.14.14 with HTTP; Mon, 10 Jul 2006 16:25:44 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.63.0607110049470.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23667>

On 7/11/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 10 Jul 2006, Olivier Galibert wrote:
>
> > On Mon, Jul 10, 2006 at 02:14:17PM -0500, Paul Serice wrote:
> > > If you want to write portable code, you have to take into account
> > > different operating systems _and_ different compilers.  Writing your
> > > code for just a single compiler is almost as bad as writing your code
> > > for just a single operating system.
> >
> > Hmmm, that was not so much about gcc-specific code than which kind of
> > C you want to code to, the one from 1973, the one from 1989 or the one
> > from 1999?  I personally don't have much sympathy for the OS vendors
> > giving you an older standard C compiler and selling you the up-to-date
> > one.
>
> Judging by what you say, one could get the impression you'd have not much
> sympathy for people being stuck with non-C99 compilers.
>
> Just look at it: if the OS vendor just does not _care_, and you blame the
> vendor for not providing something newer, the vendor does not _care_ about
> your complaint either. But the user does.
>
> However, there is a more important point to be made. If you are complying
> with an older standard, you get more users. More users = more bug testers.
>
> And there were quite a few occasions where I found bugs by trying to run
> on a different platform, which was less forgiving than Linux. These are
> bugs you have a harder time to spot on Linux, _because_ Linux is so nice.
> But they will surface. And they will be a PITA to find.
>
> Anyway, it is best practice for a reason to program portably. (Well, at
> least if you are not living in Redmont.)

Back in the beginning of nineties, c89 was new and the
prototypes was not yet impemented on many compilers.
One good trick of the time was automatic
source conversion. This protoize/unprotoize tool converted
sources from non-prototyped form to
prototyped, and the other way. (There was also #ifdef-trick
which was ugly as hell for the same purpose, and the __P()
macro trick, which was less ugly).

The benefit was that you got the benefit of both worlds,
(1) the benefit of prototypes when compiler was c89-compliant, and
(2) compilability with pre-c89 compilers when needed.

I am writing in order to ask, whether there maybe
some c99-to-c89 source convertor that can be
automatically applied to the .c before compiling with
pre-c99 compiler ?

Yakov
