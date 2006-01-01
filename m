From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: how to find outstanding patches in non-linux-2.6 repositories?
Date: Sun, 1 Jan 2006 22:32:27 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601012228470.32311@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060101200121.GA20633@suse.de> <43B83EBC.9070905@didntduck.org>
 <20060101210429.GA22033@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Gerst <bgerst@didntduck.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 01 22:32:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EtAod-0004K1-MZ
	for gcvg-git@gmane.org; Sun, 01 Jan 2006 22:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWAAVcb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jan 2006 16:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWAAVcb
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jan 2006 16:32:31 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:19929 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932269AbWAAVcb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jan 2006 16:32:31 -0500
Received: from amavis.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.46])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CC284140584; Sun,  1 Jan 2006 22:32:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id BE005355F;
	Sun,  1 Jan 2006 22:32:27 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id A1A511561;
	Sun,  1 Jan 2006 22:32:27 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 37461140584; Sun,  1 Jan 2006 22:32:27 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20060101210429.GA22033@suse.de>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14132>

Hi,

On Sun, 1 Jan 2006, Olaf Hering wrote:

>  On Sun, Jan 01, Brian Gerst wrote:
> 
> > Pull the powerpc tree into your local repo, then do something like:
> > git-whatchanged master..powerpc
> > or
> > gitk master..powerpc
> 
> This worked for me:
> 
> mkdir /dev/shm/x
> cd /dev/shm/x
> rsync -Ha --delete ~/kernel/git/{powerpc,linux-2.6} .
> cd linux-2.6/
> cat .git/HEAD  > ../start
> git-pull /dev/shm/x/powerpc
> cat .git/HEAD  > ../end
> git-format-patch `cat ../start` `cat ../end`
> view ????-*

Preferrable is the following:

cd /existing/clone/of/ppc-linux # OP said he had this already
git fetch \
  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git \
  master:refs/heads/linus
git-whatchanged linus..HEAD

Hth,
Dscho
