From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Errors building git-1.5.6 from source on Mac OS X 10.4.11
Date: Sat, 28 Jun 2008 22:34:48 +0200
Message-ID: <20080628203447.GA3172@steel.home>
References: <2eb980790806250620t73ae0ff7heedb65780a66ad00@mail.gmail.com> <20080625175311.GB4039@steel.home> <2eb980790806260148p7713a546k641d96a956e9b0fa@mail.gmail.com> <81b0412b0806261142r37f84187qf5ff043e1913b4fb@mail.gmail.com> <2eb980790806270143i5caec64fs498d9ca08acb0a1c@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ifejinelo Onyiah <nelo.onyiah@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 22:35:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCh9B-0005eK-3J
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 22:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbYF1Uev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 16:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbYF1Uev
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 16:34:51 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:18639 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbYF1Ueu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 16:34:50 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44jeZV
Received: from tigra.home (Fa959.f.strato-dslnet.de [195.4.169.89])
	by post.webmailer.de (mrclete mo4) (RZmta 16.45)
	with ESMTP id h06e12k5SGdpz5 ; Sat, 28 Jun 2008 22:34:49 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 966B2277BD;
	Sat, 28 Jun 2008 22:34:48 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 64BA956D2A; Sat, 28 Jun 2008 22:34:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2eb980790806270143i5caec64fs498d9ca08acb0a1c@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86741>

Ifejinelo Onyiah, Fri, Jun 27, 2008 10:43:05 +0200:
> > could you try the command _without_ "bash -x"?
> > Like this:
> >
> >    cd t
> >    ./t2004-checkout-cache-temp.sh -d -v -i
> >
> 
> I've just done that and here's the output:
> 
> io1@mib19412i[00m:~/Desktop/git-1.5.6/t$ ./t2004-checkout-cache-temp.sh -d -v -i
> * expecting success:
...
> * passed all 18 test(s)

So it succeeded... Complicated, then. You can try removing the
command-line options (except -i, which just makes the script stop
after the first failure):

    ./t2004-checkout-cache-temp.sh -i -v
    ./t2004-checkout-cache-temp.sh -i -d

and see if it breaks. Either -d or -v will help to pinpoint the test,
which failed more precisely.

Or, you can also try to build everything from scratch first (by
re-cloning your git repo somewhere and building it there).  As far as
I understood, the "make test" failed after you tried to build things
first time, right?

P.S. sorry for slow communication. I'm rarely on the net. A more
active debugging session can be had on IRC, there is some experienced
folk hanging around there (irc.freenode.net, channel #git).
