From: Jeff King <peff@peff.net>
Subject: Re: teach git diff -v/--invert-match?
Date: Fri, 22 Aug 2008 15:39:47 -0400
Message-ID: <20080822193947.GA31322@coredump.intra.peff.net>
References: <48AED264.60600@visi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Ericson <bme@visi.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 21:41:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWcVE-0006V5-Tg
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 21:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbYHVTjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 15:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753963AbYHVTjv
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 15:39:51 -0400
Received: from peff.net ([208.65.91.99]:2261 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752007AbYHVTjt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 15:39:49 -0400
Received: (qmail 24299 invoked by uid 111); 22 Aug 2008 19:39:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 22 Aug 2008 15:39:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Aug 2008 15:39:47 -0400
Content-Disposition: inline
In-Reply-To: <48AED264.60600@visi.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93349>

On Fri, Aug 22, 2008 at 09:51:16AM -0500, Brian Ericson wrote:

> I'm wondering what it would take to teach git diff to invert the -S  
> string (like git grep).

I think you would have to figure out the desired semantics first.

> I'm finding git diff -S<string> [--pickaxe-regex] to be really useful,  
> but find I have cases where I want to ignore differences.  For example, I 
> might not care if the only changes to a Java file, for example, are  
> related to import statements.  I'd like to be able to do something like  
> "git diff -S'^import' --pickaxe-regex -v".  I'll admit I can get by with  
> something like "git diff -S'^[^i]' --pickaxe-regex", but am pining for  
> -v/--invert-match.

I would have thought "-v" meant "match any changes which do not have
this pattern". But you want "match any changes that have any line which
does not have this pattern."

IOW, mine would not match any changes which used an import statement,
whereas yours would not match any changes which are _only_ import
statements.

-Peff
