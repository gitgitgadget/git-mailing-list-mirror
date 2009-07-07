From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn fetch fails with Temp file with moniker 'svn_delta'
	already in use
Date: Tue, 7 Jul 2009 14:26:08 -0700
Message-ID: <20090707212608.GB31195@dcvr.yhbt.net>
References: <B4BD8C6031F4EC4DAD8EABAB3ABA6CFE024DD4C5@IBCPTEX01.intecbilling.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marcus Griep <marcus@griep.us>
To: Andre Mostert <Andre.Mostert@intecbilling.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 23:26:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOIB5-0006Fn-Ep
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 23:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065AbZGGV0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 17:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755169AbZGGV0K
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 17:26:10 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48862 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756052AbZGGV0J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 17:26:09 -0400
Received: from localhost (unknown [12.186.229.34])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id D15D71F4EA;
	Tue,  7 Jul 2009 21:26:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <B4BD8C6031F4EC4DAD8EABAB3ABA6CFE024DD4C5@IBCPTEX01.intecbilling.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122878>

Andre Mostert <Andre.Mostert@intecbilling.com> wrote:
> Hi 
> 
> I'm getting this error when trying to "git svn fetch":
> 
> Temp file with moniker 'svn_delta' already in use at
> /usr/lib/perl5/site_perl/5.10.0/Git.pm
> 
> I've found some mention of this in the archives, but no conclusive
> fixes or workarounds.
> 
> This is with git 1.6.3.3, perl 5.10.0 and svn 1.5.1

Hi Andre,

Is there a public repository we can test and reproduce this on?

Which OS, C library and architecture?  This might be a memory corruption
issue inside SVN itself.  I think last time we managed to avoid it by
using a different build of SVN or Perl on OSX, but apparently somebody
on Debian hit it in a very odd way too: http://bugs.debian.org/534763

I've never been able to see or reproduce this issue myself, maybe Marcus
can help since he implemented this piece.

-- 
Eric Wong
