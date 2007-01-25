From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Git Subversion problem
Date: Thu, 25 Jan 2007 01:54:30 -0800
Message-ID: <20070125095430.GA24742@localdomain>
References: <Pine.LNX.4.64.0701240935330.3282@blackbox.fnordora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: alan <alan@clueserver.org>
X-From: git-owner@vger.kernel.org Thu Jan 25 10:54:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA1JW-0001GW-5L
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 10:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965748AbXAYJyd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 04:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965747AbXAYJyd
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 04:54:33 -0500
Received: from hand.yhbt.net ([66.150.188.102]:44941 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965748AbXAYJyc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 04:54:32 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id C83677DC094;
	Thu, 25 Jan 2007 01:54:30 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 25 Jan 2007 01:54:30 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701240935330.3282@blackbox.fnordora.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37717>

alan <alan@clueserver.org> wrote:
> I think I tracked down where my problem with using Git to pull subversion 
> repositories came from.
> 
> It seems that if the repository has a file larger than what will fit in 
> memory, it does not react well.  (Yes, I know that you should not check in 
> huge data files into a repository, but accidents happen and Subversion 
> does not make it easy to remove them.)
> 
> I can work around the problem at the moment, but it may be something that 
> the person who maintains that chunk of git may want to look at.

Which version of git-svn are you using?  Can you try git-svn from
version 1.4.4.4 of git and see if that problem can be reproduced?  The
new delta fetching code in the latest git.git master may try to store
the entire file in memory when receiving it over the network.

-- 
Eric Wong
