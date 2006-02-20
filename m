From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Prepend the history of one git tree to another
Date: Mon, 20 Feb 2006 13:51:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602201350210.23862@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060220090909.GT6558@cip.informatik.uni-erlangen.de>
 <43F99684.5070403@op5.se> <20060220104345.GG26454@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 20 13:51:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBAW4-0003wQ-K1
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 13:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWBTMvq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 07:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWBTMvq
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 07:51:46 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:61874 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030190AbWBTMvp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 07:51:45 -0500
Received: from virusscan.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A9D2B146A31; Mon, 20 Feb 2006 13:51:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 96E7C21F8;
	Mon, 20 Feb 2006 13:51:44 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4C622146A58; Mon, 20 Feb 2006 13:51:40 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20060220104345.GG26454@cip.informatik.uni-erlangen.de>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16481>

Hi,

On Mon, 20 Feb 2006, Thomas Glanzmann wrote:

> Hello Andreas,
> 
> > Something like this might do the trick, depending on how linear your 
> > ancestry graph is:
> 
> > $ cd blastwave
> > $ first=$(git rev-list HEAD | tail -n 1)
> > $ git format-patch -k --stdout $first..HEAD > ../blw.mbox
> > $ cd ../blastwave.old
> > $ git am -k -3 ../blw.mbox
> 
> My graph is very linear. However. I have binaries checked into my tree.
> I am not sure if format-patch can handle this.

Do you need the history at all times? If not, you could just make a graft 
file. If you need it always, you could even check in a version of the 
graft file (but remember to copy it to .git/info/grafts, too).

Hth,
Dscho
