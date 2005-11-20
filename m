From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes
 through
Date: Sun, 20 Nov 2005 02:24:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511200217200.11653@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051117230723.GD26122@nowhere.earth>
 <Pine.LNX.4.63.0511180026080.18775@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051119140404.GD3393@nowhere.earth> <20051119141341.GE3393@nowhere.earth>
 <Pine.LNX.4.63.0511191612350.4895@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051119170929.GF3393@nowhere.earth> <pan.2005.11.19.17.23.17.920228@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 02:26:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eddx2-0001cz-UC
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 02:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbVKTBYz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 20:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbVKTBYz
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 20:24:55 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:65408 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751076AbVKTBYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 20:24:55 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1C06813FFF7; Sun, 20 Nov 2005 02:24:54 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 057679F37A; Sun, 20 Nov 2005 02:24:54 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E73A29CC77; Sun, 20 Nov 2005 02:24:53 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C87E013FFF7; Sun, 20 Nov 2005 02:24:53 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.11.19.17.23.17.920228@smurf.noris.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12362>

Hi,

On Sat, 19 Nov 2005, Matthias Urlichs wrote:

> [...] What can you do with such a thing that you cannot do now, just as 
> easily, besides slow down your programs with an unnecessary level of 
> indirection?

I tend to agree. In fact, if I would like to introduce earlier history 
(for the sake of archeology or whatever), I would import the earlier 
history into git, possibly finding the best match in the current 
development branch (for example, when the original project continued for a 
while to be tracked in CVS), and then make a merge between these two.

Then, I'd merge the new development's HEAD, and it would be fine:

ORIG1 .. ORIG2 .. .. ORIG_HEAD
                         |
                         |   GIT1 .. GIT2 .. .. GIT_HEAD
                         |   /                    /
                         | /                     /
                      UNIFYING_MERGE           /
                                   \         /
                                     \     /
                               NEW_HEAD_FOR_ARCHEOLOGICAL_PURPOSES

Where ORIG_HEAD's tree is identical with GIT1's tree. The resulting branch 
would serve every research purpose I can think of (just be sure not to 
use "-m" with git-whatchanged).

Ciao,
Dscho
