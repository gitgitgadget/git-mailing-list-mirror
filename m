From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/6] 'git svn info' fixes
Date: Fri, 29 Aug 2008 01:16:54 -0700
Message-ID: <20080829081654.GA6680@yp-box.dyndns.org>
References: <1219779157-31602-1-git-send-email-trast@student.ethz.ch> <20080827095342.GB26475@untitled> <200808281031.04975.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 29 10:18:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYzBC-0002i2-Vv
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 10:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbYH2IQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 04:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbYH2IQ5
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 04:16:57 -0400
Received: from hand.yhbt.net ([66.150.188.102]:58830 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbYH2IQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 04:16:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id B50AA2DC01B;
	Fri, 29 Aug 2008 01:16:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200808281031.04975.trast@student.ethz.ch>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Rast <trast@student.ethz.ch> wrote:
> Eric Wong wrote:
> > Thomas Rast <trast@student.ethz.ch> wrote:
> > > However, the unknown files tests still fail, simply because 'svn info'
> > > itself fails on untracked files.  It would be great if someone who is
> > > still running SVN 1.4 could check whether that has been a bug in
> > > git-svn all along, or is actually a behaviour change on the part of
> > > SVN.
> > 
> > Oops, I upgraded to 1.5.x here already.  I should still have
> > another machine with 1.4 to check on tomorrow, though.
> 
> I got a friend with 1.4 to test this, and it appears the error
> 
>   $ touch new
>   $ svn info new
>   new:  (Keine versionierte Ressource)
> 
> (literally "not a versioned resource") is already present in
> 
>   $ svn --version
>   svn, Version 1.4.6 (r28521)
> 
> (He also says the error is the same if the file does not exist at
> all.)

Interesting.

> So should we just change all "unknown foo" tests to verify that 'git
> svn info' errors out too?

Yes, I see no reason to differ from plain svn here.

-- 
Eric Wong
