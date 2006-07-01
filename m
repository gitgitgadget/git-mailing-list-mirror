From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Sat, 1 Jul 2006 20:35:52 +1000
Message-ID: <17574.20488.149073.587594@cargo.ozlabs.ibm.com>
References: <e79921$u0e$1@sea.gmane.org>
	<46a038f90606201233p6283febbn9a46e36c3a666903@mail.gmail.com>
	<e79jtd$51j$1@sea.gmane.org>
	<46a038f90606201417k71c4c43ak59204774bcfe8246@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 12:57:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwdAS-0000QZ-SF
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 12:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWGAK5e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 06:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWGAK5e
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 06:57:34 -0400
Received: from ozlabs.org ([203.10.76.45]:16078 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932474AbWGAK5d (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 06:57:33 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 5B27D67A66; Sat,  1 Jul 2006 20:57:32 +1000 (EST)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606201417k71c4c43ak59204774bcfe8246@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23043>

Martin Langhoff writes:

> > If I remember correctly, it was done in the background, and it was done
> > at least partially _in_ gitk (Tcl/Tk).
> 
> I suspect it is doing a whole lot of git-merge-base invocations, which
> are rather costly. I don't know of any cheaper way to ask that
> question.

There's no git-merge-base involved.  Gitk does a

git-rev-list --all --topo-order --parents

and reads the output of that, and then traverses the entire graph
forwards and backwards (in Tcl).  (This is after gitk has read the
output of git ls-remote $GIT_DIR, so it knows which commits have
tags.)

Paul.
