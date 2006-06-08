From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] repo-config: learn the flag "--no-local"
Date: Thu, 8 Jun 2006 22:42:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606082235020.28405@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606081331140.11910@wbgn013.biozentrum.uni-wuerzburg.de>
 <44880BE8.40804@etek.chalmers.se> <Pine.LNX.4.63.0606081340230.25911@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1wtzaa26.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP04DDBAA584B31A4B0F31DCAE8B0@CEZ.ICE>
 <Pine.LNX.4.63.0606082222470.28323@wbgn013.biozentrum.uni-wuerzburg.de>
 <BAYC1-PASMTP102B1021B943F57F9FB1EEAE8B0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, lukass@etek.chalmers.se, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 22:42:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoRKg-0003Oe-QO
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 22:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWFHUmT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 16:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWFHUmT
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 16:42:19 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:52167 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964987AbWFHUmT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 16:42:19 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 27C6B1D99;
	Thu,  8 Jun 2006 22:42:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 1A7D01DA6;
	Thu,  8 Jun 2006 22:42:18 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id DF8421D99;
	Thu,  8 Jun 2006 22:42:17 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP102B1021B943F57F9FB1EEAE8B0@CEZ.ICE>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21513>

Hi,

On Thu, 8 Jun 2006, Sean wrote:

> On Thu, 8 Jun 2006 22:24:31 +0200 (CEST)
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > I think --user makes more sense than --home, since it does not matter 
> > _where_ it is stored, but _when_ it is retreived.
> 
> --home seems more natural to me for some reason but I don't feel strongly
> about it.

I'd like to know how --home tells you when this key is retreived.

> > In the same vein, I do not think it is user friendly to expect the user to 
> > remember if it was .gitconfig, .git or .gitrc.
> 
> Sure, was just thinking that this could be used by an administrator to
> modify _other_ users' configs.. but probably not worth it.

The admin has no business messing around with the users' configuration. 
And if she absolutely wants to be a BOFH, she can fire up any editor, or 
copy .gitconfig to /root/.gitconfig, use git-config, and copy it back, or 
do what she does all the time: "su <user>". But frankly, we should not 
support a bad work flow.

BTW it is the same reason I would rather not see /etc/gitconfig: it 
meddles with an existing configuration. If you want to give defaults, you 
can use a skeleton for $HOME, and templates for $GIT_DIR. As a user, I 
would be very surprised if the behaviour of git changed from one day to 
the other without my changing anything.

Ciao,
Dscho
