From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Introduce ~/.gitconfig
Date: Thu, 8 Jun 2006 17:19:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606081711520.27335@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606081329200.11910@wbgn013.biozentrum.uni-wuerzburg.de>
 <1149775348.23938.236.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jun 08 17:20:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoMIL-0005I0-W8
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 17:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWFHPTf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 11:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWFHPTf
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 11:19:35 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:49112 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964861AbWFHPTe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 11:19:34 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 5EFCB1DC9;
	Thu,  8 Jun 2006 17:19:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 537741DB7;
	Thu,  8 Jun 2006 17:19:33 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 412DA1DAC;
	Thu,  8 Jun 2006 17:19:33 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1149775348.23938.236.camel@cashmere.sps.mot.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21493>

Hi,

On Thu, 8 Jun 2006, Jon Loeliger wrote:

> On Thu, 2006-06-08 at 06:30, Johannes Schindelin wrote:
> 
> > - The --no-local flag could be implemented more cleanly, but also less
> 
> Could we have multiple levels, and have names that call out
> where it applies?  Perhaps something like:
> 
> --repo   into $GIT_DIR/.gitconfig  <- current default, right?
> --home   into ~/.gitconfig
> --site   into /etc/gitconfig
> --share  into /usr/share/git/config
> 
> My issue is that --no-local is vague and doesn't call out
> where it actually does go.  There could be more than one
> different non-local place.

The whole idea is that there are only two levels of configuration. Global 
(applies to all calls to git) and local (applies only to the repository).

Now, it makes sense to make settings overrideable in a certain order: If 
the global default does not match your needs in a particular case, 
override it. With "git-repo-config <key> <value>".

*However*, if you want to change the default, it makes sense to say 
"--no-local" or "--global", but I doubt that it makes any sense at all to 
access a certain finer level. For example, when would you possibly need to 
wrap in porcelain a method to query exactly which aliases are defined in 
/usr/local/share/git/config?

IOW if you want to edit /etc/gitconfig or something else you need admin 
permissions for with git-repo-config, you should look for another 
profession. Quickly.

> But, hey, that's all pre-coffee.

post-coffee is pre-coffee.

Ciao,
Dscho
