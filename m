From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git /objects directory created 755 by default?
Date: Thu, 22 Dec 2005 20:28:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512222022510.31591@wbgn013.biozentrum.uni-wuerzburg.de>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
 <7vacevgwqr.fsf@assigned-by-dhcp.cox.net> <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vek465cev.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de>
 <43AA75D1.7040009@op5.se> <Pine.LNX.4.63.0512221220220.7112@wbgn013.biozentrum.uni-wuerzburg.de>
 <43AA9BE6.7000601@op5.se> <Pine.LNX.4.63.0512221530570.18551@wbgn013.biozentrum.uni-wuerzburg.de>
 <43AACBE9.7060201@op5.se> <Pine.LNX.4.63.0512221700310.18982@wbgn013.biozentrum.uni-wuerzburg.de>
 <43AAD9D7.1070503@op5.se> <7vwthxlzai.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Dec 22 20:28:50 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpW7N-0002XI-Cm
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 20:28:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbVLVT2r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 14:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbVLVT2r
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 14:28:47 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:12202 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030282AbVLVT2q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 14:28:46 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 84C9A13FC3C; Thu, 22 Dec 2005 20:28:45 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 66CB39E3A1; Thu, 22 Dec 2005 20:28:45 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4D1A29E2AA; Thu, 22 Dec 2005 20:28:45 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 310BC13FC3C; Thu, 22 Dec 2005 20:28:45 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwthxlzai.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13964>

Hi,

On Thu, 22 Dec 2005, Junio C Hamano wrote:

> When we talk about "CVS-style shared repository", we know what
> it is -- there is no such thing as "*the* working tree
> associated with the repository" and there is no room for
> disagreement.

This is what I mean by shared repository.

> I could give each of the gitsters I trust an git-shell account
> on my private machine and prepare refs/heads/rcpt/js branch for
> you and refs/heads/rcpt/ae for Andreas to push into (I would use
> Carl's per branch push policy to make sure those "receipt
> branches" are the only ones you guys can push into if I did so).
> 
> Then instead of sending "I now have this public repository and
> have goodies for git improvement; please pull" e-mail to me, you
> could push into your branch.  I will keep working on master (and
> my own topic branches), with whatever branch checked out in the
> working tree, and merge from those rcpt branches at my leisure.
> You guys are not allowed to touch my working tree, though.

This has some merit, for example, when some of the contributors have no 
public repository.

> In such a scenario, there is no reason to forbid me from
> applying umask 022 to my working tree files, even though making
> sure that fan-out directories of .git/objects/ *I* lazily create
> can be writable by you is essential.
> 
> I have a feeling that it might be good enough to modify
> safe_create_leading_directories() to chmod(0777) after creating
> a new directory under .git/ (or limit it to .git/objects/).  The
> repository administrator can restrict things further by chmod
> 0770 .git/ as needed.

And then somebody comes along and allows world access by chmod(0775) and 
does not realize that *everybody* can delete packs, objects and what-nots 
in GIT_DIR.

Given the complexity we are talking about, and the needs which are not at 
all that complicated, why not just go with core.umask until somebody 
*needs* core.repositoryumask?

Ciao,
Dscho
