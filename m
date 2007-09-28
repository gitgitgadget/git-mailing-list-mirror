From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] alloc_ref(): allow for trailing NUL
Date: Fri, 28 Sep 2007 01:03:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709280046241.5926@iabervon.org>
References: <Pine.LNX.4.64.0709280356550.28395@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 28 07:03:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib815-0002kf-0N
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 07:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756216AbXI1FDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 01:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754992AbXI1FDs
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 01:03:48 -0400
Received: from iabervon.org ([66.92.72.58]:60451 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756216AbXI1FDr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 01:03:47 -0400
Received: (qmail 25238 invoked by uid 1000); 28 Sep 2007 05:03:46 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Sep 2007 05:03:46 -0000
In-Reply-To: <Pine.LNX.4.64.0709280356550.28395@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59361>

On Fri, 28 Sep 2007, Johannes Schindelin wrote:

> The parameter name "namelen" suggests that you pass the equivalent of
> strlen() to the function alloc_ref().  However, this function did not
> allocate enough space to put a NUL after the name.
> 
> Since struct ref does not have any member to describe the length of the
> string, this just does not make sense.
> 
> So make space for the NUL.

Good point, but shouldn't you then fix call sites that use strlen(name) + 
1?

	-Daniel
*This .sig left intentionally blank*
