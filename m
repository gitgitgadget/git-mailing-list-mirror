From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] send-email: Change from Mail::Sendmail to Net::SMTP
Date: Thu, 27 Apr 2006 17:27:44 -0700
Message-ID: <20060428002744.GB9146@hand.yhbt.net>
References: <20060325235859.GO26071@mythryan2.michonline.com> <1143336048205-git-send-email-normalperson@yhbt.net> <46a038f90604251745u1b15ad99ka1aeff1cd8d8c344@mail.gmail.com> <7vy7xsm6qa.fsf@assigned-by-dhcp.cox.net> <46a038f90604261324w76f272edp93941d7e8645be8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git <git@vger.kernel.org>,
	Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Fri Apr 28 02:28:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZGqZ-0004Ia-Bg
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 02:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbWD1A1v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 20:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbWD1A1u
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 20:27:50 -0400
Received: from hand.yhbt.net ([66.150.188.102]:10626 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S965157AbWD1A1q (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Apr 2006 20:27:46 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 1F07B2DC01A; Thu, 27 Apr 2006 17:27:45 -0700 (PDT)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90604261324w76f272edp93941d7e8645be8@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19258>

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 4/27/06, Junio C Hamano <junkio@cox.net> wrote:
> > > system that we don't need an smtp daemon. Net::SMTP doesn't know how
> > > to use /usr/bin/sendmail
> 
> 
> > Wouldn't --smtp-server=that.smtp.server work for you?  Ah, that
> > would not work if your use is to send a local mail.  Hmph...
> 
> Well, the machine knows that the smtp server is (I mean, files in /etc
> have the right values in them), but I don't think often about it. Only
> when I am installing OSs or MTAs...
> 
> I know... I'm a whiner! ;-) I'll probably do something that does an
> eval and tries Mail::Sendmail and post it.

You should be able to just open a pipe to:
	/usr/sbin/sendmail @recipients
and just write headers\nbody to that pipe.

Perhaps allow and detect --smtp-server=/path/to/sendmail ?

-- 
Eric Wong
