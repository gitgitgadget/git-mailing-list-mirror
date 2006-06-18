From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git
Date: Sun, 18 Jun 2006 20:43:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606182040410.26803@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vpsh75lx1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0606181417090.26803@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060618130837.GN2609@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 20:43:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fs2F9-00044D-Bc
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 20:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWFRSnZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 14:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWFRSnZ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 14:43:25 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:40586 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751219AbWFRSnY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 14:43:24 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 763832439;
	Sun, 18 Jun 2006 20:43:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 6A6852418;
	Sun, 18 Jun 2006 20:43:23 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 5670323DC;
	Sun, 18 Jun 2006 20:43:21 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060618130837.GN2609@pasky.or.cz>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22095>

Hi,

On Sun, 18 Jun 2006, Petr Baudis wrote:

> Dear diary, on Sun, Jun 18, 2006 at 02:26:14PM CEST, I got a letter
> where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> > There is one thing I don't like about Pasky's approach: You can change the 
> > config file name to whatever you like, even if no program will read it. 
> > That is why I decided to have a flag instead of an option: to prevent 
> > pilot-errors.
> 
> I'm lost here, admittelly not getting your argument. :-(

Okay, the point I was driving at:

GIT_CONFIG_FILE=~/.gitrc git repo-config blabla.blibli bloblo

_will_ succeed, but to the user it will be non-obvious that the git 
commands do not pick up on it (because ~/.gitconfig is read instead of 
~/.gitrc), whereas

git repo-config --user blabla.blibli bloblo

is pretty obvious, and _has_ the intended effect.

> > I cobbled together a patch, which turned out to be rather messy, 
> > introducing "--config-file <file>" to git-repo-config. If people are 
> > interested, I'll clean it up and post it. But then, if you already know 
> > you want to use another config file, you are probably better of just 
> > exporting GIT_CONFIG_FILE and be done with it.
> 
> $GIT_CONFIG_FILE feels nicer since any other git tool can use it as
> well, it's not git-repo-config-specific. But the current intent indeed
> is to simply override the location for git-repo-config, thus for the
> current purposes if we will have --config-file instead of
> GIT_CONFIG_FILE, I will not weep; whatever does the job.

Yes, that is true. Forget about my --config-file patch, please.

> > Note that this issue is orthogonal to the need for a user-specific config 
> > file. I still think that this one should go in.
> 
> I agree as well.

Ciao,
Dscho
