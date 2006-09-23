From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC][RESEND][PATCH] Allow fetching from multiple repositories at once
Date: Sat, 23 Sep 2006 21:14:39 +0200
Message-ID: <20060923191439.GD20017@pasky.or.cz>
References: <20060923164308.16334.49252.stgit@machine.or.cz> <ef3vb6$69d$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 21:14:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRCxY-0005bV-EF
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 21:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWIWTOl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 15:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWIWTOl
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 15:14:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:12000 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751435AbWIWTOl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 15:14:41 -0400
Received: (qmail 1580 invoked by uid 2001); 23 Sep 2006 21:14:39 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ef3vb6$69d$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27615>

Dear diary, on Sat, Sep 23, 2006 at 08:45:01PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Petr Baudis wrote:
> 
> > This patch enables fetching multiple repositories at once over the Git
> > protocol (and SSH, and locally if git-fetch-pack is your cup of coffee
> > there). This is done especially for the xorg people who have tons of
> > repositories and dislike pulls much slower than they were used to with CVS.
> > I'm eager to hear how this affects the situation.
> [...]
> 
> I see that objects got to the one shared object database. Where the heads
> (refs) go to? Separate projects have separate ref spaces, even if they share
> object database...

git-fetch-pack actually does not save the refs at all, that's the job of
the porcelain (either git-fetch or cg-fetch). git-fetch-pack just emits
the refs list on stdout. See the script in a followup for an example of
a multirepo-aware porcelain wrapper.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
