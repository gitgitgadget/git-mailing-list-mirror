From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: Re: [PATCH] Added an option to cvsimport to specify email domain
Date: Fri, 30 Sep 2005 14:22:14 +0400
Message-ID: <200509301422.14677.snake@penza-gsm.ru>
References: <u5tzmqp8fzx.fsf@lysator.liu.se> <200509301219.42087.snake@penza-gsm.ru> <7v64sj6iva.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 12:24:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELI2N-0007RS-8j
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 12:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbVI3KWV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 06:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbVI3KWV
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 06:22:21 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:63119
	"HELO penza-gsm.ru") by vger.kernel.org with SMTP id S965033AbVI3KWU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 06:22:20 -0400
Received: (qmail 18405 invoked from network); 30 Sep 2005 10:23:03 -0000
Received: from unknown (HELO snake) (192.168.0.20)
  by fileserver.penza-gsm.ru with SMTP; 30 Sep 2005 10:23:02 -0000
To: Junio C Hamano <junkio@cox.net>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	David Mansfield <david@cobite.com>
User-Agent: KMail/1.7.2
In-Reply-To: <7v64sj6iva.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-102.8 required=5.0 tests=ALL_TRUSTED,AWL,
	USER_IN_WHITELIST autolearn=unavailable version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9552>

On Friday 30, September 2005 12:48 Junio C Hamano wrote:
> Alexey Nezhdanov <snake@penza-gsm.ru> writes:
> > Unfortunately I do not know perl so I can not write a patch for
> > git-cvsimport-script. So I asking you, Matthias, to help with this or may
> > somebody on this list can do it instead.
>
> Untested, but something like this?
<skipped/>
Yes, now it works correctly and can go down to master IMHO. One little notice, 
though. It is still prints out "* UNKNOWN LINE *" for each authorname in the 
new format.
This is not result of your patch - it started doing this immidiatedly after I 
tried updated version of cvsps (I have not mentioned this in my previous 
mail, sorry). Let's wait if somebody will fix it.
In any way, 

ANNOUNCE:
=========
With my patch to cvsps and Junio's patch to git-cvsimport.perl it is now 
possible to import authorname+email pairs correctly basing on contents of 
CVSROOT/users file. Currently cvsps can't retrieve this file in --cvs-direct 
mode (that git-cvsimport.perl uses) so you'll need to check it out by hand. 
May be if David will find some time for it this limitation will be lifted.

So now you can do either:
cvs checkout CVSROOT/users
or
mkdir CVSROOT && echo "author:A U Thor <author@domain.xz>" >CVSROOT/users
and then
git cvsimport -p "--users-file,CVSROOT/users"

you will import all mapped usernames correctly.

-- 
Respectfully
Alexey Nezhdanov
