From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH] Don't fetch objects that exist in the local repository
Date: Fri, 7 Oct 2005 16:08:56 -0700
Message-ID: <20051007230856.GC4989@reactrix.com>
References: <20051007220151.GB4989@reactrix.com> <Pine.LNX.4.63.0510080047500.20922@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 01:10:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EO1L5-0001jY-Py
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 01:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbVJGXJH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 19:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbVJGXJH
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 19:09:07 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:50369 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750967AbVJGXJG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2005 19:09:06 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j97N8uLR017610;
	Fri, 7 Oct 2005 16:08:56 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j97N8uDC017608;
	Fri, 7 Oct 2005 16:08:56 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0510080047500.20922@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9825>

On Sat, Oct 08, 2005 at 12:50:53AM +0200, Johannes Schindelin wrote:

> > Be sure not to fetch objects that already exist in the local repository.
> 
> Really? I seem to recall a dispute I had with Linus that this is 
> unacceptable. He seems worried about incomplete fetches.

This patch just moved an existing check from the process queue loop to the
appropriate places in transport-specific code to prevent the transport
from transferring an object that appeared in the local repository after
it was prefetched (eg. via a pack), and to make sure that all objects that
were prefetched are subsequently fetched so the transport can perform the
appropriate cleanup.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
