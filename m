From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: git pull regression?
Date: Wed, 5 Nov 2008 10:48:35 +0100
Message-ID: <20081105094835.GA29316@localhost.aei.mpg.de>
References: <20081104222749.GA9296@localhost.aei.mpg.de> <7vtzanoyg0.fsf@gitster.siamese.dyndns.org> <20081105083810.GA22318@localhost.aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 10:49:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxf0y-0001BT-Ad
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 10:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753682AbYKEJsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 04:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754124AbYKEJsL
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 04:48:11 -0500
Received: from ox1.aei.mpg.de ([194.94.224.6]:38440 "EHLO ox1.aei.mpg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752925AbYKEJsK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 04:48:10 -0500
Received: from localhost.aei.mpg.de (unknown [172.18.254.253])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ox1.aei.mpg.de (Postfix) with ESMTP id E9ACF8805A74A;
	Wed,  5 Nov 2008 10:48:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081105083810.GA22318@localhost.aei.mpg.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100152>

On Wed  5.Nov'08 at  9:38:10 +0100, Carlos R. Mafra wrote:
> On Tue  4.Nov'08 at 15:37:03 -0800, Junio C Hamano wrote:
> > "Carlos R. Mafra" <crmafra2@gmail.com> writes:
> > 
> > > It looks like a regression to me. I can finish
> > > the bisection if people in the list say that
> > > I am not making a mistake somewhere :-)
> > 
> > Interesting, and _sounds_ like a regression, but I do not think anybody
> > can tell if it is without looking at what .git/config and exact command
> > sequence you are using for this "git pull" and where you are starting
> > from.

Hm...that what I feared most has just happened.

I tried to bisect my problem when I realized that it wasn't
goint to take 2 hours and a lot of reboots like with the kernel :-)

And I soon realized that something was wrong when I was
running 'make install'. I had two terminals open, one with
the regular user with which I was compiling git, and the
other with the root user where I run 'make install'.

After compiling with the regular user and running
'make install' with the root user from the other terminal
the whole compilation was happening again and strangely
it was installing things in the prefix /root instead of
/usr/local

I simply don't know why this happened nor how. But 
somehow my git installation was screwed.

I have just compiled the latest git and it is ok now.

I am really sorry for all the noise, but I was 
sincerely fooled by the symptoms (as you can see
in the previous email).
