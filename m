From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: git remote update -> rejected
Date: Tue, 22 Apr 2008 15:41:18 +0300
Message-ID: <20080422124118.GA3098@mithlond.arda.local>
References: <1208857733.4695.37.camel@marge.simson.net> <20080422103458.GA14751@sigio.intra.peff.net> <1208861703.18689.2.camel@marge.simson.net> <20080422111113.GB11238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Galbraith <efault@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 22 14:42:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoHpi-0006T7-94
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 14:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbYDVMmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 08:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753156AbYDVMmA
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 08:42:00 -0400
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:60206 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751944AbYDVMl7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Apr 2008 08:41:59 -0400
Received: from mithlond.arda.local (80.220.180.181) by pne-smtpout3-sn2.hy.skanova.net (7.3.129)
        id 478BDB9600599B44; Tue, 22 Apr 2008 14:41:21 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JoHoE-000253-T0; Tue, 22 Apr 2008 15:41:18 +0300
Content-Disposition: inline
In-Reply-To: <20080422111113.GB11238@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80108>

Jeff King wrote (2008-04-22 07:11 -0400):

> remote: create fetch config lines with '+'
> 
> Since git-remote always uses remote tracking branches, it
> should be safe to always force updates of those branches.
> I.e., we should generate
> 
>   fetch = +refs/heads/*:refs/remotes/$remote/*
> 
> instead of
> 
>   fetch = refs/heads/*:refs/remotes/$remote/*
> 
> This was the behavior of the perl version, which seems to
> have been lost in the C rewrite.

I agree, the "+" should be there. I see remote tracking branches as,
well, branches that track remote repository - no matter what happens
there. Local branches are under user's personal control, so if user
wants to save/keep the information of remote branches he can create
local ones out of them: git branch localcopy $remote/$branch
