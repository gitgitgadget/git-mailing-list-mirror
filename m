From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Sun, 20 Nov 2005 20:50:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511202039340.23586@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 20:50:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdvDD-0005Zb-RB
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 20:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVKTTuo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 14:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbVKTTuo
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 14:50:44 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:63183 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932070AbVKTTun (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 14:50:43 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5CEB6140294; Sun, 20 Nov 2005 20:50:42 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 41A9B9F398; Sun, 20 Nov 2005 20:50:42 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2CB8F9F396; Sun, 20 Nov 2005 20:50:42 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CE59B140294; Sun, 20 Nov 2005 20:50:41 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12396>

Hi,

On Sun, 20 Nov 2005, Linus Torvalds wrote:

> 	[branches.origin]
> 		url = master.kernel.org:/pub/scm/git/git.git
> 		pull = master:origin
> 
> 	[branches.mine]
> 		url = my.domain.com:/other/repo
> 		pull = master:mine

I like this approach best. In fact, that was my idea on how to go about 
implementing that feature.

However, 

> 	[branches.origin]
> 		url = master.kernel.org:/pub/scm/git/git.git
> 		pull = master:origin
> 
> 	    [.mine]
> 		url = my.domain.com:/other/repo
> 		pull = master:mine

I don't like this. Usually, data in ini files is not dependent on its 
position in the file, with the notable exception of section names. I never 
ran across nested sections (probably for all the reasons XML is 
unreadable). And the sections should be exchangable, just for clarities 
sake.

> And I'm not 100% convinced that putting these branches in the config file 
> has any real advantages over keeping them as separate files. Having 
> everything in one place is nice, of course, and being able to copy just 
> one file around might be convenient, but it _does_ make the config file 
> more complicated.

And it _does_ make finding the information for less savvy git users more 
easy.

I'm not 100% convinced, either, but it could be a better concept than 
different files in different places and different formats basically doing 
the same.

But my thinking went like this: if Pasky and Junio can not agree on one 
location and format, and therefore none of the two is deprecated, how 
about giving them a way out they both might be able to agree to?

Ciao,
Dscho

P.S.: Anybody noticed that I did not use 0xb4 in five days?
