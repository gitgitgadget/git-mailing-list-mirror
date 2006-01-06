From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: use GIT_DIR instead of /var/tmp
Date: Fri, 6 Jan 2006 11:00:48 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601061057470.19735@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0601050352n386505bfjd40e515809e3c862@mail.gmail.com>
 <Pine.LNX.4.64.0601050840010.3169@g5.osdl.org> <Pine.LNX.4.63.0601051048490.667@gheavc.wnzcbav.cig>
 <20060106093213.GA4268@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 06 11:01:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuoP2-0005He-0G
	for gcvg-git@gmane.org; Fri, 06 Jan 2006 11:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWAFKAw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 05:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752261AbWAFKAw
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 05:00:52 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:49353 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1752155AbWAFKAv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2006 05:00:51 -0500
Received: from amavis.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.46])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 546DCE3E3A; Fri,  6 Jan 2006 11:00:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id 44B699A5;
	Fri,  6 Jan 2006 11:00:48 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id 283B69B;
	Fri,  6 Jan 2006 11:00:48 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 056FD13FC87; Fri,  6 Jan 2006 11:00:48 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060106093213.GA4268@steel.home>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14212>

Hi,

On Fri, 6 Jan 2006, Alex Riesen wrote:

> Jon Nelson, Thu, Jan 05, 2006 17:49:36 +0100:
> > Do you still need write access to $GIT_DIR if $GIT_INDEX_FILE is set to 
> > some place outside of $GIT_DIR?
> 
> yes, $GIT_DIR/refs/heads/ref-pointed-by-HEAD is updated by git-reset.

In a strict sense, this means write access to $GIT_DIR/refs/heads/. In a 
shared setup, I have repositories where all developers are allowed to 
write to that folder, but only the repo maintainer (yours truly) is 
allowed to write to $GIT_DIR (which effectively means: nobody can write 
an index).

Maybe the safe method would be to introduce $GIT_TMP_DIR, with "/tmp/" 
being the default?

Ciao,
Dscho
