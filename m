From: sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH 3/3] fetch: optionally store the current remote
 information in the config
Date: Sun, 30 Apr 2006 13:28:19 -0400
Message-ID: <BAYC1-PASMTP05AA5A3E9CB852B03EAC4DAEB00@CEZ.ICE>
References: <Pine.LNX.4.63.0604301524080.2646@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP08069B2CE6005391A1AFF9AEB00@CEZ.ICE>
	<Pine.LNX.4.63.0604301743370.3641@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP03034CC49FFA3042562BCBAEB00@CEZ.ICE>
	<Pine.LNX.4.63.0604301859280.3977@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 30 19:33:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaFnP-0003HF-S8
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 19:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWD3RdD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 13:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWD3RdB
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 13:33:01 -0400
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:6297 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751209AbWD3Rc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 13:32:57 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 30 Apr 2006 10:32:57 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 51F1A644C28;
	Sun, 30 Apr 2006 13:32:56 -0400 (EDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-Id: <20060430132819.3af8e9d1.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.63.0604301859280.3977@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 30 Apr 2006 17:32:57.0514 (UTC) FILETIME=[1ECD18A0:01C66C7C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 30 Apr 2006 19:09:18 +0200 (CEST)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> > Which head does git-pull then use to merge, all of them?
> 
> The first one.

Which can be confusing since you can only specify one "first one"
in a remotes file (or .git/config)  yet you can pull while 
having any random local branch being checkout out, each with
a different merge branch being appropriate.

> You are right. But you are also wrong. The patch uses
> 
> 	git-repo-config --get remote.$nick.url
> 
> which fails if there are more than one matching line. Note that 
> "--get-all" is used to get _all_ remote.$nick.pull lines...
> 
> But of course, Linus "built git-push in" so that multiple urls are 
> allowed and handled. It is probably confusing, if you can push but 
> cannot fetch with the same remote information... But then, I fail to see 
> how you could possibly specify the refspecs for the different urls.

Yeah, I was speaking only of git push, but see you were speaking of 
fetch.

Anyway, thanks for helping me understand your proposal, it seems
flexible enough to handle just about any case one might want to
throw at it.

Cheers,
Sean
