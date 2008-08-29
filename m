From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Feature request: git-svn dcommit should send deltas upstream
Date: Fri, 29 Aug 2008 01:23:11 -0700
Message-ID: <20080829082311.GA7128@yp-box.dyndns.org>
References: <87myj0f3mb.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Fri Aug 29 10:24:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYzHW-0004Qu-DT
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 10:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053AbYH2IXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 04:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753844AbYH2IXP
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 04:23:15 -0400
Received: from hand.yhbt.net ([66.150.188.102]:58841 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755831AbYH2IXM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 04:23:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 342312DC01B;
	Fri, 29 Aug 2008 01:23:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87myj0f3mb.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Florian Weimer <fw@deneb.enyo.de> wrote:
> Looking at my network traffic and the Perl code, it seems to me that
> git-svn fails to create a diff (delta) before sending data to the
> server.  As a result, a few changes in a multi-megabyte file lead to a
> large upload (similar to the situation with CVS).  git-svn should be
> able to compute this diff in all cases because it has got an up-to-date
> copy of the current revision in the Subversion repository.
> 
> As far as I can tell, this can't be fixed with a one-liner; some handles
> need to be passed down to the code that actually handles the upload.

Odd.  Can you verify that svn(1) does not send full files in this case,
too?

It's been too long since I've looked at the SVN TxDelta API, but I
thought SVN::TxDelta::apply would take care of the delta computation for
us...

-- 
Eric Wong
