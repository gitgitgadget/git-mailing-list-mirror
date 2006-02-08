From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Handling large files with GIT
Date: Wed, 8 Feb 2006 12:54:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602081248270.31700@wbgn013.biozentrum.uni-wuerzburg.de>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 08 12:54:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6nu7-0005lI-RW
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 12:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWBHLy0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 06:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWBHLy0
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 06:54:26 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:51133 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964986AbWBHLyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 06:54:25 -0500
Received: from virusscan.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7428213EEDB; Wed,  8 Feb 2006 12:54:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 627C41280;
	Wed,  8 Feb 2006 12:54:24 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 305B313EEDB; Wed,  8 Feb 2006 12:54:24 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15735>

Hi,

On Wed, 8 Feb 2006, Martin Langhoff wrote:

> Roland Stigge recently pointed out a use case using very large files
> where GIT has some serious limitations.

That is intentional: git handles source code very well, where you tend to 
have small files, and it handles branches very well, where you tend to 
have mostly the same files in different branches.

I am uncertain if it is possible to extend git to handle large files 
gracefully, without slowing it down for its main use case.

[thinking] A potentially silly idea just hit me: We could virtually cut 
every file into 256kB chunks. That would not affect source code at all: 
anybody producing a 256kB C file should be shot anyway.

If the files just keep growing, this should help enormously. If the files 
change subtly, the diff algorithm should work quite well on 'em.

Comments?

Ciao,
Dscho
