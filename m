From: Eric Wong <normalperson@yhbt.net>
Subject: Re: t9001 fails because Net::SMTP is missing
Date: Tue, 30 May 2006 23:05:30 -0700
Message-ID: <20060531060530.GA9333@hand.yhbt.net>
References: <Pine.LNX.4.63.0605302125310.11586@wbgn013.biozentrum.uni-wuerzburg.de> <7v8xojyqu3.fsf@assigned-by-dhcp.cox.net> <7v4pz7yqpd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 31 08:05:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlJpu-0003Dn-4o
	for gcvg-git@gmane.org; Wed, 31 May 2006 08:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWEaGFc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 02:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWEaGFc
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 02:05:32 -0400
Received: from hand.yhbt.net ([66.150.188.102]:52925 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932498AbWEaGFb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 May 2006 02:05:31 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 7A86B7DC005; Tue, 30 May 2006 23:05:30 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4pz7yqpd.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21058>

Junio C Hamano <junkio@cox.net> wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> is it unexpected that there are setups which come without Net::SMTP?
> >>
> >> -- snip --
> >> * expecting success: git format-patch -n HEAD^1
> >>      git send-email -from="Example <nobody@example.com>" 
> >> --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" ./0001*txt
> >> 0001-Second.txt
> >> Can't locate Net/SMTP.pm in @INC (@INC contains: 
> >
> > Hmm.  Something like this?
> 
> Nah, nevermind.  I forgot my Perl that use has the magic BEGIN{}
> block around it X-<.

s/use/require/ and you should be fine.  We don't need any thing imported
from Net::SMTP, either.

Odd that Net::SMTP isn't installed on Johannes' machine, though, as it's
part of the standard Perl 5.8 (maybe even before) installation.

-- 
Eric Wong
