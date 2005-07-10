From: Ingo Molnar <mingo@elte.hu>
Subject: Re: qgit-0.7
Date: Sun, 10 Jul 2005 12:01:06 +0200
Message-ID: <20050710100106.GA18875@elte.hu>
References: <20050709081512.33503.qmail@web26306.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 12:02:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrYcx-00078c-LF
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 12:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVGJKBP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 06:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVGJKBP
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 06:01:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:41661 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261878AbVGJKBO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 06:01:14 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 6112232975A;
	Sun, 10 Jul 2005 12:00:30 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id D80871FC2; Sun, 10 Jul 2005 12:00:57 +0200 (CEST)
To: Marco Costalba <mcostalba@yahoo.it>
Content-Disposition: inline
In-Reply-To: <20050709081512.33503.qmail@web26306.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Marco Costalba <mcostalba@yahoo.it> wrote:

> Here is qgit-0.7, a GUI git viewer.
> 
> you can download from:
> 
> http://prdownloads.sourceforge.net/qgit/qgit-0.7.tar.gz?download
> 
> 
> This time a small changelog, but a lot of work ;-)
> 
> - rewrite of graph drawing
> - start-up loading: switch to use git-rev-list --topo-order
> - final fixes to annotation
> - cache of file lists to speed-up loading of file names
> - added color background on heads

the good news: it's really fast now and very usable for browsing 
changes.  Kudos!

the bad news: except for annotations. I started qgit in the current 
kernel GIT repository, and clicked on the following commit:

  5bbcfd9000887c0da7d57cc7b3ac869fc0dd5aa9

then i clicked on sched.c to see the annotated file. Firstly, it took 
roughly 2 minutes (!) for the annotated sched.c to show up. All the qgit 
windows were fully frozen during that time, no refreshes or anything.  
My kernel tree was fully cached in RAM, so it was pure CPU overhead 
(qgit was taking 99% of CPU time). It is clearly not usable in this 
form.

then the annotations were plain wrong. Almost all lines are attributed 
to Tony Luck, while much of the file comes from the initial repository.  
So something's quite fishy here. Also, a number of lines were attributed 
to 'merge', which isnt very informative.

	Ingo
