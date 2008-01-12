From: Jeff King <peff@peff.net>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file
	descriptor
Date: Fri, 11 Jan 2008 23:56:37 -0500
Message-ID: <20080112045637.GC5211@coredump.intra.peff.net>
References: <4787E981.7010200@nrlssc.navy.mil> <4787EB38.7010600@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>, drafnel@gmail.com
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 05:57:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDYQj-00039s-86
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 05:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756023AbYALE4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 23:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756682AbYALE4p
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 23:56:45 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4961 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755757AbYALE4o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 23:56:44 -0500
Received: (qmail 3994 invoked by uid 111); 12 Jan 2008 04:56:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 11 Jan 2008 23:56:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jan 2008 23:56:37 -0500
Content-Disposition: inline
In-Reply-To: <4787EB38.7010600@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70261>

On Fri, Jan 11, 2008 at 10:18:32PM +0000, Charles Bailey wrote:

> I have seen this exact type of failure (commit reports possible oom, but 
> commit appears to have succeeded) with most recent gits.

This is almost certainly caused not by the commit action itself (which
uses very little memory) but by the resulting diffstat to show what
happened. So the commit has already been "committed" to disk by the time
it crashes.

This is at least the case with Brandon's problem (his stack trace shows
the diff happening).

-Peff
