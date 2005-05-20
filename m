From: Ingo Molnar <mingo@elte.hu>
Subject: Re: gitk-1.0 released
Date: Fri, 20 May 2005 13:33:34 +0200
Message-ID: <20050520113334.GA19810@elte.hu>
References: <17036.36624.911071.810357@cargo.ozlabs.ibm.com> <20050519132411.GA29111@elte.hu> <17037.5109.556362.904185@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 13:36:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZ5l4-0002DM-0T
	for gcvg-git@gmane.org; Fri, 20 May 2005 13:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVETLeN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 07:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVETLeN
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 07:34:13 -0400
Received: from mx2.elte.hu ([157.181.151.9]:20926 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261423AbVETLds (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 07:33:48 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 240DE31C856;
	Fri, 20 May 2005 13:31:38 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 11B461FC2; Fri, 20 May 2005 13:33:42 +0200 (CEST)
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
In-Reply-To: <17037.5109.556362.904185@cargo.ozlabs.ibm.com>
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


* Paul Mackerras <paulus@samba.org> wrote:

> > - first window appearance on an uncached repository can be pretty slow 
> >   due to disk seeks - so it might make sense to display something (an 
> >   hourglass?) sooner - when i first started it i thought it hung. On 
> >   already cached repositories the window comes up immediately, and the 
> >   list of commits is updated dynamically.
> 
> The problem is that git-rev-tree HEAD doesn't output anything until it 
> has read all the relevant commits, which can involve a lot of disk 
> seeks.  I put the "Reading commits..." message in to indicate that 
> something was happening, but your hourglass cursor suggestion is a 
> good one.  It looks like git-rev-list might be better suited to what I 
> want, actually.

it was quite a couple of seconds to get the empty windows with the 
'Reading commits...' message. It was this first period of time (5-10 
seconds?) which i mistook for a hang. Perhaps this is some Tk startup 
slowness, not a genuine gitk issue?

> +	if {$nparents($id) > 2} {
> +	    set xt [expr {$xt + ($nparents($id) - 2) * $linespc}]
> +	}

thanks, this fix did the trick.

	Ingo
