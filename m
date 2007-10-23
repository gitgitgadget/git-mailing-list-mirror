From: Scott Parish <sRp@srparish.net>
Subject: Re: [PATCH] don't set-group-id on directories on apple
Date: Mon, 22 Oct 2007 21:30:23 -0700
Message-ID: <20071023043022.GB17089@srparish.net>
References: <20071022075459.GA1157@srparish.net> <Pine.LNX.4.64.0710221234070.25221@racer.site> <20071022142945.GO16291@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 23 06:30:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkBPW-0000Ut-CX
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 06:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbXJWEaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 00:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbXJWEaW
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 00:30:22 -0400
Received: from smtp-gw8.mailanyone.net ([208.70.128.73]:44584 "EHLO
	smtp-gw8.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbXJWEaW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 00:30:22 -0400
Received: from mailanyone.net
	by smtp-gw8.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1IkBPI-00028C-RW; Mon, 22 Oct 2007 23:30:21 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 501
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Mon, 22 Oct 2007 21:30:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071022142945.GO16291@srparish.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62084>

On Mon, Oct 22, 2007 at 07:29:45AM -0700, Scott Parish wrote:

> On Mon, Oct 22, 2007 at 03:16:01PM +0100, Johannes Schindelin wrote:
> 
> > On Mon, 22 Oct 2007, Scott R Parish wrote:
> > 
> > > "git init --shared=all" was failing because chmod was returning EPERM.
> > 
> > Not here. 
> > 
> > Is it possible that you have stricter permission settings?

I finally figured it out. I keep my home directory encrypted, but
its pretty slow (especially compiles) and i don't care who steals
open source code i'm playing with, so i keep that in /Users/Shared.
Since mkdir() on darwin keeps the parents group by default, the
group on my git clone was wheel, which i'm not a member of.

sRp

-- 
Scott Parish
http://srparish.net/
