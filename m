From: Scott Parish <sRp@srparish.net>
Subject: Re: [PATCH] "git help -a" should search all exec_paths and PATH
Date: Sun, 21 Oct 2007 17:54:30 -0700
Message-ID: <20071022005429.GK16291@srparish.net>
References: <20071021214846.GI16291@srparish.net> <Pine.LNX.4.64.0710212323580.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 02:54:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjlZ8-0006sd-1n
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 02:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbXJVAye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 20:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbXJVAye
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 20:54:34 -0400
Received: from smtp-gw51.mailanyone.net ([208.70.128.77]:50440 "EHLO
	smtp-gw51.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbXJVAyd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 20:54:33 -0400
Received: from mailanyone.net
	by smtp-gw51.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1IjlYt-0002zD-Vg; Sun, 21 Oct 2007 19:54:32 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Sun, 21 Oct 2007 17:54:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710212323580.25221@racer.site>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61925>

On Sun, Oct 21, 2007 at 11:25:29PM +0100, Johannes Schindelin wrote:

> > To fix this, help.c is modified to search in all the exec_paths and PATH
> > for potential git commands.
> 
> With this explanation, I would have expected that you add a loop just like 
> in exec-cmd.c.  Not anything more.  And certainly not the removal of a 
> sanity check for the length of the path name.

Well, i took a slightly different approach where that sanity check
wasn't nessisary. Instead of building up a string of the path of
each file, i'm saving the original directory in a file descriptor,
and "cd"ing to the exec_path currently being listed. Because of
that i can just stat() the names returned by readdir. Much simpler
imho

sRp

-- 
Scott Parish
http://srparish.net/
